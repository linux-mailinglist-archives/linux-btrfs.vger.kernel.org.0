Return-Path: <linux-btrfs+bounces-6551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAEE937088
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5104C283261
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0A14600C;
	Thu, 18 Jul 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FiFouT5Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CD1386BF;
	Thu, 18 Jul 2024 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340340; cv=none; b=FE5xh7K61TMluIo9HZN4NWiXmYOrObemVnMzSdBX0n4yqFrmjG7Qo0MaRmt5YjGfkxGUjIBSMnH1vQbTg1RoaC3gPcr+6GeH1UXIQc2k9N5EyxcR13gLDHsgunWiullVVELKQSu+hGwdWOa/xl1QP4vRe6J3p1Qb3Q6L5P2JrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340340; c=relaxed/simple;
	bh=aUlWIvdwnrqNRmtRIB9nJrmHyfzntU0EOhiQs/H/qLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFf4MGnN0pClfkjR00KpFbtZ0ktLXskcb2YdT75FTprFzzDtx2cxVU22Ey0KNbcwUFp1/DtOcWP1HsZ89RQAjg5HXvpk/i0kCaM21JlMa9azWq9o2dHaZzYfsIeF9JhNEorvZsktsTM5i87pXRSxrzgPRu7+xPt3EH3bTcbnQVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FiFouT5Y; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721340331; x=1721945131; i=quwenruo.btrfs@gmx.com;
	bh=IWFllE/B/B//MfHh2L8Kp7n3HNA0cVbaVBKge6qoq0Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FiFouT5YIrdfW01KsbrRsGVz66wb3i2zNwoFNaaEK6hwo3/J0R1AzYZ+UG6MmNm9
	 y2i0Kl3pApJDR1wJuYSwOt3CK+1+1QkrecjEgsh68HL0VEV6VfAcxwpHx/A35Q9Gd
	 64QTL0UbYD1V93Qb74nfQxbfFtGbIQqks9nid8DQC9HlR8xM9s8jU/PO8Aw5iD+Ab
	 GJ1GuepZ6TrGXuZjhCRuJhS15biNMJU9dH4sjeY2mvlBPGM3hhhmohN0Lm/kkBJmZ
	 HNM6M9uELcOFbwtZZSSKRtWCg+pftBwa5sF9AfaDyKxxIQwBonwjzu3+2Yw904agj
	 i0GqXM1HhET0EBJ2yA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wuk-1sRFs61u0y-00G7Ew; Fri, 19
 Jul 2024 00:05:30 +0200
