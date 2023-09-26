Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE667AF281
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjIZSTT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZSTS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:19:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0698ABF
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:19:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3312C433C9
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695752351;
        bh=1wgxoScG3kgSV/3N4qJFKLv1CJ6BvuE/Wz4pkYva9ds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KhP+qJwBASjx74tTeICTqoLqNrCpDvkHAvxrLOIQLSH2mFSvnSclqGCC8DnggRHma
         Y2f8JHpXbeyjpDALg54Zx+zzpoMU0j6KpQNzxMg9C8EJkYi6Hw0XzObwzbV/8kTJbn
         ilPAv+RadbRVw71tA6gL/Ewn4dGZeReLeXYYZhXIO28bluh3JddUBoLWc0VndcyFMo
         vRYECFWEwULvK4mzrKlyhNN7rI+PY+h/htmVReINYk8i+uEQ+hHrA5Mce1X4zYPVnp
         jeh8nBVE+pTrvwwp4XnyMw+0vsdcLrxhLQ2WG99PMtb+fVc9zrS+8+dIiWWSZh1YwS
         su58rIfwVfShQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6bf58009a8dso5530834a34.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:19:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YwnVMsLC2vTk1b09+WCEdt1v7dc8QwnwMtKPQDEppq0LnmoQ4pX
        eHuVwR4DtPTRxg7YTYKJVdPFvE0+WModvvurCRU=
X-Google-Smtp-Source: AGHT+IHd4Vrz2qZMdMXo2cS/BZRJcgYol00IV846xGf/M5FUaAqmXcZmiw0r7OHlU+XQ0CFkkPF/uolK8XZa4vAlNXw=
X-Received: by 2002:a05:6870:220b:b0:1d6:3f77:c214 with SMTP id
 i11-20020a056870220b00b001d63f77c214mr11257089oaf.55.1695752350914; Tue, 26
 Sep 2023 11:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695731838.git.fdmanana@suse.com> <a678551d318d5dd9835ad9800dfb41c787654dd1.1695731841.git.fdmanana@suse.com>
 <20230926173130.GU13697@twin.jikos.cz> <CAL3q7H4i=zNmR0QfjxeN8JYsGKiqaXb3qp9TjqbAVZEKu_dZhw@mail.gmail.com>
In-Reply-To: <CAL3q7H4i=zNmR0QfjxeN8JYsGKiqaXb3qp9TjqbAVZEKu_dZhw@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 26 Sep 2023 19:18:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H60GF6Euxy-YLWnXgXANYJXyPpro_DD=5cza47u=iqHZQ@mail.gmail.com>
Message-ID: <CAL3q7H60GF6Euxy-YLWnXgXANYJXyPpro_DD=5cza47u=iqHZQ@mail.gmail.com>
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

On Tue, Sep 26, 2023 at 6:57=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Tue, Sep 26, 2023 at 6:38=E2=80=AFPM David Sterba <dsterba@suse.cz> wr=
ote:
> >
> > On Tue, Sep 26, 2023 at 01:45:13PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > At btrfs_cow_block() we have these checks to verify we are not using =
a
> > > stale transaction (a past transaction with an unblocked state or high=
er),
> > > and the only thing we do is to trigger a WARN with a message and a st=
ack
> > > trace. This however is a critical problem, highly unexpected and if i=
t
> > > happens it's most likely due to a bug, so we should error out and tur=
n the
> > > fs into error state so that such issue is much more easily noticed if=
 it's
> > > triggered.
> > >
> > > The problem is critical because using such stale transaction will lea=
d to
> > > not persisting the extent buffer used for the COW operation, as alloc=
ating
> > > a tree block adds the range of the respective extent buffer to the
> > > ->dirty_pages iotree of the transaction, and a stale transaction, in =
the
> > > unlocked state or higher, will not flush dirty extent buffers anymore=
,
> > > therefore resulting in not persisting the tree block and resource lea=
ks
> > > (not cleaning the dirty_pages iotree for example).
> > >
> > > So do the following changes:
> > >
> > > 1) Return -EUCLEAN if we find a stale transaction;
> > >
> > > 2) Turn the fs into error state, with error -EUCLEAN, so that no
> > >    transaction can be committed, and generate a stack trace;
> > >
> > > 3) Combine both conditions into a single if statement, as both are re=
lated
> > >    and have the same error message;
> > >
> > > 4) Mark the check as unlikely, since this is not expected to ever hap=
pen.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/ctree.c | 24 ++++++++++++++++--------
> > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > > index 56d2360e597c..dff2e07ba437 100644
> > > --- a/fs/btrfs/ctree.c
> > > +++ b/fs/btrfs/ctree.c
> > > @@ -686,14 +686,22 @@ noinline int btrfs_cow_block(struct btrfs_trans=
_handle *trans,
> > >               btrfs_err(fs_info,
> > >                       "COW'ing blocks on a fs root that's being dropp=
ed");
> > >
> > > -     if (trans->transaction !=3D fs_info->running_transaction)
> > > -             WARN(1, KERN_CRIT "trans %llu running %llu\n",
> > > -                    trans->transid,
> > > -                    fs_info->running_transaction->transid);
> > > -
> > > -     if (trans->transid !=3D fs_info->generation)
> > > -             WARN(1, KERN_CRIT "trans %llu running %llu\n",
> > > -                    trans->transid, fs_info->generation);
> > > +     /*
> > > +      * COWing must happen through a running transaction, which alwa=
ys
> > > +      * matches the current fs generation (it's a transaction with a=
 state
> > > +      * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn t=
he fs
> > > +      * into error state to prevent the commit of any transaction.
> > > +      */
> > > +     if (unlikely(trans->transaction !=3D fs_info->running_transacti=
on ||
> > > +                  trans->transid !=3D fs_info->generation)) {
> > > +             btrfs_handle_fs_error(fs_info, -EUCLEAN,
> >
> > Can this be a transaction abort? The helper btrfs_handle_fs_error() is
> > from times before we had the abort mechanism and should not be used in
> > new code when the abort can be done. There are cases where transaction
> > is not available (like superblock commit), but these are exceptions.
>
> The handle we have here is for a stale transaction - not the one
> currently running (if there's any).
> That's why the btrfs_handle_fs_error() call instead.

We can actually btrfs_abort_transaction() even on a stale one. It
still sets the error
at fs_info->fs_error, which is what matters here.

Do you want me to replace it and send a v2, or do you prefer to fixup
it up yourself?

Thanks

>
> >
> > > +"unexpected transaction when attempting to COW block %llu on root %l=
lu, transaction %llu running transaction %llu fs generation %llu",
> > > +                                   buf->start, btrfs_root_id(root),
> > > +                                   trans->transid,
> > > +                                   fs_info->running_transaction->tra=
nsid,
> > > +                                   fs_info->generation);
> > > +             return -EUCLEAN;
> > > +     }
> > >
> > >       if (!should_cow_block(trans, root, buf)) {
> > >               *cow_ret =3D buf;
> > > --
> > > 2.40.1
