Return-Path: <linux-btrfs+bounces-7149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFBC94F991
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 00:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29E51F22804
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5C198E60;
	Mon, 12 Aug 2024 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gL47Ksy4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253D1953B9;
	Mon, 12 Aug 2024 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501694; cv=none; b=ALurt7XTqyZEC+WOhL5lxxD5irJ+MT7hNMpNhnHe2xLNk1425dcCCBYFkPOTp6r9pTUqiry0XgZwoj4TIGkaEzyTcu+5uq8bjYRTwnTV1sHLaVv23/eXtAqMt9o7+KYIjWEevOZV3+2WwQtR16kxxE9NQjgmlYKibQUI572YWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501694; c=relaxed/simple;
	bh=atsVwzSVtfxfiZRiO1gVOtOGM9DNb1f1BSKbBtweVoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+EP++gm2+iqcHQlTw5pE9DMmjFy6HUwXZiJKL/FR+FUFelhoi8VvOmXoUewqc+igbdFX1ISfXjYfD3aU/YQV4p0qyrJxMIIFUnaMAyO89uulYAoAvQiLWwaQ+TX1nv3jNzBMp2hVRNdfhtqDU/yTi2LqD2xsQDT+i3lrDRgX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gL47Ksy4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723501685; x=1724106485; i=quwenruo.btrfs@gmx.com;
	bh=0D9c8sf/2Gzor6Zv4ICks0gy+Gq0CyVMTT6+yfYcdTg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gL47Ksy4ESTwuWUc5xdBvW0gvKtR3sBsStSXAw8m6vTfBX3arHgAmsmFRm4+rGJW
	 AyK/3y4dYatUn8VPaAc0L9VqjuYJdiYH84CbsBEVUzBuyvSVc/p2tsiTzKgK1baNW
	 Y5A0KmH45nTELpZbuc299pY/5rTFoVzQ5NDU0d87xyb2tC/yJbd/dghai+J/ZBhkO
	 3N0JuznBZQysCouQrkYHsrHKBQhDOZKslyUoZqb/GFezUNmVs43NKohO9TmzAUBZC
	 YtvjnxmBzKkFEHj7YRGf2yOsNZc2BR4gl0waNGTkM9YOtpP+ZDXRR+FWjvhZKEU7Z
	 M99LI935zQ0JFTOI+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7QxB-1s7z6P3cMf-016Vo8; Tue, 13
 Aug 2024 00:28:05 +0200
Message-ID: <7313c002-db31-415e-897a-f3d1bcab1587@gmx.com>
Date: Tue, 13 Aug 2024 07:58:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: test send clones extents with unaligned end offset
 ending at i_size
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <177f429d65afb5cc99a7f950779ba15b130cd581.1723470203.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <177f429d65afb5cc99a7f950779ba15b130cd581.1723470203.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z7mnqbWFC2tGSZsaHpR75H+Pql4zy1jQnQlOq43ns8FBRv2FXZZ
 ssqKfEsszgY13Cm7Y0bLbXORi6dC2QOf/VYt/3cxcwjYijuwFQ7vZrFiCJW1evuACc52+Xf
 wyz4CeG406FOwgQo/HuzSUyNlj9GxNVWBEAlc8F8y8GzWHPODU4bcvWtg9NjF9UGGYSiZR5
 pMfqgyeByHis+ZtySCjeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fFawV79vZHo=;0HGppEyA8cWD/VqE1jVAP4uS8im
 Ahad5cdo1VBjVHT039qbO22gv1Fo/kohd/YJLC4jKOsQ6U+tZepHboUC5ThuW3lJXGDXDLibj
 MAk1NNJ5QGwonXZh+qvmRc5rUNCEbF4vRrfgiQxJX+9Q+nfFX35n+ZSxTxiJ8IgCkhc9EBkBB
 4QPBX7bivotOHxhK7QgiHBsekIMuU6YsGHdBhHgjfjRBBoDyJiK0m/HRGU0CI3Ya2JAcOk49r
 dMDuH/5Of0uphwIaAKhjtfWWlR90Eoo5r4lHlvfZvNwYLY9axz6kvBmZpexYBIh5MdQ8/+Xqz
 NLh5wTnbk8zK5qnm7KMHapSzTQJrVZq8Hv1RLPpZ29F8DUCq6Fvl+NK9aHCVJ0qBgfIs6ehwo
 UCFG/hYnC4gJYygdH7X3kyjm6O1SccqN0uS9XGk6VZUllpK9nIboUc/Xwe8U5Xo97DrYhiPzO
 frahdMXjjKaWHEudcWICmHa4i2FsahIkKs2RgVWancnYIcyujGxYHtpZrOaoigYJwKDfrzoS6
 l2MURNbkM2RcVWQTztP5myuIjKzV3oxWbomp7XYbzy/2qHFO43XVRGYXOhqrLLxcCZnSOK3N3
 LDpIcU65sgqtGJ1FKQhOqbWuk6aV/D5aqt0VGK+rDX1WUBEjkT5DhZhM2Z5XOH0D40l/++Im+
 ah1Oj7VxmcEoDeLyvq7yKxSTjQAZynrFRIMMx5SxVMjBlulIl7JoN1IT7VD+wXrhKI+4ULhW1
 lsSNXo0FAITfUgx0/nNeMMkkHz8yp+JwqwOHeQB1WxB8Xkk12vQS5WNiS0n7U6W2nbQB8IKE6
 d8rHL9RJ1ch3Qw2RttkzjqYw==



