Return-Path: <linux-btrfs+bounces-15732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3EB148C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 08:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3052918C0198
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC90261393;
	Tue, 29 Jul 2025 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+Ustv0K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AF211499;
	Tue, 29 Jul 2025 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772038; cv=none; b=spMQiKjoWhj1g5bdUvK/XwvtKgoSe1kF7svJiJPQY19MD1WVwZqLN9/b8zN2PLB8awgfx4YJtxytNBc35Cj4f3ACB6E0sXxW3TLC2TpRC31oRmFSRiDFusmhfqecvO6fcs4n/dFYXRKebRMtDbnuL5KDnw7FsbpdUvJuKvjqle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772038; c=relaxed/simple;
	bh=lcqY03g9FBOmXnyFjqq/PkEWTDu6BRCdVu4/Eyw8ppg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7kgJkPRtggWzMOdfoE3qZ6TGCxSMdh6g+KbKbBBJEb8IsUh+nqD8Dr9nnTsV9mM9fGsbX9H1PCbbQAqIXcHnD0gMHJgmppE+zWEVBPg9PrdueslN9jHUy5MyRefpG5YFAyG3eBEtF7W8HVKKjj5W8kTHOvq86l5PmvR+GmWD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+Ustv0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06143C4CEF8;
	Tue, 29 Jul 2025 06:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772038;
	bh=lcqY03g9FBOmXnyFjqq/PkEWTDu6BRCdVu4/Eyw8ppg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q+Ustv0K1rW2hC1hX3XZV3bAN6UmlAlx+Z3+6mJtcgra7lcQeOIFYpuFo5rU+p7nM
	 ePPE8/IlMaBJMBYyJg1FcN5iOn1rnAezCLmWQelM/3UnqVpvTRFPl9xSbhDaeoqXVG
	 bAlG+1WQuhEKFDeD5O+1C6afX+iWBdKnFIIWupTKacIMnKSg+8hwWWs7y3sr0mfe0e
	 aOnDapDPDrZ6vCJregZHugE+v7Q1a4AId8UG/2sekAYYsGyWmgViE1Ikk1I2w8jVnT
	 935tFb5/Vnvz2Kv1atYM1lHnrY1uAq4nWO7nay/eV4WckQWkvc86fFmFhzARN50kFj
	 U6FBT7hi1YOpg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so802080266b.2;
        Mon, 28 Jul 2025 23:53:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXk2WeXK/I7NXQzlSxE08gshgOltD7EeReXAk69S/9UHABsmmA1cj2w/vhNA6zP+C5aGP5Vyoh6o0a3iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwb0DQ19zn9aYpgqzUewuQs8hj8+okyvoInsPCt8/zXvw2QIKN
	KDyzg/Q6eUjt35T+brG0xZ30LZhUt4eGAdCWvLlevD8PeySc7Cx7FepT6QhBToZuZNXuj04BCXD
	WlpXzNzIkDUXrJm8kYQZykfjKX6/XW0o=
X-Google-Smtp-Source: AGHT+IHBBm+h2BCFEBsqMqFpL1KPN7JHH/Mc15OHLYejtWi63fVPA1+ZUkheeevGvwanhBKf0bzn5BnnBqpxiy5UV5E=
X-Received: by 2002:a17:907:3f16:b0:af4:14d4:23f1 with SMTP id
 a640c23a62f3a-af61c4c158amr1721867166b.3.1753772036537; Mon, 28 Jul 2025
 23:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com> <ec81b0ed49ebfe203d7923f3886776fb74fbaf32.1753769382.git.nirjhar.roy.lists@gmail.com>
In-Reply-To: <ec81b0ed49ebfe203d7923f3886776fb74fbaf32.1753769382.git.nirjhar.roy.lists@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 29 Jul 2025 07:53:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6QxUNCY443AVfwFQ0X3zr6g+Wq=r0Xb3mq0tECEw_yTA@mail.gmail.com>
X-Gm-Features: Ac12FXw3AoVvVOhp2IvGBCCsWgzcgACj_jW8uGgxLr8PXHktgpvFirU61eTqIGc
Message-ID: <CAL3q7H6QxUNCY443AVfwFQ0X3zr6g+Wq=r0Xb3mq0tECEw_yTA@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs/200: Make this test scale with the block size
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org, 
	zlang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 7:24=E2=80=AFAM Nirjhar Roy (IBM)
