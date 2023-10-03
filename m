Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B8C7B6868
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 13:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbjJCL6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 07:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbjJCL6F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 07:58:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43819B7;
        Tue,  3 Oct 2023 04:58:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0576C433C8;
        Tue,  3 Oct 2023 11:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696334280;
        bh=0kDcA2jFFsPRAQa3MWBp9Tcl0uF1YzFy0xQQOCPznSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXsXmVlFUFxgw8ISnLcsJRwsIR1hXWefrKrNnE7V65DgkOJmk5/9ibfWjUIye9oQo
         3wNQtXPZ755LA/DmdFy8H+McK/L9OJ7Qe9qXyhAPsgGi4Wx9y1AKDWLIw74f2Hj0wJ
         XUysONVRLV8EMfSAbhpEDMrerhViFqugNZZi9pAqfi4L+GqqQIndV1jZgyc0HDq78s
         4YzJhy/+ie+dQMrj9Q+IyrU191CiGgWQoKjMoKN7YiWWnLRveEmNt8G3m5UnwGQaDW
         LvvxhOrMYumcDCQcc7cNg0vCorwNEoMlltNT/9V2XN3Pn6mjRkqcQPFxZ+0pIIIY26
         cC6UALhZEYEAg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] fstests: redirect fsstress' stdout to $seqres.full instead of /dev/null
Date:   Tue,  3 Oct 2023 12:57:44 +0100
Message-Id: <bbd99333b3c2dcd44c10958aeab43c22c91a738f.1696333874.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696333874.git.fdmanana@suse.com>
References: <cover.1696333874.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Several tests are redirecting the output of fsstress to /dev/null and this
makes it harder to debug a test failure because we have no way of knowing
what was the seed used by fsstress, as fsstress outputs the seed it uses
to stdout. Very often when such a test fails, I have to go modify to
redirect stdout to the $seqres.full file and then run it in a loop until
I find a seed that causes a failure.

So modify all tests that redirect fsstress' output to /dev/null to instead
redirect it to the $seqres.full file. Note that for some tests I've added
the style ">> $seqres.full" (with a space after >>) while for others I did
">>$seqres.full" (no space) - the reason for this was to keep style
consistency within each test case.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/028   | 2 +-
 tests/btrfs/049   | 2 +-
 tests/btrfs/060   | 2 +-
 tests/btrfs/061   | 2 +-
 tests/btrfs/062   | 2 +-
 tests/btrfs/063   | 2 +-
 tests/btrfs/064   | 2 +-
 tests/btrfs/065   | 2 +-
 tests/btrfs/066   | 2 +-
 tests/btrfs/067   | 2 +-
 tests/btrfs/068   | 2 +-
 tests/btrfs/069   | 2 +-
 tests/btrfs/070   | 2 +-
 tests/btrfs/071   | 2 +-
 tests/btrfs/072   | 2 +-
 tests/btrfs/073   | 2 +-
 tests/btrfs/074   | 2 +-
 tests/btrfs/136   | 2 +-
 tests/btrfs/192   | 2 +-
 tests/btrfs/232   | 2 +-
 tests/btrfs/261   | 2 +-
 tests/btrfs/286   | 2 +-
 tests/ext4/057    | 2 +-
 tests/ext4/307    | 2 +-
 tests/generic/068 | 2 +-
 tests/generic/269 | 2 +-
 tests/generic/409 | 2 +-
 tests/generic/410 | 2 +-
 tests/generic/411 | 2 +-
 tests/generic/589 | 2 +-
 tests/xfs/051     | 2 +-
 tests/xfs/057     | 2 +-
 tests/xfs/297     | 2 +-
 tests/xfs/305     | 2 +-
 tests/xfs/538     | 2 +-
 35 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tests/btrfs/028 b/tests/btrfs/028
index fe0678f8..4637469c 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -35,7 +35,7 @@ args=`_scale_fsstress_args -z \
 	-f fsync=10 -n 100000 -p 2 \
 	-d $SCRATCH_MNT/stress_dir`
 echo "Run fsstress $args" >>$seqres.full
-$FSSTRESS_PROG $args >/dev/null 2>&1 &
+$FSSTRESS_PROG $args >>$seqres.full &
 fsstress_pid=$!
 
 echo "Start balance" >>$seqres.full
diff --git a/tests/btrfs/049 b/tests/btrfs/049
index 9569c141..c48e4087 100755
--- a/tests/btrfs/049
+++ b/tests/btrfs/049
@@ -42,7 +42,7 @@ args=`_scale_fsstress_args -z \
 	-f write=10 -f creat=10 \
 	-n 1000 -p 2 -d $SCRATCH_MNT/stress_dir`
 echo "Run fsstress $args" >>$seqres.full
