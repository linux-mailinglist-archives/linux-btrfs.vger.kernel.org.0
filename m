Return-Path: <linux-btrfs+bounces-1665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F5839D7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 01:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D01C22DD9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 00:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049147E5;
	Wed, 24 Jan 2024 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dv+t3KcI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9724368;
	Wed, 24 Jan 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054935; cv=none; b=HC8PmuMYjzHViBBsi4M24v/OUmxPF95yBgm3lMsKXovUKeNg/fNO3dq9u0RqLhOupevkirZg+AgNWDsfRs29qe333o25z/TuT67AIO689oTK/OkvTLXLEvpH1+i4k75q16jcEXJwXLu7naVh5drNf5TW06A6chTg61CAp0hRWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054935; c=relaxed/simple;
	bh=zdMTSfYHnseO2hKxUnLhVk5ao2eN2ghQupjfKHBamVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUl3Bh10R2dEPDRZbaoh4yRDb62p7xR+6OMFZQAQb16Z4hej64vFWDnbjfD/wpUhK55yzGg+fZ6otitQgX+n7EgHu4rXZFiSP6zIqBOdxoekkB77eHnEXFX0jIgT2IcCjsoSP5DjoDjnexZfMlF+u1dWYvgsBFiAH0hJygGunnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dv+t3KcI; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706054927; x=1706659727; i=quwenruo.btrfs@gmx.com;
	bh=zdMTSfYHnseO2hKxUnLhVk5ao2eN2ghQupjfKHBamVM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=dv+t3KcI2YVH1zzsMZYn+7UMDZbqssDhM+ITtSBf67cgT4Jdp4qf3Kyny5nsnqdn
	 b7mvPm6TrSatffCPLZzwJx61GIgsG8PQZh47809ZTGd3LQbHYadt5SW2b22aX7+Lg
	 TXRzRbKJfQrfWAbJWxlcdIvT7RsfndWcgQnfNbI4q7mlPosn5pJdLkCjbhza7hYEh
	 +Dg3T3XNvjk4gQsTfqb+yX4WX8usRrmUbt9dsan1Dr/eIXIs1Q7+qOk5SNg7AMLzu
	 Mo+eBwB+r64v16XfgYg3ir9q5ivqDDFKz4Yp0yl7NYnKKdlE/diTtGaXM8USdRB56
	 IXNGL7b4mPhtIkFksg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6UZl-1rQUsg078D-006v73; Wed, 24
 Jan 2024 01:08:47 +0100
Message-ID: <4f54135d-d013-4534-9598-f099df541205@gmx.com>
Date: Wed, 24 Jan 2024 10:38:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: verify the read behavior of compressed
 inline extent
Content-Language: en-US
To: Neal Gompa <neal@gompa.dev>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240123034908.25415-1-wqu@suse.com>
 <CAEg-Je-0JN59m+Cjxf_oFjWn37JxyfVLeqy=wyjo5qyucsp8fQ@mail.gmail.com>
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
In-Reply-To: <CAEg-Je-0JN59m+Cjxf_oFjWn37JxyfVLeqy=wyjo5qyucsp8fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FuQ/C1T2dSZmDxjiPmlbraSmSGrOaU1bWpnGt/QViKj1dA2puHX
 6/pjmqjXzzRZQl4gzOQQc/x3I0i5p70JbcKlYzB7/aRO5shTD1mvXY36mEJ9m1x004UAUHW
 XV4CraAYXb9V6zrI0rWxc7O9jLgiT1IhYzYGvIgCrZVc9h6SE2ZreEM3tw0+PuO6RF+es4x
 k/gJ9KeytsFtb6aOX5KHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V6dUgViqg9g=;EjJSVRj96FWNJRoP+QLrddh1Xno
 14ame6ZtlZMx5eLO1ADibZLPxF7H8NAc4/eaG5uVie7zP6wZrxizXs48Q3XRWanvyvcRgdwrz
 DCVIDH3i3nQ9vmrOb5TbxAVccKoirZ34M3O0DqJf3umCb2fBMs2lJnasY+oslKpdGvXOc7CbV
 Tok2UmeMg4/YTwZqYXpX9TXXEUgkWAVW3+jqBagAR0nB/QTlExwwdDBIU3VZCnV4J29hC3ImR
 VpDFAo39K2LAky9PAbRN2zNHQnpSi+CT+6fd1q0pQEfkiBoDQbqjAtpde119XvNa+OZGBJx+Y
 ny6ADcza867jwfHtNfxtPksl21C6CGGeolpgC3E/3RQW9mG7jZTv2Zd87xaaDCTxix22PSSG9
 Uwv6qPutRb1DO7HJVO+0ZMrctp9A/qaoSqqioF/35bUPqYy72Sj/c3TleLsH1Am0QgDLjK9tm
 ns2xM7FNUPs839FXDjh+Kv0voQ9/DVUyJe0JfyvbThcmi9vthcVUNvg2+fSuampnrD5O7/fRu
 Qk4HR7+iE9v7cq0usbfab5Tdc1BI50Y8W/9SkHnhQIx7uWQYsOLBG4VkXqCypEsdkuiRvV/XU
 w0StHj5eOJfYwknpLaBtjcYsNL8nxthHK+sXf1NhvVm7x0oTk7PZ0aRYZMsMuvcM9uq5hOXTI
 AALzi0DWyYVtEDFK4Y1bqxC1cb6RPaNq9oUetz39PWB8ni9dCh+Sle+R2Yp4qbzJz0bYZfI1U
 O98w9jTFV1vVfpK7FKhXA2pkEVQSSqdveuGRtmp83TqlSN4tXGTmMrME21+xAfdp3khP2u5Yn
 qJq1GeWDAiV8MTzS7h8DzwaARSiqfdaDhKBpcFpfZfelAZ70V5wrIyDcG319aUbcEaCggPGhS
 EVCiY26pmQKuDRuWH28Dee2bEVRsdhIZzYFjn14gjxLoV9A5GhWqD5bLuWFcdAKh11SP1bdin
 owxwd3j98T7KRweXnxSofI3lKYo=



