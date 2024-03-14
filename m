Return-Path: <linux-btrfs+bounces-3305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC87287C241
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B965B1C21736
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F244774BEF;
	Thu, 14 Mar 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1aOXArV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB674BE3
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438733; cv=none; b=PjdCpN//xYTQL1EwEaEs9RpB/pcQxRft8JLk561sJ5rvWoETSWtAilN8tBMDMU8zZtwpr1hmk0ttlLUZ1PJXv69/achpaBFpBqauJB+V0siUj5omrXDQqu71okZDGKS69lDhY3nWy061TCeTg1dV2imWEl5zzCwRTTZrYSBfkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438733; c=relaxed/simple;
	bh=KZbgT6uw5rzGQ04DKl2m1EVIY1VbgnMkvshk5z1HqCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MctUUmiuMdY5T40yuEBbgRua/8o1TTOFXMOAvfptZEmsgVYM3pIcDEIuN9YwVSDBUg9CJ1n1IjbtIkB6arNKjcNpLzmazFeI7Ee8pLrhlAmS0VwsXz1GMu1X5bI2VvbE2yaqXHfgWFLWZNwZsUoqLdF1oUKUp7EMpxFPSTrM2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1aOXArV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781B9C433C7
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710438732;
	bh=KZbgT6uw5rzGQ04DKl2m1EVIY1VbgnMkvshk5z1HqCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E1aOXArVT7NxuoPiq7r82bGwwF6A9RuQrc0WX3T7FuubfQyII9gh0kD0gkLobMLWg
	 oPUVLK0DGctwYtsZSMRKXivy/Ywq+shDOLV1gY3CcEFz7p9PfHK2QigrT4L9PjxeiO
	 Lf+IlNwYxOdESGQIaK6Hs9wGiHajQg/l3LdCdC5RomVWDBivWWqQurY6zjQxhIAxNa
	 RsP6/rWZ6FR1iwJAwz3n3s5Nd7TSF+ynlKuO6doAXtVy1OryS4mbXnEuuNJeseJHey
	 O6E8BQYsVZz7Af5bJfaXoKK0xmbuIOPHU5EG1imDj8eTQgJ6FLnppnZt+gtMuSqz63
	 wsfxXvTbWAoHQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a466f796fc1so134235366b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 10:52:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YwiW/u/GtWq8xtvoQ/G0OatdpSpJ2LbNACcyAWiX0N0p/t4Vomq
	BzOXxvzdzb3CLf949j31/pweKQ2BCDWRCHOWptKgcpCMNmgdQhXXTsVSBjCPUI4grtLm+fzqj58
	qgJ83MacfQL3NgOlee3ps3QPNsmw=
X-Google-Smtp-Source: AGHT+IEKQkSlsOdDoJN6n+8WNBeL41+APicEMgduv59xexf/dqwwxUuQpbAFiJsS+4H7GCZ5HWRhTiIdVmLlkH/siI8=
X-Received: by 2002:a17:906:b2d8:b0:a46:2cac:377c with SMTP id
 cf24-20020a170906b2d800b00a462cac377cmr1885113ejb.48.1710438731031; Thu, 14
 Mar 2024 10:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <c46343633e6198f315876179d31b3a66b66a8aa2.1710409033.git.wqu@suse.com>
