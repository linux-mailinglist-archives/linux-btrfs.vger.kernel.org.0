Return-Path: <linux-btrfs+bounces-9246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C79B5D81
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 09:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED37281D9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9421E0DFF;
	Wed, 30 Oct 2024 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bxVjmMlx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316741991D8;
	Wed, 30 Oct 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276442; cv=none; b=S9//VtYgyLgwzPOcYnjNpy9CQY6dWbAXUjoCP01HrzwtxXXSXXPTviaP6EsMKRHERV4ozY3CTm7D3uNkkoZOyvD2m0RMcOFV8QrDUvajLw29cWTnlIgJkyjKnLHd/tFh8k4pOOc77vZ9MrDOGLTJJVb585VrLKTsr76rCYE4trg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276442; c=relaxed/simple;
	bh=eHTPMLPPOTrabIceX5qJSw7OjGYrYuNz41ET1XWIihw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP5C9qrGERV8eg1FUK8inLEcMm4WmMijTi2IcmiZQhx4HpFDsKKj2S+g6GnZiXlVA8mYFAibVY/Kb8Vr0t7bwZjPqXYoXQ94n6UctqO4ZC0IhXZqxPeho9Cd5fX170D9drrm26vHt+bYZhRHGUtEW0NlGXMwZAIhZ9l0pHn9sVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bxVjmMlx; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730276431; x=1730881231; i=quwenruo.btrfs@gmx.com;
	bh=kwm6T/WhFWZ2g7ulHCgHjFJbClMCQRs2F6Q1MEL3Gqw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bxVjmMlxZ8omfkYGiAG9ZRbouMMxmwi+J8ah1f2xktliYk9Td8r4oyD8EaDik1Lx
	 o2i/Ijrx+67Kd3ImtbelHH7o3f5Ny0TNofLSnuAs+z072zDNv3UVECEbzytiBtC2q
	 9g8A4Et/ZsCyBAdMMhf3OyKcFUnBdSgNQqG3amkbD61TkbHwL5H1EfnBDkOsMv/X/
	 IRa3Xx6WRWoMlmc5DMsTKKuUPH+jz32/qgB1PlUoXHVz3V4Ihy/Jn2e2NeYOzaDys
	 uMlkyxwG8xSUaHCBLyb99JhAkBIVNrFXr4LBmmb55++HnF2WHVlDGWBSfRmMcQ6jK
	 9FOZR8rjJyTLudfdWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McpJg-1tffwL0Uja-00fjs0; Wed, 30
 Oct 2024 09:20:31 +0100
Message-ID: <a3e41a97-aa8a-4553-b184-adc89c201177@gmx.com>
Date: Wed, 30 Oct 2024 18:50:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: add a test for defrag of contiguous file
 extents
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <e592bcc458f5c2ec41930975003702a667c92a8e.1730220751.git.fdmanana@suse.com>
 <fc85e9cdeb879a76b78229c374c96b37776d222b.1730274466.git.fdmanana@suse.com>
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
In-Reply-To: <fc85e9cdeb879a76b78229c374c96b37776d222b.1730274466.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g3yS15fM1NuUwHpm1I6/t6n9KypCHShfgQTHy/yOj2FF4udaw+o
 BhiMEofX7WOD7mlgJkQZUavMavd7L2l2CUQrh5a9FqIML0yEU3GOPXPqOUVZ0zuUKrrsZo7
 TwoRjmGLXbY31qkbhEwlp9o4ET3p5AGrwt4KB4tjLYyaZ6btdsdHd86zzyWjjMiKw/Wxt+b
 mGY3eeFcbno/g8sqBRDXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YAx1RfKdIN8=;tsvqFpZsUOW4UhdnR9ttWMW+BCk
 6X0vR0/Y+jTY5/lAfuRuR8GCdbVbsHJdCpgJQlg3ZmAibLhjl2nSFFu807Bug0mHCzQHDFqph
 VUquddupETWgJJS/BxxVJKn6F+f6g0QJkDgFqBstwkAWQGWdFNloNXrTMRK6npgHqk3Qzfq7X
 C4pEXwmwpY4ueTL/Ybvh06290Fppmp98KCI1rlHDCCeLNryRWiafNxsacE7K7PcAPEMY2thFd
 CAInuboTJMcdAAjdJx3+zJxBl57nPZbRGddGWTkY4VylrKicLGCjkfGiMIR/RIBBdVuKcdNAT
 FRWzlqi1HNF6lDmwkOMmMxe/rZhLWk2thCHLlsvKPqCQRTMhRbXqplhVHecZl/F4hf9tRnMF1
 nLPwFFfXduP0TWdWnbsbJD4r9d8o82hkebwm02IuPDca9/WnkcQrN2ARWrUYUujc4Mj7e0nfP
 DYKcs+upQzs/tE3CsLAdVM0b9Df5QjeG8OVRkv3VFZp+H/zBbsrOaEOkJeT0nFjMxSJY8zI0T
 vt33jHQvnF2opaD+Bfl/h4cbVLEOeAY6TPimppsdUVc/bxSeO4r4dSpj/eUH5swYYTRbP+wJS
 rNlDezW+1AdwUa2QIGPleoaogjqe//qsSvMLCxDhZMyCdg/83bz/tn4V7akY3c+zLv3TI/Xnp
 pZh53ZWaOmHYSFB1g6SQMrH9jfdI1xKDw9zBDrEV3CZsBYx2VBpT+PeJLikShznZucYOouLcS
 hIDASFLVKhvYI3vN5IDRyXWs+PMA3FXS7C1XrbGM6wF24+idHkLm4FlQt1d1nheIkqL+NuxGA
 F5TfZySWoKNeGvqnqvEmSXVw==



