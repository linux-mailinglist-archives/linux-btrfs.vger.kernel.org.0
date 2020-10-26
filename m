Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579AA299C24
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 00:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410983AbgJZXzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 19:55:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49194 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410901AbgJZXzZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 19:55:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNpgBO008933;
        Mon, 26 Oct 2020 23:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=p9wcWzNWRupsTKDyjWPNfJsqQtY82jEb9ldxxLrL474=;
 b=jIEIjvOuyv/iSRBRexHuRTELGCQ5dkX1KR0hETC1SzaHCpMIGVtDbsFJejT+4fZTuCnN
 ZmLVjFjakzT5vZmqWU0xoBFrRCkNJyna7Cta0uRaDojphUIGqPqrc4glotAYq37MT6oJ
 mI4L04ah8evUpLuyhGR+x34KHL/fXRhVpH422cCp3GXLNQb9htr3lF49acUQjQ1u/xJ0
 hKXgTo2lY4lW7G7W0bwpFFY6IXd4XGtfFlpuRBcnWIAtAiqpBcHizfDujG0JJr6q3qP2
 ULR/eMQIIUTI4X+d/JrfF5uP289QfMV69uaqThxEr/6IGO6PGRC35C2gXwqRhH9Uffwq NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7kq9jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 23:55:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNo4Vw158434;
        Mon, 26 Oct 2020 23:55:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34cx5wg49d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 23:55:24 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09QNtNBn013961;
        Mon, 26 Oct 2020 23:55:23 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 16:55:22 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH RFC 1/7] block: export part_stat_read_all
Date:   Tue, 27 Oct 2020 07:55:04 +0800
Message-Id: <047fe87c52b64caf1bd09eee4b1ca5130062a885.1603751876.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603751876.git.anand.jain@oracle.com>
References: <cover.1603751876.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260155
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For mirrored raid profiles such as raid1, raid1c3, raid1c4, and raid10,
currently, btrfs use the PID method to determine which one of the
mirrored devices to use to read the block. However, the PID method is
not the best choice if the devices are heterogeneous in terms of type,
speed, and size, as we may end up reading from the slower device.

Export the function part_stat_read_all() so that the btrfs can determine
the device with the least average wait time to use.

Cc: linux-block@vger.kernel.org
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 block/genhd.c         | 3 ++-
 include/linux/genhd.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0a273211fec2..81b10b90de71 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -89,7 +89,7 @@ const char *bdevname(struct block_device *bdev, char *buf)
 }
 EXPORT_SYMBOL(bdevname);
 
-static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
+void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 {
 	int cpu;
 
@@ -108,6 +108,7 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 		stat->io_ticks += ptr->io_ticks;
 	}
 }
+EXPORT_SYMBOL_GPL(part_stat_read_all);
 
 static unsigned int part_in_flight(struct hd_struct *part)
 {
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 38f23d757013..eb77e0ac8a82 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -281,6 +281,7 @@ struct disk_part_iter {
 	unsigned int		flags;
 };
 
+extern void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat);
 extern void disk_part_iter_init(struct disk_part_iter *piter,
 				 struct gendisk *disk, unsigned int flags);
 extern struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter);
-- 
2.25.1

