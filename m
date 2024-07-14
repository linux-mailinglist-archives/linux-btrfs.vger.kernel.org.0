Return-Path: <linux-btrfs+bounces-6442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C25930A94
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785851F214C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647313A252;
	Sun, 14 Jul 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neaHUsiF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE638139CFA
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720971298; cv=none; b=JLBwZQvAmuspbLHZ/ZBIxn2m0QVR7GyjG5bMLNPj24joQFhAi8oahyICm0cs4PquOcDlcU35HRGZIcX12EkaSSA3pA0jEh3IFucCNF2y/+XvQ1ihCxSZJLeEcrF43/vMGrd6An3Q9uVgJ9ZjSCI5XUt+b/okvmmDCA/ZVFaqgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720971298; c=relaxed/simple;
	bh=NUqA2mpGTOjM7J4EZ+P3fMy4S+5dK/cx08HnZNlxhOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lqt1wo3Q3S3VSUHlysPAjpyQ9YUVRlHEAay/G4kmFq9YNua3qVohq8NIlGk4Sdi+Q0HG93Ah8EX9uKUYb68DhG0yYotlx5mIJ666aV3C/XgeITt1FchuCXrDJuq2A+w0pKyxAyBNTqcI5+VlZk8eF6NHBepDKHWRAcRoG8W/ouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neaHUsiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558CAC116B1
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720971298;
	bh=NUqA2mpGTOjM7J4EZ+P3fMy4S+5dK/cx08HnZNlxhOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=neaHUsiFdF/5KiqHelyAyM7ZCwG5sSSXCOz/es0R/a03z6JqM40r0muF0hZColCRO
	 BATIIkI4YhAuhS7A8zWwTgXXCkGBnTzlF9gZOsIKuFA4hFDKCqAC+y1sl7Mq+AVC7/
	 sb4Aac9qyJwRBCmi0rQKSAu+OorUuh+Yjgk/OemUoro7w6L5mNd2hhiXvZKePRZQ3w
	 1ubzdyLuXDT+rEVJCcrztovE9/w5I/22c7YMDhtBNjZWoMOOFeNgn1mSiME2gY6iIv
	 IvIqRJNo2aAxNbBMGaQNvL4VTKF49UAP9utr2nJ40BfEb1XelBNNdFlnyspUomC7IR
	 8DMxswZ//5d9g==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso4242622a12.3
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 08:34:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZIK0y6t4vFBcfFVXljolZr8HcK8lkLExbJPMW6qurbnVvvF3f
	hy81nSwcEmp6qTMlGBUXJqT+5Ydl/C7VF2tuv9nhvo1V9rDovDlEzNImO8nxoXi7+ECL80IaiY2
	G3Bxo3uvOiXyNZt6BtQN04XUbsv8=
X-Google-Smtp-Source: AGHT+IEA1rhAnn+nHkUL+IQP1grS2OEqmleufW3rQ+zCJImP7GHCmMIwKTZ+kPo5mkQM2nuzIlFflf91ttcXEZdQQqc=
X-Received: by 2002:a17:906:451:b0:a77:db36:1cc6 with SMTP id
 a640c23a62f3a-a780b89a166mr970929066b.68.1720971296904; Sun, 14 Jul 2024
 08:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720962326-19300-1-git-send-email-zhanglikernel@gmail.com>
In-Reply-To: <1720962326-19300-1-git-send-email-zhanglikernel@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 14 Jul 2024 16:34:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H42YJOYRZA9QtDzbAi8ff6STwpFXOjOXA-zLqvg2sVrnA@mail.gmail.com>
Message-ID: <CAL3q7H42YJOYRZA9QtDzbAi8ff6STwpFXOjOXA-zLqvg2sVrnA@mail.gmail.com>
Subject: Re: [PATCH]: btrfs: print warning message if bdev_file_open_by_path
 function fails during mount
To: Li Zhang <zhanglikernel@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 2:06=E2=80=AFPM Li Zhang <zhanglikernel@gmail.com> =
wrote:
>
> [ENHANCEMENT]
> When mounting a btrfs filesystem, the filesystem opens the
> block device, and if this fails, there is no message about
> it. Print a message about it to help debugging.
>
> [IMPLEMENTATION]
> Print warning message if bdev_file_open_by_path fails.
>
> [TEST]
> I have a btrfs filesystem on three block devices,
> one of which is write-protected, so regular mounts fail,
> but there is no message in dmesg.
>
> /dev/vdb normal
> /dev/vdc write protected
> /dev/vdd normal
>
> Before patch:
> $ sudo mount /dev/vdb /mnt/
> mount: mount(2) failed: no such file or directory
> $ sudo dmesg # Show only messages about missing block devices
> ....
> [ 352.947196] BTRFS error (device vdb): devid 2 uuid 4ee2c625-a3b2-4fe0-b=
411-756b23e08533 missing
> ....
>
> After patch:
> $ sudo mount /dev/vdb /mnt/
> mount: mount(2) failed: no such file or directory
> $ sudo dmesg # Show bdev_file_open_by_path failed.
> ....
> [ 352.944328] bdev_file_open_by_path failed device_path:/dev/vdc ret::-13
> [ 352.947196] BTRFS error (device vdb): missing devid 2 uuid 4ee2c625-a3b=
2-4fe0-b411-756b23e08533
> ....
>
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
>  fs/btrfs/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c39145e..0713b44 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -476,6 +476,7 @@ static noinline struct btrfs_fs_devices *find_fsid(
>
>         if (IS_ERR(*bdev_file)) {
>                 ret =3D PTR_ERR(*bdev_file);
> +               printk(KERN_WARNING "bdev_file_open_by_path failed device=
_path:%s ret::%d\n", device_path, ret);

Please use the btrfs helpers to print messages: btrfs_warn(),
btrfs_err(), btrfs_crit(), etc.
This is what we prefer to do.

About the message itself:

1) Don't use a function name like bdev_file_open_by_path in the
message, we don't do that anywhere else, and we have 3 different
places calling it;

2) Try to comply with the style we follow. After a ":" leave a space
for better readability;

3) Don't use "::", we don't do it anywhere else and it's even
inconsistent with the rest of the message you added;

4) An error level is more appropriate since we have a failure.

Look at the example we have at device_list_add():

btrfs_err(NULL, "failed to lookup block device for path %s: %d", path, erro=
r);

So I would suggest changing it to:

btrfs_err(NULL, "failed to open device for path %s with flags 0x%x:
%d", device_path, flags, ret);

Thanks.


>                 goto error;
>         }
>         bdev =3D file_bdev(*bdev_file);
> --
> 1.8.3.1
>
>

