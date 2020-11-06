Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2822A95D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKFLya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:54:29 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EF8C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:54:29 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id h12so513096qtc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8uxLazjVWKra0iYp88EpthR1UDDz9oVzYEAnshSiNXU=;
        b=PLmcVJeqiEJKLqxW25y7wpUr8+hR+EHz5pSVfqIhn+4/h+90UcyDBDP1C5SGKSlOSL
         VttM74zcjE0wBoTxrcYUQDoak3K5Q5cof2h9VzvXnpsst7E90ta179U8JoQhR2SIYhAf
         I0iRwTaivcvUyr6lQAoXSlAGnLnRLt+8DDlr4LT+L2g3J8Hq9nQwGeAFdP8NBaE2rijm
         zKVoLB8wvJ/faqxPSV39zr20PzsTPGukexgS7RiH8IesPQVNEmigu8StS8kTRFwE4QcP
         y3ggR9ioNdV+H0x5oGucIJ4KbvLisutR3GxpCpc6fzhBsm3Uh66qL5vRbDogyQUmgOMS
         z4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8uxLazjVWKra0iYp88EpthR1UDDz9oVzYEAnshSiNXU=;
        b=RtGSAyBxvBgG4mAXa1ZzC7S8/ZaX+eTtmPcU/918K1jezwkSAclV0ujBieMrc2YXiR
         Dub85zaWn8dUtkxEVugZewJn+yYQaj1ES4+j/wQr19xRfEVMOz0kBxr/7iqQ5ZvO65KM
         lAbFao8vKU+0WXA1vRmXsJyrMH+yUOkz3KvjGIrxzvFCmc9cbPrrnvW3as9fzJCoqoYb
         FnmR5Ltevrwb1rzfnYWlwk0OzRxhwHoSKpB2rbdSf4kLctHfnCX6fWlxg2eqhhUd3cl4
         cnh3hapoYaDwM4DGDL7mgiPpWL2B1NBb9vw1aO+knSeuVzPja+JNejMLQT47X2debfS3
         6KYg==
X-Gm-Message-State: AOAM5308YidvUSNRK/+9wKcMjllYxWQGEojBIvlZIsvAbjKScxJsB/4s
        34/AcnfNMZ7y+7sYtQJiGXNaeOzmWkgWT7O7Qgo=
X-Google-Smtp-Source: ABdhPJwOPzzHxKSQ48jRYOmzvwJqczj9lhkgIjTf5mTY/zunYB8tGi/tll5IOA0E219swf+xASu33rwrUC4RlZIcwGw=
X-Received: by 2002:aed:30e2:: with SMTP id 89mr1086025qtf.259.1604663669018;
 Fri, 06 Nov 2020 03:54:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <6eb34e2f39e9c17cee9e2be74c86607a1e69f39b.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <6eb34e2f39e9c17cee9e2be74c86607a1e69f39b.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:54:18 +0000
