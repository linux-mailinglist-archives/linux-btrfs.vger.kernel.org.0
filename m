Return-Path: <linux-btrfs+bounces-16800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F962B547E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D48E1893836
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FFF284B42;
	Fri, 12 Sep 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="Ln7QpYHR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8428507B
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669672; cv=none; b=WsXH+SOyxw84Dtt2U9eqvHeQBn6DrPvgqCrEUMh+M7TbEAcRpKaLybHLYZUZqLhVlOrOiAiURZcDT0KIc/gOdHpn93D4GThVanrnEpVMWKzcf87ZHHFvsWC+DY6DcY7MKGrtP/DPfQnpkCyJp/eo99GLxsKQedw2NRuYE9mWSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669672; c=relaxed/simple;
	bh=6tgOsZtrP4+ofRPtORvDD/4E29A3V+FnmJph46TJeXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fYrC6eknqIT/lfewvqKh6Z1mR39Gy1l9mxDKXoBydw7lBGQ0pKo49H5pw5tl7OsYp4tuIA3LZXQqU787cylnMQTLkPQU4jEEeo1wgQV5pHCCIOpGyfOcA0n3Kd2YBlgpWxBrP2vb0/Y6/n4C9wZYIqoXn6Fi49rXkeKOMuApc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=Ln7QpYHR; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-austinchang.. (unknown [10.17.211.34])
	by mail.synology.com (Postfix) with ESMTPA id 4cNTld41J6zD1PKc8;
	Fri, 12 Sep 2025 17:34:21 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1757669662; bh=6tgOsZtrP4+ofRPtORvDD/4E29A3V+FnmJph46TJeXw=;
	h=From:To:Cc:Subject:Date;
	b=Ln7QpYHRr2EJJLAlxeUcusucBKTCP30xjOYMcTaHVQyZlgIHe4poWCfysOz9ZLKWY
	 hz1H0xpP3xiLW2Alee+2+Wq5LBZ41RgriG6M9i8kEkJyevhwuS0w8J+iSRIkhi6GmB
	 ouT6JGPsarNfRxw4kDw0PU5v3a5b+u459ckTcKUs=
From: austinchang <austinchang@synology.com>
To: dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Cc: robbieko@synology.com,
	austinchang@synology.com
Subject: [PATCH] btrfs: mark dirty bit for out of bound prealloc extents
Date: Fri, 12 Sep 2025 09:34:12 +0000
Message-Id: <20250912093412.1900895-1-austinchang@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
Content-Type: text/plain

In btrfs_fallocate(), when the allocated range overlaps with a prealloc
extent and the extent starts after i_size, the range doesn't get marked
dirty in file_extent_tree.

It affects btrfs_find_contiguous_extent_bit() in
btrfs_inode_safe_disk_i_size_write() procedure and can produce wrong
on-disk i_size.

This would be reproducible since the commit
41a2ee7("btrfs: introduce per-inode file extent tree"), and became hidden
since 3d7db6e("btrfs: don't allocate file extent tree for non regular files")
stops initializing file_extent_tree. A quick example as follows:

btrfs sub cre sub1
touch sub1/file
fallocate -n -o 1359872 -l 540672 sub1/file
btrfs sub snap sub1 sub2
fallocate -n -p -o 1359872 -l 395859 sub2/file
fallocate -o 1359872 -l 395859 sub2/file
echo 3 > /proc/sys/vm/drop_caches
ls -l sub2/file

The correct size should be 1755731 instead of 1753088.

Fix by adding a call to btrfs_inode_set_file_extent_range() for such
extents.

Signed-off-by: austinchang <austinchang@synology.com>
---
 fs/btrfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 204674934..e78646389 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3209,6 +3209,11 @@ static long btrfs_fallocate(struct file *file, int mode,
 			}
 			qgroup_reserved += range_len;
 			data_space_needed += range_len;
+		} else {
+			ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
+					em->start, em->len);
+			if (ret < 0)
+				break;
 		}
 		btrfs_free_extent_map(em);
 		cur_offset = last_byte;
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

