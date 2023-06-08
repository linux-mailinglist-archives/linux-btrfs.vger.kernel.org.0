Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8B727BBB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjFHJo3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjFHJoX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:44:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A026AC
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76C9464B41
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 09:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE58CC433D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686217460;
        bh=JhIUMml8WAz6kIlomaXnKv6XlHCJjOhmZ8Vo3SfU934=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sCkV89ZVWbcSk5O/ofle6ZOm8mMC4/pV7nTUK1k1VBwBnnmbeKSlHd08yOvaXDCbu
         ZNvylLNdpD1P1o+YWwJX/bucFPVvqacKuEImtvtouPvAxrQSlmbin6TSg04myKE+GG
         IbB4iy5szEqa2r3UevY0g8rNdFl8VEvcXzH9T7gqIvVSSvaaovwaEqdKpO9wE/GSpy
         RbY3qbNar9ICQg/u0t3Dkaw0rRHYZ64QsKzYoDdMkb7d2K1Jzfj3NAnur7TtCq+utM
         mLWWYpiLE41xEMl4C9byvLkeO3v0G6MvZjxhSlJpt2HWa0Q+f6hYzprRvuKSyVgtFX
         mpt7Kwcws4rtg==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6b2a2cba31eso177996a34.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 02:44:20 -0700 (PDT)
X-Gm-Message-State: AC+VfDw4kfnD+2jJnTmSEd5bAL9600ohn8Ly6XVePArqmwttPhSZqRaT
        uCs7jJkPMxK8ztO8rzuAesmwc3c1tq/Qe/rB5ZI=
X-Google-Smtp-Source: ACHHUZ5OzvFE2j1SYGR/8HIUqWjLVP6g5Q2Wjf1Is+zeW8euXdY9CZrJS927MXjTR16iK1tyCrA19wnGR4Z3h32Ps2o=
X-Received: by 2002:a05:6808:98b:b0:39a:bb23:e53c with SMTP id
 a11-20020a056808098b00b0039abb23e53cmr4291358oic.23.1686217459997; Thu, 08
 Jun 2023 02:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686164789.git.fdmanana@suse.com> <bd2831e141daa59bfba8b0dc24d839090b63d87f.1686164822.git.fdmanana@suse.com>
 <d8faba01-76a7-4401-bab9-483fd909139b@gmx.com>