Message-ID: <CAL3q7H5Ek-p9z0reYiuo63=Gc8fdfVjxDZRmybRw0jZ2j12czQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] btrfs: pass the owner_root and level to alloc_extent_buffer
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Now that we've plumbed all of the callers to have the owner root and the
> level, plumb it down into alloc_extent_buffer().
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/disk-io.c     |  7 ++++---
>  fs/btrfs/disk-io.h     |  3 ++-
>  fs/btrfs/extent-tree.c |  6 ++++--
>  fs/btrfs/extent_io.c   | 13 +++++++++----
>  fs/btrfs/extent_io.h   |  5 +++--
>  fs/btrfs/reada.c       |  8 +++++---
>  fs/btrfs/relocation.c  |  3 ++-
>  fs/btrfs/tree-log.c    |  4 +++-
>  fs/btrfs/volumes.c     |  3 ++-
>  9 files changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 934723785ab8..f14398b5d933 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -947,11 +947,12 @@ static const struct address_space_operations btree_=
aops =3D {
>
>  struct extent_buffer *btrfs_find_create_tree_block(
>                                                 struct btrfs_fs_info *fs_=
info,
> -                                               u64 bytenr)
> +                                               u64 bytenr, u64 owner_roo=
t,
> +                                               int level)
>  {
>         if (btrfs_is_testing(fs_info))
>                 return alloc_test_extent_buffer(fs_info, bytenr);
> -       return alloc_extent_buffer(fs_info, bytenr);
> +       return alloc_extent_buffer(fs_info, bytenr, owner_root, level);
>  }
>
>  /*
> @@ -970,7 +971,7 @@ struct extent_buffer *read_tree_block(struct btrfs_fs=
_info *fs_info, u64 bytenr,
>         struct extent_buffer *buf =3D NULL;
>         int ret;
>
> -       buf =3D btrfs_find_create_tree_block(fs_info, bytenr);
> +       buf =3D btrfs_find_create_tree_block(fs_info, bytenr, owner_root,=
 level);
>         if (IS_ERR(buf))
>                 return buf;
>
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 41588babf2ed..e75ea6092942 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -47,7 +47,8 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_i=
nfo *fs_info, u64 bytenr,
>                                       int level, struct btrfs_key *first_=
key);
>  struct extent_buffer *btrfs_find_create_tree_block(
>                                                 struct btrfs_fs_info *fs_=
info,
> -                                               u64 bytenr);
> +                                               u64 bytenr, u64 owner_roo=
t,
> +                                               int level);
>  void btrfs_clean_tree_block(struct extent_buffer *buf);
>  int __cold open_ctree(struct super_block *sb,
>                struct btrfs_fs_devices *fs_devices,
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index fe829bb528b5..14b6e19f6151 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4612,7 +4612,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct extent_buffer *buf;
>
> -       buf =3D btrfs_find_create_tree_block(fs_info, bytenr);
> +       buf =3D btrfs_find_create_tree_block(fs_info, bytenr, owner, leve=
l);
>         if (IS_ERR(buf))
>                 return buf;
>
> @@ -5013,7 +5013,9 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>
>         next =3D find_extent_buffer(fs_info, bytenr);
>         if (!next) {
> -               next =3D btrfs_find_create_tree_block(fs_info, bytenr);
> +               next =3D btrfs_find_create_tree_block(fs_info, bytenr,
> +                                                   root->root_key.object=
id,
> +                                                   level - 1);
>                 if (IS_ERR(next))
>                         return PTR_ERR(next);
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c9d652b0770a..a883350d5e7f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5171,7 +5171,7 @@ struct extent_buffer *alloc_test_extent_buffer(stru=
ct btrfs_fs_info *fs_info,
>  #endif
>
>  struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> -                                         u64 start)
> +                                         u64 start, u64 owner_root, int =
level)
>  {
>         unsigned long len =3D fs_info->nodesize;
>         int num_pages;
> @@ -6119,19 +6119,22 @@ int try_release_extent_buffer(struct page *page)
>   * btrfs_readahead_tree_block - attempt to readahead a child block.
>   * @fs_info - the fs_info for the fs.
>   * @bytenr - the bytenr to read.
> + * @owner_root - the objectid of the root that owns this eb.
>   * @gen - the generation for the uptodate check, can be 0.
> + * @level - the level for the eb.
>   *
>   * Attempt to readahead a tree block at @bytenr.  If @gen is 0 then we d=
o a
>   * normal uptodate check of the eb, without checking the generation.  If=
 we have
>   * to read the block we will not block on anything.
>   */
>  void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
> -                               u64 bytenr, u64 gen)
> +                               u64 bytenr, u64 owner_root, u64 gen,
> +                               int level)
>  {
>         struct extent_buffer *eb;
>         int ret;
>
> -       eb =3D btrfs_find_create_tree_block(fs_info, bytenr);
> +       eb =3D btrfs_find_create_tree_block(fs_info, bytenr, owner_root, =
level);
>         if (IS_ERR(eb))
>                 return;
>
> @@ -6159,5 +6162,7 @@ void btrfs_readahead_node_child(struct extent_buffe=
r *node, int slot)
>  {
>         btrfs_readahead_tree_block(node->fs_info,
>                                    btrfs_node_blockptr(node, slot),
> -                                  btrfs_node_ptr_generation(node, slot))=
;
> +                                  btrfs_header_owner(node),
> +                                  btrfs_node_ptr_generation(node, slot),
> +                                  btrfs_header_level(node) - 1);
>  }
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index a211e90292f8..578c2e56c5e4 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -182,7 +182,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct f=
iemap_extent_info *fieinfo,
>  void set_page_extent_mapped(struct page *page);
>
>  struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> -                                         u64 start);
> +                                         u64 start, u64 owner_root, int =
level);
>  struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *=
fs_info,
>                                                   u64 start, unsigned lon=
g len);
>  struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs=
_info,
> @@ -199,7 +199,8 @@ int read_extent_buffer_pages(struct extent_buffer *eb=
, int wait,
>                              int mirror_num);
>  void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
>  void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
> -                               u64 bytenr, u64 gen);
> +                               u64 bytenr, u64 owner_root, u64 gen,
> +                               int level);
>  void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
>
>  static inline int num_extent_pages(const struct extent_buffer *eb)
> diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
> index 83f4e6c53e46..8f26b3b22308 100644
> --- a/fs/btrfs/reada.c
> +++ b/fs/btrfs/reada.c
> @@ -656,12 +656,13 @@ static int reada_pick_zone(struct btrfs_device *dev=
)
>  }
>
>  static int reada_tree_block_flagged(struct btrfs_fs_info *fs_info, u64 b=
ytenr,
> -                                   int mirror_num, struct extent_buffer =
**eb)
> +                                   u64 owner_root, int level, int mirror=
_num,
> +                                   struct extent_buffer **eb)
>  {
>         struct extent_buffer *buf =3D NULL;
>         int ret;
>
> -       buf =3D btrfs_find_create_tree_block(fs_info, bytenr);
> +       buf =3D btrfs_find_create_tree_block(fs_info, bytenr, owner_root,=
 level);
>         if (IS_ERR(buf))
>                 return 0;
>
> @@ -749,7 +750,8 @@ static int reada_start_machine_dev(struct btrfs_devic=
e *dev)
>         logical =3D re->logical;
>
>         atomic_inc(&dev->reada_in_flight);
> -       ret =3D reada_tree_block_flagged(fs_info, logical, mirror_num, &e=
b);
> +       ret =3D reada_tree_block_flagged(fs_info, logical, re->owner_root=
,
> +                                      re->level, mirror_num, &eb);
>         if (ret)
>                 __readahead_hook(fs_info, re, NULL, ret);
>         else if (eb)
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 3e792bf31ecd..4551650a270d 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2514,7 +2514,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle =
*trans,
>         rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node=
) {
>                 if (!block->key_ready)
>                         btrfs_readahead_tree_block(fs_info,
> -                                                  block->bytenr, 0);
> +                                                  block->bytenr, 0, 0,
> +                                                  block->level);
>         }
>
>         /* Get first keys */
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index eb86c632535a..b1f97be57bb3 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2699,7 +2699,9 @@ static noinline int walk_down_log_tree(struct btrfs=
_trans_handle *trans,
>                 btrfs_node_key_to_cpu(cur, &first_key, path->slots[*level=
]);
>                 blocksize =3D fs_info->nodesize;
>
> -               next =3D btrfs_find_create_tree_block(fs_info, bytenr);
> +               next =3D btrfs_find_create_tree_block(fs_info, bytenr,
> +                                                   btrfs_header_owner(cu=
r),
> +                                                   *level - 1);
>                 if (IS_ERR(next))
>                         return PTR_ERR(next);
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8beb91d3cd88..0ca2e96a9cda 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6897,7 +6897,8 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_i=
nfo)
>          * fixed to BTRFS_SUPER_INFO_SIZE. If nodesize > sb size, this wi=
ll
>          * overallocate but we can keep it as-is, only the first page is =
used.
>          */
> -       sb =3D btrfs_find_create_tree_block(fs_info, BTRFS_SUPER_INFO_OFF=
SET);
> +       sb =3D btrfs_find_create_tree_block(fs_info, BTRFS_SUPER_INFO_OFF=
SET,
> +                                         root->root_key.objectid, 0);
>         if (IS_ERR(sb))
>                 return PTR_ERR(sb);
>         set_extent_buffer_uptodate(sb);
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
