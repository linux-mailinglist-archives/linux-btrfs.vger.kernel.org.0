Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E267B28B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 01:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjI1XQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 19:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjI1XQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 19:16:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B36AC;
        Thu, 28 Sep 2023 16:16:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CDA55C013C;
        Thu, 28 Sep 2023 19:16:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Sep 2023 19:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695942965; x=
        1696029365; bh=jRmpQnQRDBNFYsmZr9zixenkAAlEEq75rTWdTPQkDAw=; b=M
        i6dkTIJMx40+SQjAi8ntcfkmeRBJwgl4SOUyu/TXd+quD0xAhl8Eznxzmqj6IRxn
        lzXU/0PKWKPEWo7k22W9C+NUr8TCSbdmBDzRA1P2eYYYJoMy2afkeH4j4NOTekNA
        /9zSE949cWGYVeYKGNWRGohUEvXBqUrHIWoKEpLzCHaBJpCkBQLMVct+/czTThHl
        LpKj6oBVR9RLjKlrXn+W7mhEj7k0c1v1FlK0pSM1lns1Q/8wFJQq6C4+X2ncednK
        ZzNV8BANsZj8vXyQtLja7l++cCVP0jZmlF0QGCroLlps6Zf7t4Fv1b0702+QwWAk
        IrL/vdRTK+H7PdoRy6klQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695942965; x=1696029365; bh=j
        RmpQnQRDBNFYsmZr9zixenkAAlEEq75rTWdTPQkDAw=; b=e3fJmO1uwdqm3z2DP
        KKjrEI70wR9ARHS67B0zWovQlsgcqoPyQOJ3y7wocWLLBofuFfbMI0gECbxyTWwH
        vYjlKOzaxBrmjLXwNi4o/swgqCK3HlCz6j3jxfYxbhPNDGP3cjUVzCY5uIMkk9/f
        4qLjfezkA3O4yEGmgK0rESQgUuHYgUrAW5OfQmcBp9fsY3m7czv7S5aGtQkHp9Xp
        BFUZNpJLY2xiGbtO7qdcB2bDjgsQ2KNSS+aTKciuDffrZfw5bRtS+/6Oio6QqsE9
        4RdygI113RqE+vfUyzpoauQ8HPsQhimk1+1/7lNsbosYveMW4CSu592vFw++e0Ex
        bNCGw==
X-ME-Sender: <xms:NAkWZTHxFh1cNrO7z7TgC6lO8fV6WAi2zXZc-cnRq5Hb1oLhCC2FCQ>
    <xme:NAkWZQXUmB6LIW2GXMm7YSUtukSTVYxJTQR2nFVc14nUZ9v34yjK8CE8Eun18zCjD
    bvC8xE2MsK-mv_SKaY>
X-ME-Received: <xmr:NAkWZVIcixcov6B4ikPjPO6bHhSGwRh-dm0JgJQwNnkAmlu8Ic3NOjtkYWIrs49n5BHEGW-U_7-y5xyr6BvWClEcc_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddugddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:NQkWZREnKH7Vm1daOKnYXYfJ8-IPCfffBic-oM8cy-YVNMFEjVT9Ew>
    <xmx:NQkWZZWsIcjMuZg9ATSdJ-qUqtkLDPbTaELhwsRD44Do776AdLNYLA>
    <xmx:NQkWZcP1pkdseMz7RJuBz87kGpc_VU-5HKSri6aDEgAoynwNx9a_ZA>
    <xmx:NQkWZYejPINvlvynOaG0AqV7F3tCy8uWpP5oUeaNaqGVIdJEtd2ziQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 19:16:04 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v4 5/6] btrfs: use new rescan wrapper
Date:   Thu, 28 Sep 2023 16:16:47 -0700
Message-ID: <7264ca978836109af1be53f93153837ede2705da.1695942727.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695942727.git.boris@bur.io>
References: <cover.1695942727.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These tests can pass in simple quota mode if we skip the rescans via the
wrapper.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/022 | 1 +
 tests/btrfs/028 | 2 +-
 tests/btrfs/104 | 2 +-
 tests/btrfs/123 | 2 +-
 tests/btrfs/126 | 2 +-
 tests/btrfs/139 | 2 +-
 tests/btrfs/153 | 2 +-
 tests/btrfs/171 | 6 +++---
 tests/btrfs/179 | 2 +-
 tests/btrfs/180 | 2 +-
 tests/btrfs/190 | 2 +-
 tests/btrfs/193 | 2 +-
 tests/btrfs/210 | 2 +-
 tests/btrfs/224 | 6 +++---
 tests/btrfs/230 | 2 +-
 tests/btrfs/232 | 2 +-
 16 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/tests/btrfs/022 b/tests/btrfs/022
