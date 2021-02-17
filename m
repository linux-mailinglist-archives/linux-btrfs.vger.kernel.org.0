Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329DE31D7C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 11:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBQK53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 05:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhBQK5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 05:57:25 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C4C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 02:56:44 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c1so9199380qtc.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 02:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=T4dJ/zrRFNATwmOBPdDPaq6GXkijKom8VjTpLys/UIo=;
        b=GMLo43KbIV0zXDEGQtCo1ZSrtSI4/kYQPbqP0rUnVOsp+3EANMhTF1DjVTb5DlU7pA
         yYuS+SrGVoEN+Vehb58sP8voNO1DHviLsc/V9ReSbJo3MaH8aeiNzPpeJORhj5vc+b0E
         uesk5a2fQMwB5/Gx3mM61TeSbLyLiRv4wKDl1cBUmajH0tsI9lDWJ+M5h1fQ8CI7XqFe
         X4C4e1Gfv9QwFzyyu7HSSF+t9IJh7rPsYSS88yicVPyXJgHDdINdQUU2d83r+DmfH5w8
         1/HZtema4I3TIL+J9T7gX9BWAfzCB02xtnw4QHOtP5Gn3BsA2uJ1yKl3dzVuacecmP9C
         gfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=T4dJ/zrRFNATwmOBPdDPaq6GXkijKom8VjTpLys/UIo=;
        b=rRdcQk+OeCiU7XvJS7paQt/0bIbNB5Mq/cXVSi/icIUSQfRUT8NClEvoaTZnZh/fco
         VXhYsurywoKZ+++m6RScLRJMKbqfzggzOZzl+Po7xua6Yu0a9eSiwuLc82/uw2fydm5E
         fXq98PWAnyL8Disb91pWcCtFuzJwwIoXEQAjX6FirRQTC4mn3BMHFeP0Pp8yyISSD/0x
         ZlhK57ga5rCgIE8xm5LDCLHBMNYKkKG1AklmCgeuyWkbF585b2FIxxuBb5y4a70l3ye8
         9WDd2PYS9mFxkh8jBElfcJsTsbtpUk83AQt0TI8K4Ud/bz76aG3zb3MXCYjCs2y2xgD5
         2nqg==
X-Gm-Message-State: AOAM533mhf8XY+z861622/iXptMxJh549+LkjIBvqtU3fF/XI4thCRD6
        XhDnVwbyOm2fV/WfuMnkMLbDbFaprvSKfs1kqvM=
X-Google-Smtp-Source: ABdhPJxNY/HTiAEebdfqn4nyu8BaneDs129kAwGgE3ljfoX4KkZIe9dbTKr/v7WJTMQ9cjDcxF5mxXV3SiKZcOxdPPc=
X-Received: by 2002:aed:3407:: with SMTP id w7mr22833960qtd.213.1613559403758;
 Wed, 17 Feb 2021 02:56:43 -0800 (PST)
MIME-Version: 1.0
References: <c801971bb6f1318ae71440504d8631333b7dddc7.1613508186.git.josef@toxicpanda.com>
In-Reply-To: <c801971bb6f1318ae71440504d8631333b7dddc7.1613508186.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Feb 2021 10:56:32 +0000
Message-ID: <CAL3q7H4Yk5EgACKxetq+8Hf4nQeigRkvWrOwyoWOTPgCBYXn5Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not error out if the extent ref hash doesn't match
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        =?UTF-8?Q?Tuomas_L=C3=A4hdekorpi?= <tuomas.lahdekorpi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 8:46 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> The tree checker checks the extent ref hash at read and write time to
> make sure we do not corrupt the file system.  Generally extent
> references go inline, but if we have enough of them we need to make an
> item, which looks like
>
> key.objectid    =3D <bytenr>
> key.type        =3D <BTRFS_EXTENT_DATA_REF_KEY|BTRFS_TREE_BLOCK_REF_KEY>
> key.offset      =3D hash(tree, owner, offset)
>
> However if key.offset collide with an unrelated extent reference we'll
> simply key.offset++ until we get something that doesn't collide.
> Obviously this doesn't match at tree checker time, and thus we error
> while writing out the transaction.  This is relatively easy to
> reproduce, simply do something like the following
>
> xfs_io -f -c "pwrite 0 1M" file
> offset=3D2
>
> for i in {0..10000}
> do
>         xfs_io -c "reflink file 0 ${offset}M 1M" file
>         offset=3D$(( offset + 2 ))
> done
>
> xfs_io -c "reflink file 0 17999258914816 1M" file
> xfs_io -c "reflink file 0 35998517829632 1M" file
> xfs_io -c "reflink file 0 53752752058368 1M" file
>
> btrfs filesystem sync
>
> And the sync will error out because we'll abort the transaction.  The
> magic values above are used because they generate hash collisions with
> the first file in the main subvol.
>
> The fix for this is to remove the hash value check from tree checker, as
> we have no idea which offset ours should belong to.
>
> Reported-by: Tuomas L=C3=A4hdekorpi <tuomas.lahdekorpi@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tree-checker.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 582061c7b547..2429d668db46 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1453,22 +1453,10 @@ static int check_extent_data_ref(struct extent_bu=
ffer *leaf,
>                 return -EUCLEAN;
>         }
>         for (; ptr < end; ptr +=3D sizeof(*dref)) {
> -               u64 root_objectid;
> -               u64 owner;
>                 u64 offset;
> -               u64 hash;
>
>                 dref =3D (struct btrfs_extent_data_ref *)ptr;
> -               root_objectid =3D btrfs_extent_data_ref_root(leaf, dref);
> -               owner =3D btrfs_extent_data_ref_objectid(leaf, dref);
>                 offset =3D btrfs_extent_data_ref_offset(leaf, dref);
> -               hash =3D hash_extent_data_ref(root_objectid, owner, offse=
t);
> -               if (unlikely(hash !=3D key->offset)) {
> -                       extent_err(leaf, slot,
> -       "invalid extent data ref hash, item has 0x%016llx key has 0x%016l=
lx",
> -                                  hash, key->offset);
> -                       return -EUCLEAN;
> -               }
>                 if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsiz=
e))) {
>                         extent_err(leaf, slot,
>         "invalid extent data backref offset, have %llu expect aligned to =
%u",
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
