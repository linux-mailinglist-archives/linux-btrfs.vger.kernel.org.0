Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F42A95C5
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgKFLv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:51:27 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C83C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:51:27 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id i17so286693qvp.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=P3/GC4q9SsBjdLKB0qJIULg+e81Ahfxqw4RPWlp4sJ0=;
        b=b6yLgGiMVfoiaVmeSsddX8sFQrn3zmi1V0a3E7g3ESeMmQ9mfyceWguiWBiaQA9Jbf
         MutmC3RLmznTLwc+QToejyYVn61Mylvxw0ngZZ7sbuA2p3OXH0xLmBIxLbUDQ3xNXFx1
         QTYxkAAw6GzTcdkohXvc+ymChW3f6pIC84F5AXH2EN8xtesQrChl1SbGHH/y2EobpSU8
         4CaHflSyjSd4hFZSj05MfpMlpUyr1Vuwm0zGJw95U01qRbzz/oCPlj8QouHWH22VqZGy
         2uhPmGgSjr7zhSyrnuPivpWGDdbv7FNFrlUgFf+3rI+MfSQyRjf1R9vL7miDzmHCNrjp
         crhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=P3/GC4q9SsBjdLKB0qJIULg+e81Ahfxqw4RPWlp4sJ0=;
        b=Ogg4g8/WOXQwdW9wk/VfWzIp3YxJJFgEgfIFiBTGJIirqvcykRx14sbhhfWDdAiYV7
         w7XTuTtN+2zzCbCp/dCz8jKQFpwDEI3bpInwfx3x2uXi0RTl1wmLhza77KlDtW/swGpX
         9Pm9jpZMK/PWyPhLN1mssRC6CDEe7g5BQE3yWiYcmaiN3aX1ZKLRilPVjqapI0bMT+H7
         dTWZqJ4eAqx70JQNbPnm3g+I4XXs040gc6WbKM2xpjRnIaSPetfYogvXI9Ibn1JWCE/u
         wBNXArOENvRrnebC8cJZFkbfhck+NfF6gzoNeuRqlb1w+xjg0IyPoeOIVTsVLJvFGHu4
         vzyw==
X-Gm-Message-State: AOAM530TO+hN1wzCQz36KfQI8tI8CiIwTHlf4o2H4XZjb4IUMvkvpdvx
        dtYpKu4ptUG6lhjz8f7Klo5vAOlAswRb+ZSiyuE=
X-Google-Smtp-Source: ABdhPJzB4gMLcrkPjaehpJJa3OJebV0uh0smo7o/F/mvb/Up6KjvgM2Gr7Jz+q4TxyKDBjPmjELQhW41iIpJOvJDp4g=
X-Received: by 2002:ad4:4381:: with SMTP id s1mr1058608qvr.27.1604663486408;
 Fri, 06 Nov 2020 03:51:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <c064bd10eca6d335160fa3ab838816fbc87de7c1.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <c064bd10eca6d335160fa3ab838816fbc87de7c1.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:51:15 +0000
