Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57C074779
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 08:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfGYGtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 02:49:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:51776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfGYGtD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 02:49:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBB53AD12;
        Thu, 25 Jul 2019 06:49:01 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] btrfs: Enhanced runtime defence against fuzzed
 images
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Jungyeon Yoon <jungyeon.yoon@gmail.com>
References: <20190725061222.9581-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1c212f70-4863-7bcc-be23-893d145bff58@suse.com>
Date:   Thu, 25 Jul 2019 09:49:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725061222.9581-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.07.19 г. 9:12 ч., Qu Wenruo wrote:
> Another wave of defence enhancment, including:
> 
> - Enhanced eb accessors
>   Not really needed for the fuzzed images, as 448de471cd4c
>   ("btrfs: Check the first key and level for cached extent buffer")
>   already fixed half of the reported images.
>   Just add a final layer of safe net.
> 
>   Just to complain here, two experienced btrfs developer have got
>   confused by @start, @len in functions like read_extent_buffer() with
>   logical address.
>   The best example to solve the confusion is to check the
>   read_extent_buffer() call in btree_read_extent_buffer_pages().
> 
>   I'm not sure why this confusion happens or even get spread.
>   My guess is the extent_buffer::start naming causing the problem.
> 
>   If so, I would definitely rename extent_buffer::start to
>   extent_buffer::bytenr at any cost.
>   Hopes the new commend will address the problem for now.

it should either be bytenr or disk_bytenr or disk_addr or address.
Looking at the code base though, it seems there is already a convention
that bytenr means the byte number in the logical address space. So
indeed, bytenr should be ok.

> 
> - BUG_ON() hunt in __btrfs_free_extent()
>   Kill BUG_ON()s in __btrfs_free_extent(), replace with error reporting
>   and why it shouldn't happen.
> 
>   Also add comment on what __btrfs_free_extent() is designed to do, with
>   two dump-tree examples for newcomers.
> 
> - BUG_ON() hunt in __btrfs_inc_extent_ref()
>   Just like __btrfs_free_extent(), but less comment as
>   comment for __btrfs_free_extent() should also work for
>   __btrfs_inc_extent_ref(), and __btrfs_inc_extent_ref() has a better
>   structure than __btrfs_free_extent().
> 
> - Defence against unbalanced empty leaf
> 
> - Defence against bad key order across two tree blocks
> 
> The last two cases can't be rejected by tree-checker and they are all
> cross-eb cases.
> Thankfully we can reuse existing first_key check against unbalanced
> empty leaf, but needs extra check deep into ctree.c for tree block
> merging time check.
> 
> Reported-by: Jungyeon Yoon <jungyeon.yoon@gmail.com>
> [ Not to mail bombarding the report, thus only RB tag in cover letter ]
> 
> Changelog:
> v2:
> - Remove duplicated error message in WARN() call.
>   Changed to WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG))
>   Also move WARN() after btrfs error message.
> 
> - Fix a comment error in __btrfs_free_extent()
>   It's not adding refs to a tree block, but adding the same refs
>   to an existing tree block ref.
>   It's impossible a btrfs tree owning the same tree block directly twice.
> 
> - Add comment for eb accessors about @start and @len
>   If anyone could tell me why such confusion between @start @len and
>   logical address is here, I will definitely solve the root cause no
>   matter how many codes need to be modified.
> 
> - Use bool to replace int where only two values are returned
>   Also rename to follow the bool type.
> 
> - Remove one unrelated change for the error handler in
>   btrfs_inc_extent_ref()
> 
> - Add Reviewed-by tag
> 
> Qu Wenruo (5):
>   btrfs: extent_io: Do extra check for extent buffer read write
>     functions
>   btrfs: extent-tree: Kill BUG_ON() in __btrfs_free_extent() and do
>     better comment
>   btrfs: Detect unbalanced tree with empty leaf before crashing btree
>     operations
>   btrfs: extent-tree: Kill the BUG_ON() in
>     insert_inline_extent_backref()
>   btrfs: ctree: Checking key orders before merged tree blocks
> 
>  fs/btrfs/ctree.c        |  68 +++++++++++++++++
>  fs/btrfs/disk-io.c      |   8 ++
>  fs/btrfs/extent-tree.c  | 164 ++++++++++++++++++++++++++++++++++++----
>  fs/btrfs/extent_io.c    |  76 ++++++++++---------
>  fs/btrfs/tree-checker.c |   6 ++
>  5 files changed, 271 insertions(+), 51 deletions(-)
> 
