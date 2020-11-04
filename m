Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6142A6C5C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbgKDSDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKDSC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 13:02:59 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A130C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 10:02:57 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id c5so12838131qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 10:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UkbkfyRBZQc3MW3y6YEDmDNnks5GmqKUpLiXx2BAzx8=;
        b=Vi8PgYjauV1JE7l4+IFJtI6APUP2+ehI2v8NyOKiTVO6kt/a7kO5SZy7mqa0ljwNrd
         Sp5p3X29YthqIBYdMmP4t+KJWSzND+1j2G0NL6mK2PBbDACUEF0OXYHsr2EkkdUGZkWO
         j56mPgXI2jkVy4V7kmtMYlnSNBPMIyggtJuSjSlmmhjhysqRvmmWPQbhPLND/mrK2OH3
         WpjjeXDlaiwLEdxWFQq1+naRHp6v9h8h7/prvVBxPArjOoUtBvpdQXveELI8CGXRNlzD
         2qVejQx2evvHTVD81+RdpHGYZfvKQfd35Wfo4yWyxTkQt+2ZB8zDd/TNUUplFaHB2Eb1
         PAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UkbkfyRBZQc3MW3y6YEDmDNnks5GmqKUpLiXx2BAzx8=;
        b=TntEi3naV7GR9jaKvazRSFo9LdWjDyvgbjgL9WPzhXyS8grGXmpu0ieU8Rf38f0MsO
         A4cEQROy5feR/xZ3UgnO/fpgmB2V3WcWKjeHzfbTBQKjQOYjV7QD7AAAMVi2NmYabG5F
         kjbuzwle8pLh0WwQHr91XPbzVIjTv5Nf/KRRkiDVrZiJjlGmZYbBi8bC8hD2Jh46Bpzf
         FNJ3rM1GtAKJuxpZeTcS7Woz3ZkMeMQ0CLf/cg7kX7r+RXNkeMbs/pLOTeCi8wJYqaQ7
         99UpZ8YfZRMUI6eNxQ+m/8Dy0H1m73hKsfhQPA4A30R94bVs298Tv921wS8VS6ybRKkc
         iiRw==
X-Gm-Message-State: AOAM530yKPLrxLW+ksc/VtLcdHCqTkdDiT5TKRfBQHrbIxmzMZbevgTF
        6A98PfMnd1yMkOsBCNjNQtRXOC0xDV0XE/0Jfqizn+kqQYg=
X-Google-Smtp-Source: ABdhPJwQYHlTi8rn195QXzJFHPU/9kubJarnePyYIc7+zdLdhzShMRwFvL+9MoKZJjqJGALgdpSAdMgvxmCG7D1VOq0=
X-Received: by 2002:aed:2321:: with SMTP id h30mr20256418qtc.213.1604512976565;
 Wed, 04 Nov 2020 10:02:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <e18fae96f7718557e766edf282a6d8f4dfe7f139.1603460665.git.josef@toxicpanda.com>
