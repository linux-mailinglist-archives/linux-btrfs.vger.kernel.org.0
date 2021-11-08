Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340E5449C99
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhKHTmD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbhKHTmC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:42:02 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45836C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:39:18 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z9so3248792qtj.9
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rkiRPF3TW6iiKQCiPVPjeoFs3uNw3UfOop3F2JDpblE=;
        b=6Jw7jtIWzaS7UedxD5/LLH3MltxmW4zYAEoKYB3jfUYArTvBxN9txHXGdj3C+owsSi
         86+nA93TJsX2p6nNz3pOkEGMza8En1hoq00mbIw9V7H0yTCjTC6SHYBJRG1vlUE9WNw/
         W1LuPGsJTRyYFc5HjX6QDC94UK5IiKBrAvYU+wOxzoUFFIZhxKNRW1yGez+4mLQR9b//
         i7a3h8EFQLSb0ZFNZ6fr0Hvuo3ugVNOggIS3VlYFf8jfLvgXDVFrWoZNvVIh8bz4joEx
         zyB4RNDJiczR4Sf2SOcAD8ePeLbvn2ooI1tujSTos+8vuNMEjN5CTgnj6O1Hiv7sPGOb
         69/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rkiRPF3TW6iiKQCiPVPjeoFs3uNw3UfOop3F2JDpblE=;
        b=vvLPsIYcIYKBvLbbF5yWTliYJR+1nKBnBawW5csJIBD7fP5CrJkGUooYkymDs3nXWi
         zvoEYC3iH68z2KQUebgN7X5xrzx85T6Bz9bR1dQvhJW1vMQx/Gz7rxOc9LixHD2eAbOl
         TpqZC/fjpNshy+ItR5gWOMtNA9974Voc/J5DTyZrHRYdAAhB3hwoh6p9nSiAB+3ma0NN
         uwHLdiGLTbjmEtHubBZhtwjENb5JWTiMum68RmEto5NwSzS/VnBK5gdgt/KXwldbU9D1
         RybG1WcnhePI1KGmnlTBWe3jBuv6DBM77SuBWWGMvVJPYh68jesmiwgvpxCmpmE/jhBM
         V4BA==
X-Gm-Message-State: AOAM531Cj/Nziriw2G8B6C8Ps+sqI3y/Bg5Fok4n05zBI8sGACRF+g7p
        FwidEr2/0Yf4jSe0soxsuX7G6A==
X-Google-Smtp-Source: ABdhPJxxDmL9DkB2pxf6m3TBW1GMmSoGBF0mTWcoulZTNdhPiluCe3xRcC5CkMMRpz282rY2po8onw==
X-Received: by 2002:a05:622a:1883:: with SMTP id v3mr2134294qtc.327.1636400357391;
        Mon, 08 Nov 2021 11:39:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r10sm11426664qta.27.2021.11.08.11.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:39:16 -0800 (PST)
Date:   Mon, 8 Nov 2021 14:39:15 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] btrfs: add support for multiple global roots
Message-ID: <YYl84zTxBf4ZDSSG@localhost.localdomain>
References: <cover.1636145221.git.josef@toxicpanda.com>
 <a6f403691bdec22e8e052f699ae52f18875cb870.1636145221.git.josef@toxicpanda.com>
 <0595f1b5-2d5c-c5ca-cfad-efb753afec1b@gmx.com>
 <c7caa1df-f634-302f-4d24-3281aa1c94ac@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7caa1df-f634-302f-4d24-3281aa1c94ac@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 06, 2021 at 09:51:20AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/6 09:18, Qu Wenruo wrote:
> > 
> > 
> > On 2021/11/6 04:49, Josef Bacik wrote:
> > > With extent tree v2 you will be able to create multiple csum, extent,
> > > and free space trees.  They will be used based on the block group, which
> > > will now use the block_group_item->chunk_objectid to point to the set of
> > > global roots that it will use.  When allocating new block groups we'll
> > > simply mod the gigabyte offset of the block group against the number of
> > > global roots we have and that will be the block groups global id.
> > > 
> > >  From there we can take the bytenr that we're modifying in the respective
> > > tree, look up the block group and get that block groups corresponding
> > > global root id.  From there we can get to the appropriate global root
> > > for that bytenr.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >   fs/btrfs/block-group.c     | 11 +++++++--
> > >   fs/btrfs/block-group.h     |  1 +
> > >   fs/btrfs/ctree.h           |  2 ++
> > >   fs/btrfs/disk-io.c         | 49 +++++++++++++++++++++++++++++++-------
> > >   fs/btrfs/free-space-tree.c |  2 ++
> > >   fs/btrfs/transaction.c     | 15 ++++++++++++
> > >   fs/btrfs/tree-checker.c    | 21 ++++++++++++++--
> > >   7 files changed, 88 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index 7eb0a8632a01..85516f2fd5da 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -2002,6 +2002,7 @@ static int read_one_block_group(struct
> > > btrfs_fs_info *info,
> > >       cache->length = key->offset;
> > >       cache->used = btrfs_stack_block_group_used(bgi);
> > >       cache->flags = btrfs_stack_block_group_flags(bgi);
> > > +    cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
> > > 
> > >       set_free_space_tree_thresholds(cache);
> > > 
> > > @@ -2284,7 +2285,7 @@ static int insert_block_group_item(struct
> > > btrfs_trans_handle *trans,
> > >       spin_lock(&block_group->lock);
> > >       btrfs_set_stack_block_group_used(&bgi, block_group->used);
> > >       btrfs_set_stack_block_group_chunk_objectid(&bgi,
> > > -                BTRFS_FIRST_CHUNK_TREE_OBJECTID);
> > > +                           block_group->global_root_id);
> > >       btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
> > >       key.objectid = block_group->start;
> > >       key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> > > @@ -2460,6 +2461,12 @@ struct btrfs_block_group
> > > *btrfs_make_block_group(struct btrfs_trans_handle *tran
> > >       cache->flags = type;
> > >       cache->last_byte_to_unpin = (u64)-1;
> > >       cache->cached = BTRFS_CACHE_FINISHED;
> > > +    cache->global_root_id = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
> > > +
> > > +    if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> > > +        cache->global_root_id = div64_u64(cache->start, SZ_1G) %
> > > +            fs_info->nr_global_roots;
> > > +
> > 
> > Any special reason for this complex global_root_id calculation?
> > 
> > My initial assumption for global trees is pretty simple, just something
> > like (CSUM_TREE, ROOT_ITEM, bg bytenr) or (EXTENT_TREE, ROOT_ITEM, bg
> > bytenr) as their root key items.
> > 
> > But this is definitely not the case here.
> > 
> > Thus I'm wondering why we're not using something more simple.
> 

Because we don't have a global tree per-block group.  We have N global roots
that have to be round robined through the block groups.  We could do something
smarter in the future, but for now just round robin'ing them is easy to wrap
your head around, and is a decent default.

> And I also forgot that, for smaller fs, we could have metadata only sized
> several megabytes.
> 
> In that case, several metadata block groups would share the same
> global_root_id, which is definitely not a good idea.
> 

Sure, we can adjust this logic for smaller file systems, I'll change it to scale
down for smaller fs'es.  Thanks,

Josef
