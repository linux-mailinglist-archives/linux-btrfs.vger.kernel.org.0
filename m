Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AE1706E0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjEQQZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQQZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 12:25:38 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62A8FB
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 09:25:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ab02aeac3fso422945a34.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684340736; x=1686932736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TjjSWKmne2Ya5j0Avcxfk7Er7nMBZ1gwmKQ27BsXjNY=;
        b=WeVxZarQHQwTNe3XuMhzcLJu1e29T+m2eA8/Yt/N55Kq9fyEEY8CSHWbwI/j+KNwHi
         N7EtvLSe9p2GIIz7/HahU0q/T2bU+PVSmGR/wX2231MVouTa5jmzdY4rdwm28Rl3hKY5
         +H2mdUZ4PL7ELnO1XxmUwdbtP62AgOR2yh2V1OqOftf0RtoMBbycTJmH6SNr7tqhQnMX
         1enjT6lTUnY5+/gFyKtOMKFQiYVyeKk7eXgPkxt3u5HJLuqppi2kWO3i2h9P/efZzazu
         EQbUSWgRjCvrN1RjTjeqc7NfKHGVvr7BV5e5aVcbdYBOVSP4mSQbSSKiYo6FFBX8zwcS
         BGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340736; x=1686932736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TjjSWKmne2Ya5j0Avcxfk7Er7nMBZ1gwmKQ27BsXjNY=;
        b=dUZLE63WyHQHjoIJUFuIyOo0FQ0FtoJcNbd3+mVAEnUwQWoOOGDuJXXdqIkPJM9sDB
         et0K7FJIeltYMUDHrlb6gX3GAB484L4VZfm+Wne2V1NkBhS/Sxc4VpXvOHrtsP6oPmkU
         1UItdScaEYUjraqNnGsnTCO1SDXxpWcpXBy6TvFg7ZxPv8ihWmR3VfqvYF5AfpXmW8na
         N30ChuiMBPLvkxNy964XH9GaNG61qlJ+aljuwILzmnz+4ggf4TFIOVhaxe1KpYmdQiUc
         1a959yxTL32VbwBvRgtvrAotWJ3od6Ced4xZwUWlMKYqYPQbQLwUm6avOrdCkYPdowQW
         8Dlw==
X-Gm-Message-State: AC+VfDz9Rur5/R5s/b+ypmfFZw+yp1yGE42OwoC5+B+WQKuAVdVzXZzB
        XKpspaREgLvi+GqmbWdeFBb5GYEcLtTbqdFFNWo=
X-Google-Smtp-Source: ACHHUZ4Gx9fV3ni2nDT8ITpaPNFi9cgyVV4H8mqPiyFrVpyZbt/1nzIAY1Hl2XD6ExGIpKbjSFKeW1601rb+8Oz+6IU=
X-Received: by 2002:a05:6808:2a04:b0:392:5882:69dd with SMTP id
 ez4-20020a0568082a0400b00392588269ddmr12368286oib.10.1684340736031; Wed, 17
 May 2023 09:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230515192256.29006-1-hch@lst.de> <20230515192256.29006-2-hch@lst.de>
 <CAL3q7H7k0fvvQVb5Eq3Uz61q6j1EnjxCVEeaaqu-o-JCL8K+7Q@mail.gmail.com> <20230517122150.GA17334@lst.de>
In-Reply-To: <20230517122150.GA17334@lst.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 May 2023 17:24:59 +0100
Message-ID: <CAL3q7H6E6kUsqpVEaRqc=WRHatborKE+mG3BauNyYD+2Jc+O3A@mail.gmail.com>
Subject: Re: [PATCH 1/6] btrfs: use a linked list for tracking
 per-transaction/log dirty buffers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 17, 2023 at 1:21=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, May 17, 2023 at 11:40:14AM +0100, Filipe Manana wrote:
> > > This patch instead switches tracking to one linked list per transacti=
on
> > > and two to each root for the two tree logs which link a new object th=
at
> > > points directly to the buffer.  Note that the list_head can't directl=
y be
> > > embedded into the extent_buffer structure given that a buffer can be =
part
> > > of more than one transaction or tree_log.  This also means the existi=
ng
> > > error propagation based off eb->log_index never fully worked, as this
> > > index would get overwritten once a buffer is added to a new dirty tre=
e.
> >
> > If an extent buffer is part of 2 transactions, it means that when it
> > was allocated
> > for the next one, it was already cleaned up in the previous one, so
> > its ->log_index is
> > no longer used by the previous transaction and can be safely
> > overwritten by the next transaction.
> >
> > Or did you find a case where that is not true?
>
> At least with a previous version of this patch where the list_head was
> embedded into the extent_buffer structure I could very easily reproduce
> cases where one buffer was added to another list while still on another
> one.  The most common case was a tree log and a transaction, but I think
> I've also seen two transactions or two tree logs.

