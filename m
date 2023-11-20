Return-Path: <linux-btrfs+bounces-202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC317F1CDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 19:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CBA282793
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DAA37168;
	Mon, 20 Nov 2023 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="rHkO+o9a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBWCIR/j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CABCC9;
	Mon, 20 Nov 2023 10:44:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 71C2B5C078F;
	Mon, 20 Nov 2023 13:44:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 20 Nov 2023 13:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1700505857; x=
	1700592257; bh=QpkwrtSQolhAx/izexOFkO18eZqnDoUOVWGjBY9n4PM=; b=r
	HkO+o9aI8xgnqvLIgrQaR8rNmd8iEFdXI+fAIxzMBNdM7AdnwhAfjCs0LM53hs2D
	OeooRD4pg6+yFkEMorytkeaAOyUkCvDYyUW4TWj4PFPsFHBfwFoq48C0k7G+N8j4
	0dmz5d4K3vV3LhLqIyPOpnPO8OmIsMw3PKfUMzYI2NDUAUOvEqt6wh0IteYztUpp
	XDGFSyDqXCdLlOvq96XOr81hlAeVyoPgcN1+K3UOmn0Xive+N8I7341RfRm2ccNw
	0g1rBkyimL0qjAdwJusdk1Pei2u801iJcPnIVMSg3DKLD435XENoKASswxM5fVqh
	wtd7YyoHWykItVAHyRCVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1700505857; x=1700592257; bh=Q
	pkwrtSQolhAx/izexOFkO18eZqnDoUOVWGjBY9n4PM=; b=cBWCIR/jEEAgL5qIv
	Nr5a7KqqAHilOYp3OMVY8amd/L+652zD+i4Ak9Wop+5cLT9sgnEPYJzgHQ4svGz3
	unhP8aWAsJVWZ/g7LezKHOOF0E7AMOzvcyUPZ7CSVkeFRapv/kAN+xAzoMJwuWC7
	In+tUVsas3aM9MSxk5olci7aHzBROosuSpQ488Qcr+cqGnnczeZpWCF1/8rEcanG
	LPcyf+do/4PH4PdrArm57Vq+g3/lXfm2DWjSpZeWo2dXVV1nEif2Q175949KRVm7
	uqNUXEdwlZhi/JiQ+eqm7fXRSimgyR6ZvUbilvB6XH0DoxIZFWx//y+KIyEkVwwd
	rLUpA==
X-ME-Sender: <xms:AalbZZRBfzxZ8OI0_LfnUeh9dd68PYLYGYFUV4dObGV4pAVi4id6cQ>
    <xme:AalbZSwAgCvrFuUpfzb7SqqZjTB0imJLlrlgiUGLB0YzRPBHQoW_EAPjiYoNeUT-t
    jU21VmWTkkhgQMFJ9c>
X-ME-Received: <xmr:AalbZe3yl83mgXfJmiGQwiop-looS-E0nM39Jn1no6kogUHH9fX87mB8Ox0ES3gTC-jt_V4C19QmGEl9jhXrg496avQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegjedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:AalbZRDJUssEhlo9JeL4IwJpqmXT8HrBulJCNyAb3vZI1dx_UjGbCw>
    <xmx:AalbZSjA52n2p4dBuVhXUHW8v6VLWVXW9Tlipb8NXTHlv7Cl04uMeA>
    <xmx:AalbZVpdF6TjjZaPDIPaHwyUjU-zeIJZSl87lVu81OyzMcJ9QoU1FA>
    <xmx:AalbZWbmM7t2m-uEtR3OwMccvopX1o6T4HfikFIBQCJQx1HMpis85g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 13:44:16 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH 1/2] btrfs/301: fix hardcoded subvolids
Date: Mon, 20 Nov 2023 10:45:02 -0800
Message-ID: <da0104f52b8253be8b905f77ce467acaf6afc9cd.1700505679.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1700505679.git.boris@bur.io>
References: <cover.1700505679.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardcoded subvolids break noholes test runs, so change the test to use
_btrfs_get_subvolid instead of assuming 256, 257, etc...

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/301 | 138 ++++++++++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 68 deletions(-)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 7a0b4c0e1..5bb6b16a6 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -172,25 +172,27 @@ prepare()
 	_scratch_mount
 	enable_quota "s"
 	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