Message-ID: <ad159992-c2f1-49ee-bac1-0f72b3a6691e@gmx.com>
Date: Fri, 19 Jul 2024 07:35:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: test a compressed send stream scenario that
 triggered a read corruption
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <330b0c61a77f01bd2aa57e9b500145178a2d751a.1721124764.git.fdmanana@suse.com>
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
In-Reply-To: <330b0c61a77f01bd2aa57e9b500145178a2d751a.1721124764.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tJ+b7fFtMk5iNTzbsXzKeCDY0DtNXjUbr4Q3yuse5SLOkkbhc63
 Z9NW+1Em12SSqtckHvRY6hy5UZgqeCRI7eE372AXtKFiJtJrGhzkSDrfCwh1j5lQVyKjkBG
 afO6AV+VLl+m9uAyiw3feNgnXE5QaJy2PrudpYZXyRyzZRAZAFgiLmbXt65asectmpLaqNY
 EToLjCi2VbGpmO95rDfFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kdYYJiVAi5c=;TFXzeg0Y1MWq90xyW145P9moeeP
 BruMMbmLzC7ITHOSYgZ2+BPATfg5/WbNOeKfD3xcT8tyo1DKvRA+xVtnsbdvumiCgaG/eyN1p
 eH8MZ8tFO9fCmm+Tq38tRS4wOKQhcuYtiZc+yMMPpyjLdUcViHmkHIpfYTJRoyqe7aV0tzj/R
 56yaaYQXsWAEpcBFGEmTIpqKq/ke1ZroTCvppMU6XwZmfbvbLJpzqHhtLM5DQ/Hkj5mo5hpRI
 4LtwjvAH3y1sWXxXQLJSiQ93/i0ntF/2UtDFoJq6jmCCZfRM3sXi7FPU6LJtEGNgk8KOJAc/+
 /fwHiBzHMS6CVM7UXaStj8qU/ms81JJUcTmBrIQmsSGE1Rd7RFkUUD/xCgcHcoC7C+KuscEfW
 B9+xEsUlnvCMGUGfXIsandzMedIfIWCACUNkdetzYwPsCvIqPaXl2h0iLLwhhVnxjzt4MjGBZ
 /WpWQDUrATOvuPv1fDbEAFEIqtAZ/CleOxtJD1B0v8Aj6jzxjA+uszT47lzUhQD4s+i7jbLUt
 RpZFYKElSF6FxriIly5iLn2C/Ak3PMN4GqTPZWO+M10QPwH4mVH0ViUfYjNxDbeAEYxv2Xip8
 YzSffcuBfiGrwSYgox3ibXhKL9kuMfuE/233l/CTDsvhOGuPUq1ezORrm9QzzL9eZ2o0yEwFa
 +wE2XnSmTJ1LhX2vPykkUnYihauQWvbMgRobBZsr40Xe6E8o8prShRWltWf0nlUQckpERGNLz
 Rv1vGH6OUZ5gPZj/0WsPW9w14r7iImnqyoL52+3YrOamrkuZQTxczB8tQHQZ1uM7euuW0dnM6
 voYmL6DfnTTfsEjq0aOAzpeg==



=E5=9C=A8 2024/7/16 19:44, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Test a scenario of a compressed send stream that triggered a bug in the
> extent map merging code introduced in the merge window for 6.11.
>
> The commit that introduced the bug is on its way to Linus' tree and its
> subject is:
>
>     "btrfs: introduce new members for extent_map"
>
> The corresponding fix was submitted to the btrfs mailing list, with the
> subject:
>
>    "btrfs: fix corrupt read due to bad offset of a compressed extent map=
"
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/btrfs/312     | 115 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/312.out |   7 +++
>   2 files changed, 122 insertions(+)
>   create mode 100755 tests/btrfs/312
>   create mode 100644 tests/btrfs/312.out
>
> diff --git a/tests/btrfs/312 b/tests/btrfs/312
> new file mode 100755
> index 00000000..ebecadc6
> --- /dev/null
> +++ b/tests/btrfs/312
> @@ -0,0 +1,115 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 312
> +#
> +# Test a scenario of a compressed send stream that triggered a bug in t=
he extent
> +# map merging code introduced in the merge window for 6.11.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send compress
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $tmp.*
> +	rm -fr $send_files_dir
> +}
> +
> +. ./common/filter
> +
> +_require_btrfs_send_version 2
> +_require_test
> +_require_scratch
> +
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"btrfs: fix corrupt read due to bad offset of a compressed extent map"
> +
> +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +first_stream=3D"$send_files_dir/1.send"
> +second_stream=3D"$send_files_dir/2.send"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
> +_scratch_mount -o compress
> +
> +# Create a compressed extent for the range [108K, 144K[. Since it's a
> +# non-aligned start offset, the first 3K of the extent are filled with =
zeroes.
> +# The i_size is set to 141K.
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 111K 30K" $SCRATCH_MNT/foo >> $seqre=
s.full
> +
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 =
>> $seqres.full
> +
> +# Overwrite a part of the extent we created before.
> +# This will make the send stream include an encoded write (compressed) =
for the
> +# file range [120K, 128K[.
> +$XFS_IO_PROG -c "pwrite -S 0xcd 120K 8K" $SCRATCH_MNT/foo >> $seqres.fu=
ll
> +
> +# Now do write after those extents and leaving a hole in between.
> +# This results in expanding the last block of the extent we first creat=
ed, that
> +# is, in filling with zeroes the file range [141K, 144K[ (3072 bytes), =
which
> +# belongs to the block in the range [140K, 144K[.
> +#
> +# When the destination filesystem receives from the send stream a write=
 for that
