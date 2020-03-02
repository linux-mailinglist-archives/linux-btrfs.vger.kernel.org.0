Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C6175DCA
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCBPCI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 10:02:08 -0500
Received: from mail.itouring.de ([188.40.134.68]:45020 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgCBPCI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 10:02:08 -0500
Received: from tux.applied-asynchrony.com (p5B07E2B3.dip0.t-ipconnect.de [91.7.226.179])
        by mail.itouring.de (Postfix) with ESMTPSA id A9F4D416D794;
        Mon,  2 Mar 2020 16:02:06 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 5A4E4F01606;
        Mon,  2 Mar 2020 16:02:06 +0100 (CET)
Subject: Re: [PATCH][RESEND] btrfs: kill update_block_group_flags
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200117140826.42616-1-josef@toxicpanda.com>
 <2e16f37e-014e-6d86-76c6-801d6cb7bc20@applied-asynchrony.com>
 <20200302141042.by7jjjokwttqfyzn@jbacik-mbp>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <5dab8982-1e6f-a840-9d2b-cf8e1626cf1f@applied-asynchrony.com>
Date:   Mon, 2 Mar 2020 16:02:06 +0100
MIME-Version: 1.0
In-Reply-To: <20200302141042.by7jjjokwttqfyzn@jbacik-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/20 3:10 PM, Josef Bacik wrote:
> On Sun, Mar 01, 2020 at 06:58:02PM +0100, Holger Hoffstätte wrote:
>> On 1/17/20 3:08 PM, Josef Bacik wrote:
>>> btrfs/061 has been failing consistently for me recently with a
>>> transaction abort.  We run out of space in the system chunk array, which
>>> means we've allocated way too many system chunks than we need.
[snip]
>> It seems that this patch breaks forced metadata rebalance from dup to single;
>> all chunks remain dup (or are rewritten as dup again). I bisected the broken
>> balance behaviour to this commit which for some reason was in my tree ;-) and
>> reverting it immediately fixed things.
>>
>> I don't (yet) see this applied anywhere, but couldn't find any discussion or
>> revocation either. Maybe the logic between update_block_group_flags() and
>> btrfs_get_alloc_profile() is not completely exchangeable?
>>
> 
> Well cool, it looks like we just ignore the restriping stuff if it's not what we
> already have available, which is silly considering we probably don't have any
> block groups of the stripe that we had before.  The previous helpers just
> unconditionally used the restripe target, so can you apply this patch ontop of
> this one and see if it starts working?  I'll wire up a xfstest for this so we
> don't miss it again.  Thanks,
> 
> Josef
> 
>  From 01ec038b8fa64c2bbec6d117860e119a49c01f60 Mon Sep 17 00:00:00 2001
> From: Josef Bacik <josef@toxicpanda.com>
> Date: Mon, 2 Mar 2020 09:08:33 -0500
> Subject: [PATCH] we're restriping, use the target
> 
> ---
>   fs/btrfs/block-group.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 60e9bb136f34..becad9c7486b 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -66,11 +66,8 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
>   	spin_lock(&fs_info->balance_lock);
>   	target = get_restripe_target(fs_info, flags);
>   	if (target) {
> -		/* Pick target profile only if it's already available */
> -		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
> -			spin_unlock(&fs_info->balance_lock);
> -			return extended_to_chunk(target);
> -		}
> +		spin_unlock(&fs_info->balance_lock);
> +		return extended_to_chunk(target);
>   	}
>   	spin_unlock(&fs_info->balance_lock);
>   
> 

Applied it on top & it makes dup -> single balancing work again. \o/
Feel free to add my Tested-by.

Thanks!
Holger
