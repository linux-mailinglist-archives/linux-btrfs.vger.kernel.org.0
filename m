Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19830233735
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgG3Qy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3Qy6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 12:54:58 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274E9C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 09:54:58 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id n4so8870452uae.5
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=eFOYuffVswEcvmS6zesK6U3jhcBqb6bznqrB7YqJ8/4=;
        b=WAlsrb/QV9MrHqG6+fMaqtKvh+Kpf5mPBjKKMO5DSbpFXBchHRqV8z7QSAnaSs8XM3
         ksypZonJZ34qYh8k/JtlIrMCH9xsStwAOVrUXYoSN8MsqpiIlnkiuOnmuTVVDSyGxgDn
         bP9tWWstqUEDe1U5FMKVIlpNVn1vG1AlxhhbgDkmgzEQJYSy5t54G4SnkR7c42Pod+iC
         R8hcbrD4brlQ0we90oE/S3CLMfHc4odyT9LgBzV3JiNup+K5poPCMN7WVmOhdgsokZr4
         b+lm86QLshl8oC5O9sEHiI459FU6q6wHAd/RIYGW4YP7leJ5xMgPtk3U/E799zW8+d7U
         Ki/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=eFOYuffVswEcvmS6zesK6U3jhcBqb6bznqrB7YqJ8/4=;
        b=KZ4233Wz+xxm+rSr4jajINgnwRQeJFlDOUBZU1d4jJ0uE2PCnIVvcpk9edko7Deyxe
         XaGz/3/6Jt9pRCQOtUh4huxRZcAAE9Lqd4YP+lIwLDegZwHkLITnR/SccafkJKyBCUwg
         pBAeriMJjpejxMWgLHD/nJxmFp+VRRIIKptzuhUROpq99im4lel0bIonA7eKevZTkoHR
         sfJGe5XghJsm4m2msw5cuLUiMkgASVF2BKJ+H40EnDsx4lrb56iN6vBKLpZTHp/apEve
         AEuZpeHofgklKIWLXCTgcHAWjPhLxF8/XajvmHnMuMd1LOw8QFROOsqtFnM1+zwhnTYz
         3sEg==
X-Gm-Message-State: AOAM530YEnaqIWSsX2dOoohYSWXPB2GlKWMux7rK0ApG98gtn76ujpPE
        T5NEk9YcS60o+XGVeQqT/KfO6Ihh2XlRqMYu5TqT5A==
X-Google-Smtp-Source: ABdhPJwFGrfCoTPAv7FJnOhh+Cg+uYpD31bcx8wp3YUhsWzAq9pQ0loD8/qMMCLUsOdZ38+d5h9uDphnqEKxyY3rjzs=
X-Received: by 2002:ab0:22c9:: with SMTP id z9mr2895003uam.0.1596128097025;
 Thu, 30 Jul 2020 09:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200730111921.60051-1-wqu@suse.com>
In-Reply-To: <20200730111921.60051-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Jul 2020 17:54:46 +0100
Message-ID: <CAL3q7H6LofjW9GozPR6_ds8YHZpLKOCF790XiSQ1aqWqsam+WA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 30, 2020 at 12:20 PM Qu Wenruo <wqu@suse.com> wrote:
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
>   We check if the returned range is already beyond current device
>   boundary.
>
> Link: https://github.com/kdave/btrfs-progs/issues/282
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c |  5 +++++
>  fs/btrfs/volumes.c     | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 61ede335f6c3..758f963feb96 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5667,6 +5667,11 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>                 find_first_clear_extent_bit(&device->alloc_state, start,
>                                             &start, &end,
>                                             CHUNK_TRIMMED | CHUNK_ALLOCAT=
ED);
> +               if (start >=3D device->total_bytes) {
> +                       mutex_unlock(&fs_info->chunk_mutex);
> +                       ret =3D 0;
> +                       break;
> +               }

It's good to ensure we never trim beyond the end of the fs, to avoid
corruption of whatever lies beyond it.
However we should have at least a WARN_ON / WARN_ON_ONCE here to help
more easily detect other current or future bugs that lead to the same
type of issue.

Other than that it looks good to me.
After that you can have,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
>                 /* Ensure we skip the reserved area in the first 1M */
>                 start =3D max_t(u64, start, SZ_1M);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 537ccf66ee20..906704c61a51 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4705,6 +4705,18 @@ int btrfs_shrink_device(struct btrfs_device *devic=
e, u64 new_size)
>         }
>
>         mutex_lock(&fs_info->chunk_mutex);
> +       /*
> +        * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond t=
he
> +        * current device boundary.
> +        */
> +       ret =3D clear_extent_bits(&device->alloc_state, new_size, (u64)-1=
,
> +                               CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +       if (ret < 0) {
> +               mutex_unlock(&fs_info->chunk_mutex);
> +               btrfs_abort_transaction(trans, ret);
> +               btrfs_end_transaction(trans);
> +               goto done;
> +       }
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
