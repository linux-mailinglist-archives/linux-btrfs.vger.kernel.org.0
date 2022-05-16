Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFBE528719
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbiEPOby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244456AbiEPObu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:31:50 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C527B02
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652711508; x=1684247508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jFTV7i7Hh3OaUG5j4fuJXk1l0TFnopVwjp9A7WCDbMM=;
  b=Z9KR8i6OUuVYFHUG6MKxbGRGy7gqXaqWgTE5KmUoKgDsc0LcGokNzOlT
   9ik8NdNSswZR9PfiwbqsH+rLRH7WBHWww+KBogfsqkEvx8CLX4f088Jvs
   9anOIiDc/48KnV3jXB/mGFcghO3ma5prnMk6aaDoCBXlc40I/OKrIRyNP
   CMBeFtxKUNoN4Ml8ovSuaFr293Kps+3qSonxDqgCw2Vasec/CSgeoJXKq
   esIn6VLnMEC5debfdl2zDpW6uXq4XwKNAHljvowkk3qgcTR1JqbBiq5qu
   26dVIsGiFgJgSeKcqyPiEeWPlAYmwCEBM9aTrBeR2+M21y11qUmugRYjy
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205309209"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:31:47 +0800
IronPort-SDR: MNqj4YmeN8kTBl5PL2M22/AHgawnsfsFaA+S/ELK6Q6xEWy+R62UiSjDwgy9NJPN/RS1QHIlFA
 B1WprAv0ezF61F/uVKxHeWzuObDiO8brz6y3fc9ENyURQCmz+7xAU7cvQ1yQx24tvADRL9JysZ
 nj4Srnx/ffMBuKW+1MUZYHCmsXly2Daw8XZYrZuiOhwUO6bqZvRZbH+Hoet1XUk2wMShVe7b/G
 8uulSvd3CwQ7GLuqJzX5STz00B/mVXbp0ZdnA7Z+dxg+fqE5p7mXizMDjJzUUwlra1lDzBG/31
 VpQBOg6x7fjJD58UgWWV1alQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:57:29 -0700
IronPort-SDR: cJiXOciLLqW8t1ixOqTPTBoSRdmMsIHD7eeOGLdc421TMKDFE9gIoqfGoQHsfffpp/0opRKMv9
 2se6isOQ1niKELK+FCJ0jWFdZgiB17RopIJEel5MwrlGYm+RNXVYqM9bQSdYyohiHeEdQPFKka
 F5FMLn73taeVMSz/pvYJb5FSjTqZOwM7GC3jTw8TtKOl6fiB+09jr3nlftJHpYTlvr54VfQ6fp
 pyGA3xsUIexVXxjrwGxIVPvPu+QlPqf8X+gDmhBhBrgDwU4wjEsS3RDpGiUlY/GBiov2kx1ZRY
 T9c=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2022 07:31:47 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 1/8] btrfs: add raid stripe tree definitions
Date:   Mon, 16 May 2022 07:31:36 -0700
Message-Id: <06a217ce02243fe88b9649d689df89eea7a570c7.1652711187.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652711187.git.johannes.thumshirn@wdc.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
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
 fs/btrfs/ctree.h                | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h | 17 +++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7328fb17b7f5..20aa2ebac7cd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1878,6 +1878,34 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
 
+BTRFS_SETGET_FUNCS(stripe_extent_devid, struct btrfs_stripe_extent, devid, 64);
+BTRFS_SETGET_FUNCS(stripe_extent_offset, struct btrfs_stripe_extent, offset, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_devid, struct btrfs_stripe_extent, devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_offset, struct btrfs_stripe_extent, offset, 64);
+
+static inline struct btrfs_stripe_extent *btrfs_stripe_extent_nr(
+					 struct btrfs_dp_stripe *dps, int nr)
+{
+	unsigned long offset = (unsigned long)dps;
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
+static inline u64 btrfs_stripe_extent_offset_nr(const struct extent_buffer *eb,
+						struct btrfs_dp_stripe *dps,
+						int nr)
+{
+	return btrfs_stripe_extent_offset(eb, btrfs_stripe_extent_nr(dps, nr));
+}
+
 /* struct btrfs_dev_extent */
 BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent,
 		   chunk_tree, 64);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index b069752a8ecf..a2d28d83cc96 100644
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
 
+#define BTRFS_RAID_STRIPE_KEY 247
+
 /*
  * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
  */
@@ -488,6 +493,18 @@ struct btrfs_free_space_header {
 	__le64 num_bitmaps;
 } __attribute__ ((__packed__));
 
+struct btrfs_stripe_extent {
+	/* btrfs device-id this raid extent  lives on */
+	__le64 devid;
+	/* offset from  the devextent start */
+	__le64 offset;
+} __attribute__ ((__packed__));
+
+struct btrfs_dp_stripe {
+	/* array of stripe extents this stripe is comprised of */
+	struct btrfs_stripe_extent extents;
+} __attribute__ ((__packed__));
+
 #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
 #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
 
-- 
2.35.1

