class Thorax.Views.MeasureHistoryTimelineView extends Thorax.Views.BonnieView
  template: JST['measure_history_timeline']
  
  initialize: ->
    @populationIndex = @model.get('displayedPopulation').index()
    #$.get('/measures/history?id='+@model.attributes['hqmf_set_id'], @loadHistory)
    @measureDiffView = new Thorax.Views.MeasureHistoryDiffView(model: @model)
    @loadHistory()
    
  events:
    'click .history-circle': 'patientCircleClicked'
    
  loadHistory: =>
    @patientIndex = [];
    
    # pull out all patients that exist, even deleted ones, map id to names
    @upload_summaries.each (upload_summary) =>
      for population in upload_summary.get('measure_upload_population_summaries')
        for patientId, patient of population.patients
          if _.findWhere(@patientIndex, {id: patientId}) == undefined
            patient = @patients.findWhere({_id: patientId})
            if patient
              @patientIndex.push {
                id: patientId
                name: "#{patient.get('first')} #{patient.get('last')}"
                patient: patient
              }
            # else
            #   @patientIndex.push {
            #     id: patientId
            #     name: "Deleted Patient"
            #     patient: patient
            #   }
    return
    
  updatePopulation: (population) ->
    @populationIndex = population.index()
    @render()
    
  showDiffClicked: (e) ->
    uploadID = $(e.target).data('uploadId')
    upload = @upload_summaries.findWhere({_id: uploadID})
    @measureDiffView.loadDiff upload.get('measure_db_id_before'), upload.get('measure_db_id_after')
    @$('#measure-diff-view-dialog').modal('show');
    
  patientCircleClicked: (e) ->
    circleDiv = $(e.target).parent('.history-circle')
    uploadId = circleDiv.data('uploadId');
    patientId = circleDiv.data('patientId');

    patient = @patients.findWhere({_id: patientId});
    
    if uploadId != "current"
      upload_summary = @upload_summaries.findWhere({_id: uploadId});
      bonnie.navigate "measures/#{@model.get('hqmf_set_id')}/patients/#{patientId}/compare/at_upload/#{uploadId}", trigger: true
    else
      bonnie.navigate "measures/#{@model.get('hqmf_set_id')}/patients/#{patientId}/compare", trigger: true
