Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E90941620F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbhIWPau (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 11:30:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12159 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbhIWPau (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 11:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632410959; x=1663946959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h6jTBGBjErUjGjwFeB+xCIbPanLK6jeqayGda2fhjZM=;
  b=L3DXw7QWRuVuJIBmU+Q9BLuydkUJGeRGpbglmebH3ai7XkLrCIkN5CmK
   /wy5OJbbgfsumtW1HGcwXcGOfFJEEoutsZyOZQNOXixgeUSc1TLxGsGGI
   FXHOKgISUOa33676aBYECBBmeJ1jCtKUuBdX8c1cBhoxfrL7Xtgkya5vg
   cJOMPq4d3n5+05QKobW0IHDK9gCXZ4PtXFbHhE1e/6ZLNxVycbyzr2d35
   E1RsGM5watUbFz8QmGaPoDQqYzC3GN6qmX29JP3ekNCyvpO9k22hMNzzP
   7qtzvIbR0UDZsQn13omvWI0u8ShHhiGWx822kcTORtmNzkwJNTmQsVCZ8
   w==;
X-IronPort-AV: E=Sophos;i="5.85,316,1624291200"; 
   d="scan'208";a="181281422"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2021 23:29:19 +0800
IronPort-SDR: cg8QUWh7SBwk5Xq1JapBsxq+UD1FkPLsItxN8Zkpy5DG7J0XRqQ9zKl3iY8FL6JBS4YIxahOlC
 d/FJmRkecHcAKnFnbxv3NWJRVTl6dEM+RIQCdkPvwQuwIxHwkPjIEVmsxvLEvbiRPVBLpv7ChH
 hOnIMCFdk52O20VaXi1iajucUKvFIR3wKiXIIEqikes2PHXL314IBO90tn2n741rgMk0SXansU
 gjqU719VYL1KFrzFVIQZM9txg8pVBV8bXsNDTGZ4Yz6ENb+pdcU8XBnsRetToR0O48P+/FT1SD
 XAMhgWHt8+1HxPgVTe6vjPIo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 08:05:29 -0700
IronPort-SDR: ekbJ6W30LmHQ9nQTnCHKlu7WbO/WxXy+LpBhb/I9T8kl+E+IDFNRbBa6HkimBRnz4CCKWXGPO/
 q1iC7BQ3t3NbCGEAf9nKM6fHDptROYaZ8mfmbghu/VXhT7Lamr28h06ZyAk+Rs+2+7W7iW94g8
 pbXXVwp8HXY6FUybAPDOxTRkw087sba+ae8zYLRoHrK7jB4hKV1x9xSkNDBd6n35UoUAlqu8SD
 uzRRP2IHaa2KV7QqhrdwVoo85/unEswb3nMKh8VVzIf0NaNQKHLYuHpXpz9vp7cPUkTdJoMpRE
 5eM=
WDCIronportException: Internal
Received: from drry1z2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.120])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Sep 2021 08:29:17 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCH] btrfs-progs: properly format btrfs_header in btrfs_create_root()
Date:   Fri, 24 Sep 2021 00:29:11 +0900
Message-Id: <20210923152911.359451-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enabling quota on zoned btrfs hits the following ASSERT().

    $ mkfs.btrfs -f -d single -m single -R quota /dev/nullb0
    btrfs-progs v5.11
    See http://btrfs.wiki.kernel.org for more information.

    Zoned: /dev/nullb0: host-managed device detected, setting zoned feature
    Resetting device zones /dev/nullb0 (1600 zones) ...
    bad tree block 25395200, bytenr mismatch, want=25395200, have=0
    kernel-shared/disk-io.c:549: write_tree_block: BUG_ON `1` triggered, value 1
    ./mkfs.btrfs(+0x26aaa)[0x564d1a7ccaaa]
    ./mkfs.btrfs(write_tree_block+0xb8)[0x564d1a7cee29]
    ./mkfs.btrfs(__commit_transaction+0x91)[0x564d1a7e3740]
    ./mkfs.btrfs(btrfs_commit_transaction+0x135)[0x564d1a7e39aa]
    ./mkfs.btrfs(main+0x1fe9)[0x564d1a7b442a]
    /lib64/libc.so.6(__libc_start_main+0xcd)[0x7f36377d37fd]
    ./mkfs.btrfs(_start+0x2a)[0x564d1a7b1fda]
    zsh: IOT instruction  sudo ./mkfs.btrfs -f -d single -m single -R quota /dev/nullb0

The issue occur because btrfs_create_root() is not formatting the root node
properly. This is fine on regular btrfs, because it's fortunately reusing
an once freed buffer. As the previous tree node allocation kindly formatted
the header, it will see the proper bytenr and pass the checks.

However, we never reuse an once freed buffer on zoned btrfs. As a result,
we have zero-filled bytenr, FSID, and chunk-tree UUID, hitting the ASSERTs
in check_tree_block().

Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/ctree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 6e9358cbac55..21e5414965e7 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -237,11 +237,16 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 	}
 	new_root->node = node;
 
+	memset_extent_buffer(node, 0, 0, sizeof(struct btrfs_header));
+	btrfs_set_header_bytenr(node, node->start);
 	btrfs_set_header_generation(node, trans->transid);
 	btrfs_set_header_backref_rev(node, BTRFS_MIXED_BACKREF_REV);
-	btrfs_clear_header_flag(node,
-			BTRFS_HEADER_FLAG_RELOC | BTRFS_HEADER_FLAG_WRITTEN);
 	btrfs_set_header_owner(node, objectid);
+	write_extent_buffer(node, fs_info->fs_devices->metadata_uuid,
+			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
+	write_extent_buffer(node, fs_info->chunk_tree_uuid,
+			    btrfs_header_chunk_tree_uuid(node),
+			    BTRFS_UUID_SIZE);
 	btrfs_set_header_nritems(node, 0);
 	btrfs_set_header_level(node, 0);
 	ret = btrfs_inc_ref(trans, new_root, node, 0);
-- 
2.33.0

