Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF2B3184E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 06:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhBKF0x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 00:26:53 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57816 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBKF0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 00:26:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5O01Z032060;
        Thu, 11 Feb 2021 05:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=KKqUbbTwPVUlIXdUb3F3mufLRxeQ6M7lbUnBQOhqP6Q=;
 b=huoHakfNufIJy81ru6zqW1AghP25R3pERemNNmeHeoyr8VfuaJZsIOQ+/bjYtbYgUEtP
 SB5/JAwuJOSeNvYE0j+I1JNLJcdR2aXFt3Vtcuk32lCH2SH3qa2xSWkywEKJRglhbjKL
 oXlKx5tJnagLGNVWsvThtf7kNolWScYrZ9pfOtk3ymCY5HSMnyZGnNFO6Dcs0MKQOGjs
 ceoDC2/b3UAo5KK9WgS+7eVT1+quK+dyMa/lDEPsinMLQfKmAkwScTYIf6/u39hMMg9z
 Gig7svc7pGsVYhK+MzV6motvFnrx/4ixgBa04GyODWxyYRLo7ur2h2izUGSn4ne9L74o lQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36hgmap6mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5OiHQ183231;
        Thu, 11 Feb 2021 05:25:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36j4vtqjnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11B5PZ1p015028;
        Thu, 11 Feb 2021 05:25:36 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 21:25:35 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH 4/5] btrfs: scrub_checksum_tree_block() drop its function declaration
Date:   Wed, 10 Feb 2021 21:25:18 -0800
Message-Id: <b19539f16f4292749e201032459f5b2686709f0a.1613019838.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1613019838.git.anand.jain@oracle.com>
References: <cover.1613019838.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move the static function scrub_checksum_tree_block() before its use in
the scrub.c, and drop its declaration.

No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/scrub.c | 133 +++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 67 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 029477dd77de..bc335dd6a54f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -221,7 +221,6 @@ static void scrub_write_block_to_dev_replace(struct scrub_block *sblock);
 static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
 					   int page_num);
 static int scrub_checksum_data(struct scrub_block *sblock);
-static int scrub_checksum_tree_block(struct scrub_block *sblock);
 static int scrub_checksum_super(struct scrub_block *sblock);
 static void scrub_block_put(struct scrub_block *sblock);
 static void scrub_page_get(struct scrub_page *spage);
@@ -1506,6 +1505,72 @@ static inline int scrub_check_fsid(u8 fsid[],
 	return !ret;
 }
 
+static int scrub_checksum_tree_block(struct scrub_block *sblock)
+{
+	struct scrub_ctx *sctx = sblock->sctx;
+	struct btrfs_header *h;
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	u8 calculated_csum[BTRFS_CSUM_SIZE];
+	u8 on_disk_csum[BTRFS_CSUM_SIZE];
+	/*
+	 * This is done in sectorsize steps even for metadata as there's a
+	 * constraint for nodesize to be aligned to sectorsize. This will need
+	 * to change so we don't misuse data and metadata units like that.
+	 */
+	const u32 sectorsize = sctx->fs_info->sectorsize;
+	const int num_sectors = fs_info->nodesize >> fs_info->sectorsize_bits;
+	int i;
+	struct scrub_page *spage;
+	char *kaddr;
+
+	BUG_ON(sblock->page_count < 1);
+
+	/* Each member in pagev is just one block, not a full page */
+	ASSERT(sblock->page_count == num_sectors);
+
+	spage = sblock->pagev[0];
+	kaddr = page_address(spage->page);
+	h = (struct btrfs_header *)kaddr;
+	memcpy(on_disk_csum, h->csum, sctx->fs_info->csum_size);
+
+	/*
+	 * we don't use the getter functions here, as we
+	 * a) don't have an extent buffer and
+	 * b) the page is already kmapped
+	 */
+	if (spage->logical != btrfs_stack_header_bytenr(h))
+		sblock->header_error = 1;
+
+	if (spage->generation != btrfs_stack_header_generation(h)) {
+		sblock->header_error = 1;
+		sblock->generation_error = 1;
+	}
+
+	if (!scrub_check_fsid(h->fsid, spage))
+		sblock->header_error = 1;
+
+	if (memcmp(h->chunk_tree_uuid, fs_info->chunk_tree_uuid,
+		   BTRFS_UUID_SIZE))
+		sblock->header_error = 1;
+
+	shash->tfm = fs_info->csum_shash;
+	crypto_shash_init(shash);
+	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
+			    sectorsize - BTRFS_CSUM_SIZE);
+
+	for (i = 1; i < num_sectors; i++) {
+		kaddr = page_address(sblock->pagev[i]->page);
+		crypto_shash_update(shash, kaddr, sectorsize);
+	}
+
+	crypto_shash_final(shash, calculated_csum);
+	if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
+		sblock->checksum_error = 1;
+
+	return sblock->header_error || sblock->checksum_error;
+}
+
 static void scrub_recheck_block_checksum(struct scrub_block *sblock)
 {
 	sblock->header_error = 0;
@@ -1835,72 +1900,6 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	return sblock->checksum_error;
 }
 
-static int scrub_checksum_tree_block(struct scrub_block *sblock)
-{
-	struct scrub_ctx *sctx = sblock->sctx;
-	struct btrfs_header *h;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	u8 calculated_csum[BTRFS_CSUM_SIZE];
-	u8 on_disk_csum[BTRFS_CSUM_SIZE];
-	/*
-	 * This is done in sectorsize steps even for metadata as there's a
-	 * constraint for nodesize to be aligned to sectorsize. This will need
-	 * to change so we don't misuse data and metadata units like that.
-	 */
-	const u32 sectorsize = sctx->fs_info->sectorsize;
-	const int num_sectors = fs_info->nodesize >> fs_info->sectorsize_bits;
-	int i;
-	struct scrub_page *spage;
-	char *kaddr;
-
-	BUG_ON(sblock->page_count < 1);
-
-	/* Each member in pagev is just one block, not a full page */
-	ASSERT(sblock->page_count == num_sectors);
-
-	spage = sblock->pagev[0];
-	kaddr = page_address(spage->page);
-	h = (struct btrfs_header *)kaddr;
-	memcpy(on_disk_csum, h->csum, sctx->fs_info->csum_size);
-
-	/*
-	 * we don't use the getter functions here, as we
-	 * a) don't have an extent buffer and
-	 * b) the page is already kmapped
-	 */
-	if (spage->logical != btrfs_stack_header_bytenr(h))
-		sblock->header_error = 1;
-
-	if (spage->generation != btrfs_stack_header_generation(h)) {
-		sblock->header_error = 1;
-		sblock->generation_error = 1;
-	}
-
-	if (!scrub_check_fsid(h->fsid, spage))
-		sblock->header_error = 1;
-
-	if (memcmp(h->chunk_tree_uuid, fs_info->chunk_tree_uuid,
-		   BTRFS_UUID_SIZE))
-		sblock->header_error = 1;
-
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
-	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
-			    sectorsize - BTRFS_CSUM_SIZE);
-
-	for (i = 1; i < num_sectors; i++) {
-		kaddr = page_address(sblock->pagev[i]->page);
-		crypto_shash_update(shash, kaddr, sectorsize);
-	}
-
-	crypto_shash_final(shash, calculated_csum);
-	if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
-		sblock->checksum_error = 1;
-
-	return sblock->header_error || sblock->checksum_error;
-}
-
 static int scrub_checksum_super(struct scrub_block *sblock)
 {
 	struct btrfs_super_block *s;
-- 
2.27.0

