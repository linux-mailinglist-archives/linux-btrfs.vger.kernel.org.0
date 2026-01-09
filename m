Return-Path: <linux-btrfs+bounces-20328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29423D08F75
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 12:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93D530CA958
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B43596E1;
	Fri,  9 Jan 2026 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="A1zE1AAW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192F334C28;
	Fri,  9 Jan 2026 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958654; cv=none; b=aVq9JR8IhaFLgXeFETAP+SsxWiAf6p8SBXnkSOHdufjeqJYfyBJPZOfqcSdTvylstutRfNdb09WdcB8kE8vAiCBB8Mt1FDoUQX233f833PwM53/bamNlGYAjLW0TmArQG9071LDvIaETjNJwHykOVEM6/vcxB1MdPXYlFw0f+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958654; c=relaxed/simple;
	bh=3nu36tbY8u4DraqT7/qo1MR2c9zYL3m5G14G+tjdYLc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=u+Dho6OyiqxQ09DSKEWXASPT3/nhXw3RLvZm4/42GeQI0u41py89GsdJZCsODDW6+tVGeLak5AOBeUZdoE2oWI18pWoxvtoI2tg8RFbNmoQ7BapuiaZ1c58ZchaoxHv1iuI0Fa7hDNtKshWGJMnPSSntSwkCWgtnuNXz0RWI+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=A1zE1AAW; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767958639; bh=Bp8myDrLbM52r/qKYcZaXxFmEJ1b8I6IcEwo4TWqsVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A1zE1AAWYpiqV69VhPo/dIv7MtlE7h/Anwus1he/uvfmII+pt+/K3fxyS2AJmgW+a
	 ciZpxb/qKDppoZAxov/hmESPhpwkSsgasiNnl45QldBOVV64BQGDjq16H6FFkOdXm9
	 VUCVMJ93t6OaIguOgFs922UqXz3m7REclcr6uBZQ=
Received: from lxu-ped-host.. ([114.244.57.24])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 9513F04B; Fri, 09 Jan 2026 19:37:17 +0800
X-QQ-mid: xmsmtpt1767958637tb3dkrzjy
Message-ID: <tencent_7744F7621777A6DDB366E374C97F83BEE405@qq.com>
X-QQ-XMAILINFO: M+5cKLn0wXDtrKZx0hAHaQ6ZYo/ZjDtT0Ysjtp0eI2h/LXBbtqi8b1iZWRiNCk
	 yne2NwxokbJ/+mpDIqN8USL2ZtpkVlGJNw0hWbR4tPz+mU/PVO425HYgQV3ue6xLqTjKgAjrRLFP
	 U/vIAgZaeHArAqA77NTFBiKBXhOYzXnAHjt1Pl9Afq232SXTO5BZszzGk1uxAq2LEZX7v5Nv7mcB
	 TowlOzgc0JoLD14Os36q/T4RNNoM4OqgpgDIDObRMr65ma9Ehbyn73dCs3CU5n03sHRwBrDsuZMl
	 U//QetU8t29BsXt91racfZfT3lRLvZfW4LRMg2M/05jml3GrPT7zXtAVEorzVqpAWmtis9R5F/Xo
	 PD24DVgRrYN77jYpBEsOlpBltTK10fJFu9pdenamE6Ch2lEeBJOCrOKDp396UmbaOHjfjC3O8CZf
	 2Eh0+ie7HYhvEkrCrMqV4EbnG34r/Dei5aoXRPeJCXV9pewEobnSuUeLU9xSa/cWc3L+5pTY67PS
	 fjBTr3bGrl9bw7Ewpbw3tRZDvBvoRkLmMwzfap3ukcSm9xfpaWFauk+8Vi+nxYO4VQA0iZIkUTkD
	 huDfyaAHqaDQkP4/kVIk5OTwngiK24JSz3GH8fTvB8zOhMKZZbvjPcBSLccTNSwlUyKsKwEcnPXN
	 fVHhoAUMWLyjo9zpcLq52vRdBtXPXVnjV5uPS3jiCnhWkQG4ASZGxZQuqrpZcrubarbZvXWgkvT+
	 S0yu4gkgMYOATtsUeNNUrdEU0TgoBQ6Y9UIu6JK3mhMiONQJ9prCB4gZCHxxgg+7G5ti4FH2Ov3T
	 tPHwPW4tApuxpNQ9UY61lx+wJbk4Q8dCOHq2QEPOSIwZm2tXiI6X+YaiE+4/vOdj2IjdZlqdsPUw
	 /1mCLdCIJCndWC5QQkkshRdRFJTkOzBFKqdvljsFvsKLqbfOIGajk8T53cUtfEPrbHGcBof7crjQ
	 Gf7zYu/8JnNGyos87cNhXyVBOB2nQASbvU8hV2H2BF/JqF1FxxB/cOujTHq75zJZLS7B6u4lQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com
Cc: clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] btrfs: Sync read disk supper and set block size
Date: Fri,  9 Jan 2026 19:37:17 +0800
X-OQ-MSGID: <20260109113716.556380-2-eadavis@qq.com>
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


