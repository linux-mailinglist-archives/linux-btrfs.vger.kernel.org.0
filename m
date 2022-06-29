Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E2756035F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiF2Ol0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiF2OlZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75313A734
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656513682; x=1688049682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fUuoIhB/O5nhEZHplhJZf6apHnNDub5hbyfqTcihtLI=;
  b=CBIBuGSOuH3NJWcxhbd3KH9R6up3inRCmd/zfxQQo0AxMeFDTmj8YDy4
   vmF8zxSwUelgT4hrL2EU+BLQOOwBMwdf6Fmd+SB91kbxHuLqc7fYS/3GW
   eisDg4DQQUDiTygMIPpkgpzdwysnWY5Y06/oLFilRFLiUeZj+szXlb4We
   u9xTh5+P78cYgOkOiskHIYJGxr3KPQokYJGHiTM0hvyIrHj/ybYsfRFz1
   CsDbCSw8JvzwvaIP3Tk2Q16hTyMk0VjHAurluHqwtc/XafN8KlvxpeG+P
   FvCYO+rIe5w3XR0VM9upa40b9Ipl+qKesq1got7vUNPW9uVdVzXbD5Cwi
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="203064882"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 22:41:22 +0800
IronPort-SDR: miGwLkT9+gJThNJTj/KIpZA0YiuN7AAsF0rJxwTfv1yPiw/9CbQBgVmaALrD7ndM5mwFiAOl59
 H1F8I5NMmMS3+RaRE+t81ySqHZ8RkK8gfDGn47LzJQEPA04uxX+rQbHYzyr8U5Vvdn0iRyIlbN
 xXTcK5ADk+1yIN19eFg/4NlI2nakzvYWDQMJzWCoMvJiTRJk4GbUYsTQN6yiJGs3tBtpRNzHus
 3hcLFAadeumnvUxXvYfm1uzBJMDP60EoJlNcu7c2jU0yOUqRRihMgiPBSi3uNy2kOPhfHZgnVV
 j6Ha2brsviMRuGEzzosrlqRM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 06:59:00 -0700
IronPort-SDR: E3hU26Qcle2HMvVr+7K5GY28DauPegHuFgVak1iXP8VOS92sz0KH4TGU4Y/Yn/qKAcJCZNc20N
 VCNptoOahgGy6eG5VH3CQMlJTcQibN0YrGDix1g8izHk3FUS5T4F+JWPh2aUFWiLILs1mvdx+l
 uPXwH6N7KsE5DzUCQ9cQVfcQm7QhWj2WuKlrz66P+qMjj8FlMZE/3z71/HrZcelMDShsB3BuAs
 poXGbQG6K5nqTVcmKbKdRIaAsi+cBKjsMrFNWXSWwk5vSkS7Bv9yzgL5u5lH22uSraTTbUwZRb
 U5o=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2022 07:41:21 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 1/8] btrfs: add raid stripe tree definitions
Date:   Wed, 29 Jun 2022 07:41:07 -0700
Message-Id: <1ca2b7b2f61b32caae125e4001f83620fa1ddd0c.1656513330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656513330.git.johannes.thumshirn@wdc.com>
References: <cover.1656513330.git.johannes.thumshirn@wdc.com>
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

Add definitions for the raid-stripe-tree. This tree will hold informatioin
about the on-disk layout of the stripes in a RAID set.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h                | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h | 17 +++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e2569f84aab..18e2f186cb5e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1906,6 +1906,35 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
 
+BTRFS_SETGET_FUNCS(stripe_extent_devid, struct btrfs_stripe_extent, devid, 64);
+BTRFS_SETGET_FUNCS(stripe_extent_physical, struct btrfs_stripe_extent, physical, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_devid, struct btrfs_stripe_extent, devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_physical, struct btrfs_stripe_extent, physical, 64);
+
+static inline struct btrfs_stripe_extent *btrfs_stripe_extent_nr(
+					 struct btrfs_dp_stripe *dps, int nr)
+{
+	unsigned long offset = (unsigned long)dps;
+
+	offset += offsetof(struct btrfs_dp_stripe, extents);
+	offset += nr * sizeof(struct btrfs_stripe_extent);
+	return (struct btrfs_stripe_extent *)offset;
+}
+
+static inline u64 btrfs_stripe_extent_devid_nr(const struct extent_buffer *eb,
+					       struct btrfs_dp_stripe *dps,
+					       int nr)
+{
+	return btrfs_stripe_extent_devid(eb, btrfs_stripe_extent_nr(dps, nr));
+}
+
+static inline u64 btrfs_stripe_extent_physical_nr(const struct extent_buffer *eb,
+						  struct btrfs_dp_stripe *dps,
+						  int nr)
+{
+	return btrfs_stripe_extent_physical(eb, btrfs_stripe_extent_nr(dps, nr));
+}
+
 /* struct btrfs_dev_extent */
 BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent,
 		   chunk_tree, 64);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index d4117152d907..070fc9266821 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -56,6 +56,9 @@
 /* Holds the block group items for extent tree v2. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* tracks RAID stripes in block groups. */
+#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -264,6 +267,8 @@
  */
 #define BTRFS_QGROUP_RELATION_KEY       246
 
+#define BTRFS_RAID_STRIPE_KEY		247
+
 /*
  * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
  */
@@ -488,6 +493,18 @@ struct btrfs_free_space_header {
 	__le64 num_bitmaps;
 } __attribute__ ((__packed__));
 
+struct btrfs_stripe_extent {
+	/* btrfs device-id this raid extent lives on */
+	__le64 devid;
+	/* physical location on disk */
+	__le64 physical;
+} __attribute__ ((__packed__));
+
+struct btrfs_dp_stripe {
+	/* array of stripe extents this stripe is composed of */
+	DECLARE_FLEX_ARRAY(struct btrfs_stripe_extent, extents);
+} __attribute__ ((__packed__));
+
 #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
 #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
 
-- 
2.35.3

