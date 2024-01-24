Return-Path: <linux-btrfs+bounces-1741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D183B37D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E416D1F23F1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946541350ED;
	Wed, 24 Jan 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hmOn+h2e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DA1350DD;
	Wed, 24 Jan 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130019; cv=none; b=Btz1c8PJERXdMit1hfQuC1WFxH1X0egeFgAa7Xhx0CbBnk9QGNmE+nU0lzZqfw0UkZxOh+5sYPqYfVm1CLMZU4jtyAWaEjuOG+AgQb1qrKhdfgxbrOlsdXjskXNyYy/N0Zg1KGNtAGHe7WMdIwKTaCbuuQ8dNwBpDO2NWKHWzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130019; c=relaxed/simple;
	bh=QKfSQXjNPoMyNHmDy3yJdokk4b9mGyEorO7ZOXZFyGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pvmo375sEJpjfF794+7YBbCzPr8bhKm0g/xQoxRTFSxJn9UWwVPOP123o8VxvRu0E/5tXZZQNHe2ZYKe5D2vUHrEFqto2kLuOkdoMtbnfi4Mb1vmskzl6gvHmPvyswKG9SYAzR2TarSXZs5Usc284D+O5p2649Gsy2l/I30Qoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hmOn+h2e; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706130005; x=1706734805; i=quwenruo.btrfs@gmx.com;
	bh=QKfSQXjNPoMyNHmDy3yJdokk4b9mGyEorO7ZOXZFyGE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=hmOn+h2egRypx4oZXV14wqLsra6I7j/51LVqy3tMmslxu4LcaVXX+rKzcCQhA4It
	 C1dGQTSsJxM0AG2xr5FNzxWy5/TOtniMD3eCycqy4Y8EOC9HaIpXT0TDofzmGZDcN
	 BSIx/4pxsTIprFdlALklX0JzrsKhmRViks5E2TBSTfnPFf7tpqZ7ZDK5vlZ/3E/tr
	 WQdEBEjMhvNkpOAJ5GpHu8YLm2xReYZS+oCGI2OPH+SsznBHcP9hxP7Z5gFbqx6Nw
	 NN20rXE9JW+5fKC7HJx/gWXH9Do5UsJeKvW1VwS8xkSd2GxqM3EIfBZtJlhtm5sMN
	 xncMvYUSJmiIKPCtMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mk0Ne-1qn2p22ItU-00kOIy; Wed, 24
 Jan 2024 22:00:05 +0100
Message-ID: <9baa2a24-a44a-4f5e-95d7-23509ea450e4@gmx.com>
Date: Thu, 25 Jan 2024 07:30:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: verify the read behavior of compressed
 inline extent
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240123034908.25415-1-wqu@suse.com>
 <17e9c07d-9396-4999-8449-b0e3e764c32f@oracle.com>
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
In-Reply-To: <17e9c07d-9396-4999-8449-b0e3e764c32f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EWkM8gF4R+BBmSO13Q77as6CdumY5Ke2n4OvN68kRRIQp0WIehg
 Ti8A/lu7mAKza1yBNMUGluKpJrBYPXVuapLAhIQDBLdE87K+pQl68CqeI6hgQ+9OFTM/C2A
 7rFE8psPSNZ9J+mT8/s38Nrx5sC3BkFOkzkhRrlhkFNePiNi8nmtWxt6gEMBotqi8x1XhWk
 3kBMYGFArKdc5D2+bIJNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Qf9YFU9338=;0AJBSPxPxn3t4SdzBB9hWMwMOvg
 OD5nJ+S5bnWx+T3foANj5y/oI+2F8y2b/tbT34gUy3fU7418pFj4x8P4uBHHUnQtLmlnQc13n
 vNIygdWTHmsCeTryXvAQN6hLwuXg6oB/oTTsXTRDPbQBhltoRlNHAWqhB9lS5pFsXJxl89Vx8
 QdzW/Kv3eLAX0j+tgJgxrVe/XRNitoVr82kQaNiK91ZR/iZ0MVNEz5tYgpqr4J1kgCKwJCom2
 eqghQfeTys6hZaTh3Qo8T/4n0622xJs1Ei/5/ojUwtFCC0DF9Mk5NkmQkOZidY0a0vm8OSAG+
 K87s0K3UoHjWpvkNs3JlQBxIslKfgvv8cwaYsGT3/yafS8c+3JlH7jtUX/fEVvFAt6hm0gT2t
 6dHypXCp1tqKQofVorcIejcNvfHqKcVqqcwqtO4o66tFai7Rs/BtCXCaFKgwG7Y9/4hwIHR8P
 RlisPALJDDV2ZqcH4i/3qDG6JMmEMN90UcJu7taAZvIQKoUXsBE5wWkcSFdSihvwwN3xhO5Dk
 dUOlyMjQ2n9qe8YZ2IoGfdx1KI9PRzeyCsI+uCTyuPH1IDHUo++hn7Efb3K3QBwZN92OPwWm1
 Gy1F4qNwDVhTkClo2P72/i20eugY1ISut+Mrn7jZHVmnUcFt2SPp6XYgCp15FyXaDnx89KGem
 9K/Nyr8wsk2Vt/KImzM0+AJDvmzlJUgMJpStsKFOmEnUm9yxJjQIAVIsON5yzfev+dOPl3xmm
 JR8DfFw1UfyHIY15hfBrpsLF+4Xu+V7tbpslfhrYdPMgWk+p9fuILaluyEeo+cDQBJngiUk8t
 0pc18kOL6CnQ/1l/5oo0nIoVhYaqwNRQ8k7TdXVzxpsAJi0XSXGaqWLaPqjjoGIXS/Sk0A3jn
 ZII1YPC236xbMCIvL6Tx74SqhA8A3gE8gmi9gtSX7oGBj/Rw3trzZBOxR4NfrktZtfTuqrGWC
 PD0fU4Gl2pEoepQZAXj3z+7awSI=



