Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876D02A95DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgKFLzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgKFLzn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:55:43 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E68C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:55:43 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y197so749585qkb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pTKhRdyAFkJAR32FhbwKm5E85eBsk4rD138HN2RdUuc=;
        b=s8wpm5U/ngh8hGmq0tRvbfeqM0HesLkgiaw3KuCA9vXFTMb0zL0ZnLyCaz3FZDK7vx
         Pg4+QuaQ2HhqXlhPiZ7qjBMCjf0JzJmCCBqsdpSz2fQ/VDav5iM9yCDpQV+pckoh1d8k
         u6eER6Q0Xy9RdryOoylmMVW4Nrwmy6vsf6mmiNi5cUlJVsSzRMYS3jFdQeRg3nbYB7w3
         3Ba8AezAieLWBNyA+j0XUqCA7p2+8Lxb/sxDlzlBU5lJKpEtseA5a6u23wO1lIl9VL58
         mUh9OdhaX9gC5XLUsl+peuaISIKk3mjtrlt1i9Xx1xyHByHNnXwWWFSV8IkK926sPJ0p
         vlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pTKhRdyAFkJAR32FhbwKm5E85eBsk4rD138HN2RdUuc=;
        b=U32Vx77ARQVGXya3SYskyb5oKVx5ME5iMbleY5E6pbp8/pFssXlUYu1eCiiCB0PrWb
         yqLw3uzYbXEoPE6uTJkysGhb2wcrVK0dyIKJBrmVAh7VVE2YXdRCnOeRvfA6sJQiY2Gh
         ryPqGEnh3fxHn869jnOusEz0MpbB0w/wVEYgw7DFpLRyq5D3DFjMio4KjagClifykb5F
         DfdUkZU+DCvluYS80ZlgsQ9askwb2qryERy7YKzcYhyDk1pIG/a1X0qOsYHTbjJlLz1P
         uZXbGvOvpK2V1UPWo9EuYXDzTYKOfTPNj5uMzynLXFcXKMCfk+f/wFrfEmN5xh5rfQEv
         9V+g==
X-Gm-Message-State: AOAM531vE6KXOnbvJvrA+4wjlqWRbB5rdrEL71NSctetkvnxIHcE/yPh
        TAu4Rqx4+oEowGqpo9QiF/djKNkWovHlUIZoW1s=
X-Google-Smtp-Source: ABdhPJwHzkC1lhIWcUWLfuU0M/IUfrIJX6+UIdnt9I25xZTTNL8CU6QXcxgPTIAZsY/W5uLpf5IPqIAjtPgqQPtiOm8=
X-Received: by 2002:a37:7c81:: with SMTP id x123mr976643qkc.383.1604663742472;
 Fri, 06 Nov 2020 03:55:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <9060bfcc7ea0806cb05ff8e7e8d7adb17d7b6e53.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <9060bfcc7ea0806cb05ff8e7e8d7adb17d7b6e53.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:55:31 +0000
