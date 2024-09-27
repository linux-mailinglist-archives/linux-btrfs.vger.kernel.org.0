Return-Path: <linux-btrfs+bounces-8285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8607098801D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D381F23D46
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79821898EA;
	Fri, 27 Sep 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKWkTaH3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C53189524
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424881; cv=none; b=OzYsQKg7NVVCe8lvY8R4O8RWBbxFPw3lmQ5AoYTWRk0opgdm4BOyR1jIUOBHiJiIqc7TKFx3KDuSb+9knPIQG0h/HQ4+jpMFOyZ3KRx7UkpFCdGPD9btzDgdK/qbagaGycyu3MBKJ0tOfzP9iUaVgKp45Um/GTEvFAZl/JYIlEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424881; c=relaxed/simple;
	bh=ZGmu2LfSOykQZSVUV2bZd7u9O748n8tv/J8jDm55m9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gP+dvaMQd2M2i1CZqlmM55/fSL2BOv0Pe8mrhBDmCWw8q/rR5+s3y8AtsrL5qv+OP6LyLr1diQqGakoWHZsNB9KxR2yCDkCZYhw0sP6LIPlbi64F+IMAO4VmbS67eHWvETijFMzSijYMIvJIWYAg8yI0hSXC2aXRzX+kujLuEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKWkTaH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADC0C4CEC7
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424881;
	bh=ZGmu2LfSOykQZSVUV2bZd7u9O748n8tv/J8jDm55m9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NKWkTaH3qV0gfMdq3IJI9wj8ARWnp8AxSUo0LDn3NPm4wR5Tw6XgNVmFxHFeW0F21
	 u9ppVPuWbInANpQioa+mGmMgGW/flg8IzgTHI/5upgz3l5fboCW2KY4kKGtv3OkfHw
	 2g1C1ZJQBzsgR4zvj4U28UpgQWnU4MRhjCMIWffvbdphzjonXgywIijPYRp9rSlG+L
	 MP4WYu5KAGoEaUvynrkR4cXjtKZ+CKE2It6H1d4aDh8Nc8rPT9VuSBnWFmHBBqOh4f
	 ve3RRkAU1lYIJ4UBFAms4q4/Dm3L79/Ak/7xloHiiJidsHO7UQHb+EYJP1b32pjUq3
	 t3qwVG8qLPJoA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a910860e4dcso270519766b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 01:14:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxj2SgriOoFsmNokeU644EKjVH+Ri4+NjOAQVCFWU+ULAZ4zHtX
	/3FAR/NCCJNpKQ0I+2X0reG/9fSTWvPCDlRUUM5KYCqRmuy8/cM82yu27IWfym4paoAUnzWRmwO
	UIpT9gQjy0mnZvDtAhn7zmrVc/Cs=
X-Google-Smtp-Source: AGHT+IHbwjm5p9sUTWXeLqv3abORtUeMBsaTNvG+EI3ZciTtz28ZQudsGSK0D8BxvzMd039YK2rzx+f1NWtP/DGyT5o=
X-Received: by 2002:a17:907:1c0a:b0:a8d:286f:7b46 with SMTP id
 a640c23a62f3a-a93c492a26cmr211721066b.29.1727424879896; Fri, 27 Sep 2024
 01:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727416314.git.wqu@suse.com> <16df770373ded4bf871d9d89f5af1ea7865de896.1727416314.git.wqu@suse.com>
