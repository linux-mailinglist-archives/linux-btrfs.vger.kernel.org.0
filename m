Return-Path: <linux-btrfs+bounces-1873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2E83FA4F
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 23:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696581C219A8
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 22:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82F25773;
	Sun, 28 Jan 2024 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KTU7ZsZ/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722723C47E;
	Sun, 28 Jan 2024 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706480534; cv=none; b=YfsIQCcIHdAeUiGu9WPop8psnnYok7H7v1zOkOUHC6mnLMG5KcKTW4I4hDjzDTqCaU260gkNLjW1IvU3eAtfiH8R5adlgnCBKX9E2Fg9uO8cdVaEQ8hfCNqQFU8oXTbl1hOC8uvlwBVlECLaGiesUpl5faqlfE4nlNzcMuWiPLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706480534; c=relaxed/simple;
	bh=Ky+QBzVHYvyceKzObu12tT6p6sTPDIL1zME/nEZCpH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2OzxZrJDgxWiGV9FgsIj303CfmkaHTokNTbf7QBS/XOmhFYBcjTRBiNq6B5NRHiJuoRkd5LGh7uJiqKYijNUd2nToJ0FRPHDjhcFSZjqjavtpn2tAfZVrtbbTTd+FAgTjBSi/voYnrhD679iZs8Qa6sJUlN4S+7al2DXYK8ojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KTU7ZsZ/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706480521; x=1707085321; i=quwenruo.btrfs@gmx.com;
	bh=Ky+QBzVHYvyceKzObu12tT6p6sTPDIL1zME/nEZCpH8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KTU7ZsZ/c9wJ01As0auXaxNu1X6SbT6uyPo3YXMpZLNDmlkvsHEnyLVQsb1Cu9e8
	 B/g4V0Cf/vkePvslYuKFiXRtERIrm+KVPM3GaBV8ufPk9TkomuPOystLbgpNlm9+6
	 PERL8U0TgEbStMvgB+X4ctyhsOO+vBbz2sNPaAu3F/m33gYIi5h5mX3QLHKWpEWm2
	 /yaacsh4pVRd+ImDo/1wKMt/Pg7Ax1M8Bns4t3LsWZnRYxNIzX/0ZDul/g2Y56h02
	 QkhdqY8wn5SJbKMj12zhySYC0seu30Mzy9BlaVUW6sf7WcQrAP4EPgSXQ7y5DX026
	 icb9sQD1/9UmzDIarw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDjA-1rM0sI3Xuo-00CjmD; Sun, 28
 Jan 2024 23:22:01 +0100
Message-ID: <d7762a10-c1d3-47b1-beca-c3486524790e@gmx.com>
Date: Mon, 29 Jan 2024 08:51:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: verify the read behavior of compressed
 inline extent
To: Neal Gompa <neal@gompa.dev>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240127204417.11880-1-wqu@suse.com>
 <CAEg-Je-KvRra=Vtn9i0NaLZAGQCt40LaJAHywznKZXStBFRKbw@mail.gmail.com>
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
In-Reply-To: <CAEg-Je-KvRra=Vtn9i0NaLZAGQCt40LaJAHywznKZXStBFRKbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DnFfaV1KDTrn4DkJotusnp0/Ov84i8tQ/iWEsoElIA95KWxTLeY
 wHRidx7brs/Jgq8u3ID7sTBmhMsdzoVlsATGIZyDOGCFowbXV8+QhAoNmdJ6bWiyJHerggl
 Ga3SiuiVH08EdKKtgM18zbBmcmuRVkA03Xx3R/wDn5hYQyTZlw/6JL+wWZ49ZJ3Gdcv8FHy
 KMFg6FaOtuW1GaxPn/5Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zNzV612L/M4=;LYPfjt7lxnSdw5QkOrdVDyFLKC/
 8Owic4OAkE8gattDQiNbrKjc3M7VWD2+NOkplktcHb9sZpQ7CPzWVNjC31M3blo6j1wKt+Sqw
 WS9TahEQBVu5tGlbuZByzJq8GMQGOYeyZ2BleuLqvb5egerPYLbkrnbUmZwYrsKIvc53mtmxY
 2+TTAk3A60iBcF/KJo+dvj4WTcU42giL8lDiJMSQ5KbiGVr8oGId0+g43E//V+PdX7XIB7CFZ
 +GXAIpGv4tOyKnQakYHcP9eqctUC/as5GyhMI4SoxF0CkapFaZ5V/k/3/ZQnl3puYlIGqzi70
 BI9mUUd/O9qqOvtwXgQf//yfIqTwG5UOUSAvVSdbcYHeJAE6fXnf+g9JJCMfQyrDFu7MLmkDm
 64qt+Yn2TOZyrtMa80SfxEoEM+xREd0XPN2Bz80RYwK74kmZosQ5Y0XdsUPFPvX2tD9wZeK9g
 TLR/M7o99ghFA4fZzHsR8ss4KzJ64lvLcb4ntBCH+NP+r52kTJkql+9f6JAqtK3BIeZtUpTrB
 Eb6HXz9pWG+N1l5w0k7YIZPUm3gqpeTdXAdPcn2Y9q88y7cPSORyGOFMKvEjwpxz2H5xXs9fs
 RB3IWq+2P24cCh/WK7XWLFSsrEeh9nCwPbCscG96cvO3z0GS9F3t0l8/UHHABJD0kMxcfukR0
 HfNENS9AOfbcPPim98gaGTCoSXZV7It00dcjPZsA0Zfw6JqSTApKVwQu11B5usT9CGV93QurT
 1jJPqaCUmpq5l4dEyeGvAZjy0/5kiR1fPkSLReZRIwHepn1G8CJfC41bg6IukqeHkp88u31s5
 kjn71uY38p46rv61ot6cx6Ba38wRLJbHKZ44UTFuKzr0kzQSe/Z8/eSBKjVfb8UFoCC67+ffE
 KA5ef98YTgsnnXZyJxUZDGpX8FVg0QjrX9VkrpH43utxoZvYdeC53hbi4z6O2+xynTPdEx/Aj
 JAqlboD7031ImCu8SR7Udzc5Gss=



On 2024/1/29 01:53, Neal Gompa wrote:
> On Sat, Jan 27, 2024 at 8:44=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
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
>>   tests/btrfs/310     | 83 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/310.out |  2 ++
>>   2 files changed, 85 insertions(+)
>>   create mode 100755 tests/btrfs/310
>>   create mode 100644 tests/btrfs/310.out
>> ---
>> Changelog:
>> v2:
>> - Add a comment on why a "sync" is needed
>> - Update the failure case comment
>>    The specific design of the inline extent size is ensured to trigger
>>    VM_BUG_ON(), thus remove the data corruption case.
>>
>> diff --git a/tests/btrfs/310 b/tests/btrfs/310
>> new file mode 100755
>> index 00000000..507485a4
>> --- /dev/null
>> +++ b/tests/btrfs/310
>> @@ -0,0 +1,83 @@
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
>
> I assume that this will be updated once we land a fixed commit? We
> should ensure we keep track of those things...

Not exactly, in fact the test case only verify the very basic of inline
compressed extent read, thus this fix is correct.

For the reflinking of inline compressed extent, the behavior is tested
in another test case.

Thanks,
Qu
>
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
>> +       # Writeback data to get correct fiemap result, or we got FIEMAP=
_DEALLOC
>> +       # without compression/inline flags.
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
>> +       # For v6.8-rc1 without the revert or the newer fix, this would
>> +       # lead to VM_BUG_ON() thus crash
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
> Otherwise, LGTM.
>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
>
>

