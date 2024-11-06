Return-Path: <linux-btrfs+bounces-9353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F239BDC7C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 03:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B327E283CEA
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 02:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B31E04A2;
	Wed,  6 Nov 2024 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrvb1GjU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6CC19066B;
	Wed,  6 Nov 2024 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859158; cv=none; b=VONokXgmmYzahQ+EB3UWV38opkVKp6f1KRKovaREvRAahGwLcrt3fl5ilE+SQC2NeNHsJe3RP1Kwo/9lymQ7f9Xd8Zncyhh7DkljA31hZ+h0G5URLmvf2Obkk/VtACbnwRWxwkzvWPo0+MPUBC2TKS1BDWkZ5k9rS+tbcdXZMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859158; c=relaxed/simple;
	bh=xYv2q5+y/jFqolt3LNkFi9zvPdqElsu3XZIBDXT/qZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I1gePBhJHQ2B2lX7wvVY7R39/I3+BW4dva5sbEd5lnntnmvrz2KE3RAkvySWJizG39Zrkth6KEiVQqgA8xjWoZjrDRElqdXh5woo3RIJs1FHKAX4xToKXkAx8dwItlKGyaTnAdhr1lNRoMJr6sVA5AkaO9F7G2CnWh+B4sVRKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrvb1GjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF03C4CECF;
	Wed,  6 Nov 2024 02:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859157;
	bh=xYv2q5+y/jFqolt3LNkFi9zvPdqElsu3XZIBDXT/qZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qrvb1GjUn+2vti7vHoKkrdmc0ygfYTyRIxskJm9E4s2Uni9i8Vkeuddj5inLimBnf
	 7qsFAPHjcrXso87mcj20MHCMLDg+10yysGvGp2/eR4oo9plGwPhgYXmc9yxlJ2ahpJ
	 a1KVYmpKzqDrV+evEFyFObl3vJnFyaty2bs1MyoS/S1nAyDuFy/lImcaaKF2Pkwn8Q
	 AdaTKj6XH/Fd/FjPkKmUxtpk0ubnIl5xVpZR+vjcVRrnvy/yjgYGWpxZnuf/xeYd8k
	 qgsR/tPfilf79PLe3auouSuqhA2K44xUeL4429CcggYHOKxwjDLuURxvDwAloeCQVc
	 VODRPhHL0WO5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chengzhihao1@huawei.com
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()" failed to apply to v5.10-stable tree
Date: Tue,  5 Nov 2024 21:12:34 -0500
Message-ID: <20241106021235.183010-1-sashal@kernel.org>
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

The patch below does not apply to the v5.10-stable tree.
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