-$FSSTRESS_PROG $args >/dev/null 2>&1
+$FSSTRESS_PROG $args >>$seqres.full
 
 # Start and pause balance to ensure it will be restored on remount
 echo "Start balance" >>$seqres.full
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index 7dd4d2af..a0184891 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -38,7 +38,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start balance worker: " >>$seqres.full
diff --git a/tests/btrfs/061 b/tests/btrfs/061
index 55f5625b..c1010413 100755
--- a/tests/btrfs/061
+++ b/tests/btrfs/061
@@ -36,7 +36,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start balance worker: " >>$seqres.full
diff --git a/tests/btrfs/062 b/tests/btrfs/062
index 10f95111..818a0156 100755
--- a/tests/btrfs/062
+++ b/tests/btrfs/062
@@ -37,7 +37,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start balance worker: " >>$seqres.full
diff --git a/tests/btrfs/063 b/tests/btrfs/063
index cef80771..2f771baf 100755
--- a/tests/btrfs/063
+++ b/tests/btrfs/063
@@ -36,7 +36,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start balance worker: " >>$seqres.full
diff --git a/tests/btrfs/064 b/tests/btrfs/064
index f29e68ba..e9b46ce6 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -46,7 +46,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	# Start both balance and replace in the background.
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index b6c9dbad..c4b6aafe 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -46,7 +46,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	# make sure the stop sign is not there
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index 8d12af61..a29034bb 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -38,7 +38,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	# make sure the stop sign is not there
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 970a23c4..709db155 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -39,7 +39,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	# make sure the stop sign is not there
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index e0bcc2ac..15fd41db 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -39,7 +39,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	# make sure the stop sign is not there
diff --git a/tests/btrfs/069 b/tests/btrfs/069
index 6e798a2e..139dde48 100755
--- a/tests/btrfs/069
+++ b/tests/btrfs/069
@@ -44,7 +44,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start replace worker: " >>$seqres.full
diff --git a/tests/btrfs/070 b/tests/btrfs/070
index f2e61ad3..54aa275c 100755
--- a/tests/btrfs/070
+++ b/tests/btrfs/070
@@ -45,7 +45,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start replace worker: " >>$seqres.full
diff --git a/tests/btrfs/071 b/tests/btrfs/071
index 40230b11..6ebbd8cc 100755
--- a/tests/btrfs/071
+++ b/tests/btrfs/071
@@ -44,7 +44,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start replace worker: " >>$seqres.full
diff --git a/tests/btrfs/072 b/tests/btrfs/072
index bcb0ea25..4b6b6fb5 100755
--- a/tests/btrfs/072
+++ b/tests/btrfs/072
@@ -37,7 +37,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start scrub worker: " >>$seqres.full
diff --git a/tests/btrfs/073 b/tests/btrfs/073
index 26c5deb6..b1604f94 100755
--- a/tests/btrfs/073
+++ b/tests/btrfs/073
@@ -36,7 +36,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start scrub worker: " >>$seqres.full
diff --git a/tests/btrfs/074 b/tests/btrfs/074
index 92e25c7c..9b22c620 100755
--- a/tests/btrfs/074
+++ b/tests/btrfs/074
@@ -37,7 +37,7 @@ run_test()
 
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 
 	echo -n "Start defrag worker: " >>$seqres.full
diff --git a/tests/btrfs/136 b/tests/btrfs/136
index b9ab8270..70e836a5 100755
--- a/tests/btrfs/136
+++ b/tests/btrfs/136
@@ -39,7 +39,7 @@ populate_data(){
 	mkdir -p $data_path
 	args=`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $data_path`
 	echo "Run fsstress $args" >>$seqres.full
-	$FSSTRESS_PROG $args >/dev/null 2>&1 &
+	$FSSTRESS_PROG $args >>$seqres.full &
 	fsstress_pid=$!
 	wait $fsstress_pid
 }
diff --git a/tests/btrfs/192 b/tests/btrfs/192
index ea261b34..80588a3c 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -140,7 +140,7 @@ pid1=$!
 delete_workload &
 pid2=$!
 
-"$FSSTRESS_PROG" $fsstress_args > /dev/null &
+"$FSSTRESS_PROG" $fsstress_args >> $seqres.full &
 sleep $runtime
 
 "$KILLALL_PROG" -q "$FSSTRESS_PROG" &> /dev/null
