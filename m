Return-Path: <linux-btrfs+bounces-3469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C384A881255
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 14:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7936C286737
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D340C14;
	Wed, 20 Mar 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbUfVLwx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D381DFD9
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941456; cv=none; b=MaBmyq3T0EhZ3js6dJl0yHKJPVUtU5s4TESHbrWJ/EliVgX3FeVlGz6J3LaqcwMzjsJLOHbD+DcD9YPQiEX09Nnw5BtgVNm5jJc8pISs2fVb4oceYsd+LTj6XO/J+WpIARdpOv97ay1b+b/zxJwcFpgE8DAwI3ECM5E8z60iOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941456; c=relaxed/simple;
	bh=30DeZIGKkoPr0lkX99YsYHLHtbnvjxX+EeoTHxa+znY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li70RCuW3XuBPBkWPk+ta7VgCotkCpJ8uysBgbSIFR6rYp254a4NMNEucMGsGUVmcV7BQ+HtOHwWsgVRkVTBzhNuwOokxvEiC1YaaZLmNFBo/vSZMpRQq3K5Wke5wUsqp3jF4tBKj3HjNeEH5JqYseJ0I8XwmamwGn7eJG4TVAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbUfVLwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D767DC433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710941455;
	bh=30DeZIGKkoPr0lkX99YsYHLHtbnvjxX+EeoTHxa+znY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gbUfVLwxzOQwzdi+FZLV8D8ND3405EXKNZFnE0ytZAEoo1l1brIMh6MsEPeOzOaNr
	 ni2xBzHPfWw4l72kRtg9TkYl5fEX3TxMWdFJ4MvUqVps1XYLGCd1BqnzGwYEYF2Owa
	 4UQjV0pQJ22UpsgvmjDOheH/MSln9eAGPLzbL+xyA375xyse3Cr4Eoz25oGocgcmWN
	 Jr3IG0w+PFMoOjgQWE1R7HKbSpcGS6rOdVtOfOG4uuYRL1nbvq4CGIM5GnFmnntW9j
	 osGKpG7UMd5S/I9MbAUctVhi05kjoO+KGYs6nYY2MgekU534VFk3NJkrakN9NxF3Ss
	 oQNSan4q3xrpg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso11553893e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 06:30:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YyZRnFYUK2gzii6Z3R+zKnzwxe0wyCo6LSsSLmp2WEWLcr834O7
	oLdhKyKh1zTiqLIy4ImPL1ys+x81mjjzq9j4/ubClzpQEsO+5HY492rM+v4yWPEpQMLvLZWGhfv
	RxHj/9rMhacLr2iw4Sw1awLNhO/k=
X-Google-Smtp-Source: AGHT+IFKkQwesWgl97AV0u82gIcmnOebBI3HdBPjhguyHhs/063/xI895e9v0a71tohkLGAsxEzjgCOVO0g6pXOKNd8=
X-Received: by 2002:a19:381b:0:b0:513:26e7:440c with SMTP id
 f27-20020a19381b000000b0051326e7440cmr9580529lfa.61.1710941454173; Wed, 20
 Mar 2024 06:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710906371.git.wqu@suse.com> <295591e961dc5b1f14b8ffcbccfa1e3530e2ba91.1710906371.git.wqu@suse.com>
In-Reply-To: <295591e961dc5b1f14b8ffcbccfa1e3530e2ba91.1710906371.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 20 Mar 2024 13:30:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Pd3kCiwe22t3e1vGWDe3cM-WFU-5j98VugB8F90vW8A@mail.gmail.com>
Message-ID: <CAL3q7H6Pd3kCiwe22t3e1vGWDe3cM-WFU-5j98VugB8F90vW8A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] btrfs: scrub: ensure we output at least one error
 message for unrepaired corruption
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:55=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> For btrfs scrub error messages, I have hit a lot of support cases on
> older kernels where no filename is outputted at all, with only error
> messages like:
>
>  BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0,=
 flush 0, corrupt 2823, gen 0
>  BTRFS error (device dm-0): unable to fixup (regular) error at logical 15=
63504640 on dev /dev/mapper/sys-rootlv
>  BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0,=
 flush 0, corrupt 2824, gen 0
>  BTRFS error (device dm-0): unable to fixup (regular) error at logical 15=
79016192 on dev /dev/mapper/sys-rootlv
>  BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0,=
 flush 0, corrupt 2825, gen 0
>
> The "unable to fixup (regular) error" line shows we hit an unrepairable
> error, then normally we would do data/metadata backref walk to grab the
> correct info.
>
> But we can hit cases like the inode is already orphan (unlinked from any
> parent inode), or even the subvolume is orphan (unlinked and waiting to
> be deleted).
>
> In that case we're not sure what's the proper way to continue (Is it
> some critical data/metadata? Would it prevent the system from booting?)
>
> To improve the situation, this patch would:
>
> - Ensure we at least output one message for each unrepairable error
>   If by somehow we didn't output any error message for the error, we
>   always fallback to the basic logical/physical error output, with its
>   type (data or metadata).
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, just a minor comment below.

