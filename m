Return-Path: <linux-btrfs+bounces-8638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170A9946BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 13:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16329286472
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A9A1D0BB2;
	Tue,  8 Oct 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FDu7GbGL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246BA1D0BAE
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386625; cv=none; b=PbUnI88tJPSY2ry+WWH4Yg9mXPi0Aib/z52wy5WHaghSkO9GmF0bFa22EBsn9k5CDnJNuBQBgycyl/GvTT07LxsNQNWXaaqNcPZWpZGrcbCTBF63bEIPoQ4n5EnuxURV7WvqQrVbnlbqviEgChAlW55SI3lNsspvoirRXB0/XvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386625; c=relaxed/simple;
	bh=vI9JZ6EDI6lQhZLKSOi7yqHOeShtKeqjx0RWa9I5OfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KGQl4Sh5ZYKcEu0WSgjbbjoGqxn8IOFn4KqbgIyQeMVgGxrrYyKbtvUHbL6WZ4e+T3VHnGBBXQQdtZTN4t9DxoQSXBWoB5UBpp/o7EQJ2KHizvcqG4Rrqqohtlc0xAe5LggzQM5kg4JfRDAFySqaE9edSWxzi29ezECz8RmLDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=FDu7GbGL; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 498BNN11013413
	for <linux-btrfs@vger.kernel.org>; Tue, 8 Oct 2024 04:23:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=lFhGPnT2D5YfyQH9NdPusGd
	c2f7yO9nt3rBHwC1Bxr0=; b=FDu7GbGLHRY8zox7dQDVNbvkQzxzQLYh4mVo75r
	pXZHmOWHZRCSGgTH7lXZKj7bBDbn54pCLaccOuVxkj4uR/LNPk70jNs/XM8aEpfH
	H+0+TWNvMHRk3A/QJdjCStmfeNEar8lhnHppqAui/FekJ/LsWk14nqXs4cYt3i75
	G5a0=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4230y4fjkp-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 08 Oct 2024 04:23:32 -0700 (PDT)
Received: from twshared17314.02.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 8 Oct 2024 11:23:26 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 5DFA378E827E; Tue,  8 Oct 2024 12:23:18 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <fstests@vger.kernel.org>
CC: <linux-btrfs@vger.kernel.org>, Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: add test for missing csums in log when doing async on subpage vol
Date: Tue, 8 Oct 2024 12:22:54 +0100
Message-ID: <20241008112302.2757404-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HnrH9_Q87_-rdaPWTPM9BdOpPAC05Zfu
X-Proofpoint-GUID: HnrH9_Q87_-rdaPWTPM9BdOpPAC05Zfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
race could mean that csums weren't getting written to the log tree,
leading to corruption when it was replayed.

The patches to detect log this tree corruption are in btrfs-progs 6.11.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 common/dmlogwrites  | 24 ++++++++++++++++++
 tests/btrfs/192     | 26 +-------------------
 tests/btrfs/333     | 59 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/333.out |  2 ++
 4 files changed, 86 insertions(+), 25 deletions(-)
 create mode 100755 tests/btrfs/333
 create mode 100644 tests/btrfs/333.out

diff --git a/common/dmlogwrites b/common/dmlogwrites
index c1c85de9..f7faf244 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -203,3 +203,27 @@ _log_writes_replay_log_range()
 		>> $seqres.full 2>&1
 	[ $? -ne 0 ] && _fail "replay failed"
 }
+
+# Replay and check each fua/flush (specified by $2) point.
+#
+# Since dm-log-writes records bio sequentially, even just replaying a ra=
nge
+# still needs to iterate all records before the end point.
+# When number of records grows, it will be unacceptably slow, thus we ne=
ed
+# to use relay-log itself to trigger fsck, avoid unnecessary seek.
+_log_writes_fast_replay_check()
+{
+	local check_point=3D$1
+	local blkdev=3D$2
+	local fsck_command=3D$3
+	local ret
+
+	[ -z "$check_point" -o -z "$blkdev" ] && _fail \
+	"check_point and blkdev must be specified for log_writes_fast_replay_ch=
eck"
+
+	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
+		--replay $blkdev --check $check_point --fsck "$fsck_command" \
+		&> $tmp.full_fsck
+	ret=3D$?
+	tail -n 150 $tmp.full_fsck >> $seqres.full
+	[ $ret -ne 0 ] && _fail "fsck failed during replay"
+}
diff --git a/tests/btrfs/192 b/tests/btrfs/192
index f7fb65b8..449f0459 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -96,30 +96,6 @@ delete_workload()
 	done
 }
