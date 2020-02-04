Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862AE15193E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBDLGs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 06:06:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59598 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgBDLGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 06:06:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014An6kv181014
        for <linux-btrfs@vger.kernel.org>; Tue, 4 Feb 2020 11:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=psRNYCdy0Ic7Of7yfc+e6LRkx6eMuK7LhdDmMqY4Ruw=;
 b=dbWdjCTL0dWTF2YSD7l8oXa2pauEeDxkYK7LaFLzBhnmmJGIu2zR6OVaiSUHqrWM4fFV
 tuEDYYnp37PtufrRyhsIlC7nql2Z04sN41UX1fewAXjqrBqgVNftALiqbY580gxxWOXE
 R75CXSu3hzUv+BcY/u769VhV8b0EaaEjFeIOk2hh1S4gwwfVFFWNz9etSwRHlZegUZwE
 dWoYL+WF8WZv+LElV50lLMZ2qgL5/o0CukU2HpDNNgMFypZYF5MBCFRVlFC02UPUa15t
 PdVw9wsTWSrEnnL7bKO72eA74qOs1pegXx3wJaInheFL0gSHUihi06kUqChlKXUq9bbJ XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xw19qdxy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 11:06:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014B6fI4083533
        for <linux-btrfs@vger.kernel.org>; Tue, 4 Feb 2020 11:06:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xxsbnqvxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 11:06:42 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014B6BFv013874
        for <linux-btrfs@vger.kernel.org>; Tue, 4 Feb 2020 11:06:11 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 03:06:11 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: drop math for block_reserved which is block_rsv size
Date:   Tue,  4 Feb 2020 19:05:58 +0800
Message-Id: <1580814358-1468-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=931
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=979 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040080
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_update_global_block_rsv the lines
  num_bytes = block_rsv->size - block_rsv->reserved;
  block_rsv->reserved += num_bytes;
imply
  block_rsv->reserved = block_rsv->size;

Just assign block_rsv->size to block_rsv->reserved instead of the math.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-rsv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 6dacde9a7e93..62e0885c1e5d 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -304,9 +304,9 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 
 	if (block_rsv->reserved < block_rsv->size) {
 		num_bytes = block_rsv->size - block_rsv->reserved;
-		block_rsv->reserved += num_bytes;
 		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
 						      num_bytes);
+		block_rsv->reserved = block_rsv->size;
 	} else if (block_rsv->reserved > block_rsv->size) {
 		num_bytes = block_rsv->reserved - block_rsv->size;
 		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-- 
1.8.3.1

