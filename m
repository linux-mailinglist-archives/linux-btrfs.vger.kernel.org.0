Return-Path: <linux-btrfs+bounces-11533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8215A399E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 12:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B073B301B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3332723958C;
	Tue, 18 Feb 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J95lmcoS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF122E002
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876840; cv=none; b=d7XCgOrI9KSdFgnj/rYmlFvCouJWu6p1hQxT/Uo1LI3tNUFM4gGKOPfOsFXs0iL/dFEH2yO9eDBmIPgYDatZ9CXpp9MNptqFcRLIj7/IVTImeM8bIWYsPX1v9fC5Yo+k7Icc0LU62O1ALB2IIWHcl59hwXjDQRyryYLforci0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876840; c=relaxed/simple;
	bh=n/hUTXMxwkKi3G/6eUuDjQOOuqAhrNhCbQSqkqsJYMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCg5Uddu0VjdaB1FOhL3QLQoMne4XNRJJvIByYtGtJlKO4ifWus0i12WV1DemwpGyFojqdUv+sGJhvFRREjhsTmJfrS5Giv411Lh4vDpVzEFobcPywYw/pN14gYrGa7/fF9glifEHlnePbVXvpbwvieM0kShAe+JTjU6g78LzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J95lmcoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0188BC4AF09
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739876840;
	bh=n/hUTXMxwkKi3G/6eUuDjQOOuqAhrNhCbQSqkqsJYMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J95lmcoSuLgh+6hP0QIUcx/RP2BlDXxlNPOmbwCZeEgM/gkfDn52A7Uta6JqVvAll
	 AuK9kdGhdKhTcs4htmn+x+n/MAZER5aBuh54wiBdscNlvpn3Kng7eUnhQRArVQorgY
	 vRUkY2ozxRrWluQUl+nob89I0U6YYIHUVt4jGtBjGfToc/Jylil80/SjrGSBmLghbP
	 cPEsWo3c6ecnUTuGYzdCq58/LqFcmyoovIvV3BNNxUokZq1xFbdBO5jLMycX2VaZr2
	 GFh1UFmKTPgiGkQdA6fywAKv8gWmGqHRovgkT24ntZ0R+NWqPZciIfAwFoE1uaBcwH
	 zLNoFM1GAeG5Q==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1069236566b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 03:07:19 -0800 (PST)
X-Gm-Message-State: AOJu0YztpCzzWc/D58Y5n7wOsQT4c7c6IbV9w+Pr5UCmVpaAb/zbEW4y
	g4LmXYjDdh5qXucygYnZuRnM7zXBxN/luJIMeL9lpPyqE//O+giUvxtdJSxCY3M/MoE86K1f+3T
	JEmPFGpTSjpTK75Wzv0NS3aHSlcE=
X-Google-Smtp-Source: AGHT+IGJAz30K3Z1O7VXivJzarJkhDdSXnO48DA+7ctqU9jTTQe/dghhWQllctiIqyW39fbq1Yzd+2xs5dVU3meENRY=
X-Received: by 2002:a17:907:1b12:b0:ab7:a39:db4 with SMTP id
 a640c23a62f3a-abb7115103fmr1418068466b.57.1739876838554; Tue, 18 Feb 2025
 03:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82088d8a206ac6187b994a4f9f21876773cf036b.1739831055.git.wqu@suse.com>
In-Reply-To: <82088d8a206ac6187b994a4f9f21876773cf036b.1739831055.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 18 Feb 2025 11:06:41 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4p4_knhgzZt1ze8B7Tb3yFdbp5E6QnkK9gjvMZh9XVPw@mail.gmail.com>
X-Gm-Features: AWEUYZlQKIjgEmv6wdE-idfXxQG5D7HzBjgdGSaSwkpbmLrIohS9Z5M9wxB0zRY
Message-ID: <CAL3q7H4p4_knhgzZt1ze8B7Tb3yFdbp5E6QnkK9gjvMZh9XVPw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: output an error message if btrfs failed to find
 the seed fsid
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 10:26=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> If btrfs failed to locate the seed device for whatever reason, mounting
> the sprouted device will fail without any meaningful error message:
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
>  # dmesg -t | tail -n6
>  BTRFS info (device dm-5): first mount of filesystem 64252ded-5953-4868-b=
962-cea48f7ac4ea
>  BTRFS info (device dm-5): using crc32c (crc32c-generic) checksum algorit=
hm
>  BTRFS info (device dm-5): using free-space-tree
>  BTRFS error (device dm-5): failed to read chunk tree: -2
>  BTRFS error (device dm-5): open_ctree failed: -2
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
>  BTRFS info (device dm-4): first mount of filesystem 7769223d-4db1-4e4c-a=
c29-0a96f53576ab
>  BTRFS info (device dm-4): using crc32c (crc32c-generic) checksum algorit=
hm
>  BTRFS info (device dm-4): using free-space-tree
>  BTRFS error (device dm-4): failed to find fsid e87c12e6-584b-4e98-8b88-9=
62c33a619ff when attempting to open seed devices
>  BTRFS error (device dm-4): failed to read chunk tree: -2
>  BTRFS error (device dm-4): open_ctree failed: -2
>
> Link: https://github.com/kdave/btrfs-progs/issues/959
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changelog:
> v2:
> - Enhance the error message to show a little more details
> - Remove the dmesg timestamp from commit message
> ---
>  fs/btrfs/volumes.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0a0776489055..fb22d4425cb0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7200,8 +7200,12 @@ static struct btrfs_fs_devices *open_seed_devices(=
struct btrfs_fs_info *fs_info,
>
>         fs_devices =3D find_fsid(fsid, NULL);
>         if (!fs_devices) {
> -               if (!btrfs_test_opt(fs_info, DEGRADED))
> +               if (!btrfs_test_opt(fs_info, DEGRADED)) {
> +                       btrfs_err(fs_info,
> +               "failed to find fsid %pU when attempting to open seed dev=
ices",
> +                                 fsid);
>                         return ERR_PTR(-ENOENT);
> +               }
>
>                 fs_devices =3D alloc_fs_devices(fsid);
>                 if (IS_ERR(fs_devices))
> --
> 2.48.1
>
>