In-Reply-To: <16df770373ded4bf871d9d89f5af1ea7865de896.1727416314.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Sep 2024 09:14:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7hKkZgqGGk0kAK8qe2GS4uCoKGO6YCMcTdY3pm+qoYwg@mail.gmail.com>
Message-ID: <CAL3q7H7hKkZgqGGk0kAK8qe2GS4uCoKGO6YCMcTdY3pm+qoYwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: receive: workaround unaligned full file clone
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Ben Millwood <thebenmachine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 6:54=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> The following script can lead to receive failure with latest kernel:
>
>   dev=3D"/dev/test/scratch1"
>   mnt=3D"/mnt/btrfs"
>
>   mkfs.btrfs -f $dev
>   mount $dev $mnt
>   btrfs subv create $mnt/subv1
>   xfs_io -f -c "pwrite 0 4000" $mnt/subv1/source
>   xfs_io -f -c "reflink $mnt/subv1/source" $mnt/subv1/dest
>   btrfs subv snap -r $mnt/subv1 $mnt/ro_subv1
>   btrfs subv snap $mnt/subv1 $mnt/snap1
>   xfs_io -f -c "pwrite -S 0xff 0 3900" -c "truncate 3900" $mnt/snap1/sour=
ce
>   truncate -s 0 $mnt/snap1/dest
>   xfs_io -f -c "reflink $mnt/snap1/source" $mnt/snap1/dest
>   btrfs subv snap -r $mnt/snap1 $mnt/ro_snap1
>   btrfs send $mnt/ro_subv1 -f /tmp/ro_subv1.stream
>   btrfs send -p $mnt/ro_subv1 $mnt/ro_snap1 -f /tmp/ro_snap1.stream
>   umount $mnt
>   mkfs.btrfs -f $dev
>   mount $dev $mnt
>   btrfs receive -f /tmp/ro_subv1.stream $mnt
>   btrfs receive -f /tmp/ro_snap1.stream $mnt
>   At snapshot ro_snap1
>   ERROR: failed to clone extents to dest: Invalid argument
>
> [CAUSE]
> Since kernel commit 46a6e10a1ab1 ("btrfs: send: allow cloning
> non-aligned extent if it ends at i_size"), kernel can send out clone
> stream if we're cloning a full file, even if the size of the file is not
> sector aligned, like this one:
>
>   snapshot        ./ro_snap1                      uuid=3D2a3e2b70-c606-d4=
46-b60b-baab458be6da transid=3D9 parent_uuid=3Dd8ff9b9e-3ffc-6343-b53e-e22f=
8bbb7c25 parent_transid=3D7
>   write           ./ro_snap1/source               offset=3D0 len=3D4700
>   truncate        ./ro_snap1/source               size=3D4700
>   utimes          ./ro_snap1/source               atime=3D2024-09-27T13:0=
8:54+0800 mtime=3D2024-09-27T13:08:54+0800 ctime=3D2024-09-27T13:08:54+0800
>   clone           ./ro_snap1/dest                 offset=3D0 len=3D4700 f=
rom=3D./ro_snap1/source clone_offset=3D0
>   truncate        ./ro_snap1/dest                 size=3D4700
>   utimes          ./ro_snap1/dest                 atime=3D2024-09-27T13:0=
8:54+0800 mtime=3D2024-09-27T13:08:54+0800 ctime=3D2024-09-27T13:08:54+0800
>
> However for the clone command, if the file inside the source subvolume
> is larger than the new size, kernel will reject the clone operation, as
> the resulted layout may read beyond the EOF of the clone source.
>
> This should be addressed by the kernel, by doing the truncation before
> the clone to ensure the destination file is no larger than the source.
>
> [FIX]
> It won't hurt for "btrfs receive" command to workaround the
> problem, by truncating the destination file first.
>
> Here we choose to truncate the file size to 0, other than the
> source/destination file size.
> As truncating to an unaligned size can cause the fs to do extra page
> dirty and zero the tailing part.
>
> Since we know it's a full file clone, truncating the file to size 0 will
> avoid the extra page dirty, and allow the later clone to be done.
>
> Reported-by: Ben Millwood <thebenmachine@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=3DojYvBPDLsATw=
Lbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  cmds/receive.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 4cc5b9009442..9bda5485d895 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -56,6 +56,8 @@
>  #include "cmds/commands.h"
>  #include "cmds/receive-dump.h"
>
> +static u32 g_sectorsize;
> +
>  struct btrfs_receive
>  {
>         int mnt_fd;
> @@ -739,6 +741,7 @@ static int process_clone(const char *path, u64 offset=
, u64 len,
>         struct btrfs_receive *rctx =3D user;
>         struct btrfs_ioctl_clone_range_args clone_args;
>         struct subvol_info *si =3D NULL;
> +       struct stat st =3D { 0 };
>         char full_path[PATH_MAX];
>         const char *subvol_path;
>         char full_clone_path[PATH_MAX];
> @@ -802,11 +805,36 @@ static int process_clone(const char *path, u64 offs=
et, u64 len,
>                 error("cannot open %s: %m", full_clone_path);
>                 goto out;
>         }
> +       ret =3D fstat(clone_fd, &st);
> +       if (ret < 0) {
> +               errno =3D -ret;
> +               error("cannot stat %s: %m", full_clone_path);
> +               goto out;
> +       }
>
>         if (bconf.verbose >=3D 2)
>                 fprintf(stderr,
>                         "clone %s - source=3D%s source offset=3D%llu offs=
et=3D%llu length=3D%llu\n",
>                         path, clone_path, clone_offset, offset, len);
> +       /*
> +        * Since kernel commit 46a6e10a1ab1 ("btrfs: send: allow cloning
> +        * non-aligned extent if it ends at i_size"), we can have send
> +        * stream cloning a full file even its size is not sector aligned=
.
> +        *
> +        * But if we're cloning this unaligned range into an existing fil=
e,
> +        * which has a larger i_size, the clone will fail.
> +        *
> +        * Address this quirk by introducing an extra truncation to size =
0.

No, this is incorrect and will cause data loss in case the file has
multiple extents, and we're trying to clone the last one which is not
sector size aligned.
The assumption that this is always for a full file, consisting of a
single extent is wrong.

The problem is easy to fix in the kernel and it's where it should
always be fixed - any problem with the order of operations in the send
stream should be fixed in the kernel.
We've had at least one problem in the past by adding this type of
workarounds to btrfs-progs when the problem should be fixed in the
kernel (a case with special xattrs).

I'll send the kernel fix soon.

Thanks.

> +        */
> +       if (clone_offset =3D=3D 0 && !IS_ALIGNED(len, g_sectorsize) &&
> +           len =3D=3D st.st_size) {
> +               ret =3D ftruncate(rctx->write_fd, 0);
> +               if (ret < 0) {
> +                       errno =3D - ret;
> +                       error("failed to truncate %s: %m", path);
> +                       goto out;
> +               }
> +       }
>
>         clone_args.src_fd =3D clone_fd;
>         clone_args.src_offset =3D clone_offset;
> @@ -1468,6 +1496,18 @@ static struct btrfs_send_ops send_ops =3D {
>         .enable_verity =3D process_enable_verity,
>  };
>
> +static int get_fs_sectorsize(int fd, u32 *sectorsize_ret)
> +{
> +       struct btrfs_ioctl_fs_info_args args =3D { 0 };
> +       int ret;
> +
> +       ret =3D ioctl(fd, BTRFS_IOC_FS_INFO, &args);
> +       if (ret < 0)
> +               return -errno;
> +       *sectorsize_ret =3D args.sectorsize;
> +       return 0;
> +}
> +
>  static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
>                       char *realmnt, int r_fd, u64 max_errors)
>  {
> @@ -1491,6 +1531,13 @@ static int do_receive(struct btrfs_receive *rctx, =
const char *tomnt,
>                         dest_dir_full_path);
>                 goto out;
>         }
> +       ret =3D get_fs_sectorsize(rctx->dest_dir_fd, &g_sectorsize);
> +       if (ret < 0) {
> +               errno =3D -ret;
> +               error("failed to get sectorsize of the destination direct=
ory %s: %m",
> +                       dest_dir_full_path);
> +               goto out;
> +       }
>
>         if (realmnt[0]) {
>                 rctx->root_path =3D realmnt;
> --
> 2.46.1
>
>