In-Reply-To: <c46343633e6198f315876179d31b3a66b66a8aa2.1710409033.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 14 Mar 2024 17:51:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7Tn87T=Qcmo2-nZR-jSeTw7ZPdZWbUN7AQARpGsQYyBw@mail.gmail.com>
Message-ID: <CAL3q7H7Tn87T=Qcmo2-nZR-jSeTw7ZPdZWbUN7AQARpGsQYyBw@mail.gmail.com>
Subject: Re: [PATCH 7/7] btrfs: scrub: fix the frequency of error messages
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> - Remove the "unable to fixup" error message
>   Since we have ensured at least one error message is outputted for each
>   unrepairable corruption, there is no need for that fallback one.
>
> Now one unrepairable corruption would output a more refined and less
> duplicated error message:
>
>  BTRFS info (device dm-2): scrub: started on devid 1
>  BTRFS warning (device dm-2): checksum error at inode 5/257(file1) fileof=
f 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872
>  BTRFS info (device dm-2): scrub: finished on devid 1 with status: 0
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 17e492076bf8..84617a64b2d4 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -227,6 +227,7 @@ struct scrub_warning {
>         u64                     logical;
>         struct btrfs_device     *dev;
>         int                     mirror_num;
> +       bool                    message_printed;
>  };
>
>  static void release_scrub_stripe(struct scrub_stripe *stripe)
> @@ -426,26 +427,29 @@ static int scrub_print_warning_inode(u64 inum, u64 =
offset, u64 num_bytes,
>          * we deliberately ignore the bit ipath might have been too small=
 to
>          * hold all of the paths here
>          */
> -       for (i =3D 0; i < ipath->fspath->elem_cnt; ++i)
> -               btrfs_warn_in_rcu(fs_info,
> +       for (i =3D 0; i < ipath->fspath->elem_cnt; ++i) {
> +               btrfs_warn_rl_in_rcu(fs_info,
>  "%s at inode %lld/%llu(%s) fileoff %llu, logical %llu(%u) physical %llu(=
%s)%llu",
>                                   swarn->errstr, root, inum,
>                                   (char *)ipath->fspath->val[i], offset,
>                                   swarn->logical, swarn->mirror_num,
>                                   swarn->dev->devid, btrfs_dev_name(swarn=
->dev),
>                                   swarn->physical);
> +               swarn->message_printed =3D true;
> +       }
>
>         btrfs_put_root(local_root);
>         free_ipath(ipath);
>         return 0;
>
>  err:
> -       btrfs_warn_in_rcu(fs_info,
> +       btrfs_warn_rl_in_rcu(fs_info,
>         "%s at inode %lld/%llu fileoff %llu, logical %llu(%u) physical %l=
lu(%s)%llu",
>                           swarn->errstr, root, inum, offset,
>                           swarn->logical, swarn->mirror_num,
>                           swarn->dev->devid, btrfs_dev_name(swarn->dev),
>                           swarn->physical);
> +       swarn->message_printed =3D true;
>         free_ipath(ipath);
>         return 0;
>  }
> @@ -472,6 +476,7 @@ static void scrub_print_common_warning(const char *er=
rstr, struct btrfs_device *
>         swarn.errstr =3D errstr;
>         swarn.dev =3D NULL;
>         swarn.mirror_num =3D mirror_num;
> +       swarn.message_printed =3D false;
>
>         ret =3D extent_from_logical(fs_info, swarn.logical, path, &found_=
key,
>                                   &flags);
> @@ -488,26 +493,31 @@ static void scrub_print_common_warning(const char *=
errstr, struct btrfs_device *
>                 unsigned long ptr =3D 0;
>                 u8 ref_level;
>                 u64 ref_root;
> +               bool message_printed =3D false;
>
>                 while (true) {
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
> -                       btrfs_warn_in_rcu(fs_info,
> +                       btrfs_warn_rl_in_rcu(fs_info,
>  "%s at metadata in tree %llu(%u), logical %llu(%u) physical %llu(%s)%llu=
",
>                                 errstr, ref_root, ref_level,
>                                 swarn.logical, swarn.mirror_num,
>                                 dev->devid, btrfs_dev_name(dev),
>                                 swarn.physical);
> +                       message_printed =3D true;
>                 }
> +               if (!message_printed)
> +                       btrfs_warn_rl_in_rcu(fs_info,
> +"%s at metadata, logical %llu(%u) physical %llu(%s)%llu",
> +                               errstr, swarn.logical, swarn.mirror_num,
> +                               dev->devid, btrfs_dev_name(dev),
> +                               swarn.physical);
> +
>                 btrfs_release_path(path);
>         } else {
>                 struct btrfs_backref_walk_ctx ctx =3D { 0 };
> @@ -522,8 +532,14 @@ static void scrub_print_common_warning(const char *e=
rrstr, struct btrfs_device *
>                 swarn.dev =3D dev;
>
>                 iterate_extent_inodes(&ctx, true, scrub_print_warning_ino=
de, &swarn);
> +               if (!swarn.message_printed) {
> +                       btrfs_warn_rl_in_rcu(fs_info,
> +"%s at data, unresolved path name, logical %llu(%u) physical %llu(%s)%ll=
u",
> +                               errstr, swarn.logical, swarn.mirror_num,
> +                               dev->devid, btrfs_dev_name(dev),
> +                               swarn.physical);
> +               }

No need for the curly braces here, it's a single statement, so we
follow the style of dropping them.


>         }
> -
>  out:
>         btrfs_free_path(path);
>  }
> @@ -889,12 +905,6 @@ static void scrub_stripe_report_errors(struct scrub_=
ctx *sctx,
>                 }
>
>                 /* The remaining are all for unrepaired. */
> -               btrfs_err_rl_in_rcu(fs_info,
> -       "unable to fixup (regular) error at logical %llu(%u) physical %ll=
u(%s)%llu",
> -                                           logical, stripe->mirror_num,
> -                                           dev->devid, btrfs_dev_name(de=
v),
> -                                           physical);
> -

This hunk seems unintentional?

Thanks.

>                 if (test_bit(sector_nr, &stripe->io_error_bitmap))
>                         scrub_print_common_warning("i/o error", dev,
>                                                      logical, physical,
> --
> 2.44.0
>
>

