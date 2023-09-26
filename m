Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803587AF20E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjIZR6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjIZR6P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 13:58:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75AE9F
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 10:58:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F6CC433C8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695751088;
        bh=dpNjbHu3kuWxnKPd8w9WnOrRL+6KCmgwo1ah9b6h8ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SRTU7IcfRE7+2BHfK39vSqEaUMgrX8NO9v7l5PoOt1BK2Wmcd8aZ8gmrVQKahFTs0
         vhu0VjoAdVCsChy8BjDanl11Crls3TxPstx4WGwYSGI09kUHudyGGopRColWcQltxV
         twSFr8IJ6ORJWsSXtcqQE0b1Qo/bDRfGBmvc5lSR2F/NMzWiiBKlbssH+PE7M8VCfn
         3I8oZH/s4FztrBiUXwYzKQr/ediu8zZdzzdNW+KxRmWgKWdjDYRl+0PzxMp31+1QcL
         X1U+uL/hJmgIzsrrHuQjnSyt0nmlhCiX607XunawPmV8HXNW1mbkGVg+5CWoar04cZ
         T852moMDyE3Ng==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6c4a25f6390so5099207a34.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 10:58:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YyMOisBfiuj2sJkZS4e8VbW420okaGqweVBTLoUQThv1h9zoLEy
        uAEjLq0kV7VUfWtFhx2065M0dnPeIu/DKCXtsOQ=
X-Google-Smtp-Source: AGHT+IGkuU4hMioJc197MoIwBJ5FxaTXzvtHZEYpRUqFXYFJSUbEPwgAeagzC2bCf7Axc7tRRb+1iHk4gY+gdCJI5vE=
X-Received: by 2002:a05:6870:2314:b0:1bf:77e2:95cc with SMTP id
 w20-20020a056870231400b001bf77e295ccmr12894913oao.17.1695751087623; Tue, 26
 Sep 2023 10:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695731838.git.fdmanana@suse.com> <a678551d318d5dd9835ad9800dfb41c787654dd1.1695731841.git.fdmanana@suse.com>
 <20230926173130.GU13697@twin.jikos.cz>
In-Reply-To: <20230926173130.GU13697@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 26 Sep 2023 18:57:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4i=zNmR0QfjxeN8JYsGKiqaXb3qp9TjqbAVZEKu_dZhw@mail.gmail.com>
Message-ID: <CAL3q7H4i=zNmR0QfjxeN8JYsGKiqaXb3qp9TjqbAVZEKu_dZhw@mail.gmail.com>
Subject: Re: [PATCH 1/8] btrfs: error out when COWing block using a stale transaction
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 6:38=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Sep 26, 2023 at 01:45:13PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At btrfs_cow_block() we have these checks to verify we are not using a
> > stale transaction (a past transaction with an unblocked state or higher=
),
> > and the only thing we do is to trigger a WARN with a message and a stac=
k
> > trace. This however is a critical problem, highly unexpected and if it
> > happens it's most likely due to a bug, so we should error out and turn =
the
> > fs into error state so that such issue is much more easily noticed if i=
t's
> > triggered.
> >
> > The problem is critical because using such stale transaction will lead =
to
> > not persisting the extent buffer used for the COW operation, as allocat=
ing
> > a tree block adds the range of the respective extent buffer to the
> > ->dirty_pages iotree of the transaction, and a stale transaction, in th=
e
> > unlocked state or higher, will not flush dirty extent buffers anymore,
> > therefore resulting in not persisting the tree block and resource leaks
> > (not cleaning the dirty_pages iotree for example).
> >
> > So do the following changes:
> >
> > 1) Return -EUCLEAN if we find a stale transaction;
> >
> > 2) Turn the fs into error state, with error -EUCLEAN, so that no
> >    transaction can be committed, and generate a stack trace;
> >
> > 3) Combine both conditions into a single if statement, as both are rela=
ted
> >    and have the same error message;
> >
> > 4) Mark the check as unlikely, since this is not expected to ever happe=
n.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/ctree.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 56d2360e597c..dff2e07ba437 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -686,14 +686,22 @@ noinline int btrfs_cow_block(struct btrfs_trans_h=
andle *trans,
> >               btrfs_err(fs_info,
> >                       "COW'ing blocks on a fs root that's being dropped=
");
> >
> > -     if (trans->transaction !=3D fs_info->running_transaction)
> > -             WARN(1, KERN_CRIT "trans %llu running %llu\n",
> > -                    trans->transid,
> > -                    fs_info->running_transaction->transid);
> > -
> > -     if (trans->transid !=3D fs_info->generation)
> > -             WARN(1, KERN_CRIT "trans %llu running %llu\n",
> > -                    trans->transid, fs_info->generation);
> > +     /*
> > +      * COWing must happen through a running transaction, which always
> > +      * matches the current fs generation (it's a transaction with a s=
tate
> > +      * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the=
 fs
> > +      * into error state to prevent the commit of any transaction.
> > +      */
> > +     if (unlikely(trans->transaction !=3D fs_info->running_transaction=
 ||
> > +                  trans->transid !=3D fs_info->generation)) {
> > +             btrfs_handle_fs_error(fs_info, -EUCLEAN,
>
> Can this be a transaction abort? The helper btrfs_handle_fs_error() is
> from times before we had the abort mechanism and should not be used in
> new code when the abort can be done. There are cases where transaction
> is not available (like superblock commit), but these are exceptions.

The handle we have here is for a stale transaction - not the one
currently running (if there's any).
That's why the btrfs_handle_fs_error() call instead.

>
> > +"unexpected transaction when attempting to COW block %llu on root %llu=
, transaction %llu running transaction %llu fs generation %llu",
> > +                                   buf->start, btrfs_root_id(root),
> > +                                   trans->transid,
> > +                                   fs_info->running_transaction->trans=
id,
> > +                                   fs_info->generation);
> > +             return -EUCLEAN;
> > +     }
> >
> >       if (!should_cow_block(trans, root, buf)) {
> >               *cow_ret =3D buf;
> > --
> > 2.40.1