-	set_subvol_limit 256 $limit
-	check_subvol_usage 256 0
+	subvid=$(_btrfs_get_subvolid $SCRATCH_MNT subv)
+	set_subvol_limit $subvid $limit
+	check_subvol_usage $subvid 0
 
 	# Create a bunch of little filler files to generate several levels in
 	# the btree, to make snapshotting sharing scenarios complex enough.
 	$FIO_PROG $prep_fio_config --output=$fio_out
-	check_subvol_usage 256 $total_fill
+	check_subvol_usage $subvid $total_fill
 
 	# Create a single file whose extents we will explicitly share/unshare.
 	do_write $subv/f $ext_sz
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
 }
 
 prepare_snapshotted()
 {
 	prepare
 	$BTRFS_UTIL_PROG subvolume snapshot $subv $snap >> $seqres.full
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	check_subvol_usage 257 0
+	snapid=$(_btrfs_get_subvolid $SCRATCH_MNT snap)
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	check_subvol_usage $snapid 0
 }
 
 prepare_nested()
@@ -198,13 +200,13 @@ prepare_nested()
 	prepare
 	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
 	$BTRFS_UTIL_PROG qgroup limit $limit 1/100 $SCRATCH_MNT
-	$BTRFS_UTIL_PROG qgroup assign 0/256 1/100 $SCRATCH_MNT >> $seqres.full
+	$BTRFS_UTIL_PROG qgroup assign 0/$subvid 1/100 $SCRATCH_MNT >> $seqres.full
 	$BTRFS_UTIL_PROG subvolume create $nested >> $seqres.full
 	do_write $nested/f $ext_sz
-	check_subvol_usage 257 $ext_sz
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	local subv_usage=$(get_subvol_usage 256)
-	local nested_usage=$(get_subvol_usage 257)
+	check_subvol_usage $snapid $ext_sz
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	local subv_usage=$(get_subvol_usage $subvid)
+	local nested_usage=$(get_subvol_usage $snapid)
 	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
 }
 
@@ -214,8 +216,8 @@ basic_accounting()
 	echo "basic accounting"
 	prepare
 	rm $subv/f
-	check_subvol_usage 256 $total_fill
-	cycle_mount_check_subvol_usage 256 $total_fill
+	check_subvol_usage $subvid $total_fill
+	cycle_mount_check_subvol_usage $subvid $total_fill
 	do_write $subv/tmp 512M
 	rm $subv/tmp
 	do_write $subv/tmp 512M
@@ -245,19 +247,19 @@ snapshot_accounting()
 	echo "snapshot accounting"
 	prepare_snapshotted
 	touch $snap/f
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	check_subvol_usage $snapid 0
 	do_write $snap/f $ext_sz
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	check_subvol_usage 257 $ext_sz
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	check_subvol_usage $snapid $ext_sz
 	rm $snap/f
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	check_subvol_usage $snapid 0
 	rm $subv/f
-	check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 0
-	cycle_mount_check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $total_fill
+	check_subvol_usage $snapid 0
+	cycle_mount_check_subvol_usage $subvid $total_fill
+	check_subvol_usage $snapid 0
 	_scratch_unmount
 }
 
@@ -267,14 +269,14 @@ delete_snapshot_src_ref()
 	echo "delete src ref first"
 	prepare_snapshotted
 	rm $subv/f
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	check_subvol_usage $snapid 0
 	rm $snap/f
 	trigger_cleaner
-	check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 0
-	cycle_mount_check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $total_fill
+	check_subvol_usage $snapid 0
+	cycle_mount_check_subvol_usage $subvid $total_fill
+	check_subvol_usage $snapid 0
 	_scratch_unmount
 }
 
@@ -284,13 +286,13 @@ delete_snapshot_ref()
 	echo "delete snapshot ref first"
 	prepare_snapshotted
 	rm $snap/f
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	check_subvol_usage $snapid 0
 	rm $subv/f
-	check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 0
-	cycle_mount_check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $total_fill
+	check_subvol_usage $snapid 0
+	cycle_mount_check_subvol_usage $subvid $total_fill
+	check_subvol_usage $snapid 0
 	_scratch_unmount
 }
 