index e2d37b094..b1ef2fdf7 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -14,6 +14,7 @@ _begin_fstest auto qgroup limit
 
 _supported_fs btrfs
 _require_scratch
+_require_qgroup_rescan
 _require_btrfs_qgroup_report
 
 # Test to make sure we can actually turn it on and it makes sense
diff --git a/tests/btrfs/028 b/tests/btrfs/028
index fe0678f86..c4080c950 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -25,7 +25,7 @@ _scratch_mkfs >/dev/null
 _scratch_mount
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_qgroup_rescan $SCRATCH_MNT
 
 # Increase the probability of generating de-refer extent, and decrease
 # other.
diff --git a/tests/btrfs/104 b/tests/btrfs/104
index 499de6bfb..c9528eb13 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -94,7 +94,7 @@ _explode_fs_tree 1 $SCRATCH_MNT/snap2/files-snap2
 # Enable qgroups now that we have our filesystem prepared. This
 # will kick off a scan which we will have to wait for.
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_qgroup_rescan $SCRATCH_MNT
 
 # Remount to clear cache, force everything to disk
 _scratch_cycle_mount
diff --git a/tests/btrfs/123 b/tests/btrfs/123
index c179eeec9..4c5b7e116 100755
--- a/tests/btrfs/123
+++ b/tests/btrfs/123
@@ -39,7 +39,7 @@ sync
 
 # enable quota and rescan to get correct number
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_qgroup_rescan $SCRATCH_MNT
 
 # now balance data block groups to corrupt qgroup
 _run_btrfs_balance_start -d $SCRATCH_MNT >> $seqres.full
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index 2b0edb65b..1bb24e00f 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -28,7 +28,7 @@ _scratch_mkfs >/dev/null
 _scratch_mount "-o enospc_debug"
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_qgroup_rescan $SCRATCH_MNT
 _run_btrfs_util_prog qgroup limit 512K 0/5 $SCRATCH_MNT
 
 # The amount of written data may change due to different nodesize at mkfs time,
diff --git a/tests/btrfs/139 b/tests/btrfs/139
index c4b09f9fc..f3d92ba46 100755
--- a/tests/btrfs/139
+++ b/tests/btrfs/139
@@ -30,7 +30,7 @@ SUBVOL=$SCRATCH_MNT/subvol
 
 _run_btrfs_util_prog subvolume create $SUBVOL
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_qgroup_rescan $SCRATCH_MNT
 _run_btrfs_util_prog qgroup limit -e 1G $SUBVOL
 
 # Write and delete files within 1G limits, multiple times
diff --git a/tests/btrfs/153 b/tests/btrfs/153
index 99fab1018..4a5fe2b8c 100755
--- a/tests/btrfs/153
+++ b/tests/btrfs/153
@@ -24,7 +24,7 @@ _scratch_mkfs >/dev/null
 _scratch_mount
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_qgroup_rescan $SCRATCH_MNT
 _run_btrfs_util_prog qgroup limit 100M 0/5 $SCRATCH_MNT
 
 testfile1=$SCRATCH_MNT/testfile1
diff --git a/tests/btrfs/171 b/tests/btrfs/171
index 461cdd0fa..6a1ed1c1a 100755
--- a/tests/btrfs/171
+++ b/tests/btrfs/171
@@ -35,7 +35,7 @@ $BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
 	"$SCRATCH_MNT/snapshot" > /dev/null
 
 $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+_qgroup_rescan $SCRATCH_MNT > /dev/null
 
 # Create high level qgroup
 $BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
@@ -45,7 +45,7 @@ $BTRFS_UTIL_PROG qgroup assign "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_MNT" \
 
 # Above assignment will mark qgroup inconsistent due to the shared extents
 # between subvol/snapshot/high level qgroup, do rescan here.
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+_qgroup_rescan $SCRATCH_MNT > /dev/null
 
 # Now remove the qgroup relationship and make 1/0 childless
 # Due to the shared extent outside of 1/0, we will mark qgroup inconsistent
@@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG qgroup remove "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_MNT" \
 	2>&1 | _filter_btrfs_qgroup_assign_warnings
 
 # Above removal also marks qgroup inconsistent, rescan again
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+_qgroup_rescan $SCRATCH_MNT > /dev/null
 
 # After the test, btrfs check will verify qgroup numbers to catch any
 # corruption.
