Return-Path: <linux-btrfs+bounces-15432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BA4B00E59
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 00:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5156F542AB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D42292B3E;
	Thu, 10 Jul 2025 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="L7RzkLqg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350123FC74;
	Thu, 10 Jul 2025 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184841; cv=none; b=Vsbbw7MNs6RSS47akrZyGAnnJ65hTvSEqg6NJBf5+gFQyN0wctnVVVMpRWfXokx/VOpMJETv3DF3zObb5J5mWu7teiSWu7EnbrBwof26DBrd0RQlM961JdKFfbVEedBIl93U5Y2MgvTSyFI+ez13gep2O6pUVM1KviQr06R4CtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184841; c=relaxed/simple;
	bh=mFLvlq/sXqCTyhLWuvJC47rR5gikNZuQZVZZYlm8g38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsbkCylMVWFVTv5+YouDrYL2nQAxFJLP4Qflk9U14kPwDfwM8CfsF/3mCCssXxFUUM3yyy6L8H7dkZXaVkCh9qZm+YSreI8oFl6e7zw+qLFKPG16uA5568axn7geL8wy3nV1dKyVfTQiP0zHCDelhn/LrbLD0vCc0a/j8LD1/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=L7RzkLqg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752184836; x=1752789636; i=quwenruo.btrfs@gmx.com;
	bh=9ho8/L+5dWp0hUAoY9u+ymB+WKpequvLnS72Cgtt+Cc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L7RzkLqgBUphvLcoEvcvo8DAVeIIwvXnzxaFNHt4nM+cHTnkmcu+iS+OTJNJ5DWi
	 Sru1tQTyxm3nnTiF2G7XWbAGQHH+IHIcv9U5Zw3NbZwnuUav/lNpveAt8fY2X8ZaI
	 SA7dq8CYGlNNKo9zT50i8DZ/t0I4A0HQb7ccvWQvBsSEk8BvvcmHKE5t9np5uFvPX
	 B1tVIMza5tmppOgbdsucaIab18BepxveQQXMSRVJAHDfW2cT+sXSdhXGEYoAAnpsE
	 TGE9KDBkKJQiHrZwbonDfyV3egqM5kdIZVMYCEP1+qfrTw43CTOrSu5CMc+UkXof0
	 l6NSjzTKJyuYlpjZRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfUe-1uTLUR3DCa-003RU6; Fri, 11
 Jul 2025 00:00:36 +0200
Message-ID: <7f5c6eb7-d1ae-4730-b7ee-daeb2b805e16@gmx.com>
Date: Fri, 11 Jul 2025 07:30:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] generic: test overwriting file with mmap on a full
 filesystem
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>
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
In-Reply-To: <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zcMxsJ33zs7Fe2U838z6ArOfOj8KhxFKXjWFRZatXTWNFQzPaBR
 7sztL/y9aftI9OyMqynneRtwpMC3lSNacU1yvbTomfeK+n6GYQX/eJF1UIp/bWY/AKRdWDJ
 /D41SG6aOlBvnWXY/qiD04bH6u0WKmmQZENnMMh5YfEFejAx6g6pVeGSQ3NUoHTzvWT/SSo
 NQ6zPBRwZ6OwYL7cswgIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:62869leODuI=;NhKIiAOx9hK2sQKGk4iI1AuXvUI
 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
 5zJthT4hj2qYxh/nGmB42vw=



=E5=9C=A8 2025/7/11 02:33, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Test that overwriting a file with mmap when the filesystem has no more
> space available for data allocation works. The motivation here is to che=
ck
> that NOCOW mode of a COW filesystem (such as btrfs) works as expected.
>=20
> This currently fails with btrfs but it's fixed by a kernel patch that ha=
s
> the subject:
>=20
>     btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>=20
> V2: Use _try_scratch_mkfs_sized;
>      Use _get_file_block_size instead of _get_block_size;
>      Add a more detailed comment about why dd is used to fill the fs.
>=20
>   tests/generic/211     | 63 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/211.out |  6 +++++
>   2 files changed, 69 insertions(+)
>   create mode 100755 tests/generic/211
>   create mode 100644 tests/generic/211.out
>=20
> diff --git a/tests/generic/211 b/tests/generic/211
> new file mode 100755
> index 00000000..e87d1e01
> --- /dev/null
> +++ b/tests/generic/211
> @@ -0,0 +1,63 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 211
> +#
> +# Test that overwriting a file with mmap when the filesystem has no mor=
e space
> +# available for data allocation works. The motivation here is to check =
that
> +# NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw mmap
> +
> +. ./common/filter
> +
> +_require_scratch
> +
> +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
> +
> +# Use a 512M fs so that it's fast to fill it with data but not too smal=
l such
> +# that on btrfs it results in a fs with mixed block groups - we want to=
 have
> +# dedicated block groups for data and metadata, so that after filling a=
ll the
> +# data block groups we can do a NOCOW write with mmap (if we have enoug=
h free
> +# metadata space available).
> +fs_size=3D$(_small_fs_size_mb 512)
> +_try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 =
|| \
> +	_fail "mkfs failed"
> +_scratch_mount
> +
> +touch $SCRATCH_MNT/foobar
> +
> +# Set the file to NOCOW mode on btrfs, which must be done while the fil=
e is
> +# empty, otherwise it fails.
> +if [ $FSTYP =3D=3D "btrfs" ]; then
> +	_require_chattr C
> +	$CHATTR_PROG +C $SCRATCH_MNT/foobar
> +fi
> +
> +# Add initial data to the file we will later overwrite with mmap.
> +$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xfs=
_io
> +
> +# Now fill all the remaining space with data. We use dd because we want=
 to fill
> +# only data space in btrfs - creating files with __populate_fill_fs() w=
ould also
> +# fill metadata space. We want to exhaust data space on btrfs but still=
 have
> +# metadata space available, as metadata is always COWed on btrfs, so th=
at the
> +# mmap writes below succeed (metadata space available but no more data =
space
> +# available).
> +blksz=3D$(_get_file_block_size $SCRATCH_MNT)
> +dd if=3D/dev/zero of=3D$SCRATCH_MNT/filler bs=3D$blksz >>$seqres.full 2=
>&1
> +
> +# Overwrite the file with a mmap write. Should succeed.
> +$XFS_IO_PROG -c "mmap -w 0 1M"        \
> +	     -c "mwrite -S 0xcd 0 1M" \
> +	     -c "munmap"              \
> +	     $SCRATCH_MNT/foobar
> +
> +# Cycle mount and dump the file's content. We expect to see the new dat=
a.
> +_scratch_cycle_mount
> +_hexdump $SCRATCH_MNT/foobar
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/211.out b/tests/generic/211.out
> new file mode 100644
> index 00000000..71cdf0f8
> --- /dev/null
> +++ b/tests/generic/211.out
> @@ -0,0 +1,6 @@
> +QA output created by 211
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >..............=
..<
> +*
> +100000


