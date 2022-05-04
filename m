Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855FC519301
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 02:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbiEDAxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 20:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244751AbiEDAxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 20:53:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865663F89D
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651625379; x=1683161379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwJPU/Bd44I87KvZod58QD9K1Mdp7OF2dH0K6wp4nps=;
  b=jodfTvQAjf1+ikS3FQqM6E3/Dt+d2mas0m5pIe1aMj8O0dD1Bid5ra5r
   ujV5TVi9ygVOqKwY+CtOxl+tdO4qHIYu19t5ZQI++oX12AeyCn8kcqNTY
   srRYKXubquJxcsggfBgccphrccN3LIClStCOt74SEbwKoUcnTu09hCwVS
   D8s4l6C4VfmquQsA333IucFfTSrBzIFsNmbyQ4sxO0K/J3QL93Cfc3tXn
   y7K8GgqWjbFa2V8NvwNz7a9MFdQWQs+p9qX+JjpW1AJxU7DG4YOiccYJN
   bWY26glFT6qs6M9zwwJGnlWIOd/AqgeelXxeg+TJ68Fbx5wgo2oMxerBY
   w==;
X-IronPort-AV: E=Sophos;i="5.91,196,1647273600"; 
   d="scan'208";a="200341876"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 08:49:38 +0800
IronPort-SDR: DJGHu9zfbQhsrNzALsvgVcTTsWbNaFw2OoWOPB/mdHe0G2P+jG+OaIZmCXfXI8IO+DWf5M2SpS
 iPDugYH4GaIqdaAzVhTFGwQ8k/eIBfW4dPbXOu+VXhgFpwoZYcELA/LeFr8Gzkw42YaXFH5SGU
 WiV4KFjCrWnAtax96qPAppeaU6pmoMDs+FePMg0nsf6fnk7VQexSTib/RYmbPR8j6q3r+yLmkZ
 Gcc+1fKzFvCSqiF7qaHTS3hCA7ws9SwI+IlZs8gJlf8E4QN8OvaQYJCi32dLGAhrMz133DzWcg
 9PL6AMqdTJzYNSQVhkyh0mqm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 17:19:40 -0700
IronPort-SDR: yn4TxpDRnqgL/OfDxCQJ8pNOdp3kZL6luC6SkgHp6bBG7dpfa6JzmyiE8o+zAB6WQdDPQ7v/Li
 N7SWh8e8LiVGuiBVqrF+b/TG7/II4+00TzzRnTnMZikTIJKXrr4h1MkDXoRKrP9jDiyapwv7qY
 4AcnTVvu8qjHA4NyLHldLnKaIUL/tvo1SIC0jmypTqpIa5yWS93MrzsjvyhYVDY/CfZARg+tPu
 vXcQxC5OqxLGFej0VB3k+DYnIR0qtHBHQxOLVNAg3Gd/F1tGmWHrxIWe7Sx7Jya7EF6ZM4Zh86
 OB0=
WDCIronportException: Internal
Received: from jv0vzd3.ad.shared (HELO naota-x1.wdc.com) ([10.225.48.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 May 2022 17:49:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/5] btrfs: zoned: introduce btrfs_zoned_bg_is_full
Date:   Tue,  3 May 2022 17:48:50 -0700
Message-Id: <1b20c7e3f675e7752d94e5d6543aa8bbdb281225.1651624820.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651624820.git.naohiro.aota@wdc.com>
References: <cover.1651624820.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a wrapper to check if all the space in a block group is allocated
or not.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 3 +--
 fs/btrfs/zoned.c       | 2 +-
 fs/btrfs/zoned.h       | 6 ++++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1dc6b2014813..1a2959be579d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3800,8 +3800,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 
 	/* Check RO and no space case before trying to activate it */
 	spin_lock(&block_group->lock);
-	if (block_group->ro ||
-	    block_group->alloc_offset == block_group->zone_capacity) {
+	if (block_group->ro || btrfs_zoned_bg_is_full(block_group)) {
 		ret = 1;
 		/*
 		 * May need to clear fs_info->{treelog,data_reloc}_bg.
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6e91022ae9f6..cc0c5dd5a901 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1836,7 +1836,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	}
 
 	/* No space left */
-	if (block_group->alloc_offset == block_group->zone_capacity) {
+	if (btrfs_zoned_bg_is_full(block_group)) {
 		ret = false;
 		goto out_unlock;
 	}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index de923fc8449d..98f277ed5138 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -372,4 +372,10 @@ static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *inode)
 		mutex_unlock(&root->fs_info->zoned_data_reloc_io_lock);
 }
 
+static inline bool btrfs_zoned_bg_is_full(struct btrfs_block_group *bg)
+{
+	ASSERT(btrfs_is_zoned(bg->fs_info));
+	return bg->alloc_offset == bg->zone_capacity;
+}
+
 #endif
-- 
2.35.1

