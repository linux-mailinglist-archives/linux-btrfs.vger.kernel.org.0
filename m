Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16BD6BF6C6
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Mar 2023 01:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCRAIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 20:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCRAIM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 20:08:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AFEC14A
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 17:08:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E94C219C2
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Mar 2023 00:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679098088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tSKHfLG78lFQsg2PUnMXZSdL83PDqUtqwmZGOHl4QdI=;
        b=RWEhx+pY/wjwtOyJ93o7KEX+RJPyYb3eZ1os7mVxrMs2JV8z+WJVi3jWncyBTSQdVt1sbG
        bmutB6IBJtIeyle5nTJE34lieYSbmFd0ejhmhqXyG94ng6W6zCVXudQFJ1DPZW6VPEZBWg
        a+JQBe3wleORvGCX0kLbZOwQersRl3E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E007413443
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Mar 2023 00:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XbMzK+cAFWTODwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Mar 2023 00:08:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: sync ioctl from kernel
Date:   Sat, 18 Mar 2023 08:07:50 +0800
Message-Id: <4fbc61d726ee1830d3e24313b7bf6f8a763951a1.1679098064.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This sync is mostly for the new member, btrfs_ioctl_dev_info_args::fsid.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Separate from the btrfs/249 fix
  The btrfs/249 fallback fix is a little too niche, and the proper fix is
  already merged

- Only sync to "include/ioctl.h" and "libbtrfsutil/btrfs.h"
---
 include/ioctl.h      | 13 ++++++++++++-
 libbtrfsutil/btrfs.h | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/ioctl.h b/include/ioctl.h
index 1af16db13241..d8a8bb9cad3d 100644
--- a/include/ioctl.h
+++ b/include/ioctl.h
@@ -214,7 +214,18 @@ struct btrfs_ioctl_dev_info_args {
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
+	 * Introduced in v6.3, thus user space still needs to
+	 * check if kernel changed this value.
+	 * Older kernel will not touch the values here.
+	 */
+	__u8 fsid[BTRFS_UUID_SIZE];
+	__u64 unused[377];			/* pad to 4k */
 	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
 };
 BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 0d863d58ec23..d9415ea2faed 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -224,7 +224,18 @@ struct btrfs_ioctl_dev_info_args {
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
+	 * Introduced in v6.3, thus user space still needs to
+	 * check if kernel changed this value.
+	 * Older kernel will not touch the values here.
+	 */
+	__u8 fsid[BTRFS_UUID_SIZE];
+	__u64 unused[377];			/* pad to 4k */
 	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
 };
 
-- 
2.39.2

