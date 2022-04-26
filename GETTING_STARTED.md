# Getting started with ERDDAP

For local development, you will want to use Docker, as a Docker container will contain all the necessary setup for ERDDAP that would be a pain to develop a cross-platform guide for.




- Local development (requirements, spinup, etc.)
  - Windows
  - Linux
- On-premises development
- Working on the datasets.xml file (MD file)
  - generateDatasetsXML[.sh, .bat]
  - dasdds[.sh, .bat]
  - Fewer iterations per concise guidance (compared with "900-950")
  - Spatial data: what's the difference in markup
  - Ownership
  - Snippetize datasets.xml ([Jinja](https://jinja.palletsprojects.com/en/3.1.x/), other tools?)  
- Docker (MD file)
  - GitHub actions?
  - persistence of datasets.xml 
- Kubernetes and setup of a YAML file for that (MD file)
  - persistence of datasets.xml
- Tools for easing data integration into ERDDAP
- Make this all less vague, no more jazz hands


Goals:

- Work with the Gold Standard guide
- But also tear it out of its Docker context
- Encapulate details in proper sections of documentation
  - see those lines above with "(MD file)" by them
- local -> try out dataset -> times 999 -> deploy
