Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9AC36F9D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhD3MPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 08:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhD3MPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 08:15:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13611C06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Apr 2021 05:14:26 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id q5so128438qvv.6
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Apr 2021 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=n8ft2E3GeQ4fxV0gQVT9//eM0lyB6QMKvBx3GXlEI6M=;
        b=VMERLq3WFHXNvh74qLkdhjBvi5Y4NqxJd5+J1bnR0WE2opDuQnWZQfeTweoGO31Bky
         U6dvMsvigYU9EmIkqwsDNABXATh3SwJlN+rSVf8cFp8UAwihlyH3MeZhLxJ7biZ7Lnaa
         goSfati6ksLDnh59XismsdQTVJCrE6Yb9WwV1i4K4Odvw3biO/XehTgwjmo2ZY3s15qU
         pg2qYS8q7bwbhnKBP/Q3PUXo/bQMYG+o6x9DETzvLRFKnSN9JAPf/NnW3PzPT23ueQZs
         uazOD1HPpf3Ta7z842ql0zv7dYBnBRNYjtWmiyM8dcQdttwzV/xcjJFafpsC/R3PI4hs
         1V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=n8ft2E3GeQ4fxV0gQVT9//eM0lyB6QMKvBx3GXlEI6M=;
        b=IkTjbbf3fY69XGnlpRlu7n0SXTB9TTakcExUYv8jnlMILG2tLPuLw6HuQLfASvIouP
         DBp0q9C+d9YNMynGSAgkx7H3bWNo85tqZjn+Rm/vMM73ZZmO3ULDvzxwpGEVedRBJvrb
         81Z/SPtTYVhFmBwKd/6AnQQutWOCzOtqlK5mpVpS7l/Fb6Uc4zek9HZOiNLddbjjeMV0
         QApb+w8RJxAEbTz/h+oq95500/DrBU5/xTdgSKLdn93/SM1xj9QPd4GQXI1+WsXuEh62
         ZQk9OJVGsjoqu/IQtCwlO47IcWauxXxr/OCoDJId3J+XxddyxjSoVyGPBV+FA/nvQ6pV
         9xSg==
X-Gm-Message-State: AOAM531rJRJqaDrftoDnIdNg2D6HVaAxF6Bi2F2+yTRfiOkzyFa1yNck
        UXWPGrYm0uYXqc2mo6AoXQcfkMFj9TubKr4uavhZRAql+NA=
X-Google-Smtp-Source: ABdhPJwsqCuqeLzt0vBR7IxSV2BlshAxnVgd+dUw7BQbRcu89h8gdorNy515/xcG25kFQROnJTEGuncJr+uLrdDbPFY=
X-Received: by 2002:a0c:a1c2:: with SMTP id e60mr5331652qva.41.1619784865198;
 Fri, 30 Apr 2021 05:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <c7715d09a67f212e0ecb5fea2d598513912092f4.1619443900.git.anand.jain@oracle.com>
 <d6fcae756c5ce47da3527e5db4760d676420d950.1619783910.git.anand.jain@oracle.com>
In-Reply-To: <d6fcae756c5ce47da3527e5db4760d676420d950.1619783910.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 30 Apr 2021 13:14:14 +0100
Message-ID: <CAL3q7H4Nt6Z5B5ZtqFgjR-=hDH+RhZe0XrWE27zvFpq90VNpMQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix unmountable seed device after fstrim
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 30, 2021 at 1:03 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> The following test case reproduces an issue of wrongly freeing in-use
> blocks on the readonly seed device when fstrim is called on the rw sprout
> device. As shown below.
>
> Create a seed device and add a sprout device to it:
>         $ mkfs.btrfs -fq -dsingle -msingle /dev/loop0

An example of making things easier to the eye here, is adding a blank
line before the mkfs line.
The same applies to all the other similar places below.

>         $ btrfstune -S 1 /dev/loop0
>         $ mount /dev/loop0 /btrfs
>         $ btrfs dev add -f /dev/loop1 /btrfs
>         BTRFS info (device loop0): relocating block group 290455552 flags=
 system
>         BTRFS info (device loop0): relocating block group 1048576 flags s=
ystem
>         BTRFS info (device loop0): disk added /dev/loop1
>         $ umount /btrfs
>
> Mount the sprout device and run fstrim:
>         $ mount /dev/loop1 /btrfs
>         $ fstrim /btrfs
>         $ umount /btrfs
>
> Now try to mount the seed device, and it fails:
>         $ mount /dev/loop0 /btrfs
>         mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/=
loop0, missing codepage or helper program, or other error.
>
> Block 5292032 is missing on the readonly seed device.

Colon ":" instead of ".", plus blank line.

>         $ dmesg -kt | tail
>         <snip>
>         BTRFS error (device loop0): bad tree block start, want 5292032 ha=
ve 0
>         BTRFS warning (device loop0): couldn't read-tree root
>         BTRFS error (device loop0): open_ctree failed
>
> From the dump-tree of the seed device (taken before the fstrim). Block
> 5292032 belonged to the block group starting at 5242880

Missing colon and blank line too.

>         $ btrfs inspect dump-tree -e /dev/loop0 | grep -A1 BLOCK_GROUP
>         <snip>
>         item 3 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16169 items=
ize 24
>                 block group used 114688 chunk_objectid 256 flags METADATA
>         <snip>
>
> From the dump-tree of the sprout device (taken before the fstrim).
> fstrim(8) used block-group 5242880 to find the related free space to free=
.

Colon ":" and not ".", plus blank line.

>         $ btrfs inspect dump-tree -e /dev/loop1 | grep -A1 BLOCK_GROUP
>         <snip>
>         item 1 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16226 items=
ize 24
>                 block group used 32768 chunk_objectid 256 flags METADATA
>         <snip>
>
> Bpf kernel tracing the fstrim(8) command finds the missing block 5292032
> within the range of the discarded blocks as below.

Same as before.

>         kprobe:btrfs_discard_extent {
>                 printf("freeing start %llu end %llu num_bytes %llu:\n",
>                         arg1, arg1+arg2, arg2);
>         }
>
>         freeing start 5259264 end 5406720 num_bytes 147456
>         <snip>
>
> Fix this by avoiding the discard command to the readonly seed device.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: Chris Murphy <lists@colorremedies.com>

The fix looks good. Don't feel forced to address the style comments
above, consider them more a recommendation for the future.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/extent-tree.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 7a28314189b4..f1d15b68994a 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1340,12 +1340,16 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs=
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
> +                       if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device-=
>dev_state))
> +                               continue;
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
