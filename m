Return-Path: <linux-btrfs+bounces-15826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE47B19AB4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 06:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8807A406D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 04:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60E1E7C1B;
	Mon,  4 Aug 2025 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Sn9o4Rhu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B517BA9;
	Mon,  4 Aug 2025 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754281197; cv=none; b=reSXOe31P6+BaeYNeGnDPGRV8t8BVra+Dev8qBNfBV1Rqiu4gn8vFrLzvRyKe7d+oOOF3qnuhepzV175BH/uXn065R/pHLSwlkfhPTr41QD2hwmVk+mrAiRa/dE5iSbqRD4JOOj0+djZwrEW3sdKlmAhv6Ye8VfOahljp2R9Wpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754281197; c=relaxed/simple;
	bh=9naKNlJnCm4NgZE3y9RkEwGdHp/r9sBFkMR1fVzKUo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZvzR6iITS7pdzW5U94OqcWPkQDXCu2vv0rDJlgqNnG2MhUI885dW7WdBJL7Tq0Wi34NR9QjUFFGrFhwNEEJLNHuWOsRfXTRHPqxn7CMPhyrdpPcqVuh+O1xoEvVd89x/nh/Hn362hC5CysEWMUZizHkLCr3fT0Dldomt2jgqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Sn9o4Rhu; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754281185; x=1754885985; i=quwenruo.btrfs@gmx.com;
	bh=StI6DkpbEy9BX3DC2A1su8VtP+qNXWXK0qba1SWL3LI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sn9o4RhulBVh4h1tRR2MeBi5taIKpqvl+NZLShuNLbeNU64glIst05IbGbku5eG3
	 b8FjLR/T4FztqqJl924xGnsqMsggKO2RBt8jSmWS0+Fpj7QsUjmf6glRSmE8WvQ14
	 Bps+dJ5sryKvsJCMIb3RzssJZSY6iaBEZ7C+itUq30lp4auFpIuTIc1/upISsAUHG
	 jRfAhic7D3gm9NfiGPewiBYGgKgz5auvw/Jhb2lY0XuIDKluIzqhbpFd46qzl83y4
	 bn3hsFl7Mk2gsXtwYXdxcn0+bkEwow5lERTCunZpzusQ+hNLmzhyuFQY0VkEA443q
	 /n2TtHAbnEPEfcdXNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmfi-1vBydx1nqM-00Y2tq; Mon, 04
 Aug 2025 06:19:45 +0200
Message-ID: <dec1d1f0-896b-4b9f-bc78-a21e2f9aecfc@gmx.com>
Date: Mon, 4 Aug 2025 13:49:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] btrfs/200: Make this test scale with the block size
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <ec81b0ed49ebfe203d7923f3886776fb74fbaf32.1753769382.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <ec81b0ed49ebfe203d7923f3886776fb74fbaf32.1753769382.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3xedAZ8gWvXCNCacCgUN9gJpyRJLSkijzv3GYDXH1UKAGk9gJl0
 N3GiiPtBe0FryGuw/GT3DaEVgPtAoN87yOomOh+AGmRtaGGqeK+zPyZERqipke4gf/ub/Di
 xUOAIvAQSdyY2GXC402mNdvqKG9Ex/4GVmtUqOAn/uC+3eybbGW8BBil9pLP1z+YoGEy6hR
 RGfol5KvErJSRcDOt184g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oJQUnhf57Y4=;8cmkXnd1RcG+V9sccZI8vhamKCW
 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



=E5=9C=A8 2025/7/29 15:51, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
> For large block sizes like 64k on powerpc with 64k
> pagesize it failed because this test was hardcoded
> to work with 4k blocksize.
> With blocksize 4k and the existing file lengths,
> we are getting 2 extents but with 64k page size
> number of extents is not exceeding 1(due to lower
> file size).
> The first few lines of the error message is as follows:
>       At snapshot incr
>       OK
>       OK
>      +File foo does not have 2 shared extents in the base snapshot
>      +/mnt/scratch/base/foo:
>      +   0: [0..255]: 26624..26879
>      +File foo does not have 2 shared extents in the incr snapshot
>      ...
>=20
> Fix this by scaling the size and offsets to scale with the block
> size by a factor of (blocksize/4k).

