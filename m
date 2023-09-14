Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1817A0A40
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbjINQFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbjINQFr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:05:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA8E1BF8
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707543; x=1726243543;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Rt+TRcnIncRdW3sqGWFr+5uNWeiiI61Ww4Ly4jFNlIc=;
  b=MdMJdP2T01UJmp7ZOMt7gTDdEJH6RHn5ZgeDBjXpXH9lUoDyRLOy7W/h
   eFmJCtiNEjqrz2WlM/vppZCiqxTIQgawMWcZT7tcrUao69eVLy4S4+qsy
   Exmc86ReTLzaqhzCsjl+VaQLW/zmEof2uTHeYsdx3sHbU2t0G5bRbSfxA
   XCxJhOCFEp6M8xK4Ja+mquZtt+WsrsTdpUMU78x1jHT6hOblgjaw8aYSc
   VI6bc9XfGc6L4zfn0tj7HOKKZ7Wmey7rl17efNHaf7s+haWyOvRmH8Skh
   f0mYqKHvkJoLrhn4XTqOXL9r4YMYpr+v3bur8CyRxV1BLk9yKfldf3077
   w==;
X-CSE-ConnectionGUID: ncS1mGDbS+G+qGXj4nCitA==
X-CSE-MsgGUID: qSAXSWVrTbqommcTb6umUA==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="242196079"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:05:42 +0800
IronPort-SDR: h5Kpt7tbHtx4vradJ6kBSCzmGAkstr83vb39cAhaDClooWDVrinYXL/QNnbbU+KvKSGHAeOjpT
 zCqAgtExpYbBB9347oq8dvl6xevPEwbx39CkivQAponDSGiZ7s2mDkmltRwwvOlP1SFKa/deHR
 bRxVimb1ozhz0l9ooGuGTAUIqSf7KlnnWrjAGCYEoFN7wESHXWYvw5G1/ltv2jEQ4sEQJ1VnY/
 AIm2AJkqMDnR3cbn3j5DJxZ3bhkhOF+j4zRhF2dWoBJj3tVdqm1DTYWKiKqLU9KeIOQNXMCUCB
 Vug=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:18:24 -0700
IronPort-SDR: HkL0aInPNONvwHM3lPMNZXk1LBCIIzgcyuXQVL2bF47lRBa3nQUPSN2/Cs8nmg65US5ukEIWVD
 tfKZjTXTTjegouxpdT2+EWQ73UvHR/mxnG+FsujXs48WpV87RBbxN3o/91IuilYbzadFoPX+cS
 hZH1y67OhpgAvk2mmRVf3F1NDbMUkKattHByA2SU3sTwQtAOFCHOMJP8hIdCBT9/WUHkEdgq9M
 kE6q3blVe+hvGJu9EGOU8tehdgByxNSXUltVV6MflTULdFbu8VripkYwLFK8velKSFPKqPs5iv
 LYg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:05:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:05:32 -0700
Subject: [PATCH v4 1/6] btrfs-progs: add raid-stripe-tree definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v4-1-c921c15ec052@wdc.com>
References: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707540; l=3412;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=Rt+TRcnIncRdW3sqGWFr+5uNWeiiI61Ww4Ly4jFNlIc=;
 b=FGcSy8fZTEU3nXbr4POiJXmtcRARfydGYJXRUuhvU/Mq7rd8WosqVB7ygADhAmsq6WBYpSGOx
 MyQWyyo3FwMC9GsjhwHdKDa1RgyM5Mqpei7b7VBBQ786l4dUlpWR5iS
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the definitions for the on-disk format of the RAID stripe tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/accessors.h       | 37 +++++++++++++++++++++++++++++++++++++
 kernel-shared/uapi/btrfs_tree.h | 26 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index 625acfbe8ca7..80635f31c90b 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -270,6 +270,43 @@ BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
 		   extent_count, 32);
 BTRFS_SETGET_FUNCS(free_space_flags, struct btrfs_free_space_info, flags, 32);
 
+/* struct btrfs_stripe_extent */
+BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
+BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
+BTRFS_SETGET_FUNCS(raid_stride_offset, struct btrfs_raid_stride, offset, 64);
+BTRFS_SETGET_FUNCS(raid_stride_length, struct btrfs_raid_stride, length, 64);
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
+static inline u64 btrfs_raid_stride_length_nr(struct extent_buffer *eb,
+						struct btrfs_stripe_extent *dps,
+						int nr)
+{
+	return btrfs_raid_stride_length(eb, btrfs_raid_stride_nr(dps, nr));
+}
+
 /* struct btrfs_inode_ref */
 BTRFS_SETGET_FUNCS(inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
 BTRFS_SETGET_FUNCS(inode_ref_index, struct btrfs_inode_ref, index, 64);
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index ad555e7055ab..73411a8697ce 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -699,6 +699,32 @@ struct btrfs_super_block {
 	__u8 padding[565];
 } __attribute__ ((__packed__));
 
+struct btrfs_raid_stride {
+	/* btrfs device-id this raid extent  lives on */
+	__le64 devid;
+	/* offset from  the devextent start */
+	__le64 offset;
+	/* length of the stride on disk */
+	__le64 length;
+} __attribute__ ((__packed__));
+
+/* The stripe_extent::encoding, 1:1 mapping of enum btrfs_raid_types */
+#define BTRFS_STRIPE_RAID0	1
+#define BTRFS_STRIPE_RAID1	2
+#define BTRFS_STRIPE_DUP	3
+#define BTRFS_STRIPE_RAID10	4
+#define BTRFS_STRIPE_RAID5	5
+#define BTRFS_STRIPE_RAID6	6
+#define BTRFS_STRIPE_RAID1C3	7
+#define BTRFS_STRIPE_RAID1C4	8
+
+struct btrfs_stripe_extent {
+	u8 encoding;
+	u8 reserved[7];
+	/* array of raid strides this stripe is comprised of */
+	struct btrfs_raid_stride strides;
+} __attribute__ ((__packed__));
+
 #define BTRFS_FREE_SPACE_EXTENT	1
 #define BTRFS_FREE_SPACE_BITMAP	2
 

-- 
2.41.0

