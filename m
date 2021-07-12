Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB23C57B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352956AbhGLIg4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 04:36:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60694 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354962AbhGLIdZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 04:33:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E49C22102;
        Mon, 12 Jul 2021 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626078636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2lKPyrPC+vGVEY72pLZq4K5ZPQEIw8Swdq53gVWTAQ=;
        b=Swf9S2CastFgmuWHxArb3lw91UwKS/krUGakvq4KreM2DNADgRuAjTmhTdejNuxzQAS/Lj
        O6kwUklP3RpdImIo8+tVQseD6COGU+iC1Ih9pMQefgbT5Wu2/PZvt29DRRwKJ8d0Lt3pBz
        p9HlEH4AY/1N0DiutNFAsGZAxv1tQq0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 34C5113455;
        Mon, 12 Jul 2021 08:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WEAGOar962ByEAAAGKfGzw
        (envelope-from <wqu@suse.com>); Mon, 12 Jul 2021 08:30:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 03/17] btrfs: disable compressed readahead for subpage
Date:   Mon, 12 Jul 2021 16:30:13 +0800
Message-Id: <20210712083027.212734-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712083027.212734-1-wqu@suse.com>
References: <20210712083027.212734-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For current subpage support, we only support 64K page size with 4K
sector size.

This makes compressed readahead less effective, as maximum compressed
extent size is only 128K, 2x the page size.

On the other hand, the function add_ra_bio_pages() is still assuming
sectorsize == PAGE_SIZE, and code change may affect 4K page size
systems.

So for now, let's disable subpage compressed readahead for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d40c2c878c83..f17be6398d2c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -564,6 +564,16 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	if (isize == 0)
 		return 0;
 
+	/*
+	 * For current subpage support, we only support 64K page size,
+	 * which means maximum compressed extent size (128K) is just 2x page
+	 * size.
+	 * This makes readahead less effective, so here disable readahead for
+	 * subpage support for now, until full compressed write is supported.
+	 */
+	if (btrfs_sb(inode->i_sb)->sectorsize < PAGE_SIZE)
+		return 0;
+
 	end_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
 	while (last_offset < compressed_end) {
-- 
2.32.0

