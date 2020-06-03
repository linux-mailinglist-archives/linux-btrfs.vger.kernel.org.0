Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D869F1ECD62
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCKUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCKUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 06:20:01 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D2C08C5C0
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 03:19:55 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o2so1079321vsr.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SUHUshMgpbPkjYkz4JPkklCN9tt8d7J0bXRb05TQa4c=;
        b=jriZGt+itQQTiIiUZWObbr/+b2l8U/7NgkyirrIKOkkY9m09Bzh18Z7vWAIJnmFqqg
         QLxW2E5CW1A2ARX0e0Nl7cNJJ/E6A8C9ktJGX5wTQ80CQyS7S85UTz/JlFpPEfl80GG8
         xlPF5r+0rPObkYMl2tj0/ZTFnuUTIt56i9fFanghtQ4uUx8E6aLBdYyHAlZEbEBlON5/
         4jIoZDSQpDFST9xMDLOBXsC258NEPc66mPbsTSK0KMGJPih4pwxTxVErDT7ytP0+sPYU
         wcG17m8BhEuF+pvtTrWt2S97WlT9AyhpDrLGBighucKk0b0KMcIUNQeydSs9kOpM+IfB
         2Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SUHUshMgpbPkjYkz4JPkklCN9tt8d7J0bXRb05TQa4c=;
        b=eWTMRbls0u75wgCNKtu79APDZHAElb45i7x7ItGwhCtMD1E624teOspuifKJFhlDtB
         iP/DFH4qTZre6Pp3t6WyBH3ZeRuvDbnzwbI9c/qbaIM/gcdAdcmeALfaC4H2xODJQVbA
         HrkQA0dg7AoJAiLfWXbzu4/EbI8xRdcGvH8AEq1j1E8+GqsnCgsyKOff+3XATNzqRvml
         u77ryImyI9yov3C+p4AnsY7sxSFNbcCioL+JYlDdFuoyQ2elFH1FqxekwrABUYz+y4oP
         QFk4ZrHCOSjGBmfA97hNa9n0C0UzLFtxy0x82D6OmlRMa83j/YDgNsdH+X/GshVQWgSG
         2B2A==
X-Gm-Message-State: AOAM5328D8lZpz6RRTV0bS9Bova/p6sC5IeXfBhP24dHTy+H/XrrlNDn
        t91AZyseLY6rxe13RIjY9JxqciiObosawrAqY7E=
X-Google-Smtp-Source: ABdhPJxi03hqliHQ2yhTBrYKpRb74nwnEKlhB1AeX9YGUsNzJa09cyqqaBJoZEIGGOOlfhDnvqVlsMQhEQBUvPR3s0U=
X-Received: by 2002:a67:2dc1:: with SMTP id t184mr8238591vst.90.1591179593276;
 Wed, 03 Jun 2020 03:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200603101020.143372-1-anand.jain@oracle.com> <20200603101020.143372-3-anand.jain@oracle.com>
In-Reply-To: <20200603101020.143372-3-anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 3 Jun 2020 11:19:42 +0100
Message-ID: <CAL3q7H7g6DA7S27RM8o=uG7wbXbvKYKvc6ot2qnnaY1A73kPhA@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: rename btrfs_block_group::count
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 3, 2020 at 11:13 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> The name 'count' is a very commonly used name. It is often difficult to
> review the code to check if there is any leak. So rename it to
> 'bg_count', which is unique enough.

Hum? Seriously?

count to bg_count?
It's a member of the block group structure, adding a bg_ prefix adds
no value at all, we know the count is related to the block group.
I could somewhat understand if you named it 'refcount' instead.

Thanks.

>
> This patch also serves as a preparatory patch to either make sure
> btrfs_get_block_group() is used instead of open coded the same or just
> open code every where as btrfs_get_block_group() is a one-liner.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/block-group.c      | 8 ++++----
>  fs/btrfs/block-group.h      | 2 +-
>  fs/btrfs/free-space-cache.c | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 31ca2cfb7e3e..8111f6750063 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -118,12 +118,12 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *f=
s_info, u64 orig_flags)
>
>  void btrfs_get_block_group(struct btrfs_block_group *cache)
>  {
> -       atomic_inc(&cache->count);
> +       atomic_inc(&cache->bg_count);
>  }
>
>  void btrfs_put_block_group(struct btrfs_block_group *cache)
>  {
> -       if (atomic_dec_and_test(&cache->count)) {
> +       if (atomic_dec_and_test(&cache->bg_count)) {
>                 WARN_ON(cache->pinned > 0);
>                 WARN_ON(cache->reserved > 0);
>
> @@ -1805,7 +1805,7 @@ static struct btrfs_block_group *btrfs_create_block=
_group_cache(
>
>         cache->discard_index =3D BTRFS_DISCARD_INDEX_UNUSED;
>
> -       atomic_set(&cache->count, 1);
> +       atomic_set(&cache->bg_count, 1);
>         spin_lock_init(&cache->lock);
>         init_rwsem(&cache->data_rwsem);
>         INIT_LIST_HEAD(&cache->list);
> @@ -3379,7 +3379,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *i=
nfo)
>                 ASSERT(list_empty(&block_group->dirty_list));
>                 ASSERT(list_empty(&block_group->io_list));
>                 ASSERT(list_empty(&block_group->bg_list));
> -               ASSERT(atomic_read(&block_group->count) =3D=3D 1);
> +               ASSERT(atomic_read(&block_group->bg_count) =3D=3D 1);
>                 btrfs_put_block_group(block_group);
>
>                 spin_lock(&info->block_group_cache_lock);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index b6ee70a039c7..f0ef8be08747 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -115,7 +115,7 @@ struct btrfs_block_group {
>         struct list_head list;
>
>         /* Usage count */
> -       atomic_t count;
> +       atomic_t bg_count;
>
>         /*
>          * List of struct btrfs_free_clusters for this block group.
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 1bf08c855edb..169b1117c1a3 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2925,7 +2925,7 @@ void btrfs_return_cluster_to_free_space(
>                 spin_unlock(&cluster->lock);
>                 return;
>         }
> -       atomic_inc(&block_group->count);
> +       atomic_inc(&block_group->bg_count);
>         spin_unlock(&cluster->lock);
>
>         ctl =3D block_group->free_space_ctl;
> @@ -3355,7 +3355,7 @@ int btrfs_find_space_cluster(struct btrfs_block_gro=
up *block_group,
>                 list_del_init(&entry->list);
>
>         if (!ret) {
> -               atomic_inc(&block_group->count);
> +               atomic_inc(&block_group->bg_count);
>                 list_add_tail(&cluster->block_group_list,
>                               &block_group->cluster_list);
>                 cluster->block_group =3D block_group;
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
