Imports System.Data.SqlClient
Public Class frmTi_eTable
    Dim currentRow As Long
    Private bsource As BindingSource = New BindingSource()
    Private Sub frmTi_eTable_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call FillCombo(cmbSemester, "Select 0 as SemesterID, '' as SemesterName union Select SemesterID, SemesterName from TTM_Semester order by semesterid", enumComboFill.CF_SEMESTER, enumComboFillType.CFT_BOUNDCODE)

    End Sub

    Private Sub cmbSemester_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbSemester.Validated
        Dim isfacultyavailable As Boolean
        objDataAdapter = New SqlDataAdapter
        objDataAdapter.SelectCommand = New SqlCommand
        objDataAdapter.SelectCommand.Connection = objcnn
        objDataAdapter.SelectCommand.CommandText = "checkfacultyallocation"
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@semesterid", cmbSemester.SelectedValue)
        objDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure
        objDataSet = New DataSet()
        objDataAdapter.Fill(objDataSet, "checkfacultyallocation")
        currentRow = 0
        isfacultyavailable = objDataSet.Tables("checkfacultyallocation").Rows(currentRow)("isexits").ToString()
        If isfacultyavailable Then
            objDataSet = New DataSet
            objDataAdapter = New SqlDataAdapter("ttm_generateTimetable", objcnn)
            objDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure
            objDataAdapter.SelectCommand.Parameters.AddWithValue("@SemesterID", IIf(cmbSemester.SelectedValue = Nothing, 1, cmbSemester.SelectedValue))
            Dim commandBuilder As SqlCommandBuilder = New SqlCommandBuilder(objDataAdapter)
            objDataAdapter.Fill(objDataSet, "ttm_generateTimetable")
            bsource.DataSource = objDataSet.Tables("ttm_generateTimetable")
            dataGrTimeTable.DataSource = bsource
            'dataGrTimeTable.DataSource = objDataSet
            'dataGrTimeTable.Rows.Clear()
            'dataGrTimeTable.DataMember = "ttm_generateTimetable"
            'dataGrTimeTable.Refresh()
            'dataGrTimeTable.Column = objDataSet.Tables("ttm_generateTimetable").Columns
            'dataGrTimeTable.Show()
        Else
            dataGrTimeTable.DataSource = ""
            MsgBox("Faculty mapping pending.", MsgBoxStyle.Information, "Login")
        End If
        '
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Report.Click

    End Sub
End Class