On 2024/1/24 22:40, Anand Jain wrote:
> On 1/23/24 11:49, Qu Wenruo wrote:
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
>> =C2=A0 tests/btrfs/310=C2=A0=C2=A0=C2=A0=C2=A0 | 81 +++++++++++++++++++=
++++++++++++++++++++++++++
>> =C2=A0 tests/btrfs/310.out |=C2=A0 2 ++
>> =C2=A0 2 files changed, 83 insertions(+)
>> =C2=A0 create mode 100755 tests/btrfs/310
>> =C2=A0 create mode 100644 tests/btrfs/310.out
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
>> +# This test require inlined compressed extents creation, and all the
>> writes
>> +# are designed for 4K sector size.
>> +_require_btrfs_inline_extents_creation
>> +_require_btrfs_support_sectorsize 4096
>> +
>> +_fixed_by_kernel_commit e01a83e12604 \
>> +=C2=A0=C2=A0=C2=A0 "Revert \"btrfs: zstd: fix and simplify the inline =
extent
>> decompression\""
>> +
>> +# The correct md5 for the correct 4K file filled with "0xcd"
>> +md5sum_correct=3D"5fed275e7617a806f94c173746a2a723"
>> +
>> +workload()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local algo=3D"$1"
>> +
>> +=C2=A0=C2=A0=C2=A0 echo "=3D=3D=3D Testing compression algorithm ${alg=
o} =3D=3D=3D" >> $seqres.full
>> +=C2=A0=C2=A0=C2=A0 _scratch_mkfs >> $seqres.full
>> +=C2=A0=C2=A0=C2=A0 _scratch_mount -o compress=3D${algo}
>> +
>> +=C2=A0=C2=A0=C2=A0 _pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/inline_file" >=
 /dev/null
>
>
>
>> +=C2=A0=C2=A0=C2=A0 result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file"=
)
>> +=C2=A0=C2=A0=C2=A0 echo "after initial write, md5sum=3D${result}" >> $=
seqres.full
>> +=C2=A0=C2=A0=C2=A0 if [ "$result" !=3D "$md5sum_correct" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _fail "initial write result=
s incorrect content for \"$algo\""
>> +=C2=A0=C2=A0=C2=A0 fi
>
> General rule of thumb is where possible use stdout and compare it with
> the golden output.
>
> So something like the below shall suffice.
>
> echo "after initial write with alog=3D$algo"
> _md5_checksum "$SCRATCH_MNT/inline_file"
>
> Also, helps quick debug, when=C2=A0 fails we have the diff.

Nope, for this particular case, golden output is not suitable.

As the workload is dependent on the support compression algorithm, we
can not reply on golden output to cover all algorithms.
Or it would always fail for older kernels without zstd, or for newer
kernel with newer algorithm.

That's why I personally don't believe golden output is always the best
way to go.

Thanks,
Qu
>
>
>> +=C2=A0=C2=A0=C2=A0 sync
>
>  =C2=A0Generally, we need comments to explain why sync is necessary.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline_fil=
e | tail -n 1
>> > $tmp.fiemap
>> +=C2=A0=C2=A0=C2=A0 cat $tmp.fiemap >> $seqres.full
>> +=C2=A0=C2=A0=C2=A0 # Make sure we got an inlined compressed file exten=
t.
>> +=C2=A0=C2=A0=C2=A0 # 0x200 means inlined, 0x100 means not block aligne=
d, 0x8 means
>> encoded
>> +=C2=A0=C2=A0=C2=A0 # (compressed in this case), and 0x1 means the last=
 extent.
>> +=C2=A0=C2=A0=C2=A0 if ! grep -q "0x309" $tmp.fiemap; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -f -- $tmp.fiemap
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _notrun "No compressed inli=
ne extent created, maybe subpage?"
>
>  =C2=A0workload() is called for each compress algo. If we fail
>  =C2=A0for one of the algo then notrun is not a good option here.
>
>  =C2=A0IMO, stdout (with filters?) and comparing it with golden output
>  =C2=A0is better.
>
>> +=C2=A0=C2=A0=C2=A0 fi
>
>
>> +=C2=A0=C2=A0=C2=A0 rm -f -- $tmp.fiemap
>> +
>> +=C2=A0=C2=A0=C2=A0 # Unmount to clear the page cache.
>> +=C2=A0=C2=A0=C2=A0 _scratch_cycle_mount
>> +
>> +=C2=A0=C2=A0=C2=A0 # For v6.8-rc1 without the revert or the newer fix,=
 this can
>> +=C2=A0=C2=A0=C2=A0 # crash or lead to incorrect contents for zstd.
>> +=C2=A0=C2=A0=C2=A0 result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file"=
)
>> +=C2=A0=C2=A0=C2=A0 echo "after cycle mount, md5sum=3D${result}" >> $se=
qres.full
>> +=C2=A0=C2=A0=C2=A0 if [ "$result" !=3D "$md5sum_correct" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _fail "read for compressed =
inline extent failed for \"$algo\""
>> +=C2=A0=C2=A0=C2=A0 fi
>
>  =C2=A0Here too, same as above, golden output to compare can be done.
>  =C2=A0And remove _fail.
>
> Thanks, Anand
>
>> +=C2=A0=C2=A0=C2=A0 _scratch_unmount
>> +=C2=A0=C2=A0=C2=A0 _check_scratch_fs
>> +}
>> +
>> +algo_list=3D($(_btrfs_compression_algos))
>> +for algo in ${algo_list[@]}; do
>> +=C2=A0=C2=A0=C2=A0 workload $algo
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
>
>

