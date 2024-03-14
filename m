Return-Path: <linux-btrfs+bounces-3303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9601387C22B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027BB1F21D8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25D74BE4;
	Thu, 14 Mar 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ3EW9+X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9397443F
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438048; cv=none; b=PkaTv3ZjDcWZrveasx7rgnKV5n0jPx21v22NDZ7xAwHO+sd/pZnv7D6qBnRQ8oRO+7JePS5wM3gXSqZ1avDAhviGVVt3xSMcvR8Hb709grE7FSS2i7aqZb7e8Rn0Ax4rpSnadmBuuK8/UlG941TeW5vGqf9DMswecG9lujIg7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438048; c=relaxed/simple;
	bh=pQMMa+mI4h/TpmF02aN/EmkyDGT9WSJpL1Y62DPdCOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLrpVga6xoBAElkTfuavajG8vGn4wS7/JLL16yL1XAXpqKAEHHZes7bqVyip3szUaPi8z/QXVy7urX6bpSJNokrr23LtnJYrmeViIao5YpMnyU/9NNFPlUkhrkyfm9KQfkxLGwzm6IJA6nslGHOl0GbHlQbEt5TcdGn+z6NxlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ3EW9+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8CBC433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710438047;
	bh=pQMMa+mI4h/TpmF02aN/EmkyDGT9WSJpL1Y62DPdCOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gZ3EW9+XXsk/TWgpipBPMq6urwZqcI/NE1lnni/tl1TG+qqlIiG6c4nF7o+yEnrZv
	 Yt9/tA0jwmstukAL5/xqWBEvl5P/f+qsvBixrF8vcZs5M4FPaPvmL8DbN/GbrpmpIu
	 HLP2jNO8FJu9g62T4F3F/TK0KfqVqjSwasCf1iBfWCSAgHRf54jVmyK5vRROVkANOn
	 6gC2tSl5MEDdnUtKPFvv81wfz+sLuKKWyqPQjR9K5iPJRTlM5e7spqjIfqcaCbsl83
	 iVgMtKvuEnPt5ewMCawipeaiKaE990SNC6EKQntbg2zSaD6fSCKDB9/61PQ8i2COR/
	 CZH4YC7jbMGxA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a466a27d30aso167274666b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 10:40:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YxaZH5Tl/Y/G2Oho4Pl0cZb1XwohYU8DhTJvjtQkwe085vLx72z
	1rPtx9gl7a5169qIvF3Qve1NqIxzbfbOWiUe/PZbOB26xO7pSxJDyQdowA6wUNeFybimQe6U4rB
	GdusZV28LTmLW70RJaMlnlQGBNc4=
X-Google-Smtp-Source: AGHT+IFNJtZ0zlqBSURG/2jXUk09GJyN/DgN/h/aEOGv50zgJ/LlGosbXWZuRR8IkkuuU0la0s4oEC9ZiGUkT5D6RW0=
X-Received: by 2002:a17:907:a70c:b0:a46:7722:377e with SMTP id
 vw12-20020a170907a70c00b00a467722377emr1260447ejc.69.1710438045905; Thu, 14
 Mar 2024 10:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu@suse.com>
In-Reply-To: <6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 14 Mar 2024 17:40:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7wLB4wp+H-BYv1zi0ReywAJ2aiKf7LWyysb2rH44BZfg@mail.gmail.com>
Message-ID: <CAL3q7H7wLB4wp+H-BYv1zi0ReywAJ2aiKf7LWyysb2rH44BZfg@mail.gmail.com>
Subject: Re: [PATCH 6/7] btrfs: scrub: unify and shorten the error message
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently the scrub error report is pretty long:
>
>  BTRFS error (device dm-2): unable to fixup (regular) error at logical 13=
647872 on dev /dev/mapper/test-scratch1 physical 13647872
>  BTRFS warning (device dm-2): checksum error at logical 13647872 on dev /=
dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, offset 1638=
4, length 4096, links 1 (path: file1)
>
> Since we have so many things to output, it's not a surprise we got long
> error lines.
>
> To make the lines a little shorter, and make important info more
> obvious, change the unify output to something like this:
>
>  BTRFS error (device dm-2): unable to fixup (regular) error at logical 13=
647872(1) physical 1(/dev/mapper/test-scratch1)13647872
>  BTRFS warning (device dm-2): checksum error at inode 5/257(file1) fileof=
f 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872

