Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA96606488
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJTPav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJTPaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:30:35 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86D813C1F4
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:30:18 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id s17so87727qkj.12
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6R+Il1nHVYlYzG7+8laUQcMqWpjV8TYAS6hyR4VKck=;
        b=B9dfylNpws7wFTx56C3ccfLblm2jRo7AFaSCatG/kChfzcb5aQ9KTUt7nN7mopzSWY
         6GS2RW6JCe/bk3HXU7Z5rH3vB0QcwKNa1uaAt3/5pxKeUZ67fVJvwpOTIkik1VFdXT6m
         qmV8BH+LEZ86iVyxSYYkdfUSzvX17V7WsGGUdyqvp6Tpj8Nbto5FFZ1fEcWQCP1WAVdv
         2AK15bJftJZrav2SfWij1a9/uvxmSAgDsLHUPXbVWRpjc6Mb+bB1bjYriAriwjZyIdg9
         zN2waKcpxwJUVPBfQHBHprdJPifAWubA18XTN7nHYO9u3YzQAyD07ewwiwO8vnr/RSLt
         r0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6R+Il1nHVYlYzG7+8laUQcMqWpjV8TYAS6hyR4VKck=;
        b=1aJPmX22I5dE8VSHLDl8AXtICkVT/FRy7zzaGsK0nizsZZhf3C3CUTv+sYQceIl21+
         nrWQd2j+5Gi/ClpPUh5d77BQIMzex7amxt/ew51mKMDgBRThqNWUaTIL5CvEN0ppbDzp
         lePe0LKsaoX8D2ejTSOAGhUH9G2BqjDvElPtESfp+64HbAkT+lFEdbghPt/3SPfZxciS
         Sbx/oxeIK+rbUP7FDAhwcLGX03RwsWFakyBom8G3Z0dXirz5cZUy6iPXlVh7jhfYNZlA
         va4eJ68Kjhci7L7pKvfO2F+bJc4TubLcyH0TzYoQZUpPpMnsPXShQRopZCcoiEsmv+wD
         zd3g==
X-Gm-Message-State: ACrzQf0k07KQp1NElfQPaPAWemfbEhVOPR+u/Ia9EFF8U9loV6NEKwfR
        hO4Jl4nsFGVxgnYCtoFOAIo+XGLiVAihTA==
X-Google-Smtp-Source: AMsMyM5dq3lpqKYGqvXVbIarSdysWlMpXtmmcoUyavLhw1Gbp8Kh4dHa9QCptW7kaCiTuBZWHtuQoQ==
X-Received: by 2002:a05:620a:2629:b0:6ee:b2cf:aeb5 with SMTP id z41-20020a05620a262900b006eeb2cfaeb5mr9621537qko.62.1666279805421;
        Thu, 20 Oct 2022 08:30:05 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a29c300b006d1d8fdea8asm7815891qkp.85.2022.10.20.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:30:04 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:30:03 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 03/11] btrfs: add support for inserting raid stripe
 extents
Message-ID: <Y1Fpe1ATGwW0o5J3@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <5c8b4c3005d7c02ca4ab76a1802f14137ae47bda.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c8b4c3005d7c02ca4ab76a1802f14137ae47bda.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:21AM -0700, Johannes Thumshirn wrote:
> Add support for inserting stripe extents into the raid stripe tree on
> completion of every write that needs an extra logical-to-physical
> translation when using RAID.
> 
> Inserting the stripe extents happens after the data I/O has completed,
> this is done to a) support zone-append and b) rule out the possibility of
> a RAID-write-hole.
> 
> This is done by creating in-memory ordered stripe extents, just like the
> in memory ordered extents, on I/O completion and the on-disk raid stripe
> extents get created once we're running the delayed_refs for the extent
> item this stripe extent is tied to.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/Makefile           |   2 +-
>  fs/btrfs/ctree.h            |   3 +
>  fs/btrfs/disk-io.c          |   3 +
>  fs/btrfs/extent-tree.c      |  48 +++++++++
>  fs/btrfs/inode.c            |   6 ++
>  fs/btrfs/raid-stripe-tree.c | 189 ++++++++++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |  49 ++++++++++
>  fs/btrfs/volumes.c          |  35 ++++++-
>  fs/btrfs/volumes.h          |  14 +--
>  fs/btrfs/zoned.c            |   4 +
>  10 files changed, 345 insertions(+), 8 deletions(-)
>  create mode 100644 fs/btrfs/raid-stripe-tree.c
>  create mode 100644 fs/btrfs/raid-stripe-tree.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 99f9995670ea..4484831ac624 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>  	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>  	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
>  	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
> -	   subpage.o tree-mod-log.o
> +	   subpage.o tree-mod-log.o raid-stripe-tree.o
>  
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 430f224743a9..1f75ab8702bb 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1102,6 +1102,9 @@ struct btrfs_fs_info {
>  	struct lockdep_map btrfs_trans_pending_ordered_map;
>  	struct lockdep_map btrfs_ordered_extent_map;
>  
> +	struct mutex stripe_update_lock;

The mutex seems a bit heavy handed here, but I don't have a good mental model
for the mix of adds/lookups there are.  I think at the very least a spin lock is
more appropriate, and maybe an rwlock depending on how often we're doing a
add/remove vs lookups.

<snip>
> +
> +static int ordered_stripe_cmp(const void *key, const struct rb_node *node)
> +{
> +	struct btrfs_ordered_stripe *stripe =
> +		rb_entry(node, struct btrfs_ordered_stripe, rb_node);
> +	const u64 *logical = key;
> +
> +	if (*logical < stripe->logical)
> +		return -1;
> +	if (*logical >= stripe->logical + stripe->num_bytes)
> +		return 1;
> +	return 0;
> +}
> +
> +static int ordered_stripe_less(struct rb_node *rba, const struct rb_node *rbb)
> +{
> +	struct btrfs_ordered_stripe *stripe =
> +		rb_entry(rba, struct btrfs_ordered_stripe, rb_node);
> +	return ordered_stripe_cmp(&stripe->logical, rbb);
> +}

Ahhh yay we're finally not adding new rb tree insert/lookup functions that are
99% the same.  Thanks,

Josef
