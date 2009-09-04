#!/usr/env python

import sys
from PyQt4 import QtCore, QtGui

class Systray(QtGui.QWidget):
    def __init__(self):
        QtGui.QWidget.__init__(self)
        self.createActions()
        self.createTrayIcon()
        self.trayIcon.show()

    def createActions(self):
        self.quitAction = QtGui.QAction(self.tr("&Quit"), self)
        QtCore.QObject.connect(self.quitAction, QtCore.SIGNAL("triggered()"),
                               QtGui.qApp, QtCore.SLOT("quit()"))

    def createTrayIcon(self):
        self.trayIconMenu = QtGui.QMenu(self)
        self.trayIconMenu.addAction(self.quitAction)
        self.trayIcon = QtGui.QSystemTrayIcon(self)
        self.trayIcon.setContextMenu(self.trayIconMenu)
        self.trayIcon.setIcon(QtGui.QIcon("teste.png"))

app = QtGui.QApplication(sys.argv)
x = Systray()
sys.exit(app.exec_())
