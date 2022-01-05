Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38009484C7A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 03:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiAEC2g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 21:28:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiAEC2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 21:28:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78F2921129
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641349714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhPuhxOL0h9w7zGPlbQaW4iPmKdvKYSdGKmhfrPe004=;
        b=dWnMXTiJ3v8Y8pwUGwxPx23YzSjau7KV8LOZnbiH5KzOsbUzwQaMN406VBqKr+SIlNfSxd
        voKlSwLqev+0PqD3m5/fK3lXdM8dLktsapIzYnxF9JJBEjMj65bhlQo2Ye2uDrhfNy/fgg
        2U3QVYAJnqhZqXPEHhSR14D+gdQfBYw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5AE213B66
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 02:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8I4pAlEC1WHLKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jan 2022 02:28:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: expand subpage support to any PAGE_SIZE > 4K
Date:   Wed,  5 Jan 2022 10:28:12 +0800
Message-Id: <20220105022812.45698-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105022812.45698-1-wqu@suse.com>
References: <20220105022812.45698-1-wqu@suse.com>
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
 1 file changed, 11 insertions(+), 5 deletions(-)

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
-- 
2.34.1