diff --git a/tests/btrfs/232 b/tests/btrfs/232
index 02c7e49d..e8a22f5e 100755
--- a/tests/btrfs/232
+++ b/tests/btrfs/232
@@ -25,7 +25,7 @@ writer()
 
 	while true; do
 		args=`_scale_fsstress_args -p 20 -n 1000 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
-		$FSSTRESS_PROG $args >/dev/null 2>&1
+		$FSSTRESS_PROG $args >> $seqres.full
 	done
 }
 
diff --git a/tests/btrfs/261 b/tests/btrfs/261
index 50173de3..58fa8e75 100755
--- a/tests/btrfs/261
+++ b/tests/btrfs/261
@@ -36,7 +36,7 @@ prepare_fs()
 	# Then use fsstress to generate some extra contents.
 	# Disable setattr related operations, as it may set NODATACOW which will
 	# not allow us to use btrfs checksum to verify the content.
-	$FSSTRESS_PROG -f setattr=0 -d $SCRATCH_MNT -w -n 3000 > /dev/null 2>&1
+	$FSSTRESS_PROG -f setattr=0 -d $SCRATCH_MNT -w -n 3000 >> $seqres.full
 	sync
 
 	# Save the fssum of this fs
diff --git a/tests/btrfs/286 b/tests/btrfs/286
index f1ee129c..71f6d4bd 100755
--- a/tests/btrfs/286
+++ b/tests/btrfs/286
@@ -36,7 +36,7 @@ workload()
 	# Use nodatasum mount option, so all data won't have checksum.
 	_scratch_mount -o nodatasum
 
-	$FSSTRESS_PROG -p 10 -n 200 -d $SCRATCH_MNT > /dev/null 2>&1
+	$FSSTRESS_PROG -p 10 -n 200 -d $SCRATCH_MNT >> $seqres.full
 	sync
 
 	# Generate fssum for later verification, here we only care
diff --git a/tests/ext4/057 b/tests/ext4/057
index 4006a07c..6babedb2 100755
--- a/tests/ext4/057
+++ b/tests/ext4/057
@@ -42,7 +42,7 @@ _scratch_mount
 
 # Begin fsstress while modifying UUID
 fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
-$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
+$FSSTRESS_PROG $fsstress_args >> $seqres.full &
 fsstress_pid=$!
 
 for n in $(seq 1 20); do
diff --git a/tests/ext4/307 b/tests/ext4/307
index db83a083..8b1cfc9e 100755
--- a/tests/ext4/307
+++ b/tests/ext4/307
@@ -21,7 +21,7 @@ _workout()
 	out=$SCRATCH_MNT/fsstress.$$
 	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 $FSSTRESS_AVOID -d $out`
 	echo "fsstress $args" >> $seqres.full
-	$FSSTRESS_PROG $args > /dev/null 2>&1
+	$FSSTRESS_PROG $args >> $seqres.full
 	find $out -type f > $out.list
 	cat $out.list | xargs  md5sum > $out.md5sum
 	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
diff --git a/tests/generic/068 b/tests/generic/068
index eeddf6d1..af527fee 100755
--- a/tests/generic/068
+++ b/tests/generic/068
@@ -57,7 +57,7 @@ touch $tmp.running
       # We do both read & write IO - not only is this more realistic,
       # but it also potentially tests atime updates
       FSSTRESS_ARGS=`_scale_fsstress_args -d $STRESS_DIR -p $procs -n $nops $FSSTRESS_AVOID`