On 2024/1/24 10:21, Neal Gompa wrote:
> On Mon, Jan 22, 2024 at 10:49=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> There is a report about reading a zstd compressed inline file extent
>> would lead to either a VM_BUG_ON() crash, or lead to incorrect file
>> content.
>>
>> [CAUSE]
>> The root cause is a incorrect memcpy_to_page() call, which uses
>> incorrect page offset, and can lead to either the VM_BUG_ON() as we may
>> write beyond the page boundary, or writes into the incorrect offset of
>> the page.
>>
>> [TEST CASE]
>> The test case would:
>>
>> - Mount with the specified compress algorithm
>> - Create a 4K file
>> - Verify the 4K file is all inlined and compressed
>> - Verify the content of the initial write
>> - Cycle mount to drop all the page cache
>> - Verify the content of the file again
>> - Unmount and fsck the fs
>>
>> This workload would be applied to all supported compression algorithms.
>> And it can catch the problem correctly by triggering VM_BUG_ON(), as ou=
r
>> workload would result decompressed extent size to be 4K, and would
>> trigger the VM_BUG_ON() 100%.
>> And with the revert or the new fix, the test case can pass safely.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/310     | 81 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/310.out |  2 ++
>>   2 files changed, 83 insertions(+)
>>   create mode 100755 tests/btrfs/310
>>   create mode 100644 tests/btrfs/310.out
>>
>> diff --git a/tests/btrfs/310 b/tests/btrfs/310
>> new file mode 100755
>> index 00000000..b514a8bc
>> --- /dev/null
>> +++ b/tests/btrfs/310
>> @@ -0,0 +1,81 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 310
>> +#
>> +# Make sure reading on an compressed inline extent is behaving correct=
ly
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick compress
>> +
>> +# Import common functions.
>> +# . ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +# This test require inlined compressed extents creation, and all the w=
rites
>> +# are designed for 4K sector size.
>> +_require_btrfs_inline_extents_creation
>> +_require_btrfs_support_sectorsize 4096
>> +
>> +_fixed_by_kernel_commit e01a83e12604 \
>> +       "Revert \"btrfs: zstd: fix and simplify the inline extent decom=
pression\""
>> +
>> +# The correct md5 for the correct 4K file filled with "0xcd"
>> +md5sum_correct=3D"5fed275e7617a806f94c173746a2a723"
>> +
>> +workload()
>> +{
>> +       local algo=3D"$1"
>> +
>> +       echo "=3D=3D=3D Testing compression algorithm ${algo} =3D=3D=3D=
" >> $seqres.full
>> +       _scratch_mkfs >> $seqres.full
>> +       _scratch_mount -o compress=3D${algo}
>> +
>> +       _pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/inline_file" > /dev/null
>> +       result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file")
>> +       echo "after initial write, md5sum=3D${result}" >> $seqres.full
>> +       if [ "$result" !=3D "$md5sum_correct" ]; then
>> +               _fail "initial write results incorrect content for \"$a=
lgo\""
>> +       fi
>> +       sync
>> +
>> +       $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline_file | tail -n =
1 > $tmp.fiemap
>> +       cat $tmp.fiemap >> $seqres.full
>> +       # Make sure we got an inlined compressed file extent.
>> +       # 0x200 means inlined, 0x100 means not block aligned, 0x8 means=
 encoded
>> +       # (compressed in this case), and 0x1 means the last extent.
>> +       if ! grep -q "0x309" $tmp.fiemap; then
>> +               rm -f -- $tmp.fiemap
>> +               _notrun "No compressed inline extent created, maybe sub=
page?"
>> +       fi
>> +       rm -f -- $tmp.fiemap
>> +
>> +       # Unmount to clear the page cache.
>> +       _scratch_cycle_mount
>> +
>> +       # For v6.8-rc1 without the revert or the newer fix, this can
>> +       # crash or lead to incorrect contents for zstd.
>> +       result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file")
>> +       echo "after cycle mount, md5sum=3D${result}" >> $seqres.full
>> +       if [ "$result" !=3D "$md5sum_correct" ]; then
>> +               _fail "read for compressed inline extent failed for \"$=
algo\""
>> +       fi
>> +       _scratch_unmount
>> +       _check_scratch_fs
>> +}
>> +
>> +algo_list=3D($(_btrfs_compression_algos))
>> +for algo in ${algo_list[@]}; do
>> +       workload $algo
>> +done
>> +
>> +echo "Silence is golden"
>> +
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
>> new file mode 100644
>> index 00000000..7b9eaf78
>> --- /dev/null
>> +++ b/tests/btrfs/310.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 310
>> +Silence is golden
>> --
>> 2.42.0
>>
>>
>
> This looks reasonable to me, but how is $_btrfs_compression_algos
> defined? Does it include all the algorithm options supported in Btrfs?

It fetches all the supported compression algo through the sysfs interfaces=
:

   /sys/fs/btrfs/features/compress_*

Along with the default supported zlib compression.

Thanks,
Qu
>
>

