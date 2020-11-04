Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871982A69AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 17:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgKDQ1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbgKDQ1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:15 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4E4C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:15 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id h12so12609451qtu.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kgzMLykdAJIES0n1Ct7WFEtQUP2oyXoGkt4z2kZoj+c=;
        b=B/w8qcR6aMEhi25bSVmpvhQniCA+nPM6mVwjGON5Jrf5RJKZumLpgEdB6rS4C5ua83
         2+KTqzCV4oQWMxFeg85FJbU/7Z0cUNhZ0z41IGzXuFDFzD0PjCl/83HwvzLL5oL+IU4n
         lBsAwQgzslPOTvDzmtmtg/yZ/KaVFEkd5p82k9xscZaqqqPyFBnPIrAdI/IQWzajRRIG
         yWHYf4rnqX62VktBWh8vdBfe7ZM1y/yLUsjbmb/B3nu6n8Cl+MIYptFvzZAMR/UJzLk2
         LmJ/JbfZwAih57+7L7TaEs4mt/LJ8wYp3zvronNn9jUjFR54tMZWNu3vbh6Axugy4eR1
         +8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kgzMLykdAJIES0n1Ct7WFEtQUP2oyXoGkt4z2kZoj+c=;
        b=UBxR4xcF6IaTuom5oCYorIg3dLHuQkay+I73Bh61HxNsQafOi7KsVo69HtHNalhQj7
         Uxn8Sve/U7LugD5uAn67g+Qe6f4ksrp52sMUy69W6IEGb7YU3UOSlFuuHDiPY0RjLuSU
         Aky5B5f1ZMmyhRJ4OxzOQB8a7dxpih7bm7kWR4yrMkcE9/Vw0kfiqgB43uIQLqRFVUvd
         xFEE5wo2Zmb+G3qtzxxNRPyBE43O0/f6ucCpxFGCjxtnSEzbWMeykCuOkNmsqcAJs8vm
         V+SVNMFLj35ZGT3qWOBUKPaAv/T07ORBvwqPz95a9cr088/nd364hZsg3+sgdCtv5WVK
         XjuA==
X-Gm-Message-State: AOAM530XZ8cMRcdJQyfdIBNg8FdIXW5KM0SKqhpuFWjLcRCUfV8VrFaE
        ezmTRbnISVoemQ/Wf1HpRWBW7S54014vnTg79qVjv27M
X-Google-Smtp-Source: ABdhPJxLcjoSX05kcKs6HehhpNk/pwEmhk1kOj944ORTP7pF2Y/QXMmdOBVXt1rwnXCjq2DDbS4XrXCPkS6Ys16sPP0=
X-Received: by 2002:ac8:5942:: with SMTP id 2mr12264409qtz.183.1604507234387;
 Wed, 04 Nov 2020 08:27:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <5e4e7c68ef710c23034d6a7a180e8912d6ebbc7d.1603460665.git.josef@toxicpanda.com>
In-Reply-To: <5e4e7c68ef710c23034d6a7a180e8912d6ebbc7d.1603460665.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Nov 2020 16:27:03 +0000
Message-ID: <CAL3q7H4g6y0Q5qDrzN6UOURE_ZF4B94rdUS-wDR7Kx4HpOBGjw@mail.gmail.com>
Subject: Re: [PATCH 6/8] btrfs: load the free space cache inode extents from
 commit root
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 5:14 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Historically we've allowed recursive locking specifically for the free
> space inode.  This is because we are only doing reads and know that it's
> safe.  However we don't actually need this feature, we can get away with
> reading the commit root for the extents.  In fact if we want to allow
> asynchronous loading of the free space cache we have to use the commit
> root, otherwise we will deadlock.
>
> Switch to using the commit root for the file extents.  These are only
> read at load time, and are replaced as soon as we start writing the
> cache out to disk.  The cache is never read again, so this is
> legitimate.  This matches what we do for the inode itself, as we read
> that from the commit root as well.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/inode.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1dcccd212809..53d6a66670d3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6577,7 +6577,15 @@ struct extent_map *btrfs_get_extent(struct btrfs_i=
node *inode,
>          */
>         path->leave_spinning =3D 1;
>
> -       path->recurse =3D btrfs_is_free_space_inode(inode);
> +       /*
> +        * The same explanation in load_free_space_cache applies here as =
well,
> +        * we only read when we're loading the free space cache, and at t=
hat
> +        * point the commit_root has everything we need.
> +        */
> +       if (btrfs_is_free_space_inode(inode)) {
> +               path->search_commit_root =3D 1;
> +               path->skip_locking =3D 1;
> +       }
>
>         ret =3D btrfs_lookup_file_extent(NULL, root, path, objectid, star=
t, 0);
>         if (ret < 0) {
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
