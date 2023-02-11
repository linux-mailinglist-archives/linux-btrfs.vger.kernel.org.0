Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB5E693083
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjBKLu4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Feb 2023 06:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjBKLuz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 06:50:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C10255286
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 03:50:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A56723EDC3
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676116252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3D1tIKe622CyvgqpIAWXRDQxbv4DFk4o9ucRsHLIyrM=;
        b=aPrcVz7SwkKOYbeHLwvb9lurU00qGj6Sw2/f1j41iPoK8HO5L+jtmLEox1NIY/WSkUkh4g
        jVs2uSUa9K/Dj05nCjyZXvUKEZLdjpy9RNqD9Y+C+dYh6fSFuqC7PuhpdrdtI32F+nY+U8
        0G0xaC1NMxDPIHwlQvToXMjQbGAHDDM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0664C13A10
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AK3MMBuB52ObVgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: sync ioctl from kernel
Date:   Sat, 11 Feb 2023 19:50:31 +0800
Message-Id: <3b6d9333e90103336e49e0b6a52118617928e3e4.1676115988.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676115988.git.wqu@suse.com>
References: <cover.1676115988.git.wqu@suse.com>
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

This sync is mostly for the new member, btrfs_ioctl_dev_info_args::fsid.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 ioctl.h          | 13 ++++++++++++-
 libbtrfs/ioctl.h | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/ioctl.h b/ioctl.h
index 1af16db13241..034f38dd702a 100644
--- a/ioctl.h
+++ b/ioctl.h
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
+	 * Introduced in v6.4, thus user space still needs to
+	 * check if kernel changed this value.
+	 * Older kernel will not touch the values here.
+	 */
+	__u8 fsid[BTRFS_UUID_SIZE];
+	__u64 unused[377];			/* pad to 4k */
 	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
 };
 BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
diff --git a/libbtrfs/ioctl.h b/libbtrfs/ioctl.h
index f19695e30a63..0b19efde4915 100644
--- a/libbtrfs/ioctl.h
+++ b/libbtrfs/ioctl.h
@@ -215,7 +215,18 @@ struct btrfs_ioctl_dev_info_args {
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
 BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
-- 
2.39.1

