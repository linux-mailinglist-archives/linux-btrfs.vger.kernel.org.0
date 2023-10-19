Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B9D7CFF57
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjJSQUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjJSQUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 12:20:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C170C114
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 09:20:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F44C433C7
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697732443;
        bh=mY1NfwHuJypFwiooyx93yyQHYqG2yv4BEy2DnXLxW/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bC+eBTr+tJ1bMoG/inlE2Otsw0mejyPcI1dGtrCZzAwRTF0vqcHHHd2HZNwgo2esd
         dB0Zk5kGC8821DkmbxZD7y6VacgdBdirlizibrI6FHGXzfCAGQTiRTGAvKi2xGdVA6
         0esHS8ucCTlnROGlcO+tyITmBbv6kZqafKUWwoQaTw8U5Tq2nknFY4aouV9A28ryz8
         nFHywwRFcok0TNA5S1Hra3ng5NOCCVWWr1O7F7SQy1x5eveJE48g1WzFwi3bJIcTd1
         QPUJzUdZDeXZ3VYDCYXwFeud0fesr4EIfsTQoTuEU/5yh/Sfv5fkdYrYaEDro0cky0
         i4WZ5hTXs6gOw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso942773266b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 09:20:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwOtx3vVOL5+/F5aLUDQwDoO0Il9AEDa23358Uj+zBXXulQYCk9
        pTB6K9BWfdIUUOhNPTu4jS0dyv5iOGVULId7Sc4=
X-Google-Smtp-Source: AGHT+IFCYNE7XUmCFqVwoy6xZzxtwOZ37wasEs3ctfvPN9z+LB/xDlKJzdtQ9kBmicxMpPasYkx7ribQ8mcarSOdqmA=
X-Received: by 2002:a17:907:3c81:b0:9c7:5a01:ffe8 with SMTP id
 gl1-20020a1709073c8100b009c75a01ffe8mr2459893ejc.29.1697732441813; Thu, 19
 Oct 2023 09:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <2bd997ea59e43e8f7db0f8fd8c8f3d85d0ff0c06.1697224683.git.josef@toxicpanda.com>
In-Reply-To: <2bd997ea59e43e8f7db0f8fd8c8f3d85d0ff0c06.1697224683.git.josef@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 19 Oct 2023 17:20:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7hCOr1fwC7y5YismNgGm7aqiv3Ve7j5AhDwY+esaq=3A@mail.gmail.com>
Message-ID: <CAL3q7H7hCOr1fwC7y5YismNgGm7aqiv3Ve7j5AhDwY+esaq=3A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: get correct owning_root when dropping snapshot
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
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

On Fri, Oct 13, 2023 at 8:18=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Dave reported a bug where we were aborting the transaction while trying
> to cleanup the squota reservation for an extent.
>
> This turned out to be because we're doing btrfs_header_owner(next) in
> do_walk_down when we decide to free the block.  However in this code
> block we haven't explicitly read next, so it could be stale.  We would
> then get whatever garbage happened to be in the pages at this point.
>
> Fix this by saving the owner_root when we do the
> btrfs_lookup_extent_info().  We always do this in do_walk_down, it is
> how we make the decision of whether or not to delete the block.  This is
> cheap because we've already done the extent item lookup at this point,
> so it's straightforward to just grab the owner root as well.
>
> Then we can use this when deleting the metadata block without needing to
> force a read of the extent buffer to find the owner.
>
> This fixes the problem that Dave reported.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

So this fixes "btrfs: track owning root in btrfs_ref" (currently
457cb1ddf5e8d895e9c551cad6b84bafae41f32c in misc-next).
Shouldn't that be mentioned somewhere?

