Return-Path: <linux-btrfs+bounces-20334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C64D0A144
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 13:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 854B1301D4A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32435B12B;
	Fri,  9 Jan 2026 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GZ2f7/oc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1532572F;
	Fri,  9 Jan 2026 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963420; cv=none; b=Obf4AR8V9viHODEDnzVcG5Co4CJ/0s8T3n4BJbOApsxsve4HEHVxdcn+teFWZlv7SyReEpiZ53Jn8RwEAJvM3CYAZnN525SDMcam3YSbAwl/4hiiQhGRmyZT0DAvTTks70b0SE9eid0b9KOfVWGt8Hj2UmMSX1NA6fUrpOJNwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963420; c=relaxed/simple;
	bh=3nu36tbY8u4DraqT7/qo1MR2c9zYL3m5G14G+tjdYLc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KQvxIp01N1YfDOas56Tk5EXW1Mfg1tho2ttsJBdOZNCm5CH8yXBPazKVeT1oGVDyPEOf9sP+LcxpylLPMm5czEHVx5CawzBdgWs4rz+Nd1JjsD7VCMqMgEPGl1qHTyfUko5k9r5vgpEP4cHvfPGWk27NGdXjQCJ/C2jIR78zjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GZ2f7/oc; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767963412; bh=Bp8myDrLbM52r/qKYcZaXxFmEJ1b8I6IcEwo4TWqsVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZ2f7/ocZ7hqxSZbCqdo8JXqFZKVyfeyEokDnZoos9f46qti7IKAydJqzIMZ8/55D
	 mDpmdtDJH1DeM163BlBKOwenqGbxuajfXmfvE1XDEIEh4mrJDQJiCoa+MQHAJMWkoE
	 usvf9hUZgMARaor2on5rpAM30bfjS9/L28DzyB2U=
Received: from lxu-ped-host.. ([114.244.57.24])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id E328BA9E; Fri, 09 Jan 2026 20:56:50 +0800
X-QQ-mid: xmsmtpt1767963410t0ej21fxj
Message-ID: <tencent_1B9D99764FFD8DAEA5888DF9926EDDB5DD07@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTgxBl4hzXZtMjkZsk8cyTMx6KJn31Z6rU0a7nkJhd8HxRW/Qigr
	 ULGzS9ZuatHP7LLQ7AJmMJ5zFOcWY5U+24n9z3jjTGcLJhUc2/Da42oqj3+MINaJX7Q3s3v2SKUh
	 4O8IdzvUMq0bQ7srKsS1g03RY/gm/Y8rTLnOe6h/ljNH9sgSsp0VUdlZRnOasR4U988a3YhbUryI
	 n5lt2e3EPWqSDOrlI2EeZxACpTkGEEPy3j728enpFHQ0S79DzkpLCI5CcCWeGuiqYb12EvdtRwM5
	 zsf0q9hUBM6uv09ZkPo4kv0Jn5f1JPf9rykG6bnKQc3Ww9SqrqYUX+KjmwrdvFC5dBZ4JpK3ivZn
	 vUpH3Rdrg/JzQTHt98qoPAjHsTQJ0SBIBpRwd7fdRYHOkgla08z8J/6h2WoVDEih9mhptImN1wGA
	 3hZp6gwNR/TYrRyiECYOwbaKYXcj0sSNm9OxDmOplw1EOiotUngaDQrD0SBCXHT223v1V7hUhtfl
	 D8t2Vk4cFkzotEUtm2dKrgoYLPatK7Nk5WCXe7SrU5vRV7B3d+iPXRqB7lq6ZVqaowiqgu5FfMC3
	 hQ+uSEdGLVKrGZSGH7Xsevw4bFcw379D4WW/SaFqOOiZfhT0JF0SYoqNiZRGiwQFVRBiC+1rAN1S
	 Qo7anrPq0EmttV6LCR8G7yk/nDkk9J9t6lGsxRUmbSbEfJMTlz7nsdGhgEWPCQ2oh01CPyDTzzSs
	 vP5rzmtLbrvPhLNSWuwd6H46xiwm6vGxDcGGct6HgTyi3umgZ/lfANnbTF1IiL8zlVnP+JjeiI+c
	 vuB5wKCyT4n3JLACkSN3yC7dYQvy1aGXqx4bLQABkjRwtgMZZdJVwJz+vtvCQx02T2k9LbZOtj+M
	 fXXa8e2fIwxNLYLllcfNbLutU2juimxplBE6dBQ1AwITXZpnoRCiGgIvDrRk2zR4ByPmY2Y/p9i5
	 /7HHZFNq4y33yoMluTqFJYsnUxLkirrgSqlmEV98+EJfqqvOHRLBX6iakuK59JDzDX8qaPHeGxRN
	 5Auqyph4jxDF6Eb+GLbPvjrTdekWI70h+vsBPGzw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com
Cc: clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] btrfs: Sync read disk super and set block size
Date: Fri,  9 Jan 2026 20:56:51 +0800
X-OQ-MSGID: <20260109125650.560171-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <695faa63.050a0220.1c677c.039b.GAE@google.com>
References: <695faa63.050a0220.1c677c.039b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user performs a btrfs mount, the block device is not set
correctly. The user sets the block size of the block device to 0x4000
by executing the BLKBSZSET command.
Since the block size change also changes the mapping->flags value, this
further affects the result of the mapping_min_folio_order() calculation.

Let's analyze the following two scenarios:
Scenario 1: Without executing the BLKBSZSET command, the block size is
0x1000, and mapping_min_folio_order() returns 0;

Scenario 2: After executing the BLKBSZSET command, the block size is
0x4000, and mapping_min_folio_order() returns 2.

do_read_cache_folio() allocates a folio before the BLKBSZSET command
is executed. This results in the allocated folio having an order value
of 0. Later, after BLKBSZSET is executed, the block size increases to
0x4000, and the mapping_min_folio_order() calculation result becomes 2.
This leads to two undesirable consequences:
1. filemap_add_folio() triggers a VM_BUG_ON_FOLIO(folio_order(folio) <
mapping_min_folio_order(mapping)) assertion.
2. The syzbot report [1] shows a null pointer dereference in
create_empty_buffers() due to a buffer head allocation failure.

Synchronization should be established based on the inode between the
BLKBSZSET command and read cache page to prevent inconsistencies in
block size or mapping flags before and after folio allocation.

[1]
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
RIP: 0010:create_empty_buffers+0x4d/0x480 fs/buffer.c:1694
Call Trace:
 folio_create_buffers+0x109/0x150 fs/buffer.c:1802
 block_read_full_folio+0x14c/0x850 fs/buffer.c:2403
 filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2496
 do_read_cache_folio+0x266/0x5c0 mm/filemap.c:4096
 do_read_cache_page mm/filemap.c:4162 [inline]
 read_cache_page_gfp+0x29/0x120 mm/filemap.c:4195
 btrfs_read_disk_super+0x192/0x500 fs/btrfs/volumes.c:1367
 
Reported-by: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b4a2af3000eaa84d95d5
Tested-by: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/btrfs/volumes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 13c514684cfb..eee7471a3e03 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1339,6 +1339,7 @@ struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 	struct page *page;
 	u64 bytenr, bytenr_orig;
 	struct address_space *mapping = bdev->bd_mapping;
+	struct inode *inode = mapping->host;
 	int ret;
 
 	bytenr_orig = btrfs_sb_offset(copy_num);
@@ -1364,7 +1365,9 @@ struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 				      (bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
 	}
 
+	inode_lock(inode);
 	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
+	inode_unlock(inode);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
 
-- 
2.43.0


