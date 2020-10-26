Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7DB299F1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 01:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411000AbgJZXzz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 19:55:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49204 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410904AbgJZXz2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 19:55:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNn3Jd007463;
        Mon, 26 Oct 2020 23:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=8/0gPSKV0KmfUImax6hqcL3jMFWQsE2a8ICFQIxguNs=;
 b=GeDbRiaYfHBmLB/bG7E303ownCqAx8/HfPOcx9XM4kjfboWQ0C8zI5KY9+s/Bg7tYLTK
 QLfFc48U++qwHTxty2fl0zSm9zbWlkurOR1kE0bBb2eOPnk+WyFduXvxWdoZiuYxERmT
 0wHL8s3sM4zcM8dzg6WWvWXeRQS/LwpOZaCeSOLP/j/YEuoiCuShV0cOnmkqxsLwWjG7
 jen/fg/KPeXlQuwsgtbJUrN+/Zc0an7Gr7A/NYAc7Iy/CMHk+XbdDFljGCqtJBSBrhar
 FD31hEulXip6eX4q3ZFsPsH0tKlMgCBB/IvGdDa1Y7lkK5CAItdM0GYFJF7EgveB0DJz yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7kq9jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 23:55:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNnxVn157963;
        Mon, 26 Oct 2020 23:55:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34cx5wg49t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 23:55:26 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QNtPAi003347;
        Mon, 26 Oct 2020 23:55:25 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 16:55:24 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH RFC 2/7] block: export part_stat_read_inflight
Date:   Tue, 27 Oct 2020 07:55:05 +0800
Message-Id: <187d1f02f82019d48f66c97c0d1b99c9a58cd553.1603751876.git.anand.jain@oracle.com>
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
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260155
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The exported function part_in_flight() returns commands in-flight in the
given block device.

Cc: linux-block@vger.kernel.org
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 block/genhd.c         | 19 +++++++++++--------
 include/linux/genhd.h |  2 ++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 81b10b90de71..21876d4cf2fb 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -125,6 +125,15 @@ static unsigned int part_in_flight(struct hd_struct *part)
 	return inflight;
 }
 
+unsigned int part_stat_read_inflight(struct request_queue *q, struct hd_struct *p)
+{
+	if (queue_is_mq(q))
+		return blk_mq_in_flight(q, p);
+	else
+		return part_in_flight(p);
+}
+EXPORT_SYMBOL_GPL(part_stat_read_inflight);
+
 static void part_in_flight_rw(struct hd_struct *part, unsigned int inflight[2])
 {
 	int cpu;
@@ -1291,10 +1300,7 @@ ssize_t part_stat_show(struct device *dev,
 	unsigned int inflight;
 
 	part_stat_read_all(p, &stat);
-	if (queue_is_mq(q))
-		inflight = blk_mq_in_flight(q, p);
-	else
-		inflight = part_in_flight(p);
+	inflight = part_stat_read_inflight(q, p);
 
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
@@ -1613,10 +1619,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
 		part_stat_read_all(hd, &stat);
-		if (queue_is_mq(gp->queue))
-			inflight = blk_mq_in_flight(gp->queue, hd);
-		else
-			inflight = part_in_flight(hd);
+		inflight = part_stat_read_inflight(gp->queue, hd);
 
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index eb77e0ac8a82..93dd7a96d444 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -282,6 +282,8 @@ struct disk_part_iter {
 };
 
 extern void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat);
+extern unsigned int part_stat_read_inflight(struct request_queue *q,
+					    struct hd_struct *part);
 extern void disk_part_iter_init(struct disk_part_iter *piter,
 				 struct gendisk *disk, unsigned int flags);
 extern struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter);
-- 
2.25.1