-      $FSSTRESS_PROG $FSSTRESS_ARGS > /dev/null 2>&1
+      $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
     done
 
     rm -r $STRESS_DIR/*
diff --git a/tests/generic/269 b/tests/generic/269
index 838e696d..b852f6bf 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -23,7 +23,7 @@ _workout()
 	out=$SCRATCH_MNT/fsstress.$$
 	args=`_scale_fsstress_args -p128 -n999999999 -f setattr=1 $FSSTRESS_AVOID -d $out`
 	echo "fsstress $args" >> $seqres.full
-	$FSSTRESS_PROG $args > /dev/null 2>&1 &
+	$FSSTRESS_PROG $args >> $seqres.full &
 	pid=$!
 	echo "Run dd writers in parallel"
 	for ((i=0; i < num_iterations; i++))
diff --git a/tests/generic/409 b/tests/generic/409
index 7a5004ed..432befac 100755
--- a/tests/generic/409
+++ b/tests/generic/409
@@ -58,7 +58,7 @@ fs_stress()
 		       -f chown=1 \
 		       -f getdents=1 \
 		       -f fiemap=1 \
-		       -d $target >/dev/null
+		       -d $target >>$seqres.full
 	sync
 }
 
diff --git a/tests/generic/410 b/tests/generic/410
index f35f2f4a..8cc36d9f 100755
--- a/tests/generic/410
+++ b/tests/generic/410
@@ -66,7 +66,7 @@ fs_stress()
 		       -f chown=1 \
 		       -f getdents=1 \
 		       -f fiemap=1 \
-		       -d $target >/dev/null
+		       -d $target >>$seqres.full
 	sync
 }
 
diff --git a/tests/generic/411 b/tests/generic/411
index 9852a49d..b2b8d550 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -49,7 +49,7 @@ fs_stress()
 		       -f chown=1 \
 		       -f getdents=1 \
 		       -f fiemap=1 \
-		       -d $target >/dev/null
+		       -d $target >>$seqres.full
 	sync
 }
 
diff --git a/tests/generic/589 b/tests/generic/589
index c03cf1fc..bfc7407a 100755
--- a/tests/generic/589
+++ b/tests/generic/589
@@ -48,7 +48,7 @@ fs_stress()
 {
 	local target=$1
 
-	$FSSTRESS_PROG -n 50 -p 3 -d $target >/dev/null
+	$FSSTRESS_PROG -n 50 -p 3 -d $target >>$seqres.full
 	sync
 }
 
diff --git a/tests/xfs/051 b/tests/xfs/051
index ea70cb50..1c670964 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -38,7 +38,7 @@ _scratch_mount
 
 # Start a workload and shutdown the fs. The subsequent mount will require log
 # recovery.
-$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT > /dev/null 2>&1 &
+$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT >> $seqres.full &
 sleep 5
 _scratch_shutdown -f
 $KILLALL_PROG -q $FSSTRESS_PROG
diff --git a/tests/xfs/057 b/tests/xfs/057
index 9fb3f406..6af14c80 100755
--- a/tests/xfs/057
+++ b/tests/xfs/057
@@ -56,7 +56,7 @@ _scratch_mkfs_sized $((1024 * 1024 * 500)) >> $seqres.full 2>&1 ||
 _scratch_mount
 
 # populate the fs with some data and cycle the mount to reset the log head/tail
-$FSSTRESS_PROG -d $SCRATCH_MNT -z -fcreat=1 -p 4 -n 100000 > /dev/null 2>&1
+$FSSTRESS_PROG -d $SCRATCH_MNT -z -fcreat=1 -p 4 -n 100000 >> $seqres.full
 _scratch_cycle_mount || _fail "cycle mount failed"
 
 # Pin the tail and start a file removal workload. File removal tends to
diff --git a/tests/xfs/297 b/tests/xfs/297
index 07f84c25..1d101876 100755
--- a/tests/xfs/297
+++ b/tests/xfs/297
@@ -39,7 +39,7 @@ _scratch_mount
 STRESS_DIR="$SCRATCH_MNT/testdir"
 mkdir -p $STRESS_DIR
 
-$FSSTRESS_PROG -d $STRESS_DIR -n 100 -p 1000 $FSSTRESS_AVOID >/dev/null 2>&1 &
+$FSSTRESS_PROG -d $STRESS_DIR -n 100 -p 1000 $FSSTRESS_AVOID >>$seqres.full &
 
 # Freeze/unfreeze file system randomly
 echo "Start freeze/unfreeze randomly" | tee -a $seqres.full
diff --git a/tests/xfs/305 b/tests/xfs/305
index 41c7b7f8..d8a6712e 100755
--- a/tests/xfs/305
+++ b/tests/xfs/305
@@ -36,7 +36,7 @@ _exercise()
 	_qmount
 	mkdir -p $QUOTA_DIR
 
-	$FSSTRESS_PROG -d $QUOTA_DIR -n 1000000 -p 100 $FSSTRESS_AVOID >/dev/null 2>&1 &
+	$FSSTRESS_PROG -d $QUOTA_DIR -n 1000000 -p 100 $FSSTRESS_AVOID >>$seqres.full &
 	sleep 10
 	$XFS_QUOTA_PROG -x -c "disable -$type" $SCRATCH_DEV
 	sleep 5
diff --git a/tests/xfs/538 b/tests/xfs/538
index 2b5e97e5..0b5772a1 100755
--- a/tests/xfs/538
+++ b/tests/xfs/538
@@ -63,7 +63,7 @@ $FSSTRESS_PROG -d $SCRATCH_MNT \
 		-f readv=0 \
 		-f stat=0 \
 		-f aread=0 \
-		-f dread=0 > /dev/null 2>&1
+		-f dread=0 >> $seqres.full
 
 # success, all done
 status=0
-- 
2.40.1

