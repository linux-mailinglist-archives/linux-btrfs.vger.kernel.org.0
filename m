Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91D839127D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhEZImy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 04:42:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51892 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhEZImy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 04:42:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q8dU0f068252;
        Wed, 26 May 2021 08:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=VotDhLbH1evQzX13tI544DKGn9Bpp/zHvdeWX981FHE=;
 b=IIsUl1kKTWrhR8OG5PJlVfmSKbcIThChU5C9TXeIs7/hn8t1XbXlxtUJ+sinKI+Dut8c
 WoJV/41ARBohTv/U/LAaCg2wpVQQ1NadF/b/eY4LKBkWXKsR9AAfUyD3pEothOMtrHwR
 ZcmlYrqAyHaDVsKgHNOSINwP3k5B1dZaTmVHMmLjk7NrlcNddV9a1gSze1UNUSXWQ5Te
 sfnY7bXtCP0ObsrsKwF56VM9Pk55I8OD3EFarr32PkFVVg/r0mAvoCdb53gtvz6sfRJ7
 H1wuLkcfdJLqd716SR2tkOVGK9GkEkZf0YWBiQOc+Ew0jrYT5ze3wSskbTtpijrhRc8o 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38ptkp88rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 08:41:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q8a7RU063362;
        Wed, 26 May 2021 08:41:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38pr0chgjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 08:41:18 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14Q8fHxl006937;
        Wed, 26 May 2021 08:41:18 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 May 2021 01:41:17 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH] btrfs: optimize users of members of the struct compressed_bio
Date:   Wed, 26 May 2021 16:40:54 +0800
Message-Id: <19bd55230c326edc303c574acd2eb2e4312aa941.1622018450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1a3c6cddd909d922948a22ac1f287293e0deb665.1621961965.git.dsterba@suse.com>
References: <1a3c6cddd909d922948a22ac1f287293e0deb665.1621961965.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260056
X-Proofpoint-GUID: hfGNJn1Mm8RHRmTtRRk63fNCE9juZucz
X-Proofpoint-ORIG-GUID: hfGNJn1Mm8RHRmTtRRk63fNCE9juZucz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260056
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit
 btrfs: reduce compressed_bio member's types
reduced some of the members size.

It has its cascading effects which are done here.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/compression.c | 18 +++++++++---------
 fs/btrfs/compression.h |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c006f5d81c2a..36731b598770 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -149,7 +149,7 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	const u32 csum_size = fs_info->csum_size;
 	const u32 sectorsize = fs_info->sectorsize;
 	struct page *page;
-	unsigned long i;
+	unsigned int i;
 	char *kaddr;
 	u8 csum[BTRFS_CSUM_SIZE];
 	struct compressed_bio *cb = bio->bi_private;
@@ -208,7 +208,7 @@ static void end_compressed_bio_read(struct bio *bio)
 	struct compressed_bio *cb = bio->bi_private;
 	struct inode *inode;
 	struct page *page;
-	unsigned long index;
+	unsigned int index;
 	unsigned int mirror = btrfs_io_bio(bio)->mirror_num;
 	int ret = 0;
 
@@ -334,7 +334,7 @@ static void end_compressed_bio_write(struct bio *bio)
 	struct compressed_bio *cb = bio->bi_private;
 	struct inode *inode;
 	struct page *page;
-	unsigned long index;
+	unsigned int index;
 
 	if (bio->bi_status)
 		cb->errors = 1;
@@ -387,10 +387,10 @@ static void end_compressed_bio_write(struct bio *bio)
  * the end io hooks.
  */
 blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
-				 unsigned long len, u64 disk_start,
-				 unsigned long compressed_len,
+				 unsigned int len, u64 disk_start,
+				 unsigned int compressed_len,
 				 struct page **compressed_pages,
-				 unsigned long nr_pages,
+				 unsigned int nr_pages,
 				 unsigned int write_flags,
 				 struct cgroup_subsys_state *blkcg_css)
 {
@@ -669,9 +669,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map_tree *em_tree;
 	struct compressed_bio *cb;
-	unsigned long compressed_len;
-	unsigned long nr_pages;
-	unsigned long pg_index;
+	unsigned int compressed_len;
+	unsigned int nr_pages;
+	unsigned int pg_index;
 	struct page *page;
 	struct bio *comp_bio;
 	u64 cur_disk_byte = bio->bi_iter.bi_sector << 9;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 00d8439048c9..c359f20920d0 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -91,10 +91,10 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
 			      struct bio *bio);
 
 blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
-				  unsigned long len, u64 disk_start,
-				  unsigned long compressed_len,
+				  unsigned int len, u64 disk_start,
+				  unsigned int compressed_len,
 				  struct page **compressed_pages,
-				  unsigned long nr_pages,
+				  unsigned int nr_pages,
 				  unsigned int write_flags,
 				  struct cgroup_subsys_state *blkcg_css);
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
-- 
2.30.2