I find that hard to read because:

1) Please leave spaces before opening parenthesis.
   That makes things less cluttered and easier to the eyes, more
consistent with what we generally do and it's the formal way to do
things in English (see
https://www.scribens.com/grammar-rules/typography/spacing.html);

2) Instead of "inode 5/257(file1)", something a lot easier to
understand like "inode 5 root 257 path \"file1\"", which leaves no
margin for doubt about what each number is;

3) Same with "logical 13647872(1)" - what is the 1? That will be the
question anyone reading such a log message will likely have.
    Something like "logical 13647872 mirror 1" makes it clear;

4) Same with "physical 1(/dev/mapper/test-scratch1)13647872".
    Something like "physical 13647872 device ID 1 device path
\"/dev/mapper/test-scratch1\"", makes it clear what each number is and
easier to read.

Thanks.

>
> The idea is, to put large values/small values/string separated meanwhile
> skip the some descriptor directly:
>
> - "logical LOGICAL(MIRROR)"
>   LOGICAL is always a large value, meanwhile MIRROR is always a single
>   digit.
>   Thus combining them together, human can still split them instinctively.
>
> - "physical DEVID(DEVPATH)PHYSICAL"
>   DEVID is normally a short number, DEVPATH is a long string, and PHYSICA=
L
>   is a normally a large number.
>   And for most end users, the most important device path is still easy
>   to catch, even surrounded by some large numbers.
>
> - inode ROOT/INO(PATH)
>   To locate a btrfs inode, we have to provide both root and inode
>   number. Normally ROOT should be a much smaller number (3 digits)
>   meanwhile the INO can be pretty large.
>
>   However for the end user, the most important thing is the PATH, which
>   is still not hard to locate.
>
> Any better ideas would be appreciated to make those lines shorter.
>
> However what we really need is a proper way to report all those info
> (maybe put the file/dev name resolution into the user space) to user
> space reliably (without rate limit).
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 55 +++++++++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 18b2ee3b1616..17e492076bf8 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -226,6 +226,7 @@ struct scrub_warning {
>         u64                     physical;
>         u64                     logical;
>         struct btrfs_device     *dev;
> +       int                     mirror_num;
>  };
>
>  static void release_scrub_stripe(struct scrub_stripe *stripe)
> @@ -427,12 +428,12 @@ static int scrub_print_warning_inode(u64 inum, u64 =
offset, u64 num_bytes,
>          */
>         for (i =3D 0; i < ipath->fspath->elem_cnt; ++i)
>                 btrfs_warn_in_rcu(fs_info,
> -"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, off=
set %llu, path: %s",
> -                                 swarn->errstr, swarn->logical,
> -                                 btrfs_dev_name(swarn->dev),
> -                                 swarn->physical,
> -                                 root, inum, offset,
> -                                 (char *)(unsigned long)ipath->fspath->v=
al[i]);
> +"%s at inode %lld/%llu(%s) fileoff %llu, logical %llu(%u) physical %llu(=
%s)%llu",
> +                                 swarn->errstr, root, inum,
> +                                 (char *)ipath->fspath->val[i], offset,
> +                                 swarn->logical, swarn->mirror_num,
> +                                 swarn->dev->devid, btrfs_dev_name(swarn=
->dev),
> +                                 swarn->physical);
>
>         btrfs_put_root(local_root);
>         free_ipath(ipath);
> @@ -440,18 +441,17 @@ static int scrub_print_warning_inode(u64 inum, u64 =
offset, u64 num_bytes,
>
>  err:
>         btrfs_warn_in_rcu(fs_info,
> -                         "%s at logical %llu on dev %s, physical %llu, r=
oot %llu, inode %llu, offset %llu: path resolving failed with ret=3D%d",
> -                         swarn->errstr, swarn->logical,
> -                         btrfs_dev_name(swarn->dev),
> -                         swarn->physical,
> -                         root, inum, offset, ret);
> -
> +       "%s at inode %lld/%llu fileoff %llu, logical %llu(%u) physical %l=
lu(%s)%llu",
> +                         swarn->errstr, root, inum, offset,
> +                         swarn->logical, swarn->mirror_num,
> +                         swarn->dev->devid, btrfs_dev_name(swarn->dev),
> +                         swarn->physical);
>         free_ipath(ipath);
>         return 0;
>  }
>
>  static void scrub_print_common_warning(const char *errstr, struct btrfs_=
device *dev,
> -                                      u64 logical, u64 physical)
> +                                      u64 logical, u64 physical, int mir=
ror_num)
>  {
>         struct btrfs_fs_info *fs_info =3D dev->fs_info;
>         struct btrfs_path *path;
> @@ -471,6 +471,7 @@ static void scrub_print_common_warning(const char *er=
rstr, struct btrfs_device *
>         swarn.logical =3D logical;
>         swarn.errstr =3D errstr;
>         swarn.dev =3D NULL;
> +       swarn.mirror_num =3D mirror_num;
>
>         ret =3D extent_from_logical(fs_info, swarn.logical, path, &found_=
key,
>                                   &flags);
> @@ -501,10 +502,11 @@ static void scrub_print_common_warning(const char *=
errstr, struct btrfs_device *
>                         if (ret > 0)
>                                 break;
>                         btrfs_warn_in_rcu(fs_info,
> -"%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in =
tree %llu",
> -                               errstr, swarn.logical, btrfs_dev_name(dev=
),
> -                               swarn.physical, (ref_level ? "node" : "le=
af"),
> -                               ref_level, ref_root);
> +"%s at metadata in tree %llu(%u), logical %llu(%u) physical %llu(%s)%llu=
",
> +                               errstr, ref_root, ref_level,
> +                               swarn.logical, swarn.mirror_num,
> +                               dev->devid, btrfs_dev_name(dev),
> +                               swarn.physical);
>                 }
>                 btrfs_release_path(path);
>         } else {
> @@ -879,27 +881,32 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>                  */
>                 if (repaired) {
>                         btrfs_err_rl_in_rcu(fs_info,
> -                       "fixed up error at logical %llu on dev %s physica=
l %llu",
> -                                           logical, btrfs_dev_name(dev),
> +                       "fixed up error at logical %llu(%u) physical %llu=
(%s)%llu",
> +                                           logical, stripe->mirror_num,
> +                                           dev->devid, btrfs_dev_name(de=
v),
>                                             physical);
>                         continue;
>                 }
>
>                 /* The remaining are all for unrepaired. */
>                 btrfs_err_rl_in_rcu(fs_info,
> -       "unable to fixup (regular) error at logical %llu on dev %s physic=
al %llu",
> -                                           logical, btrfs_dev_name(dev),
> +       "unable to fixup (regular) error at logical %llu(%u) physical %ll=
u(%s)%llu",
> +                                           logical, stripe->mirror_num,
> +                                           dev->devid, btrfs_dev_name(de=
v),
>                                             physical);
>
>                 if (test_bit(sector_nr, &stripe->io_error_bitmap))
>                         scrub_print_common_warning("i/o error", dev,
> -                                                    logical, physical);
> +                                                    logical, physical,
> +                                                    stripe->mirror_num);
>                 if (test_bit(sector_nr, &stripe->csum_error_bitmap))
>                         scrub_print_common_warning("checksum error", dev,
> -                                                    logical, physical);
> +                                                    logical, physical,
> +                                                    stripe->mirror_num);
>                 if (test_bit(sector_nr, &stripe->meta_error_bitmap))
>                         scrub_print_common_warning("header error", dev,
> -                                                    logical, physical);
> +                                                    logical, physical,
> +                                                    stripe->mirror_num);
>         }
>
>         spin_lock(&sctx->stat_lock);
> --
> 2.44.0
>
>

