Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C14697E5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBOObX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBOObV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:31:21 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267DD38EAF
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471473; x=1708007473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+3/IGzQkpR3EhYQgh6lncbPjq3djAtMHmNM9K5vBJk=;
  b=a9ChJ0fw+/gpBlytOGoaQFTamxdTV/UnEYxytZexeFHn2+hSCSh6EWjx
   j0fCr1ctg1JMAOm7ZbZf9SS9nyxioiM4/vO+rn7jPj1unPGP6C8NRqm1F
   KHr76OGIDCBTsONKV3+0L4QzPTUr76WeFz0a965egKUEO8lChTGr0aF+d
   GxgGkE2IwEqTkFUMke5YoN6oI7EaEEbQ+SYczVKVsdOWuSlbpzRxO8vMp
   8X+3EVZGMjenwKYjbHMwfX7kSr0JyITBmC+s92X7t5alBOsEKw2ncYCay
   Fp+NEEIRRmL4LBppKbt52NB/hthRoqBG/IGnMjh3HKKzN580moqiD5b+6
   g==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223393908"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:31:12 +0800
IronPort-SDR: dRQiSGaQ4F92qF3SkA9pBN7A0vDjwtmzHtBuH+f51Njsya2D8F+oVNwJZe/If0vimms67+VZUo
 T1gySmxAe76+8zgFpxoHc5AnRfTcifWp6pTr693u8Ug3otR7EptSo0BMOlIHG+v7cj1nF9RMJy
 M3gt5UWIsNWo/KSey2Ad24RIbQSQ4uIzpSoyVLabiZtQMDTlWFjkqbvHThqTXlAqYy4ymCSvXx
 VSmHqZaD9ICxGuAyWeByaZ18oZV9v6shZBi0svAqi65aYRawWW06efM+mP/b9BNA37kRGNvxkd
 KRA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:48:19 -0800
IronPort-SDR: VssUs9Y5crXmt+qmrFIruSFYxxUtI9WKARl5Fjvkk112h4QMCrQ+Gck0RoD8Oxr1kRWVExcq6D
 quV/UE3pVqlinHCPkDXZRzEzej7hbF2F1LwYblLv/8mht+qiHDBh9OUUimtxIprp2yZkVvcU80
 CJR6TeochM9W0T8oi2iGsXYdwTzxatZcVoau7rn4v7h8PKfnu4TjSuoDbG8QenMtD5Isqv5mZM
 TKCOxk1oGmur7Luvh9R154tlXebChMwVIuC2rdAWUeXMdSs5vPF6PUhjXaziJFtmL8KWpopz0o
 2po=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:31:13 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/6] btrfs-progs: add raid-stripe-tree definitions
Date:   Wed, 15 Feb 2023 06:31:04 -0800
Message-Id: <20230215143109.2721722-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
References: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the definitions for the on-disk format of the RAID stripe tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/ctree.h      | 41 ++++++++++++++++++++++++++++++++++++++
 kernel-shared/print-tree.c |  1 +
 2 files changed, 42 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index a969125e0e36..a91c7dac4403 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -292,6 +292,18 @@ struct btrfs_chunk {
 	/* additional stripes go here */
 } __attribute__ ((__packed__));
 
+struct btrfs_raid_stride {
+	/* btrfs device-id this raid extent  lives on */
+	__le64 devid;
+	/* offset from  the devextent start */
+	__le64 offset;
+} __attribute__ ((__packed__));
+
+struct btrfs_stripe_extent {
+	/* array of raid strides this stripe is comprised of */
+	struct btrfs_raid_stride strides;
+} __attribute__ ((__packed__));
+
 #define BTRFS_FREE_SPACE_EXTENT	1
 #define BTRFS_FREE_SPACE_BITMAP	2
 
@@ -515,6 +527,7 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -1761,6 +1774,34 @@ BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
 		   extent_count, 32);
 BTRFS_SETGET_FUNCS(free_space_flags, struct btrfs_free_space_info, flags, 32);
 
+/* struct btrfs_stripe_extent */
+BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
+BTRFS_SETGET_FUNCS(raid_stride_offset, struct btrfs_raid_stride, offset, 64);
+
+static inline struct btrfs_raid_stride *btrfs_raid_stride_nr(
+						 struct btrfs_stripe_extent *dps,
+						 int nr)
+{
+	unsigned long offset = (unsigned long)dps;
+	offset += offsetof(struct btrfs_stripe_extent, strides);
+	offset += nr * sizeof(struct btrfs_raid_stride);
+	return (struct btrfs_raid_stride *)offset;
+}
+
+static inline u64 btrfs_raid_stride_devid_nr(struct extent_buffer *eb,
+					       struct btrfs_stripe_extent *dps,
+					       int nr)
+{
+	return btrfs_raid_stride_devid(eb, btrfs_raid_stride_nr(dps, nr));
+}
+
+static inline u64 btrfs_raid_stride_offset_nr(struct extent_buffer *eb,
+						struct btrfs_stripe_extent *dps,
+						int nr)
+{
+	return btrfs_raid_stride_offset(eb, btrfs_raid_stride_nr(dps, nr));
+}
+
 /* struct btrfs_inode_ref */
 BTRFS_SETGET_FUNCS(inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
 BTRFS_SETGET_STACK_FUNCS(stack_inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index ba1caa88fcf1..78e6aa2dcd5a 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1691,6 +1691,7 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
 	DEF_INCOMPAT_FLAG_ENTRY(ZONED),
 	DEF_INCOMPAT_FLAG_ENTRY(EXTENT_TREE_V2),
+	DEF_INCOMPAT_FLAG_ENTRY(RAID_STRIPE_TREE),
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
-- 
2.39.0