Message-ID: <CAL3q7H4zxBmBAeFsMKvnCuQbRydMvjyGSYmTEJ-ydppPOkqm=w@mail.gmail.com>
Subject: Re: [PATCH 02/14] btrfs: cleanup extent buffer readahead
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> I'm going to need to start passing around a lot more information when we
> allocate extent buffers, in order to make that cleaner we need to
> cleanup how we do readahead.  Most of the callers have the parent node
> that we're getting our blockptr from, with the sole exception of
> relocation which simply has the bytenr it wants to read.  Add a helper
> that takes the current arguments that we need (bytenr and gen), and add
> another helper for simply reading the slot out of a node.  In followup
> patches the helper that takes all the extra arguments will be expanded,
> and the simpler helper won't need to have it's arguments adjusted.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/ctree.c       | 45 ++++++++--------------------------------
>  fs/btrfs/disk-io.c     | 16 --------------
>  fs/btrfs/disk-io.h     |  1 -
>  fs/btrfs/extent-tree.c |  2 +-
>  fs/btrfs/extent_io.c   | 47 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/extent_io.h   |  3 +++
>  fs/btrfs/relocation.c  |  3 ++-
>  fs/btrfs/volumes.c     |  8 ++-----
>  8 files changed, 64 insertions(+), 61 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index d2d5854d51a7..0ff866328a4f 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2226,7 +2226,7 @@ static void reada_for_search(struct btrfs_fs_info *=
fs_info,
>                 search =3D btrfs_node_blockptr(node, nr);
>                 if ((search <=3D target && target - search <=3D 65536) ||
>                     (search > target && search - target <=3D 65536)) {
> -                       readahead_tree_block(fs_info, search);
> +                       btrfs_readahead_node_child(node, nr);
>                         nread +=3D blocksize;
>                 }
>                 nscan++;
> @@ -2235,16 +2235,11 @@ static void reada_for_search(struct btrfs_fs_info=
 *fs_info,
>         }
>  }
>
> -static noinline void reada_for_balance(struct btrfs_fs_info *fs_info,
> -                                      struct btrfs_path *path, int level=
)
> +static noinline void reada_for_balance(struct btrfs_path *path, int leve=
l)
>  {
> +       struct extent_buffer *parent;
>         int slot;
>         int nritems;
> -       struct extent_buffer *parent;
> -       struct extent_buffer *eb;
> -       u64 gen;
> -       u64 block1 =3D 0;
> -       u64 block2 =3D 0;
>
>         parent =3D path->nodes[level + 1];
>         if (!parent)
> @@ -2253,32 +2248,10 @@ static noinline void reada_for_balance(struct btr=
fs_fs_info *fs_info,
>         nritems =3D btrfs_header_nritems(parent);
>         slot =3D path->slots[level + 1];
>
> -       if (slot > 0) {
> -               block1 =3D btrfs_node_blockptr(parent, slot - 1);
> -               gen =3D btrfs_node_ptr_generation(parent, slot - 1);
> -               eb =3D find_extent_buffer(fs_info, block1);
> -               /*
> -                * if we get -eagain from btrfs_buffer_uptodate, we
> -                * don't want to return eagain here.  That will loop
> -                * forever
> -                */
> -               if (eb && btrfs_buffer_uptodate(eb, gen, 1) !=3D 0)
> -                       block1 =3D 0;
> -               free_extent_buffer(eb);
> -       }
> -       if (slot + 1 < nritems) {
> -               block2 =3D btrfs_node_blockptr(parent, slot + 1);
> -               gen =3D btrfs_node_ptr_generation(parent, slot + 1);
> -               eb =3D find_extent_buffer(fs_info, block2);
> -               if (eb && btrfs_buffer_uptodate(eb, gen, 1) !=3D 0)
> -                       block2 =3D 0;
> -               free_extent_buffer(eb);
> -       }
> -
> -       if (block1)
> -               readahead_tree_block(fs_info, block1);
> -       if (block2)
> -               readahead_tree_block(fs_info, block2);
> +       if (slot > 0)
> +               btrfs_readahead_node_child(parent, slot - 1);
> +       if (slot + 1 < nritems)
> +               btrfs_readahead_node_child(parent, slot + 1);
>  }
>
>
> @@ -2454,7 +2427,7 @@ setup_nodes_for_search(struct btrfs_trans_handle *t=
rans,
>                         goto again;
>                 }
>
> -               reada_for_balance(fs_info, p, level);
> +               reada_for_balance(p, level);
>                 sret =3D split_node(trans, root, p, level);
>
>                 BUG_ON(sret > 0);
> @@ -2473,7 +2446,7 @@ setup_nodes_for_search(struct btrfs_trans_handle *t=
rans,
>                         goto again;
>                 }
>
> -               reada_for_balance(fs_info, p, level);
> +               reada_for_balance(p, level);
>                 sret =3D balance_level(trans, root, p, level);
>
>                 if (sret) {
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 35b16fe3b05f..ec64e087520e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -945,22 +945,6 @@ static const struct address_space_operations btree_a=
ops =3D {
>         .set_page_dirty =3D btree_set_page_dirty,
>  };
>
> -void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr)
> -{
> -       struct extent_buffer *buf =3D NULL;
> -       int ret;
> -
> -       buf =3D btrfs_find_create_tree_block(fs_info, bytenr);
> -       if (IS_ERR(buf))
> -               return;
> -
> -       ret =3D read_extent_buffer_pages(buf, WAIT_NONE, 0);
> -       if (ret < 0)
> -               free_extent_buffer_stale(buf);
> -       else
> -               free_extent_buffer(buf);
> -}
> -
>  struct extent_buffer *btrfs_find_create_tree_block(
>                                                 struct btrfs_fs_info *fs_=
info,
>                                                 u64 bytenr)
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 238b45223f2e..009f505d6c97 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -45,7 +45,6 @@ int btrfs_verify_level_key(struct extent_buffer *eb, in=
t level,
>  struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64=
 bytenr,
>                                       u64 parent_transid, int level,
>                                       struct btrfs_key *first_key);
> -void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr);
>  struct extent_buffer *btrfs_find_create_tree_block(
>                                                 struct btrfs_fs_info *fs_=
info,
>                                                 u64 bytenr);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d7a68203cda0..bf2f0af24e91 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4854,7 +4854,7 @@ static noinline void reada_walk_down(struct btrfs_t=
rans_handle *trans,
>                                 continue;
>                 }
>  reada:
> -               readahead_tree_block(fs_info, bytenr);
> +               btrfs_readahead_node_child(eb, slot);
>                 nread++;
>         }
>         wc->reada_slot =3D slot;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 119ced4a501b..c9d652b0770a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6114,3 +6114,50 @@ int try_release_extent_buffer(struct page *page)
>
>         return release_extent_buffer(eb);
>  }
> +
> +/**
> + * btrfs_readahead_tree_block - attempt to readahead a child block.
> + * @fs_info - the fs_info for the fs.
> + * @bytenr - the bytenr to read.
> + * @gen - the generation for the uptodate check, can be 0.
> + *
> + * Attempt to readahead a tree block at @bytenr.  If @gen is 0 then we d=
o a
> + * normal uptodate check of the eb, without checking the generation.  If=
 we have
> + * to read the block we will not block on anything.
> + */
> +void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
> +                               u64 bytenr, u64 gen)
> +{
> +       struct extent_buffer *eb;
> +       int ret;
> +
> +       eb =3D btrfs_find_create_tree_block(fs_info, bytenr);
> +       if (IS_ERR(eb))
> +               return;
> +
> +       if (btrfs_buffer_uptodate(eb, gen, 1)) {
> +               free_extent_buffer(eb);
> +               return;
> +       }
> +
> +       ret =3D read_extent_buffer_pages(eb, WAIT_NONE, 0);
> +       if (ret < 0)
> +               free_extent_buffer_stale(eb);
> +       else
> +               free_extent_buffer(eb);
> +}
> +
> +/**
> + * btrfs_readahead_node_child - readahead a node's child block.
> + * @node - the parent node we're reading from.
> + * @slot - the slot in the parent node for the child we want to read.
> + *
> + * A helper for btrfs_readahead_tree_block, we simply read the bytenr po=
inted at
> + * the slot in the node provided.
> + */
> +void btrfs_readahead_node_child(struct extent_buffer *node, int slot)
> +{
> +       btrfs_readahead_tree_block(node->fs_info,
> +                                  btrfs_node_blockptr(node, slot),
> +                                  btrfs_node_ptr_generation(node, slot))=
;
> +}
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 3c2bf21c54eb..a211e90292f8 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -198,6 +198,9 @@ void free_extent_buffer_stale(struct extent_buffer *e=
b);
>  int read_extent_buffer_pages(struct extent_buffer *eb, int wait,
>                              int mirror_num);
>  void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
> +void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
> +                               u64 bytenr, u64 gen);
> +void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
>
>  static inline int num_extent_pages(const struct extent_buffer *eb)
>  {
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 0b3ccf464c3d..0e2dd7cf87f6 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2542,7 +2542,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle =
*trans,
>         /* Kick in readahead for tree blocks with missing keys */
>         rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node=
) {
>                 if (!block->key_ready)
> -                       readahead_tree_block(fs_info, block->bytenr);
> +                       btrfs_readahead_tree_block(fs_info,
> +                                                  block->bytenr, 0);
>         }
>
>         /* Get first keys */
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c927dc597550..8beb91d3cd88 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7065,12 +7065,8 @@ static void readahead_tree_node_children(struct ex=
tent_buffer *node)
>         int i;
>         const int nr_items =3D btrfs_header_nritems(node);
>
> -       for (i =3D 0; i < nr_items; i++) {
> -               u64 start;
> -
> -               start =3D btrfs_node_blockptr(node, i);
> -               readahead_tree_block(node->fs_info, start);
> -       }
> +       for (i =3D 0; i < nr_items; i++)
> +               btrfs_readahead_node_child(node, i);
>  }
>
>  int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
