Return-Path: <linux-btrfs+bounces-8935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EABF99F199
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 17:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64261F2881C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8711F6667;
	Tue, 15 Oct 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ptDULMFY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72171DD0C6
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006820; cv=none; b=GT26EVjy/pXvhyATbu2BCKfkl9spTP0KUwien3ovs3W8epJsmMcnUYTtpimexFHsmz6u2tHWFrAFUK3T1FJcCafhmAh/l8eFMXBswJhAAcyweSSu6boCIJVB56HqLTJNLkjy29gB5jOMaMDVnv5beIHjZKl9oEgAWMmh92CP8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006820; c=relaxed/simple;
	bh=FIAo2FZnf+jMUWY1k7tNvETVogNml5yD+U8nYEnwKW0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hm9je3sus5DitttmBschy8TmHnAXi2lRaMN67x348WVfYqcktVd9roBON371tgDepAswA3vKzd5gYHXds0Pt2X7QR7z7D0J53LUrpNwEwgJ5iPxvKhpEuLsQdYSseDPsxTo/925JoCIu+V2N3jdXYvXoxgFs4Kz+VDnRWsvzT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=ptDULMFY; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FFbU2a001904
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 08:40:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=gxKGweHK8S1gipBA8mthXkn
	uQQgOKNqCgLyIDgW2Nl8=; b=ptDULMFY5DIIdDRsV8pKehGDlDXyR4px1vZO0VI
	5/ql3JRPx/1AzK7X1m9U66udnyCBzYceyoIQVEcI2WtaBo3JBEhb2lsu4+FewcDG
	sVgR3VaslbaCwiJxFO+hReAd4bfmqNkWDEsNVKlMcnjrOvv+anu+urf4DmYzR6mN
	8Jbg=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 427re71hbb-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 08:40:17 -0700 (PDT)
Received: from twshared16035.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 15 Oct 2024 15:40:16 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id DB5EA7CAA648; Tue, 15 Oct 2024 16:40:05 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <fstests@vger.kernel.org>, <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] generic: add test for missing btrfs csums in log when doing async on subpage vol
Date: Tue, 15 Oct 2024 16:39:34 +0100
Message-ID: <20241015153957.2099812-1-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: wd4ux-OgiFkdyGiAr1p65_3yOlF2lPro
X-Proofpoint-GUID: wd4ux-OgiFkdyGiAr1p65_3yOlF2lPro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
race could mean that csums weren't getting written to the log tree,
leading to corruption when it was replayed.

The patches to detect log this tree corruption are in btrfs-progs 6.11.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
This is a genericized version of the test I originally proposed as
btrfs/333.

 tests/generic/757     | 71 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/757.out |  2 ++
 2 files changed, 73 insertions(+)
 create mode 100755 tests/generic/757
 create mode 100644 tests/generic/757.out

diff --git a/tests/generic/757 b/tests/generic/757
new file mode 100755
index 00000000..6ad3d01e
--- /dev/null
+++ b/tests/generic/757
@@ -0,0 +1,71 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test 757
+#
+# Test async dio with fsync to test a btrfs bug where a race meant that =
csums
+# weren't getting written to the log tree, causing corruptions on remoun=
t.
+# This can be seen on subpage FSes on Linux 6.4.
+#
+. ./common/preamble
+_begin_fstest auto quick metadata log recoveryloop
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
+
+prev=3D$(_log_writes_mark_to_entry_number mkfs)
+[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
+cur=3D$(_log_writes_find_next_fua $prev)
+[ -z "$cur" ] && _fail "failed to locate next FUA write"
+
+while [ ! -z "$cur" ]; do
+	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
+
+	_check_scratch_fs
+
+	prev=3D$cur
+	cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
+	[ -z "$cur" ] && break
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=3D0
+exit
diff --git a/tests/generic/757.out b/tests/generic/757.out
new file mode 100644
index 00000000..dfbc8094
--- /dev/null
+++ b/tests/generic/757.out
@@ -0,0 +1,2 @@
+QA output created by 757
+Silence is golden
--=20
2.44.2


