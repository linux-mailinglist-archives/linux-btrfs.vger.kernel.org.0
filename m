Return-Path: <linux-btrfs+bounces-15421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1DBB000DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 13:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EAD189838E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386924A046;
	Thu, 10 Jul 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC2FIEGC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202C32222AB
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148513; cv=none; b=ulzMCUQ2hv3c12oEu9OCJh8+eLExd2ORrWAddLnLC2U756e0mzw6vuuR3N332fYxr7xJHVoF/bXuFX1c1EyDzJzziGrGCMubq3thv8xkZzOopb2VZ5Q5sq0C4onitzfqdgTFgnP9+xyGHP8S96BtkPjgsKd18xlAEBzoMH7Lelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148513; c=relaxed/simple;
	bh=nyO61kLbyKwVBAMdOO9sAZ0QaT3Qvz7lctDn39zVtn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6k+KdJYWuHZQTdwu5UmcIEbUJEDFbhTZNoUN3o08XIMi0ObEuCiStrte5tDwQT+05WD258TZwVJWuhTPjc45hSjKoQSHH2iho0jybkk1YK/LKQHouydacSdZGt/KuP4OHZkTm8vwd2xGsI/F+QYP6bwpxwtKSWWLbH6+TXLmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC2FIEGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8564DC4AF0B
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 11:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752148512;
	bh=nyO61kLbyKwVBAMdOO9sAZ0QaT3Qvz7lctDn39zVtn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CC2FIEGCyDrDaZilSqChHRN8QsGa0+IA67+w0BKGkt1g86SjnhEfnsPdSFXKTbd4Y
	 oIR5AGgwp2D+YxSC3HRgzC2wFbVntp8TE8BAhtUx3McSP7stUvBFaZhU9lIBV6bQXj
	 7Z38IQspVH7+d1xmsIPu6AoHtXXqycnh2Wyx+kpEiTHKgMr/aczITeQpNSlJ2utzP2
	 LDKPBEpvbAGrnxPZ00c6s7k9m68klR6/JJdit3aZi3lC+WauHr4TJWVeZIkuThxtxR
	 Nba81JIz2J57jt/ximhV7BddMmR9/Acy0i+6PPumSjdOCVmEGjM+B6MRAY4kSIu0eL
	 m7LjXSQhaBsCw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3b37207easo164444666b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 04:55:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YyuPM9qROju1sLBh8Wujmkzp4vx0aPzmRimwvmEAJczWS9F9WGc
	KrA4QwuIlYHCl4Orx7ZVGeawfX7cXqN7VCYFwpsc54lYZC1xy8P3VJ1CneQo7EwUF2MQYx9a/fA
	fzBWbvQPCjTvWri2ANjUuveFt8MLfCFQ=
X-Google-Smtp-Source: AGHT+IGbChgp6EEe3ynjvHl7Oc80upet9qh2cfn07WAeYnHqIHHle8u6gtiWTG7mdgJBjfm0TEE5i/CHJV3lY823Ssg=
X-Received: by 2002:a17:906:7943:b0:ad5:7bc4:84b5 with SMTP id
 a640c23a62f3a-ae6cfb954a1mr670216766b.57.1752148510820; Thu, 10 Jul 2025
 04:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com>
In-Reply-To: <fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 10 Jul 2025 12:54:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5pDTDK6zOj_85dNTbARcfaTHwqZXOGbZ-We0N5Jg8rtQ@mail.gmail.com>
X-Gm-Features: Ac12FXxN0j60HOOs3kj4gp19-K-uP8ql_64wwsQcT8-Puv7WUB8XXBLUnUJVUmA
Message-ID: <CAL3q7H5pDTDK6zOj_85dNTbARcfaTHwqZXOGbZ-We0N5Jg8rtQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: implement ref_tracker for delayed_nodes
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 11:04=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> This patch tracks references to btrfs_delayed_nodes using ref_tracker.
> This patch introduces some btrfs_delayed_node_ref_tracker_* wrappers
> around ref_tracker structures and functions. The wrappers ensure
> that when the Kconfig is disabled everything compiles down to noops.
> I was hesitant to lump this with BTRFS_DEBUG because of how expensive
> it is, so I introduced a new Kconfig "BTRFS_DELAYED_NODE_REF_TRACKER".
> If this isn't an issue I am happy to use BTRFS_DEBUG instead.
>
> - btrfs_delayed_node_ref_tracker_dir
> - btrfs_delayed_node_ref_tracker_dir_init()
> - btrfs_delayed_node_ref_tracker_dir_exit()
>
> - btrfs_delayed_node_ref_tracker
> - btrfs_delayed_node_ref_tracker_alloc()
> - btrfs_delayed_node_ref_tracker_free()
>
> Along with being useful for tracking delayed node reference leaks,
> this patch helps "document" via code where each ref count increase is
> decreased.
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/Kconfig         |  14 +++
>  fs/btrfs/delayed-inode.c | 209 ++++++++++++++++++++++++++++-----------
>  fs/btrfs/delayed-inode.h |  56 ++++++++++-
>  3 files changed, 218 insertions(+), 61 deletions(-)
>
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index c352f3ae0385c..d1bff4fdc8c05 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -72,6 +72,20 @@ config BTRFS_DEBUG
>
>           If unsure, say N.
>
> +config BTRFS_DELAYED_NODE_REF_TRACKER
> +       bool "Btrfs delayed node reference tracking"
> +       depends on BTRFS_DEBUG
> +       select REF_TRACKER
> +       help
> +         Enable run-time reference tracking for delayed nodes in btrfs f=
ilesystem.
> +
> +         This option tracks stack traces when references to delayed node=
s are taken
> +         and released. It will alert if there are outstanding references=
 when a