Otherwise it looks good to me.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> ---
>  fs/btrfs/ctree.c       |  2 +-
>  fs/btrfs/extent-tree.c | 25 +++++++++++++++++--------
>  fs/btrfs/extent-tree.h |  3 ++-
>  3 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index c0c5f2239820..14cefeaf9622 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -421,7 +421,7 @@ static noinline int update_ref_for_cow(struct btrfs_t=
rans_handle *trans,
>         if (btrfs_block_can_be_shared(root, buf)) {
>                 ret =3D btrfs_lookup_extent_info(trans, fs_info, buf->sta=
rt,
>                                                btrfs_header_level(buf), 1=
,
> -                                              &refs, &flags);
> +                                              &refs, &flags, NULL);
>                 if (ret)
>                         return ret;
>                 if (unlikely(refs =3D=3D 0)) {
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index c8e5b4715b49..0455935ff558 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -102,7 +102,8 @@ int btrfs_lookup_data_extent(struct btrfs_fs_info *fs=
_info, u64 start, u64 len)
>   */
>  int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
>                              struct btrfs_fs_info *fs_info, u64 bytenr,
> -                            u64 offset, int metadata, u64 *refs, u64 *fl=
ags)
> +                            u64 offset, int metadata, u64 *refs, u64 *fl=
ags,
> +                            u64 *owning_root)
>  {
>         struct btrfs_root *extent_root;
>         struct btrfs_delayed_ref_head *head;
> @@ -114,6 +115,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handl=
e *trans,
>         u32 item_size;
>         u64 num_refs;
>         u64 extent_flags;
> +       u64 owner =3D 0;
>         int ret;
>
>         /*
> @@ -167,6 +169,8 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handl=
e *trans,
>                                             struct btrfs_extent_item);
>                         num_refs =3D btrfs_extent_refs(leaf, ei);
>                         extent_flags =3D btrfs_extent_flags(leaf, ei);
> +                       owner =3D btrfs_get_extent_owner_root(fs_info, le=
af,
> +                                                           path->slots[0=
]);
>                 } else {
>                         ret =3D -EUCLEAN;
>                         btrfs_err(fs_info,
> @@ -226,6 +230,8 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handl=
e *trans,
>                 *refs =3D num_refs;
>         if (flags)
>                 *flags =3D extent_flags;
> +       if (owning_root)
> +               *owning_root =3D owner;
>  out_free:
>         btrfs_free_path(path);
>         return ret;
> @@ -5234,7 +5240,7 @@ static noinline void reada_walk_down(struct btrfs_t=
rans_handle *trans,
>                 /* We don't lock the tree block, it's OK to be racy here =
*/
>                 ret =3D btrfs_lookup_extent_info(trans, fs_info, bytenr,
>                                                wc->level - 1, 1, &refs,
> -                                              &flags);
> +                                              &flags, NULL);
>                 /* We don't care about errors in readahead. */
>                 if (ret < 0)
>                         continue;
> @@ -5301,7 +5307,8 @@ static noinline int walk_down_proc(struct btrfs_tra=
ns_handle *trans,
>                 ret =3D btrfs_lookup_extent_info(trans, fs_info,
>                                                eb->start, level, 1,
>                                                &wc->refs[level],
> -                                              &wc->flags[level]);
> +                                              &wc->flags[level],
> +                                              NULL);
>                 BUG_ON(ret =3D=3D -ENOMEM);
>                 if (ret)
>                         return ret;
> @@ -5391,6 +5398,7 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>         u64 bytenr;
>         u64 generation;
>         u64 parent;
> +       u64 owner_root =3D 0;
>         struct btrfs_tree_parent_check check =3D { 0 };
>         struct btrfs_key key;
>         struct btrfs_ref ref =3D { 0 };
> @@ -5434,7 +5442,8 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>
>         ret =3D btrfs_lookup_extent_info(trans, fs_info, bytenr, level - =
1, 1,
>                                        &wc->refs[level - 1],
> -                                      &wc->flags[level - 1]);
> +                                      &wc->flags[level - 1],
> +                                      &owner_root);
>         if (ret < 0)
>                 goto out_unlock;
>
> @@ -5567,8 +5576,7 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>                 find_next_key(path, level, &wc->drop_progress);
>
>                 btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, byte=
nr,
> -                                      fs_info->nodesize, parent,
> -                                      btrfs_header_owner(next));
> +                                      fs_info->nodesize, parent, owner_r=
oot);
>                 btrfs_init_tree_ref(&ref, level - 1, root->root_key.objec=
tid,
>                                     0, false);
>                 ret =3D btrfs_free_extent(trans, &ref);
> @@ -5635,7 +5643,8 @@ static noinline int walk_up_proc(struct btrfs_trans=
_handle *trans,
>                         ret =3D btrfs_lookup_extent_info(trans, fs_info,
>                                                        eb->start, level, =
1,
>                                                        &wc->refs[level],
> -                                                      &wc->flags[level])=
;
> +                                                      &wc->flags[level],
> +                                                      NULL);
>                         if (ret < 0) {
>                                 btrfs_tree_unlock_rw(eb, path->locks[leve=
l]);
>                                 path->locks[level] =3D 0;
> @@ -5880,7 +5889,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, in=
t update_ref, int for_reloc)
>                         ret =3D btrfs_lookup_extent_info(trans, fs_info,
>                                                 path->nodes[level]->start=
,
>                                                 level, 1, &wc->refs[level=
],
> -                                               &wc->flags[level]);
> +                                               &wc->flags[level], NULL);
>                         if (ret < 0) {
>                                 err =3D ret;
>                                 goto out_end_trans;
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index 0716f65d9753..2e066035ccee 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -99,7 +99,8 @@ u64 btrfs_cleanup_ref_head_accounting(struct btrfs_fs_i=
nfo *fs_info,
>  int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u=
64 len);
>  int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
>                              struct btrfs_fs_info *fs_info, u64 bytenr,
> -                            u64 offset, int metadata, u64 *refs, u64 *fl=
ags);
> +                            u64 offset, int metadata, u64 *refs, u64 *fl=
ags,
> +                            u64 *owner_root);
>  int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 n=
um,
>                      int reserved);
>  int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
> --
> 2.41.0
>
