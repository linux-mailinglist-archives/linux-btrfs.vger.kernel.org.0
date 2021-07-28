Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E6B3D92B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhG1QDE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 12:03:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52984 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhG1QDD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 12:03:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4DA3522325;
        Wed, 28 Jul 2021 16:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627488181;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4ifBTr8AIhogl43KqSY8bmjGzLvqV6c2VAcAOB7YVY=;
        b=NfcG9cc9kcLyRrEyvs4N/YBxS7o5zF6N58zhQ04k+pRtg6EN7vxelTBnusVujZrlxdDFai
        aC845JWOF/aA8+L7oBYVEWcjXTT1x7uw9eCcHblEKNdFTIeb2wwvQYegN/EXdYBmaEbjPl
        WYav26wSu7aj6pg8Uns/gokL9WvTHtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627488181;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4ifBTr8AIhogl43KqSY8bmjGzLvqV6c2VAcAOB7YVY=;
        b=DI0M/RNqufxVF/Q3EqoiX8XIgr8NPoKRsxp31Q4cB0liqo+mK1gnUJXmhxieltQf8ivm8Z
        HHjOBfqFyX2STPCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 456A4A3B81;
        Wed, 28 Jul 2021 16:03:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5AA29DA8A7; Wed, 28 Jul 2021 18:00:16 +0200 (CEST)
Date:   Wed, 28 Jul 2021 18:00:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
Message-ID: <20210728160015.GP5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
References: <20210701160039.12518-1-dsterba@suse.com>
 <YN67+nvpQBfiLXzh@infradead.org>
 <20210702110630.GE2610@twin.jikos.cz>
 <YOLD3CJjDgiq+kfR@infradead.org>
 <20210708143412.GC2610@twin.jikos.cz>
 <333c5709-0d10-635e-656f-32263ec7f0a5@embeddedor.com>
 <20210728153242.GN5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210728153242.GN5047@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 28, 2021 at 05:32:42PM +0200, David Sterba wrote:
> On Wed, Jul 14, 2021 at 06:37:01PM -0500, Gustavo A. R. Silva wrote:
> > Is it OK with you if we proceed to enable -Warray-bounds in linux-next,
> > in the meantime?
> 
> Yes, I've checked the development queue and there are no warnings from
> fs/btrfs/.

Sorry, not yet, there's the other issue that happens on 64k pages that
lead to a 1 element extent_buffer::pages. I can emulate that and see the
warning

  fs/btrfs/disk-io.c: In function ‘csum_tree_block’:
  fs/btrfs/disk-io.c:226:34: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
    226 |   kaddr = page_address(buf->pages[i]);
	|                        ~~~~~~~~~~^~~
  ./include/linux/mm.h:1630:48: note: in definition of macro ‘page_address’
   1630 | #define page_address(page) lowmem_page_address(page)
	|                                                ^~~~
  In file included from fs/btrfs/ctree.h:32,
		   from fs/btrfs/disk-io.c:23:
  fs/btrfs/extent_io.h:98:15: note: while referencing ‘pages’
     98 |  struct page *pages[1];
	|               ^~~~~

but that's easy to fix with

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -210,7 +210,7 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
 static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
        struct btrfs_fs_info *fs_info = buf->fs_info;
-       const int num_pages = fs_info->nodesize >> PAGE_SHIFT;
+       const int num_pages = num_extent_pages(buf);
        const int first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
        SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
        char *kaddr;
---

I'll send a patch, it'll appear in for-next soonish.