diff --git a/tests/btrfs/179 b/tests/btrfs/179
index 479667f05..00013af0a 100755
--- a/tests/btrfs/179
+++ b/tests/btrfs/179
@@ -33,7 +33,7 @@ _scratch_mount
 mkdir -p "$SCRATCH_MNT/snapshots"
 $BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/src" > /dev/null
 $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+_qgroup_rescan "$SCRATCH_MNT" > /dev/null
 
 fill_workload()
 {
diff --git a/tests/btrfs/180 b/tests/btrfs/180
index b7c8dac96..aa195f7b4 100755
--- a/tests/btrfs/180
+++ b/tests/btrfs/180
@@ -27,7 +27,7 @@ _scratch_mkfs > /dev/null
 _scratch_mount
 
 $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+_qgroup_rescan "$SCRATCH_MNT" > /dev/null
 $BTRFS_UTIL_PROG qgroup limit -e 1G "$SCRATCH_MNT"
 
 $XFS_IO_PROG -f -c "falloc 0 900M" "$SCRATCH_MNT/padding"
diff --git a/tests/btrfs/190 b/tests/btrfs/190
index 974438c15..f78c14fe4 100755
--- a/tests/btrfs/190
+++ b/tests/btrfs/190
@@ -30,7 +30,7 @@ _log_writes_mkfs >> $seqres.full 2>&1
 
 _log_writes_mount
 $BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
-$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+_qgroup_rescan $SCRATCH_MNT >> $seqres.full
 
 # Create enough metadata for later balance
 for ((i = 0; i < $nr_files; i++)); do
diff --git a/tests/btrfs/193 b/tests/btrfs/193
index b4632ab0a..67220c7a5 100755
--- a/tests/btrfs/193
+++ b/tests/btrfs/193
@@ -26,7 +26,7 @@ _scratch_mkfs > /dev/null
 _scratch_mount
 
 $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+_qgroup_rescan "$SCRATCH_MNT" > /dev/null
 $BTRFS_UTIL_PROG qgroup limit -e 256M "$SCRATCH_MNT"
 
 # Create a file with the following layout:
diff --git a/tests/btrfs/210 b/tests/btrfs/210
index 383a307ff..f3d769fa0 100755
--- a/tests/btrfs/210
+++ b/tests/btrfs/210
@@ -29,7 +29,7 @@ _pwrite_byte 0xcd 0 16M "$SCRATCH_MNT/src/file" > /dev/null
 # by qgroup
 sync
 $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT"
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+_qgroup_rescan "$SCRATCH_MNT" > /dev/null
 $BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
 
 # Create a snapshot with qgroup inherit
diff --git a/tests/btrfs/224 b/tests/btrfs/224
index d7ec57360..de10942fe 100755
--- a/tests/btrfs/224
+++ b/tests/btrfs/224
@@ -30,7 +30,7 @@ assign_shared_test()
 
 	echo "=== qgroup assign shared test ===" >> $seqres.full
 	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
-	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+	_qgroup_rescan $SCRATCH_MNT >> $seqres.full
 
 	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
 	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
@@ -54,7 +54,7 @@ assign_no_shared_test()
 
 	echo "=== qgroup assign no shared test ===" >> $seqres.full
 	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
-	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+	_qgroup_rescan $SCRATCH_MNT >> $seqres.full
 
 	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
 	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
@@ -75,7 +75,7 @@ snapshot_test()
 
 	echo "=== qgroup snapshot test ===" >> $seqres.full
 	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
-	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+	_qgroup_rescan $SCRATCH_MNT >> $seqres.full
 
 	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
 	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
diff --git a/tests/btrfs/230 b/tests/btrfs/230
index 46b0c6369..7a4cd18e9 100755
--- a/tests/btrfs/230
+++ b/tests/btrfs/230
@@ -31,7 +31,7 @@ _pwrite_byte 0xcd 0 1G $SCRATCH_MNT/file >> $seqres.full
 sync
 
 $BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
-$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+_qgroup_rescan $SCRATCH_MNT >> $seqres.full
 
 # Set the limit to just 512MiB, which is way below the existing usage
 $BTRFS_UTIL_PROG qgroup limit  512M 0/5 $SCRATCH_MNT
diff --git a/tests/btrfs/232 b/tests/btrfs/232
index 02c7e49de..debe070bb 100755
--- a/tests/btrfs/232
+++ b/tests/btrfs/232
@@ -46,7 +46,7 @@ _pwrite_byte 0xcd 0 900m $SCRATCH_MNT/file >> $seqres.full
 sync
 
 $BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
-$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+_qgroup_rescan $SCRATCH_MNT >> $seqres.full
 # set the limit to 1 g, leaving us just 100mb of slack space
 $BTRFS_UTIL_PROG qgroup limit 1G 0/5 $SCRATCH_MNT
 
-- 
2.42.0