@@ -300,18 +302,18 @@ delete_snapshot_src()
 	echo "delete snapshot src first"
 	prepare_snapshotted
 	$BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	check_subvol_usage $snapid 0
 	rm $snap/f
 	trigger_cleaner
-	check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $total_fill
+	check_subvol_usage $snapid 0
 	$BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
 	trigger_cleaner
-	check_subvol_usage 256 0
-	check_subvol_usage 257 0
-	cycle_mount_check_subvol_usage 256 0
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid 0
+	check_subvol_usage $snapid 0
+	cycle_mount_check_subvol_usage $subvid 0
+	check_subvol_usage $snapid 0
 	_scratch_unmount
 }
 
@@ -321,12 +323,12 @@ delete_snapshot()
 	echo "delete snapshot first"
 	prepare_snapshotted
 	$BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	check_subvol_usage $snapid 0
 	$BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
 	trigger_cleaner
-	check_subvol_usage 256 0
-	check_subvol_usage 257 0
+	check_subvol_usage $subvid 0
+	check_subvol_usage $snapid 0
 	_scratch_unmount
 }
 
@@ -337,16 +339,16 @@ nested_accounting()
 	echo "nested accounting"
 	prepare_nested
 	rm $subv/f
-	check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 $ext_sz
-	local subv_usage=$(get_subvol_usage 256)
-	local nested_usage=$(get_subvol_usage 257)
+	check_subvol_usage $subvid $total_fill
+	check_subvol_usage $snapid $ext_sz
+	local subv_usage=$(get_subvol_usage $subvid)
+	local nested_usage=$(get_subvol_usage $snapid)
 	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
 	rm $nested/f
-	check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 0
-	subv_usage=$(get_subvol_usage 256)
-	nested_usage=$(get_subvol_usage 257)
+	check_subvol_usage $subvid $total_fill
+	check_subvol_usage $snapid 0
+	subv_usage=$(get_subvol_usage $subvid)
+	nested_usage=$(get_subvol_usage $snapid)
 	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
 	do_enospc_falloc $nested/large_falloc 2G
 	do_enospc_write $nested/large 2G
@@ -365,21 +367,21 @@ enable_mature()
 	# we did before enabling.
 	sync
 	enable_quota "s"
-	set_subvol_limit 256 $limit
+	set_subvol_limit $subvid $limit
 	_scratch_cycle_mount
-	usage=$(get_subvol_usage 256)
+	usage=$(get_subvol_usage $subvid)
 	[ $usage -lt $ext_sz ] || \
 		echo "captured usage from before enable $usage >= $ext_sz"
 	do_write $subv/g $ext_sz
-	usage=$(get_subvol_usage 256)
+	usage=$(get_subvol_usage $subvid)
 	[ $usage -lt $ext_sz ] && \
 		echo "failed to capture usage after enable $usage < $ext_sz"
-	check_subvol_usage 256 $ext_sz
+	check_subvol_usage $subvid $ext_sz
 	rm $subv/f
-	check_subvol_usage 256 $ext_sz
+	check_subvol_usage $subvid $ext_sz
 	_scratch_cycle_mount
 	rm $subv/g
-	check_subvol_usage 256 0
+	check_subvol_usage $subvid 0
 	_scratch_unmount
 }
 
@@ -394,7 +396,7 @@ reflink_accounting()
 		_cp_reflink $subv/f $subv/f.i
 	done
 	# Confirm that there is no additional data usage from the reflinks.
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
 	_scratch_unmount
 }
 
@@ -404,11 +406,11 @@ delete_reflink_src_ref()
 	echo "delete reflink src ref"
 	prepare
 	_cp_reflink $subv/f $subv/f.link
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
 	rm $subv/f
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
 	rm $subv/f.link
-	check_subvol_usage 256 $(($total_fill))
+	check_subvol_usage $subvid $(($total_fill))
 	_scratch_unmount
 }
 
@@ -418,11 +420,11 @@ delete_reflink_ref()
 	echo "delete reflink ref"
 	prepare
 	_cp_reflink $subv/f $subv/f.link
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
 	rm $subv/f.link
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
 	rm $subv/f
-	check_subvol_usage 256 $(($total_fill))
+	check_subvol_usage $subvid $(($total_fill))
 	_scratch_unmount
 }
 
-- 
2.42.0


