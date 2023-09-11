Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7279B8DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356185AbjIKWDI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbjIKNXR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:17 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA9CD7
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694438592; x=1725974592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v5sjPWXNw95QgO2j1uFYVXOa4VWaWPbh/DcihNdSso4=;
  b=JviwefIlxeuz2sFvd84VPSK1Nj9GCNeQU/u6KXYr6k9iNeIH2tLCqNxe
   l/XAPnagKE9i82OwQxk9w9m7YM1bsuHuQY+dx12U86iSYmPjm1eVnGCZy
   9lJ2HlOInoyqDKv/P1YP5zby1TwiB4Q1mXTM+ax1ZU8YlFO7P99cJCm0s
   1WQ25ZiwGGmH4iSb6W/NSxwRUlCynVo2ZZlqbS1GH1coLE1cTJcLGOeVn
   LVYEi0SF7Tt62ApbUnbPLphJQAKSiGeQEQA7qJELSbGXFFM3VigJiObdD
   j/5KIIVxRBfkJPWq7UIf20J78B+BR7AryVUu+p9VQY4FRs33LwaIfivb5
   Q==;
X-CSE-ConnectionGUID: Yj0R/gFURUGsBiEtI3OTZg==
X-CSE-MsgGUID: WFoBy5DlQTyY1Ns/bU2w0Q==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="248143279"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 21:23:11 +0800
IronPort-SDR: Lk13+n1PHeCZRwcvrPBe+YNB7gqOVqTXKYvU+KtGOhw2bxg6TZk4ATZtpzHjwI4iYfWL2+aCse
 KVE1zLc3vyw6mN5izIkthTsiLENAjwdqHOUtR3M9JQ4nvl1dy+uLPT4bGkEXvsKBLZ5cnErox3
 vtijKctjXyAI/JpXpsJ0DXopIiXPyIfpTRQcij+JOj25d8X2JKFnZImrUlBdAzgKofL/JYYTRK
 ZQ0yvDjsLjNKpMnw+Q3Gtj0aUwWb8mbai2G70MUiwJ3LI2sctM+iGWh8A+CzWiYxyGmakDTGTi
 mPc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:30:17 -0700
IronPort-SDR: cAibKOUD4oBNL+IxvCZZIHyDTQzw3mX7zgrGLeM++AqoT8kqC+z2zr1VbyVFa7s3D96gR2ON90
 w//xwv9ZEmM60TJ2xP7HoIT9jbQMuu0PZaPKXRHpPq2SmlMCavEYKO+ueVBU3e0JQQMVcaJjwc
 O4qDkBmwfu2jh1ZhrF2oKrfFqkoKj/ONSCrzZGzOWyLvFK6OMdQmwyTrkTGptkxVwnaHcUQYH4
 k8yIGhHqoqTyl9CLdUKePThKT3M8DNpFO1m53A0uswg2dEJptx9cEjt662ZyGSJHEu5UnqLybk
 CvU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2023 06:23:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs-progs: add raid-stripe-tree definitions
Date:   Mon, 11 Sep 2023 06:22:57 -0700
Message-ID: <20230911-raid-stripe-tree-v1-1-c8337f7444b5@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
References: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694438542; l=3337; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=v5sjPWXNw95QgO2j1uFYVXOa4VWaWPbh/DcihNdSso4=; b=zmx0WYmHngfI2tBUw1kKTDVzGndQ6IqYwoEnw5cXj+2tLpQOjPhPiJwM9ol/lUKnHk+1JLAL6 EL4Q7r222pPDe1OE1uM6rmwA6u9KYAeFwkfMhzCKDnJJ2LihilQUycC
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the definitions for the on-disk format of the RAID stripe tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/accessors.h       | 37 +++++++++++++++++++++++++++++++++++++
 kernel-shared/uapi/btrfs_tree.h | 25 +++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

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
index ad555e7055ab..e89246a3fdbe 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -699,6 +699,31 @@ struct btrfs_super_block {
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
+#define BTRFS_STRIPE_DUP	0
+#define BTRFS_STRIPE_RAID0	1
+#define BTRFS_STRIPE_RAID1	2
+#define BTRFS_STRIPE_RAID1C3	3
+#define BTRFS_STRIPE_RAID1C4	4
+#define BTRFS_STRIPE_RAID5	5
+#define BTRFS_STRIPE_RAID6	6
+#define BTRFS_STRIPE_RAID10	7
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

