Return-Path: <linux-btrfs+bounces-21156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA3VHpy1eWk0ygEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21156-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:07:08 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA909D964
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E37D630166F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 07:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32696327C05;
	Wed, 28 Jan 2026 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="JUWKPVSw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299C2F361A
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769584020; cv=none; b=hW6tZHeVx4NuKU986KA3dxyBtPJNlNri+aBn0Hi/kQU4/GGGryWdcrO+4wgrdplsOMM3L059T2yZVdmrw/WWGVlUbm2ERxyzOTgpDgXGZG1K/xu148ki1mZqtxbp77pNXGXgn50UoFF7yzvBmFPi2Mf/q9JrqjhQcdrMJMIJQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769584020; c=relaxed/simple;
	bh=+ffLp3nSWUDIPQkY7SqwQLkBCw48BX61fRmASk+6OUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqCRuLQtdJW6sc/mgJN53Bg1skwZ959hEzZQfn8NhDcH92FS2zwNR0DLB0llwt5UCkGOXVD9fNHakT6vAb2ro2LYzwg6Zc2TfVNN9i+S+oREB42c1KRvbxQg208MhJeAfhjC5QP84cLKYdBLWHWebk8g1cW3E5TJ3XzkYH00ZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=JUWKPVSw; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4f1Cxs33GkzGCgmtX;
	Wed, 28 Jan 2026 15:06:57 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1769584017; bh=+ffLp3nSWUDIPQkY7SqwQLkBCw48BX61fRmASk+6OUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JUWKPVSwISms3WvxyLwfyQ2HCRJhge1jbyJ8QwmCf8IZ7xDRwA1igU6+pVcf/Ud/9
	 wrhdys1huKV6ExFw65JAzN5K2NLsS6E5xWa7ej+WYakUfYwSFNrSlqxRgdWPUgwbjo
	 DN//opVy59SJT5X3DgGHGZPu+f5Qk6Sy08JHbYlk=
From: jinbaohong <jinbaohong@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	dsterba@suse.com,
	jinbaohong <jinbaohong@synology.com>,
	Robbie Ko <robbieko@synology.com>
Subject: [PATCH v4 3/4] btrfs: handle user interrupt properly in btrfs_trim_fs
Date: Wed, 28 Jan 2026 07:06:40 +0000
Message-Id: <20260128070641.826722-4-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128070641.826722-1-jinbaohong@synology.com>
References: <20260128070641.826722-1-jinbaohong@synology.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21156-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jinbaohong@synology.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synology.com:email,synology.com:dkim,synology.com:mid]
X-Rspamd-Queue-Id: 0BA909D964
X-Rspamd-Action: no action

When a fatal signal is pending or the process is freezing,
btrfs_trim_block_group and btrfs_trim_free_extents return -ERESTARTSYS.
Currently this is treated as a regular error: the loops continue to the
next iteration and count it as a block group or device failure.

Instead, break out of the loops immediately and return -ERESTARTSYS to
userspace without counting it as a failure. Also skip the device loop
entirely if the block group loop was interrupted.

Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: jinbaohong <jinbaohong@synology.com>
---
 fs/btrfs/extent-tree.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6c49465c0632..633c7c0f9d92 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6665,6 +6665,10 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 						     range->minlen);
 
 			trimmed += group_trimmed;
+			if (ret == -ERESTARTSYS || ret == -EINTR) {
+				btrfs_put_block_group(cache);
+				break;
+			}
 			if (ret) {
 				bg_failed++;
 				if (!bg_ret)
@@ -6679,6 +6683,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			"failed to trim %llu block group(s), first error %d",
 			bg_failed, bg_ret);
 
+	if (ret == -ERESTARTSYS || ret == -EINTR)
+		return ret;
+
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
@@ -6687,6 +6694,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
 
 		trimmed += group_trimmed;
+		if (ret == -ERESTARTSYS || ret == -EINTR)
+			break;
 		if (ret) {
 			dev_failed++;
 			if (!dev_ret)
@@ -6701,6 +6710,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			"failed to trim %llu device(s), first error %d",
 			dev_failed, dev_ret);
 	range->len = trimmed;
+	if (ret == -ERESTARTSYS || ret == -EINTR)
+		return ret;
 	if (bg_ret)
 		return bg_ret;
 	return dev_ret;
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