> ---
>  fs/btrfs/scrub.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 85f321e3e37c..0d2b042d75c2 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -226,6 +226,7 @@ struct scrub_warning {
>         u64                     physical;
>         u64                     logical;
>         struct btrfs_device     *dev;
> +       bool                    message_printed;
>  };
>
>  static void release_scrub_stripe(struct scrub_stripe *stripe)
> @@ -425,7 +426,7 @@ static int scrub_print_warning_inode(u64 inum, u64 of=
fset, u64 num_bytes,
>          * we deliberately ignore the bit ipath might have been too small=
 to
>          * hold all of the paths here
>          */
> -       for (i =3D 0; i < ipath->fspath->elem_cnt; ++i)
> +       for (i =3D 0; i < ipath->fspath->elem_cnt; ++i) {
>                 btrfs_warn_in_rcu(fs_info,
>  "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, off=
set %llu, path: %s",
>                                   swarn->errstr, swarn->logical,
> @@ -433,6 +434,8 @@ static int scrub_print_warning_inode(u64 inum, u64 of=
fset, u64 num_bytes,
>                                   swarn->physical,
>                                   root, inum, offset,
>                                   (char *)(unsigned long)ipath->fspath->v=
al[i]);
> +               swarn->message_printed =3D true;
> +       }
>
>         btrfs_put_root(local_root);
>         free_ipath(ipath);
> @@ -445,7 +448,7 @@ static int scrub_print_warning_inode(u64 inum, u64 of=
fset, u64 num_bytes,
>                           btrfs_dev_name(swarn->dev),
>                           swarn->physical,
>                           root, inum, offset, ret);
> -
> +       swarn->message_printed =3D true;
>         free_ipath(ipath);
>         return 0;
>  }
> @@ -471,6 +474,7 @@ static void scrub_print_common_warning(const char *er=
rstr, struct btrfs_device *
>         swarn.logical =3D logical;
>         swarn.errstr =3D errstr;
>         swarn.dev =3D NULL;
> +       swarn.message_printed =3D false;
>
>         ret =3D extent_from_logical(fs_info, swarn.logical, path, &found_=
key,
>                                   &flags);
> @@ -492,12 +496,8 @@ static void scrub_print_common_warning(const char *e=
rrstr, struct btrfs_device *
>                         ret =3D tree_backref_for_extent(&ptr, eb, &found_=
key, ei,
>                                                       item_size, &ref_roo=
t,
>                                                       &ref_level);
> -                       if (ret < 0) {
> -                               btrfs_warn(fs_info,
> -                               "failed to resolve tree backref for logic=
al %llu: %d",
> -                                                 swarn.logical, ret);
> +                       if (ret < 0)
>                                 break;
> -                       }
>                         if (ret > 0)
>                                 break;
>                         btrfs_warn_in_rcu(fs_info,
> @@ -505,7 +505,13 @@ static void scrub_print_common_warning(const char *e=
rrstr, struct btrfs_device *
>                                 errstr, swarn.logical, btrfs_dev_name(dev=
),
>                                 swarn.physical, (ref_level ? "node" : "le=
af"),
>                                 ref_level, ref_root);
> +                       swarn.message_printed =3D true;
>                 }
> +               if (!swarn.message_printed)
> +                       btrfs_warn_in_rcu(fs_info,
> +                       "%s at metadata, logical %llu on dev %s physical =
%llu",
> +                                         errstr, swarn.logical,
> +                                         btrfs_dev_name(dev), swarn.phys=
ical);

This could be moved below the btrfs_release_path() call, as there's no
need to be holding a leaf locked while printing the message. It's an
error path and should not happen normally, but it's a good practice to
release any locks as soon as they aren't needed anymore.

Anyway, it's optional, and feel free to skip or do that adjustment
when committing the patch.

Thanks.

>                 btrfs_release_path(path);
>         } else {
>                 struct btrfs_backref_walk_ctx ctx =3D { 0 };
> @@ -520,6 +526,11 @@ static void scrub_print_common_warning(const char *e=
rrstr, struct btrfs_device *
>                 swarn.dev =3D dev;
>
>                 iterate_extent_inodes(&ctx, true, scrub_print_warning_ino=
de, &swarn);
> +               if (!swarn.message_printed)
> +                       btrfs_warn_in_rcu(fs_info,
> +       "%s at data, filename unresolved, logical %llu on dev %s physical=
 %llu",
> +                                         errstr, swarn.logical,
> +                                         btrfs_dev_name(dev), swarn.phys=
ical);
>         }
>
>  out:
> --
> 2.44.0
>
>

