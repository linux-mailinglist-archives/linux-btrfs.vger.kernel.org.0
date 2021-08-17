Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B143D3EEA08
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhHQJje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 05:39:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50238 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhHQJjb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 05:39:31 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 423D220010
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629193137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rZOGzxzg5Nx41Eg6HM7M8T7yhsNGy/yXCxw752YtT4=;
        b=PheDvtCVsuWBJcfCBD2X6tQ0gwLS9MHjknJXk6isZHCALS8CLNU0MUt+v5/s9a3yGokKsX
        ScTvNZbDO7MN1k0uEpahMFIjr6/c7skpZ1yGqtnCxc9JYaViH+NJAB0ORA0UQwtg4UPZR5
        fZTNBda03at08bF2fM1LDGBf4lqkFbQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 746CA132AB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:38:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OPGrDLCDG2FcCwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:38:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: only call btrfs_alloc_subpage() when sectorsize is smaller than PAGE_SIZE
Date:   Tue, 17 Aug 2021 17:38:49 +0800
Message-Id: <20210817093852.48126-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817093852.48126-1-wqu@suse.com>
References: <20210817093852.48126-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two call sites of btrfs_alloc_subpage():

- btrfs_attach_subpage()
  We have ensured sectorsize is smaller than PAGE_SIZE

- alloc_extent_buffer()
  We call btrfs_alloc_subpage() unconditionally.

The alloc_extent_buffer() forces us to check the sectorsize size against
page size inside btrfs_alloc_subpage().

Since the function name, btrfs_alloc_subpage(), already indicates it
should only get called for subpage cases, do the check in
alloc_extent_buffer() and add an ASSERT() in btrfs_alloc_subpage().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 16 +++++++++-------
 fs/btrfs/subpage.c   |  3 +--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aaddd7225348..19889dbfcf15 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6137,13 +6137,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * page, but it may change in the future for 16K page size
 		 * support, so we still preallocate the memory in the loop.
 		 */
-		ret = btrfs_alloc_subpage(fs_info, &prealloc,
-					  BTRFS_SUBPAGE_METADATA);
-		if (ret < 0) {
-			unlock_page(p);
-			put_page(p);
-			exists = ERR_PTR(ret);
-			goto free_eb;
+		if (fs_info->sectorsize < PAGE_SIZE) {
+			ret = btrfs_alloc_subpage(fs_info, &prealloc,
+						  BTRFS_SUBPAGE_METADATA);
+			if (ret < 0) {
+				unlock_page(p);
+				put_page(p);
+				exists = ERR_PTR(ret);
+				goto free_eb;
+			}
 		}
 
 		spin_lock(&mapping->private_lock);
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index cb10e56ee31e..ff1c6ba34a4d 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -104,8 +104,7 @@ int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 			struct btrfs_subpage **ret,
 			enum btrfs_subpage_type type)
 {
-	if (fs_info->sectorsize == PAGE_SIZE)
-		return 0;
+	ASSERT(fs_info->sectorsize < PAGE_SIZE);
 
 	*ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
 	if (!*ret)
-- 
2.32.0

