Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9A706577
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 12:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjEQKlC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 06:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjEQKk6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 06:40:58 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CC40EA
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 03:40:51 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-54fb3ef9c53so131750eaf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684320051; x=1686912051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZh+gLk/EuOfN7nf4Bs/IsGn6sXisRY2VvsLQ+VskqI=;
        b=aW8P20qANOLQl0KpQdNEv6cdLlgqMt3AQL0QMgGknF3dve/Xyo3tFyT+MPZf4MM4vS
         H6jV76MkxZFuZDZQ4VVWSMVyy/eE46Ps6nKfOfOPfGs7/sxI+IkFGQqetLeGShbxoNeq
         hwtcL7fSRxNuSTLXxlPVUwF8MaquOOsmsnan4xBT49yJcy1/UoOLnoi56YEmCJ2NYKhw
         NLg7EqQ9N1e/jka8EgayMT6E9wij/BUoBrUu5Qd8hQNO3YvFcAuhXyKY6mfUzNuG/42O
         xW7wc+88NqLWVX9atIJqMNIkY0toFPwdzEOA6dgVgW987VwXg0NBEGw4tUL6ORBQae3Q
         Fj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320051; x=1686912051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZh+gLk/EuOfN7nf4Bs/IsGn6sXisRY2VvsLQ+VskqI=;
        b=RkeZ/YGTKBJbsjKNtelKozcVD9gz6AH5OquZLW8YAxnRhgxbXfHElowVByXYcQ1b8C
         zeriQSCmAgXzCPygb2vzlxyhZLCWOMeiKBY0DQqt1lhcrLwj89O2OuaQ1oYsSlWQQEgt
         tSAmG886i/eb+zTzGINyOkzsKWkLlfKnSGXTg+dZoe83Z3RsVrV3aNRUz4cSyPtWwL/v
         S+lrwft/4cSOGcrnQm4vJm0u+IuXvU8WYqzDrobzNUinduMhfEWQ+CDk+QPCes65YvsO
         jZ9i5gRu2+snXzRQqThwBGqvtp3nIG2fL4cjpYvM0mFkC7AOUmBYV95THQXh7Uuwdayg
         +ZCg==
X-Gm-Message-State: AC+VfDxpXcEbFlOTXJ9FgxdrHRr6exbg3G+qQPeKFUR1Kv9Pzx+kJU9v
        41IIxiwygLIxAs4Xe+yW4jqU8pgAzwK86Ygyoww=
X-Google-Smtp-Source: ACHHUZ7QacX2MDOR2e08KF/7VExDI6/yYwiHjMEovn25r/E5boF0RNhsN9ZNM7tS54oIRrMKofBZh9LSv0NM6FZkVMA=
X-Received: by 2002:a4a:924f:0:b0:54f:5161:4817 with SMTP id
 g15-20020a4a924f000000b0054f51614817mr12004007ooh.2.1684320050545; Wed, 17
 May 2023 03:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230515192256.29006-1-hch@lst.de> <20230515192256.29006-2-hch@lst.de>
In-Reply-To: <20230515192256.29006-2-hch@lst.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 May 2023 11:40:14 +0100
Message-ID: <CAL3q7H7k0fvvQVb5Eq3Uz61q6j1EnjxCVEeaaqu-o-JCL8K+7Q@mail.gmail.com>
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

On Mon, May 15, 2023 at 8:27=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Currently there is an extent_io_tree per transaction or tree_log root to
> track the dirty buffer ranges in the transaction or tree_log.  This is
> fairly inefficient, as:
>
>  - we only add to the list, until the transaction / log_tree commit
>    happens, at which point we'll want to walk them sequentially
>  - the dirty range means we need another mechanism to actually find
>    the dirty buffer based off the dirty range
>
> This patch instead switches tracking to one linked list per transaction
> and two to each root for the two tree logs which link a new object that
> points directly to the buffer.  Note that the list_head can't directly be
> embedded into the extent_buffer structure given that a buffer can be part
> of more than one transaction or tree_log.  This also means the existing
> error propagation based off eb->log_index never fully worked, as this
> index would get overwritten once a buffer is added to a new dirty tree.

If an extent buffer is part of 2 transactions, it means that when it
was allocated
for the next one, it was already cleaned up in the previous one, so
its ->log_index is
no longer used by the previous transaction and can be safely
overwritten by the next transaction.

Or did you find a case where that is not true?

Also some comments inlined below.

