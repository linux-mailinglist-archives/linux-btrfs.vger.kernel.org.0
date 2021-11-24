Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA845B781
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhKXJee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32204 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhKXJe0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746276; x=1669282276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJjN+pVk4qAT40vLu1g4Mj2Be/S3g1FANYlkQQ3HPk4=;
  b=pHKDZm3XX9Q+g+znc113V2ZCCgmpBsGahZAYr+Gg2KktGbrGrnLtfAtB
   pPGYpGpPyEg0slMctaKnQLLWDwr+pUE6HTZDx+WIZR14InbOGGSoW0ZGY
   /cmlkqubrpTyIWorSxHO0W7d5Tz/PYC0890slvWwaWogkgwgFvPYk+RDn
   b3Z5AJQhEsWWkG/aiP2LfJEDHlMEar+gGPDLLofwIRk3fggfvd6M5p2KE
   CCVQ7PGc5/Nm1uAkTtSh0qB6JhA0COU8kupHWph6DkvOFVfVVIVPshu6z
   zcdbqtF+aAPjDDxxhJs0z1x+QWcv6JT6SRIMKFZPwclqgA3xE15Bw7fpz
   w==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499402"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:16 +0800
IronPort-SDR: tTi4SZPAIJl5R+fYX+ZOG9/TKr+4y54DiCYZaeGj9qWJjf7+KA7n9m4Vop+9aXX6C58IVO02H7
 CRLW8cHnuQwnuwdjUeLGPg5lVWbv01MrIy2KqIqdqqIo6xsRQIeDNBX2ZFQjHw3yuL4H5OoyyQ
 KKGhTKEhce//ViRgLnub/YLAA7sdyFRepLwpf6n8Yl2A6X3KhT103P8AyfSB3zt9fLfU7Dlsn7
 lRoltxkCyNDWQYyZjtQYX91mI3KjNDPoI8fnrP+j/S1kzsCmnWOx/Poo7kyMD6Md/mAA04U3Kq
 BzA83k6lAlyH/2WSQE5TIKVC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:09 -0800
IronPort-SDR: HS6KV4/PwBCd4ifTo6OnFIT/C0eewYauTdojzocBcKec0ltyfNuaLrrxEvu5jiYXDcX8o2txuT
 tIAWxD3wwk+0HsLIVedR+rgbyeLXNwLd5p89YkocC7Ho8Kru6CQBlTMrK/PGmA3qTu/7XLqqgp
 Ykl4Q7XiJNJ89IDc+uscOac7IgM7tCJw2PlcS+fyemqsgpZIc/CKwA47I7pd5dEAukBhmmrBa3
 v6JloVhAO25PSNgsUFXC7BOPdaYwkRrHIrwtVb/t+H3B/hpEDrEk9cfeozXJoBtNXrl37EpAeh
 +IQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:16 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 17/21] btrfs: move btrfs_scrub_pause() definition to scrub.h
Date:   Wed, 24 Nov 2021 01:30:43 -0800
Message-Id: <cbc055ce96061f36ca5e8c0f6e9ff048dee48e9f.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a scrub.h move btrfs_scrub_pause()'s definition there.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h       | 1 -
 fs/btrfs/scrub.h       | 1 +
 fs/btrfs/transaction.c | 1 +
 fs/btrfs/volumes.c     | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c050c47131760..5ab09bb0279fe 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3801,7 +3801,6 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
 int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
 
 /* scrub.c */
-void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
 void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
 int btrfs_scrub_cancel(struct btrfs_fs_info *info);
 int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 9ff9d3e033b25..f06e4a10a08b9 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -53,4 +53,5 @@ void btrfs_scrub_wr_submit(struct scrub_ctx *sctx);
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    u64 end, struct btrfs_scrub_progress *progress,
 		    int readonly, int is_dev_replace);
+void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
 #endif /* BTRFS_SCRUB_H */
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8b6a90fafcd41..df56c6991294d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -22,6 +22,7 @@
 #include "block-group.h"
 #include "space-info.h"
 #include "zoned.h"
+#include "scrub.h"
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 23459328d19bc..3c31f8fd4bb3c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -33,6 +33,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "zoned.h"
+#include "scrub.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
-- 
2.31.1

