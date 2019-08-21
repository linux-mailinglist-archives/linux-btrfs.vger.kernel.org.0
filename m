Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1379761C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfHUJ0m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 05:26:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34494 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfHUJ0m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 05:26:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L9Nl2n021104
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=LeMoMW8S6hZyFhKhilVFBcZn3TCc93dnVf8CjtWxEIM=;
 b=G5AEsN/nm40rZbEaxnVu+swHcy/Scbuy2IvfoJkwgE+Qjywrd5/WdbTwU8ckfQHnsu7x
 p7USdk0nP/0/3NfgGGfaUpAvAQz8e4zpvz8nI2JNXywiqB61xeJlYbc/VLbQOjy/00je
 o/AlZ2Ae2kTpqZ/1utR7505IYrv7JP4gTr6C6skYomi/6s5zkjjGxkCKIsUTjbyqGa3G
 G0ihDT292ZfSisHb8ikMZuu3+SlGGSQqOQYno8WSCqyo/+qSWHmehdPnYk1R0KTZaqLw
 PRzSK4wl1wwnW1f/kCA34os6EMi+uP49IgEf/ZFgNcn2EqhJ5/aSaGHS0nt1Wjn9w7wg NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ue9hpm913-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L9Niep148911
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2ugj7pq5md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7L9Qem2013372
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:40 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 02:26:39 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: dev stats item key conversion per cpu type is not needed
Date:   Wed, 21 Aug 2019 17:26:33 +0800
Message-Id: <20190821092634.6778-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190821092634.6778-1-anand.jain@oracle.com>
References: <20190821092634.6778-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

%found_key is not used, drop it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bd279db0f760..a343aa9cf5ba 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7278,7 +7278,6 @@ void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_key key;
-	struct btrfs_key found_key;
 	struct btrfs_root *dev_root = fs_info->dev_root;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct extent_buffer *eb;
@@ -7310,7 +7309,6 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 		}
 		slot = path->slots[0];
 		eb = path->nodes[0];
-		btrfs_item_key_to_cpu(eb, &found_key, slot);
 		item_size = btrfs_item_size_nr(eb, slot);
 
 		ptr = btrfs_item_ptr(eb, slot,
-- 
2.21.0 (Apple Git-120)