> The new code instead directly looks at the EXTENT_BUFFER_WRITE_ERR bit,
> which doesn't have this problem.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/Makefile                |   2 +-
>  fs/btrfs/ctree.h                 |   3 +-
>  fs/btrfs/disk-io.c               |  72 ++++++-------
>  fs/btrfs/extent-io-tree.h        |  10 --
>  fs/btrfs/extent-tree.c           |  21 +---
>  fs/btrfs/extent_buffer.c         |  99 ++++++++++++++++++
>  fs/btrfs/extent_buffer.h         |  23 +++++
>  fs/btrfs/extent_io.c             |  59 +----------
>  fs/btrfs/extent_io.h             |   2 -
>  fs/btrfs/fs.h                    |   3 -
>  fs/btrfs/tests/extent-io-tests.c |   2 -
>  fs/btrfs/transaction.c           | 168 +++----------------------------
>  fs/btrfs/transaction.h           |   3 +-
>  fs/btrfs/tree-log.c              |  71 ++++++++-----
>  fs/btrfs/zoned.c                 |   4 +-
>  include/trace/events/btrfs.h     |  16 +--
>  16 files changed, 232 insertions(+), 326 deletions(-)
>  create mode 100644 fs/btrfs/extent_buffer.c
>  create mode 100644 fs/btrfs/extent_buffer.h
>
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 90d53209755bf8..661cead213d6df 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -24,7 +24,7 @@ obj-$(CONFIG_BTRFS_FS) :=3D btrfs.o
>
>  btrfs-y +=3D super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-=
item.o \
>            file-item.o inode-item.o disk-io.o \
> -          transaction.o inode.o file.o defrag.o \
> +          transaction.o inode.o file.o defrag.o extent_buffer.o \
>            extent_map.o sysfs.o accessors.o xattr.o ordered-data.o \
>            extent_io.o volumes.o async-thread.o ioctl.o locking.o orphan.=
o \
>            export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 5af61480dde613..5a5fda077a0288 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -202,7 +202,8 @@ struct btrfs_root {
>         struct btrfs_root_item root_item;
>         struct btrfs_key root_key;
>         struct btrfs_fs_info *fs_info;
> -       struct extent_io_tree dirty_log_pages;
> +       struct list_head dirty_buffers[2];

As this is for the log tree, I'd prefer to have its name reflect that,
like we had before.
Something like "log_dirty_buffers" for example.

> +       spinlock_t dirty_buffers_lock;

Same here.

>
>         struct mutex objectid_mutex;
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f58806b798cd65..3b81d6ec1b47b8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -24,6 +24,7 @@
>  #include "transaction.h"
>  #include "btrfs_inode.h"
>  #include "bio.h"
> +#include "extent_buffer.h"
>  #include "print-tree.h"
>  #include "locking.h"
>  #include "tree-log.h"
> @@ -64,9 +65,6 @@ static void btrfs_destroy_ordered_extents(struct btrfs_=
root *root);
>  static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>                                       struct btrfs_fs_info *fs_info);
>  static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
> -static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
> -                                       struct extent_io_tree *dirty_page=
s,
> -                                       int mark);
>  static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
>                                        struct extent_io_tree *pinned_exte=
nts);
>  static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info);
> @@ -693,8 +691,9 @@ static void __setup_root(struct btrfs_root *root, str=
uct btrfs_fs_info *fs_info,
>         root->last_log_commit =3D 0;
>         root->anon_dev =3D 0;
>         if (!dummy) {
> -               extent_io_tree_init(fs_info, &root->dirty_log_pages,
> -                                   IO_TREE_ROOT_DIRTY_LOG_PAGES);
> +               INIT_LIST_HEAD(&root->dirty_buffers[0]);
> +               INIT_LIST_HEAD(&root->dirty_buffers[1]);
> +               spin_lock_init(&root->dirty_buffers_lock);
>                 extent_io_tree_init(fs_info, &root->log_csum_range,
>                                     IO_TREE_LOG_CSUM_RANGE);
>         }
> @@ -4208,18 +4207,16 @@ static void warn_about_uncommitted_trans(struct b=
trfs_fs_info *fs_info)
>          */
>         ASSERT(test_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags));
>         list_for_each_entry_safe(trans, tmp, &fs_info->trans_list, list) =
{
> -               struct extent_state *cached =3D NULL;
> +               struct dirty_buffer *db;
>                 u64 dirty_bytes =3D 0;
> -               u64 cur =3D 0;
> -               u64 found_start;
> -               u64 found_end;
>
>                 found =3D true;
> -               while (!find_first_extent_bit(&trans->dirty_pages, cur,
> -                       &found_start, &found_end, EXTENT_DIRTY, &cached))=
 {
> -                       dirty_bytes +=3D found_end + 1 - found_start;
> -                       cur =3D found_end + 1;
> -               }
> +
> +               spin_lock(&trans->dirty_buffers_lock);
> +               list_for_each_entry(db, &trans->dirty_buffers, wb_entry)
> +                       dirty_bytes +=3D db->eb->len;
> +               spin_unlock(&trans->dirty_buffers_lock);
> +
>                 btrfs_warn(fs_info,
>         "transaction %llu (with %llu dirty metadata bytes) is not committ=
ed",
>                            trans->transid, dirty_bytes);
> @@ -4707,38 +4704,30 @@ static void btrfs_destroy_all_delalloc_inodes(str=
uct btrfs_fs_info *fs_info)
>         spin_unlock(&fs_info->delalloc_root_lock);
>  }
>
> -static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
> -                                       struct extent_io_tree *dirty_page=
s,
> -                                       int mark)
> +static void btrfs_destroy_dirty_buffers(struct btrfs_fs_info *fs_info,
> +                                       struct btrfs_transaction *cur_tra=
ns)
>  {
> -       int ret;
> -       struct extent_buffer *eb;
> -       u64 start =3D 0;
> -       u64 end;
> +       struct dirty_buffer *db;
>
> -       while (1) {
> -               ret =3D find_first_extent_bit(dirty_pages, start, &start,=
 &end,
> -                                           mark, NULL);
> -               if (ret)
> -                       break;
> +       spin_lock(&cur_trans->dirty_buffers_lock);
> +       while ((db =3D list_first_entry_or_null(&cur_trans->dirty_buffers=
,
> +                       struct dirty_buffer, wb_entry))) {
> +               struct extent_buffer *eb =3D db->eb;
>
> -               clear_extent_bits(dirty_pages, start, end, mark);
> -               while (start <=3D end) {
> -                       eb =3D find_extent_buffer(fs_info, start);
> -                       start +=3D fs_info->nodesize;
> -                       if (!eb)
> -                               continue;
> +               list_del_init(&db->wb_entry);
> +               spin_unlock(&cur_trans->dirty_buffers_lock);
>
> -                       btrfs_tree_lock(eb);
> -                       wait_on_extent_buffer_writeback(eb);
> -                       btrfs_clear_buffer_dirty(NULL, eb);
> -                       btrfs_tree_unlock(eb);
> +               btrfs_tree_lock(eb);
> +               wait_on_extent_buffer_writeback(eb);
> +               btrfs_clear_buffer_dirty(NULL, eb);
> +               btrfs_tree_unlock(eb);
>
> -                       free_extent_buffer_stale(eb);
> -               }
> -       }
> +               free_extent_buffer_stale(eb);
> +               kfree(db);
>
> -       return ret;
> +               spin_lock(&cur_trans->dirty_buffers_lock);
> +       }
> +       spin_unlock(&cur_trans->dirty_buffers_lock);
>  }
>
>  static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
> @@ -4866,8 +4855,7 @@ void btrfs_cleanup_one_transaction(struct btrfs_tra=
nsaction *cur_trans,
>
>         btrfs_destroy_delayed_inodes(fs_info);
>
> -       btrfs_destroy_marked_extents(fs_info, &cur_trans->dirty_pages,
> -                                    EXTENT_DIRTY);
> +       btrfs_destroy_dirty_buffers(fs_info, cur_trans);
>         btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
>
>         cur_trans->state =3DTRANS_STATE_COMPLETED;
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index 21766e49ec02e7..0dae0a16a87cb7 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -12,13 +12,11 @@ enum {
>         ENUM_BIT(EXTENT_DIRTY),
>         ENUM_BIT(EXTENT_UPTODATE),
>         ENUM_BIT(EXTENT_LOCKED),
> -       ENUM_BIT(EXTENT_NEW),
>         ENUM_BIT(EXTENT_DELALLOC),
>         ENUM_BIT(EXTENT_DEFRAG),
>         ENUM_BIT(EXTENT_BOUNDARY),
>         ENUM_BIT(EXTENT_NODATASUM),
>         ENUM_BIT(EXTENT_CLEAR_META_RESV),
> -       ENUM_BIT(EXTENT_NEED_WAIT),
>         ENUM_BIT(EXTENT_NORESERVE),
>         ENUM_BIT(EXTENT_QGROUP_RESERVED),
>         ENUM_BIT(EXTENT_CLEAR_DATA_RESV),
> @@ -68,8 +66,6 @@ enum {
>         IO_TREE_BTREE_INODE_IO,
>         IO_TREE_INODE_IO,
>         IO_TREE_RELOC_BLOCKS,
> -       IO_TREE_TRANS_DIRTY_PAGES,
> -       IO_TREE_ROOT_DIRTY_LOG_PAGES,
>         IO_TREE_INODE_FILE_EXTENT,
>         IO_TREE_LOG_CSUM_RANGE,
>         IO_TREE_SELFTEST,
> @@ -210,12 +206,6 @@ static inline int set_extent_defrag(struct extent_io=
_tree *tree, u64 start,
>                               cached_state, GFP_NOFS);
>  }
>
> -static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
> -               u64 end)
> -{
> -       return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOF=
S);
> -}
> -
>  int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
>                           u64 *start_ret, u64 *end_ret, u32 bits,
>                           struct extent_state **cached_state);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 99b9ab5ccf932a..20d7cb51de944f 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -17,6 +17,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/crc32c.h>
>  #include "ctree.h"
> +#include "extent_buffer.h"
>  #include "extent-tree.h"
>  #include "tree-log.h"
>  #include "disk-io.h"
> @@ -4822,23 +4823,9 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>         btrfs_set_header_owner(buf, owner);
>         write_extent_buffer_fsid(buf, fs_info->fs_devices->metadata_uuid)=
;
>         write_extent_buffer_chunk_tree_uuid(buf, fs_info->chunk_tree_uuid=
);
> -       if (root->root_key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTID) {
> -               buf->log_index =3D root->log_transid % 2;
> -               /*
> -                * we allow two log transactions at a time, use different
> -                * EXTENT bit to differentiate dirty pages.
> -                */
> -               if (buf->log_index =3D=3D 0)
> -                       set_extent_dirty(&root->dirty_log_pages, buf->sta=
rt,
> -                                       buf->start + buf->len - 1, GFP_NO=
FS);
> -               else
> -                       set_extent_new(&root->dirty_log_pages, buf->start=
,
> -                                       buf->start + buf->len - 1);
> -       } else {
> -               buf->log_index =3D -1;
> -               set_extent_dirty(&trans->transaction->dirty_pages, buf->s=
tart,
> -                        buf->start + buf->len - 1, GFP_NOFS);
> -       }
> +
> +       btrfs_add_to_dirty_buffers_list(buf, trans->transaction, root);
> +
>         /* this returns a buffer locked for blocking */
>         return buf;
>  }
> diff --git a/fs/btrfs/extent_buffer.c b/fs/btrfs/extent_buffer.c
> new file mode 100644
> index 00000000000000..d20fc0d113968f
> --- /dev/null
> +++ b/fs/btrfs/extent_buffer.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Christoph Hellwig.
> + */
> +
> +#include <linux/list_sort.h>
> +#include "extent_buffer.h"
> +#include "extent_io.h"
> +#include "fs.h"
> +#include "transaction.h"
> +
> +void btrfs_add_to_dirty_buffers_list(struct extent_buffer *eb,
> +                                    struct btrfs_transaction *trans,
> +                                    struct btrfs_root *root)
> +{
> +       struct dirty_buffer *db =3D kmalloc(sizeof(*db), GFP_NOFS | __GFP=
_NOFAIL);
> +
> +       db->eb =3D eb;
> +       atomic_inc(&eb->refs); /* for the dirty list */
> +       if (root && root->root_key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTI=
D) {
> +               spin_lock(&root->dirty_buffers_lock);
> +               list_add_tail(&db->wb_entry,
> +                             &root->dirty_buffers[root->log_transid % 2]=
);
> +               spin_unlock(&root->dirty_buffers_lock);
> +       } else {
> +               spin_lock(&trans->dirty_buffers_lock);
> +               list_add_tail(&db->wb_entry, &trans->dirty_buffers);
> +               spin_unlock(&trans->dirty_buffers_lock);
> +       }

Ok, so there are several important differences here when compared to
the existing io tree approach that you don't mention at all in the
changelog.
These are:

1) With the io tree approach, if we allocate multiple extent buffers
that are adjacent, we get a single entry to represent them, due the
merging done by the io tree code.
With this new approach we don't have any merging at all, using more
memory and keeping a longer list, which will take longer to iterate
and sort.
For example if a 1G metadata block group is allocated, and then we
allocate all metadata extents from it, we get 65536 struct
dirty_buffer allocated, while with the io tree approach we would get a
single struct extent_state record.