> +         delayed node is freed. Note that enabling this option may negat=
ively impact
> +         performance and is primarily intended for debugging purposes.
> +
> +         If unsure, say N.
> +
>  config BTRFS_ASSERT
>         bool "Btrfs assert support"
>         depends on BTRFS_FS
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 0f8d8e275143b..7e6e7532e70f5 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -4,6 +4,7 @@
>   * Written by Miao Xie <miaox@cn.fujitsu.com>
>   */
>
> +#include "linux/gfp_types.h"
>  #include <linux/slab.h>
>  #include <linux/iversion.h>
>  #include "ctree.h"
> @@ -57,6 +58,8 @@ static inline void btrfs_init_delayed_node(
>         delayed_node->root =3D root;
>         delayed_node->inode_id =3D inode_id;
>         refcount_set(&delayed_node->refs, 0);
> +       btrfs_delayed_node_ref_tracker_dir_init(&delayed_node->ref_dir, 1=
6,
> +                                               "delayed_node");
>         delayed_node->ins_root =3D RB_ROOT_CACHED;
>         delayed_node->del_root =3D RB_ROOT_CACHED;
>         mutex_init(&delayed_node->mutex);
> @@ -64,8 +67,9 @@ static inline void btrfs_init_delayed_node(
>         INIT_LIST_HEAD(&delayed_node->p_list);
>  }
>
> -static struct btrfs_delayed_node *btrfs_get_delayed_node(
> -               struct btrfs_inode *btrfs_inode)
> +static struct btrfs_delayed_node *
> +btrfs_get_delayed_node(struct btrfs_inode *btrfs_inode,
> +                      btrfs_delayed_node_ref_tracker *tracker)
>  {
>         struct btrfs_root *root =3D btrfs_inode->root;
>         u64 ino =3D btrfs_ino(btrfs_inode);
> @@ -74,6 +78,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_nod=
e(
>         node =3D READ_ONCE(btrfs_inode->delayed_node);
>         if (node) {
>                 refcount_inc(&node->refs);
> +               btrfs_delayed_node_ref_tracker_alloc(&node->ref_dir, trac=
ker,
> +                                                    GFP_NOFS);
>                 return node;
>         }
>
> @@ -83,6 +89,8 @@ static struct btrfs_delayed_node *btrfs_get_delayed_nod=
e(
>         if (node) {
>                 if (btrfs_inode->delayed_node) {
>                         refcount_inc(&node->refs);      /* can be accesse=
d */
> +                       btrfs_delayed_node_ref_tracker_alloc(
> +                               &node->ref_dir, tracker, GFP_ATOMIC);
>                         BUG_ON(btrfs_inode->delayed_node !=3D node);
>                         xa_unlock(&root->delayed_nodes);
>                         return node;
> @@ -106,6 +114,11 @@ static struct btrfs_delayed_node *btrfs_get_delayed_=
node(
>                  */
>                 if (refcount_inc_not_zero(&node->refs)) {
>                         refcount_inc(&node->refs);
> +                       btrfs_delayed_node_ref_tracker_alloc(
> +                               &node->ref_dir, tracker, GFP_ATOMIC);
> +                       btrfs_delayed_node_ref_tracker_alloc(
> +                               &node->ref_dir, &node->inode_cache_tracke=
r,
> +                               GFP_ATOMIC);
>                         btrfs_inode->delayed_node =3D node;
>                 } else {
>                         node =3D NULL;
> @@ -125,8 +138,9 @@ static struct btrfs_delayed_node *btrfs_get_delayed_n=
ode(
>   *
>   * Return the delayed node, or error pointer on failure.
>   */
> -static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> -               struct btrfs_inode *btrfs_inode)
> +static struct btrfs_delayed_node *
> +btrfs_get_or_create_delayed_node(struct btrfs_inode *btrfs_inode,
> +                                btrfs_delayed_node_ref_tracker *tracker)
>  {
>         struct btrfs_delayed_node *node;
>         struct btrfs_root *root =3D btrfs_inode->root;
> @@ -135,7 +149,7 @@ static struct btrfs_delayed_node *btrfs_get_or_create=
_delayed_node(
>         void *ptr;
>
>  again:
> -       node =3D btrfs_get_delayed_node(btrfs_inode);
> +       node =3D btrfs_get_delayed_node(btrfs_inode, tracker);
>         if (node)
>                 return node;
>
> @@ -146,6 +160,9 @@ static struct btrfs_delayed_node *btrfs_get_or_create=
_delayed_node(
>
>         /* Cached in the inode and can be accessed. */
>         refcount_set(&node->refs, 2);
> +       btrfs_delayed_node_ref_tracker_alloc(&node->ref_dir, tracker, GFP=
_NOFS);
> +       btrfs_delayed_node_ref_tracker_alloc(
> +               &node->ref_dir, &node->inode_cache_tracker, GFP_NOFS);
>
>         /* Allocate and reserve the slot, from now it can return a NULL f=
rom xa_load(). */
>         ret =3D xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> @@ -191,6 +208,8 @@ static void btrfs_queue_delayed_node(struct btrfs_del=
ayed_root *root,
>                 list_add_tail(&node->n_list, &root->node_list);
>                 list_add_tail(&node->p_list, &root->prepare_list);
>                 refcount_inc(&node->refs);      /* inserted into list */
> +               btrfs_delayed_node_ref_tracker_alloc(
> +                       &node->ref_dir, &node->node_list_tracker, GFP_ATO=
MIC);
>                 root->nodes++;
>                 set_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags);
>         }
> @@ -204,6 +223,8 @@ static void btrfs_dequeue_delayed_node(struct btrfs_d=
elayed_root *root,
>         spin_lock(&root->lock);
>         if (test_bit(BTRFS_DELAYED_NODE_IN_LIST, &node->flags)) {
>                 root->nodes--;
> +               btrfs_delayed_node_ref_tracker_free(&node->ref_dir,
> +                                                   &node->node_list_trac=
ker);
>                 refcount_dec(&node->refs);      /* not in the list */
>                 list_del_init(&node->n_list);
>                 if (!list_empty(&node->p_list))
> @@ -213,23 +234,28 @@ static void btrfs_dequeue_delayed_node(struct btrfs=
_delayed_root *root,
>         spin_unlock(&root->lock);
>  }
>
> -static struct btrfs_delayed_node *btrfs_first_delayed_node(
> -                       struct btrfs_delayed_root *delayed_root)
> +static struct btrfs_delayed_node *
> +btrfs_first_delayed_node(struct btrfs_delayed_root *delayed_root,
> +                        btrfs_delayed_node_ref_tracker *tracker)
>  {
>         struct btrfs_delayed_node *node;
>
>         spin_lock(&delayed_root->lock);
>         node =3D list_first_entry_or_null(&delayed_root->node_list,
>                                         struct btrfs_delayed_node, n_list=
);
> -       if (node)
> +       if (node) {
>                 refcount_inc(&node->refs);
> +               btrfs_delayed_node_ref_tracker_alloc(&node->ref_dir, trac=
ker,
> +                                                    GFP_ATOMIC);
> +       }
>         spin_unlock(&delayed_root->lock);
>
>         return node;
>  }
>
> -static struct btrfs_delayed_node *btrfs_next_delayed_node(
> -                                               struct btrfs_delayed_node=
 *node)
> +static struct btrfs_delayed_node *
> +btrfs_next_delayed_node(struct btrfs_delayed_node *node,
> +                       btrfs_delayed_node_ref_tracker *tracker)
>  {
>         struct btrfs_delayed_root *delayed_root;
>         struct list_head *p;
> @@ -249,15 +275,17 @@ static struct btrfs_delayed_node *btrfs_next_delaye=
d_node(
>
>         next =3D list_entry(p, struct btrfs_delayed_node, n_list);
>         refcount_inc(&next->refs);
> +       btrfs_delayed_node_ref_tracker_alloc(&next->ref_dir, tracker,
> +                                            GFP_ATOMIC);
>  out:
>         spin_unlock(&delayed_root->lock);
>
>         return next;
>  }
>
> -static void __btrfs_release_delayed_node(
> -                               struct btrfs_delayed_node *delayed_node,
> -                               int mod)
> +static void
> +__btrfs_release_delayed_node(struct btrfs_delayed_node *delayed_node, in=
t mod,
> +                            btrfs_delayed_node_ref_tracker *tracker)
>  {
>         struct btrfs_delayed_root *delayed_root;
>
> @@ -273,6 +301,7 @@ static void __btrfs_release_delayed_node(
>                 btrfs_dequeue_delayed_node(delayed_root, delayed_node);
>         mutex_unlock(&delayed_node->mutex);
>
> +       btrfs_delayed_node_ref_tracker_free(&delayed_node->ref_dir, track=
er);
>         if (refcount_dec_and_test(&delayed_node->refs)) {
>                 struct btrfs_root *root =3D delayed_node->root;
>
> @@ -282,17 +311,21 @@ static void __btrfs_release_delayed_node(
>                  * back up.  We can delete it now.
>                  */
>                 ASSERT(refcount_read(&delayed_node->refs) =3D=3D 0);
> +               btrfs_delayed_node_ref_tracker_dir_exit(&delayed_node->re=
f_dir);
>                 kmem_cache_free(delayed_node_cache, delayed_node);
>         }
>  }
>
> -static inline void btrfs_release_delayed_node(struct btrfs_delayed_node =
*node)
> +static inline void
> +btrfs_release_delayed_node(struct btrfs_delayed_node *node,
> +                          btrfs_delayed_node_ref_tracker *tracker)
>  {
> -       __btrfs_release_delayed_node(node, 0);
> +       __btrfs_release_delayed_node(node, 0, tracker);
>  }
>
> -static struct btrfs_delayed_node *btrfs_first_prepared_delayed_node(
> -                                       struct btrfs_delayed_root *delaye=
d_root)
> +static struct btrfs_delayed_node *
> +btrfs_first_prepared_delayed_node(struct btrfs_delayed_root *delayed_roo=
t,
> +                                 btrfs_delayed_node_ref_tracker *tracker=
)
>  {
>         struct btrfs_delayed_node *node;
>
> @@ -302,16 +335,19 @@ static struct btrfs_delayed_node *btrfs_first_prepa=
red_delayed_node(
>         if (node) {
>                 list_del_init(&node->p_list);
>                 refcount_inc(&node->refs);
> +               btrfs_delayed_node_ref_tracker_alloc(&node->ref_dir, trac=
ker,
> +                                                    GFP_ATOMIC);
>         }
>         spin_unlock(&delayed_root->lock);
>
>         return node;
>  }
>
> -static inline void btrfs_release_prepared_delayed_node(
> -                                       struct btrfs_delayed_node *node)
> +static inline void
> +btrfs_release_prepared_delayed_node(struct btrfs_delayed_node *node,
> +                                   btrfs_delayed_node_ref_tracker *track=
er)
>  {
> -       __btrfs_release_delayed_node(node, 1);
> +       __btrfs_release_delayed_node(node, 1, tracker);
>  }
>
>  static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
> @@ -1126,6 +1162,8 @@ static int __btrfs_run_delayed_items(struct btrfs_t=
rans_handle *trans, int nr)
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_delayed_root *delayed_root;
>         struct btrfs_delayed_node *curr_node, *prev_node;
> +       btrfs_delayed_node_ref_tracker curr_delayed_node_tracker,
> +               prev_delayed_node_tracker;
>         struct btrfs_path *path;
>         struct btrfs_block_rsv *block_rsv;
>         int ret =3D 0;
> @@ -1143,7 +1181,8 @@ static int __btrfs_run_delayed_items(struct btrfs_t=
rans_handle *trans, int nr)
>
>         delayed_root =3D fs_info->delayed_root;
>
> -       curr_node =3D btrfs_first_delayed_node(delayed_root);
> +       curr_node =3D btrfs_first_delayed_node(delayed_root,
> +                                            &curr_delayed_node_tracker);
>         while (curr_node && (!count || nr--)) {
>                 ret =3D __btrfs_commit_inode_delayed_items(trans, path,
>                                                          curr_node);
> @@ -1153,7 +1192,9 @@ static int __btrfs_run_delayed_items(struct btrfs_t=
rans_handle *trans, int nr)
>                 }
>
>                 prev_node =3D curr_node;
> -               curr_node =3D btrfs_next_delayed_node(curr_node);
> +               prev_delayed_node_tracker =3D curr_delayed_node_tracker;
> +               curr_node =3D btrfs_next_delayed_node(curr_node,
> +                                                   &curr_delayed_node_tr=
acker);
>                 /*
>                  * See the comment below about releasing path before rele=
asing
>                  * node. If the commit of delayed items was successful th=
e path
> @@ -1161,7 +1202,8 @@ static int __btrfs_run_delayed_items(struct btrfs_t=
rans_handle *trans, int nr)
>                  * point to locked extent buffers (a leaf at the very lea=
st).
>                  */
>                 ASSERT(path->nodes[0] =3D=3D NULL);
> -               btrfs_release_delayed_node(prev_node);
> +               btrfs_release_delayed_node(prev_node,
> +                                          &prev_delayed_node_tracker);
>         }
>
>         /*
> @@ -1174,7 +1216,8 @@ static int __btrfs_run_delayed_items(struct btrfs_t=
rans_handle *trans, int nr)
>         btrfs_free_path(path);
>
>         if (curr_node)
> -               btrfs_release_delayed_node(curr_node);
> +               btrfs_release_delayed_node(curr_node,
> +                                          &curr_delayed_node_tracker);
>         trans->block_rsv =3D block_rsv;
>
>         return ret;
> @@ -1193,7 +1236,9 @@ int btrfs_run_delayed_items_nr(struct btrfs_trans_h=
andle *trans, int nr)
>  int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
>                                      struct btrfs_inode *inode)
>  {
> -       struct btrfs_delayed_node *delayed_node =3D btrfs_get_delayed_nod=
e(inode);
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
> +       struct btrfs_delayed_node *delayed_node =3D
> +               btrfs_get_delayed_node(inode, &delayed_node_tracker);
>         BTRFS_PATH_AUTO_FREE(path);
>         struct btrfs_block_rsv *block_rsv;
>         int ret;
> @@ -1204,14 +1249,14 @@ int btrfs_commit_inode_delayed_items(struct btrfs=
_trans_handle *trans,
>         mutex_lock(&delayed_node->mutex);
>         if (!delayed_node->count) {
>                 mutex_unlock(&delayed_node->mutex);
> -               btrfs_release_delayed_node(delayed_node);
> +               btrfs_release_delayed_node(delayed_node, &delayed_node_tr=
acker);
>                 return 0;
>         }
>         mutex_unlock(&delayed_node->mutex);
>
>         path =3D btrfs_alloc_path();
>         if (!path) {
> -               btrfs_release_delayed_node(delayed_node);
> +               btrfs_release_delayed_node(delayed_node, &delayed_node_tr=
acker);
>                 return -ENOMEM;
>         }
>
> @@ -1220,7 +1265,7 @@ int btrfs_commit_inode_delayed_items(struct btrfs_t=
rans_handle *trans,
>
>         ret =3D __btrfs_commit_inode_delayed_items(trans, path, delayed_n=
ode);
>
> -       btrfs_release_delayed_node(delayed_node);
> +       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>         trans->block_rsv =3D block_rsv;
>
>         return ret;
> @@ -1230,7 +1275,9 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_i=
node *inode)
>  {
>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>         struct btrfs_trans_handle *trans;
> -       struct btrfs_delayed_node *delayed_node =3D btrfs_get_delayed_nod=
e(inode);
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
> +       struct btrfs_delayed_node *delayed_node =3D
> +               btrfs_get_delayed_node(inode, &delayed_node_tracker);
>         struct btrfs_path *path;
>         struct btrfs_block_rsv *block_rsv;
>         int ret;
> @@ -1241,7 +1288,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_i=
node *inode)
>         mutex_lock(&delayed_node->mutex);
>         if (!test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flag=
s)) {
>                 mutex_unlock(&delayed_node->mutex);
> -               btrfs_release_delayed_node(delayed_node);
> +               btrfs_release_delayed_node(delayed_node, &delayed_node_tr=
acker);
>                 return 0;
>         }
>         mutex_unlock(&delayed_node->mutex);
> @@ -1275,7 +1322,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_i=
node *inode)
>         btrfs_end_transaction(trans);
>         btrfs_btree_balance_dirty(fs_info);
>  out:
> -       btrfs_release_delayed_node(delayed_node);
> +       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>
>         return ret;
>  }
> @@ -1289,7 +1336,8 @@ void btrfs_remove_delayed_node(struct btrfs_inode *=
inode)
>                 return;
>
>         inode->delayed_node =3D NULL;
> -       btrfs_release_delayed_node(delayed_node);
> +       btrfs_release_delayed_node(delayed_node,
> +                                  &delayed_node->inode_cache_tracker);
>  }
>
>  struct btrfs_async_delayed_work {
> @@ -1305,6 +1353,7 @@ static void btrfs_async_run_delayed_root(struct btr=
fs_work *work)
>         struct btrfs_trans_handle *trans;
>         struct btrfs_path *path;
>         struct btrfs_delayed_node *delayed_node =3D NULL;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>         struct btrfs_root *root;
>         struct btrfs_block_rsv *block_rsv;
>         int total_done =3D 0;
> @@ -1321,7 +1370,8 @@ static void btrfs_async_run_delayed_root(struct btr=
fs_work *work)
>                     BTRFS_DELAYED_BACKGROUND / 2)
>                         break;
>
> -               delayed_node =3D btrfs_first_prepared_delayed_node(delaye=
d_root);
> +               delayed_node =3D btrfs_first_prepared_delayed_node(
> +                       delayed_root, &delayed_node_tracker);
>                 if (!delayed_node)
>                         break;
>
> @@ -1330,7 +1380,8 @@ static void btrfs_async_run_delayed_root(struct btr=
fs_work *work)
>                 trans =3D btrfs_join_transaction(root);
>                 if (IS_ERR(trans)) {
>                         btrfs_release_path(path);
> -                       btrfs_release_prepared_delayed_node(delayed_node)=
;
> +                       btrfs_release_prepared_delayed_node(
> +                               delayed_node, &delayed_node_tracker);
>                         total_done++;
>                         continue;
>                 }
> @@ -1345,7 +1396,8 @@ static void btrfs_async_run_delayed_root(struct btr=
fs_work *work)
>                 btrfs_btree_balance_dirty_nodelay(root->fs_info);
>
>                 btrfs_release_path(path);
> -               btrfs_release_prepared_delayed_node(delayed_node);
> +               btrfs_release_prepared_delayed_node(delayed_node,
> +                                                   &delayed_node_tracker=
);
>                 total_done++;
>
>         } while ((async_work->nr =3D=3D 0 && total_done < BTRFS_DELAYED_W=
RITEBACK)
> @@ -1377,10 +1429,15 @@ static int btrfs_wq_run_delayed_node(struct btrfs=
_delayed_root *delayed_root,
>
>  void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
>  {
> -       struct btrfs_delayed_node *node =3D btrfs_first_delayed_node(fs_i=
nfo->delayed_root);
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
> +       struct btrfs_delayed_node *node =3D btrfs_first_delayed_node(
> +               fs_info->delayed_root, &delayed_node_tracker);
>
> -       if (WARN_ON(node))
> +       if (WARN_ON(node)) {
> +               btrfs_delayed_node_ref_tracker_free(&node->ref_dir,
> +                                                   &delayed_node_tracker=
);
>                 refcount_dec(&node->refs);
> +       }
>  }
>
>  static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int =
seq)
> @@ -1454,13 +1511,15 @@ int btrfs_insert_delayed_dir_index(struct btrfs_t=
rans_handle *trans,
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         const unsigned int leaf_data_size =3D BTRFS_LEAF_DATA_SIZE(fs_inf=
o);
>         struct btrfs_delayed_node *delayed_node;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>         struct btrfs_delayed_item *delayed_item;
>         struct btrfs_dir_item *dir_item;
>         bool reserve_leaf_space;
>         u32 data_len;
>         int ret;
>
> -       delayed_node =3D btrfs_get_or_create_delayed_node(dir);
> +       delayed_node =3D
> +               btrfs_get_or_create_delayed_node(dir, &delayed_node_track=
er);
>         if (IS_ERR(delayed_node))
>                 return PTR_ERR(delayed_node);
>
> @@ -1536,7 +1595,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_tra=
ns_handle *trans,
>         mutex_unlock(&delayed_node->mutex);
>
>  release_node:
> -       btrfs_release_delayed_node(delayed_node);
> +       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>         return ret;
>  }
>
> @@ -1591,10 +1650,11 @@ int btrfs_delete_delayed_dir_index(struct btrfs_t=
rans_handle *trans,
>                                    struct btrfs_inode *dir, u64 index)
>  {
>         struct btrfs_delayed_node *node;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>         struct btrfs_delayed_item *item;
>         int ret;
>
> -       node =3D btrfs_get_or_create_delayed_node(dir);
> +       node =3D btrfs_get_or_create_delayed_node(dir, &delayed_node_trac=
ker);
>         if (IS_ERR(node))
>                 return PTR_ERR(node);
>
> @@ -1635,13 +1695,15 @@ int btrfs_delete_delayed_dir_index(struct btrfs_t=
rans_handle *trans,
>         }
>         mutex_unlock(&node->mutex);
>  end:
> -       btrfs_release_delayed_node(node);
> +       btrfs_release_delayed_node(node, &delayed_node_tracker);
>         return ret;
>  }
>
>  int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
>  {
> -       struct btrfs_delayed_node *delayed_node =3D btrfs_get_delayed_nod=
e(inode);
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
> +       struct btrfs_delayed_node *delayed_node =3D
> +               btrfs_get_delayed_node(inode, &delayed_node_tracker);
>
>         if (!delayed_node)
>                 return -ENOENT;
> @@ -1652,12 +1714,12 @@ int btrfs_inode_delayed_dir_index_count(struct bt=
rfs_inode *inode)
>          * is updated now. So we needn't lock the delayed node.
>          */
>         if (!delayed_node->index_cnt) {
> -               btrfs_release_delayed_node(delayed_node);
> +               btrfs_release_delayed_node(delayed_node, &delayed_node_tr=
acker);
>                 return -EINVAL;
>         }
>
>         inode->index_cnt =3D delayed_node->index_cnt;
> -       btrfs_release_delayed_node(delayed_node);
> +       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>         return 0;
>  }
>
> @@ -1668,8 +1730,9 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_i=
node *inode,
>  {
>         struct btrfs_delayed_node *delayed_node;
>         struct btrfs_delayed_item *item;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>
> -       delayed_node =3D btrfs_get_delayed_node(inode);
> +       delayed_node =3D btrfs_get_delayed_node(inode, &delayed_node_trac=
ker);
>         if (!delayed_node)
>                 return false;
>
> @@ -1704,6 +1767,8 @@ bool btrfs_readdir_get_delayed_items(struct btrfs_i=
node *inode,
>          * insert/delete delayed items in this period. So we also needn't
>          * requeue or dequeue this delayed node.
>          */
> +       btrfs_delayed_node_ref_tracker_free(&delayed_node->ref_dir,
> +                                           &delayed_node_tracker);
>         refcount_dec(&delayed_node->refs);
>
>         return true;
> @@ -1845,17 +1910,18 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u=
32 *rdev)
>  {
>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>         struct btrfs_delayed_node *delayed_node;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>         struct btrfs_inode_item *inode_item;
>         struct inode *vfs_inode =3D &inode->vfs_inode;
>
> -       delayed_node =3D btrfs_get_delayed_node(inode);
> +       delayed_node =3D btrfs_get_delayed_node(inode, &delayed_node_trac=
ker);
>         if (!delayed_node)
>                 return -ENOENT;
>
>         mutex_lock(&delayed_node->mutex);
>         if (!test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flag=
s)) {
>                 mutex_unlock(&delayed_node->mutex);
> -               btrfs_release_delayed_node(delayed_node);
> +               btrfs_release_delayed_node(delayed_node, &delayed_node_tr=
acker);
>                 return -ENOENT;
>         }
>
> @@ -1895,7 +1961,7 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32=
 *rdev)
>                 inode->index_cnt =3D (u64)-1;
>
>         mutex_unlock(&delayed_node->mutex);
> -       btrfs_release_delayed_node(delayed_node);
> +       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>         return 0;
>  }
>
> @@ -1904,9 +1970,11 @@ int btrfs_delayed_update_inode(struct btrfs_trans_=
handle *trans,
>  {
>         struct btrfs_root *root =3D inode->root;
>         struct btrfs_delayed_node *delayed_node;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>         int ret =3D 0;
>
> -       delayed_node =3D btrfs_get_or_create_delayed_node(inode);
> +       delayed_node =3D
> +               btrfs_get_or_create_delayed_node(inode, &delayed_node_tra=
cker);
>         if (IS_ERR(delayed_node))
>                 return PTR_ERR(delayed_node);
>
> @@ -1926,7 +1994,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_h=
andle *trans,
>         atomic_inc(&root->fs_info->delayed_root->items);
>  release_node:
>         mutex_unlock(&delayed_node->mutex);
> -       btrfs_release_delayed_node(delayed_node);
> +       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>         return ret;
>  }
>
> @@ -1934,6 +2002,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_ino=
de *inode)
>  {
>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>         struct btrfs_delayed_node *delayed_node;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>
>         /*
>          * we don't do delayed inode updates during log recovery because =
it
> @@ -1943,7 +2012,8 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_ino=
de *inode)
>         if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
>                 return -EAGAIN;
>
> -       delayed_node =3D btrfs_get_or_create_delayed_node(inode);
> +       delayed_node =3D
> +               btrfs_get_or_create_delayed_node(inode, &delayed_node_tra=
cker);
>         if (IS_ERR(delayed_node))
>                 return PTR_ERR(delayed_node);
>
> @@ -1970,7 +2040,7 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_ino=
de *inode)
>         atomic_inc(&fs_info->delayed_root->items);
>  release_node:
>         mutex_unlock(&delayed_node->mutex);
> -       btrfs_release_delayed_node(delayed_node);
> +       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>         return 0;
>  }
>
> @@ -2014,19 +2084,21 @@ static void __btrfs_kill_delayed_node(struct btrf=
s_delayed_node *delayed_node)
>  void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode)
>  {
>         struct btrfs_delayed_node *delayed_node;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>
> -       delayed_node =3D btrfs_get_delayed_node(inode);
> +       delayed_node =3D btrfs_get_delayed_node(inode, &delayed_node_trac=
ker);
>         if (!delayed_node)
>                 return;
>
>         __btrfs_kill_delayed_node(delayed_node);
> -       btrfs_release_delayed_node(delayed_node);
> +       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>  }
>
>  void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>  {
>         unsigned long index =3D 0;
>         struct btrfs_delayed_node *delayed_nodes[8];
> +       btrfs_delayed_node_ref_tracker delayed_node_trackers[8];
>
>         while (1) {
>                 struct btrfs_delayed_node *node;
> @@ -2045,6 +2117,10 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_roo=
t *root)
>                          * about to be removed from the tree in the loop =
below
>                          */
>                         if (refcount_inc_not_zero(&node->refs)) {
> +                               btrfs_delayed_node_ref_tracker_alloc(
> +                                       &node->ref_dir,
> +                                       &delayed_node_trackers[count],
> +                                       GFP_ATOMIC);
>                                 delayed_nodes[count] =3D node;
>                                 count++;
>                         }
> @@ -2056,7 +2132,8 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root=
 *root)
>
>                 for (int i =3D 0; i < count; i++) {
>                         __btrfs_kill_delayed_node(delayed_nodes[i]);
> -                       btrfs_release_delayed_node(delayed_nodes[i]);
> +                       btrfs_release_delayed_node(delayed_nodes[i],
> +                                                  &delayed_node_trackers=
[i]);
>                 }
>         }
>  }
> @@ -2064,14 +2141,20 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_ro=
ot *root)
>  void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info)
>  {
>         struct btrfs_delayed_node *curr_node, *prev_node;
> +       btrfs_delayed_node_ref_tracker curr_delayed_node_tracker,
> +               prev_delayed_node_tracker;
>
> -       curr_node =3D btrfs_first_delayed_node(fs_info->delayed_root);
> +       curr_node =3D btrfs_first_delayed_node(fs_info->delayed_root,
> +                                            &curr_delayed_node_tracker);
>         while (curr_node) {
>                 __btrfs_kill_delayed_node(curr_node);
>
>                 prev_node =3D curr_node;
> -               curr_node =3D btrfs_next_delayed_node(curr_node);
> -               btrfs_release_delayed_node(prev_node);
> +               prev_delayed_node_tracker =3D curr_delayed_node_tracker;
> +               curr_node =3D btrfs_next_delayed_node(curr_node,
> +                                                   &curr_delayed_node_tr=
acker);
> +               btrfs_release_delayed_node(prev_node,
> +                                          &prev_delayed_node_tracker);
>         }
>  }
>
> @@ -2081,8 +2164,9 @@ void btrfs_log_get_delayed_items(struct btrfs_inode=
 *inode,
>  {
>         struct btrfs_delayed_node *node;
>         struct btrfs_delayed_item *item;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>
> -       node =3D btrfs_get_delayed_node(inode);
> +       node =3D btrfs_get_delayed_node(inode, &delayed_node_tracker);
>         if (!node)
>                 return;
>
> @@ -2140,6 +2224,8 @@ void btrfs_log_get_delayed_items(struct btrfs_inode=
 *inode,
>          * delete delayed items.
>          */
>         ASSERT(refcount_read(&node->refs) > 1);
> +       btrfs_delayed_node_ref_tracker_free(&node->ref_dir,
> +                                           &delayed_node_tracker);
>         refcount_dec(&node->refs);
>  }
>
> @@ -2150,8 +2236,9 @@ void btrfs_log_put_delayed_items(struct btrfs_inode=
 *inode,
>         struct btrfs_delayed_node *node;
>         struct btrfs_delayed_item *item;
>         struct btrfs_delayed_item *next;
> +       btrfs_delayed_node_ref_tracker delayed_node_tracker;
>
> -       node =3D btrfs_get_delayed_node(inode);
> +       node =3D btrfs_get_delayed_node(inode, &delayed_node_tracker);
>         if (!node)
>                 return;
>
> @@ -2183,5 +2270,7 @@ void btrfs_log_put_delayed_items(struct btrfs_inode=
 *inode,
>          * delete delayed items.
>          */
>         ASSERT(refcount_read(&node->refs) > 1);
> +       btrfs_delayed_node_ref_tracker_free(&node->ref_dir,
> +                                           &delayed_node_tracker);
>         refcount_dec(&node->refs);
>  }
> diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
> index e6e763ad2d421..d7e0ec020c4d0 100644
> --- a/fs/btrfs/delayed-inode.h
> +++ b/fs/btrfs/delayed-inode.h
> @@ -7,6 +7,7 @@
>  #ifndef BTRFS_DELAYED_INODE_H
>  #define BTRFS_DELAYED_INODE_H
>
> +#include "linux/ref_tracker.h"
>  #include <linux/types.h>
>  #include <linux/rbtree.h>
>  #include <linux/spinlock.h>
> @@ -44,6 +45,51 @@ struct btrfs_delayed_root {
>         wait_queue_head_t wait;
>  };
>
> +#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
> +typedef struct ref_tracker *btrfs_delayed_node_ref_tracker;
> +typedef struct ref_tracker_dir btrfs_delayed_node_ref_tracker_dir;
> +#else
> +typedef struct {} btrfs_delayed_node_ref_tracker;
> +typedef struct {} btrfs_delayed_node_ref_tracker_dir;
> +#endif
> +
> +static inline void btrfs_delayed_node_ref_tracker_dir_init(btrfs_delayed=
_node_ref_tracker_dir *dir,
> +                                                      unsigned int quara=
ntine_count,
> +                                                      const char *name)
> +{
> +#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
> +       ref_tracker_dir_init(dir, quarantine_count, name);
> +#endif
> +}
> +
> +static inline void btrfs_delayed_node_ref_tracker_dir_exit(btrfs_delayed=
_node_ref_tracker_dir *dir)
> +{
> +#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
> +       ref_tracker_dir_exit(dir);
> +#endif
> +}
> +
> +static inline int btrfs_delayed_node_ref_tracker_alloc(btrfs_delayed_nod=
e_ref_tracker_dir *dir,
> +                                                   btrfs_delayed_node_re=
f_tracker *tracker,
> +                                                   gfp_t gfp)
> +{
> +#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
> +       return ref_tracker_alloc(dir, tracker, gfp);
> +#else
> +       return 0;
> +#endif
> +}
> +
> +static inline int btrfs_delayed_node_ref_tracker_free(btrfs_delayed_node=
_ref_tracker_dir *dir,
> +                                                  btrfs_delayed_node_ref=
_tracker *tracker)
> +{
> +#ifdef CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER
> +       return ref_tracker_free(dir, tracker);
> +#else
> +       return 0;
> +#endif
> +}
> +
>  #define BTRFS_DELAYED_NODE_IN_LIST     0
>  #define BTRFS_DELAYED_NODE_INODE_DIRTY 1
>  #define BTRFS_DELAYED_NODE_DEL_IREF    2
> @@ -63,10 +109,18 @@ struct btrfs_delayed_node {
>         struct rb_root_cached del_root;
>         struct mutex mutex;
>         struct btrfs_inode_item inode_item;
> +
>         refcount_t refs;
> -       int count;
> +       /* Used to track all references to this delayed node. */
> +       btrfs_delayed_node_ref_tracker_dir ref_dir;
> +       /* Used to track delayed node reference stored in node list. */
> +       btrfs_delayed_node_ref_tracker node_list_tracker;
> +       /* Used to track delayed node reference stored in inode cache. */
> +       btrfs_delayed_node_ref_tracker inode_cache_tracker;
> +
>         u64 index_cnt;
>         unsigned long flags;
> +       int count;

Why are you moving the count field?
This increases the size of the struct even without the new config
option enabled and as a result we get less objects per page.
You are essentially reverting this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Da20725e1e7014642fc8ba4c7dd2c4ef6d4ec56a9

Without any explanation about why.

I'm also not a big fan of the typedefs and would prefer to have
struct ref_tracker used directly in the structure surrounded by an
#ifdef block.
I also don't like adding a new Kconfig option just for this... How
much slower would a build with CONFIG_BTRFS_DEBUG=3Dy be?

If that's really a lot slower, then perhaps a more generic config
option name in case we add similar tracking to other data structures
one day.

Thanks.

>         /*
>          * The size of the next batch of dir index items to insert (if th=
is
>          * node is from a directory inode). Protected by @mutex.
> --
> 2.47.1
>
>

