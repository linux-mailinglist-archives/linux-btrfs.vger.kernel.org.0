Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDCD3B9A62
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 03:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhGBBHd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 21:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234579AbhGBBHc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 21:07:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B98A6613ED;
        Fri,  2 Jul 2021 01:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625187901;
        bh=CDRCL93h23besIz9vEppCvGLJhL5F3wj+8t2oHCgt6Q=;
        h=Date:From:To:Cc:Subject:From;
        b=RAk/AmyxJW90Ab+sgsDz26SOhBhK79ciwO9dZ6jtAK1bU3LsBw0xnUnlch5WFP+ft
         izOcAKXg8BXTQuiMBCbJXFY3gGo8j62Ig9LSAPU8tjlr7MJGXGta2v3FHbIA3z4EfP
         fTwt9v4z7IpN4bSAe3P9NjW3ZUkEjQX1sxPZok8wrJ/5GEPZh9fXOsLyMpk5hPtt1e
         qm8Yn/aOIEJelQuSwTAf3QtsXg8t07nSUq85D66XPddAEEJc1k4hXUgYJ4fCDtFhYG
         YGifuTbzWxjNwIBsfbMudPdh92LiO33JzPf7bLHTB4y0UD/QxDP0CK1PlCe41KPep/
         OGx1PsOuARBMg==
Date:   Thu, 1 Jul 2021 20:06:53 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] btrfs: Fix multiple out-of-bounds warnings
Message-ID: <20210702010653.GA84106@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix the following out-of-bounds warnings by using a flexible-array
member *pages[] at the bottom of struct extent_buffer:

fs/btrfs/disk-io.c:225:34: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:80:46: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:101:32: warning: array subscript 1 is above array bounds of ‘struct page * const[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:133:46: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:156:32: warning: array subscript 1 is above array bounds of ‘struct page * const[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:80:46: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:101:32: warning: array subscript 1 is above array bounds of ‘struct page * const[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:133:46: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:156:32: warning: array subscript 1 is above array bounds of ‘struct page * const[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:80:46: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:101:32: warning: array subscript 1 is above array bounds of ‘struct page * const[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:133:46: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
fs/btrfs/struct-funcs.c:156:32: warning: array subscript 1 is above array bounds of ‘struct page * const[1]’ [-Warray-bounds]

Also, make use of the struct_size() helper to properly calculate the
total size of struct extent_buffer for the kmem cache allocation.

This is part of the ongoing efforts to globally enable -Warray-bounds.

The code was built with ppc64_defconfig and -Warray-bounds enabled by
default in the main Makefile.

Link: https://github.com/KSPP/linux/issues/109
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/btrfs/extent_io.c | 5 +++--
 fs/btrfs/extent_io.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9e81d25dea70..4cf0b72fdd9f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -232,8 +232,9 @@ int __init extent_state_cache_init(void)
 int __init extent_io_init(void)
 {
 	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
-			sizeof(struct extent_buffer), 0,
-			SLAB_MEM_SPREAD, NULL);
+			struct_size((struct extent_buffer *)0, pages,
+				    INLINE_EXTENT_BUFFER_PAGES),
+			0, SLAB_MEM_SPREAD, NULL);
 	if (!extent_buffer_cache)
 		return -ENOMEM;
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 62027f551b44..b82e8b694a3b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -94,11 +94,11 @@ struct extent_buffer {
 
 	struct rw_semaphore lock;
 
-	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
 	struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 #endif
+	struct page *pages[];
 };
 
 /*
-- 
2.27.0

