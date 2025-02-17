Return-Path: <linux-btrfs+bounces-11513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E2FA38A2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 18:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A0818944E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F94A226863;
	Mon, 17 Feb 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaEJtnvU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D42248B7
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811640; cv=none; b=tYnQzYfBQaoPKXAdi8Dg9SxlO1ZKy1X9/fLY1Flpfk0GKlEw9pkxx1R3VDkheaiKVaNb42RzaaOvnGQkhjL8+aasr1nn1HLrK0Or3r43slPGYJ8OYcvmoK+FP9Z8v0LlbdbJrnkBRFSr1b0te+HiT5RuciOuaazti44Jpx2PB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811640; c=relaxed/simple;
	bh=9jPG1p/vyE7qseFMSGya/0N/h0GUJ9wVovOnzFqK+vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIyWKj8tre/3Vewl3bW7bM6dnYRgGXAv385ubCo5PjMUluhyurhH6BXysCF/X4IBqAbEtZxzdviol/5TQcDhoRTb99Wmv0CvWcyXBh8e46x5PBsKkUyu4q9JgVJJa64To8TjexXmAAY5bNuIc5dsdr7svLG0jwGcs6jCosx7gOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaEJtnvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E02C4CEE4
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739811640;
	bh=9jPG1p/vyE7qseFMSGya/0N/h0GUJ9wVovOnzFqK+vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qaEJtnvUZ1ouHiMqOJK9y3zL6+0bxXipXlV94ft8kRwt3woD+K5N/eGV5HmW9KGfs
	 V8ywjulVqxBbDCaBKcbDwQDDsIaWjZAXOlAbYx/BVzbtbs8Y8T4+EkjpqIpFaVYQVC
	 vUG2J3ZPACGagsy58V0zUnb+/rvNC/HmEinG17nQDR9K5tY+G5olJJFVsY92Ta1Tdl
	 /1mKsnrpb8JzuXF+dzXZHc4Ic0ss1WGTWIZIQumOYqsPHY80l1X1ApbUyXlysbAJWl
	 tn0I5+LBKtRvVSVL2GNndW+B6xbJckGnvCssd0EkLYildtg6XTaRvn9OD5DjCMUInk
	 S/VIQzWLD4iyA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso756341366b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 09:00:40 -0800 (PST)
X-Gm-Message-State: AOJu0Yw53H2Ddgv50jRUkO/kuj0w/wG7wb4VgwNcGja3llGL/apaOlrv
	rSCMONapFEu3rku09DBXnusnGsbWDtiffrRQrbVzOxI3Da5Ip+5KATJTnSs564zXZ6nA8yWoMzr
	6ey1m4R84eyumT1h+wEmCA7lYvKE=
X-Google-Smtp-Source: AGHT+IEujCJr6xzQjE6xa6iAV9C2lE533jxiKTkRQg66v1DCS+NqFG0QyLUeeJl8A0IF4iTKZpHOw+5ByMpzLWaPhuU=
X-Received: by 2002:a17:907:7247:b0:ab7:c6f4:9522 with SMTP id
 a640c23a62f3a-abb70921334mr1065900266b.9.1739811638834; Mon, 17 Feb 2025
 09:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c34c50a035111a83b3cb5c735f9a86a7d47a66c7.1739785941.git.wqu@suse.com>
In-Reply-To: <c34c50a035111a83b3cb5c735f9a86a7d47a66c7.1739785941.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 17 Feb 2025 17:00:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5EtidnOJen9d+tWu5Cu03U5SGhnB=Divp7DeTc=XbiyA@mail.gmail.com>
X-Gm-Features: AWEUYZlI4dxWz4jFNOthHhJjC6tH3aq2xKGrqP0w2lWeKwZtmxwispSqpAGhrHs
Message-ID: <CAL3q7H5EtidnOJen9d+tWu5Cu03U5SGhnB=Divp7DeTc=XbiyA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: output an error message if btrfs failed to find
 the seed fsid
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 9:52=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> If btrfs failed to locate the seed device for whatever reason, mounting
> the sprouted device will fail without any meaning error message:
>
>  # mkfs.btrfs -f /dev/test/scratch1
>  # btrfstune -S1 /dev/test/scratch1
>  # mount /dev/test/scratch1 /mnt/btrfs
>  # btrfs dev add -f /dev/test/scratch2 /mnt/btrfs
>  # umount /mnt/btrfs
>  # btrfs dev scan -u
>  # btrfs mount /dev/test/scratch2 /mnt/btrfs
>  mount: /mnt/btrfs: fsconfig system call failed: No such file or director=
y.
>        dmesg(1) may have more information after failed mount system call.
>  # dmesg | tail -n6
>  [ 1626.369520] BTRFS info (device dm-5): first mount of filesystem 64252=
ded-5953-4868-b962-cea48f7ac4ea
>  [ 1626.370348] BTRFS info (device dm-5): using crc32c (crc32c-generic) c=
hecksum algorithm
>  [ 1626.371099] BTRFS info (device dm-5): using free-space-tree
>  [ 1626.373051] BTRFS error (device dm-5): failed to read chunk tree: -2
>  [ 1626.373929] BTRFS error (device dm-5): open_ctree failed: -2
>
> [CAUSE]
> The failure to mount is pretty straight forward, just unable to find the
> seed device and its fsid, caused by `btrfs dev scan -u`.
>
> But the lack of any useful info is a problem.
>
> [FIX]
> Just add an extra error message in open_seed_devices() to indicate the
> error.
>
> Now the error message would look like this:
>
>  [ 1926.837729] BTRFS info (device dm-5): first mount of filesystem 64252=
ded-5953-4868-b962-cea48f7ac4ea
>  [ 1926.838829] BTRFS info (device dm-5): using crc32c (crc32c-generic) c=
hecksum algorithm
>  [ 1926.839563] BTRFS info (device dm-5): using free-space-tree
>  [ 1926.840797] BTRFS error (device dm-5): failed to find fsid 1980efd3-6=
16e-4815-bd5e-aa0d7c3586e3
>  [ 1926.841632] BTRFS error (device dm-5): failed to read chunk tree: -2
>  [ 1926.842563] BTRFS error (device dm-5): open_ctree failed: -2
>
> Link: https://github.com/kdave/btrfs-progs/issues/959
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0a0776489055..7642fce50c12 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7200,8 +7200,10 @@ static struct btrfs_fs_devices *open_seed_devices(=
struct btrfs_fs_info *fs_info,
>
>         fs_devices =3D find_fsid(fsid, NULL);
>         if (!fs_devices) {
> -               if (!btrfs_test_opt(fs_info, DEGRADED))
> +               if (!btrfs_test_opt(fs_info, DEGRADED)) {
> +                       btrfs_err(fs_info, "failed to find fsid %pU", fsi=
d);

Perhaps add here extra information to have more context like for example:

"failed to find fsid %pU when attempting to open seed devices"

So that it's more clear where the failure is happening.

Thanks.

>                         return ERR_PTR(-ENOENT);
> +               }
>
>                 fs_devices =3D alloc_fs_devices(fsid);
>                 if (IS_ERR(fs_devices))
> --
> 2.48.1
>
>

