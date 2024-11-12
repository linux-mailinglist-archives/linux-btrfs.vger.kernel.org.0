Return-Path: <linux-btrfs+bounces-9524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C99C5CC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 17:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893EC282895
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D967020650B;
	Tue, 12 Nov 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="q2HQ+ot9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391220262E
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427278; cv=none; b=lOpgZzQXFJ70mfqvp9oX1q1jSAk6KpFlUFACmZkb9XsasEiVI6tRMTbi6RSRSJY2KqyEzeihGXMPyycE1SgedZHAis2gH19e+01nsUU6f3GnFB8T/UAKHEB2sTcQy1ISc4V90UtduLg+tyUx+Jp1rEvVH/dpadPnamvK0mvFF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427278; c=relaxed/simple;
	bh=HTPZOHKYxzXhZGWt9rW1OUy3iZOFY1V4N1uQTkhOzYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YnmT5ozfnATDicvl8bKZ0dLCb3Vw6Izkgs9YMB0dYwtW8Zt30vk0mfSs4AFc2F5MD86hdvHQpCxwFeDIHhDcmmzcF5X1+KymCV1tki0l4sOvz9/2FdPEfKdGsYnfnibPJJMValY99PjnWJJjAPyDehDXECf3y3Y2Ad8J2loz5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=q2HQ+ot9; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACB1ure032070
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 08:01:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=asJdRrPZFJjALEEdjXTmRr/
	jWZb1HN05yvTTx7UPX8Q=; b=q2HQ+ot9o4seoITwkNKIS+FGT6b8GpIzC536JCX
	DTasTziysEWQdPfLZmGzmlkqIh9JfiPI2rMYQ/DQE+mkblyb+kgYMzATluknNJm8
	Ivwg9vRJOW4ybYy8EWMaLWl1+ax+L0aRv6tgn1qPlD/AUzW792KRz5U/zGyHvUBX
	t9B8=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42v5sea2pf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 08:01:14 -0800 (PST)
Received: from twshared13460.05.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 12 Nov 2024 16:01:14 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id B54848964BC1; Tue, 12 Nov 2024 16:01:01 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>,
        Johannes Thumshirn
	<johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Date: Tue, 12 Nov 2024 16:00:49 +0000
Message-ID: <20241112160055.1829361-1-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: nMS5x32ofcs1Y7h2jc7ZhHPU4szxoOi9
X-Proofpoint-GUID: nMS5x32ofcs1Y7h2jc7ZhHPU4szxoOi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

Lockdep doesn't like the fact that btrfs_uring_read_extent() returns to
userspace still holding the inode lock, even though we release it once
the I/O finishes. Add calls to rwsem_release() and rwsem_acquire_read() t=
o
work round this.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ioctl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1fdeb216bf6c..6ea01e4f940e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4752,6 +4752,11 @@ static void btrfs_uring_read_finished(struct io_ur=
ing_cmd *cmd, unsigned int iss
 	size_t page_offset;
 	ssize_t ret;
=20
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/* The inode lock has already been acquired in btrfs_uring_read_extent.=
  */
+	rwsem_acquire_read(&inode->vfs_inode.i_rwsem.dep_map, 0, 0, _THIS_IP_);
+#endif
+
 	if (priv->err) {
 		ret =3D priv->err;
 		goto out;
@@ -4860,6 +4865,15 @@ static int btrfs_uring_read_extent(struct kiocb *i=
ocb, struct iov_iter *iter,
 	 * and inode and freeing the allocations.
 	 */
=20
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/*
+	 * We're returning to userspace with the inode lock held, and that's
+	 * okay - it'll get unlocked in a kthread.  Call rwsem_release to
+	 * avoid confusing lockdep.
+	 */
+	rwsem_release(&inode->vfs_inode.i_rwsem.dep_map, _THIS_IP_);
+#endif
+
 	return -EIOCBQUEUED;
=20
 out_fail:
--=20
2.45.2