> +# range ([140K, 144K[) it does a btrfs_get_extent() call to find the ex=
tent map
> +# containing the offset 140K. There's no loaded extent map covering tha=
t range
> +# so it will lookg at the subvolume tree to find a file extent item cov=
ering the
> +# range and then finds the file extent item covering the range [108K, 1=
44K[ which
> +# corresponds to the first extent written to the file, before snapshoti=
ng.
> +#
> +# Note that at this point in time the destination filesystem processed =
an encoded
> +# write for the range [120K, 128K[, which created a compressed extent m=
ap for
> +# that range and a corresponding ordered extent, which has not yet comp=
leted when
> +# it received the write command for the [140K, 144K[ range, so the corr=
esponding
> +# file extent item is not yet in the subvolume tree - that only happens=
 when the
> +# ordered extent completes, at btrfs_finish_one_ordered().
> +#
> +# So having found a file extent item for the range [108K, 144K[ where 1=
40K falls
> +# into, it tries to add a compressed extent map for that range to the i=
node's
> +# extent map tree with a call to btrfs_add_extent_mapping() done at
> +# btrfs_get_extent(). That finds there's a loaded overlapping extent ma=
p for the
> +# range [120K, 128K[ (the extent from the previous encoded write) and t=
hen calls
> +# into merge_extent_mapping().
> +#
> +# The merging ended adjusting the extent map we attempted to insert, co=
vering
> +# the range [108K, 144K[, to cover instead the range [128K, 144K[ (leng=
th 16K)
> +# instead, since there's an existing extent map for the range [120K, 12=
8K[ and
> +# we are looking for a range starting at 140K (and ending at 144K). How=
ever it
> +# didn't adjust the extent map's offset from 0 to 20K, resulting in fut=
ure reads
> +# reading the incorrect range from the underlying extent (108K to 124K,=
 16K of
> +# length, instead of the 128K to 144K range).
> +#
> +# Note that for the incorrect extent map, and therefore read corruption=
, to
> +# happen, we depend on specific timings - the ordered extent for the en=
coded
> +# write for the range [120K, 128K[ must not complete before the destina=
tion
> +# of the send stream receives the write command for the range [140K, 14=
4K[.
> +#
> +$XFS_IO_PROG -c "pwrite -S 0xef 160K 4K" $SCRATCH_MNT/foo >> $seqres.fu=
ll
> +
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 =
>> $seqres.full
> +
> +echo "Checksums in the original filesystem:"
> +echo "$(md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch)"
> +echo "$(md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch)"
> +
> +$BTRFS_UTIL_PROG send --compressed-data -q -f $first_stream $SCRATCH_MN=
T/snap1
> +$BTRFS_UTIL_PROG send --compressed-data -q -f $second_stream \
> +		 -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2
> +
> +_scratch_unmount
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG receive -q -f $first_stream $SCRATCH_MNT
> +$BTRFS_UTIL_PROG receive -q -f $second_stream $SCRATCH_MNT
> +
> +echo "Checksums in the new filesystem:"
> +echo "$(md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch)"
> +echo "$(md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch)"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
> new file mode 100644
> index 00000000..75f1f4cc
> --- /dev/null
> +++ b/tests/btrfs/312.out
> @@ -0,0 +1,7 @@
> +QA output created by 312
> +Checksums in the original filesystem:
> +e3ba4a9cbb38d921adc30d7e795d6626  SCRATCH_MNT/snap1/foo
> +4de09f7184f63aa64b481f3031138920  SCRATCH_MNT/snap2/foo
> +Checksums in the new filesystem:
> +e3ba4a9cbb38d921adc30d7e795d6626  SCRATCH_MNT/snap1/foo
> +4de09f7184f63aa64b481f3031138920  SCRATCH_MNT/snap2/foo

