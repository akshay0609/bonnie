###
These templates will be evaluated as they are called
in our view functions.
###

###
Provides a generic date field
###
JST['pd_date_field'] = Handlebars.compile '
  <input type="text" id="" name="{{key}}{{rowIndex}}" class="date-picker form-control input-sm" title="month/day/year" data-date-format="mm/dd/yyyy" data-date-keyboard-navigation="false" data-date-autoclose="true">'

###
Provides a generic input field
###
JST['pd_input_field'] = Handlebars.compile '
  <input class="form-control input-sm" type="text" name="{{key}}{{rowIndex}}">'

###
Gender select menu for editing patients.
###
JST['pd_edit_gender'] = Handlebars.compile '
  <select name="gender{{rowIndex}}" class="form-control input-sm">
    <option value="M" {{#unless femaleSelected}}selected{{/unless}}>Male</option>
    <option value="F" {{#if femaleSelected}}selected{{/if}}>Female</option>
  </select>'

###
Save and cancel buttons bit editing patients.
###
JST['pd_edit_controls'] = Handlebars.compile '
  <button class="btn btn-sm btn-success" data-call-method="saveEdits">
    <i aria-hidden="true" class="fa fa-fw fa-check"></i>
    <span class="sr-only">Save patient edits</span>
  </button>
  <button class="btn btn-sm btn-danger" data-call-method="cancelEdits">
    <i aria-hidden="true" class="fa fa-fw fa-close"></i>
    <span class="sr-only">Cancel patient edits</span>
  </button>'

###
Delete and cancel buttons for deleting patients.
###
JST['pd_delete_controls'] = Handlebars.compile '
  <button class="btn btn-sm btn-danger" data-call-method="hideDelete">
    <i aria-hidden="true" class="fa fa-minus-circle"></i>
    <span class="sr-only">Hide Delete</span>
  </button>
  <button class="btn btn-sm btn-danger" data-call-method="deletePatient">
    <i aria-hidden="true" class="fa fa-fw fa-close"></i>
    Delete
    <span class="sr-only">Delete Patient</span>
  </button>'

###
Takes a result (0 or 1) and displays it as a checked/unchecked box.
TODO: Take into account results other than 0 and 1.
###
JST['pd_result_checkbox'] = Handlebars.compile '<div>
    {{#if result}}
      <span class="sr-only">Meets this population.</span>
      <i class="fa fa-check-square-o default" aria-hidden="true"></i>
    {{else}}
      <span class="sr-only">Does not meet this population.</span>
      <i class="fa fa-square-o default" aria-hidden="true"></i>
    {{/if}}
  </div>'

###
Renders pass/fail text.
###
JST['pd_result_text'] = Handlebars.compile '<div
  class="patient-status status status-{{#if passes}}pass{{else}}fail{{/if}}">
    {{#if passes}}pass{{else}}fail{{/if}}
  </div>'

###
When clicked, shows or hides buttons to perform actions on a row
###
JST['pd_action_gears'] = Handlebars.compile '<span class="pd-settings-container">
    <a href="" class="btn btn-settings" data-call-method="expandActions">
      <i class="fa fa-cog" aria-hidden="true"></i>
      <span class="sr-only">Patient Actions</span>
    </a>
    <div class="pd-settings">
      <button class="btn btn-sm btn-primary" data-call-method="makeInlineEditable">
        <i aria-hidden="true" class="fa fa-fw fa-pencil"></i>
        Edit
      </button>
      <button class="btn btn-sm btn-primary" data-call-method="openEditDialog">
        <i aria-hidden="true" class="fa fa-fw fa-square-o"></i>
        Open
      </button>
      <button class="btn btn-sm btn-danger-inverse" data-call-method="showDelete">
        <i class="fa fa-minus-circle" aria-hidden="true"></i> <span class="sr-only">Show Delete</span>
      </button>
    </div>
  </span>'

###
Displays individual results.
###
JST['pd_result_detail'] = Handlebars.compile '
  {{#if passes}}
    <div class="pull-left text-success">
      {{#if specifically}}
        <i aria-hidden="true" class="fa fa-fw fa-asterisk"></i> SPECIFICALLY TRUE
      {{else}}
        <i aria-hidden="true" class="fa fa-fw fa-check-circle"></i> TRUE
      {{/if}}
    </div>
  {{else}}
    <div class="pull-left text-danger">
      {{#if specifically}}
        <i aria-hidden="true" class="fa fa-fw fa-asterisk"></i> SPECIFICALLY FALSE
      {{else}}
        <i aria-hidden="true" class="fa fa-fw fa-times"></i> FALSE
      {{/if}}
    </div>
  {{/if}}'

###
Displays results with a popover. Popover content and result are HTML blobs.
###
JST['pd_result_with_popover'] = Handlebars.compile '
  {{{result}}}
  {{#if content}}
    <a
      tabindex="0"
      class="btn btn-default btn-xs trigger-criteria"
      data-container="body"
      data-toggle="popover"
      data-trigger="focus"
      data-placement="bottom"
      data-call-method="populatePopover"
      data-html=true
      patientId={{patientId}}
      columnNumber={{columnNumber}}
      data-title="Children Criteria">
      details
    </a>
  {{/if}}'

###
Displays children criteria
###
JST['pd_criteria_list'] = Handlebars.compile '
  {{#if criteria}}
      <ul class="fa-ul children-criteria">
        {{#each criteria}}
          <li class="{{#if passes}}bg-success text-success{{else}}bg-danger text-danger{{/if}}">
          <i class="fa-li fa
            {{#if passes}}
              fa-check-circle
            {{else}}
              {{#if specifically}}fa-asterisk{{else}}fa-times{{/if}}
            {{/if}}"></i>
            {{text}}
          </li>
        {{/each}}
      </ul>
  {{else}}
    No Children Data Criteria
  {{/if}}'
