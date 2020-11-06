Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DE52A9873
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgKFPWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 10:22:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:34760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgKFPWu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 10:22:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604676168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=W5WJMHEQxwpGaFjTIAGerBBIeWDUjWcNaNmwr9h9yRI=;
        b=oGlDMSsvUSRMHXEddoBXDWR/N7PI8lKR8X4ccONTjUid40/vqP2+djmAnHSKqQ9lOV7ciz
        Gk8W9zwCqWAR8qwZ94cPGr9uXi8hBYe5C4BkA743DOS3pN9Lt5oKaRHMevMS7W+Xfe2Y2W
        Oe+9FomHyOC2k1h5j5yBirSh8daTe0g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C14AFABCC;
        Fri,  6 Nov 2020 15:22:48 +0000 (UTC)
Subject: Re: [PATCH 24/32] btrfs: file-item: refactor btrfs_lookup_bio_sums()
 to handle out-of-order bvecs
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-25-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <32eeff2d-2836-3fab-d03d-fc827178ae36@suse.com>
Date:   Fri, 6 Nov 2020 17:22:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103133108.148112-25-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.11.20 г. 15:31 ч., Qu Wenruo wrote:
> Refactor btrfs_lookup_bio_sums() by:
> - Remove the @file_offset parameter
>   There are two factors making the @file_offset parameter useless:
> 
>   * For csum lookup in csum tree, file offset makes no sense
>     We only need disk_bytenr, which is unrelated to file_offset
> 
>   * page_offset (file offset) of each bvec is not contiguous.
>     Pages can be added to the same bio as long as their on-disk bytenr
>     is contiguous, meaning we could have pages at differnt file offsets
>     in the same bio.
> 
>   Thus passing file_offset makes no sense any more.
>   The only user of file_offset is for data reloc inode, we will use
>   a new function, search_file_offset_in_bio(), to handle it.
> 
> - Extract the csum tree lookup into find_csum_tree_sums()

The function is no longer named find_csum_tree_sums but search_csum_tree
so update the changelog as well.

>   The new function will handle the csum search in csum tree.
>   The return value is the same as btrfs_find_ordered_sum(), returning
>   the found number of sectors who has checksum.

nit: s/who/which/


> 
> - Change how we do the main loop
>   The only needed info from bio is:
>   * the on-disk bytenr
>   * the length
> 
>   After extracting above info, we can do the search without bio
>   at all, which makes the main loop much simpler:
> 
> 	for (cur_disk_bytenr = orig_disk_bytenr;
> 	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
> 	     cur_disk_bytenr += count * sectorsize) {
> 
> 		/* Lookup csum tree */
> 		count = find_csum_tree_sums(fs_info, path, cur_disk_bytenr,
> 					    search_len, csum_dst);

nit: update function name

> 		if (!count) {
> 			/* Csum hole handling */
> 		}
> 	}
> 
> - Use single variable as core to calculate all other offsets
>   Instead of all differnt type of variables, we use only one core

nit: s/differnt/different/

>   variable, cur_disk_bytenr, which represents the current disk bytenr.
> 
>   All involves values can be calculated from that core variable, and

nit: s/involves/involved/

>   all those variable will only be visible in the inner loop.
> 
> 	diff_sectors = div_u64(cur_disk_bytenr - orig_disk_bytenr,
> 			       sectorsize);
> 	cur_disk_bytenr = orig_disk_bytenr +
> 			  diff_sectors * sectorsize;
> 	csum_dst = csum + diff_sectors * csum_size;

this snippet also need to be either updated to reflect the latest state
of code name wise or simply be removed.

> 
> All above refactor makes btrfs_lookup_bio_sums() way more robust than it
> used to, especially related to the file offset lookup.
> Now file_offset lookup is only related to data reloc inode, other wise
> we don't need to bother file_offset at all.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This patch missed David's feedback @
https://lore.kernel.org/linux-btrfs/20201103194650.GD6756@twin.jikos.cz/
for v1 however it integrated feedback I gave to your original v2
posting. One thing which would help readability is making the  compound
division statements in search_csum_tree on a single line, even if they
break the 80 char limit, which is no 100 AFAIR, for btrfs we chose to
use longer lines than 80 if it made sense. I think this case is an
example where it does make sense.

<snip>
