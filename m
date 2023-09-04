Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2621879180D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Sep 2023 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352584AbjIDN1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Sep 2023 09:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353027AbjIDN1D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Sep 2023 09:27:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E73CCDF
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 06:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4BECB80DB1
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 13:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F70AC433CC
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693834015;
        bh=uZgSR5q7j5kxo+7X8TOvm2MvY05o/9qcmsh69G5qT3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F9MBvLPv9t5IsJu53BtExpv+cZmjfi136cyvjgCRsorXiraEiUcixWyOSCX1um9Cy
         SpgT+5uzhfvA5uIj6wDNzSX9H5ujcLYpPA2x7cHTj/yewKZ3mvWZx8Nvn8nj9xwBWe
         B+zKBqxAakL/TaG6dPQrbNRp34FWRfa+z6K0kouEBIMw+KgSbj5qQ/bCpSGSwemZCY
         yx3W8iZKgGy5+UxQitt3V1raiE1mVZHvBzgmnFP6gyVrHjkWlG7tr+mQcBYZJtvV1J
         6HrUfygS+9XtYc6Dk76u9m+dytgNypBp5RwtvBu7jveQmjem3OvMaYP/hf5bPYo4Mh
         JGEVLdteZUWbA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1d4c9494b42so1052096fac.0
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Sep 2023 06:26:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxd3AVL+Ct8QYjLZzZsAxL+wY99OY7ktOEqr3cUaxwkS6J91KRL
        VKzDyLgiG1ArzeuoAw46pqB7DSva6wmiU2og2KM=
X-Google-Smtp-Source: AGHT+IGhj9d4WmQO40Fnc6mvLoPS68hgRYOt3BLQ5+VuGn+tViJleSZJ0rrzPj1gqcJ4yqX8kssNXUCSAtOxofF3a3I=
X-Received: by 2002:a05:6870:658b:b0:1bb:ba55:3fdd with SMTP id
 fp11-20020a056870658b00b001bbba553fddmr13237223oab.7.1693834014492; Mon, 04
 Sep 2023 06:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <f5eda1ba8b7a776d3407d30939078b63d02aaff4.1693825574.git.fdmanana@suse.com>
 <2141e167-99ba-4a12-b053-af2cd7124a7a@gmx.com>
In-Reply-To: <2141e167-99ba-4a12-b053-af2cd7124a7a@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 4 Sep 2023 14:26:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4QR8aLRFtVOuhXoxSyFAdRJqCgvD7v9W=pNaUnLyKmhg@mail.gmail.com>
Message-ID: <CAL3q7H4QR8aLRFtVOuhXoxSyFAdRJqCgvD7v9W=pNaUnLyKmhg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix race between finishing block group creation
 and its item update
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 4, 2023 at 1:22=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> On 2023/9/4 19:10, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Commit 675dfe1223a6 ("btrfs: fix block group item corruption after
> > inserting new block group") fixed one race that resulted in not persist=
ing
> > a block group's item when its "used" bytes field decreases to zero.
> > However there's another race that can happen in a much shorter time win=
dow
> > that results in the same problem. The following sequence of steps expla=
ins
> > how it can happen:
> >
> > 1) Task A creates a metadata block group X, its "used" and "commit_used=
"
> >     fields are initialized to 0;
> >
> > 2) Two extents are allocated from block group X, so its "used" field is
> >     updated to 32K, and its "commit_used" field remains as 0;
> >
> > 3) Transaction commit starts, by some task B, and it enters
> >     btrfs_start_dirty_block_groups(). There it tries to update the bloc=
k
> >     group item for block group X, which currently has its "used" field =
with
> >     a value of 32K and its "commited_used" field with a value of 0. How=
ever
> >     that fails since the block group item was not yet inserted, so at
> >     update_block_group_item(), the btrfs_search_slot() call returns 1, =
and
> >     then we set 'ret' to -ENOENT. Before jumping to the label 'fail'...
> >
> > 4) The block group item is inserted by task A, when for example
> >     btrfs_create_pending_block_groups() is called when releasing its
> >     transaction handle. This results in insert_block_group_item() inser=
ting
> >     the block group item in the extent tree (or block group tree), with=
 a
> >     "used" field having a value of 32K and setting "commit_used", in st=
ruct
> >     btrfs_block_group, to the same value (32K);
> >
> > 5) Task B jumps to the 'fail' label and then resets the "commit_used"
> >     field to 0. At btrfs_start_dirty_block_groups(), because -ENOENT wa=
s
> >     returned from update_block_group_item(), we add the block group aga=
in
> >     to the list of dirty block groups, so that we will try again in the
> >     critical section of the transaction commit when calling
> >     btrfs_write_dirty_block_groups();
> >
> > 6) Later the two extents from block group X are freed, so its "used" fi=
eld
> >     becomes 0;
> >
> > 7) If no more extents are allocated from block group X before we get in=
to
> >     btrfs_write_dirty_block_groups(), then when we call
> >     update_block_group_item() again for block group X, we will not upda=
te
> >     the block group item to reflect that it has 0 bytes used, because t=
he
> >     "used" and "commit_used" fields in struct btrfs_block_group have th=
e
> >     same value, a value of 0.
> >
> >     As a result after committing the transaction we have an empty block
> >     group with its block group item having a 32K value for its "used" f=
ield.
> >     This will trigger errors from fsck ("btrfs check" command) and afte=
r
> >     mounting again the fs, the cleaner kthread will not automatically d=
elete
> >     the empty block group, since its "used" field is not 0. Possibly th=
ere
> >     are other issues due to this incosistency.
> >
> >     When this issue happens, the error reported by fsck is like this:
> >
> >       [1/7] checking root items
> >       [2/7] checking extents
> >       block group [1104150528 1073741824] used 39796736 but extent item=
s used 0
> >       ERROR: errors found in extent allocation tree or chunk allocation
> >       (...)
> >
> > So fix this by not resetting the "commit_used" field of a block group w=
hen
> > we don't find the block group item at update_block_group_item().
> >
> > Fixes: 7248e0cebbef ("btrfs: skip update of block group item if used by=
tes are the same")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Although considering we have hit at least two bugs around "commit_used",
> can we have a more generic way like setting "commit_used" to some
> impossible values (e.g, U64_MAX) so that the bg is ensured to be updated?

I don't see how initializing commit_used to U64_MAX, or anything else,
would have prevented any of these two bugs...

>
> Thanks,
> Qu
> > ---
> >   fs/btrfs/block-group.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 0cb1dee965a0..b2e5107b7cec 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -3028,8 +3028,16 @@ static int update_block_group_item(struct btrfs_=
trans_handle *trans,
> >       btrfs_mark_buffer_dirty(leaf);
> >   fail:
> >       btrfs_release_path(path);
> > -     /* We didn't update the block group item, need to revert @commit_=
used. */
> > -     if (ret < 0) {
> > +     /*
> > +      * We didn't update the block group item, need to revert commit_u=
sed
> > +      * unless the block group item didn't exist yet - this is to prev=
ent a
> > +      * race with a concurrent insertion of the block group item, with
> > +      * insert_block_group_item(), that happened just after we attempt=
ed to
> > +      * update. In that case we would reset commit_used to 0 just afte=
r the
> > +      * insertion set it to a value greater than 0 - if the block grou=
p later
> > +      * becomes with 0 used bytes, we would incorrectly skip its updat=
e.
> > +      */
> > +     if (ret < 0 && ret !=3D -ENOENT) {
> >               spin_lock(&cache->lock);
> >               cache->commit_used =3D old_commit_used;
> >               spin_unlock(&cache->lock);