<nirjhar.roy.lists@gmail.com> wrote:
>
> For large block sizes like 64k on powerpc with 64k
> pagesize it failed because this test was hardcoded
> to work with 4k blocksize.

Where exactly is it hardcoded with 4K blocksize expectations?

The test does 64K writes and reflinks at offsets multiples of 64K (0 and 64=
K).
In fact that's why the test is doing 64K writes and using only the
file offsets 0 and 64K, so that it works with any block size.

> With blocksize 4k and the existing file lengths,
> we are getting 2 extents but with 64k page size
> number of extents is not exceeding 1(due to lower
> file size).

Due to lower file size? How?
The file sizes should be independent of the block size, and be 64K and
128K everywhere.

Please provide more details in the changelog.
Thanks.

> The first few lines of the error message is as follows:
>      At snapshot incr
>      OK
>      OK
>     +File foo does not have 2 shared extents in the base snapshot
>     +/mnt/scratch/base/foo:
>     +   0: [0..255]: 26624..26879
>     +File foo does not have 2 shared extents in the incr snapshot
>     ...
>
> Fix this by scaling the size and offsets to scale with the block
> size by a factor of (blocksize/4k).
>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  tests/btrfs/200     | 24 ++++++++++++++++--------
>  tests/btrfs/200.out |  8 ++++----
>  2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/tests/btrfs/200 b/tests/btrfs/200
> index e62937a4..fd2c2026 100755
> --- a/tests/btrfs/200
> +++ b/tests/btrfs/200
> @@ -35,18 +35,26 @@ mkdir $send_files_dir
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
>
> +blksz=3D`_get_block_size $SCRATCH_MNT`
> +echo "block size =3D $blksz" >> $seqres.full
> +
> +# Scale the test with any block size starting from 1k
> +scale=3D$(( blksz / 1024 ))
> +offset=3D$(( 16 * 1024 * scale ))
> +size=3D$(( 16 * 1024 * scale ))
> +
>  # Create our first test file, which has an extent that is shared only wi=
th
>  # itself and no other files. We want to verify a full send operation wil=
l
>  # clone the extent.
> -$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
> -       | _filter_xfs_io
> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
> -       | _filter_xfs_io
> +$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b $size 0 $size" $SCRATCH_MNT/foo \
> +       | _filter_xfs_io | _filter_xfs_io_size_offset 0 $size
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 $offset $size" $SCRATCH_MNT/=
foo \
> +       | _filter_xfs_io | _filter_xfs_io_size_offset $offset $size
>
>  # Create out second test file which initially, for the first send operat=
ion,
>  # only has a single extent that is not shared.
> -$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
> -       | _filter_xfs_io
> +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $size 0 $size" $SCRATCH_MNT/bar \
> +       | _filter_xfs_io | _filter_xfs_io_size_offset 0 $size
>
>  _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
>
> @@ -56,8 +64,8 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATC=
H_MNT/base 2>&1 \
>  # Now clone the existing extent in file bar to itself at a different off=
set.
>  # We want to verify the incremental send operation below will issue a cl=
one
>  # operation instead of a write operation.
> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
> -       | _filter_xfs_io
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 $offset $size" $SCRATCH_MNT/=
bar \
> +       | _filter_xfs_io | _filter_xfs_io_size_offset $offset $size
>
>  _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
>
> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
> index 306d9b24..4a10e506 100644
> --- a/tests/btrfs/200.out
> +++ b/tests/btrfs/200.out
> @@ -1,12 +1,12 @@
>  QA output created by 200
> -wrote 65536/65536 bytes at offset 0
> +wrote SIZE/SIZE bytes at offset OFFSET
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -linked 65536/65536 bytes at offset 65536
> +linked SIZE/SIZE bytes at offset OFFSET
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 0
> +wrote SIZE/SIZE bytes at offset OFFSET
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  At subvol SCRATCH_MNT/base
> -linked 65536/65536 bytes at offset 65536
> +linked SIZE/SIZE bytes at offset OFFSET
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  At subvol SCRATCH_MNT/incr
>  At subvol base
> --
> 2.34.1
>

