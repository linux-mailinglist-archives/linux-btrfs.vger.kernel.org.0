Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D276E234213
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbgGaJKR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbgGaJKQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 05:10:16 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C5DC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 02:10:16 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id o25so9503017uar.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=cX0Ij3u/yjB9cTRyLoSruu3d+kLLNj/y9TkwWQXtoUg=;
        b=ck99eadjOpSRNC6f7N4gNuNM9gtTo6MJR6+LbgqrSe7sUKMoewg+vbnMGSAB+izhTo
         29KRtSxVr3Nfu73h4JS04txTzk8sBiU3zjYBnBlUef26WZKu1/05+hKp+EHLq6aej4m4
         n+jInBIWIt80hF6hE4zq1k+8LjHvQhvbL+WqkXpNs0r5S3Tfc3yRjYyqqxk9W76GVuDC
         wqHXU0iLXIuzvTmJFuVuEAEFFCJsag4DAo0B7b7JHlOdxoXNct1+crVIo6fuxu+sAYoW
         aPaX7bboGsx+LSahmAHwIPIcFOd/fBvQQa5oXw5mFavDFVG4y2+TvNEryTCkQbJ94x3k
         e+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=cX0Ij3u/yjB9cTRyLoSruu3d+kLLNj/y9TkwWQXtoUg=;
        b=VBSn9aii6rorevBzkDrFKDgtkG1igzenqd0Ac54YQ8ijmP09hMnu701tbAEwPUNrJ9
         H7BEYKiespPTIaM8aZSt7bZJIUvPtIlr2joNcbsob+sl0+zn92Bqgt078mPHzgeyZAf3
         la/rOqqBreT2Pm3wYnMQaA6Hnak4Kd9AuUIy5988zqxA7VJvuUvjPuOTco8oKHV9MxRi
         zpM53Ryg2i2MC1zPJ9Ekam1GJmSnhoMG3Zk/3l3nW4oxhpUwk5+m/l0Mt6n4USLJRr1T
         eN6S6v40uraVU7YYKPQ7D76ubQUPiByA3oJA97mDp3sT3+W6ruCDNRLnxAzASHMmpT1w
         gZFQ==
X-Gm-Message-State: AOAM531CJuh3GBU5G70N+EoKRWHHc/2Ct4CD5pKlZDSimyIo/ttDtPwY
        exFYnIKPW/vgytSdm+RRniT+/Ozq7mVizO2p2beRag==
X-Google-Smtp-Source: ABdhPJzMCYw8Mcll1qKB1FLiTf7IcVDxs4gF9h3EUBJcCNYQ7btRkTrYIl+ZXXeFzLCAiJS4gUYJmT71480ikg3xPDM=
X-Received: by 2002:ab0:76d2:: with SMTP id w18mr1854476uaq.27.1596186615704;
 Fri, 31 Jul 2020 02:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200731072258.85861-1-wqu@suse.com>
In-Reply-To: <20200731072258.85861-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 31 Jul 2020 10:10:03 +0100
Message-ID: <CAL3q7H5r9CSbsTTPgstaYEFzo9PE40H2ZC4a7_Wf3BQB_Q+9Ow@mail.gmail.com>
Subject: Re: [PATCH] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 31, 2020 at 8:24 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> The following script can lead to tons of beyond device boundary access:
>
>   mkfs.btrfs -f $dev -b 10G
>   mount $dev $mnt
>   trimfs $mnt
>   btrfs filesystem resize 1:-1G $mnt
>   trimfs $mnt
>
> [CAUSE]
> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
> already trimmed.
>
> So we check device->alloc_state by finding the first range which doesn't
> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
>
> But if we shrunk the device, that bits are not cleared, thus we could
> easily got a range starts beyond the shrunk device size.
>
> This results the returned @start and @end are all beyond device size,
> then we call "end =3D min(end, device->total_bytes -1);" making @end
> smaller than device size.
>
> Then finally we goes "len =3D end - start + 1", totally underflow the
> result, and lead to the beyond-device-boundary access.
>
> [FIX]
> This patch will fix the problem in two ways:
> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>   This is the root fix
>
> - Add extra safe net when trimming free device extents
>   We check and warn if the returned range is already beyond current
>   device.
>
> Link: https://github.com/kdave/btrfs-progs/issues/282
> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_first=
_clear_extent_bit")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
> Changelog:
> v2:
> - Add proper fixes tag
> - Add extra warning for beyond device end case
> - Add graceful exit for already trimmed case
> ---
>  fs/btrfs/extent-tree.c | 18 ++++++++++++++++++
>  fs/btrfs/volumes.c     | 12 ++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index fa7d83051587..84ec24506fc1 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5669,6 +5669,24 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>                                             &start, &end,
>                                             CHUNK_TRIMMED | CHUNK_ALLOCAT=
ED);
>
> +               /* CHUNK_* bits not cleared properly */
> +               if (start > device->total_bytes) {
> +                       WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +                       btrfs_err(fs_info,
> +               "alloc_state not cleared properly for shrink, devid %llu"=
,
> +                                 device->devid);

Hum, I find the message a bit cryptic: referring to the name of
attributes of structures, like alloc_state is not very user friendly.
Plus this message is assuming all possible current and future bugs of
attempts to trim beyond the device size are caused by a past shrink
operation.
I'm pretty sure we had such bugs in the past due to other causes.

How about something like:

btrfs_warn("ignoring attempt to trim beyond device size: offset %llu
length %llu device %s device size %llu")

I find it a lot more helpful for both users and developers.

> +                       mutex_unlock(&fs_info->chunk_mutex);
> +                       ret =3D -EUCLEAN;
> +                       break;

I don't see a reason to return an error. Especially EUCLEAN since
nothing is really corrupted on disk.

Thanks.

> +               }
> +
> +               /* The remaining part has already been trimmed */
> +               if (start =3D=3D device->total_bytes) {
> +                       mutex_unlock(&fs_info->chunk_mutex);
> +                       ret =3D 0;
> +                       break;
> +               }
> +
>                 /* Ensure we skip the reserved area in the first 1M */
>                 start =3D max_t(u64, start, SZ_1M);
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d7670e2a9f39..4e51ef68ea72 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *devic=
e, u64 new_size)
>         }
>
>         mutex_lock(&fs_info->chunk_mutex);
> +       /*
> +        * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond t=
he
> +        * current device boundary.
> +        * This shouldn't fail, as alloc_state should only utilize those =
two
> +        * bits, thus we shouldn't alloc new memory for clearing the stat=
us.
> +        *
> +        * So here we just do an ASSERT() to catch future behavior change=
.
> +        */
> +       ret =3D clear_extent_bits(&device->alloc_state, new_size, (u64)-1=
,
> +                               CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +       ASSERT(!ret);
> +
>         btrfs_device_set_disk_total_bytes(device, new_size);
>         if (list_empty(&device->post_commit_list))
>                 list_add_tail(&device->post_commit_list,
> --
> 2.28.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
