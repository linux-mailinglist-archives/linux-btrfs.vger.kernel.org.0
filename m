Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923E52A95C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgKFLuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKFLuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:50:39 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF70C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:50:39 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id h12so507318qtc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=nSp8b5bKv3gt6AzsvxCzushji4RLBF0L03h6P4NWLgI=;
        b=advh/NhtYiJpcTFIdr7TLdGNJsJ4AKSDUROwf5vwXFmX6M7CM5VkC0JRiaC2bjCibz
         VT7PsmLBJPBIJK43Wjq6Mm8OedPb72pW5PPYLVacr7En8DIxc8WYTscbviVDeud3bcsj
         1lETOwBOW/z/iUOqguDSea7rSQDxcBvZ9EtXqolkgn2DycY+DR3QaOkOS7zVQk1anSct
         dZqRR8zSX4d1HhKCYEs4VqwoRyM/Z3sKFdgh/m8apu6YVq0baq7lGofeO4ACfj2K/Jek
         P4UsW2GcZeSzyiUYoAFldR6apqgxT3nn1xiBqUA/ZzvgFEt6we+cEbZYb9rvHVKjdC/C
         H5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=nSp8b5bKv3gt6AzsvxCzushji4RLBF0L03h6P4NWLgI=;
        b=YbE2SRzlS7d7MMz5q32RHpN3pEuzildJnwFpSMyRdS+YZ8EJ+kVV90LiWOVnjOiZ05
         wHRdxGu5QI2+c8FE157mA5OU2XtHfgc/9Cjq6+wxUvi7Wna+h95S3iwJCp2kTWIkXp++
         RRs+jy2E8V2/8te2jFKMf1yWF0CH21kNxSrhyAq/Hw7aQBXNtkDu4lJ+jpNgvgWSeTPQ
         76UNquR5TP6bo2GZMvmJwOZ59myMBvifoj/KPsRvWnHm9XZYzXfFAcpKC3Z2kJ13MLVT
         +fB5TCfWfZJNahRI8mqAqv/I1ywt6xisPor5MaKfCFhJtBctz9PyPwdfeukjxK7pLao7
         uZAA==
X-Gm-Message-State: AOAM533Nygclodw84FsyrspHoidbGUcqqpAGD/XxFGvQdJ0Si28/6NDv
        bRH/bQywAUCL0I2GsLZeHn0cyXorDwFxYNRdV+I=
X-Google-Smtp-Source: ABdhPJy3MG28TuwuvNaJmDFwiwbAsoZSOroU/JpoK9p+uBgSgB2JUFM//wwTArDoqEMhpvQm8gQp3cUWGwsSFPTH2N4=
X-Received: by 2002:aed:30e2:: with SMTP id 89mr1074831qtf.259.1604663438666;
 Fri, 06 Nov 2020 03:50:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <e19ba3fe887ce6ace42c8d57cf0db54e38ab5eb3.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <e19ba3fe887ce6ace42c8d57cf0db54e38ab5eb3.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:50:27 +0000
Message-ID: <CAL3q7H798X8PZYBXzOvK-5iy7tkEwXuR5OT6pGP9K1vUdWjiVw@mail.gmail.com>
Subject: Re: [PATCH 01/14] btrfs: remove lockdep classes for the fs tree
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We have this weird problem where our lockdep class is set after we
> read a tree block, which can race with concurrent readers and result in
> erroneous lockdep errors.  We want to set the lockdep class at
> allocation time if possible, but in certain cases we may not have the
> actual root owner, such as with relocation or any backref lookups.  This
> is only really a problem for reference counted tree's, because all other
> tree's have their root reference set in their extent reference.  Remove
> the fs tree specific lock class.  We need to still keep the reloc tree
> one, it's still reference counted, because replace_path will lock the
> reloc tree and the destination tree, and if they're both set to
> tree-<level> we'll have issues.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before, it used to
happen very often with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/disk-io.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 212806d59012..35b16fe3b05f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -173,7 +173,6 @@ static struct btrfs_lockdep_keyset {
>         { .id =3D BTRFS_EXTENT_TREE_OBJECTID,     DEFINE_NAME("extent")  =
 },
>         { .id =3D BTRFS_CHUNK_TREE_OBJECTID,      DEFINE_NAME("chunk")   =
 },
>         { .id =3D BTRFS_DEV_TREE_OBJECTID,        DEFINE_NAME("dev")     =
 },
> -       { .id =3D BTRFS_FS_TREE_OBJECTID,         DEFINE_NAME("fs")      =
 },
>         { .id =3D BTRFS_CSUM_TREE_OBJECTID,       DEFINE_NAME("csum")    =
 },
>         { .id =3D BTRFS_QUOTA_TREE_OBJECTID,      DEFINE_NAME("quota")   =
 },
>         { .id =3D BTRFS_TREE_LOG_OBJECTID,        DEFINE_NAME("log")     =
 },
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
