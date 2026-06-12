allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// 1. Namespace matrum Compile SDK prachanaiyai force-fix pannum block
subprojects {
    plugins.withType<com.android.build.gradle.BasePlugin> {
        val androidExtension = extensions.findByName("android")
        if (androidExtension != null) {
            try {
                // Namespace fix
                val getNamespace = androidExtension.javaClass.getMethod("getNamespace")
                val currentNamespace = getNamespace.invoke(androidExtension)
                if (currentNamespace == null) {
                    val setNamespace = androidExtension.javaClass.getMethod("setNamespace", String::class.java)
                    setNamespace.invoke(androidExtension, project.group.toString())
                }

                // Compile SDK 34 fix
                val setCompileSdkVersion = androidExtension.javaClass.getMethod("setCompileSdkVersion", Int::class.javaPrimitiveType)
                setCompileSdkVersion.invoke(androidExtension, 34)
                
            } catch (e: Exception) {
                // Method illana ignore aagum
            }
        }
    }
}

// 2. Flutter App Badger-oda Manifest package attribute collision-ah automatic-ah clean pannum block
gradle.projectsEvaluated {
    val badgerProject = subprojects.find { it.name == "flutter_app_badger" }
    badgerProject?.tasks?.any { it.name.contains("Manifest") }?.let {
        badgerProject.tasks.forEach { task ->
            if (task.name.contains("Manifest")) {
                task.doFirst {
                    val manifestFile = file("${badgerProject.projectDir}/src/main/AndroidManifest.xml")
                    if (manifestFile.exists()) {
                        var content = manifestFile.readText()
                        if (content.contains("package=")) {
                            // Manifest-la irukra package="xxx" attribute-ah auto-ah thukkidum
                            content = content.replace(Regex("""package="[^"]*""""), "")
                            manifestFile.writeText(content)
                        }
                    }
                }
            }
        }
    }
}