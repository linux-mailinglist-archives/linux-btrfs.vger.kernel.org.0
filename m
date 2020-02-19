Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88185163FE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 10:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgBSJB5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 04:01:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:56110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgBSJB5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 04:01:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D216AD5F;
        Wed, 19 Feb 2020 09:01:54 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] Btrfs: relocation: Refactor build_backref_tree()
 using btrfs_backref_iterator infrastructure
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200218090129.134450-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <126e10f4-47be-6b03-a939-394e9cce3e4c@suse.com>
Date:   Wed, 19 Feb 2020 11:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218090129.134450-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.02.20 г. 11:01 ч., Qu Wenruo wrote:
> This is part 1 of the incoming refactor patches for build_backref_tree()
> 
> [THE PLAN]
> The overall plan of refactoring build_backref_tree() is:
> - Refactor how we iterate through backref items
>   This patchset, the smallest I guess.
> 
> - Make build_backref_tree() easier to read.
>   In short, that function is doing breadth-first-search to build a map
>   which starts from one tree block, to all root nodes referring it.
> 
>   It involves backref iteration part, and a lot of backref cache only
>   works.
>   At least I hope to make this function less bulky and more structured.
> 
> - Make build_backref_tree() independent from relocation
>   The hardest I guess.
> 
>   Current it even accepts reloc_control as its first parameter.
>   Don't have a clear plan yet, but I guess at least I should make
>   build_backref_tree() to do some more coverage, other than taking
>   certain relocation-dependent shortcut.
> 
> [THIS PATCHSET]
> For the patchset itself, the main purpose is to change how we iterate
> through all backref items of one tree block.
> 
> The old way:
> 
>   path->search_commit_root = 1;
>   path->skip_locking = 1;
>   ret = btrfs_search_slot(NULL, extent_root, path, &key, 0, 0);
>   ptr = btrfs_item_offset_nr()
>   end = btrfs_item_end_nr()
>   /* Inline item loop */
>   while (ptr < end) {
> 	/* Handle each inline item here */
>   }
>   while (1) {
>   	ret = btrfs_next_item();
> 	btrfs_item_key_to_cpu()
> 	if (key.objectid != bytenr ||
> 	    !(key.type == XXX || key.type == YYY)) 
> 		break;
> 	/* Handle each keyed item here */
>   }
>   
> The new way:
> 
>   iterator = btrfs_backref_iterator_alloc();
>   for (ret = btrfs_backref_iterator_start(iterator, bytenr);
>        ret == 0; ret = btrfs_backref_iterator_next(iterator)) {
> 	/*
> 	 * Handle both keyed and inlined item here.
> 	 *
> 	 * We can use iterator->key to determine if it's inlined or
> 	 * keyed.
> 	 * Even for inlined item, it can be easily converted to keyed
> 	 * item, just like we did in build_backref_tree().
> 	 */
>   }
> 
> Currently, only build_backref_tree() can utilize this infrastructure.
> 
> Backref.c has more requirement, as it needs to handle iteration for both
> data and metadata, both commit root and current root.
> And more importantly, backref.c uses depth first search, thus not a
> perfect match for btrfs_backref_iterator.
> 
> Extra naming suggestion is welcomed.
> The current naming, btrfs_backref_iterator_* looks pretty long to me
> already.
> Shorter naming would be much better.
> 
> Changelog:
> v2:
> - Fix a completion bug in btrfs_backref_iterator_next()
>   It should be btrfs_extent_inline_ref_type().
> 
> v3:
> - Comment and commit message update
> - Move helper definitions to where they get first used
> - Use helpers to replace some internal open code
> 
> v4:
> - Fix a bug in end_ptr calculation
>   The old btrfs_item_end_nr() doesn't take LEAF_DATA_OFFSET into
>   consideration, thus causes failure in btrfs/003.
> 
> - Add extra check for keyed only backrefs
>   btrfs_backref_iter_start() doesn't handle keyed only backrefs well.
>   Add extra check to ensure callers get the correct cur_ptr set.
> 
> - Shorten the name, iterator->iter
> 
> v5:
> - Add the missing assignment for iter->bytenr
>   This makes keyed backref not checked, causing random dead loop for
>   btrfs/187.
> 
> - Add comment for btrfs_backref_iter_next()
>   Mostly for the return value.
> 
> 
> Qu Wenruo (3):
>   btrfs: backref: Introduce the skeleton of btrfs_backref_iter
>   btrfs: backref: Implement btrfs_backref_iter_next()
>   btrfs: relocation: Use btrfs_backref_iter infrastructure
> 
>  fs/btrfs/backref.c    | 145 +++++++++++++++++++++++++++++++
>  fs/btrfs/backref.h    |  94 ++++++++++++++++++++
>  fs/btrfs/relocation.c | 193 ++++++++++++++----------------------------
>  3 files changed, 301 insertions(+), 131 deletions(-)
> 

I tested the patchset on btrfs/balance group of tests and didn't observe
any of the regressions present in the previous version so:

Tested-by: Nikolay Borisov <nborisov@suse.com>
