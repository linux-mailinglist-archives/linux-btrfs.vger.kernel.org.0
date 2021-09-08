Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447D0403EDA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhIHSGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 14:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhIHSGz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 14:06:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9749561157
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631124347;
        bh=uFHWflZNlCMnWy9DFeIDTkMweZikBXF3uJyTiY4t/gc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hxPn/DpWb+PsbK5qJ0YeL8aNXLKwb7bsBEm/wfIEPtLekUio9zWXa3PvuunRw4RaW
         OYks0lv1LRRCkG++iatfmTFkKcdQuG1atXJKSPvTDjPNja9U+x6ibTsX4M7xdgxgr2
         bkHypgUrK5d0aTmHDldzvFsO8IDdbkp5CHv/S8JEeO2oBzQEnrv3swaCLw02e1c/Bj
         svpKm3iVomRFbWwBVHZyisFR9RvoAScQfKtfO51APebjys6nwr/t0+ZBCK6/T2788X
         uTKjovCj9xCgSL/iVH6j8EXcrBiipzplOkU51QKdnEc68cvsy1u6cjgNU0pBAb70HG
         FBsgURufKcNmQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: fix mount failure due to past and transient device flush error
Date:   Wed,  8 Sep 2021 19:05:44 +0100
Message-Id: <893dad4768973411df7867e4436fe728d989fe1a.1631122173.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dcf9de78faa6ec5cef443d031a987c87301805b1.1631026981.git.fdmanana@suse.com>
References: <dcf9de78faa6ec5cef443d031a987c87301805b1.1631026981.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we get an error flushing one device, during a super block commit, we
record the error in the device structure, in the field 'last_flush_error'.
This is used to later check if we should error out the super block commit,
depending on whether the number of flush errors is greater than or equals
to the maximum tolerated device failures for a raid profile.

However if we get a transient device flush error, unmount the filesystem
and later try to mount it, we can fail the mount because we treat that
past error as critical and consider the device is missing. Even if it's
very likely that the error will happen again, as it's probably due to a
hardware related problem, there may be cases where the error might not
happen again. One example is during testing, and a test case like the
new generic/648 from fstests always triggers this. The test cases
generic/019 and generic/475 also trigger this scenario, but very
sporadically.

When this happens we get an error like this:

  $ mount /dev/sdc /mnt
  mount: /mnt wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.

  $ dmesg
  (...)
  [12918.886926] BTRFS warning (device sdc): chunk 13631488 missing 1 devices, max tolerance is 0 for writable mount
  [12918.888293] BTRFS warning (device sdc): writable mount is not allowed due to too many missing devices
  [12918.890853] BTRFS error (device sdc): open_ctree failed

The failure happens because when btrfs_check_rw_degradable() is called at
mount time, or at remount from RO to RW time, is sees a non zero value in
a device's ->last_flush_error attribute, and therefore considers that the
device is 'missing'.

Fix this by setting a device's ->last_flush_error to zero when we close a
device, making sure the error is not seen on the next mount attempt. We
only need to track flush errors during the current mount, so that we never
commit a super block if such errors happened.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V3: Use a different and cleaner approach, by reseting the flush error
    from a device when we close it, so that it's not seen on the next
    mount attempt.

 fs/btrfs/volumes.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b81f25eed298..2101a5bd4eba 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1137,6 +1137,19 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	atomic_set(&device->dev_stats_ccnt, 0);
 	extent_io_tree_release(&device->alloc_state);
 
+	/*
+	 * Reset the flush error record. We might have a transient flush error
+	 * in this mount, and if so we aborted the current transaction and set
+	 * the fs to an error state, guaranteeing no super blocks can be further
+	 * committed. However that error might be transient and if we unmount the
+	 * filesystem and mount it again, we should allow the mount to succeed
+	 * (btrfs_check_rw_degradable() should not fail) - if after mounting the
+	 * filesystem again we still get flush errors, then we will again abort
+	 * any transaction and set the error state, guaranteeing no commits of
+	 * unsafe super blocks.
+	 */
+	device->last_flush_error = 0;
+
 	/* Verify the device is back in a pristine state  */
 	ASSERT(!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
 	ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
-- 
2.33.0

