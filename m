Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F73184E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 06:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBKF1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 00:27:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45744 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBKF0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 00:26:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5NtVV027411;
        Thu, 11 Feb 2021 05:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=r06omi6kUt0is18Cnyrbx+Ms8MfGqZqIfs87watTZHQ=;
 b=HXkalprkd3EGwNbQhf/Vr9Rpf3EOChkV8ZYE+IWwWcEEoBcB6KenEcnLCZc3nsK+1DUr
 1uAFm5m5xBcNYC0s8RnKiQBmqsTWy+fyxGFVgmcoY9EeZ0L8jRc6XWGG4kVQUfxZUIl+
 s3EtAUla35d8/Tc0/X6kW/OXJoMUOwDuGHNGtN1OdVaRe2zQdjL9TK6t2Umb2TBHgLhz
 UNzyRxIeZL22E+OVUK0UZBx4i9L/1VQFB2ENVNQYvTiGAH2KfaGceX9ge2Csi39sCI9Q
 eTruNTCj+hg3P4c3nVotei1umj4uD3llTh8Yq9yhUP8WVOUMS71bIvCY93oAdEOuPGnK /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36hkrn60wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5P6E5176939;
        Thu, 11 Feb 2021 05:25:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 36j51yg4j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11B5PaSQ019898;
        Thu, 11 Feb 2021 05:25:36 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 21:25:35 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH 5/5] btrfs: scrub_checksum_data() drop its function declaration
Date:   Wed, 10 Feb 2021 21:25:19 -0800
Message-Id: <46c9cb7e4a50fc9c40d7dea000f5285e5997124f.1613019838.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1613019838.git.anand.jain@oracle.com>
References: <cover.1613019838.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move scrub_checksum_data() before its use, and drop its declaration.

No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/scrub.c | 61 ++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index bc335dd6a54f..62ea81eded03 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -220,7 +220,6 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 static void scrub_write_block_to_dev_replace(struct scrub_block *sblock);
 static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
 					   int page_num);
-static int scrub_checksum_data(struct scrub_block *sblock);
 static int scrub_checksum_super(struct scrub_block *sblock);
 static void scrub_block_put(struct scrub_block *sblock);
 static void scrub_page_get(struct scrub_page *spage);
@@ -1505,6 +1504,36 @@ static inline int scrub_check_fsid(u8 fsid[],
 	return !ret;
 }
 
+static int scrub_checksum_data(struct scrub_block *sblock)
+{
+	struct scrub_ctx *sctx = sblock->sctx;
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	u8 csum[BTRFS_CSUM_SIZE];
+	struct scrub_page *spage;
+	char *kaddr;
+
+	BUG_ON(sblock->page_count < 1);
+	spage = sblock->pagev[0];
+	if (!spage->have_csum)
+		return 0;
+
+	kaddr = page_address(spage->page);
+
+	shash->tfm = fs_info->csum_shash;
+	crypto_shash_init(shash);
+
+	/*
+	 * In scrub_pages() and scrub_pages_for_parity() we ensure each spage
+	 * only contains one sector of data.
+	 */
+	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
+
+	if (memcmp(csum, spage->csum, fs_info->csum_size))
+		sblock->checksum_error = 1;
+	return sblock->checksum_error;
+}
+
 static int scrub_checksum_tree_block(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
@@ -1870,36 +1899,6 @@ static int scrub_checksum(struct scrub_block *sblock)
 	return ret;
 }
 
-static int scrub_checksum_data(struct scrub_block *sblock)
-{
-	struct scrub_ctx *sctx = sblock->sctx;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	u8 csum[BTRFS_CSUM_SIZE];
-	struct scrub_page *spage;
-	char *kaddr;
-
-	BUG_ON(sblock->page_count < 1);
-	spage = sblock->pagev[0];
-	if (!spage->have_csum)
-		return 0;
-
-	kaddr = page_address(spage->page);
-
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
-
-	/*
-	 * In scrub_pages() and scrub_pages_for_parity() we ensure each spage
-	 * only contains one sector of data.
-	 */
-	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
-
-	if (memcmp(csum, spage->csum, fs_info->csum_size))
-		sblock->checksum_error = 1;
-	return sblock->checksum_error;
-}
-
 static int scrub_checksum_super(struct scrub_block *sblock)
 {
 	struct btrfs_super_block *s;
-- 
2.27.0

