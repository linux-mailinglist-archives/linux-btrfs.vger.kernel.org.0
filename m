Return-Path: <linux-btrfs+bounces-9728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989E99CF0B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AEF1F2AB67
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C001E104C;
	Fri, 15 Nov 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AoYYPuxL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71C1E103B
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685785; cv=none; b=OFBiqaZzs7sFnO6ifFnL/xF6O45axWosng2W02s6AHp9Bq4gqiSrfOoCH2drdk3QmGmKVgNOwWOh+oUaCMe/5usBr9W6BqLz0xAHpynRwt7W7jRkW9DpdwQLq1kHHX2trAWZFHOUTT6pZbVKo1ZWuyBqiVA3xdNq4K3fPhG2+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685785; c=relaxed/simple;
	bh=ph4w429BD1ycyH1RPeP3LgUvoo3aLJjycvjX7xDjfCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rwZ4MIWBpXxnPG/HSI2LXKrs4DNYwjnYMDLQafcyGThO/umSQzlBTRRQ8SUoqJGEtMZDEsjthUqT2bdBe+YehJ4S74U8pHge2lcB8XpghwA+lCxHmlej0nPZGm1YtEinJywan268nLBWSxqzaCXd4n9AxogCEShzBMBiF1zNl5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=AoYYPuxL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEMjAC008027
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:49:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=CQRVVCQCdcPeBYozSf90X2D
	78Qj0uWQTPc6kSveM6lg=; b=AoYYPuxL5wQlQ/KnqXCpkgC7rdZdT/+IPH/VMCx
	1R+LLuUVdALfAA80omBEH/U8+Ei4t8FqGGEHPiUNekzCS4osJBl9jYKGPQivBhXF
	Murl+JBISftEokUTdFOSgCqauwOE8AE3dqUhzViV2kjDx9s7VXeEaILT0XD9Wz7p
	w5Rw=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42x6cmh7yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:49:43 -0800 (PST)
Received: from twshared25495.03.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 15 Nov 2024 15:49:42 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id C781C8AC4461; Fri, 15 Nov 2024 15:49:28 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>,
        Johannes Thumshirn
	<johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: fix lockdep warnings on io_uring encoded reads
Date: Fri, 15 Nov 2024 15:49:17 +0000
Message-ID: <20241115154925.1175086-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: ND3Riyzmk4KGYs2eFsp_GkSsFlIh4k_9
X-Proofpoint-ORIG-GUID: ND3Riyzmk4KGYs2eFsp_GkSsFlIh4k_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Lockdep doesn't like the fact that btrfs_uring_read_extent() returns to
userspace still holding the inode lock, even though we release it once
the I/O finishes. Add calls to rwsem_release() and rwsem_acquire_read() t=
o
work round this.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changelog:
v2: Add btrfs_lockdep_inode_acquire and btrfs_lockdep_inode_release
helpers, and remove unneeded CONFIG_DEBUG_LOCK_ALLOC #ifdefs.

 fs/btrfs/ioctl.c   | 10 ++++++++++
 fs/btrfs/locking.h | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1fdeb216bf6c..f8680e7cc974 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4752,6 +4752,9 @@ static void btrfs_uring_read_finished(struct io_uri=
ng_cmd *cmd, unsigned int iss
 	size_t page_offset;
 	ssize_t ret;
=20
+	/* The inode lock has already been acquired in btrfs_uring_read_extent.=
  */
+	btrfs_lockdep_inode_acquire(inode, i_rwsem);
+
 	if (priv->err) {
 		ret =3D priv->err;
 		goto out;
@@ -4860,6 +4863,13 @@ static int btrfs_uring_read_extent(struct kiocb *i=
ocb, struct iov_iter *iter,
 	 * and inode and freeing the allocations.
 	 */
=20
+	/*
+	 * We're returning to userspace with the inode lock held, and that's
+	 * okay - it'll get unlocked in a worker thread.  Call
+	 * btrfs_lockdep_inode_release() to avoid confusing lockdep.
+	 */
+	btrfs_lockdep_inode_release(inode, i_rwsem);
+
 	return -EIOCBQUEUED;
=20
 out_fail:
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 46c8be2afab1..35036b151bf5 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -128,6 +128,16 @@ enum btrfs_lockdep_trans_states {
 #define btrfs_lockdep_release(owner, lock)					\
 	rwsem_release(&owner->lock##_map, _THIS_IP_)
=20
+/*
+ * Used to account for the fact that when doing io_uring encoded I/O, we=
 can
+ * return to userspace with the inode lock still held.
+ */
+#define btrfs_lockdep_inode_acquire(owner, lock)				\
+	rwsem_acquire_read(&owner->vfs_inode.lock.dep_map, 0, 0, _THIS_IP_)
+
+#define btrfs_lockdep_inode_release(owner, lock)				\
+	rwsem_release(&owner->vfs_inode.lock.dep_map, _THIS_IP_)
+
 /*
  * Macros for the transaction states wait events, similar to the generic=
 wait
  * event macros.
--=20
2.45.2


