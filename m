Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0140E2A8844
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 21:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbgKEUnX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 15:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEUnX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 15:43:23 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFC7C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 12:43:22 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id i12so2133550qtj.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iKkC4cNGmyBTHMOnashmNt2vKdT0sVVuDtsikoyQf6M=;
        b=C3h0hRpYVm5dA55teGgiNkWvWGCW+Nk7XMerS1NoATR2eEnESPCvY/r22DqKxpWVVK
         CD+ln/zy39DJoxImT9B4+Vkt32CVZkJchoTOBnLr4C8SodhfoU+XMasOubBVJZz6hdf3
         dqI2YwrVvOwUuah0+hDjs4ZQY2YL0OJm7hcGcZu+HFyd4XbahdphHXYegC4K0wPZSz5i
         zqlOS/+cmD8RGfAfgpTwHUFLVo0//xbyoXddA6BSdJQCaDLmyz2wD/JPwrs/W63tsXMT
         gZZkTdn1RWVbTiU/wFXAgeQbxbGFJGMPTf3t5Tw2qGF2uAji9h+kBl3xryWl1/HB4JHF
         quJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iKkC4cNGmyBTHMOnashmNt2vKdT0sVVuDtsikoyQf6M=;
        b=SI1jJ9kvfStqZ4AZhi5dX5q5Cg+xcPEQ8SgRyKycTTNP21U+skWQjmEQJIb+6l6dJD
         U0Kld9o4H9bMz0ZGXIXQM1wez9P9ADrcIwfucwVSmfEi+203aknT6NFFUFIFMEt+Pvbn
         KwXEKQFwKBjTtzrUzd8XMAoW8GPHzQDXH2o7LT33WKEApxQUwEu62ljw4XKTcDzSz4Es
         uYHjQqboe9rVuFssHdGoXJmK0bwSZ3yqRjs6SsJqGW/Jq4p5IZsSod9ExTdREIx5xxEc
         JDPqmyff0ZyjMKYXrDCcLA0po6bpiq0yH0Ekl7gtGa3B4Q7G/QOEViASdXdjMot+IB12
         mPtw==
X-Gm-Message-State: AOAM5327BgWc2L16eQ9QLIoZx9avv5Zakt+QgDCFgQqs8cIN7UcNI2lf
        c9YHtuvVoQUN3HwyVxETkUOUUd02uDNxNQgEmCRfVCFa
X-Google-Smtp-Source: ABdhPJyWL8XygzZhDWRncUqzsJyplPZjZOqYbq29kCsuZErAcY4hBBx62X42LFUrPkMmjXW5EzL5ioPsJWklcFYXFDA=
X-Received: by 2002:ac8:832:: with SMTP id u47mr3889208qth.376.1604609001933;
 Thu, 05 Nov 2020 12:43:21 -0800 (PST)
MIME-Version: 1.0
References: <01bacd1faab24648e9701e34318f7bfd6a1f098b.1604608527.git.josef@toxicpanda.com>
In-Reply-To: <01bacd1faab24648e9701e34318f7bfd6a1f098b.1604608527.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 5 Nov 2020 20:43:10 +0000
Message-ID: <CAL3q7H4qTTpqH10Gv+Nyo0pw-yaj_V0EnMfFhczM5oECQRHFhQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: wait on v1 cache for log replay
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 8:37 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Filipe reported btrfs/159 and btrfs/201 failures with the latest
> misc-next, and bisected it to my change to always async the loading of
> the v1 cache.  This is because when replaying the log we expect that the
> free space cache will be read entirely before we start excluding space
> to replay.  However this obviously changed, and thus we ended up
> overwriting things that were allocated during replay.  Fix this by
> exporting the helper to wait on v1 space cache and use it for this
> exclusion step.  I've audited everywhere else and we are OK with all
> other callers.  Anywhere that also required reading the space cache in
> its entirety used btrfs_cache_block_group() with load_cache_only set,
> which waits for the cache to be loaded.  We do not use that here because
> we want to start caching the block group even if we aren't using the
> free space inode.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

It works and makes sense.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks!

> ---
> Dave, this can be folded into
>
>         btrfs: async load free space cache
>
> and it'll be good to go.  I validated it fixed the report, just provided =
the
> changelog to explain what happened.
>
>  fs/btrfs/block-group.c | 2 +-
>  fs/btrfs/block-group.h | 2 ++
>  fs/btrfs/extent-tree.c | 5 +++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index f19fabae4754..35be6dbca5e8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -435,7 +435,7 @@ static bool space_cache_v1_done(struct btrfs_block_gr=
oup *cache)
>         return ret;
>  }
>
> -static void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group =
*cache,
> +void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
>                                 struct btrfs_caching_control *caching_ctl=
)
>  {
>         wait_event(caching_ctl->wait, space_cache_v1_done(cache));
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index adfd7583a17b..8f74a96074f7 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -268,6 +268,8 @@ void check_system_chunk(struct btrfs_trans_handle *tr=
ans, const u64 type);
>  u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flag=
s);
>  void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
>  int btrfs_free_block_groups(struct btrfs_fs_info *info);
> +void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
> +                               struct btrfs_caching_control *caching_ctl=
);
>
>  static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info=
)
>  {
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d7a68203cda0..5c82cfdb0944 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2641,6 +2641,11 @@ static int __exclude_logged_extent(struct btrfs_fs=
_info *fs_info,
>                 BUG_ON(!btrfs_block_group_done(block_group));
>                 ret =3D btrfs_remove_free_space(block_group, start, num_b=
ytes);
>         } else {
> +               /*
> +                * We must wait for v1 caching to finish, otherwise we ma=
y not
> +                * remove our space.
> +                */
> +               btrfs_wait_space_cache_v1_finished(block_group, caching_c=
tl);
>                 mutex_lock(&caching_ctl->mutex);
>
>                 if (start >=3D caching_ctl->progress) {
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
