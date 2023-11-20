Return-Path: <linux-btrfs+bounces-208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199997F1E88
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 22:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C9B21A55
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62E374E3;
	Mon, 20 Nov 2023 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="tQl7qzhX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fl+p8zeh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A9F4;
	Mon, 20 Nov 2023 13:10:05 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 83AD05C1132;
	Mon, 20 Nov 2023 16:10:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 20 Nov 2023 16:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1700514604; x=
	1700601004; bh=61qcFI5Btuosw8a39Qq7YfHUQ1rbu2p54/bJWNL28ww=; b=t
	Ql7qzhXsiimK0Kuz8Q6tdDzG3f9koyjC5GUDo+SXWQZcPOETKeFHERGh9RgHwBuV
	hb62xKy+GI0gDJ3mvCGytFzlwGGjEkuMHeSZzQXJwGvzsrPjuYitaqv5GvFcMFsp
	SkF/4FBCMZ1pb4IUR8kQyA3j2NJT21sz4dvxBmVkFgqTJ+EQladJnXb1BoU6ZNYf
	WPk1wsI7Oir//kFd+eSXVMU0DI5S5irv6PJhV+HEtRFxnlol/I6jQnOcjctmEom2
	PNJLYmRUsl8ywElG1kUcsWnBT3axau7hIlpzyUMFjbGV7ne82Avf+Fy6cR/aIqHb
	WReE5nwoQFLHJSTmJ9uOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1700514604; x=1700601004; bh=6
	1qcFI5Btuosw8a39Qq7YfHUQ1rbu2p54/bJWNL28ww=; b=Fl+p8zeh6rOswyqhK
	ms3uF8wlvffkcWwn77pOKM2v2Phj034rP6K7EfLlbJfMXRZRbpsHkUAp3U7SN5ly
	+L249KZ6riVzthsiSjHJ3ZcC8dF96wXjOd+0MqmDFekaEw8854mWlTEEWubr5jCm
	6WIWNkl5fxW7kxMpORIJG19K6SI9XUjQkyI8sBLIRog4gkYtBHay/tki0tuWrO5h
	ZUYT6k3bxzFdl4wa8MGCePqnxEOZhk7aB0sOpLxT86rhm3zcudLmpG/off1u5zK1
	+12Ce3xMcpHJ1f3jTbCFUAD/aLyOTSnr2d4MW5hRcTVz2qPCYVOYuih4CqRqTCT/
	sWOvQ==
X-ME-Sender: <xms:LMtbZXkR05QF6YdagVjAGinoyl5rO37cYKhzzX6B-olaaSU5Q5atoA>
    <xme:LMtbZa1CE1GQsIXseQwBBgPBzQvQZ4k6E1yGZw3rRL33nitjvlq1At2IZS9IVXdfK
    _ysFyJuwoCa8eWAPDo>
X-ME-Received: <xmr:LMtbZdop90cy8uo6n_UkoIBpFWhD0cJIEoLmWhdQ-GPTZbS_SUCGYGHMmSBgC_2hOECJOonnnbjDt3vphhygWHoDyWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:LMtbZfkZspn4YdODlorXBChcFTw3kdDQ3wBNxWwjo0IhZPBVUoPNlw>
    <xmx:LMtbZV2J-o94deXeIs-w9P_BCTeLjOklHexGTtR8k-qGq6ucfit_vw>
    <xmx:LMtbZeumuC3GjA1y8UJdtD8zf5zSbnqEjXO8OUE3mTCHKkLtK0COcA>
    <xmx:LMtbZW8La_F_Pi_-VYxRjibY1OEC_eTeQm3ouZpmizuTu357bQ1P3A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 16:10:03 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs/301: fix hardcoded subvolids
Date: Mon, 20 Nov 2023 13:10:54 -0800
Message-ID: <851c95b3f2a3786dc9b3ca9009ff4b12e93d70d5.1700514431.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1700514431.git.boris@bur.io>
References: <cover.1700514431.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardcoded subvolids break test runs with no free-space-tree, so change
the test to use _btrfs_get_subvolid instead of assuming 256, 257, etc...

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/301 | 171 +++++++++++++++++++++++++++++-------------------
 1 file changed, 103 insertions(+), 68 deletions(-)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 7a0b4c0e1..dbc6d9aef 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -166,45 +166,63 @@ enable_quota()
 	$BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT
 }
 
