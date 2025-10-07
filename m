Return-Path: <linux-btrfs+bounces-17508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE2BC1309
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 13:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F5C18932AB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232802DC334;
	Tue,  7 Oct 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFVXaAIS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB12D9EC2
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836031; cv=none; b=gy5rRrNUNtf9EUTSMOOXYTwoijXkIan4okyMve10xUZIqY7NnP0AwVis9Eaw1KYR9ThXZnQm3e7zIXsouUvdi2ABHwI9wx/miR+0zHa4tNmKE+jV5ESqRMwo0UlpvlWJNcy/xbcBxPHxBM81V1odEG8uP2DUMH69unYcXc5mJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836031; c=relaxed/simple;
	bh=qB7KKknx1+FFhRzBibonia8JtzQkm7WqwbVVOprN6dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSZr+GjCz0N5cDf11+ouRVzmVbj1LxUqZLzkx6CD5n1PpZTTLdThprDyBhE7WNn9SEq1h0QnKaf+RlM1I4Wh9042watCFgvveyG9uZMGKqzYoyBU9L4ALYPFjKnb0fKCFuqptFkjpEzYfUU7vDJ8RmegaZzo1JWOCAI+HqbShZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFVXaAIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16517C4CEFE
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759836031;
	bh=qB7KKknx1+FFhRzBibonia8JtzQkm7WqwbVVOprN6dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mFVXaAISSdjCvFTIGjvBcvz93QMKNqGBvfBZ8CDCKgD59fCLwToLZ/2jNkoCKq50y
	 RGIuVOq8nhmjYXVAqmwTM/Kp9sZfOJ2ZqhFp8oymaSwP1jnd7B0rG68tQU7AtV0Ym2
	 SxXsJqoVXmaaJrpIAQGxwUf4rHerHcnnzbbJ4J547d+cFQZQE9Df7hpCG8/Rn8ZWRL
	 ycF6AHcMygX4IASKrJslHT7tUYoUnxYHnLrVcZP+3C37CBfiwyEVoSb0jn63eRwioz
	 O0DjpiHbsMXqEwZ9hgVoQM8g3rR4vDZo4iDFQO1JfAow1LRulGbfJhS4+SVZI8i8/+
	 AQokDkQgIZZXw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e9d633b78so928501866b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Oct 2025 04:20:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVO93xK9/GN4ZiwwgkGuJ6YgrNEg56RdXqSUg1cLU8WOePEHNeZB5xWy9WXeNHFPRclb8n43v9BWYeUwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza0IGEqRtu8r/dRyQSKeQhURN3axgxNZFdOGSDDmdXT0/af0xS
	7BnkJqeXuBDbmYLvXwJfXAMt50mxnzFCK/mbAFYtrcd3tL9AWRl4uQShceG6gUdmE+TzNkIXvvJ
	ocKmc57vJLA1dSsYLMj3VVHJJCq1dWw8=
X-Google-Smtp-Source: AGHT+IGE8N1TyBfC4qxygdIrwEqi/JTIR2DrGIRY1GQPEc4tSVul6iuTI48xyOxEMESshhnMeOGzJg2TdbFq9b0mBU8=
X-Received: by 2002:a17:907:c086:b0:b3d:6645:a6f1 with SMTP id
 a640c23a62f3a-b4f4372f2c6mr403480766b.29.1759836029647; Tue, 07 Oct 2025
 04:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com> <c93a0f1885721e7bc2800094fafb7fd7bd2c607b.1758036285.git.nirjhar.roy.lists@gmail.com>
In-Reply-To: <c93a0f1885721e7bc2800094fafb7fd7bd2c607b.1758036285.git.nirjhar.roy.lists@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 7 Oct 2025 12:19:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4aWoe3QmPTv8N1-HCS_ChO4bm=eWdBAbsRBUdX4BxO1Q@mail.gmail.com>
X-Gm-Features: AS18NWBcAQwOxHC0TYCN5sOQ1RXpjlF7vUb_LYajQfvp0S31jv48ZU6WnF5AhgY
Message-ID: <CAL3q7H4aWoe3QmPTv8N1-HCS_ChO4bm=eWdBAbsRBUdX4BxO1Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs/200: Make the test compatible with all
 supported block sizes
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com, 
	djwong@kernel.org, quwenruo.btrfs@gmx.com, zlang@kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:31=E2=80=AFPM Nirjhar Roy (IBM)
