Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B585436F854
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 12:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhD3KMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3KMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 06:12:50 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28954C06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Apr 2021 03:12:02 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u1so2465993qvg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Apr 2021 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jPITMoCJ7ZId/C35qFwZ51utXaE/QEzbToOTYv47T2Y=;
        b=tzPDPlsHg6F2UNVZ+ytTOAA0Jm3bND5SZl2LIfGeeNA0fi8rJwHw8+NjW8sSuRfW27
         dKUSKQxA+6DMnDBcDq5QIqBA1WeKZId3O1IXmcbLWmS93cI0bB2+JumfVZ1ruFqkjF4D
         IyDQLrl34Bh+WgGzxOY3jylWoGjGuVfLHbAFYff6C6JSZwU7XwzzKEH72qJgtblp0M6d
         Zic8IlRTj4eqk3q0bbHL5vj80WAPKxe/g/032fkQ48lKmD1/gduNixIeyduoYIZhwoa2
         JzfkFtUiztY9x+m+BRd+4k0UKbraxYKlMh/0BDTFEn4fzCwUPdKWYErkQqPT3eZ3IjU8
         9PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jPITMoCJ7ZId/C35qFwZ51utXaE/QEzbToOTYv47T2Y=;
        b=sNThL9WIU34iLhtgd0bqep3DU2WZZd9gShFBrFjmYYjeNkQYrbbRZzKKRQH9NYXNK9
         bbfWlf1EpVoS4QFLpdETl4GQzgK3xC8Okj5Qsroihgz07aa6nlQzgJ8puIp/CiKbRQvN
         LGOQmQ6tiAaYVWc1W25ghBbg7fuUWxEV18QG2AVKxdirlnrsAbFn8zjDI9KVdcpMbrIr
         Tc/LUvpFZs/frlvbLTiknTJEshhUW3dTtJBtsUARZJhiqDodDifcRw3jskRqEEsvyhj1
         vSbY1AmgCv56gryAIdUupkkxD5DCuHElgc02tO9DZ0ANSsK7dsxnBpvsEbdVpAtAiX8r
         u93A==
X-Gm-Message-State: AOAM532OVhWlHIfZp9voiF6XPMm+pQfYZqnL6Wk3b+O5NApckXaAzRXC
        XkF+jakANREtktf4TyqamwJEmbHMox4vNs+kh54=
X-Google-Smtp-Source: ABdhPJxeFu9M9mab+Vc/uq/itT6zAewStYf/LXOwbxxGeBrC+/3ntdnWAM5oF+PY5T/LDAkBi6wVi7t52UuzKJrESY4=
X-Received: by 2002:a0c:a1c2:: with SMTP id e60mr4845451qva.41.1619777521162;
 Fri, 30 Apr 2021 03:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <c7715d09a67f212e0ecb5fea2d598513912092f4.1619443900.git.anand.jain@oracle.com>
In-Reply-To: <c7715d09a67f212e0ecb5fea2d598513912092f4.1619443900.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 30 Apr 2021 11:11:50 +0100
Message-ID: <CAL3q7H5EZFoOCz_WBOwn8vnhFouCrqV1S9pMJ+KpGYbERJZRyg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix unmountable seed device after fstrim
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 30, 2021 at 10:14 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> The following test case reproduces an issue of wrongly freeing the in-use
> block on the readonly seed device when fstrim is called on the rw sprout
> device. As shown below.
>
> create a seed device and add a sprout device to it
>         mkfs.btrfs -fq -dsingle -msingle /dev/loop0
>         btrfstune -S 1 /dev/loop0
>         mount /dev/loop0 /btrfs
>         btrfs dev add -f /dev/loop1 /btrfs
>
>   BTRFS info (device loop0): relocating block group 290455552 flags syste=
m
>   BTRFS info (device loop0): relocating block group 1048576 flags system
>   BTRFS info (device loop0): disk added /dev/loop1
>
>         umount /btrfs
> mount the sprout device and run fstrim
>         mount /dev/loop1 /btrfs
>         fstrim /btrfs
>         umount /btrfs
>
> now try to mount the seed device, and it fails...
>         mount /dev/loop0 /btrfs
>
>   mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/loop0,=
 missing codepage or helper program, or other error.
>
>   BTRFS error (device loop0): bad tree block start, want 5292032 have 0
>   BTRFS warning (device loop0): couldn't read-tree root
>   BTRFS error (device loop0): open_ctree failed
>
> Block 5292032 is missing on the readonly seed device.
>
> From the dump-tree of the seed device taken before the fstrim. Block
> 5292032 belonged to the block group starting at 5242880
>
> <snip>
>  item 3 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16169 itemsize 24
>         block group used 114688 chunk_objectid 256 flags METADATA
> <snip>
>
> From the dump-tree of the sprout device (taken before the fstrim).
> fstrim used the block-group 5242880 to find the free space to free.
>
> <snip>
>
>  item 1 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16226 itemsize 24
>         block group used 32768 chunk_objectid 256 flags METADATA
> <snip>
>
>
> bpf tracing the fstrim command finds the missing block 5292032 within the
> range of the discarded blocks...
>
>   kprobe:btrfs_discard_extent {
>     printf("free start %llu end %llu num_bytes %llu\n", arg1, arg1+arg2, =
arg2);
>   }
>
> btrfs_discard_extent(..., start, num_bytes, ...):
>
>  free start 5259264 end 5406720 num_bytes 147456
> <snip>
>
> Fix this by avoiding the discard command to the readonly seed device.

Quite hard to read the changelog.

It could be better organized, indentation is screwed up in many
places, shell command lines should have some prefix like $ or # to
make it clear what is a command and what is the output of a command,
missing full collons at the end of sentences, sentences not starting
with a capital letter, etc.

>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: Chris Murphy <lists@colorremedies.com>
> ---
>
> A xfstests case to follow.
>
>  fs/btrfs/extent-tree.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 7a28314189b4..0d19bd213715 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1340,12 +1340,19 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs=
_info, u64 bytenr,
>                 stripe =3D bbio->stripes;
>                 for (i =3D 0; i < bbio->num_stripes; i++, stripe++) {
>                         u64 bytes;
> +                       struct btrfs_device *device =3D stripe->dev;
>
> -                       if (!stripe->dev->bdev) {
> +                       if (!device->bdev) {
>                                 ASSERT(btrfs_test_opt(fs_info, DEGRADED))=
;
>                                 continue;
>                         }
>
> +                       /*
> +                        * Skip sending discard command to a non-writeabl=
e device.
> +                        */
> +                       if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device-=
>dev_state))
> +                               continue;

With such an obvious and easy to read conditional, the comment is
completely unnecessary, it doesn't add any value.

Other than that, the fix itself looks good.

Thanks.

> +
>                         ret =3D do_discard_extent(stripe, &bytes);
>                         if (!ret) {
>                                 discarded_bytes +=3D bytes;
> --
> 2.29.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
