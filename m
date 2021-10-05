Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9C421ECF
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhJEGZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:25:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61147 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhJEGZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633415009; x=1664951009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0stDaJyqrlnljh3g28efsfKMlgZ1scXXQJ6Tjh6+ao8=;
  b=VIBUXkct2BWlukiu0cH5U5c7+s4NMC3avGUduApKt2ObNrkm8C9XW5dm
   uTaFOeX6Y27Cg0ntHsHhdM+jkgc44yokqebts4sxFgClhPVHJl/EWJGfl
   +Weka+IBN824gkVGAV5jZ0uD2eBA+/6IBLlcAhAxrD6kCz+ZXcwPy3qzc
   NcuQ1dx5AJxnUsduaVq3LtYKixs+C0M4NHpeC0qsImu8PU6UqUKrPmNqe
   R/iKvUtgOnCjqZehhq/EZ2SIGce0nuH2tf3nIJUl//boG8YIlhC5kGVlv
   RHYY+us14mbB7Qo0px8ufmhRDNC94W8O6uaj089Stpt1czSXkIlncNLWB
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,347,1624291200"; 
   d="scan'208";a="186648911"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2021 14:23:29 +0800
IronPort-SDR: t9OSMgBMCgPKDjEPPOLRIhMpIr2EBuTMBLVanVA6wnh7K7tnnOBOqn7kIg/6ff64/Amwrkd9rh
 LUksJ1mIPcAAseBb37H801ek/56kU7taAWTc2aoBisyryFz98t/Oj0uqitokeDQ+qVp2VebTcH
 VBrSlEbNboF1U1OT0j+L1e7rjJAuxA3l/y0BZVZ87s0SyWOBX8c9/PFgMJj6M7+uyqEN6GlSR1
 eIrAq2Yl2ImLhSiba6M9WZeWJ7GiKRR7E/bUoKZK5GTXs07AwyDsW3Cnwy6zJ9r8jKQUQQxCFp
 2Sh5VhIvZqLShSVHR6csK60H
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 22:57:53 -0700
IronPort-SDR: IRQUFgtdG2oaxyh1ypeQKFS7ZbqR+q73tuHKzBDDKvOY1QNRnIS5we2PD07CLE6usnGudlBG7l
 iQrWCPoVe5KNleRyNFzIhDi0hWlaCC4NdTmx7clwF4VIitUmYPQkoJTyUB5cetuoh3vw19r6+y
 AnNz9XulObpAl3+x3XMZxGjzjSeqR7seNum0V9QuZDYYkKdEN+v56N5sY/MB0YVyto9Qtz1JN/
 UOvchCDB89FC+6RSOdwzjGgdvZqYRwmezftxrgvZNzsl9se+SzUkwpUINb3Fyz36PiQ50Ytk2B
 3ZI=
WDCIronportException: Internal
Received: from g8961f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2021 23:23:29 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/7] btrfs-progs: set eb->fs_info properly
Date:   Tue,  5 Oct 2021 15:23:00 +0900
Message-Id: <20211005062305.549871-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005062305.549871-1-naohiro.aota@wdc.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several extent_buffer initialization misses fs_info setting. This is OK
before the following patch ("btrfs-progs: use direct-io for zoned device")
as eb->fs_info is not always necessary. But, after that patch, we will use
fs_info to determine it is zoned or not and that causes segfault in such
cases.

Properly set fs_info when initializing extent_buffers to fix the issue.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 convert/main.c          | 1 +
 kernel-shared/volumes.c | 2 ++
 mkfs/rootdir.c          | 1 +
 3 files changed, 4 insertions(+)

diff --git a/convert/main.c b/convert/main.c
index b705946b1312..223eebad2e72 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -397,6 +397,7 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 		}
 		eb->start = key.objectid;
 		eb->len = key.offset;
+		eb->fs_info = root->fs_info;
 
 		/* Write the data */
 		ret = write_and_map_eb(root->fs_info, eb);
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index b2a6b04f8e3d..2ef2a8618d1f 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2567,6 +2567,7 @@ static int split_eb_for_raid56(struct btrfs_fs_info *info,
 		eb->flags = 0;
 		eb->fd = -1;
 		eb->dev_bytenr = (u64)-1;
+		eb->fs_info = info;
 
 		this_eb_start = raid_map[i];
 
@@ -2638,6 +2639,7 @@ int write_raid56_with_parity(struct btrfs_fs_info *info,
 		new_eb->fd = multi->stripes[i].dev->fd;
 		multi->stripes[i].dev->total_ios++;
 		new_eb->len = stripe_len;
+		new_eb->fs_info = info;
 
 		if (raid_map[i] == BTRFS_RAID5_P_STRIPE)
 			p_eb = new_eb;
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index c2e14daf6663..16ff257ac408 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -397,6 +397,7 @@ again:
 
 		eb->start = first_block + bytes_read;
 		eb->len = sectorsize;
+		eb->fs_info = root->fs_info;
 
 		/*
 		 * we're doing the csum before we record the extent, but
-- 
2.33.0

