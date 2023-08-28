Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC778A853
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjH1IzB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 04:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjH1Iy2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 04:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03410E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 01:54:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 958256345E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02435C433C8
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693212860;
        bh=CWLF8uxbFBOUbDq30cXtnvt04NzQE2M83OHjy+7b/BQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VxStZBsBjf7My64Oxhd9OCSMaSl7w/UQ2TEMVWhP4NraLAJ+OJan6yWHJDFqheB3z
         YzgvO2YLhXFj0P96CUeBdxCdX1KO39Kgq3PgBGarwHUEmGV/mhpx0qwHc1rpbaxqO7
         BngKVwk7mY6plgWQrTpUtZQz8l9vP7g9KnF4olzs9a0okTiiwBFE+P/CzNpf56x6Bs
         n0BYoqJfwIeJCczHzPNiW7I1Kk8kRRx8Ps5E3GO3QWF8TwT4PWWExxIjms+Ro0+FmA
         vEIl8XDYL+ANbIgyaTeWqCIsMUjyk9ENXsSM+Mzv/0OMq1joGNArqbWtz+UpTIm9Un
         pQlDcGmsqj2hw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1c8e9d75ce1so1650580fac.3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 01:54:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw85oYfIKl6FjOs1XhG9ZkI1OC2qQU2rfmfuYCA4R61R1aPJd/y
        Tof6q6o9oJAGuHQ4Vz30775htCwJBQpiUftWqIQ=
X-Google-Smtp-Source: AGHT+IG3RGiMLW9eQwIu+RGCaedzFOBiJXN+h49hFWYpiyzVKNUWguBDp2OtaadV7/PaIH0odlrRglrCpnzE12pIFH0=
X-Received: by 2002:a05:6870:2108:b0:1b7:3f07:e431 with SMTP id
 f8-20020a056870210800b001b73f07e431mr10052063oae.54.1693212859066; Mon, 28
 Aug 2023 01:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693209858.git.fdmanana@suse.com> <ee7caf888c95075685cd068d6e78f96be283b4b5.1693209858.git.fdmanana@suse.com>
 <74ce2e98-97ed-4f3a-9929-ec5b92fb5dcc@gmx.com>
In-Reply-To: <74ce2e98-97ed-4f3a-9929-ec5b92fb5dcc@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 28 Aug 2023 09:53:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7pzOOzMaG2g0k+9bv_CYWDwWS2m9p3DnnqLrAN3+0yOg@mail.gmail.com>
Message-ID: <CAL3q7H7pzOOzMaG2g0k+9bv_CYWDwWS2m9p3DnnqLrAN3+0yOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] btrfs: remove BUG() after failure to insert
 delayed dir index item
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

On Mon, Aug 28, 2023 at 9:42=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/8/28 16:06, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Instead of calling BUG() when we fail to insert a delayed dir index ite=
m
> > into the delayed node's tree, we can just release all the resources we
> > have allocated/acquired before and return the error to the caller. This=
 is
