Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8352D6930C6
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 12:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBKL7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Feb 2023 06:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjBKL6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 06:58:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C1732CC7
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 03:58:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEE335D425
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676116405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=luw8uBzuGKU7A/TVL9JJXVWk7xN1W+gSBhwvVvOx6pI=;
        b=hKO9n9oKFu6vDDkYhoNZ5K+8IkIeGq4m8g7Vtt9cmnEXxJTzvOreUmXqn/rjN9zPF84A2H
        ny2kwBaiNFN0A2XokGcJxY65BJQQb6NWx7QwGjU0/AGrnLf8PKR/84rGty0rVirKghMjbg
        kQilu+5KLdKKaK8loGEii79XdIKVJ2M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 137EA13A10
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1AD1MrSB52N5VwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:53:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: ioctl: allow dev info ioctl to return fsid of a device
Date:   Sat, 11 Feb 2023 19:53:05 +0800
Message-Id: <c3e2ff2f10b0da711a619745495bb8e8c80c1ad0.1676116309.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently user space utilize dev info ioctl to grab the info of a
certain devid, this includes its device uuid.

But the return info is not enough to determine if a device is a seed.

This patch will add a new member, fsid, into btrfs_ioctl_dev_info_args,
and populate the member with fsid value.

This should not cause any compatibility problem, following the following
combination:

- Old user space, old kernel
- Old user space, new kernel
  User space tool won't even check the new member.

- New user space, old kernel
  The kernel won't touch the new member, and user space tool should
  zero out its argument, thus the new member is all zero.

  User space tool can then know the kernel doesn't support this fsid
  reporting, and falls back to whatever they can.

- New user space, new kernel
  Go as planned.

  Would found the fsid member is no longer zero, and trust its value.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
v2:
- Fix the wrong padding number
  I doubt why we stick with u64, not u8 for padding, which is way less
  bug-prone.
---
 fs/btrfs/ioctl.c           |  1 +
 include/uapi/linux/btrfs.h | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e348bd2ccde..d10272efd2a8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2859,6 +2859,7 @@ static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
 	di_args->bytes_used = btrfs_device_get_bytes_used(dev);
 	di_args->total_bytes = btrfs_device_get_total_bytes(dev);
 	memcpy(di_args->uuid, dev->uuid, sizeof(di_args->uuid));
+	memcpy(di_args->fsid, dev->fs_devices->fsid, BTRFS_UUID_SIZE);
 	if (dev->name)
 		strscpy(di_args->path, btrfs_dev_name(dev), sizeof(di_args->path));
 	else
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index b4f0f9531119..cbb22dbdd108 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -245,7 +245,18 @@ struct btrfs_ioctl_dev_info_args {
 	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
 	__u64 bytes_used;			/* out */
 	__u64 total_bytes;			/* out */
-	__u64 unused[379];			/* pad to 4k */
+	/*
+	 * Optional, out.
+	 *
+	 * Showing the fsid of the device, allowing user space
+	 * to check if this device is a seed one.
+	 *
+	 * Introduced in v6.4, thus user space still needs to
+	 * check if kernel changed this value.
+	 * Older kernel will not touch the values here.
+	 */
+	__u8 fsid[BTRFS_UUID_SIZE];
+	__u64 unused[377];			/* pad to 4k */
 	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
 };
 
-- 
2.39.1