=20
-# Replay and check each fua/flush (specified by $2) point.
-#
-# Since dm-log-writes records bio sequentially, even just replaying a ra=
nge
-# still needs to iterate all records before the end point.
-# When number of records grows, it will be unacceptably slow, thus we ne=
ed
-# to use relay-log itself to trigger fsck, avoid unnecessary seek.
-log_writes_fast_replay_check()
-{
-	local check_point=3D$1
-	local blkdev=3D$2
-	local fsck_command=3D"$BTRFS_UTIL_PROG check $blkdev"
-	local ret
-
-	[ -z "$check_point" -o -z "$blkdev" ] && _fail \
-	"check_point and blkdev must be specified for log_writes_fast_replay_ch=
eck"
-
-	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
-		--replay $blkdev --check $check_point --fsck "$fsck_command" \
-		&> $tmp.full_fsck
-	ret=3D$?
-	tail -n 150 $tmp.full_fsck >> $seqres.full
-	[ $ret -ne 0 ] && _fail "fsck failed during replay"
-}
-
 xattr_value=3D$(printf '%0.sX' $(seq 1 3800))
=20
 # Bumping tree height to level 2.
@@ -145,7 +121,7 @@ wait
 _log_writes_unmount
 _log_writes_remove
=20
-log_writes_fast_replay_check fua "$SCRATCH_DEV"
+_log_writes_fast_replay_check fua "$SCRATCH_DEV" "$BTRFS_UTIL_PROG check=
 $SCRATCH_DEV"
=20
 echo "Silence is golden"
=20
diff --git a/tests/btrfs/333 b/tests/btrfs/333
new file mode 100755
index 00000000..13f113ca
--- /dev/null
+++ b/tests/btrfs/333
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test 333
+#
+# Test async dio with fsync to test a bug where a race meant that csums =
weren't
+# getting written to the log tree, causing corruptions on remount. This =
can be
+# seen on subpage FSes on 6.4.
+#
+. ./common/preamble
+_begin_fstest auto quick metadata log volume
+
+_fixed_by_kernel_commit e917ff56c8e7 \
+	"btrfs: determine synchronous writers from bio or writeback control"
+
+fio_config=3D$tmp.fio
+
+. ./common/dmlogwrites
+
+_require_scratch
+_require_log_writes
+
+cat >$fio_config <<EOF
+[global]
+iodepth=3D128
+direct=3D1
+ioengine=3Dlibaio
+rw=3Drandwrite
+runtime=3D1s
+[job0]
+rw=3Drandwrite
+filename=3D$SCRATCH_MNT/file
+size=3D1g
+fdatasync=3D1
+EOF
+
+_require_fio $fio_config
+
+cat $fio_config >> $seqres.full
+
+_log_writes_init $SCRATCH_DEV
+_log_writes_mkfs >> $seqres.full 2>&1
+_log_writes_mark mkfs
+
+_log_writes_mount
+
+$FIO_PROG $fio_config > /dev/null 2>&1
+_log_writes_unmount
+
+_log_writes_remove
+_log_writes_replay_log mkfs $SCRATCH_DEV
+
+_log_writes_fast_replay_check fua "$SCRATCH_DEV" "$BTRFS_UTIL_PROG check=
 $SCRATCH_DEV"
+
+echo "Silence is golden"
+
+# success, all done
+status=3D0
+exit
diff --git a/tests/btrfs/333.out b/tests/btrfs/333.out
new file mode 100644
index 00000000..60a15898
--- /dev/null
+++ b/tests/btrfs/333.out
@@ -0,0 +1,2 @@
+QA output created by 333
+Silence is golden
--=20
2.44.2


