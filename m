Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08CEE9761E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfHUJ0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 05:26:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39708 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfHUJ0p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 05:26:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L9NpWf008175
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=kzh5l9bPyP8BZVWRQ4VfOlEADvQQcDshr/jz9WMnTJ0=;
 b=fFg5eaSjW3qwBWaF/WO6tmep9GQKmYzRKa4xojN37yzFU4SDTDMdAOmk2KBfFGVNA15m
 BgHWkmOgeEpWXh0sa0ArxZVqvl/FwNxFKglosX1I7h0C3ru27Zqz3C3h3tavYwcef5F8
 GfXesv4kErbGfy0lOyOeSrwOvoytiyhInv4foU6ZlUBRVf+4P3KWzzo6v8plPtjomUzN
 TVoZA1wsjDeKkK6WznM0BXq5NDtaFXQQts8zjSFOGh47/s0sVOEV1ZkJDLl0GwpRa5r6
 Ot0sEhHSFLgiMpoSmOJqp8beLhIQD0tqRGP5RL8o/ThNryf5JpX5KVk9BRo8t/rWdZjr jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uea7qva1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L9OPPl125253
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ug269t7sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:43 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7L9Qh1u004377
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 09:26:43 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 02:26:42 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: clean search for device item in finish sprout
Date:   Wed, 21 Aug 2019 17:26:34 +0800
Message-Id: <20190821092634.6778-3-anand.jain@oracle.com>
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

No need to btrfs_item_key_to_cpu() as we continue to next leaf. Also keep
the found_key and search key separate.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a343aa9cf5ba..1db06894aee6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2471,6 +2471,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	struct extent_buffer *leaf;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_device *device;
+	struct btrfs_key found_key;
 	struct btrfs_key key;
 	u8 fs_uuid[BTRFS_FSID_SIZE];
 	u8 dev_uuid[BTRFS_UUID_SIZE];
@@ -2498,15 +2499,13 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 				break;
 			if (ret < 0)
 				goto error;
-			leaf = path->nodes[0];
-			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 			btrfs_release_path(path);
 			continue;
 		}
 
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-		if (key.objectid != BTRFS_DEV_ITEMS_OBJECTID ||
-		    key.type != BTRFS_DEV_ITEM_KEY)
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+		if (found_key.objectid != BTRFS_DEV_ITEMS_OBJECTID ||
+		    found_key.type != BTRFS_DEV_ITEM_KEY)
 			break;
 
 		dev_item = btrfs_item_ptr(leaf, path->slots[0],
-- 
2.21.0 (Apple Git-120)