In-Reply-To: <e18fae96f7718557e766edf282a6d8f4dfe7f139.1603460665.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Nov 2020 18:02:45 +0000
Message-ID: <CAL3q7H74F8bXoS9rHXru76bc-OrcemxFmf-jE+cdj4mwgoR=8w@mail.gmail.com>
Subject: Re: [PATCH 7/8] btrfs: async load free space cache
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 5:13 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> While documenting the usage of the commit_root_sem, I noticed that we do
> not actually take the commit_root_sem in the case of the free space
> cache.  This is problematic because we're supposed to hold that sem
> while we're reading the commit roots, which is what we do for the free
> space cache.
>
> The reason I did it inline when I originally wrote the code was because
> there's the case of unpinning where we need to make sure that the free
> space cache is loaded if we're going to use the free space cache.  But
> we can accomplish the same thing by simply waiting for the cache to be
> loaded.
>
> Rework this code to load the free space cache asynchronously.  This
> allows us to greatly cleanup the caching code because now it's all
> shared by the various caching methods.  We also are now in a position to
> have the commit_root semaphore held while we're loading the free space
> cache.  And finally our modification of ->last_byte_to_unpin is removed
> because it can be handled in the proper way on commit.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/block-group.c | 123 ++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 70 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index adbd18dc08a1..ba6564f67d9a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -424,6 +424,23 @@ int btrfs_wait_block_group_cache_done(struct btrfs_b=
lock_group *cache)
>         return ret;
>  }
>
> +static bool space_cache_v1_done(struct btrfs_block_group *cache)
> +{
> +       bool ret;
> +
> +       spin_lock(&cache->lock);
> +       ret =3D cache->cached !=3D BTRFS_CACHE_FAST;
> +       spin_unlock(&cache->lock);
> +
> +       return ret;
> +}
> +
> +static void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group =
*cache,
> +                               struct btrfs_caching_control *caching_ctl=
)
> +{
> +       wait_event(caching_ctl->wait, space_cache_v1_done(cache));
> +}
> +
>  #ifdef CONFIG_BTRFS_DEBUG
>  static void fragment_free_space(struct btrfs_block_group *block_group)
>  {
> @@ -639,11 +656,28 @@ static noinline void caching_thread(struct btrfs_wo=
rk *work)
>         mutex_lock(&caching_ctl->mutex);
>         down_read(&fs_info->commit_root_sem);
>
> +       if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
> +               ret =3D load_free_space_cache(block_group);
> +               if (ret =3D=3D 1) {
> +                       ret =3D 0;
> +                       goto done;
> +               }
> +
> +               /*
> +                * We failed to load the space cache, set ourselves to
> +                * CACHE_STARTED and carry on.
> +                */
> +               spin_lock(&block_group->lock);
> +               block_group->cached =3D BTRFS_CACHE_STARTED;
> +               spin_unlock(&block_group->lock);
> +               wake_up(&caching_ctl->wait);
> +       }
> +
>         if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
>                 ret =3D load_free_space_tree(caching_ctl);
>         else
>                 ret =3D load_extent_tree_free(caching_ctl);
> -
> +done:
>         spin_lock(&block_group->lock);
>         block_group->caching_ctl =3D NULL;
>         block_group->cached =3D ret ? BTRFS_CACHE_ERROR : BTRFS_CACHE_FIN=
ISHED;
> @@ -679,7 +713,7 @@ int btrfs_cache_block_group(struct btrfs_block_group =
*cache, int load_cache_only
>  {
>         DEFINE_WAIT(wait);
>         struct btrfs_fs_info *fs_info =3D cache->fs_info;
> -       struct btrfs_caching_control *caching_ctl;
> +       struct btrfs_caching_control *caching_ctl =3D NULL;
>         int ret =3D 0;
>
>         caching_ctl =3D kzalloc(sizeof(*caching_ctl), GFP_NOFS);
> @@ -691,84 +725,28 @@ int btrfs_cache_block_group(struct btrfs_block_grou=
p *cache, int load_cache_only
>         init_waitqueue_head(&caching_ctl->wait);
>         caching_ctl->block_group =3D cache;
>         caching_ctl->progress =3D cache->start;
> -       refcount_set(&caching_ctl->count, 1);
> +       refcount_set(&caching_ctl->count, 2);
>         btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
>
>         spin_lock(&cache->lock);
>         if (cache->cached !=3D BTRFS_CACHE_NO) {
> -               spin_unlock(&cache->lock);
>                 kfree(caching_ctl);
> -               return 0;
> +
> +               caching_ctl =3D cache->caching_ctl;
> +               if (caching_ctl)
> +                       refcount_inc(&caching_ctl->count);
> +               spin_unlock(&cache->lock);
> +               goto out;
>         }
>         WARN_ON(cache->caching_ctl);
>         cache->caching_ctl =3D caching_ctl;
> -       cache->cached =3D BTRFS_CACHE_FAST;
> +       if (btrfs_test_opt(fs_info, SPACE_CACHE))
> +               cache->cached =3D BTRFS_CACHE_FAST;
> +       else
> +               cache->cached =3D BTRFS_CACHE_STARTED;
> +       cache->has_caching_ctl =3D 1;
>         spin_unlock(&cache->lock);
>
> -       if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
> -               mutex_lock(&caching_ctl->mutex);
> -               ret =3D load_free_space_cache(cache);
> -
> -               spin_lock(&cache->lock);
> -               if (ret =3D=3D 1) {
> -                       cache->caching_ctl =3D NULL;
> -                       cache->cached =3D BTRFS_CACHE_FINISHED;
> -                       cache->last_byte_to_unpin =3D (u64)-1;
> -                       caching_ctl->progress =3D (u64)-1;
> -               } else {
> -                       if (load_cache_only) {
> -                               cache->caching_ctl =3D NULL;
> -                               cache->cached =3D BTRFS_CACHE_NO;
> -                       } else {
> -                               cache->cached =3D BTRFS_CACHE_STARTED;
> -                               cache->has_caching_ctl =3D 1;
> -                       }
> -               }
> -               spin_unlock(&cache->lock);
> -#ifdef CONFIG_BTRFS_DEBUG
> -               if (ret =3D=3D 1 &&
> -                   btrfs_should_fragment_free_space(cache)) {
> -                       u64 bytes_used;
> -
> -                       spin_lock(&cache->space_info->lock);
> -                       spin_lock(&cache->lock);
> -                       bytes_used =3D cache->length - cache->used;
> -                       cache->space_info->bytes_used +=3D bytes_used >> =
1;
> -                       spin_unlock(&cache->lock);
> -                       spin_unlock(&cache->space_info->lock);
> -                       fragment_free_space(cache);
> -               }
> -#endif
> -               mutex_unlock(&caching_ctl->mutex);
> -
> -               wake_up(&caching_ctl->wait);
> -               if (ret =3D=3D 1) {
> -                       btrfs_put_caching_control(caching_ctl);
> -                       btrfs_free_excluded_extents(cache);
> -                       return 0;
> -               }
> -       } else {
> -               /*
> -                * We're either using the free space tree or no caching a=
t all.
> -                * Set cached to the appropriate value and wakeup any wai=
ters.
> -                */
> -               spin_lock(&cache->lock);
> -               if (load_cache_only) {
> -                       cache->caching_ctl =3D NULL;
> -                       cache->cached =3D BTRFS_CACHE_NO;
> -               } else {
> -                       cache->cached =3D BTRFS_CACHE_STARTED;
> -                       cache->has_caching_ctl =3D 1;
> -               }
> -               spin_unlock(&cache->lock);
> -               wake_up(&caching_ctl->wait);
> -       }
> -
> -       if (load_cache_only) {
> -               btrfs_put_caching_control(caching_ctl);
> -               return 0;
> -       }
> -
>         down_write(&fs_info->commit_root_sem);
>         refcount_inc(&caching_ctl->count);
>         list_add_tail(&caching_ctl->list, &fs_info->caching_block_groups)=
;
> @@ -777,6 +755,11 @@ int btrfs_cache_block_group(struct btrfs_block_group=
 *cache, int load_cache_only
>         btrfs_get_block_group(cache);
>
>         btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
> +out:
> +       if (load_cache_only && caching_ctl)
> +               btrfs_wait_space_cache_v1_finished(cache, caching_ctl);
> +       if (caching_ctl)
> +               btrfs_put_caching_control(caching_ctl);
>
>         return ret;
>  }
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
