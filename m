Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33664212224
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgGBLY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 07:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgGBLYZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 07:24:25 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C432C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 04:24:25 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id h1so6134019vkn.12
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Xyw2NEku/sUb/7HpCZKXmDvepSS4plw8dcw14BI1huw=;
        b=jI1Arn7Uyk4GJ1xgdAOELHyJ2iJ2FE1fHvfLPQUKvK7t05vAdoWeU6tK6JS+Ec9/2u
         O996pT/Lbptr8+s6+wKma8GLP0L72wGy578RTjXIFVQepEgvRgKQ1DzEe22Wpgp8uvBo
         ZnPLNd27YWdZMG363n+mZ1/sCEDEF7Szb9u348k+wEanlljAh/TfLMP3Q5YXHtTzOH6q
         3bsMD55pvgicaPvP25skyOcT1VtLqA1EPN8UgedP5/3cSHyP6UepmQLJtLri+Kq2r4eA
         IPh3XjDCVHj51mUxp5+XaLSrqt/unuPkyxT413N3Jf19qHEzU7CtRqOoo8daiAEvuIB+
         KjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Xyw2NEku/sUb/7HpCZKXmDvepSS4plw8dcw14BI1huw=;
        b=A7og1TIxHNgC/mu1zRE3TreX8LDchvLI9sqHhf4OVkUjOKg73si42v4j/e+/hAhnRP
         ZLTZx2BWShwWqDNu5HZbOn5p3sCNzBTjK73bXsy05K1trYDKYvwdVpHjO8Jh3DlO8/lC
         IYngIP/277KAflhdwgn3i9Pf+ptJSDyR4Xq3T79+ztdn6CR7vMLrRdEZ1GI/75rIQbSM
         VU67P0GJu7oMhoy9V8Fg3Fy52b+goocDhZKI1PFD13ls4kX21lrfRV+aMXKrJyhhJ7cQ
         tnH3f3OJ5gtJg3k/X4ESIgD1aOkmfaaXYKJALPoKZGoyPCtwZWJ+NMYaXxkZOkzdPJ7I
         9PDQ==
X-Gm-Message-State: AOAM530k6CUGEbAyZtLu4cH/cYorUf4KDRD77sO8cykp/0Ik9BloLS/M
        fpY1bwNFa1ACV2YR5gsCRTezRMCPJVGZL5emM91fcA==
X-Google-Smtp-Source: ABdhPJxeqJ0CYVnWNu7j0V4q2uUmVh5AzS4IXT9WVACs+li/0UkaEpwrE60PBp3kvGe+U9Mt9aniql3nu3P0yN1leJk=
X-Received: by 2002:a1f:9e8a:: with SMTP id h132mr22199276vke.14.1593689064518;
 Thu, 02 Jul 2020 04:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200701202219.11984-1-josef@toxicpanda.com>
In-Reply-To: <20200701202219.11984-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 2 Jul 2020 12:24:13 +0100
Message-ID: <CAL3q7H6fiz7=73b=OcjBKC4L_zm5hTN17KFp-AC3ppndudNi4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: convert block group refcount to refcount_t
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 1, 2020 at 9:24 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> I was experimenting with some new allocator changes and I noticed that I
> was getting a UAF with the block groups.  In order to help figure this
> out I converted the block group to use the refcount_t infrastructure.
> This is a generally good idea anyway, so kill the atomic and use
> refcount_t so we can get the benefit of loud complaints when refcounting
> goes wrong.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good and the patch compiles and works just fine here on the
latest misc-next.
Thanks.

> ---
>  fs/btrfs/block-group.c | 8 ++++----
>  fs/btrfs/block-group.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 09b796a081dd..7c0075413b08 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -118,12 +118,12 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *f=
s_info, u64 orig_flags)
>
>  void btrfs_get_block_group(struct btrfs_block_group *cache)
>  {
> -       atomic_inc(&cache->count);
> +       refcount_inc(&cache->count);
>  }
>
>  void btrfs_put_block_group(struct btrfs_block_group *cache)
>  {
> -       if (atomic_dec_and_test(&cache->count)) {
> +       if (refcount_dec_and_test(&cache->count)) {
>                 WARN_ON(cache->pinned > 0);
>                 WARN_ON(cache->reserved > 0);
>
> @@ -1805,7 +1805,7 @@ static struct btrfs_block_group *btrfs_create_block=
_group_cache(
>
>         cache->discard_index =3D BTRFS_DISCARD_INDEX_UNUSED;
>
> -       atomic_set(&cache->count, 1);
> +       refcount_set(&cache->count, 1);
>         spin_lock_init(&cache->lock);
>         init_rwsem(&cache->data_rwsem);
>         INIT_LIST_HEAD(&cache->list);
> @@ -3427,7 +3427,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *i=
nfo)
>                 ASSERT(list_empty(&block_group->dirty_list));
>                 ASSERT(list_empty(&block_group->io_list));
>                 ASSERT(list_empty(&block_group->bg_list));
> -               ASSERT(atomic_read(&block_group->count) =3D=3D 1);
> +               ASSERT(refcount_read(&block_group->count) =3D=3D 1);
>                 btrfs_put_block_group(block_group);
>
>                 spin_lock(&info->block_group_cache_lock);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index b6ee70a039c7..705e48050163 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -115,7 +115,7 @@ struct btrfs_block_group {
>         struct list_head list;
>
>         /* Usage count */
> -       atomic_t count;
> +       refcount_t count;
>
>         /*
>          * List of struct btrfs_free_clusters for this block group.
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