In-Reply-To: <d8faba01-76a7-4401-bab9-483fd909139b@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 8 Jun 2023 10:43:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H62z==iZq5R6rYmj9mb0Abib8Fe3XEjrCvZUCdQ+RMMdg@mail.gmail.com>
Message-ID: <CAL3q7H62z==iZq5R6rYmj9mb0Abib8Fe3XEjrCvZUCdQ+RMMdg@mail.gmail.com>
Subject: Re: [PATCH 12/13] btrfs: do not BUG_ON() on tree mod log failures at insert_ptr()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 8, 2023 at 10:16=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/6/8 03:24, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At insert_ptr(), instead of doing a BUG_ON() in case we fail to record
> > tree mod log operations, do a transaction abort and return the error to
> > the callers. There's really no need for the BUG_ON() as we can release =
all
> > resources in the context of all callers, and we have to abort because o=
ther
> > future tree searches that use the tree mod log (btrfs_search_old_slot()=
)
> > may get inconsistent results if other operations modify the tree after
> > that failure and before the tree mod log based search.
> >
> > This implies making insert_ptr() return an int instead of void, and mak=
ing
> > all callers check for returned errors.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/ctree.c | 68 ++++++++++++++++++++++++++++++++++-------------=
-
> >   1 file changed, 49 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 6e59343034d6..f1fa89ae1184 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -2982,10 +2982,10 @@ static noinline int insert_new_root(struct btrf=
s_trans_handle *trans,
> >    * slot and level indicate where you want the key to go, and
> >    * blocknr is the block the key points to.
> >    */
> > -static void insert_ptr(struct btrfs_trans_handle *trans,
> > -                    struct btrfs_path *path,
> > -                    struct btrfs_disk_key *key, u64 bytenr,
> > -                    int slot, int level)
> > +static int insert_ptr(struct btrfs_trans_handle *trans,
> > +                   struct btrfs_path *path,
> > +                   struct btrfs_disk_key *key, u64 bytenr,
> > +                   int slot, int level)
> >   {
> >       struct extent_buffer *lower;
> >       int nritems;
> > @@ -3001,7 +3001,10 @@ static void insert_ptr(struct btrfs_trans_handle=
 *trans,
> >               if (level) {
> >                       ret =3D btrfs_tree_mod_log_insert_move(lower, slo=
t + 1,
> >                                       slot, nritems - slot);
> > -                     BUG_ON(ret < 0);
> > +                     if (ret < 0) {
> > +                             btrfs_abort_transaction(trans, ret);
> > +                             return ret;
> > +                     }
> >               }
> >               memmove_extent_buffer(lower,
> >                             btrfs_node_key_ptr_offset(lower, slot + 1),
> > @@ -3011,7 +3014,10 @@ static void insert_ptr(struct btrfs_trans_handle=
 *trans,
> >       if (level) {
> >               ret =3D btrfs_tree_mod_log_insert_key(lower, slot,
> >                                                   BTRFS_MOD_LOG_KEY_ADD=
);
> > -             BUG_ON(ret < 0);
> > +             if (ret < 0) {
> > +                     btrfs_abort_transaction(trans, ret);
> > +                     return ret;
> > +             }
> >       }
> >       btrfs_set_node_key(lower, key, slot);
> >       btrfs_set_node_blockptr(lower, slot, bytenr);
> > @@ -3019,6 +3025,8 @@ static void insert_ptr(struct btrfs_trans_handle =
*trans,
> >       btrfs_set_node_ptr_generation(lower, slot, trans->transid);
> >       btrfs_set_header_nritems(lower, nritems + 1);
> >       btrfs_mark_buffer_dirty(lower);
> > +
> > +     return 0;
> >   }
> >
> >   /*
> > @@ -3098,8 +3106,13 @@ static noinline int split_node(struct btrfs_tran=
s_handle *trans,
> >       btrfs_mark_buffer_dirty(c);
> >       btrfs_mark_buffer_dirty(split);
> >
> > -     insert_ptr(trans, path, &disk_key, split->start,
> > -                path->slots[level + 1] + 1, level + 1);
> > +     ret =3D insert_ptr(trans, path, &disk_key, split->start,
> > +                      path->slots[level + 1] + 1, level + 1);
> > +     if (ret < 0) {
> > +             btrfs_tree_unlock(split);
> > +             free_extent_buffer(split);
> > +             return ret;
> > +     }
> >
> >       if (path->slots[level] >=3D mid) {
> >               path->slots[level] -=3D mid;
> > @@ -3576,16 +3589,17 @@ static int push_leaf_left(struct btrfs_trans_ha=
ndle *trans, struct btrfs_root
> >    * split the path's leaf in two, making sure there is at least data_s=
ize
> >    * available for the resulting leaf level of the path.
> >    */
> > -static noinline void copy_for_split(struct btrfs_trans_handle *trans,
> > -                                 struct btrfs_path *path,
> > -                                 struct extent_buffer *l,
> > -                                 struct extent_buffer *right,
> > -                                 int slot, int mid, int nritems)
> > +static noinline int copy_for_split(struct btrfs_trans_handle *trans,
> > +                                struct btrfs_path *path,
> > +                                struct extent_buffer *l,
> > +                                struct extent_buffer *right,
> > +                                int slot, int mid, int nritems)
> >   {
> >       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> >       int data_copy_size;
> >       int rt_data_off;
> >       int i;
> > +     int ret;
> >       struct btrfs_disk_key disk_key;
> >       struct btrfs_map_token token;
> >
> > @@ -3610,7 +3624,9 @@ static noinline void copy_for_split(struct btrfs_=
trans_handle *trans,
> >
> >       btrfs_set_header_nritems(l, mid);
> >       btrfs_item_key(right, &disk_key, 0);
> > -     insert_ptr(trans, path, &disk_key, right->start, path->slots[1] +=
 1, 1);
> > +     ret =3D insert_ptr(trans, path, &disk_key, right->start, path->sl=
ots[1] + 1, 1);
> > +     if (ret < 0)
> > +             return ret;
> >
> >       btrfs_mark_buffer_dirty(right);
> >       btrfs_mark_buffer_dirty(l);
> > @@ -3628,6 +3644,8 @@ static noinline void copy_for_split(struct btrfs_=
trans_handle *trans,
> >       }
> >
> >       BUG_ON(path->slots[0] < 0);
> > +
> > +     return 0;
> >   }
> >
> >   /*
> > @@ -3826,8 +3844,13 @@ static noinline int split_leaf(struct btrfs_tran=
s_handle *trans,
> >       if (split =3D=3D 0) {
> >               if (mid <=3D slot) {
> >                       btrfs_set_header_nritems(right, 0);
> > -                     insert_ptr(trans, path, &disk_key,
> > -                                right->start, path->slots[1] + 1, 1);
> > +                     ret =3D insert_ptr(trans, path, &disk_key,
> > +                                      right->start, path->slots[1] + 1=
, 1);
> > +                     if (ret < 0) {
> > +                             btrfs_tree_unlock(right);
> > +                             free_extent_buffer(right);
> > +                             return ret;
> > +                     }
> >                       btrfs_tree_unlock(path->nodes[0]);
> >                       free_extent_buffer(path->nodes[0]);
> >                       path->nodes[0] =3D right;
> > @@ -3835,8 +3858,13 @@ static noinline int split_leaf(struct btrfs_tran=
s_handle *trans,
> >                       path->slots[1] +=3D 1;
> >               } else {
> >                       btrfs_set_header_nritems(right, 0);
> > -                     insert_ptr(trans, path, &disk_key,
> > -                                right->start, path->slots[1], 1);
> > +                     ret =3D insert_ptr(trans, path, &disk_key,
> > +                                      right->start, path->slots[1], 1)=
;
> > +                     if (ret < 0) {
> > +                             btrfs_tree_unlock(right);
> > +                             free_extent_buffer(right);
> > +                             return ret;
> > +                     }
> >                       btrfs_tree_unlock(path->nodes[0]);
> >                       free_extent_buffer(path->nodes[0]);
> >                       path->nodes[0] =3D right;
> > @@ -3852,7 +3880,9 @@ static noinline int split_leaf(struct btrfs_trans=
_handle *trans,
> >               return ret;
> >       }
> >
> > -     copy_for_split(trans, path, l, right, slot, mid, nritems);
> > +     ret =3D copy_for_split(trans, path, l, right, slot, mid, nritems)=
;
> > +     if (ret < 0)
> > +             return ret;
>
> Shouldn't we also call btrfs_free_tree_block() for @right for error?
>
> Or because we have already aborted the trans, there is no longer the
> need to add delayed ref for @right?

Yes, we don't need to free tree blocks we allocated in the current
transaction because the transaction abort takes care of doing the
cleanup.

However this is missing the unlock and dropping the ref count.
I'll add that in v2, thanks.

>
> Thanks,
> Qu
> >
> >       if (split =3D=3D 2) {
> >               BUG_ON(num_doubles !=3D 0);