Although I can reproduce the bug on aarch64 with 64K page size, the=20
changelog doesn't seem to explain the problem.

The problem is after receive, the file base/foo is a single extent, not=20
the original reflinked two extent.

And the original fs is indeed have the correct two extents layout.


That different extent layout is definitely not explained properly in the=
=20
commit message.

Furthermore the test case is already using 64K block size for extents=20
creation, thus all supported block size should work.


So I think the change doesn't really touch the core of the failure.

Thanks,
Qu
>=20
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   tests/btrfs/200     | 24 ++++++++++++++++--------
>   tests/btrfs/200.out |  8 ++++----
>   2 files changed, 20 insertions(+), 12 deletions(-)
>=20
> diff --git a/tests/btrfs/200 b/tests/btrfs/200
> index e62937a4..fd2c2026 100755
> --- a/tests/btrfs/200
> +++ b/tests/btrfs/200
> @@ -35,18 +35,26 @@ mkdir $send_files_dir
>   _scratch_mkfs >>$seqres.full 2>&1
>   _scratch_mount
>  =20
> +blksz=3D`_get_block_size $SCRATCH_MNT`
> +echo "block size =3D $blksz" >> $seqres.full
> +
> +# Scale the test with any block size starting from 1k
> +scale=3D$(( blksz / 1024 ))
> +offset=3D$(( 16 * 1024 * scale ))
> +size=3D$(( 16 * 1024 * scale ))
> +
>   # Create our first test file, which has an extent that is shared only =
with
>   # itself and no other files. We want to verify a full send operation w=
ill
>   # clone the extent.
> -$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
> -	| _filter_xfs_io
> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
> -	| _filter_xfs_io
> +$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b $size 0 $size" $SCRATCH_MNT/foo \
> +	| _filter_xfs_io | _filter_xfs_io_size_offset 0 $size
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 $offset $size" $SCRATCH_MNT=
/foo \
> +	| _filter_xfs_io | _filter_xfs_io_size_offset $offset $size
>  =20
>   # Create out second test file which initially, for the first send oper=
ation,
>   # only has a single extent that is not shared.
> -$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
> -	| _filter_xfs_io
> +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $size 0 $size" $SCRATCH_MNT/bar \
> +	| _filter_xfs_io | _filter_xfs_io_size_offset 0 $size
>  =20
>   _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
>  =20
> @@ -56,8 +64,8 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRAT=
CH_MNT/base 2>&1 \
>   # Now clone the existing extent in file bar to itself at a different o=
ffset.
>   # We want to verify the incremental send operation below will issue a =
clone
>   # operation instead of a write operation.
> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
> -	| _filter_xfs_io
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 $offset $size" $SCRATCH_MNT=
/bar \
> +	| _filter_xfs_io | _filter_xfs_io_size_offset $offset $size
>  =20
>   _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
>  =20
> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
> index 306d9b24..4a10e506 100644
> --- a/tests/btrfs/200.out
> +++ b/tests/btrfs/200.out
> @@ -1,12 +1,12 @@
>   QA output created by 200
> -wrote 65536/65536 bytes at offset 0
> +wrote SIZE/SIZE bytes at offset OFFSET
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -linked 65536/65536 bytes at offset 65536
> +linked SIZE/SIZE bytes at offset OFFSET
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 0
> +wrote SIZE/SIZE bytes at offset OFFSET
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   At subvol SCRATCH_MNT/base
> -linked 65536/65536 bytes at offset 65536
> +linked SIZE/SIZE bytes at offset OFFSET
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   At subvol SCRATCH_MNT/incr
>   At subvol base


