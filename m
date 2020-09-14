Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE9C2687FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgINJLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 05:11:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35844 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgINJLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 05:11:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08E998ED145846
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 09:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=0qfr+5BdZ576Zw7uQcLlLGNx8FIAJihimEvbUjvywH0=;
 b=M2YtDaT4FoJ0bj3nDN8fUk4Oux6PoKu8bKTKhT0mrKpMCfo8JgyPi+0NFWkszZ+ySV+y
 przFBsMhwcgnnFfIcuaXYTPw96R1dsF2tscVaHZrZuq7eOS6UH2RVUScl9cxrHZj6k7M
 pdeYC3lF+u8VgjVZmvQFbi/6ONaPa2VsqVhEL5Pthw9/A2Kl5kBoQBEiVD1Iyd0BpmVs
 y/8h7IA+0M7mPrCQlamHB8MyxWJVyxnYBODCHRchU41fdn87icLVqGpMOpy7XFOqCNPP
 9KIjknMWqIfQLZhMXwHrdt09ke2m2MJ1dLZSOV6jexoWGvfCAevgiAmCgW7bRF2QIs87 Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33gp9kwb6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 09:11:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08E9BLPV114101
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 09:11:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33h880v18s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 09:11:35 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08E9BYwp026382
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 09:11:35 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Sep 2020 09:11:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: add a warning to check on the leaking device close
Date:   Mon, 14 Sep 2020 17:11:14 +0800
Message-Id: <8ad72827dc32542915f87db73cbb6b609f24dce4.1600074377.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9743 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=3 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009140078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9743 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=3 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009140078
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To help better understand the device-close leaks, add a warning if the
device freed is still open.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2d5cc644741e..c0dfc0b569e9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -371,6 +371,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 void btrfs_free_device(struct btrfs_device *device)
 {
 	WARN_ON(!list_empty(&device->post_commit_list));
+	WARN_ON(device->bdev);
 	rcu_string_free(device->name);
 	extent_io_tree_release(&device->alloc_state);
 	bio_put(device->flush_bio);
-- 
2.25.1

