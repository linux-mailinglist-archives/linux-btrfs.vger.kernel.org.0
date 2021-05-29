Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDD394B6E
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 May 2021 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhE2JvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 May 2021 05:51:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53460 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2JvB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 05:51:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9nOX8137913
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=mKgVCMdg+IB4IsF/BLTJPNpDG8t8apwl58gS4KfC45s=;
 b=X4uTCPAQWF9CNdH8IO4ih0QzQj8cZFToDnlCZapyWr0xYzFR5vjy5DAXmoc81Bzy9QAl
 eiKUqRnvacVS5ojXsAS3JJe9Fq3USGYI4aUgI+aZ5LPFATFsClMqHGks+XiqxhicZ5zB
 r7UDTst+i8Vw5jLeUXHokE3IJ0aqOOyLBMvq7MTi9JkYtqwy0vUn/Zp1sMtOdAL19rsP
 NCpvrgbT1hRSNc5zoHKiexkLHMD+Mq6w5bUXLzqhU73r68KmLmHo6VuDmavF3xML3uMw
 HTMKdfcKHoWCWjJ2/t7lp3FW8THPjutIexOHBADb8cHCFRxoa0kWCb5JAmiJj+hPzzqc vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38ub4cgg9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14T9kOWA091147
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38ucxjfcbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:23 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14T9nNvg094472
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 09:49:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38ucxjfcb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 May 2021 09:49:23 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14T9nM2t005637;
        Sat, 29 May 2021 09:49:22 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 May 2021 02:49:22 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/4] btrfs: reduce the variable size to fit nr_pages
Date:   Sat, 29 May 2021 17:48:33 +0800
Message-Id: <ad14b486d19f6a45d15106eac3bbbc7fd84de015.1622252932.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1622252932.git.anand.jain@oracle.com>
References: <cover.1622252932.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JPYLFEHbS6oWWR5bGdeM3CJc15z6UEAA
X-Proofpoint-ORIG-GUID: JPYLFEHbS6oWWR5bGdeM3CJc15z6UEAA
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105290076
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch (btrfs: reduce compressed_bio member's types) reduced the 
@nr_pages size to unsigned int, its cascading effects are fixed here.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/compression.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7bd7cae51dbf..e10041af8476 100644
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
-- 
2.30.2

