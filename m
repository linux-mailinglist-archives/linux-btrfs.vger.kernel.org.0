Return-Path: <linux-btrfs+bounces-6508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE63932E5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD3A1F235C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72B419E822;
	Tue, 16 Jul 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5usrvx7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406819A86A
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147487; cv=none; b=b7yJ+0+F1cbmKxA/uTxLbGkEhHHt5gST6MyfagBE1TIL3YHyrHZ2shplQKkXsirtt0GvYg0s1C0GlEHwDY4D2JFgK21P+Pn76cJgHJldDvPLuq0D/qzRc+c10mc5Uz3Lxh64o+Bywq5hriaaCnfQuETqs1oXXQBx6cgVMoFbe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147487; c=relaxed/simple;
	bh=SE3Ok4xCDagJHje8puInwxON/V1MiHf0m/Ktw0VYfGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srBCzs5wvA24hlYwHPnbGPmZreNw1D2Vwey+jINKNuyTtJ7SSvssxwSJ69pYADMSKdTQmvsmfsk/X63YyAdmFbX3tRn95U0IxT98IlYiRpyIGC9AZtbW0JrSZv1wvGdQM3tv1ewriCP3AAfxSbhtjGIq3g5wQOdnPyr7cDMJ/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5usrvx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87275C4AF0D
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721147486;
	bh=SE3Ok4xCDagJHje8puInwxON/V1MiHf0m/Ktw0VYfGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U5usrvx7XdESohSBwZM7zPniwKOnZyPGtcVctnN5j8NibqNMD2ay2AzrXe/kVMNtw
	 BcBijrJ2fgAhC4WdiEYyIw5AjyEKV9CM+V7P2C/dqxUNY7TuxLKDoCNFtJlcOikJ/e
	 p/iwtLqqU6MuZkO0cQgmIrhK8tzVWFHHNb3oHv9aCAmK8bEr3NVP0wiEXR5cjRHey6
	 prDJ0i7/NsOQoFLWQm42+dkmxVR12Uix/CdGQshAxIlxnJWi9Y+I+NLWaPkAvk5JOa
	 haxeR92c91DWsVLVYFXd3vVYf7T97Gl8m45qPs6ZX+7fVjsCG3YxzYBicfJmNpoylb
	 BniI0P7/YE05g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea952ce70so6096231e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 09:31:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YyUb2M1Sif7VgfJZBdQSQROhv8umNvYxlVWYw4Xkh1xI2qacW3O
	qq+CjwtUrxxOOOrbSZBraEsh/Ig87NzozTDZDnhrLH2/tLMEJsjcnxfQ+vOGLxScnM6TkWbac1P
	Ned0b8fYEIDZI8m6nKJyc3o8/6F0=
X-Google-Smtp-Source: AGHT+IHrdQHQ5YLrIOUOfD1vFCzqm6CaUJluFoWnCTbZ3gCDMAAkaMVwrESyqOBgPkGZ28UDJohqRprYoJe5BixcMEw=
X-Received: by 2002:a05:6512:b85:b0:52c:ab2c:19c4 with SMTP id
 2adb3069b0e04-52edef1d180mr1982817e87.10.1721147484812; Tue, 16 Jul 2024
 09:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1721147081-4813-1-git-send-email-zhanglikernel@gmail.com>
In-Reply-To: <1721147081-4813-1-git-send-email-zhanglikernel@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Jul 2024 17:30:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7KuH+hLS_wrzKfHymwo5xTVNXazAS=N6xAN9+2Wp5eWQ@mail.gmail.com>
Message-ID: <CAL3q7H7KuH+hLS_wrzKfHymwo5xTVNXazAS=N6xAN9+2Wp5eWQ@mail.gmail.com>
Subject: Re: [PATCH V2] btrfs: print warning message if bdev_file_open_by_path
 function fails during mount.
To: Li Zhang <zhanglikernel@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 5:25=E2=80=AFPM Li Zhang <zhanglikernel@gmail.com> =
wrote:
>
> [ENHANCEMENT]
> When mounting a btrfs filesystem, the filesystem opens the
> block device, and if this fails, there is no message about
> it. Print a message about it to help debugging.
>
> [IMPLEMENTATION]
> Print warning message if bdev_file_open_by_path fails.

It's no longer a warning message (it's an error message now), plus
this section/phrase is redundant - you have already said the same
right above.

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
> [ 352.944328] BTRFS error: faled to open device for path /dev/vdc with fl=
ags 0x3: -13

typo:  faled -> failed

> [ 352.947196] BTRFS error (device vdb): missing devid 2 uuid 4ee2c625-a3b=
2-4fe0-b411-756b23e08533
> ....
>
> V1:
>   Use printk to print messages
>
> V2:
>   Use btrfs_err to print messages and format output

Details about what changed between patch versions goes under the line
"---" below, so that it doesn't show up in the commit message after it
gets committed.

>
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---

Here.

>  fs/btrfs/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c39145e..179419f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -476,6 +476,7 @@ static noinline struct btrfs_fs_devices *find_fsid(
>
>         if (IS_ERR(*bdev_file)) {
>                 ret =3D PTR_ERR(*bdev_file);
> +               btrfs_err(NULL, "faled to open device for path %s with fl=
ags 0x%x: %d", device_path, flags, ret);

typo: faled -> failed

Thanks.

>                 goto error;
>         }
>         bdev =3D file_bdev(*bdev_file);
> --
> 1.8.3.1
>
>

