Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F957CBFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGUNdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 09:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiGUNdF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 09:33:05 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9840C5A44B
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 06:33:03 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id h18so1141689qvr.12
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+CypOsxOdVNzvJDY/ub5DLi8fr7ajddOUICQzh5dlMY=;
        b=PwUzMUF+qwjVUrUJHI3d25OjCwIAfNrq9tTBP7OEZU+8Tv9Mc8RA6vpAVNICEc3oq+
         7u2H2Daioa/9SDdmlQNDJv+7kr1FFofhxNOaO8xoN6oPJZm0t33rcRxhB142gV7HYTVp
         sh9XqynK21xnLxIc0B5zcxN/opMDveLbUacM0hEiAEUr3hOQbcy5DEHcWYWp22JMGE3V
         PaMbdecRNnpYvkGjm4ILdsxunYJ+hg3ZA7sXdBW76l/cl30bjrkqLMV/q1vxJzGO+au4
         5OPzoNpUffvdVx2Xbt6Fj/bplqFpkvILp3MpYmlLsuvofYBAx/tSjCJJX1Y+DfhGxyKq
         rMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+CypOsxOdVNzvJDY/ub5DLi8fr7ajddOUICQzh5dlMY=;
        b=uGEmp2cFgysiYhlI+73+TmTzUpNdz07tBzyjpk1jTPyAgs2o5rmstmAcY1Gx/NzJm9
         +a6FRx8Hnw5J3s6qUveRlQXdEJHv57Dw4DgpUxx8PTgc8/VWHtXTudH9yxpoZMyDaM5c
         e4LQ2r3AzUJZywQTNPETNlrJ79Sh1WhCBtMQGL3RQvTVWSnPCqqboyVg3764t3mEEr2H
         PllN4NUn2Z0BJEpCMsd/85T62Neo1n9w/4cy85li+oAv4nqfA8tcD/L36MH8DfSTEoQP
         4m1b3Q/X6ATORhjqRmNqoq/rY/ZEVZ4fcvHN+yewcC58BP3dlzT6hCYwJg33qeH3lyE1
         9EkA==
X-Gm-Message-State: AJIora9jaOzbMz4xyVCp4r5VcFh677Xs/uKvVkt9l8BAOpsRk2TbXe6Q
        ssZtYD1dpbRWACOMPH5nUOLFkiwGtEMpiw==
X-Google-Smtp-Source: AGRyM1sdlk0qM59SxVez7IcjDaqYw/JTrosry0babyGheP9roR4arDO1s6GYrnefAp9NY5TQYQm7LA==
X-Received: by 2002:a0c:9c83:0:b0:473:442d:ad4 with SMTP id i3-20020a0c9c83000000b00473442d0ad4mr33589568qvf.9.1658410382446;
        Thu, 21 Jul 2022 06:33:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v33-20020a05622a18a100b0031f0b43629dsm1400163qtc.23.2022.07.21.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:33:01 -0700 (PDT)
Date:   Thu, 21 Jul 2022 09:33:00 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not batch insert non-consecutive dir indexes
 during log replay
Message-ID: <YtlVjIrXqtn2oMln@localhost.localdomain>
References: <2afa2744e3ea3a2290ab683cac51907ef10f8582.1658332827.git.josef@toxicpanda.com>
 <f80b3b68-8aea-b1ac-c247-1cf18583c6b0@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80b3b68-8aea-b1ac-c247-1cf18583c6b0@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 20, 2022 at 09:27:03PM -0400, Sweet Tea Dorminy wrote:
> Looks fine to me, just a couple of clarification questions and a request for
> a Fixes: if possible:
> 
> On 7/20/22 12:00, Josef Bacik wrote:
> > While running generic/475 in a loop I got the following error
> > 
> > BTRFS critical (device dm-11): corrupt leaf: root=5 block=31096832 slot=69, bad key order, prev (263 96 531) current (263 96 524)
> > <snip>
> >   item 65 key (263 96 517) itemoff 14132 itemsize 33
> >   item 66 key (263 96 523) itemoff 14099 itemsize 33
> >   item 67 key (263 96 525) itemoff 14066 itemsize 33
> >   item 68 key (263 96 531) itemoff 14033 itemsize 33
> >   item 69 key (263 96 524) itemoff 14000 itemsize 33
> > 
> > As you can see here we have 3 dir index keys with the dir index value of
> > 523, 524, and 525 inserted between 517 and 524.  This occurs because our
> > dir index insertion code will bulk insert all dir index items on the
> > node regardless of their actual key value.
> > 
> > This makes sense on a normally running system, because if there's a gap
> > in between the items there was a deletion before the item was inserted,
> > so there's not going to be an overlap of the dir index items that need
> > to be inserted and what exists on disk.
> > 
> > However during log replay this isn't necessarily true, we could have any
> > number of dir indexes in the tree already.
> > 
> > Fix this by seeing if we're replaying the log, and if we are simply skip
> > batching if there's a gap in the key space. >
> > This file system was left broken from the fstest, I tested this patch
> > against the broken fs to make sure it replayed the log properly, and
> > then btrfs check'ed the file system after the log replay to verify
> > everything was ok.
> 
> Might need a Fixes: ?

I didn't because the code is in for-next, not in Linus, and I wasn't sure if
Dave wanted to fold it in or what.

> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> > ---
> >   fs/btrfs/delayed-inode.c | 33 +++++++++++++++++++++++++++++++--
> >   1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 823aa05b3e38..0760578e0e86 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -691,9 +691,23 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
> >   	int total_size;
> >   	char *ins_data = NULL;
> >   	int ret;
> > +	bool need_consecutive = false;
> >   	lockdep_assert_held(&node->mutex);
> > +	/*
> > +	 * We will just batch non-consecutive items for insertion while running,
> > +	 * because the dir index offset is continuously increasing.  If there is
> > +	 * a gap in the key.offset range we simply deleted that entry and that
> > +	 * key won't exist in the tree.
> > +	 *
> > +	 * The exception to this is log replay, where we could have any pattern
> > +	 * of keys in our fs tree.  If we're recovering the log we can only
> > +	 * batch keys that are consecutive and have no gaps in their key space.
> > +	 */
> 
> I think the comments state the consecutive requirement in a way that might
> confuse future readers. To me, it seems like a pain but potentially slightly
> more efficient to check the open gap in the leaf and batch everything that
> goes in that gap. I would prefer this comment emphasize that contiguity is a
> cheap way to make sure we can insert the whole batch, but isn't strictly
> necessary as the comment currently implies.
> 
> Maybe:
> During normal operation, the dir index offset is continuously increasing, so
> we don't have to worry about existing dir index items with greater offsets
> in the tree already. Therefore, we can batch all items for a particular
> leaf.
> 
> For log replay, though, we could need to replay items whose sequence of
> offsets interleaves with the sequence of offsets already in the tree. For
> instance, we might need to replay items with offsets (523, 525, 531) into a
> leaf that already has items with offsets (517, 524). For simplicity, we only
> batch items with consecutive offsets, since we're guaranteed such a batch
> can be inserted in a consecutive range without any existing keys
> interfering.
> 
> (Maybe the variable should be named consecutive_only? Don't care much.)
> 
> > +	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
> > +		need_consecutive = true;
> > +
> >   	/*
> >   	 * For delayed items to insert, we track reserved metadata bytes based
> >   	 * on the number of leaves that we will use.
> > @@ -715,6 +729,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
> >   		if (!next)
> >   			break;
> > +		/*
> > +		 * We cannot allow gaps in the key space if we're doing log
> > +		 * replay.
> > +		 */
> > +		if (need_consecutive &&
> > +		    (next->key.offset != curr->key.offset + 1))
> > +			break;
> > +
> >   		ASSERT(next->bytes_reserved == 0);
> >   		next_size = next->data_len + sizeof(struct btrfs_item);
> > @@ -775,7 +797,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
> >   	ASSERT(node->index_item_leaves > 0);
> > -	if (next) {
> > +	/*
> > +	 * If we are need_consecutive we possibly stopped not because we batch
> > +	 * inserted an entire leaf, but because there was a gap in the key
> > +	 * space, so don't bother dropping the index_item_leaves here, simply
> > +	 * wait until we've run all of our items and release all of the space at
> > +	 * once.
> > +	 */
> Sort of a long sentence I had difficulty following. Maybe:
> "Normally, we only stop if we batch inserted an entire leaf. However, during
> log replay, we may have inserted only one of several contiguous-offset
> batches for a particular leaf, and therefore should wait to drop
> index_item_leaves until all the items are run."

Yup I'll update the comments.  Thanks,

Josef