<nirjhar.roy.lists@gmail.com> wrote:
>
> This test fails on 64k block size with the following error:
>
>      At snapshot incr
>      OK
>      OK
>     +File foo does not have 2 shared extents in the base snapshot
>     +/mnt/scratch/base/foo:
>     +   0: [0..255]: 26624..26879
>     +File foo does not have 2 shared extents in the incr snapshot
>
> So, basically after btrfs receive, the file /mnt/scratch/base/foo
> doesn't have any shared extents in the base snapshot.
> The reason is that during btrfs send, the extents are not cloned
> and instead they are written.
> The following condition is responsible for the above behavior
>
> in function clone_range():
>
>         /*
>          * Prevent cloning from a zero offset with a length matching the =
sector
>          * size because in some scenarios this will make the receiver fai=
l.
>          *
>          * For example, if in the source filesystem the extent at offset =
0
>          * has a length of sectorsize and it was written using direct IO,=
 then
>          * it can never be an inline extent (even if compression is enabl=
ed).
>          * Then this extent can be cloned in the original filesystem to a=
 non
>          * zero file offset, but it may not be possible to clone in the
>          * destination filesystem because it can be inlined due to compre=
ssion
>          * on the destination filesystem (as the receiver's write operati=
ons are
>          * always done using buffered IO). The same happens when the orig=
inal
>          * filesystem does not have compression enabled but the destinati=
on
>          * filesystem has.
>          */
>         if (clone_root->offset =3D=3D 0 &&
>             len =3D=3D sctx->send_root->fs_info->sectorsize)
>                 return send_extent_data(sctx, dst_path, offset, len);
>
> Since we are cloning from the first half [0 to 64k), clone_root->offset =
=3D 0
> and len =3D 64k which is the sectorsize (sctx->send_root->fs_info->sector=
size).
> Fix this by increasing the file size and offsets to 128k so that
> len =3D=3D sctx->send_root->fs_info->sectorsize is not true.
>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Please always cc the btrfs mailing list when doing changes to btrfs test ca=
ses.

> ---
>  tests/btrfs/200     | 8 ++++----
>  tests/btrfs/200.out | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tests/btrfs/200 b/tests/btrfs/200
> index e62937a4..b53955ce 100755
> --- a/tests/btrfs/200
> +++ b/tests/btrfs/200
> @@ -38,14 +38,14 @@ _scratch_mount
>  # Create our first test file, which has an extent that is shared only wi=
th
>  # itself and no other files. We want to verify a full send operation wil=
l
>  # clone the extent.
> -$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
> +$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 128K 0 128K" $SCRATCH_MNT/foo \
>         | _filter_xfs_io
> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 128K 128K" $SCRATCH_MNT/foo =
\
>         | _filter_xfs_io
>
>  # Create out second test file which initially, for the first send operat=
ion,
>  # only has a single extent that is not shared.
> -$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
> +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 128K 0 128K" $SCRATCH_MNT/bar \
>         | _filter_xfs_io
>
>  _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
> @@ -56,7 +56,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATC=
H_MNT/base 2>&1 \
>  # Now clone the existing extent in file bar to itself at a different off=
set.
>  # We want to verify the incremental send operation below will issue a cl=
one
>  # operation instead of a write operation.
> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 128K 128K" $SCRATCH_MNT/bar =
\
>         | _filter_xfs_io
>
>  _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
> index 306d9b24..a33b3c1e 100644
> --- a/tests/btrfs/200.out
> +++ b/tests/btrfs/200.out
> @@ -1,12 +1,12 @@
>  QA output created by 200
> -wrote 65536/65536 bytes at offset 0
> +wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -linked 65536/65536 bytes at offset 65536
> +linked 131072/131072 bytes at offset 131072
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 0
> +wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  At subvol SCRATCH_MNT/base
> -linked 65536/65536 bytes at offset 65536
> +linked 131072/131072 bytes at offset 131072
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  At subvol SCRATCH_MNT/incr
>  At subvol base
> --
> 2.34.1
>