2) We now need to keep references on the extent buffers. This means
they can't be released from memory until the transaction commits.
Before we didn't do this, and if an extent buffer was allocated and
freed in the same transaction, we wouldn't need to keep it in memory
until the transaction commits.
We would not need to do it as well if its writeback is started and
completed before the transaction commit.

3) Looking a bit below, we now need to sort the list, which can be
huge, especially taking into account the fact that adjacent extents
are not merged anymore as mentioned before, potentially making anyone
who's waiting on the transaction commit to wait for longer.
On the other end, when a task allocates a new buffer the insertion is
faster, as it's just appending to a list and can reduce the latency of
many syscalls (creat, mkdir, rmdir, rename, link/unlink, reflinks,
etc)

Not saying that in the end this approach isn't often or generally
better, but at the very least I would like to see all these
differences explicitly mentioned in the changelog.
The changelog gives the impression that there are no tradeoffs and the
new solution is better in every aspect.

I would say more tests/benchmarks results would be good to have too,
other than just fs_mark, and have the tests mentioned in the changelog
(results before and after this change, command lines, fio configs for
example).

Thanks.

> +}
> +
> +static int extent_buffer_cmp(void *priv, const struct list_head *a,
> +                            const struct list_head *b)
> +{
> +       s64 diff =3D container_of(a, struct dirty_buffer, wb_entry)->eb->=
start -
> +               container_of(b, struct dirty_buffer, wb_entry)->eb->start=
;
> +
> +       if (diff < 0)
> +               return -1;
> +       if (diff > 0)
> +               return 1;
> +       return 0;
> +}
> +
> +int btrfs_write_buffers(struct btrfs_fs_info *fs_info, struct list_head =
*list)
> +{
> +       struct address_space *mapping =3D fs_info->btree_inode->i_mapping=
;
> +       struct dirty_buffer *db;
> +       int werr =3D 0, err;
> +
> +       list_sort(NULL, list, extent_buffer_cmp);
> +
> +       list_for_each_entry(db, list, wb_entry) {
> +               err =3D filemap_fdatawrite_range(mapping, db->eb->start,
> +                                              db->eb->start + db->eb->le=
n - 1);
> +               if (err)
> +                       werr =3D err;
> +               cond_resched();
> +       }
> +
> +       return werr;
> +}
> +
> +int btrfs_wait_buffers(struct btrfs_fs_info *fs_info, struct list_head *=
list)
> +{
> +       struct address_space *mapping =3D fs_info->btree_inode->i_mapping=
;
> +       struct dirty_buffer *db;
> +       int werr =3D 0, err;
> +
> +       while ((db =3D list_first_entry_or_null(list, struct dirty_buffer=
,
> +                       wb_entry))) {
> +               list_del_init(&db->wb_entry);
> +
> +               err =3D filemap_fdatawait_range(mapping, db->eb->start,
> +                                             db->eb->start + db->eb->len=
 - 1);
> +               if (err)
> +                       werr =3D err;
> +               if (!werr && test_bit(EXTENT_BUFFER_WRITE_ERR, &db->eb->b=
flags))
> +                       werr =3D -EIO;
> +               free_extent_buffer(db->eb);
> +               kfree(db);
> +
> +               cond_resched();
> +       }
> +
> +       return werr;
> +}
> +
> +void btrfs_release_buffers(struct list_head *list)
> +{
> +       struct dirty_buffer *db;
> +
> +       while ((db =3D list_first_entry_or_null(list, struct dirty_buffer=
,
> +                       wb_entry))) {
> +               list_del_init(&db->wb_entry);
> +               free_extent_buffer(db->eb);
> +               kfree(db);
> +       }
> +}
> diff --git a/fs/btrfs/extent_buffer.h b/fs/btrfs/extent_buffer.h
> new file mode 100644
> index 00000000000000..880b325d7b411a
> --- /dev/null
> +++ b/fs/btrfs/extent_buffer.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BTRFS_EXTENT_BUFFER_H
> +#define BTRFS_EXTENT_BUFFER_H
> +
> +struct extent_buffer;
> +struct btrfs_fs_info;
> +struct btrfs_root;
> +struct btrfs_transaction;
> +struct list_head;
> +
> +struct dirty_buffer {
> +       struct list_head wb_entry;
> +       struct extent_buffer *eb;
> +};
> +
> +void btrfs_add_to_dirty_buffers_list(struct extent_buffer *eb,
> +                                    struct btrfs_transaction *trans,
> +                                    struct btrfs_root *root);
> +int btrfs_write_buffers(struct btrfs_fs_info *fs_info, struct list_head =
*list);
> +int btrfs_wait_buffers(struct btrfs_fs_info *fs_info, struct list_head *=
list);
> +void btrfs_release_buffers(struct list_head *list);
> +
> +#endif /* BTRFS_EXTENT_BUFFER_H */
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5999ac3ee601db..d5937ed0962d38 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1659,8 +1659,11 @@ static bool lock_extent_buffer_for_io(struct exten=
t_buffer *eb,
>
>  static void set_btree_ioerr(struct extent_buffer *eb)
>  {
> -       struct btrfs_fs_info *fs_info =3D eb->fs_info;
> -
> +       /*
> +        * Propagate this error to btrfs_wait_buffers in case the buffer =
got
> +        * written out by optimistic VM flushing and not the explicit wri=
teback
> +        * from btrfs_write_buffers().
> +        */
>         set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
>
>         /*
> @@ -1676,58 +1679,6 @@ static void set_btree_ioerr(struct extent_buffer *=
eb)
>          * the superblock.
>          */
>         mapping_set_error(eb->fs_info->btree_inode->i_mapping, -EIO);
> -
> -       /*
> -        * If writeback for a btree extent that doesn't belong to a log t=
ree
> -        * failed, increment the counter transaction->eb_write_errors.
> -        * We do this because while the transaction is running and before=
 it's
> -        * committing (when we call filemap_fdata[write|wait]_range again=
st
> -        * the btree inode), we might have
> -        * btree_inode->i_mapping->a_ops->writepages() called by the VM -=
 if it
> -        * returns an error or an error happens during writeback, when we=
're
> -        * committing the transaction we wouldn't know about it, since th=
e pages
> -        * can be no longer dirty nor marked anymore for writeback (if a
> -        * subsequent modification to the extent buffer didn't happen bef=
ore the
> -        * transaction commit), which makes filemap_fdata[write|wait]_ran=
ge not
> -        * able to find the pages tagged with SetPageError at transaction
> -        * commit time. So if this happens we must abort the transaction,
> -        * otherwise we commit a super block with btree roots that point =
to
> -        * btree nodes/leafs whose content on disk is invalid - either ga=
rbage
> -        * or the content of some node/leaf from a past generation that g=
ot
> -        * cowed or deleted and is no longer valid.
> -        *
> -        * Note: setting AS_EIO/AS_ENOSPC in the btree inode's i_mapping =
would
> -        * not be enough - we need to distinguish between log tree extent=
s vs
> -        * non-log tree extents, and the next filemap_fdatawait_range() c=
all
> -        * will catch and clear such errors in the mapping - and that cal=
l might
> -        * be from a log sync and not from a transaction commit. Also, ch=
ecking
> -        * for the eb flag EXTENT_BUFFER_WRITE_ERR at transaction commit =
time is
> -        * not done and would not be reliable - the eb might have been re=
leased
> -        * from memory and reading it back again means that flag would no=
t be
> -        * set (since it's a runtime flag, not persisted on disk).
> -        *
> -        * Using the flags below in the btree inode also makes us achieve=
 the
> -        * goal of AS_EIO/AS_ENOSPC when writepages() returns success, st=
arted
> -        * writeback for all dirty pages and before filemap_fdatawait_ran=
ge()
> -        * is called, the writeback for all dirty pages had already finis=
hed
> -        * with errors - because we were not using AS_EIO/AS_ENOSPC,
> -        * filemap_fdatawait_range() would return success, as it could no=
t know
> -        * that writeback errors happened (the pages were no longer tagge=
d for
> -        * writeback).
> -        */
> -       switch (eb->log_index) {
> -       case -1:
> -               set_bit(BTRFS_FS_BTREE_ERR, &fs_info->flags);
> -               break;
> -       case 0:
> -               set_bit(BTRFS_FS_LOG1_ERR, &fs_info->flags);
> -               break;
> -       case 1:
> -               set_bit(BTRFS_FS_LOG2_ERR, &fs_info->flags);
> -               break;
> -       default:
> -               BUG(); /* unexpected, logic error */
> -       }
>  }
>
>  /*
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index db9148bafd02c3..7c0e638346017e 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -83,8 +83,6 @@ struct extent_buffer {
>         int read_mirror;
>         struct rcu_head rcu_head;
>         pid_t lock_owner;
> -       /* >=3D 0 if eb belongs to a log tree, -1 otherwise */
> -       s8 log_index;
>
>         struct rw_semaphore lock;
>
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 840e4def18b519..f71281408102c3 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -81,9 +81,6 @@ enum {
>         BTRFS_FS_QUOTA_ENABLED,
>         BTRFS_FS_UPDATE_UUID_TREE_GEN,
>         BTRFS_FS_CREATING_FREE_SPACE_TREE,
> -       BTRFS_FS_BTREE_ERR,
> -       BTRFS_FS_LOG1_ERR,
> -       BTRFS_FS_LOG2_ERR,
>         BTRFS_FS_QUOTA_OVERRIDE,
>         /* Used to record internally whether fs has been frozen */
>         BTRFS_FS_FROZEN,
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-=
tests.c
> index dfc5c7fa603899..df7f526e0718e0 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -75,13 +75,11 @@ static void extent_flag_to_str(const struct extent_st=
ate *state, char *dest)
>         PRINT_ONE_FLAG(state, dest, cur, DIRTY);
>         PRINT_ONE_FLAG(state, dest, cur, UPTODATE);
>         PRINT_ONE_FLAG(state, dest, cur, LOCKED);
> -       PRINT_ONE_FLAG(state, dest, cur, NEW);
>         PRINT_ONE_FLAG(state, dest, cur, DELALLOC);
>         PRINT_ONE_FLAG(state, dest, cur, DEFRAG);
>         PRINT_ONE_FLAG(state, dest, cur, BOUNDARY);
>         PRINT_ONE_FLAG(state, dest, cur, NODATASUM);
>         PRINT_ONE_FLAG(state, dest, cur, CLEAR_META_RESV);
> -       PRINT_ONE_FLAG(state, dest, cur, NEED_WAIT);
>         PRINT_ONE_FLAG(state, dest, cur, NORESERVE);
>         PRINT_ONE_FLAG(state, dest, cur, QGROUP_RESERVED);
>         PRINT_ONE_FLAG(state, dest, cur, CLEAR_DATA_RESV);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index fe0f00e717a834..5353bfd8309425 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2007 Oracle.  All rights reserved.
>   */
>
> +#include <linux/list_sort.h>
>  #include <linux/fs.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> @@ -12,6 +13,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/uuid.h>
>  #include <linux/timekeeping.h>
> +#include "extent_buffer.h"
>  #include "misc.h"
>  #include "ctree.h"
>  #include "disk-io.h"
> @@ -191,7 +193,8 @@ static noinline void switch_commit_roots(struct btrfs=
_trans_handle *trans)
>                 list_del_init(&root->dirty_list);
>                 free_extent_buffer(root->commit_root);
>                 root->commit_root =3D btrfs_root_node(root);
> -               extent_io_tree_release(&root->dirty_log_pages);
> +               ASSERT(list_empty_careful(&root->dirty_buffers[0]));
> +               ASSERT(list_empty_careful(&root->dirty_buffers[1]));
>                 btrfs_qgroup_clean_swapped_blocks(root);
>         }
>
> @@ -375,8 +378,8 @@ static noinline int join_transaction(struct btrfs_fs_=
info *fs_info,
>         INIT_LIST_HEAD(&cur_trans->deleted_bgs);
>         spin_lock_init(&cur_trans->dropped_roots_lock);
>         list_add_tail(&cur_trans->list, &fs_info->trans_list);
> -       extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
> -                       IO_TREE_TRANS_DIRTY_PAGES);
> +       INIT_LIST_HEAD(&cur_trans->dirty_buffers);
> +       spin_lock_init(&cur_trans->dirty_buffers_lock);
>         extent_io_tree_init(fs_info, &cur_trans->pinned_extents,
>                         IO_TREE_FS_PINNED_EXTENTS);
>         fs_info->generation++;
> @@ -1039,141 +1042,6 @@ int btrfs_end_transaction_throttle(struct btrfs_t=
rans_handle *trans)
>         return __btrfs_end_transaction(trans, 1);
>  }
>
> -/*
> - * when btree blocks are allocated, they have some corresponding bits se=
t for
> - * them in one of two extent_io trees.  This is used to make sure all of
> - * those extents are sent to disk but does not wait on them
> - */
> -int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
> -                              struct extent_io_tree *dirty_pages, int ma=
rk)
> -{
> -       int err =3D 0;
> -       int werr =3D 0;
> -       struct address_space *mapping =3D fs_info->btree_inode->i_mapping=
;
> -       struct extent_state *cached_state =3D NULL;
> -       u64 start =3D 0;
> -       u64 end;
> -
> -       while (!find_first_extent_bit(dirty_pages, start, &start, &end,
> -                                     mark, &cached_state)) {
> -               bool wait_writeback =3D false;
> -
> -               err =3D convert_extent_bit(dirty_pages, start, end,
> -                                        EXTENT_NEED_WAIT,
> -                                        mark, &cached_state);
> -               /*
> -                * convert_extent_bit can return -ENOMEM, which is most o=
f the
> -                * time a temporary error. So when it happens, ignore the=
 error
> -                * and wait for writeback of this range to finish - becau=
se we
> -                * failed to set the bit EXTENT_NEED_WAIT for the range, =
a call
> -                * to __btrfs_wait_marked_extents() would not know that
> -                * writeback for this range started and therefore wouldn'=
t
> -                * wait for it to finish - we don't want to commit a
> -                * superblock that points to btree nodes/leafs for which
> -                * writeback hasn't finished yet (and without errors).
> -                * We cleanup any entries left in the io tree when commit=
ting
> -                * the transaction (through extent_io_tree_release()).
> -                */
> -               if (err =3D=3D -ENOMEM) {
> -                       err =3D 0;
> -                       wait_writeback =3D true;
> -               }
> -               if (!err)
> -                       err =3D filemap_fdatawrite_range(mapping, start, =
end);
> -               if (err)
> -                       werr =3D err;
> -               else if (wait_writeback)
> -                       werr =3D filemap_fdatawait_range(mapping, start, =
end);
> -               free_extent_state(cached_state);
> -               cached_state =3D NULL;
> -               cond_resched();
> -               start =3D end + 1;
> -       }
> -       return werr;
> -}
> -
> -/*
> - * when btree blocks are allocated, they have some corresponding bits se=
t for
> - * them in one of two extent_io trees.  This is used to make sure all of
> - * those extents are on disk for transaction or log commit.  We wait
> - * on all the pages and clear them from the dirty pages state tree
> - */
> -static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
> -                                      struct extent_io_tree *dirty_pages=
)
> -{
> -       int err =3D 0;
> -       int werr =3D 0;
> -       struct address_space *mapping =3D fs_info->btree_inode->i_mapping=
;
> -       struct extent_state *cached_state =3D NULL;
> -       u64 start =3D 0;
> -       u64 end;
> -
> -       while (!find_first_extent_bit(dirty_pages, start, &start, &end,
> -                                     EXTENT_NEED_WAIT, &cached_state)) {
> -               /*
> -                * Ignore -ENOMEM errors returned by clear_extent_bit().
> -                * When committing the transaction, we'll remove any entr=
ies
> -                * left in the io tree. For a log commit, we don't remove=
 them
> -                * after committing the log because the tree can be acces=
sed
> -                * concurrently - we do it only at transaction commit tim=
e when
> -                * it's safe to do it (through extent_io_tree_release()).
> -                */
> -               err =3D clear_extent_bit(dirty_pages, start, end,
> -                                      EXTENT_NEED_WAIT, &cached_state);
> -               if (err =3D=3D -ENOMEM)
> -                       err =3D 0;
> -               if (!err)
> -                       err =3D filemap_fdatawait_range(mapping, start, e=
nd);
> -               if (err)
> -                       werr =3D err;
> -               free_extent_state(cached_state);
> -               cached_state =3D NULL;
> -               cond_resched();
> -               start =3D end + 1;
> -       }
> -       if (err)
> -               werr =3D err;
> -       return werr;
> -}
> -
> -static int btrfs_wait_extents(struct btrfs_fs_info *fs_info,
> -                      struct extent_io_tree *dirty_pages)
> -{
> -       bool errors =3D false;
> -       int err;
> -
> -       err =3D __btrfs_wait_marked_extents(fs_info, dirty_pages);
> -       if (test_and_clear_bit(BTRFS_FS_BTREE_ERR, &fs_info->flags))
> -               errors =3D true;
> -
> -       if (errors && !err)
> -               err =3D -EIO;
> -       return err;
> -}
> -
> -int btrfs_wait_tree_log_extents(struct btrfs_root *log_root, int mark)
> -{
> -       struct btrfs_fs_info *fs_info =3D log_root->fs_info;
> -       struct extent_io_tree *dirty_pages =3D &log_root->dirty_log_pages=
;
> -       bool errors =3D false;
> -       int err;
> -
> -       ASSERT(log_root->root_key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTID=
);
> -
> -       err =3D __btrfs_wait_marked_extents(fs_info, dirty_pages);
> -       if ((mark & EXTENT_DIRTY) &&
> -           test_and_clear_bit(BTRFS_FS_LOG1_ERR, &fs_info->flags))
> -               errors =3D true;
> -
> -       if ((mark & EXTENT_NEW) &&
> -           test_and_clear_bit(BTRFS_FS_LOG2_ERR, &fs_info->flags))
> -               errors =3D true;
> -
> -       if (errors && !err)
> -               err =3D -EIO;
> -       return err;
> -}
> -
>  /*
>   * When btree blocks are allocated the corresponding extents are marked =
dirty.
>   * This function ensures such extents are persisted on disk for transact=
ion or
> @@ -1183,25 +1051,22 @@ int btrfs_wait_tree_log_extents(struct btrfs_root=
 *log_root, int mark)
>   */
>  static int btrfs_write_and_wait_transaction(struct btrfs_trans_handle *t=
rans)
>  {
> -       int ret;
> -       int ret2;
> -       struct extent_io_tree *dirty_pages =3D &trans->transaction->dirty=
_pages;
> -       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       LIST_HEAD(dirty_buffers);
>         struct blk_plug plug;
> +       int ret, ret2;
> +
> +       spin_lock(&trans->transaction->dirty_buffers_lock);
> +       list_splice_init(&trans->transaction->dirty_buffers, &dirty_buffe=
rs);
> +       spin_unlock(&trans->transaction->dirty_buffers_lock);
>
>         blk_start_plug(&plug);
> -       ret =3D btrfs_write_marked_extents(fs_info, dirty_pages, EXTENT_D=
IRTY);
> +       ret =3D btrfs_write_buffers(trans->fs_info, &dirty_buffers);
>         blk_finish_plug(&plug);
> -       ret2 =3D btrfs_wait_extents(fs_info, dirty_pages);
> -
> -       extent_io_tree_release(&trans->transaction->dirty_pages);
>
> +       ret2 =3D btrfs_wait_buffers(trans->fs_info, &dirty_buffers);
>         if (ret)
>                 return ret;
> -       else if (ret2)
> -               return ret2;
> -       else
> -               return 0;
> +       return ret2;
>  }
>
>  /*
> @@ -2443,9 +2308,6 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
>
>         btrfs_commit_device_sizes(cur_trans);
>
> -       clear_bit(BTRFS_FS_LOG1_ERR, &fs_info->flags);
> -       clear_bit(BTRFS_FS_LOG2_ERR, &fs_info->flags);
> -
>         btrfs_trans_release_chunk_metadata(trans);
>
>         /*
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 8e9fa23bd7fed7..eade7eb41a07ef 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -47,7 +47,8 @@ struct btrfs_transaction {
>         enum btrfs_trans_state state;
>         int aborted;
>         struct list_head list;
> -       struct extent_io_tree dirty_pages;
> +       struct list_head dirty_buffers;
> +       spinlock_t dirty_buffers_lock;
>         time64_t start_time;
>         wait_queue_head_t writer_wait;
>         wait_queue_head_t commit_wait;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 9b212e8c70cc58..012b7e03d57968 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -8,6 +8,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/list_sort.h>
>  #include <linux/iversion.h>
> +#include "extent_buffer.h"
>  #include "misc.h"
>  #include "ctree.h"
>  #include "tree-log.h"
> @@ -2847,6 +2848,24 @@ static inline void btrfs_remove_all_log_ctxs(struc=
t btrfs_root *root,
>         }
>  }
>
> +static void btrfs_pick_all_dirty_log_buffers(struct btrfs_root *log,
> +               struct list_head *dirty_buffers)
> +{
> +       spin_lock(&log->dirty_buffers_lock);
> +       list_splice_tail_init(&log->dirty_buffers[0], dirty_buffers);
> +       list_splice_tail_init(&log->dirty_buffers[1], dirty_buffers);
> +       spin_unlock(&log->dirty_buffers_lock);
> +}
> +
> +static void btrfs_pick_dirty_log_buffers(struct btrfs_root *log,
> +                                        struct list_head *dirty_buffers,
> +                                        int log_transid)
> +{
> +       spin_lock(&log->dirty_buffers_lock);
> +       list_splice_init(&log->dirty_buffers[log_transid % 2], dirty_buff=
ers);
> +       spin_unlock(&log->dirty_buffers_lock);
> +}
> +
>  /*
>   * btrfs_sync_log does sends a given tree log down to the disk and
>   * updates the super blocks to record it.  When this call is done,
> @@ -2864,7 +2883,6 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans=
,
>  {
>         int index1;
>         int index2;
> -       int mark;
>         int ret;
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct btrfs_root *log =3D root->log_root;
> @@ -2875,6 +2893,8 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans=
,
>         struct blk_plug plug;
>         u64 log_root_start;
>         u64 log_root_level;
> +       LIST_HEAD(dirty_log_buffers);
> +       LIST_HEAD(dirty_log_root_buffers);
>
>         mutex_lock(&root->log_mutex);
>         log_transid =3D ctx->log_transid;
> @@ -2917,16 +2937,15 @@ int btrfs_sync_log(struct btrfs_trans_handle *tra=
ns,
>                 goto out;
>         }
>
> -       if (log_transid % 2 =3D=3D 0)
> -               mark =3D EXTENT_DIRTY;
> -       else
> -               mark =3D EXTENT_NEW;
> +       blk_start_plug(&plug);
>
> -       /* we start IO on  all the marked extents here, but we don't actu=
ally
> -        * wait for them until later.
> +       /*
> +        * Start I/O on all dirty buffers, but don't actually wait for th=
em
> +        * until later.
>          */
> -       blk_start_plug(&plug);
> -       ret =3D btrfs_write_marked_extents(fs_info, &log->dirty_log_pages=
, mark);
> +       btrfs_pick_dirty_log_buffers(log, &dirty_log_buffers, log_transid=
);
> +       ret =3D btrfs_write_buffers(fs_info, &dirty_log_buffers);
> +
>         /*
>          * -EAGAIN happens when someone, e.g., a concurrent transaction
>          *  commit, writes a dirty extent in this tree-log commit. This
> @@ -3008,7 +3027,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans=
,
>                         btrfs_err(fs_info,
>                                   "failed to update log for root %llu ret=
 %d",
>                                   root->root_key.objectid, ret);
> -               btrfs_wait_tree_log_extents(log, mark);
> +               btrfs_wait_buffers(fs_info, &dirty_log_buffers);
>                 mutex_unlock(&log_root_tree->log_mutex);
>                 goto out;
>         }
> @@ -3024,7 +3043,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans=
,
>         index2 =3D root_log_ctx.log_transid % 2;
>         if (atomic_read(&log_root_tree->log_commit[index2])) {
>                 blk_finish_plug(&plug);
> -               ret =3D btrfs_wait_tree_log_extents(log, mark);
> +               ret =3D btrfs_wait_buffers(fs_info, &dirty_log_buffers);
>                 wait_log_commit(log_root_tree,
>                                 root_log_ctx.log_transid);
>                 mutex_unlock(&log_root_tree->log_mutex);
> @@ -3046,15 +3065,14 @@ int btrfs_sync_log(struct btrfs_trans_handle *tra=
ns,
>          */
>         if (btrfs_need_log_full_commit(trans)) {
>                 blk_finish_plug(&plug);
> -               btrfs_wait_tree_log_extents(log, mark);
> +               btrfs_wait_buffers(fs_info, &dirty_log_buffers);
>                 mutex_unlock(&log_root_tree->log_mutex);
>                 ret =3D BTRFS_LOG_FORCE_COMMIT;
>                 goto out_wake_log_root;
>         }
>
> -       ret =3D btrfs_write_marked_extents(fs_info,
> -                                        &log_root_tree->dirty_log_pages,
> -                                        EXTENT_DIRTY | EXTENT_NEW);
> +       btrfs_pick_all_dirty_log_buffers(log_root_tree, &dirty_log_root_b=
uffers);
> +       ret =3D btrfs_write_buffers(fs_info, &dirty_log_root_buffers);
>         blk_finish_plug(&plug);
>         /*
>          * As described above, -EAGAIN indicates a hole in the extents. W=
e
> @@ -3063,7 +3081,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans=
,
>          */
>         if (ret =3D=3D -EAGAIN && btrfs_is_zoned(fs_info)) {
>                 btrfs_set_log_full_commit(trans);
> -               btrfs_wait_tree_log_extents(log, mark);
> +               btrfs_wait_buffers(fs_info, &dirty_log_buffers);
>                 mutex_unlock(&log_root_tree->log_mutex);
>                 goto out_wake_log_root;
>         } else if (ret) {
> @@ -3071,10 +3089,9 @@ int btrfs_sync_log(struct btrfs_trans_handle *tran=
s,
>                 mutex_unlock(&log_root_tree->log_mutex);
>                 goto out_wake_log_root;
>         }
> -       ret =3D btrfs_wait_tree_log_extents(log, mark);
> +       ret =3D btrfs_wait_buffers(fs_info, &dirty_log_buffers);
>         if (!ret)
> -               ret =3D btrfs_wait_tree_log_extents(log_root_tree,
> -                                                 EXTENT_NEW | EXTENT_DIR=
TY);
> +               ret =3D btrfs_wait_buffers(fs_info, &dirty_log_root_buffe=
rs);
>         if (ret) {
>                 btrfs_set_log_full_commit(trans);
>                 mutex_unlock(&log_root_tree->log_mutex);
> @@ -3160,6 +3177,9 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans=
,
>         atomic_set(&root->log_commit[index1], 0);
>         mutex_unlock(&root->log_mutex);
>
> +       btrfs_release_buffers(&dirty_log_buffers);
> +       btrfs_release_buffers(&dirty_log_root_buffers);
> +
>         /*
>          * The barrier before waitqueue_active (in cond_wake_up) is neede=
d so
>          * all the updates above are seen by the woken threads. It might =
not be
> @@ -3177,6 +3197,7 @@ static void free_log_tree(struct btrfs_trans_handle=
 *trans,
>                 .free =3D 1,
>                 .process_func =3D process_one_buffer
>         };
> +       LIST_HEAD(dirty_buffers);
>
>         if (log->node) {
>                 ret =3D walk_log_tree(trans, log, &wc);
> @@ -3198,11 +3219,9 @@ static void free_log_tree(struct btrfs_trans_handl=
e *trans,
>                          * them out and wait for their writeback to compl=
ete, so
>                          * that we properly cleanup their state and pages=
.
>                          */
> -                       btrfs_write_marked_extents(log->fs_info,
> -                                                  &log->dirty_log_pages,
> -                                                  EXTENT_DIRTY | EXTENT_=
NEW);
> -                       btrfs_wait_tree_log_extents(log,
> -                                                   EXTENT_DIRTY | EXTENT=
_NEW);
> +                       btrfs_pick_all_dirty_log_buffers(log, &dirty_buff=
ers);
> +                       btrfs_write_buffers(log->fs_info, &dirty_buffers)=
;
> +                       btrfs_wait_buffers(log->fs_info, &dirty_buffers);
>
>                         if (trans)
>                                 btrfs_abort_transaction(trans, ret);
> @@ -3211,8 +3230,8 @@ static void free_log_tree(struct btrfs_trans_handle=
 *trans,
>                 }
>         }
>
> -       clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
> -                         EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
> +       btrfs_pick_all_dirty_log_buffers(log, &dirty_buffers);
> +       btrfs_release_buffers(&dirty_buffers);
>         extent_io_tree_release(&log->log_csum_range);
>
>         btrfs_put_root(log);
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index bda301a55cbe3b..e4b8134ab70166 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -6,6 +6,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/atomic.h>
>  #include <linux/vmalloc.h>
> +#include "extent_buffer.h"
>  #include "ctree.h"
>  #include "volumes.h"
>  #include "zoned.h"
> @@ -1611,8 +1612,7 @@ void btrfs_redirty_list_add(struct btrfs_transactio=
n *trans,
>         memzero_extent_buffer(eb, 0, eb->len);
>         set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
>         set_extent_buffer_dirty(eb);
> -       set_extent_bits_nowait(&trans->dirty_pages, eb->start,
> -                              eb->start + eb->len - 1, EXTENT_DIRTY);
> +       btrfs_add_to_dirty_buffers_list(eb, trans, NULL);
>  }
>
>  bool btrfs_use_zone_append(struct btrfs_bio *bbio)
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 8ea9cea9bfeb4d..aae33b9067b918 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -86,8 +86,6 @@ struct find_free_extent_ctl;
>         EM( IO_TREE_BTREE_INODE_IO,       "BTREE_INODE_IO")         \
>         EM( IO_TREE_INODE_IO,             "INODE_IO")               \
>         EM( IO_TREE_RELOC_BLOCKS,         "RELOC_BLOCKS")           \
> -       EM( IO_TREE_TRANS_DIRTY_PAGES,    "TRANS_DIRTY_PAGES")      \
> -       EM( IO_TREE_ROOT_DIRTY_LOG_PAGES, "ROOT_DIRTY_LOG_PAGES")   \
>         EM( IO_TREE_INODE_FILE_EXTENT,    "INODE_FILE_EXTENT")      \
>         EM( IO_TREE_LOG_CSUM_RANGE,       "LOG_CSUM_RANGE")         \
>         EMe(IO_TREE_SELFTEST,             "SELFTEST")
> @@ -147,13 +145,11 @@ FLUSH_STATES
>         { EXTENT_DIRTY,                 "DIRTY"},               \
>         { EXTENT_UPTODATE,              "UPTODATE"},            \
>         { EXTENT_LOCKED,                "LOCKED"},              \
> -       { EXTENT_NEW,                   "NEW"},                 \
>         { EXTENT_DELALLOC,              "DELALLOC"},            \
>         { EXTENT_DEFRAG,                "DEFRAG"},              \
>         { EXTENT_BOUNDARY,              "BOUNDARY"},            \
>         { EXTENT_NODATASUM,             "NODATASUM"},           \
>         { EXTENT_CLEAR_META_RESV,       "CLEAR_META_RESV"},     \
> -       { EXTENT_NEED_WAIT,             "NEED_WAIT"},           \
>         { EXTENT_NORESERVE,             "NORESERVE"},           \
>         { EXTENT_QGROUP_RESERVED,       "QGROUP_RESERVED"},     \
>         { EXTENT_CLEAR_DATA_RESV,       "CLEAR_DATA_RESV"},     \
> @@ -2289,7 +2285,6 @@ DECLARE_EVENT_CLASS(btrfs_sleep_tree_lock,
>                 __field(        u64,    end_ns          )
>                 __field(        u64,    diff_ns         )
>                 __field(        u64,    owner           )
> -               __field(        int,    is_log_tree     )
>         ),
>
>         TP_fast_assign_btrfs(eb->fs_info,
> @@ -2299,14 +2294,13 @@ DECLARE_EVENT_CLASS(btrfs_sleep_tree_lock,
>                 __entry->end_ns         =3D ktime_get_ns();
>                 __entry->diff_ns        =3D __entry->end_ns - start_ns;
>                 __entry->owner          =3D btrfs_header_owner(eb);
> -               __entry->is_log_tree    =3D (eb->log_index >=3D 0);
>         ),
>
>         TP_printk_btrfs(
> -"block=3D%llu generation=3D%llu start_ns=3D%llu end_ns=3D%llu diff_ns=3D=
%llu owner=3D%llu is_log_tree=3D%d",
> +"block=3D%llu generation=3D%llu start_ns=3D%llu end_ns=3D%llu diff_ns=3D=
%llu owner=3D%llu",
>                 __entry->block, __entry->generation,
>                 __entry->start_ns, __entry->end_ns, __entry->diff_ns,
> -               __entry->owner, __entry->is_log_tree)
> +               __entry->owner)
>  );
>
>  DEFINE_EVENT(btrfs_sleep_tree_lock, btrfs_tree_read_lock,
> @@ -2330,19 +2324,17 @@ DECLARE_EVENT_CLASS(btrfs_locking_events,
>                 __field(        u64,    block           )
>                 __field(        u64,    generation      )
>                 __field(        u64,    owner           )
> -               __field(        int,    is_log_tree     )
>         ),
>
>         TP_fast_assign_btrfs(eb->fs_info,
>                 __entry->block          =3D eb->start;
>                 __entry->generation     =3D btrfs_header_generation(eb);
>                 __entry->owner          =3D btrfs_header_owner(eb);
> -               __entry->is_log_tree    =3D (eb->log_index >=3D 0);
>         ),
>
> -       TP_printk_btrfs("block=3D%llu generation=3D%llu owner=3D%llu is_l=
og_tree=3D%d",
> +       TP_printk_btrfs("block=3D%llu generation=3D%llu owner=3D%llu",
>                 __entry->block, __entry->generation,
> -               __entry->owner, __entry->is_log_tree)
> +               __entry->owner)
>  );
>
>  #define DEFINE_BTRFS_LOCK_EVENT(name)                          \
> --
> 2.39.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
