Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF6A52B62A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiERJR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiERJRV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 05:17:21 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8B19F85
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652865440; x=1684401440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Te0pR3/quGq/f/Wi8zoD6c9aeM5Y2/WeW3aOOyc6lNk=;
  b=fIle5B5m6UxwlrUQ2xqOeNoJtzAYownsQCyBCrKHE4K/0mg7iMFYdy7P
   Y2TzOsp1H4zaLrAT6oS5T7FLUUgrQnGmKoKgbFMz4rQo+7ZxR+ya/M3X9
   wkwkq4GC/kBysKu8/saZ/zUo6jgTYMzWijY+miNhE0I6/RI6k4LLEs2LQ
   wpiUEmmcPsBCzr+MeHJ+9Lki0hax42scgnYP538K1Ugk5mAXcG2D1BQob
   n5OxenBfL/uwF66ge7aOKIahtqTJ/qac/cn9rwEf/Xcvr2pmo8iDTSnV4
   OvgnMNEul5y87J9r4mMqVAJHIrXnOwwpUa4h6bnf5VjdMSqyI3y+sBmBK
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647273600"; 
   d="scan'208";a="201514743"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2022 17:17:19 +0800
IronPort-SDR: H4gAm5Ke4Ipa9VHgl8XyiI2qpYW76dnEAUu8iqzSPrIQKRrc/QZaKhfSFIUJA4N5sVj3f8r7hJ
 /bdImn3ihMO01M6N8OMtA/MbrUffqAJ9urfaF/CjYdEtpDsC6FnFxvARnREzdRa67p8OWN97cy
 rBRK2EZSJ+546eOAoU5CD1UC/8L0ZZQfoUP4zT0wAYrprEj/oXBK5659CoSY0zzkYuveE3k9w+
 Vku4bp96x2GkTVRgsbvA9TJENlUXVPq5nVg781M01j+DkM4C5UTopXqvXCUs1jfafiS5EE0WPM
 B+nqAHxLm7B9/0HwEGLPn1Cz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 01:40:22 -0700
IronPort-SDR: OzdXNEYu8N+MOLkjCcfbHiQLFqEZcAXhvMJ7O8bnOmInWOj/S/+xBPipyHYSAmHVEPX14tvetW
 GCC9diaqfFDsXAZveljTNwVNySXsNxkNrYD/XNNHYdpUV5N2EFlK9lFJC6WeEFty9rUu37dKO9
 GatX5xBgO6XrKYtDRWRjhdHe1CFJ3ywTLH6tlYExQV6kDT2g8BJoSq3FYU0rneUwZfNNXkG1jp
 +f/HgoU1lfWeJPldri8ZEF62hA4oqU+vYTX+Zjy4YeMYN8cfEX2o9tY0MqW8csyGeNoHdI/sKz
 H/E=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2022 02:17:18 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 1/6] btrfs-progs: add raid-stripe-tree definitions
Date:   Wed, 18 May 2022 02:17:11 -0700
Message-Id: <20220518091716.786452-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
References: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/ctree.h | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 68943ff294cc..56b3185001af 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -300,6 +300,24 @@ struct btrfs_chunk {
 	/* additional stripes go here */
 } __attribute__ ((__packed__));
 
+struct btrfs_stripe_extent {
+	/* btrfs device-id this raid extent  lives on */
+	__le64 devid;
+	/* offset from  the devextent start */
+	__le64 offset;
+} __attribute__ ((__packed__));
+
+struct btrfs_dp_stripe {
+	/* logical address for this stripe */
+	__le64 logical;
+	/* size of this stripe in bytes */
+	__le32 size;
+	/* reserved for future use/padding */
+	__le32 reserved;
+	/* array of stripe extents this stripe is comprised of */
+	struct btrfs_stripe_extent extents;
+} __attribute__ ((__packed__));
+
 #define BTRFS_FREE_SPACE_EXTENT	1
 #define BTRFS_FREE_SPACE_BITMAP	2
 
@@ -1206,6 +1224,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	struct rb_root global_roots_tree;
 	struct rb_root fs_root_tree;
@@ -1749,6 +1768,36 @@ BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
 		   extent_count, 32);
 BTRFS_SETGET_FUNCS(free_space_flags, struct btrfs_free_space_info, flags, 32);
 
+/* struct btrfs_dp_stripe */
+BTRFS_SETGET_FUNCS(dp_stripe_logical, struct btrfs_dp_stripe, logical, 64);
+BTRFS_SETGET_FUNCS(dp_stripe_size, struct btrfs_dp_stripe, size, 32);
+BTRFS_SETGET_FUNCS(stripe_extent_devid, struct btrfs_stripe_extent, devid, 64);
+BTRFS_SETGET_FUNCS(stripe_extent_offset, struct btrfs_stripe_extent, offset, 64);
+
+static inline struct btrfs_stripe_extent *btrfs_stripe_extent_nr(
+						 struct btrfs_dp_stripe *dps,
+						 int nr)
+{
+	unsigned long offset = (unsigned long)dps;
+	offset += offsetof(struct btrfs_dp_stripe, extents);
+	offset += nr * sizeof(struct btrfs_stripe_extent);
+	return (struct btrfs_stripe_extent *)offset;
+}
+
+static inline u64 btrfs_stripe_extent_devid_nr(struct extent_buffer *eb,
+					       struct btrfs_dp_stripe *dps,
+					       int nr)
+{
+	return btrfs_stripe_extent_devid(eb, btrfs_stripe_extent_nr(dps, nr));
+}
+
+static inline u64 btrfs_stripe_extent_offset_nr(struct extent_buffer *eb,
+						struct btrfs_dp_stripe *dps,
+						int nr)
+{
+	return btrfs_stripe_extent_offset(eb, btrfs_stripe_extent_nr(dps, nr));
+}
+
 /* struct btrfs_inode_ref */
 BTRFS_SETGET_FUNCS(inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
 BTRFS_SETGET_STACK_FUNCS(stack_inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
-- 
2.35.3

