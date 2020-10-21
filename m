Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE57929485C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440867AbgJUG2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440865AbgJUG2Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MUiLHBYuqzeygIT+LCuQeHxWkfmHFqeFvMamaqBBa4=;
        b=lPUmP/nK3XtFJHxF5MungpAjnPlLUBeci//2Z6r4vSI0btwlTRj1kZgqJgS0BfN2QsC4Li
        fxvr8CYIfudeXQlvjnCAhSaMT/0dzd7wlsyv5Bi9JedIoZy0tHOCiOW1UN4kkIa8CImsZX
        OjvFLjuFAk8oQr3zI1mfralWFeA/WYI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05703AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 64/68] btrfs: inode: always mark the full page range delalloc for btrfs_page_mkwrite()
Date:   Wed, 21 Oct 2020 14:25:50 +0800
Message-Id: <20201021062554.68132-65-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So that we won't get subpage sized EXTENT_DELALLOC, which could easily
screwup the PAGE aligned write space reservation for subpage support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f3bc894611e0..0da6c91db0bc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8323,8 +8323,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	if (page->index == ((size - 1) >> PAGE_SHIFT)) {
-		reserved_space = round_up(size - page_start,
-					  fs_info->sectorsize);
+		reserved_space = round_up(size - page_start, PAGE_SIZE);
 		if (reserved_space < PAGE_SIZE) {
 			end = page_start + reserved_space - 1;
 			btrfs_delalloc_release_space(BTRFS_I(inode),
-- 
2.28.0

