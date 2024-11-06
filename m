Return-Path: <linux-btrfs+bounces-9352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6C9BDC54
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 03:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4901C2032E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 02:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323EF1DE4EA;
	Wed,  6 Nov 2024 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3MPQCwy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF901991C3;
	Wed,  6 Nov 2024 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859103; cv=none; b=DfiKn2q8Edp8mrOIbOoleT22b1VtiIb7Q4I4HjSqFQ6w6s14jsSxAxnmsjWgqZXnw7Qw1ZIimPjRDqjNFd1SkjamIAl8zahkD86C/d3UpDuAsVtC5LJ5SvIbXHdQn1aJeeN6qq5FplgY2DIjeG81Vc3u64mhwg2YCDnIzRbrqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859103; c=relaxed/simple;
	bh=dArZ5O3BV7Wmscyd9tx3w06lMeP5aBch2T1dtyCoZO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DbPe8HXzoG3m5FZ/3omP6rwbhW3WAMY/0PMV0lsD1RTAXm4Ws+8T7R9MUfknejq3zD8TJ2Gy8Fvf9ZlLNIqiqjvImkU4jDT0EVl0Ann5KqBKRJ0REY+1fIz30vxrqmA0X//vCxJJrdGan5AJqss+N7mAojmt8TAvqMNCRWMHyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3MPQCwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B259C4CECF;
	Wed,  6 Nov 2024 02:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859103;
	bh=dArZ5O3BV7Wmscyd9tx3w06lMeP5aBch2T1dtyCoZO8=;
	h=From:To:Cc:Subject:Date:From;
	b=X3MPQCwy+oDgyt3+eByV9OxzGbtaXob1yXD1Rmt+KrE5znE8LUsOdCRzwbdmkAhDS
	 2iuDt86zlkmHl/dSU1YIpW+X11/rfeuPYJ4N29RA4/l76KPBhUj2EXSxJqD9UwxOus
	 8YVYcwM7h5YCtnb1lmNvyb7TIN8T+uk3Es75p4d6DorhYQ8KOCTikzAdziutn6zO8/
	 AuPfRWChf5GeA5bYVOnfMOu7OTo/Uq/aGhNmprYvgnd+4aOgSR8rl+qBk8Lei7c6/t
	 ++oXaVZ9A2XKP4BR3xx21EyBzs1kQt9KWwDqHMticF9dyB+jPGDKCEgVDwfLtt8emu
	 vDSI3Y161+RtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chengzhihao1@huawei.com
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()" failed to apply to v5.15-stable tree
Date: Tue,  5 Nov 2024 21:11:39 -0500
Message-ID: <20241106021140.182370-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From aec8e6bf839101784f3ef037dcdb9432c3f32343 Mon Sep 17 00:00:00 2001
From: Zhihao Cheng <chengzhihao1@huawei.com>
Date: Mon, 21 Oct 2024 22:02:15 +0800
Subject: [PATCH] btrfs: fix use-after-free of block device file in
 __btrfs_free_extra_devids()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mounting btrfs from two images (which have the same one fsid and two
different dev_uuids) in certain executing order may trigger an UAF for
variable 'device->bdev_file' in __btrfs_free_extra_devids(). And
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

3. mount /dev/loop1 /mnt
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
CC: stable@vger.kernel.org # 4.19+
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219408
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8f340ad1d9384..eb51b609190fb 100644
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
2.43.0





