## ====================================================================
## File: $sps/include/Makefile.local.mk
##

#include $(modelutils)/include/Makefile.local.mk
#include $(rpnphy)/include/Makefile.local.mk

maindm  = $(ABSPREFIX)sps$(ABSPOSTFIX)_$(BASE_ARCH).Abs

MONBINDIR = $(PWD)
BINDIR    = $(MONBINDIR)

SPSLIBS     = sps $(MODELUTILSLIBS) sps
PHY         = $(PHYLIBS)
CHMLIBPATH  = 
CHM         = $(CHM_VERSION) $(CHMLIBS)
PROF          = prof_003
PROFLIBPATH   =
#CPL         = cpl_stubs
#CPLLIBPATH = /users/dor/armn/mod/cpl/v_$(CPL_VERSION)/lib/$(EC_ARCH)

LIBPATHPOST  = $(CHMLIBPATH)/lib/$(EC_ARCH) $(CHMLIBPATH)/$(EC_ARCH) $(CHMLIBPATH) $(CPLLIBPATH)/lib/$(EC_ARCH) $(CPLLIBPATH) $(PROFLIBPATH)
LIBS_PRE = $(SPSLIBS) $(PHY) $(CLASSLIBS) $(CHM) $(PATCH) $(CPL)

.PHONY: sps allbin_sps allbincheck_sps

allbin_sps: $(BINDIR)/$(maindm)  sps_yyencode
	ls -l $(BINDIR)/$(maindm) $(BINDIR)/sps_yyencode.Abs
allbincheck_sps:
	if [[ \
		   -f $(BINDIR)/$(maindm) && \
			-f $(BINDIR)/sps_yyencode.Abs \
		]] ; then \
		exit 0 ;\
	fi ;\
	exit 1

$(BINDIR)/$(maindm): sps
	if [[ -r $(maindm) ]] ; then cp $(maindm) $@ 2>/dev/null ; fi
sps:
	export ATM_MODEL_NAME="SPS" ; $(RBUILD2Oa) ;\
	if [[ x$(BINDIR) == x ]] ; then \
		cp $@.Abs $(PWD)/$(maindm) ;\
		chmod u+x $(PWD)/$(maindm) ;\
		ls -lL $(PWD)/$(maindm) ;\
	else \
		cp $@.Abs $(BINDIR)/$(maindm) ;\
		chmod u+x $(BINDIR)/$(maindm) ;\
		ls -lL $(BINDIR)/$(maindm) ;\
	fi ; set +x ;\
	echo DYN_VERSION   = $(ATM_DYN_VERSION);\
	echo PHY_VERSION   = $(ATM_PHY_VERSION);\
	echo CHM_VERSION   = $(CHM_VERSION);\
	echo CPL_VERSION   = $(CPL_VERSION);\
	echo "VGRID_VERSION = $(VGRID_VERSION) default:$(VGRID_VERSION_)";\
	echo RMN_VERSION   = $(RMN_VERSION);\
	echo COMM_VERSION  = $(COMM_VERSION)

sps_yyencode:
	$(RBUILD2ONOMPI)
	ls -l $(BINDIR)/sps_yyencode.Abs

.PHONY: libsps
libsps: rmpo $(OBJECTS)

## ====================================================================
