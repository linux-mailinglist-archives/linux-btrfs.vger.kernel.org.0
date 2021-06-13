Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446A63A58D2
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhFMNnH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34596 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNnF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:05 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F05E21972;
        Sun, 13 Jun 2021 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsIJK/Xhj43RCQxVzm3n65e3ZnHxsC5vOFgMkRLxiIQ=;
        b=lXUoF6v1wdnjlPHqyJIPNH4UTGTd0wxG6Rhdyxjn+b6QTXuzswhRF0w9wB9PXgCLm+XCB+
        LobnipDVqkthvOxezM9mJJGIb0o1wJdDj2tp3DGpXr6YVIFZqFirz4zKN3ZlSHoB5xG0en
        GpW2k5LgiKgBIDTvoU3yvMV3I1s3l8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsIJK/Xhj43RCQxVzm3n65e3ZnHxsC5vOFgMkRLxiIQ=;
        b=VPJcX25rJUisx+RLcrgsbRrK4yGK+1eUajDeZOV7on6wOYwItRn/OCyiuzOaS+9CAtCoT2
        lpKcRP68GlDi5bAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id ED478118DD;
        Sun, 13 Jun 2021 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsIJK/Xhj43RCQxVzm3n65e3ZnHxsC5vOFgMkRLxiIQ=;
        b=lXUoF6v1wdnjlPHqyJIPNH4UTGTd0wxG6Rhdyxjn+b6QTXuzswhRF0w9wB9PXgCLm+XCB+
        LobnipDVqkthvOxezM9mJJGIb0o1wJdDj2tp3DGpXr6YVIFZqFirz4zKN3ZlSHoB5xG0en
        GpW2k5LgiKgBIDTvoU3yvMV3I1s3l8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsIJK/Xhj43RCQxVzm3n65e3ZnHxsC5vOFgMkRLxiIQ=;
        b=VPJcX25rJUisx+RLcrgsbRrK4yGK+1eUajDeZOV7on6wOYwItRn/OCyiuzOaS+9CAtCoT2
        lpKcRP68GlDi5bAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 3UK9Lu4KxmCUJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:02 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 23/31] btrfs: define iomap_page_ops
Date:   Sun, 13 Jun 2021 08:39:51 -0500
Message-Id: <4421b14055294a07710ab1ec4ec3795f8d056bc2.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

The page_done() sets page->private to EXTENT_PAGE_PRIVATE if not
already set. The check is in set_page_extent_mapped().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d311b01a2b71..fe6d24c6f7bf 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -467,6 +467,17 @@ static void btrfs_drop_pages(struct page **pages, size_t num_pages)
 	}
 }
 
+static void btrfs_page_done(struct inode *inode, loff_t pos,
+		unsigned int copied, struct page *page,
+		struct iomap *iomap)
+{
+	set_page_extent_mapped(page);
+}
+
+static const struct iomap_page_ops btrfs_iomap_page_ops = {
+	.page_done = btrfs_page_done,
+};
+
 /*
  * After btrfs_copy_from_user(), update the following things for delalloc:
  * - Mark newly dirtied pages as DELALLOC in the io tree.
-- 
2.31.1

