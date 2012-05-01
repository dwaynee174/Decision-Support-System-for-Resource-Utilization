Imports System.Windows.Forms

Public Class MDIParent1

    Private Sub SubjectToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SubjectToolStripMenuItem.Click
        frmSubject.ShowDialog()
    End Sub

    Private Sub SemesterToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SemesterToolStripMenuItem.Click
        frmSemester.ShowDialog()
    End Sub

    Private Sub FacultyToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FacultyToolStripMenuItem.Click
        frmFaculty.ShowDialog()
    End Sub

    Private Sub FacultySubjectMappingToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FacultySubjectMappingToolStripMenuItem.Click
        frmFacultySubjectMapping.ShowDialog()
    End Sub

    Private Sub ExitToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitToolStripMenuItem.Click
        frmTi_eTable.ShowDialog()
    End Sub

    Private Sub ExitToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitToolStripMenuItem1.Click
        End
    End Sub

    Private Sub MDIParent1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If loginwithfaculty Then
            ExitToolStripMenuItem.Enabled = True
        End If
    End Sub
End Class
