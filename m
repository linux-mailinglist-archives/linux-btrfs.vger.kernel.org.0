Return-Path: <linux-btrfs+bounces-20335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E8D0A2EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 14:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C7843052A5E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6035C1BF;
	Fri,  9 Jan 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="v5oNG/1D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406631D750;
	Fri,  9 Jan 2026 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963731; cv=none; b=ahnS1DZ7cq0b2pJhFQz365A2kaSYA/pHLxLYIJPALm5YuuSXW0OZWjO/JdJKmxSj//OLwKTxsQQCTUJ3QrTnGJXV9knt0wLVS7IY86GcaCw1gmkMq8efaygCpO3195UB4P8dQqa+KDDehdna8DeOaJowF5IE+B1kckxBurwVZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963731; c=relaxed/simple;
	bh=+7PY/KVDj8uK+lZkZ47j3ad3MAbH5d8pEFNezE5WBjY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JLF+oBEZ1MsScbLzIq3QfIwndGc05GiiOlWrAqR6N0jwre+8zWI+iZ7Qvz0PRtKkejLAWMAjG3xcsGeWYj4aIstO0te0iZGNB4P5tM9dm2JaTlwlxD/HSxbVOuKg5cjpz2v29a7Nt4n++j1b3SrSZJkfqvTVyjgM6HgVlcRpS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=v5oNG/1D; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767963724; bh=D3l/sfnWxsH5xrdnd6Prr0ITRMzRQ082UEvLFyDJRLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v5oNG/1DaSieX5YzZq3l7lMqGaakha5m3xPyQwEH2ef8TN7pKd3WOG9wT7I/PYlAt
	 uZFqLnckIdkfPoTb9zOVgPOXPp9POB61WBvOxYvs5aICG4mlGQLuoEmlk5fBFUlvWv
	 O74wyFZS86fiWRj71iZR9xH6mDboogeRGJYCDFac=
Received: from lxu-ped-host.. ([114.244.57.24])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 82284E3; Fri, 09 Jan 2026 21:02:02 +0800
X-QQ-mid: xmsmtpt1767963722t34e1qj1z
Message-ID: <tencent_A63C4B6C74A576F566AA3C0B37CE96AC3609@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoetqGaC8ciTZpZp5nNI0wvJdXZMFpxDGw9IGmxYs+qhOFpwjAidB
	 jnFe7IUj7MpaMNaZsnnIlRRayrVKKW3P423z1rDCNH+nwv8YH5RiIXPyD31DVU+2wduC9fWhadPK
	 GgvQ8hJ7W0KjnuRvTgQ8TgFT30AXgs6gDCYf6uU979G5LmLud9WilRErWXSpeZ1eiQmxw7YRd0XV
	 Djn8dsNgPZiV1CgcAnb0ESvzSjULjyhNphjCw/HGZLTWo4jW+rY7hFFYZKMLDqi3th42wSw4/y6d
	 X3tKm01QcILUpv3IEAizfKyA6zjVVHcXEXylxahMEVpyOmuo4Wu/xXJlleVcCWLe/MlvtacsewVc
	 580MlMKrTHzH+dFLqrrxEmro6j+iiV/Zsozxh06jC3//Fef2qZbwx73xbSFj20hefDvdteoOqcu7
	 ipgdHy5SwXBvDG4GUsgIhU5ViK+Z8M8/Y0SYEc+j3ZdeM20ZLhIkMq+yivcuR7UqmyNrcfjjv37p
	 vLSie6lo715xjwROGdm8Q/MCy2ff9HawVDeA1YnVvYfr+XZaLYtcy7QoTDlS/ggLPMei4lCzeF2d
	 LIXs8wYVPpeTKPoFPp25yASWbAhK7fE9w/c7pE3IeZ/ETM6hRmf5Zc0rLpMlNmeT8F+EliLVIFD+
	 uvHh0hwJzlc0s3qYHEEsMPmsM1kG+LNGds91+ZLN+iJEIpHn363kTzQODWt/6Y/wotJ1B03rTiE2
	 vybTIAP0ZAttAwEfaLASU0Jq2cdgxgfhekDI8b+eo8hl68zdGBJ+E3qwy5yp9JFEOewzAKLsgseS
	 eLhT4xC+oj/fGnbJcG79HmNR4Uly/d/fUUB4zYtNsaYAEEboBgGMGGy+9svrQ/3fyBynrPLk++lZ
	 exKs94rbsDVv8kPxee+nGlGpx8/0U9+MRNe7DQYQlVcwgJpoj7zW16+VcTRKO3ZfCxyYhiTfsnd5
	 kpoqnFfBeWF/igyohGROYKaB/WfX8kEnxVa3yL455RL/x/Lrqj2f/IdP/W7XPfWc5JbKMEtnfdoW
	 Nl7uXxCIfb8uFmHTbVq5r4PnX+gPBkkmdyObyxi9BydGlr47TsU8MH7DycKHIxKIoykbo1cA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Edward Adam Davis <eadavis@qq.com>
To: fdmanana@kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	eadavis@qq.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] btrfs: Sync read disk super and set block size
Date: Fri,  9 Jan 2026 21:02:02 +0800
X-OQ-MSGID: <20260109130201.560996-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAL3q7H4k3Dj9gQQhBz_eadnRUaWaNPaf7+MYucshY6cis2by5Q@mail.gmail.com>
References: <CAL3q7H4k3Dj9gQQhBz_eadnRUaWaNPaf7+MYucshY6cis2by5Q@mail.gmail.com>
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
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: replace inode lock with invalidate lock

 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 13c514684cfb..68ff166fe445 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1364,7 +1364,9 @@ struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 				      (bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
 	}
 
+	filemap_invalidate_lock(mapping);
 	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
+	filemap_invalidate_unlock(mapping);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
 
-- 
2.43.0


