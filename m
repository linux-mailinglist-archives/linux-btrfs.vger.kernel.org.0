Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813B559120
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 04:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfF1C0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 22:26:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54036 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfF1C0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 22:26:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S2O9BU075424
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2019 02:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=eG38gVkWA/n2JX8GA49uoBUIe+HGZHQ0grPCoVTd+Hk=;
 b=tVOAGjYw5DuNzZTb+xlpSer0tJg/VVhiOE4lDd7EQTfD4rErNRUGqazzbyncBZLuvoe7
 TKMYniyjOucFRN/BmMhNiYgi7OFDThY7L8qCHco7Axkvh7s6r6XmA9x6rGZouRX3PaSt
 NRijM3mnXpIi/4TosLVmbDSRqtvQQFi1KrwnVGLInyTnoY1PAx0TeHAu7vE0A4TQU1qv
 p4O/zosWer+ri2b1cU8s2mM06wG0hUneUwr/+yQuNLdCQfMp0q53xMOraFKZPmS1DwXb
 YRZiChRWCpsPZE/JUcqzYo+JB5M4fbdzOR9EVaaPLjcetO0IiR7SpMMkHLGqs0QUIy7W Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9q37kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2019 02:26:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S2PVGC150850
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2019 02:26:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tat7dpsda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2019 02:26:16 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5S2QFbp012835
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2019 02:26:16 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 19:26:15 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
Date:   Fri, 28 Jun 2019 10:26:11 +0800
Message-Id: <20190628022611.2844-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280021
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At the time mkfs.btrfs the device id and stripe index gets reversed as
shown in [1]. This patch helps to keep them in order at the time of
mkfs.btrfs. And makes it easier to debug.

Before:
Stripe 0 is on devid 2; Stipe 1 is on devid 1;

./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in dump-tree -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000 "device tree" | grep -A 13  "FIRST_CHUNK_TREE CHUNK_ITEM"
	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15975 itemsize 112
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 2 offset 1048576
			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
			stripe 1 devid 1 offset 22020096
			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsize 112
		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 2 offset 9437184
			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
			stripe 1 devid 1 offset 30408704
			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 itemsize 112
		length 314572800 owner 2 stripe_len 65536 type DATA|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 2 offset 277872640
			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
			stripe 1 devid 1 offset 298844160
			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab

After:
Stripe 0 is on devid 1; Stripe 1 is on devid 2

./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in dump-tree -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000 "device tree" | grep -A 13  "FIRST_CHUNK_TREE CHUNK_ITEM"
/dev/sdb: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52 66 53 5f 4d
/dev/sdc: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52 66 53 5f 4d
	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15975 itemsize 112
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 1 offset 22020096
			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
			stripe 1 devid 2 offset 1048576
			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsize 112
		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 1 offset 30408704
			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
			stripe 1 devid 2 offset 9437184
			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 itemsize 112
		length 314572800 owner 2 stripe_len 65536 type DATA|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 0
			stripe 0 devid 1 offset 298844160
			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
			stripe 1 devid 2 offset 277872640
			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/volumes.c b/volumes.c
index 79d1d6a07fb7..8c8b17e814b8 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1109,7 +1109,7 @@ again:
 			return ret;
 		cur = cur->next;
 		if (avail >= min_free) {
-			list_move_tail(&device->dev_list, &private_devs);
+			list_move(&device->dev_list, &private_devs);
 			index++;
 			if (type & BTRFS_BLOCK_GROUP_DUP)
 				index++;
@@ -1166,7 +1166,7 @@ again:
 		/* loop over this device again if we're doing a dup group */
 		if (!(type & BTRFS_BLOCK_GROUP_DUP) ||
 		    (index == num_stripes - 1))
-			list_move_tail(&device->dev_list, dev_list);
+			list_move(&device->dev_list, dev_list);
 
 		ret = btrfs_alloc_dev_extent(trans, device, key.offset,
 			     calc_size, &dev_offset);
-- 
2.20.1 (Apple Git-117)