Probably what you ran into is the case where a tree block is allocated
and freed in the same transaction before being written, in that case
it gets added
back to the free space cache (this happens at btrfs_free_tree_block())
and can be allocated again in the same transaction.
If so, in that case you can remove it from the list and you shouldn't
run into that issue anymore.
We currently don't remove it from the io tree in that case, because
that may need splitting an existing extent state record and therefore
requiring allocating memory.

I can't remember any other case that could lead to that.

>
> "Cleanup up" means written back and waited for writeback or dirty
> canceled I guess? Or is there some other aspect I should look for?

Yes, it's that.

>
> > > @@ -202,7 +202,8 @@ struct btrfs_root {
> > >         struct btrfs_root_item root_item;
> > >         struct btrfs_key root_key;
> > >         struct btrfs_fs_info *fs_info;
> > > -       struct extent_io_tree dirty_log_pages;
> > > +       struct list_head dirty_buffers[2];
> >
> > As this is for the log tree, I'd prefer to have its name reflect that,
> > like we had before.
> > Something like "log_dirty_buffers" for example.
>
> Ok.  Given that the btrfs_root structure isn't specific to log_trees
> that absolutely makes sense.
>
> > 1) With the io tree approach, if we allocate multiple extent buffers
> > that are adjacent, we get a single entry to represent them, due the
> > merging done by the io tree code.
> > With this new approach we don't have any merging at all, using more
> > memory and keeping a longer list, which will take longer to iterate
> > and sort.
>
> At least in theory yes.  But we also save a whole lot of lookups
> by going directly to the object instead of indirecting through the
> pages xarray and then again through the buffers array for the
> sub-block case.

I think you are talking about further changes in the patchset, not
about this particular patch?

I'm talking about the data structure used to represent a range, not pages.
The io tree is good to merge adjacent ranges and reduce the total
structure size and used memory
(and it's not uncommon to have allocated metadata extents that are
adjacent, either due to new block groups or holes in existing ones).

>
> > For example if a 1G metadata block group is allocated, and then we
> > allocate all metadata extents from it, we get 65536 struct
> > dirty_buffer allocated, while with the io tree approach we would get a
> > single struct extent_state record.
>
> But that will only get you to the filemap_fdtawrite and fdatawait.
> After that we're still looking up every single page in that range
> while with this series (the patch alone isn't enough, the rest of
> the work comes in later patches) the list gets us straight to the
> extent_buffer.
>
> > 2) We now need to keep references on the extent buffers. This means
> > they can't be released from memory until the transaction commits.
> > Before we didn't do this, and if an extent buffer was allocated and
> > freed in the same transaction, we wouldn't need to keep it in memory
> > until the transaction commits.
> > We would not need to do it as well if its writeback is started and
> > completed before the transaction commit.
>
> True.  But at the same time it will allow to get rid of all the
> extent_buffer_under_io hacks.  Note that if we figure out what
> causes buffers to be added to multiple transactions/tree_logs and
> just have a list in the object we could just deleted it when cleaned
> and have the best of both worlds.
>
> > 3) Looking a bit below, we now need to sort the list, which can be
> > huge, especially taking into account the fact that adjacent extents
> > are not merged anymore as mentioned before, potentially making anyone
> > who's waiting on the transaction commit to wait for longer.
> > On the other end, when a task allocates a new buffer the insertion is
> > faster, as it's just appending to a list and can reduce the latency of
> > many syscalls (creat, mkdir, rmdir, rename, link/unlink, reflinks,
> > etc)
> >
> > Not saying that in the end this approach isn't often or generally
> > better, but at the very least I would like to see all these
> > differences explicitly mentioned in the changelog.
> > The changelog gives the impression that there are no tradeoffs and the
> > new solution is better in every aspect.
> >
> > I would say more tests/benchmarks results would be good to have too,
> > other than just fs_mark, and have the tests mentioned in the changelog
> > (results before and after this change, command lines, fio configs for
> > example).
>
> Do you have any particular workload you think would be useful to test?

fs_mark (as you did already), dbench, fio for random writes and periodic fs=
ync,
anything that is not too short, runtimes of several minutes at least.

Thanks.


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
