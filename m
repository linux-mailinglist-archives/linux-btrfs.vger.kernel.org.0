Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A892343E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbgGaKF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732162AbgGaKF6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 06:05:58 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F421C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 03:05:58 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g4so9532891uaq.10
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tFlCKCm99DNn6ELBn3Id8FsI6UR+OZ8uQtq0u5EBjyM=;
        b=O+uQczdwUvywFS2NuCeTDYJ4Mz/jMoeYdzRILw3H4pCB04gkgmmkdEWdRnB9mPVpXE
         JI8jgO0ktcp2zB9bmuwG21/+GghnEvAic7hE9y2RH043/miEnq/tWrev1E/BrsuSr8uw
         4RS2ly89cqP6sZCYKUpNKW1DhN6HEFk1BWdWdyGhUpwr/y+Ic+yosj08Tpp8qFsJSNZc
         MFmiRi2JUyd2RGJU5ulNA8g3pzmyb2Dj1x9JNd5fhNAQDNfZf0EBqVED0IXSUtcMJ+3V
         sNNy+627fEv1z2tggae8usMBUWvZD7/z2UjJ+PakaLb1AjuLPCp+1JvUq7++GzF9BIwm
         IG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tFlCKCm99DNn6ELBn3Id8FsI6UR+OZ8uQtq0u5EBjyM=;
        b=JS/wKaWdanZ3tE+IQnsKEmfK8i/2IVx8uodWFiAQwa542j18eP8NKMfWrnOZMXYSak
         JGINabzwZiA57cjAaQH4MDOaVD9HImcblcPLt7M4PVYV9TKdks1gY17yUAF4YpEKATlR
         8W8gl2xett2cCvK/Qkn3fAS16omd9RXQ5IxFbpwrc+DNQhN0kR1Cu8YzhyDM0Zi88yF1
         q5/ANpZCV5G9XtuKmX/j3FL2Hl1ogdSBS9xzALcPYplyuTmuwTCTh724qNNsPCjO4/lM
         Bk+4PXsXokuUNvRZbdXa9eNWhuoy4y/oVAfhOClS4vkKhLpty6MhQe7vO9ov4U5f5Wnv
         NDIw==
X-Gm-Message-State: AOAM530sXvzBL+sj2lW1WtYWYsUkGYB3WoGYQv68O+/hlGYMhDrrN698
        nW8paHYUMsd+A1mik+Ow3ZWkaNmuaZ9hDpzrS0Q=
X-Google-Smtp-Source: ABdhPJwAOtG0gac8uaSqS+zPDofPJN2adVqeOEVSsRUyqPjh8xZoIPczc+4sDrvnDh/jE75F3e3tdblxxWj2EkjzC+M=
X-Received: by 2002:ab0:76d2:: with SMTP id w18mr1967600uaq.27.1596189957685;
 Fri, 31 Jul 2020 03:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200731094815.104794-1-wqu@suse.com>
In-Reply-To: <20200731094815.104794-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 31 Jul 2020 11:05:46 +0100
Message-ID: <CAL3q7H5NAJPs=mbuwSh3c+y5GR2+sMBiAEPcC8=P5__82LXziw@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: trim: fix underflow in trim length to prevent
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

On Fri, Jul 31, 2020 at 10:49 AM Qu Wenruo <wqu@suse.com> wrote:
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
> v3:
> - Don't return EUCLEAN for beyond boundary access
> - Rephrase the warning message for beyond boundary access
> ---
>  fs/btrfs/extent-tree.c | 21 +++++++++++++++++++++
>  fs/btrfs/volumes.c     | 12 ++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index fa7d83051587..7c5e0961c93b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -33,6 +33,7 @@
>  #include "delalloc-space.h"
>  #include "block-group.h"
>  #include "discard.h"
> +#include "rcu-string.h"
>
>  #undef SCRAMBLE_DELAYED_REFS
>
> @@ -5669,6 +5670,26 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>                                             &start, &end,
>                                             CHUNK_TRIMMED | CHUNK_ALLOCAT=
ED);
>
> +               /* CHUNK_* bits not cleared properly */
> +               if (start > device->total_bytes) {
> +                       WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +                       btrfs_warn_in_rcu(fs_info,
> +"ignoring attempt to trim beyond device size: offset %llu length %llu de=
vice %s device size %llu",
> +                                         start, end - start + 1,
> +                                         rcu_str_deref(device->name),
> +                                         device->total_bytes);
> +                       mutex_unlock(&fs_info->chunk_mutex);
> +                       ret =3D 0;
> +                       break;
> +               }
> +
> +               /* The remaining part has already been trimmed */
> +               if (start =3D=3D device->total_bytes) {
> +                       mutex_unlock(&fs_info->chunk_mutex);
> +                       ret =3D 0;
> +                       break;
> +               }

Sorry I missed this earlier, but why is this a special case? Couldn't
this be merged into the previous check?
Why is an offset matching the ending of the device not considered unexpecte=
d?

I also don't understand the comment, what is the remaining part?

Thanks.

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
