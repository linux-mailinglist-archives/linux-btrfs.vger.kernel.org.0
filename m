Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395D648A5B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 03:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346612AbiAKCe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 21:34:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49162 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346609AbiAKCe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 21:34:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1997C1F37B
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 02:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641868496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6AFHetrGzBVbRrJ4GPAa7MIZLZqMBzHRCHlCpzbAHA=;
        b=T61ds8Sqcz9jnzSdo0Q5rmJlWEaYhEOgSke9gWxNwwXb1gXoYtcbU0YkssEhMm7YCe8B80
        RnjqlGX2RHAX+oHssGsudAnxG207c1FjyxLRa2vxXyiUKgFullgUmNgA8QZTMMohJdnMWn
        V1KFodke4I852vzHGu+CqJrUMwdTWk0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F06E13A42
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 02:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id APlcCc/s3GERFAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 02:34:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: expand subpage support to any PAGE_SIZE > 4K
Date:   Tue, 11 Jan 2022 10:34:34 +0800
Message-Id: <20220111023434.22915-4-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111023434.22915-1-wqu@suse.com>
References: <20220111023434.22915-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the recent change in metadata handling, we can handle metadata in
the following cases:

- nodesize < PAGE_SIZE and sectorsize < PAGE_SIZE
  Go subpage routine for both metadata and data.

- nodesize < PAGE_SIZE and sectorsize >= PAGE_SIZE
  Invalid case for now. As we require nodesize >= sectorsize.

- nodesize >= PAGE_SIZE and sectorsize < PAGE_SIZE
  Go subpage routine for data, but regular page routine for metadata.

- nodesize >= PAGE_SIZE and sectorsize >= PAGE_SIZE
  Go regular page routine for both metadata and data.

Previously we require 64K page size for subpage as we need to ensure any
tree block can be fit into one page, as at that time, we don't have
support subpage metadata crossing multiple pages.

But now since we allow nodesize >= PAGE_SIZE case to regular page
routine, there is no such limitation any more.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 16 +++++++++++-----
 fs/btrfs/sysfs.c   | 11 +++++------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 884e0b543136..ffb8c811aeea 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2752,12 +2752,18 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 	}
 
 	/*
-	 * For 4K page size, we only support 4K sector size.
-	 * For 64K page size, we support 64K and 4K sector sizes.
+	 * We only support sectorsize <= PAGE_SIZE case.
+	 *
+	 * For 4K page size (e.g. x86_64), it only supports 4K sector size.
+	 * For 16K page size (e.g. PPC/ARM), it supports 4K, 8K and 16K
+	 * sector sizes.
+	 * For 64K and higher page size (e.g. PPC/ARM), it supports 4K, 8K,
+	 * 16K, 32K and 64K sector sizes (aka, all sector sizes).
+	 *
+	 * For the future, 4K will be the default sectorsize for all btrfs
+	 * and will get supported on all archtectures.
 	 */
-	if ((PAGE_SIZE == SZ_4K && sectorsize != PAGE_SIZE) ||
-	    (PAGE_SIZE == SZ_64K && (sectorsize != SZ_4K &&
-				     sectorsize != SZ_64K))) {
+	if (sectorsize > PAGE_SIZE) {
 		btrfs_err(fs_info,
 			"sectorsize %llu not yet supported for page size %lu",
 			sectorsize, PAGE_SIZE);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index beb7f72d50b8..6a01be4ef3b4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -390,13 +390,12 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 					  char *buf)
 {
 	ssize_t ret = 0;
+	u32 sectorsize;
 
-	/* 4K sector size is also supported with 64K page size */
-	if (PAGE_SIZE == SZ_64K)
-		ret += sysfs_emit_at(buf, ret, "%u ", SZ_4K);
-
-	/* Only sectorsize == PAGE_SIZE is now supported */
-	ret += sysfs_emit_at(buf, ret, "%lu\n", PAGE_SIZE);
+	/* We support any sectorsize <= PAGE_SIZE */
+	for (sectorsize = SZ_4K; sectorsize <= PAGE_SIZE; sectorsize <<= 1)
+		ret += sysfs_emit_at(buf, ret, "%u%s", sectorsize,
+				     sectorsize == PAGE_SIZE ? "\n" : " ");
 
 	return ret;
 }
-- 
2.34.1

