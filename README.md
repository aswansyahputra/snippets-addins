# RStudio Snippets dan Addins

[![Binder](http://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/aswansyahputra/snippets-addins/master?urlpath=rstudio)

## Membuat snippets

* Buka daftar snippet di Tools - Global Options - Code - Edit snippets
* Tambahkan konten dengan format

```
snippet nama_snippet
  kode/skrip dengan field menggunakan format ${1:field1}, ${2:field2}, dst
```

* Sebagai contoh masukan snippet berikut ke dalam daftar snippets!

```
snippet gg1
	ggplot(data = ${1:data}, aes(x = ${2:x}, y = ${3:y})) +
	geom_${4:geom}()
```

dan 

```
snippet sdb
	library(shiny)
	library(shinydashboard)
	
	ui <- dashboardPage(
		dashboardHeader(title = "${1:title}"),
		dashboardSidebar(
			sidebarMenu(
				menuItem(
					"${2:menu_label}",
					tabName = "${3:tabName}"
				)
			)
		),
		dashboardBody(
			tabItems(
				tabItem(
					tabName = "${3:tabName}"
				)
			)
		)
	)
	
	server <- function(input, output, session) {
	
	}
	
	shinyApp(ui, server)
```

## Membuat addins

* Buat direktori inst/rstudio
* Buat berkas `addins.dcf` dan simpan ke dalam direktori inst/rstudio (File - New File - Text File)
* Dalam berkas `addins.dcf` isi konten dengan format:

```
Name: nama addins
Description: deskripsi addins
Binding: nama fungsi dari berkas addins.R di direktori R
Interactive: false/true (true jika menggunakan shinygadget)
```

* Jalankan `devtools::document()`, `devtools::check()`, kemudian `devtools::install()`
* Mulai ulang sesi R (Session - Restart R)