Message-ID: <CAL3q7H54rcjb-AumXTsfy9jHFwk12RGJxr2_GRHh-h3UBx8XQw@mail.gmail.com>
Subject: Re: [PATCH 11/14] btrfs: pass root owner to read_tree_block
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:49 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> In order to properly set the lockdep class of a newly allocated block we
> need to know the owner of the block.  For non refcount'ed tree's this is
> straightforward, we always know in advance what tree we're reading from.
> For refcount'ed trees we don't necessarily know, however all refcount'ed
> trees share the same lockdep class name, tree-<level>.
>
> Fix all of the callers of read_tree_block() to pass in the root objectid
> we're using.  In places like relocation and backref we could probably
> unconditionally use 0, but just in case use the root when we have it,
> otherwise use 0 in the cases we don't have the root as it's going to be
> a refcount'ed tree anyway.
>
> This is a preparation patch for further changes.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/backref.c     |  6 +++---
>  fs/btrfs/ctree.c       |  8 +++++---
>  fs/btrfs/disk-io.c     | 14 +++++++++-----
>  fs/btrfs/disk-io.h     |  4 ++--
>  fs/btrfs/extent-tree.c |  4 ++--
>  fs/btrfs/print-tree.c  |  1 +
>  fs/btrfs/qgroup.c      |  2 +-
>  fs/btrfs/relocation.c  |  4 ++--
>  8 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 86abe34e9444..02d7d7b2563b 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -783,8 +783,8 @@ static int add_missing_keys(struct btrfs_fs_info *fs_=
info,
>                 BUG_ON(ref->key_for_search.type);
>                 BUG_ON(!ref->wanted_disk_byte);
>
> -               eb =3D read_tree_block(fs_info, ref->wanted_disk_byte, 0,
> -                                    ref->level - 1, NULL);
> +               eb =3D read_tree_block(fs_info, ref->wanted_disk_byte,
> +                                    ref->root_id, 0, ref->level - 1, NUL=
L);
>                 if (IS_ERR(eb)) {
>                         free_pref(ref);
>                         return PTR_ERR(eb);
> @@ -1331,7 +1331,7 @@ static int find_parent_nodes(struct btrfs_trans_han=
dle *trans,
>                                 struct extent_buffer *eb;
>
>                                 eb =3D read_tree_block(fs_info, ref->pare=
nt, 0,
> -                                                    ref->level, NULL);
> +                                                    0, ref->level, NULL)=
;
>                                 if (IS_ERR(eb)) {
>                                         ret =3D PTR_ERR(eb);
>                                         goto out;
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 5ec778e01222..35e5acbcc570 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1353,7 +1353,8 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
>         if (old_root && tm && tm->op !=3D MOD_LOG_KEY_REMOVE_WHILE_FREEIN=
G) {
>                 btrfs_tree_read_unlock(eb_root);
>                 free_extent_buffer(eb_root);
> -               old =3D read_tree_block(fs_info, logical, 0, level, NULL)=
;
> +               old =3D read_tree_block(fs_info, logical,
> +                                     root->root_key.objectid, 0, level, =
NULL);
>                 if (WARN_ON(IS_ERR(old) || !extent_buffer_uptodate(old)))=
 {
>                         if (!IS_ERR(old))
>                                 free_extent_buffer(old);
> @@ -1763,6 +1764,7 @@ struct extent_buffer *btrfs_read_node_slot(struct e=
xtent_buffer *parent,
>
>         btrfs_node_key_to_cpu(parent, &first_key, slot);
>         eb =3D read_tree_block(parent->fs_info, btrfs_node_blockptr(paren=
t, slot),
> +                            btrfs_header_owner(parent),
>                              btrfs_node_ptr_generation(parent, slot),
>                              level - 1, &first_key);
>         if (!IS_ERR(eb) && !extent_buffer_uptodate(eb)) {
> @@ -2352,8 +2354,8 @@ read_block_for_search(struct btrfs_root *root, stru=
ct btrfs_path *p,
>                 reada_for_search(fs_info, p, level, slot, key->objectid);
>
>         ret =3D -EAGAIN;
> -       tmp =3D read_tree_block(fs_info, blocknr, gen, parent_level - 1,
> -                             &first_key);
> +       tmp =3D read_tree_block(fs_info, blocknr, root->root_key.objectid=
,
> +                             gen, parent_level - 1, &first_key);
>         if (!IS_ERR(tmp)) {
>                 /*
>                  * If the read above didn't mark this buffer up to date,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index ec64e087520e..934723785ab8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -958,13 +958,14 @@ struct extent_buffer *btrfs_find_create_tree_block(
>   * Read tree block at logical address @bytenr and do variant basic but c=
ritical
>   * verification.
>   *
> + * @owner_root:                the objectid of the root owner for this b=
lock.
>   * @parent_transid:    expected transid of this tree block, skip check i=
f 0
>   * @level:             expected level, mandatory check
>   * @first_key:         expected key in slot 0, skip check if NULL
>   */
>  struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64=
 bytenr,
> -                                     u64 parent_transid, int level,
> -                                     struct btrfs_key *first_key)
> +                                     u64 owner_root, u64 parent_transid,
> +                                     int level, struct btrfs_key *first_=
key)
>  {
>         struct extent_buffer *buf =3D NULL;
>         int ret;
> @@ -1287,7 +1288,7 @@ static struct btrfs_root *read_tree_root_path(struc=
t btrfs_root *tree_root,
>         level =3D btrfs_root_level(&root->root_item);
>         root->node =3D read_tree_block(fs_info,
>                                      btrfs_root_bytenr(&root->root_item),
> -                                    generation, level, NULL);
> +                                    key->objectid, generation, level, NU=
LL);
>         if (IS_ERR(root->node)) {
>                 ret =3D PTR_ERR(root->node);
>                 root->node =3D NULL;
> @@ -2241,8 +2242,9 @@ static int btrfs_replay_log(struct btrfs_fs_info *f=
s_info,
>                 return -ENOMEM;
>
>         log_tree_root->node =3D read_tree_block(fs_info, bytenr,
> -                                             fs_info->generation + 1,
> -                                             level, NULL);
> +                                             BTRFS_TREE_LOG_OBJECTID,
> +                                             fs_info->generation + 1, le=
vel,
> +                                             NULL);
>         if (IS_ERR(log_tree_root->node)) {
>                 btrfs_warn(fs_info, "failed to read log tree");
>                 ret =3D PTR_ERR(log_tree_root->node);
> @@ -2628,6 +2630,7 @@ static int __cold init_tree_roots(struct btrfs_fs_i=
nfo *fs_info)
>                 generation =3D btrfs_super_generation(sb);
>                 level =3D btrfs_super_root_level(sb);
>                 tree_root->node =3D read_tree_block(fs_info, btrfs_super_=
root(sb),
> +                                                 BTRFS_ROOT_TREE_OBJECTI=
D,
>                                                   generation, level, NULL=
);
>                 if (IS_ERR(tree_root->node)) {
>                         handle_error =3D true;
> @@ -3116,6 +3119,7 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>
>         chunk_root->node =3D read_tree_block(fs_info,
>                                            btrfs_super_chunk_root(disk_su=
per),
> +                                          BTRFS_CHUNK_TREE_OBJECTID,
>                                            generation, level, NULL);
>         if (IS_ERR(chunk_root->node) ||
>             !extent_buffer_uptodate(chunk_root->node)) {
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 009f505d6c97..41588babf2ed 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -43,8 +43,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
>  int btrfs_verify_level_key(struct extent_buffer *eb, int level,
>                            struct btrfs_key *first_key, u64 parent_transi=
d);
>  struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64=
 bytenr,
> -                                     u64 parent_transid, int level,
> -                                     struct btrfs_key *first_key);
> +                                     u64 owner_root, u64 parent_transid,
> +                                     int level, struct btrfs_key *first_=
key);
>  struct extent_buffer *btrfs_find_create_tree_block(
>                                                 struct btrfs_fs_info *fs_=
info,
>                                                 u64 bytenr);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index bf2f0af24e91..fe829bb528b5 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5072,8 +5072,8 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>         if (!next) {
>                 if (reada && level =3D=3D 1)
>                         reada_walk_down(trans, root, wc, path);
> -               next =3D read_tree_block(fs_info, bytenr, generation, lev=
el - 1,
> -                                      &first_key);
> +               next =3D read_tree_block(fs_info, bytenr, root->root_key.=
objectid,
> +                                      generation, level - 1, &first_key)=
;
>                 if (IS_ERR(next)) {
>                         return PTR_ERR(next);
>                 } else if (!extent_buffer_uptodate(next)) {
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 8db99117531d..fe5e0026129d 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -390,6 +390,7 @@ void btrfs_print_tree(struct extent_buffer *c, bool f=
ollow)
>
>                 btrfs_node_key_to_cpu(c, &first_key, i);
>                 next =3D read_tree_block(fs_info, btrfs_node_blockptr(c, =
i),
> +                                      btrfs_header_owner(c),
>                                        btrfs_node_ptr_generation(c, i),
>                                        level - 1, &first_key);
>                 if (IS_ERR(next)) {
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 25e3b7105e8a..8a78783213f9 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4140,7 +4140,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btr=
fs_trans_handle *trans,
>         spin_unlock(&blocks->lock);
>
>         /* Read out reloc subtree root */
> -       reloc_eb =3D read_tree_block(fs_info, block->reloc_bytenr,
> +       reloc_eb =3D read_tree_block(fs_info, block->reloc_bytenr, 0,
>                                    block->reloc_generation, block->level,
>                                    &block->first_key);
>         if (IS_ERR(reloc_eb)) {
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 465f5b4d3233..3e792bf31ecd 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2413,7 +2413,7 @@ static int get_tree_block_key(struct btrfs_fs_info =
*fs_info,
>  {
>         struct extent_buffer *eb;
>
> -       eb =3D read_tree_block(fs_info, block->bytenr, block->key.offset,
> +       eb =3D read_tree_block(fs_info, block->bytenr, 0, block->key.offs=
et,
>                              block->level, NULL);
>         if (IS_ERR(eb)) {
>                 return PTR_ERR(eb);
> @@ -3039,7 +3039,7 @@ int add_data_references(struct reloc_control *rc,
>         while ((ref_node =3D ulist_next(leaves, &leaf_uiter))) {
>                 struct extent_buffer *eb;
>
> -               eb =3D read_tree_block(fs_info, ref_node->val, 0, 0, NULL=
);
> +               eb =3D read_tree_block(fs_info, ref_node->val, 0, 0, 0, N=
ULL);
>                 if (IS_ERR(eb)) {
>                         ret =3D PTR_ERR(eb);
>                         break;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
