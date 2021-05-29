Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42915394B70
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 May 2021 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhE2JvH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 May 2021 05:51:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60108 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2JvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 05:51:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9nRBA127213
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=6jRsTZBOABILNwRGndLvaE3Yhl7f4q4A1dZaABUffG8=;
 b=OhMk5sO/FkxpKOGFpPEPL0pihKngB7pZ1zJWU9xnSpzk7Xac54SAVVCioG8R6W4QCDUg
 vO9ygZS8/zljvHDOB8NbBtLVSDJwXbjL71TxxzlAqPZ+ZaHJZEqsNv1ULtSsfOuIIh8w
 YKhz7ZNN49spk2uWiDRwJIliuC5SRkIhfFqIPkavcuweCeLCdNDYU7hy3UU1YdF7sQX+
 vhZ3ZavXfO4XsomQfQomGNR1xmhxMqL4cVEjd6nPYjajeN2yOIXB/RJfmjnlYeT5HTRm
 FyMsO3x53RS9WeHQKgyJB0LYhxVwWVUCzmMZ6X9I4ExtJvVTuOzCqYxs3B02XFCqOI5I mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38udjmgdtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9kFQV087841
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38ubnb7mwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:27 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14T9nQGP090813
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38ubnb7mwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 May 2021 09:49:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14T9nPOp002046;
        Sat, 29 May 2021 09:49:25 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 May 2021 02:49:25 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 3/4] btrfs: optimize variables size in btrfs_submit_compressed_write
Date:   Sat, 29 May 2021 17:48:35 +0800
Message-Id: <ee29e49041b7e6dae1f0d1d89d01c8a249001024.1622252933.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1622252932.git.anand.jain@oracle.com>
References: <cover.1622252932.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BiDdEMncMC-geJtqTWlYFnV7fBkXK7p3
X-Proofpoint-ORIG-GUID: BiDdEMncMC-geJtqTWlYFnV7fBkXK7p3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105290076
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch (btrfs: reduce compressed_bio member's types) reduced some
member's size. Function arguments @len, @compressed_len and @nr_pages
can be declared as unsigned int.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/compression.c | 6 +++---
 fs/btrfs/compression.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c1432a58f378..c523f384bd1a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -385,10 +385,10 @@ static void end_compressed_bio_write(struct bio *bio)
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

