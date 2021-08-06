Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A233E2884
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 12:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbhHFKYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 06:24:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39044 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245151AbhHFKYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 06:24:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 122F620280;
        Fri,  6 Aug 2021 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628245459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nugh0SRsvW+C6UUVbvqWlc+sAgjtlJFQnDtQLIB1ZHc=;
        b=vI4Lqo6/jTHFtYlltkNYUXncytnykW6Xjk5OwOG+H5MbfN+nNV4x7jZNdLxJLHgpMMxCyh
        zGoArgvK6kfY8WjVOoVJcRlPZ93tWDFGrlRV2zEK/QmvhhMnpwQ3OTEK6HHyWQ77Et19LU
        JzyOc+ECZnLKjnIQlJjtAi74WYAOJwE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0781113A79;
        Fri,  6 Aug 2021 10:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3WSSLdENDWGuTAAAGKfGzw
        (envelope-from <wqu@suse.com>); Fri, 06 Aug 2021 10:24:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Subject: [PATCH] btrfs: fix NULL pointer dereference when deleting device by invalid id
Date:   Fri,  6 Aug 2021 18:24:15 +0800
Message-Id: <20210806102415.304717-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
It's super easy to trigger NULL pointer dereference, just by removing a
non-exist device id:

 # mkfs.btrfs -f -m single -d single /dev/test/scratch1 \
				     /dev/test/scratch2
 # mount /dev/test/scratch1 /mnt/btrfs
 # btrfs device remove 3 /mnt/btrfs

Then we have the following kernel NULL pointer dereference:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 9 PID: 649 Comm: btrfs Not tainted 5.14.0-rc3-custom+ #35
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 RIP: 0010:btrfs_rm_device+0x4de/0x6b0 [btrfs]
  btrfs_ioctl+0x18bb/0x3190 [btrfs]
  ? lock_is_held_type+0xa5/0x120
  ? find_held_lock.constprop.0+0x2b/0x80
  ? do_user_addr_fault+0x201/0x6a0
  ? lock_release+0xd2/0x2d0
  ? __x64_sys_ioctl+0x83/0xb0
  __x64_sys_ioctl+0x83/0xb0
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

[CAUSE]
Commit a27a94c2b0c7 ("btrfs: Make btrfs_find_device_by_devspec return
btrfs_device directly") moves the "missing" device path check into
btrfs_rm_device().

But btrfs_rm_device() itself can have case where it only receives
@devid, with NULL as @device_path.

In that case, calling strcmp() on NULL will trigger the NULL pointer
dereference.

Before that commit, we handle the "missing" case inside
btrfs_find_device_by_devspec(), which will not check @device_path at all
if @devid is provided, thus no way to trigger the bug.

[FIX]
Before calling strcmp(), also make sure @device_path is not NULL.

Fixes: a27a94c2b0c7 ("btrfs: Make btrfs_find_device_by_devspec return btrfs_device directly")
Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 230192d097c4..5156254a9655 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2079,7 +2079,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 
 	if (IS_ERR(device)) {
 		if (PTR_ERR(device) == -ENOENT &&
-		    strcmp(device_path, "missing") == 0)
+		    device_path && strcmp(device_path, "missing") == 0)
 			ret = BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
 		else
 			ret = PTR_ERR(device);
-- 
2.32.0

