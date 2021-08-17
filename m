Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC23EEA09
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhHQJjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 05:39:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50244 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhHQJjc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 05:39:32 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82FDC1FF24
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629193138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tu4TkF/BKzd0v0KBtFijoav9MvyUxKwylPaHZBNwNZY=;
        b=U4AzxM7vPGaTPwA7VfOKGkTflRXo6iCKyEMx3+BIbSdkMCLwAZAPlkB/dvLXF0XFyZKfA9
        Uj4skkX+OXRb1t6DWH6HJDNbm9BI4fYg3lhrL/yzG689ScoRxuFykwRzaUuGzGQ7cU1Szv
        tMHjn0nYTABzu83gGencWE4lgBVXkkg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B60B1132AB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2PaaHbGDG2FcCwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:38:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: make btrfs_alloc_subpage() to return struct btrfs_subpage * directly
Date:   Tue, 17 Aug 2021 17:38:50 +0800
Message-Id: <20210817093852.48126-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817093852.48126-1-wqu@suse.com>
References: <20210817093852.48126-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The existing calling convention of btrfs_alloc_subpage() is pretty
awful.

Change it to a more common pattern by returning struct btrfs_subpage *
directly and let the caller to determine if the call succeeded.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  7 ++++---
 fs/btrfs/subpage.c   | 33 +++++++++++++++++++--------------
 fs/btrfs/subpage.h   |  5 ++---
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 19889dbfcf15..3c5770d47a95 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6138,9 +6138,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * support, so we still preallocate the memory in the loop.
 		 */
 		if (fs_info->sectorsize < PAGE_SIZE) {
-			ret = btrfs_alloc_subpage(fs_info, &prealloc,
-						  BTRFS_SUBPAGE_METADATA);
-			if (ret < 0) {
+			prealloc = btrfs_alloc_subpage(fs_info,
+						       BTRFS_SUBPAGE_METADATA);
+			if (IS_ERR(prealloc)) {
+				ret = PTR_ERR(prealloc);
 				unlock_page(p);
 				put_page(p);
 				exists = ERR_PTR(ret);
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ff1c6ba34a4d..ae6c68370a95 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -66,7 +66,7 @@
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct page *page, enum btrfs_subpage_type type)
 {
-	struct btrfs_subpage *subpage = NULL;
+	struct btrfs_subpage *subpage;
 	int ret;
 
 	/*
@@ -75,13 +75,16 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 	 */
 	if (page->mapping)
 		ASSERT(PageLocked(page));
+
 	/* Either not subpage, or the page already has private attached */
 	if (fs_info->sectorsize == PAGE_SIZE || PagePrivate(page))
 		return 0;
 
-	ret = btrfs_alloc_subpage(fs_info, &subpage, type);
-	if (ret < 0)
+	subpage = btrfs_alloc_subpage(fs_info, type);
+	if (IS_ERR(subpage)) {
+		ret = PTR_ERR(subpage);
 		return ret;
+	}
 	attach_page_private(page, subpage);
 	return 0;
 }
@@ -100,23 +103,25 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
 	btrfs_free_subpage(subpage);
 }
 
-int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
-			struct btrfs_subpage **ret,
-			enum btrfs_subpage_type type)
+struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
+					  enum btrfs_subpage_type type)
 {
+	struct btrfs_subpage *ret;
+
 	ASSERT(fs_info->sectorsize < PAGE_SIZE);
 
-	*ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
-	if (!*ret)
-		return -ENOMEM;
-	spin_lock_init(&(*ret)->lock);
+	ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&ret->lock);
 	if (type == BTRFS_SUBPAGE_METADATA) {
-		atomic_set(&(*ret)->eb_refs, 0);
+		atomic_set(&ret->eb_refs, 0);
 	} else {
-		atomic_set(&(*ret)->readers, 0);
-		atomic_set(&(*ret)->writers, 0);
+		atomic_set(&ret->readers, 0);
+		atomic_set(&ret->writers, 0);
 	}
-	return 0;
+	return ret;
 }
 
 void btrfs_free_subpage(struct btrfs_subpage *subpage)
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 0120948f37a1..fdcadc5193c1 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -59,9 +59,8 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
 			  struct page *page);
 
 /* Allocate additional data where page represents more than one sector */
-int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
-			struct btrfs_subpage **ret,
-			enum btrfs_subpage_type type);
+struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
+					  enum btrfs_subpage_type type);
 void btrfs_free_subpage(struct btrfs_subpage *subpage);
 
 void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
-- 
2.32.0

