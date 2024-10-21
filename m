Return-Path: <linux-btrfs+bounces-9022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 560629A6AF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 15:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EF71C23B30
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76351F9420;
	Mon, 21 Oct 2024 13:48:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E7323D;
	Mon, 21 Oct 2024 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518484; cv=none; b=aANC4gmABpzZ73WzXgEkAR3DB6/x0F1hs54Lx374qXRnGszo5iZM8TD5FHJUxF9ICm6GJoWewErYlulYCX08/hxpVR6kZRngC5P65UK0tTtHHh0E+g5Z7qtlzIib1lHzcesNK8BUS+hDOc+y/+wU8Dch3S3MOvrrwj5SqMRycmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518484; c=relaxed/simple;
	bh=wbvPfx4k4ND3GZ/p2WA4lION7rS+/T/Lg3SpvWUr0rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SFHFMmG69QSLvdvXYq1OXHVxFEwaktVFONmDfSga4Fc5ckDhYLA0j+mY3RDlKND9ibI3UTEgzdkVZbjUaQBcEJCGvcCdzqxCn1KQlsq10V0ucgGWc51wPlJlnHuky8cEnu4/FfmqWwa9vSca7RoTvHLKX1eqiDGnhAuJvXioqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXGpP0Vl0z4f3jXr;
	Mon, 21 Oct 2024 21:47:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6885C1A092F;
	Mon, 21 Oct 2024 21:47:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgCn28eIWxZnwijhEg--.13131S4;
	Mon, 21 Oct 2024 21:47:56 +0800 (CST)
From: Zhihao Cheng <chengzhihao@huaweicloud.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	Anand.Jain@oracle.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com
Subject: [PATCH] btrfs: Fix UAF in __btrfs_free_extra_devids()
Date: Mon, 21 Oct 2024 22:02:15 +0800
Message-Id: <20241021140215.2948551-1-chengzhihao@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28eIWxZnwijhEg--.13131S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4kWw18Xw1xWF18ZFyUGFg_yoW8uw4xpr
	n8GFy5trykWw1DCrW7W3y8C3Z3Xw4qyayrWrn8urWrK3yUAFyYvF93Cw1jg340y3ykJF1D
	Xry3W34vqrnxCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UZSdgUUUUU=
X-CM-SenderInfo: xfkh0wx2klxt3r6k3tpzhluzxrxghudrp/

From: Zhihao Cheng <chengzhihao1@huawei.com>

Mounting btrfs from two images(which have the same one fsid and two
different dev_uuids) in certain executing order may trigger an UAF
for variable 'device->bdev_file' in __btrfs_free_extra_devids(). And
following are the details:
1. Attach image_1 to loop0, attach image_2 to loop1, and scan btrfs
   devices by ioctl(BTRFS_IOC_SCAN_DEV):
             /  btrfs_device_1 → loop0
   fs_device
             \  btrfs_device_2 → loop1
2. mount /dev/loop0 /mnt
   btrfs_open_devices
    btrfs_device_1->bdev_file = btrfs_get_bdev_and_sb(loop0)
    btrfs_device_2->bdev_file = btrfs_get_bdev_and_sb(loop1)
   btrfs_fill_super
    open_ctree
     fail: btrfs_close_devices // -ENOMEM
	    btrfs_close_bdev(btrfs_device_1)
             fput(btrfs_device_1->bdev_file)
	      // btrfs_device_1->bdev_file is freed
	    btrfs_close_bdev(btrfs_device_2)
             fput(btrfs_device_2->bdev_file)
2. mount /dev/loop1 /mnt
   btrfs_open_devices
    btrfs_get_bdev_and_sb(&bdev_file)
     // EIO, btrfs_device_1->bdev_file is not assigned,
     // which points to a freed memory area
    btrfs_device_2->bdev_file = btrfs_get_bdev_and_sb(loop1)
   btrfs_fill_super
    open_ctree
     btrfs_free_extra_devids
      if (btrfs_device_1->bdev_file)
       fput(btrfs_device_1->bdev_file) // UAF !

Fix it by setting 'device->bdev_file' as 'NULL' after closing the
btrfs_device in btrfs_close_one_device().

Fixes: 142388194191 ("btrfs: do not background blkdev_put()")
CC: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219408
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8f340ad1d938..eb51b609190f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1105,6 +1105,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	if (device->bdev) {
 		fs_devices->open_devices--;
 		device->bdev = NULL;
+		device->bdev_file = NULL;
 	}
 	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	btrfs_destroy_dev_zone_info(device);
-- 
2.39.2


