Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACE1ECD46
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFCKKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:10:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35300 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCKKh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 06:10:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053A8FgT151597
        for <linux-btrfs@vger.kernel.org>; Wed, 3 Jun 2020 10:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=iVxpIwl29vvOoBRDO5Qxh0p4PbSDOr7arl2yZg2MiVk=;
 b=gxhfcxXBv7k4yXsrgrER0aQ1dJLK1A0UTXVSry9oWOCdfJrswJKWOvLujBso/f15YRLP
 n1yqdToZBeVO8pmIVb0E8LKCWt3V5u3Xb+/myMU6klmU+hmAqyDf0Ep6dEgOoFgLan1o
 TLrnIChHxA+q4RT0N9kweI76AvC7ZFZT9zNSWfDWp/xe9I0uioBtNbS2XCbrtzQv5qhE
 68XJ1l7TNPTg63Nhm/NYm9042rhNSBbjISeB3FePZ3WUrjJuAQcOmR6bHwoOIhdScJIG
 Rphj4XLf3yvQGPYF0dsUoJgxKixU26fDF29xl0FO+4eJbl+37a4/nAZW/2dKVPZvaYQR qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31bewr0h80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 10:10:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053A7x2Z034705
        for <linux-btrfs@vger.kernel.org>; Wed, 3 Jun 2020 10:10:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25rpnqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 10:10:35 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 053AAZi1029568
        for <linux-btrfs@vger.kernel.org>; Wed, 3 Jun 2020 10:10:35 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 03:10:34 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use helper btrfs_get_block_group
Date:   Wed,  3 Jun 2020 18:10:20 +0800
Message-Id: <20200603101020.143372-4-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603101020.143372-1-anand.jain@oracle.com>
References: <20200603101020.143372-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=3 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=3 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the helper function where it is open coded to increment the
block_group reference count 'bg_count' so that it is less confusing
while reviewing the code. As btrfs_get_block_group() is a one-liner
we could have open-coded it, but its partner function
btrfs_put_block_group() isn't one-liner which does the free part in it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/free-space-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 169b1117c1a3..867204b48ccf 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2925,7 +2925,7 @@ void btrfs_return_cluster_to_free_space(
 		spin_unlock(&cluster->lock);
 		return;
 	}
-	atomic_inc(&block_group->bg_count);
+	btrfs_get_block_group(block_group);
 	spin_unlock(&cluster->lock);
 
 	ctl = block_group->free_space_ctl;
@@ -3355,7 +3355,7 @@ int btrfs_find_space_cluster(struct btrfs_block_group *block_group,
 		list_del_init(&entry->list);
 
 	if (!ret) {
-		atomic_inc(&block_group->bg_count);
+		btrfs_get_block_group(block_group);
 		list_add_tail(&cluster->block_group_list,
 			      &block_group->cluster_list);
 		cluster->block_group = block_group;
-- 
2.25.1

