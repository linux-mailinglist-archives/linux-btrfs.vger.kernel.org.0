Return-Path: <linux-btrfs+bounces-11031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56791A1854D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 19:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C217A2571
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2011F5433;
	Tue, 21 Jan 2025 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N9kHAi2m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E2185920
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484679; cv=none; b=uizzXlKwxC4vSWrVhK+nKPi59dLyYlY+7yhnHwG4qnBXzqy8rUEsPK8/lREEFS62lRpQEgq+Jtp4mzh/fSmCCfn9cHfiVDgcBgsbxDXW1GxALOFm8S85MeZie+e83GG0bKf3vlsDhTZWzduzBfigMqux9xX2dMV8HC4z+GWYCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484679; c=relaxed/simple;
	bh=aqvpSFNS2oyFZ6wFz3FOaP93hHL2DM6b0WAObBfsmTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtsQIYEsps/PgCHvAWVVtCLqg/WlN/BbeIBqtliqUAsgrKtj+SDB4jV7U7lYnp1yXGxD/tWiH2v+I3ab2tFQ2IbvRbp+Svluug3urlh8GqAsU2Y2PwwqDAtye/2BLhveYFuQaHg3A5fjkYpLInfZJFrYF60KhH7w4Ooy3V/iqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=N9kHAi2m; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LIaTsW002352
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 10:37:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=zu4oZmQ4vRA5XeybXIGkJg4
	b5T/lfozWqHVFHwAU8cM=; b=N9kHAi2mF44/Hm/mivY5s3pFUC5tLWXSPZb04h+
	nMOr+anaAYrWqojmwQJV365wljQ+ffr9KSoxlGtHGQcCS6PAB4RGjPVfj+zf3OFV
	irwBH/MIYal/pCmS3zW0KJIt5PpmMED5ZSp5T01Mh5jumLAVVm57Q9XMVoUV9q/A
	uvZ4=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44afgr0xab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 10:37:56 -0800 (PST)
Received: from twshared46479.39.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 21 Jan 2025 18:37:55 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id A6B32AB49779; Tue, 21 Jan 2025 18:37:53 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
Date: Tue, 21 Jan 2025 18:36:53 +0000
Message-ID: <20250121183751.201556-1-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: bjveXeH3xxmdl79saptx6MT4y-eas469
X-Proofpoint-GUID: bjveXeH3xxmdl79saptx6MT4y-eas469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01

For O_DIRECT reads and writes, both the buffer address and the file offse=
t
need to be aligned to the block size. Otherwise, btrfs falls back to
doing buffered I/O, which is probably not what you want. It also creates
portability issues, as not all filesystems do this.

Add a new sysfs entry io_stats, to record how many times DIO falls back
to doing buffered I/O. The intention is that once this is recorded, we
can investigate the programs running on any machine where this isn't 0.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/direct-io.c |  6 ++++++
 fs/btrfs/file.c      |  9 +++++++++
 fs/btrfs/fs.h        |  8 ++++++++
 fs/btrfs/sysfs.c     | 15 +++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 8567af46e16f..d388acf10f47 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -946,6 +946,12 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struc=
t iov_iter *from)
 		goto out;
 	}
=20
+	/*
+	 * We're falling back to buffered writes, increase the
+	 * dio_write_fallback counter.
+	 */
+	atomic_inc(&fs_info->io_stats.dio_write_fallback);
+
 	pos =3D iocb->ki_pos;
 	written_buffered =3D btrfs_buffered_write(iocb, from);
 	if (written_buffered < 0) {
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 36f51c311bb1..f74091482cb6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3644,10 +3644,19 @@ static ssize_t btrfs_file_read_iter(struct kiocb =
*iocb, struct iov_iter *to)
 	ssize_t ret =3D 0;
=20
 	if (iocb->ki_flags & IOCB_DIRECT) {
+		struct btrfs_fs_info *fs_info;
+
 		ret =3D btrfs_direct_read(iocb, to);
 		if (ret < 0 || !iov_iter_count(to) ||
 		    iocb->ki_pos >=3D i_size_read(file_inode(iocb->ki_filp)))
 			return ret;
+
+		/*
+		 * We're falling back to buffered reads, increase the
+		 * dio_read_fallback counter.
+		 */
+		fs_info =3D BTRFS_I(iocb->ki_filp->f_inode)->root->fs_info;
+		atomic_inc(&fs_info->io_stats.dio_read_fallback);
 	}
=20
 	return filemap_read(iocb, to, ret);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b572d6b9730b..e659fb12cae6 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -406,6 +406,12 @@ struct btrfs_commit_stats {
 	u64 total_commit_dur;
 };
=20
+/* Store data about I/O stats, exported via sysfs. */
+struct btrfs_io_stats {
+	atomic_t dio_read_fallback;
+	atomic_t dio_write_fallback;
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -851,6 +857,8 @@ struct btrfs_fs_info {
 	/* Updates are not protected by any lock */
 	struct btrfs_commit_stats commit_stats;
=20
+	struct btrfs_io_stats io_stats;
+
 	/*
 	 * Last generation where we dropped a non-relocation root.
 	 * Use btrfs_set_last_root_drop_gen() and btrfs_get_last_root_drop_gen(=
)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 53b846d99ece..4dc772bc7e7b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1526,6 +1526,20 @@ static ssize_t btrfs_bg_reclaim_threshold_store(st=
ruct kobject *kobj,
 BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
 	      btrfs_bg_reclaim_threshold_store);
=20
+static ssize_t btrfs_io_stats_show(struct kobject *kobj,
+				   struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
+
+	return sysfs_emit(buf,
+			"dio_read_fallback %u\n"
+			"dio_write_fallback %u\n",
+			atomic_read(&fs_info->io_stats.dio_read_fallback),
+			atomic_read(&fs_info->io_stats.dio_write_fallback));
+}
+
+BTRFS_ATTR(, io_stats, btrfs_io_stats_show);
+
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 static ssize_t btrfs_offload_csum_show(struct kobject *kobj,
 				       struct kobj_attribute *a, char *buf)
@@ -1586,6 +1600,7 @@ static const struct attribute *btrfs_attrs[] =3D {
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
 	BTRFS_ATTR_PTR(, temp_fsid),
+	BTRFS_ATTR_PTR(, io_stats),
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_ATTR_PTR(, offload_csum),
 #endif
--=20
2.45.2