=E5=9C=A8 2024/8/12 23:21, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Test that a send operation will issue a clone operation for a shared
> extent of a file if the extent ends at the i_size of the file and the
> i_size is not sector size aligned.
>
> This verifies an improvement to the btrfs send feature implemented by
> the following kernel patch:
>
>    "btrfs: send: allow cloning non-aligned extent if it ends at i_size"
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/btrfs/319     | 80 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/319.out | 16 +++++++++
>   2 files changed, 96 insertions(+)
>   create mode 100755 tests/btrfs/319
>   create mode 100644 tests/btrfs/319.out
>
> diff --git a/tests/btrfs/319 b/tests/btrfs/319
> new file mode 100755
> index 00000000..2fe80185
> --- /dev/null
> +++ b/tests/btrfs/319
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 319
> +#
> +# Test that a send operation will issue a clone operation for a shared =
extent
> +# of a file if the extent ends at the i_size of the file and the i_size=
 is not
> +# sector size aligned.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send clone fiemap
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $tmp.*
> +	rm -fr $send_files_dir
> +}
> +
> +. ./common/filter
> +. ./common/reflink
> +. ./common/punch # for _filter_fiemap_flags
> +
> +_require_test
> +_require_scratch_reflink
> +_require_cp_reflink
> +_require_xfs_io_command "fiemap"
> +_require_odirect
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: send: allow cloning non-aligned extent if it ends at i_size"
> +
> +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> +send_stream=3D$send_files_dir/snap.stream
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
> +_scratch_mount
> +
> +# Use a file size that is not aligned to any possible sector size (1M +=
 5 bytes).
> +file_size=3D$((1024 * 1024 + 5))
> +# Use O_DIRECT to guarantee a single extent
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xab -b $file_size 0 $file_size" \
> +	     $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Clone the file.
> +_cp_reflink $SCRATCH_MNT/foo $SCRATCH_MNT/bar
> +
> +echo "Creating snapshot and a send stream for it..."
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
> +$BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap >> $seqres.full=
 2>&1
> +
> +echo "File digests in the original filesystem:"
> +md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
> +
> +echo "File bar fiemap in the original filesystem:"
> +$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_f=
lags
> +
> +echo "Creating a new filesystem to receive the send stream..."
> +_scratch_unmount
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG receive -f $send_stream $SCRATCH_MNT
> +
> +echo "File digests in the new filesystem:"
> +md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
> +
> +echo "File bar fiemap in the new filesystem:"
> +$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_f=
lags
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
> new file mode 100644
> index 00000000..14079dbe
> --- /dev/null
> +++ b/tests/btrfs/319.out
> @@ -0,0 +1,16 @@
> +QA output created by 319
> +wrote 1048581/1048581 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Creating snapshot and a send stream for it...
> +File digests in the original filesystem:
> +e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
> +e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
> +File bar fiemap in the original filesystem:
> +0: [0..2055]: shared|last
> +Creating a new filesystem to receive the send stream...
> +At subvol snap
> +File digests in the new filesystem:
> +e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
> +e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
> +File bar fiemap in the new filesystem:
> +0: [0..2055]: shared|last