> > fine because all existing call chains undo anything they have done befo=
re
> > calling btrfs_insert_delayed_dir_index() or BUG_ON (when creating pendi=
ng
> > snapshots in the transaction commit path).
> >
> > So remove the BUG() call and do proper error handling.
> >
> > This relates to a syzbot report linked below, but does not fix it becau=
se
> > it only prevents hitting a BUG(), it does not fix the issue where someh=
ow
> > we attempt to use twice the same index number for different index items=
.
> >
> > Link: https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@=
google.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/delayed-inode.c | 74 +++++++++++++++++++++++++--------------=
-
> >   1 file changed, 47 insertions(+), 27 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index f9dae729811b..eb175ae52245 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -1413,7 +1413,29 @@ void btrfs_balance_delayed_items(struct btrfs_fs=
_info *fs_info)
> >       btrfs_wq_run_delayed_node(delayed_root, fs_info, BTRFS_DELAYED_BA=
TCH);
> >   }
> >
> > -/* Will return 0 or -ENOMEM */
> > +static void btrfs_release_dir_index_item_space(struct btrfs_trans_hand=
le *trans)
> > +{
> > +     struct btrfs_fs_info *fs_info =3D trans->fs_info;
> > +     const u64 bytes =3D btrfs_calc_insert_metadata_size(fs_info, 1);
> > +
> > +     if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
> > +             return;
> > +
> > +     /*
> > +      * Adding the new dir index item does not require touching anothe=
r
> > +      * leaf, so we can release 1 unit of metadata that was previously
> > +      * reserved when starting the transaction. This applies only to
> > +      * the case where we had a transaction start and excludes the
> > +      * transaction join case (when replaying log trees).
> > +      */
> > +     trace_btrfs_space_reservation(fs_info, "transaction",
> > +                                   trans->transid, bytes, 0);
>
> I know this is from the old code, but shouldn't we use "-bytes" instead?

Nop.
The last argument, a value of 0, indicates that it's a space release.
Allocations get a value of 1 for that last argument.


>
> Otherwise looks fine to me.
>
> Thanks,
> Qu
>
> > +     btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
> > +     ASSERT(trans->bytes_reserved >=3D bytes);
> > +     trans->bytes_reserved -=3D bytes;
> > +}
> > +
> > +/* Will return 0, -ENOMEM or -EEXIST (index number collision, unexpect=
ed). */
> >   int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
> >                                  const char *name, int name_len,
> >                                  struct btrfs_inode *dir,
> > @@ -1455,6 +1477,27 @@ int btrfs_insert_delayed_dir_index(struct btrfs_=
trans_handle *trans,
> >
> >       mutex_lock(&delayed_node->mutex);
> >
> > +     /*
> > +      * First attempt to insert the delayed item. This is to make the =
error
> > +      * handling path simpler in case we fail (-EEXIST). There's no ri=
sk of
> > +      * any other task coming in and running the delayed item before w=
e do
> > +      * the metadata space reservation below, because we are holding t=
he
> > +      * delayed node's mutex and that mutex must also be locked before=
 the
> > +      * node's delayed items can be run.
> > +      */
> > +     ret =3D __btrfs_add_delayed_item(delayed_node, delayed_item);
> > +     if (unlikely(ret)) {
> > +             btrfs_err(trans->fs_info,
> > +"error adding delayed dir index item, name: %.*s, index: %llu, root: %=
llu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error:=
 %d",
> > +                       name_len, name, index, btrfs_root_id(delayed_no=
de->root),
> > +                       delayed_node->inode_id, dir->index_cnt,
> > +                       delayed_node->index_cnt, ret);
> > +             btrfs_release_delayed_item(delayed_item);
> > +             btrfs_release_dir_index_item_space(trans); > +          m=
utex_unlock(&delayed_node->mutex);
> > +             goto release_node;
> > +     }
> > +
> >       if (delayed_node->index_item_leaves =3D=3D 0 ||
> >           delayed_node->curr_index_batch_size + data_len > leaf_data_si=
ze) {
> >               delayed_node->curr_index_batch_size =3D data_len;
> > @@ -1472,37 +1515,14 @@ int btrfs_insert_delayed_dir_index(struct btrfs=
_trans_handle *trans,
> >                * impossible.
> >                */
> >               if (WARN_ON(ret)) {
> > -                     mutex_unlock(&delayed_node->mutex);
> >                       btrfs_release_delayed_item(delayed_item);
> > +                     mutex_unlock(&delayed_node->mutex);
> >                       goto release_node;
> >               }
> >
> >               delayed_node->index_item_leaves++;
> > -     } else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
> > -             const u64 bytes =3D btrfs_calc_insert_metadata_size(fs_in=
fo, 1);
> > -
> > -             /*
> > -              * Adding the new dir index item does not require touchin=
g another
> > -              * leaf, so we can release 1 unit of metadata that was pr=
eviously
> > -              * reserved when starting the transaction. This applies o=
nly to
> > -              * the case where we had a transaction start and excludes=
 the
> > -              * transaction join case (when replaying log trees).
> > -              */
> > -             trace_btrfs_space_reservation(fs_info, "transaction",
> > -                                           trans->transid, bytes, 0);
> > -             btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes,=
 NULL);
> > -             ASSERT(trans->bytes_reserved >=3D bytes);
> > -             trans->bytes_reserved -=3D bytes;
> > -     }
> > -
> > -     ret =3D __btrfs_add_delayed_item(delayed_node, delayed_item);
> > -     if (unlikely(ret)) {
> > -             btrfs_err(trans->fs_info,
> > -"error adding delayed dir index item, name: %.*s, index: %llu, root: %=
llu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error:=
 %d",
> > -                       name_len, name, index, btrfs_root_id(delayed_no=
de->root),
> > -                       delayed_node->inode_id, dir->index_cnt,
> > -                       delayed_node->index_cnt, ret);
> > -             BUG();
> > +     } else {
> > +             btrfs_release_dir_index_item_space(trans);
> >       }
> >       mutex_unlock(&delayed_node->mutex);
> >