=E5=9C=A8 2024/10/30 18:20, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Test that defrag merges adjacent extents that are contiguous.
> This exercises a regression fixed by a patchset for the kernel that is
> comprissed of the following patches:
>
>    btrfs: fix extent map merging not happening for adjacent extents
>    btrfs: fix defrag not merging contiguous extents due to merged extent=
 maps
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> V2: Fix typo (treshold -> threshold), make the test be skipped if compre=
ssion
>      is enabled.
>
>   tests/btrfs/325     | 83 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/325.out | 22 ++++++++++++
>   2 files changed, 105 insertions(+)
>   create mode 100755 tests/btrfs/325
>   create mode 100644 tests/btrfs/325.out
>
> diff --git a/tests/btrfs/325 b/tests/btrfs/325
> new file mode 100755
> index 00000000..48470509
> --- /dev/null
> +++ b/tests/btrfs/325
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 325
> +#
> +# Test that defrag merges adjacent extents that are contiguous.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick preallocrw defrag
> +
> +. ./common/filter
> +
> +_require_scratch
> +_require_btrfs_command inspect-internal dump-tree
> +_require_xfs_io_command "falloc"
> +# We want to test getting a 256K extent after defrag, so skip the test =
if
> +# compression is enabled (with compression the maximum extent size is 1=
28K).
> +_require_no_compress
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix extent map merging not happening for adjacent extents"
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix defrag not merging contiguous extents due to merged extent=
 maps"
> +
> +count_file_extent_items()
> +{
> +	# We count file extent extent items through dump-tree instead of using
> +	# fiemap because fiemap merges adjacent extent items when they are
> +	# contiguous.
> +	# We unmount because all metadata must be ondisk for dump-tree to see
> +	# it and work correctly.
> +	_scratch_unmount
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV | \
> +		grep EXTENT_DATA | wc -l
> +	_scratch_mount
> +}
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# Create a file with a size of 256K and 4 written extents of 64K each.
> +# We fallocate to guarantee exact extent size, even if compression moun=
t
> +# option is give, and write to them because defrag skips prealloc exten=
ts.
> +$XFS_IO_PROG -f -c "falloc 0 64K" \
> +	     -c "pwrite -S 0xab 0 64K" \
> +	     -c "falloc 64K 64K" \
> +	     -c "pwrite -S 0xcd 64K 64K" \
> +	     -c "falloc 128K 64K" \
> +	     -c "pwrite -S 0xef 128K 64K" \
> +	     -c "falloc 192K 64K" \
> +	     -c "pwrite -S 0x73 192K 64K" \
> +	     $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +echo -n "Initial number of file extent items: "
> +count_file_extent_items
> +
> +# Read the whole file in order to load extent maps and merge them.
> +cat $SCRATCH_MNT/foo > /dev/null
> +
> +# Now defragment with a threshold of 128K. After this we expect to get =
a file
> +# with 1 file extent item - the threshold is 128K but since all the ext=
ents are
> +# contiguous, they should be merged into a single one of 256K.
> +$BTRFS_UTIL_PROG filesystem defragment -t 128K $SCRATCH_MNT/foo
> +echo -n "Number of file extent items after defrag with 128K threshold: =
"
> +count_file_extent_items
> +
> +# Read the whole file in order to load extent maps and merge them.
> +cat $SCRATCH_MNT/foo > /dev/null
> +
> +# Now defragment with a threshold of 256K. After this we expect to get =
a file
> +# with only 1 file extent item.
> +$BTRFS_UTIL_PROG filesystem defragment -t 256K $SCRATCH_MNT/foo
> +echo -n "Number of file extent items after defrag with 256K threshold: =
"
> +count_file_extent_items
> +
> +# Check that the file has the expected data, that defrag didn't cause a=
ny data
> +# loss or corruption.
> +echo "File data after defrag:"
> +_hexdump $SCRATCH_MNT/foo
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
> new file mode 100644
> index 00000000..c0df8137
> --- /dev/null
> +++ b/tests/btrfs/325.out
> @@ -0,0 +1,22 @@
> +QA output created by 325
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 65536
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 131072
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 196608
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Initial number of file extent items: 4
> +Number of file extent items after defrag with 128K threshold: 1
> +Number of file extent items after defrag with 256K threshold: 1
> +File data after defrag:
> +000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >..............=
..<
> +*
> +010000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >..............=
..<
> +*
> +020000 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef  >..............=
..<
> +*
> +030000 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73  >ssssssssssssss=
ss<
> +*
> +040000


