Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA031CC51
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBPOqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 09:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhBPOqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 09:46:49 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C8C06178A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 06:46:04 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id f17so9577849qkl.5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 06:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=gr/aiBrV0gs5GqXfKgOv2X1jpB1MplezztrS6AZfNxs=;
        b=qoc9hHh0pbHfb0+xuFQSo+wzGpj0xqho4gwCeT3qZCBPl7qkAwUR6wCGNRayu9i0R9
         CX2+LCsxUaK/Z7nhMSRuF01fXWz2LNv+KJavOB3Upi0AX+nOcMMMVRfB+qavZA7Z68f0
         DpHPzcAbn10AO5Hzng6HAb3g3x+puKlw+W/H6AVtVuJBFy6NKuRqoSWTr3QXo6az5aok
         Uk31ClHN01mmDwAUm9DIvHOqRnDYudrFUpLpGjwzTHjSkOiy5U1epnE+CbTfVNNNRY2R
         JVqgc7QNMemc5mrHK/1h4ZTwlwOOt71QEV7+Eh8uj1uQziPu2WLRKxiwI/lxz/7f/NWo
         MTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=gr/aiBrV0gs5GqXfKgOv2X1jpB1MplezztrS6AZfNxs=;
        b=E6r4Jy2anaZbUyBHcxmvCFXXsQj3czlOACOk1u36UWTU2pobFuuTIQ/IFVU8rUXl1O
         fEIHXQzHRbLUPaUfBUCIH/kyMmkeorvjcj5fjjUisiTfcQqoXO6zokbbELKPhDqpiDl4
         0P+w29jPW947pQ9eF1v28xWlF3CSnic4/Mp84w2KuXMg2WADOdT874o4oe/FnSiw9dfu
         QV6ggLPguPdOUOy+B6RjkyZh+sjD4Gt0RUkB8ybPOxuMlONtpulwgIYwt7MAJHCgTowI
         rzJRnu7pYwqp0rsXvtAaEKkPfo+dlOu6+dwusblaXwrUc460aGw02VU7LGh1FKrueuIB
         EMJg==
X-Gm-Message-State: AOAM53218PxGlXzMkDj8ZiBmvLXZB+Co65NEMwiLzDw6RsUyql8hOWDa
        iVurseqeeKrKbBwMJhzfz+2V26wh3vOGc+q+aPcYUjamZAVVKg==
X-Google-Smtp-Source: ABdhPJzmq9q/xmGUgqEUgu06z62i7T9yRMRKr2xwo70mD9fGoCIARDQv41dzjyk8nSXtVXSiRGFHSf3hckhKsoNVkdA=
X-Received: by 2002:a05:620a:118e:: with SMTP id b14mr20439569qkk.438.1613486763842;
 Tue, 16 Feb 2021 06:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20200624115527.855816-1-wqu@suse.com>
In-Reply-To: <20200624115527.855816-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 16 Feb 2021 14:45:52 +0000
Message-ID: <CAL3q7H5sgq_vXpP5rB+bBOBNqaq1+AszGLZvfdgdMLDruQZ4_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Ensure the data chunks size
 never exceed device size
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Jiachen YANG <farseerfc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 24, 2020 at 10:00 PM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> The following script could lead to corrupted btrfs fs after
> btrfs-convert:
>
>   fallocate -l 1G test.img
>   mkfs.ext4 test.img
>   mount test.img $mnt
>   fallocate -l 200m $mnt/file1
>   fallocate -l 200m $mnt/file2
>   fallocate -l 200m $mnt/file3
>   fallocate -l 200m $mnt/file4
>   fallocate -l 205m $mnt/file1
>   fallocate -l 205m $mnt/file2
>   fallocate -l 205m $mnt/file3
>   fallocate -l 205m $mnt/file4
>   umount $mnt
>   btrfs-convert test.img
>
> The result btrfs will have a device extent beyond its boundary:
>   pening filesystem to check...
>   Checking filesystem on test.img
>   UUID: bbcd7399-fd5b-41a7-81ae-d48bc6935e43
>   [1/7] checking root items
>   [2/7] checking extents
>   ERROR: dev extent devid 1 physical offset 993198080 len 85786624 is bey=
ond device boundary 1073741824
>   ERROR: errors found in extent allocation tree or chunk allocation
>   [3/7] checking free space cache
>   [4/7] checking fs roots
>   [5/7] checking only csums items (without verifying data)
>   [6/7] checking root refs
>   [7/7] checking quota groups skipped (not enabled on this FS)
>   found 913960960 bytes used, error(s) found
>   total csum bytes: 891500
>   total tree bytes: 1064960
>   total fs tree bytes: 49152
>   total extent tree bytes: 16384
>   btree space waste bytes: 144885
>   file data blocks allocated: 2129063936
>    referenced 1772728320
>
> [CAUSE]
> Btrfs-convert first collect all used blocks in the original fs, then
> slightly enlarge the used blocks range as new btrfs data chunks.
>
> However the enlarge part has a problem, that it doesn't take the device
> boundary into consideration.
>
> Thus it caused device extents and data chunks to go beyond device
> boundary.
>
> [FIX]
> Just to extra check before inserting data chunks into
> btrfs_convert_context::data_chunk.
>
> Reported-by: Jiachen YANG <farseerfc@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

So, having upgraded a test box from btrfs-progs v5.6.1 to v5.10.1, I
now have btrfs/136 (fstests) failing:

$ ./check btrfs/136
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian8 5.11.0-rc7-btrfs-next-81 #1 SMP
PREEMPT Tue Feb 16 12:29:07 WET 2021
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/136 7s ... [failed, exit status 1]- output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/136.out.bad)
    --- tests/btrfs/136.out 2020-06-10 19:29:03.818519162 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/136.out.bad
2021-02-16 14:31:30.669559188 +0000
    @@ -1,2 +1,3 @@
     QA output created by 136
    -Silence is golden
    +btrfs-convert failed
    +(see /home/fdmanana/git/hub/xfstests/results//btrfs/136.full for detai=
ls)
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/136.out
/home/fdmanana/git/hub/xfstests/results//btrfs/136.out.bad'  to see
the entire diff)
Ran: btrfs/136
Failures: btrfs/136
Failed 1 of 1 tests

A bisect pointed to this patch.
Did you get this failure on your test box as well?

Thanks.

> ---
>  convert/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/convert/main.c b/convert/main.c
> index c86ddd988c63..7709e9a6c085 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -669,6 +669,8 @@ static int calculate_available_space(struct btrfs_con=
vert_context *cctx)
>                         cur_off =3D cache->start;
>                 cur_len =3D max(cache->start + cache->size - cur_off,
>                               min_stripe_size);
> +               /* data chunks should never exceed device boundary */
> +               cur_len =3D min(cctx->total_bytes - cur_off, cur_len);
>                 ret =3D add_merge_cache_extent(data_chunks, cur_off, cur_=
len);
>                 if (ret < 0)
>                         goto out;
> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
