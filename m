Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3C51FD31
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 14:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiEIMsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiEIMsq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 08:48:46 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F6263DB0
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 05:44:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a76so10578938qkg.12
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=N2togqIHkUP9oT2zxoKLYbhsXqlfLVwPoOoZ61iGXfo=;
        b=WjBx1avFbhJqHX258aCrx+CDE892b3T+vc6SgEqjTq9uDXtQu10MDgsnvBEwBHb6nj
         mbq5Ews0CS4U6WQogOZqCi+u5icpYp9yGx2ZtF4wbz/UWzPa1s/zo/TCv1BZajDj4w7F
         NbI01D0n5NcWz1fe+nyarLQWw9yfW5KbIB1yi995aO5HmpE9NHCERMO183z1N/6loC7p
         3HzhNjpKK3JQfKIuTEInt3SMFpyM6jSp+fP7SWfzslosk8ZJE3QLX8ZGp3/8VP33fprd
         i87hOn3CWle3wGh3Cimd0IP0eTYDV7o9OMOspViXYd6UuVLiyhHZH4z9mV8SmEj4mzVw
         BPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=N2togqIHkUP9oT2zxoKLYbhsXqlfLVwPoOoZ61iGXfo=;
        b=2CqfEHSHUv8U17gukegvQmHbHv10sTmuVNm6JgwZG1SLVWf2F2YoJNSQEGGowYPXJq
         wpv+h1e/VUZMgpGl47bNWZOe+fpQzeRsTuUVlHMDjvN4s2djDr7XCgPfp510Ha0Ob7dq
         nEmS+RhHi6GYJCtMg73el/Pj4fhnK2i8lav5iJUiTMxLeVc5es7paJb5aMSw5kdkxDUA
         x9skV9AxEMA8oOYdYT9lOVbRN1xeENV49EtT7U5pQHbJf+MHQ9SXB7xljhEO4j4FBy6P
         zkUETLCdA2cGStHksac/zjsQn7KD4kc7wKBAv1x2N0NwS4hzhpnMp1OxEzGHLJQKF2Hl
         A+RA==
X-Gm-Message-State: AOAM532bM9Y90kF4GNIUT3AMN3Z0adAgaGxpew5EOVoCCYOwhMjl9E/2
        bHJ3zCRSI8q2mpgqny38N44Hc4ltUUAwM0cDcwegv88V
X-Google-Smtp-Source: ABdhPJyV6tt5IfOYUBK0yZaOsfefvmaHzObyXdC+KmwtzLtxQIsAi+xZDnrV5kCQRy8/vHzWcXisJOiy+lk0EgKu9Bs=
X-Received: by 2002:a05:620a:666:b0:69f:bbd4:b9af with SMTP id
 a6-20020a05620a066600b0069fbbd4b9afmr11202294qkh.11.1652100291069; Mon, 09
 May 2022 05:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <0606709d439b711a767ce1491f51f0113326d265.1652097509.git.wqu@suse.com>
In-Reply-To: <0606709d439b711a767ce1491f51f0113326d265.1652097509.git.wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 May 2022 13:44:15 +0100
Message-ID: <CAL3q7H5Y=EOSqmZcMnHnomUTWYvifS2k=gJFhb=V5w256rLKAw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: allow defrag to convert inline extents to
 regular extents
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 9, 2022 at 1:28 PM Qu Wenruo <wqu@suse.com> wrote:
>
> Btrfs defaults to max_inline=3D2K to make small writes inlined into
> metadata.
>
> The default value is always a win, as even DUP/RAID1/RAID10 doubles the
> metadata usage, it should still cause less physical space used compared
> to a 4K regular extents.
>
> But since the introduce of RAID1C3 and RAID1C4 it's no longer the case,
> users may find inlined extents causing too much space wasted, and want
> to convert those inlined extents back to regular extents.
>
> Unfortunately defrag will unconditionally skip all inline extents, no
> matter if the user is trying to converting them back to regular extents.
>
> So this patch will add a small exception for defrag_collect_targets() to
> allow defragging inline extents, if and only if the inlined extents are
> larger than max_inline, allowing users to convert them to regular ones.
>
> This also allows us to defrag extents like the following:
>
>         item 6 key (257 EXTENT_DATA 0) itemoff 15794 itemsize 69
>                 generation 7 type 0 (inline)
>                 inline extent data size 48 ram_bytes 4096 compression 1 (=
zlib)
>         item 7 key (257 EXTENT_DATA 4096) itemoff 15741 itemsize 53
>                 generation 7 type 1 (regular)
>                 extent data disk byte 13631488 nr 4096
>                 extent data offset 0 nr 16384 ram 16384
>                 extent compression 1 (zlib)
>
> Previously we're unable to do any defrag, since the first extent is
> inlined, and the second one has no extent to merge.
>
> Now we can defrag it to just one single extent, saving 48 bytes metadata
> space.
>
>         item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
>                 generation 8 type 1 (regular)
>                 extent data disk byte 13635584 nr 4096
>                 extent data offset 0 nr 20480 ram 20480
>                 extent compression 1 (zlib)
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Re-phase why we add the inline extent without checking @next_mergeable
>
> - Add some commit message on the new ability to handle mixed inline and
>   regular extents
> ---
>  fs/btrfs/ioctl.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9d8e46815ee4..d5a8f5b7d3a9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1420,8 +1420,19 @@ static int defrag_collect_targets(struct btrfs_ino=
de *inode,
>                 if (!em)
>                         break;
>
> -               /* Skip hole/inline/preallocated extents */
> -               if (em->block_start >=3D EXTENT_MAP_LAST_BYTE ||
> +               /*
> +                * If the file extent is an inlined one, we may still wan=
t to
> +                * defrag it (fallthrough) if it will cause a regular ext=
ent.
> +                * This is for users who want to convert inline extents t=
o
> +                * regular ones through max_inline=3D mount option.
> +                */
> +               if (em->block_start =3D=3D EXTENT_MAP_INLINE &&
> +                   em->len <=3D inode->root->fs_info->max_inline)
> +                       goto next;
> +
> +               /* Skip hole/delalloc/preallocated extents */
> +               if (em->block_start =3D=3D EXTENT_MAP_HOLE ||
> +                   em->block_start =3D=3D EXTENT_MAP_DELALLOC ||
>                     test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>                         goto next;
>
> @@ -1480,6 +1491,15 @@ static int defrag_collect_targets(struct btrfs_ino=
de *inode,
>                 if (em->len >=3D get_extent_max_capacity(em))
>                         goto next;
>
> +               /*
> +                * Normally there is no more extent after an inline one, =
thus

s/there is no more extent/there are no more extents/

It can be fixed when cherry picked.

Looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +                * @next_mergeable will normally be false and not defragg=
ed.
> +                * So if an inline extent passed all above checks, just a=
dd it
> +                * for defrag, and be converted to regular extents.
> +                */
> +               if (em->block_start =3D=3D EXTENT_MAP_INLINE)
> +                       goto add;
> +
>                 next_mergeable =3D defrag_check_next_extent(&inode->vfs_i=
node, em,
>                                                 extent_thresh, newer_than=
, locked);
>                 if (!next_mergeable) {
> --
> 2.36.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
