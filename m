Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B31FC70A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 14:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKNNLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 08:11:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:42196 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfKNNLg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 08:11:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A71DBACA0;
        Thu, 14 Nov 2019 13:11:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6364DABD9; Thu, 14 Nov 2019 14:11:37 +0100 (CET)
Date:   Thu, 14 Nov 2019 14:11:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu WenRuo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: block-group: Fix two rebase errors where
 assignment for cache is missing
Message-ID: <20191114131137.GI3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191105013535.14239-1-wqu@suse.com>
 <20191105013535.14239-2-wqu@suse.com>
 <20191113143143.GA3001@twin.jikos.cz>
 <5804867d-d3dc-3fb5-f152-10b9e35b8278@gmx.com>
 <224a194f-0f6f-d768-03cd-c31e70fdeb14@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <224a194f-0f6f-d768-03cd-c31e70fdeb14@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 01:37:31AM +0000, Qu WenRuo wrote:
> > On 2019/11/13 下午10:31, David Sterba wrote:
> >> On Tue, Nov 05, 2019 at 09:35:34AM +0800, Qu Wenruo wrote:
> >>> Without proper cache->flags, btrfs space info will be screwed up and
> >>> report error at mount time.
> >>>
> >>> And without proper cache->used, commit transaction will report -EEXIST
> >>> when running delayed refs.
> >>>
> >>> Please fold this into the original patch "btrfs: block-group: Refactor btrfs_read_block_groups()".
> >>>
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>> ---
> >>>  fs/btrfs/block-group.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >>> index b5eededaa750..c2bd85d29070 100644
> >>> --- a/fs/btrfs/block-group.c
> >>> +++ b/fs/btrfs/block-group.c
> >>> @@ -1713,6 +1713,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
> >>>  	}
> >>>  	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
> >>>  			   sizeof(bgi));
> >>> +	cache->used = btrfs_stack_block_group_used(&bgi);
> >>> +	cache->flags = btrfs_stack_block_group_flags(&bgi);
> >>>  	if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
> >>>  	    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
> >>>  			btrfs_err(info,
> >>
> >> Is it possible that there's another missing bit that got lost during my
> >> rebase? VM testing is fine but I get a reproducible crash on a physical
> >> machine with the following stacktrace:
> >>
> >>  113 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
> >>  114                              u64 total_bytes, u64 bytes_used,
> >>  115                              u64 bytes_readonly,
> >>  116                              struct btrfs_space_info **space_info)
> >>  117 {
> >>  118         struct btrfs_space_info *found;
> >>  119         int factor;
> >>  120
> >>  121         factor = btrfs_bg_type_to_factor(flags);
> >>  122
> >>  123         found = btrfs_find_space_info(info, flags);
> >>  124         ASSERT(found);
> > 
> > It looks like space info is not properly initialized, I'll double check
> > to ensure no other location lacks the flags/used assignment.
> 
> After looking into the latest misc-next branch, I still can't find the
> reason why it doesn't work.
> 
> We have several layers of verification:
> - Tree checker
>   This has ensured all BGI on-disk has correct type (DATA, SYS, META
>   or DATA|META for mixed bg)
> 
> - DATA, META, SYS space info created in btrfs_init_space_info()
>   3 or 2 (for mixed bg) space infos are created according to incompat
>   flags.
> 
> - btrfs_update_space_info() in read_one_block_group()
>   In it we call btrfs_find_space_info() to find the desired space info.
>   btrfs_find_space_info() will return a space info as long as *ONE* type
>   bit matches.
>   That's to say, even for MIXED_BG case, it would still return the
>   DATA|META space info if we pass DATA flag.
> 
> In theory, it's impossible to hit that ASSERT().
> If it's a bgi without a valid type profile, it should be rejected by
> tree-checker.
> 
> Even for MIXED_BG feature but without any mixed bgs, we should still
> find a hit in btrfs_find_space_info().
> If it's mixed bg without MIXED_BG feature, we should detect it early in
> read_one_block_group().
> 
> So my current guess is, that physical machine is not using the correctly
> rebased code?

Thanks for double checking, the assertion failure has disappeared. The
tested branch was exactly the same so the suspicion goes to the machine.
I wiped out all testing kernels, recreated the testing branch by hand
(master+misc-next) and restarted the tests. Strange that this did not
work the first time I rebuilt from the correct misc-next using scripts.
