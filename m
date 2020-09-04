Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DF925E0E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgIDRfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49630 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIDRe6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:34:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HXrpU037461;
        Fri, 4 Sep 2020 17:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ZOEeqNICBEG/hjDxxqITNh6GC06gLPMSF/ucQSM7B48=;
 b=HlIidEnf3xwqySaDPh537Qcijv9VLU/dm7bHgcat55oBsYLhulp0ahHHhraSdGtnOjv9
 o/eCLPHRpMUPMH1qjp6jncn8rLAiPf77PD/hnBV8iIiVuRRmAUanG/s2fJiwcWEvGYz4
 6MAfVJEw08bKH07v/qv26KefXLJRF22ZlpS5/usnrA4MwQCxkfOUUZxHyTki+T+AzLwr
 an1XI9M0oALOKkXRYOzLdgXwvFu65LhwQNq4+T7PkMdChG7rdiQPiyoGeItnZivCOvKt
 ZAKjKo2a7/jh5dvqTF2lgHrZWAwK+BtJJdkKTuQaDJxXjzHlwRPvQ6AI1xs25fMRV0Sh iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 339dmne37c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:34:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HUkYK090220;
        Fri, 4 Sep 2020 17:34:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3380xds626-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:34:52 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084HYpwJ005702;
        Fri, 4 Sep 2020 17:34:51 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:34:51 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 02/16] btrfs: fix replace of seed device
Date:   Sat,  5 Sep 2020 01:34:22 +0800
Message-Id: <f7c10bdf70331c29f88cfa2e0dd7e46d2a512b47.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040152
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If you replace a seed device in a sprouted fs, it appears to have
successfully replaced the seed device, but if you look closely, it didn't.

Here is an example.

mkfs.btrfs -fq /dev/sda
btrfstune -S1 /dev/sda
mount /dev/sda /btrfs
btrfs dev add /dev/sdb /btrfs
umount /btrfs; btrfs dev scan --forget
mount -o device=/dev/sda /dev/sdb /btrfs
btrfs rep start -f /dev/sda /dev/sdc /btrfs; echo $?
0

  BTRFS info (device sdb): dev_replace from /dev/sda (devid 1) to /dev/sdc started
  BTRFS info (device sdb): dev_replace from /dev/sda (devid 1) to /dev/sdc finished

btrfs fi show
Label: none  uuid: ab2c88b7-be81-4a7e-9849-c3666e7f9f4f
	Total devices 2 FS bytes used 256.00KiB
	devid    1 size 3.00GiB used 520.00MiB path /dev/sdc
	devid    2 size 3.00GiB used 896.00MiB path /dev/sdb

Label: none  uuid: 10bd3202-0415-43af-96a8-d5409f310a7e
	Total devices 1 FS bytes used 128.00KiB
	devid    1 size 3.00GiB used 536.00MiB path /dev/sda

So as per the replace start command and kernel log replace was successful.

Now let's try to clean mount.

umount /btrfs;  btrfs dev scan --forget

mount -o device=/dev/sdc /dev/sdb /btrfs
mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/sdb, missing codepage or helper program, or other error.

[  636.157517] BTRFS error (device sdc): failed to read chunk tree: -2
[  636.180177] BTRFS error (device sdc): open_ctree failed

That's because per dev items it is still looking for the original seed
device.

btrfs in dump-tree -d /dev/sdb

	item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
		devid 1 total_bytes 3221225472 bytes_used 545259520
		io_align 4096 io_width 4096 sector_size 4096 type 0
		generation 6 start_offset 0 dev_group 0
		seek_speed 0 bandwidth 0
		uuid 59368f50-9af2-4b17-91da-8a783cc418d4  <--- seed uuid
		fsid 10bd3202-0415-43af-96a8-d5409f310a7e  <--- seed fsid
	item 1 key (DEV_ITEMS DEV_ITEM 2) itemoff 16087 itemsize 98
		devid 2 total_bytes 3221225472 bytes_used 939524096
		io_align 4096 io_width 4096 sector_size 4096 type 0
		generation 0 start_offset 0 dev_group 0
		seek_speed 0 bandwidth 0
		uuid 56a0a6bc-4630-4998-8daf-3c3030c4256a  <- sprout uuid
		fsid ab2c88b7-be81-4a7e-9849-c3666e7f9f4f <- sprout fsid

But the replaced target has the following uuid+fsid in its superblock
which doesn't match with the expected uuid+fsid in its devitem.

btrfs in dump-super /dev/sdc | egrep '^generation|dev_item.uuid|dev_item.fsid|devid'
generation	20
dev_item.uuid	59368f50-9af2-4b17-91da-8a783cc418d4
dev_item.fsid	ab2c88b7-be81-4a7e-9849-c3666e7f9f4f [match]
dev_item.devid	1

So if you provide the original seed device the mount shall be successful.
Which so long happening in the test case btrfs/163.

btrfs dev scan --forget
mount -o device=/dev/sda /dev/sdb /btrfs

Fix in this patch:
If a seed is not sprouted then there is no replacement of it, because of
its RO filesystem with an RO device. Similarly, in the case of a sprouted
filesystem, the seed device is still RO. So, mark it as you can't replace
a seed device, you can only add a new device and then delete the seed
device. If replace is attempted then returns -EINVAL.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 580e60fe07d0..7637b1f02c63 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -230,7 +230,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 
 	*device_out = NULL;
-	if (fs_info->fs_devices->seeding) {
+	if (srcdev->fs_devices->seeding) {
 		btrfs_err(fs_info, "the filesystem is a seed filesystem!");
 		return -EINVAL;
 	}
-- 
2.25.1

