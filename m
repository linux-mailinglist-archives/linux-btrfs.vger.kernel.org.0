Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25455923C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 14:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfHSMrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 08:47:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45438 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSMrb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 08:47:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so1227733qki.12
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2019 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wXjuEdQxkxeptlt3uMpcMoBxXDPd/DF7cV1SAR7i4Zs=;
        b=G5yh++6Nq5R9r0cMcyQODCp0DO9zDp2D7SEQmwmGAYikVW1FPagr19V8gNZL7/Gc+I
         R8I8428lXrVNn9A1UCeFT7+56nwQ4F7fzd79BMIt01YALFK08WZ+PXeCm/DtPZGSb8fM
         cbJ5SYLFswhXDPN3s6B5vNrk4xSl8f7C52I/TCN7gvkCPB1OKgj1/iC1PpB/muR8B2M0
         V+zRAjqvp+c2gRXzE68kSftWn5yIQ+V5JeD+N/wS+EbjEcvyiZa3iurBgfC9j9zaAf5R
         XMpdQcI7F9xZ/Q0UUobIRQrJXef9zMLnevAeHabwDjmTOBY3M5VZnR+tGySPOQXx+3Ai
         5Ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wXjuEdQxkxeptlt3uMpcMoBxXDPd/DF7cV1SAR7i4Zs=;
        b=ppmr3UtvVxpss3CkOkXmiG0T6wWimfPVer6j9fKj0nz/d2Us/zp3NZ8WBEfhVdBaSu
         Ognagi0OVc2cY2z9OTk82iTn5Hkb7LfS4Vlz9dQnNNZ1Ok/lnpzR2EE9XD3xKtcVEnoW
         Ux1o+PXuyZDAWmo4gZQNyFu53FEZgeJLXQRIvDleEEcfJr9dLFJrp3GXxzXiI31uyWrQ
         ANsoQgrHYcMOXfFbOA/Va1nAzTeDFb2ivHH/zhev0nHldUUhey++KZDv86TG0lIm3QAM
         OEWuGNroHaIN11i8FCiI5xpi6Ty9HGu9yZ330ZYFN3IOwRCBeU/2rm/oHd8vypVWi/Wc
         kpOQ==
X-Gm-Message-State: APjAAAU1ro8vBDC+r5DTsZS5+u280RB5notsjPxQUaGKY2jtT0BQFpS1
        yL3pSb+2Cd6C4ITL5WJVwkwXTQ==
X-Google-Smtp-Source: APXvYqzN2pM5hEzKd3nZSy/aRpbdWmghyPpeiCqh8RNp7/lVmcQgPR5ZyKYfaWOszItGyrihQ0q+nQ==
X-Received: by 2002:a05:620a:15eb:: with SMTP id p11mr18865231qkm.23.1566218850159;
        Mon, 19 Aug 2019 05:47:30 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j50sm8794902qtj.30.2019.08.19.05.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 05:47:29 -0700 (PDT)
Date:   Mon, 19 Aug 2019 08:47:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: rename the btrfs_calc_*_metadata_size helpers
Message-ID: <20190819124727.t5xhqyntq72cagav@MacBook-Pro-91.local>
References: <20190816150600.9188-1-josef@toxicpanda.com>
 <20190816150600.9188-2-josef@toxicpanda.com>
 <54a313a2-8355-66cd-74a1-a267bd65cccd@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54a313a2-8355-66cd-74a1-a267bd65cccd@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 19, 2019 at 11:30:16AM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.08.19 г. 18:05 ч., Josef Bacik wrote:
> > btrfs_calc_trunc_metadata_size differs from trans_metadata_size in that
> > it doesn't take into account any splitting at the levels, because
> > truncate will never split nodes.  However truncate _and_ changing will
> > never split nodes, so rename btrfs_calc_trunc_metadata_size to
> > btrfs_calc_metadata_size.  Also btrfs_calc_trans_metadata_size is purely
> > for inserting items, so rename this to btrfs_calc_insert_metadata_size.
> > Making these clearer will help when I start using them differently in
> > upcoming patches.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/block-group.c      |  4 ++--
> >  fs/btrfs/ctree.h            | 14 +++++++++-----
> >  fs/btrfs/delalloc-space.c   |  8 ++++----
> >  fs/btrfs/delayed-inode.c    |  4 ++--
> >  fs/btrfs/delayed-ref.c      |  8 ++++----
> >  fs/btrfs/file.c             |  4 ++--
> >  fs/btrfs/free-space-cache.c |  4 ++--
> >  fs/btrfs/inode-map.c        |  2 +-
> >  fs/btrfs/inode.c            |  6 +++---
> >  fs/btrfs/props.c            |  2 +-
> >  fs/btrfs/root-tree.c        |  2 +-
> >  fs/btrfs/space-info.c       |  2 +-
> >  fs/btrfs/transaction.c      |  4 ++--
> >  13 files changed, 34 insertions(+), 30 deletions(-)
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com> see one discussion
> point below.
> > 
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index afae5c731904..3147e840f839 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -3014,8 +3014,8 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
> >  	num_devs = get_profile_num_devs(fs_info, type);
> >  
> >  	/* num_devs device items to update and 1 chunk item to add or remove */
> > -	thresh = btrfs_calc_trunc_metadata_size(fs_info, num_devs) +
> > -		btrfs_calc_trans_metadata_size(fs_info, 1);
> > +	thresh = btrfs_calc_metadata_size(fs_info, num_devs) +
> > +		btrfs_calc_insert_metadata_size(fs_info, 1);
> >  
> >  	if (left < thresh && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
> >  		btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 85b808e3ea42..f352aa098015 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -2450,17 +2450,21 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
> >  
> >  u64 btrfs_csum_bytes_to_leaves(struct btrfs_fs_info *fs_info, u64 csum_bytes);
> >  
> > -static inline u64 btrfs_calc_trans_metadata_size(struct btrfs_fs_info *fs_info,
> > -						 unsigned num_items)
> > +/*
> > + * Use this if we would be adding new items, as we could split nodes as we cow
> > + * down the tree.
> > + */
> > +static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
> > +						  unsigned num_items)
> >  {
> >  	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
> >  }
> >  
> 
> Isn't assuming that we are going to split on every level of the cow
> rather pessimistic, bordering on impossible. Isn't it realistically
> possible that we will only ever split up until root->level.
> 

I had this discussion with Chris when I messed with this.  We do pass in the
root we intend on messing with so we could very well do this, but it sort of
scares me because maybe we've been using more of our worst case reservations
than I expected.

My plan is to get these last corners worked out, get a few more months of
production testing, and then start experimenting with using the root->level + 1
for the maximum level and see how that goes.  The ramp up from 1 level to 3
level roots happens pretty fast, so I suspect there'll be weird corner cases
going from empty->not empty, but I _think_ we should be fine to make this change
further down the road?

Also I will probably start with _just_ the transaction reservations, and leave
the delayed refs calculations the absolute worst case since those can explode.
Thanks,

Josef
