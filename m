Return-Path: <linux-btrfs+bounces-7071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C168494D583
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0D4282B85
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F34F5FB;
	Fri,  9 Aug 2024 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NtX3l2GE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964D16426
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224997; cv=none; b=eLM6ycABi/u0YfiuFSJ05g/iVZ0pJ7SWm8y7LODcW61sNsiqIUYrjPEl2zYw8H/APnA5KrbrBntjd4bGsbn0r3lAtflkZUzhVO9tyL5O8wCaYOstfkjSmpu/tavsg8ngIQhjqymGkvsTEJ0QkRMpYW2GDlfgEjLdBjeczINX1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224997; c=relaxed/simple;
	bh=kpLn4JF1gvuTaL6G38CAyDC6tcqcRMeZP06kI/Nm7GU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jxcm0tbLBXQTkr7xcC3NAyRnI58oLrmUk42Ub15ZOVyxmUzrDJeR9zeTixB6roFwOwR5uYYdg4OosrlRHwAb/hPGP+B99U0IU6KtOG2vS8sx0GViar1DQW4NjsrdXL/x/ff24+K6A1euGO+5aNNQLsUo2+dCV6Q2g+zLhmDDlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=NtX3l2GE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479E48PM009736
	for <linux-btrfs@vger.kernel.org>; Fri, 9 Aug 2024 10:36:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=MAsgRmE1
	SNZlqCVqjPjepVpXSzCLtPoFC/4LMM7Fifo=; b=NtX3l2GE83geYZ2BrQgpt3uY
	NAaeMhd1T0bmDv+0ZbJj/hbUvQsnrcVXBinpJH3FUZtN8MYw2+kKf27tBWhXVx1N
	OfN90hk3fWLbuodEUHhkLC5WzVCj58o9xsobQb3B9gUZp4IQzxrAl2AWXYTTvzn6
	hMQAe4mj+57t2+ZFCBA=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40wmj2hgud-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2024 10:36:34 -0700 (PDT)
Received: from twshared53332.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 9 Aug 2024 17:36:05 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 941245429456; Fri,  9 Aug 2024 18:35:54 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: add io_uring interface for encoded reads
Date: Fri, 9 Aug 2024 18:35:27 +0100
Message-ID: <20240809173552.929988-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: TJmfwv5ydPSyqeDQ-43oykD2s5c0QpcF
X-Proofpoint-ORIG-GUID: TJmfwv5ydPSyqeDQ-43oykD2s5c0QpcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_14,2024-08-07_01,2024-05-17_01

Adds an io_uring interface for asynchronous encoded reads, using the
same interface as for the ioctl. To use this you would use an SQE opcode
of IORING_OP_URING_CMD, the cmd_op would be BTRFS_IOC_ENCODED_READ, and
addr would point to the userspace address of the
btrfs_ioctl_encoded_io_args struct. As with the ioctl, you need to have
CAP_SYS_ADMIN for this to work.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/file.c  |  1 +
 fs/btrfs/ioctl.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ioctl.h |  1 +
 3 files changed, 50 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f9d76072398d..974f9e85b46e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3850,6 +3850,7 @@ const struct file_operations btrfs_file_operations =
=3D {
 	.compat_ioctl	=3D btrfs_compat_ioctl,
 #endif
 	.remap_file_range =3D btrfs_remap_file_range,
+	.uring_cmd	=3D btrfs_uring_cmd,
 };
=20
 int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end=
)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0493272a7668..8f5cc7d1429c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -29,6 +29,7 @@
 #include <linux/fileattr.h>
 #include <linux/fsverity.h>
 #include <linux/sched/xacct.h>
+#include <linux/io_uring/cmd.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "export.h"
@@ -4648,6 +4649,53 @@ static int btrfs_ioctl_encoded_write(struct file *=
file, void __user *argp, bool
 	return ret;
 }
=20
+static void btrfs_uring_encoded_read_cb(struct io_uring_cmd *cmd,
+					unsigned int issue_flags)
+{
+	int ret;
+
+	ret =3D btrfs_ioctl_encoded_read(cmd->file, (void __user *)cmd->sqe->ad=
dr,
+				       false);
+
+	io_uring_cmd_done(cmd, ret, 0, issue_flags);
+}
+
+static void btrfs_uring_encoded_read_compat_cb(struct io_uring_cmd *cmd,
+					       unsigned int issue_flags)
+{
+	int ret;
+
+	ret =3D btrfs_ioctl_encoded_read(cmd->file, (void __user *)cmd->sqe->ad=
dr,
+				       true);
+
+	io_uring_cmd_done(cmd, ret, 0, issue_flags);
+}
+
+static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd,
+				    unsigned int issue_flags)
+{
+	if (issue_flags & IO_URING_F_COMPAT)
+		io_uring_cmd_complete_in_task(cmd, btrfs_uring_encoded_read_compat_cb)=
;
+	else
+		io_uring_cmd_complete_in_task(cmd, btrfs_uring_encoded_read_cb);
+
+	return -EIOCBQUEUED;
+}
+
+int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
+{
+	switch (cmd->cmd_op) {
+	case BTRFS_IOC_ENCODED_READ:
+#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
+	case BTRFS_IOC_ENCODED_READ_32:
+#endif
+		return btrfs_uring_encoded_read(cmd, issue_flags);
+	}
+
+	io_uring_cmd_done(cmd, -EINVAL, 0, issue_flags);
+	return -EIOCBQUEUED;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index 2c5dc25ec670..33578f4b5f46 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -22,5 +22,6 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *in=
ode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 				     struct btrfs_ioctl_balance_args *bargs);
+int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
=20
 #endif
--=20
2.44.2


