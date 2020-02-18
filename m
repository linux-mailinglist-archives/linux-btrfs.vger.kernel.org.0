Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F351162961
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgBRP1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 10:27:15 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38463 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgBRP1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 10:27:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id g6so9316308qvy.5
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2020 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qO1MAHUsz/XGo3/d7jph1BijIhee9edW9+K6IMqVfWE=;
        b=QNDkuz2GgQkitM0JLDhhJrIxet6qN/ieBu2pDHMBwZqH7MnzChaYC58hl6LuUzN4xj
         ByB1m3CoZThOkUJhhFmcR1XXXWXzE2afInlBgZJBEgNQZiArCZg6GovU6DoZw7Nt5GTn
         eYWTfVRhp/6zUMgtayfrlSOh7g4BvV7qrkdMOqvrLqzRmdp0XgkvSs6oeF/foyi7sZ68
         96bwco29b0mdfgAAtK0J2UVCYxxTdbyKRcrKzkc20W7LldTaYgHKCieKq2+G2WeXOV56
         JPQ3mp61bGeZQPdV0WVfiaGTmwSbYy+fOdYtdOa95K/OocLjSTvrsIoO7cgeMGa51oz6
         SNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qO1MAHUsz/XGo3/d7jph1BijIhee9edW9+K6IMqVfWE=;
        b=iaQv+jUgIgr3r3Iw1igA+1t6wsdYPCgDv2/DBk240N5iB/O3R2g1wZnPyXfn1QmjI0
         TJLkb+tYOlSsPAeICEvhZpm01JN67GwhCaW8yYHSACQrCt6QUdSTxq0VXDowQOLb3lF0
         B89ySezrHjP1JHpo6OTbAWYUMzX6RPdPdMMOXkAKtVzTFhTvcGJvXKtEHwL86cNkHF87
         TljJlKQ+adGEIBfDac+wTGQkZSHrXrFQpxeeqilY+NWSCLypwTRYZUJUKCXzteTSuM+K
         qSjkhG3BBalG1ZQwGG8kkaz2NO7wu7j0ofOAZdvbMh9dFswMRG6NLesizh0IOY1tmZNg
         Pe+g==
X-Gm-Message-State: APjAAAX77gHmqNQ5e4KiiwCRjbou1F92vu34lbLochdDHBIdYQ6ViXNr
        Q7+YJ6zdHc6ixE4JxgCdvFpJSg==
X-Google-Smtp-Source: APXvYqz1OUTLpisKH8559ZUPrlu2JMpvjFeWahWs7kBmMEh09+bZvV9B9INReAxOIeTunaSaRofsLw==
X-Received: by 2002:ad4:57c7:: with SMTP id y7mr16449884qvx.174.1582039634114;
        Tue, 18 Feb 2020 07:27:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n4sm1948752qti.55.2020.02.18.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 07:27:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH][v2] xfstests: add a option to run xfstests under a cgroup
Date:   Tue, 18 Feb 2020 10:27:12 -0500
Message-Id: <20200218152712.3750130-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I want to add some extended statistic gathering for xfstests, but it's
tricky to isolate xfstests from the rest of the host applications.  The
most straightforward way to do this is to run every test inside of it's
own cgroup.  From there we can monitor the activity of tasks in the
specific cgroup using BPF.

The support for this is pretty simple, allow users to pass -C <cgroup
name>.  We will create the path if it doesn't already exist, and
validate we can add things to cgroup.procs.  If we cannot it'll be
disabled, otherwise we will use this when we do _run_seq by echo'ing the
bash pid into cgroup.procs, which will cause any children to run under
that cgroup.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Changed it from a local.config option to a command line option.
- Export CGROUP2_PATH for everything, utilize that path when generating our
  cgroup for the scripts to run in.

 check          | 24 +++++++++++++++++++++++-
 common/cgroup2 |  2 --
 common/config  |  1 +
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/check b/check
index 2e148e57..df33628e 100755
--- a/check
+++ b/check
@@ -72,6 +72,7 @@ check options
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
+    -C cgroup_name	run all the tests in the specified cgroup name
 
 testlist options
     -g group[,group...]	include tests from these groups
@@ -101,6 +102,10 @@ excluded from the list of tests to run from that test dir.
 external_file argument is a path to a single file containing a list of tests
 to exclude in the form of <test dir>/<test name>.
 
+cgroup_name is just a plain name, or a path relative to the root cgroup path.
+If CGROUP2_PATH does not point at where cgroup2 is mounted then adjust it
+accordingly.
+
 examples:
  check xfs/001
  check -g quick
@@ -307,6 +312,7 @@ while [ $# -gt 0 ]; do
 		;;
 	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
 	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
+	-C)	CGROUP=$2 ; shift ;;
 
 	-*)	usage ;;
 	*)	# not an argument, we've got tests now.
@@ -509,11 +515,24 @@ _expunge_test()
 OOM_SCORE_ADJ="/proc/self/oom_score_adj"
 test -w ${OOM_SCORE_ADJ} && echo -1000 > ${OOM_SCORE_ADJ}
 
+# Initialize the cgroup path if it doesn't already exist
+if [ ! -z "$CGROUP" ]; then
+	CGROUP=${CGROUP2_PATH}/${CGROUP}
+	mkdir -p ${CGROUP}
+
+	# If we can't write to cgroup.procs then unset cgroup
+	test -w ${CGROUP}/cgroup.procs || unset CGROUP
+fi
+
 # ...and make the tests themselves somewhat more attractive to it, so that if
 # the system runs out of memory it'll be the test that gets killed and not the
 # test framework.
 _run_seq() {
-	bash -c "test -w ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq"
+	_extra="test -w ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ};"
+	if [ ! -z "$CGROUP" ]; then
+		_extra+="echo $$ > ${CGROUP}/cgroup.procs;"
+	fi
+	bash -c "${_extra} exec ./$seq"
 }
 
 _detect_kmemleak
@@ -615,6 +634,9 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
 	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
 	fi
+	if [ ! -z "$CGROUP" ]; then
+	  echo "CGROUP        -- ${CGROUP}"
+	fi
 	echo
 	needwrap=true
 
diff --git a/common/cgroup2 b/common/cgroup2
index 8833c9c8..554bd238 100644
--- a/common/cgroup2
+++ b/common/cgroup2
@@ -1,7 +1,5 @@
 # cgroup2 specific common functions
 
-export CGROUP2_PATH="${CGROUP2_PATH:-/sys/fs/cgroup}"
-
 _require_cgroup2()
 {
 	if [ `findmnt -d backward -n -o FSTYPE -f ${CGROUP2_PATH}` != "cgroup2" ]; then
diff --git a/common/config b/common/config
index 9a9c7760..0eaf35c3 100644
--- a/common/config
+++ b/common/config
@@ -259,6 +259,7 @@ case "$HOSTOS" in
 	export E2FSCK_PROG=$(type -P e2fsck)
 	export TUNE2FS_PROG=$(type -P tune2fs)
 	export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
+	export CGROUP2_PATH="${CGROUP2_PATH:-/sys/fs/cgroup}"
         ;;
 esac
 
-- 
2.24.1