+get_subvid()
+{
+	_btrfs_get_subvolid $SCRATCH_MNT subv
+}
+
+get_snapid()
+{
+	_btrfs_get_subvolid $SCRATCH_MNT snap
+}
+
+get_nestedid()
+{
+	_btrfs_get_subvolid $SCRATCH_MNT subv/nested
+}
+
 prepare()
 {
 	_scratch_mkfs >> $seqres.full
 	_scratch_mount
 	enable_quota "s"
 	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
-	set_subvol_limit 256 $limit
-	check_subvol_usage 256 0
+	local subvid=$(get_subvid)
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
+	check_subvol_usage $(get_subvid) $(($total_fill + $ext_sz))
+	check_subvol_usage $(get_snapid) 0
 }
 
 prepare_nested()
 {
 	prepare
+	local subvid=$(get_subvid)
 	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
 	$BTRFS_UTIL_PROG qgroup limit $limit 1/100 $SCRATCH_MNT
-	$BTRFS_UTIL_PROG qgroup assign 0/256 1/100 $SCRATCH_MNT >> $seqres.full
+	$BTRFS_UTIL_PROG qgroup assign 0/$subvid 1/100 $SCRATCH_MNT >> $seqres.full
 	$BTRFS_UTIL_PROG subvolume create $nested >> $seqres.full
+	local nestedid=$(get_nestedid)
 	do_write $nested/f $ext_sz
-	check_subvol_usage 257 $ext_sz
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
-	local subv_usage=$(get_subvol_usage 256)
-	local nested_usage=$(get_subvol_usage 257)
+	check_subvol_usage $nestedid $ext_sz
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
+	local subv_usage=$(get_subvol_usage $subvid)
+	local nested_usage=$(get_subvol_usage $nestedid)
 	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
 }
 
@@ -213,9 +231,10 @@ basic_accounting()
 {
 	echo "basic accounting"
 	prepare
+	local subvid=$(get_subvid)
 	rm $subv/f
-	check_subvol_usage 256 $total_fill
-	cycle_mount_check_subvol_usage 256 $total_fill
+	check_subvol_usage $subvid $total_fill
+	cycle_mount_check_subvol_usage $subvid $total_fill
 	do_write $subv/tmp 512M
 	rm $subv/tmp
 	do_write $subv/tmp 512M
@@ -244,20 +263,22 @@ snapshot_accounting()
 {
 	echo "snapshot accounting"
 	prepare_snapshotted
+	local subvid=$(get_subvid)
+	local snapid=$(get_snapid)
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
 
@@ -266,15 +287,17 @@ delete_snapshot_src_ref()
 {
 	echo "delete src ref first"
 	prepare_snapshotted
+	local subvid=$(get_subvid)
+	local snapid=$(get_snapid)
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
 
@@ -283,14 +306,16 @@ delete_snapshot_ref()
 {
 	echo "delete snapshot ref first"
 	prepare_snapshotted
+	local subvid=$(get_subvid)
+	local snapid=$(get_snapid)
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
 
@@ -299,19 +324,21 @@ delete_snapshot_src()
 {
 	echo "delete snapshot src first"
 	prepare_snapshotted
+	local subvid=$(get_subvid)
+	local snapid=$(get_snapid)
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
 
@@ -320,13 +347,15 @@ delete_snapshot()
 {
 	echo "delete snapshot first"
 	prepare_snapshotted
+	local subvid=$(get_subvid)
+	local snapid=$(get_snapid)
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
 
@@ -336,17 +365,19 @@ nested_accounting()
 {
 	echo "nested accounting"
 	prepare_nested
+	local subvid=$(get_subvid)
+	local nestedid=$(get_nestedid)
 	rm $subv/f
-	check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 $ext_sz
-	local subv_usage=$(get_subvol_usage 256)
-	local nested_usage=$(get_subvol_usage 257)
+	check_subvol_usage $subvid $total_fill
+	check_subvol_usage $nestedid $ext_sz
+	local subv_usage=$(get_subvol_usage $subvid)
+	local nested_usage=$(get_subvol_usage $nestedid)
 	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
 	rm $nested/f
-	check_subvol_usage 256 $total_fill
-	check_subvol_usage 257 0
-	subv_usage=$(get_subvol_usage 256)
-	nested_usage=$(get_subvol_usage 257)
+	check_subvol_usage $subvid $total_fill
+	check_subvol_usage $nestedid 0
+	subv_usage=$(get_subvol_usage $subvid)
+	nested_usage=$(get_subvol_usage $nestedid)
 	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
 	do_enospc_falloc $nested/large_falloc 2G
 	do_enospc_write $nested/large 2G
@@ -360,26 +391,27 @@ enable_mature()
 	_scratch_mkfs >> $seqres.full
 	_scratch_mount
 	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
+	local subvid=$(get_subvid)
 	do_write $subv/f $ext_sz
 	# Sync before enabling squotas to reliably *not* count the writes
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
 
@@ -388,13 +420,14 @@ reflink_accounting()
 {
 	echo "reflink"
 	prepare
+	local subvid=$(get_subvid)
 	# Do enough reflinks to prove that they're free. If they counted, then
 	# this wouldn't fit in the limit.
 	for i in $(seq $(($limit_nr * 2))); do
 		_cp_reflink $subv/f $subv/f.i
 	done
 	# Confirm that there is no additional data usage from the reflinks.
-	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage $subvid $(($total_fill + $ext_sz))
 	_scratch_unmount
 }
 
@@ -403,12 +436,13 @@ delete_reflink_src_ref()
 {
 	echo "delete reflink src ref"
 	prepare
+	local subvid=$(get_subvid)
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
 
@@ -417,12 +451,13 @@ delete_reflink_ref()
 {
 	echo "delete reflink ref"
 	prepare
+	local subvid=$(get_subvid)
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


