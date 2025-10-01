Return-Path: <linux-btrfs+bounces-17319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524FBB1C92
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 23:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685B719C05EB
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E230F54B;
	Wed,  1 Oct 2025 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="s3sT+Yq6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AF1C5F13;
	Wed,  1 Oct 2025 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353112; cv=none; b=urf3pSDX7jMBXxX+QtWFJA+4YYqWab/K2eNWS94KWFL0ESusD5sy33VJqRoccQ0Ofwee4L7QpXFKcWIcdxbIUjh/hIZsAzoVIMHQuYNArw+O9lvfCw2wcGR7k1TqSJTEi25e1ErMtQI/4rmSsAcJ+wQq7dB9RNc9WPg3AuIV+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353112; c=relaxed/simple;
	bh=y+e4bWsHOfZFUhm9E0sWddnUqYwl+XuILDLCrzJCe5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkqU/mlJVw4eJ0HJZHpOq4ntuss7V/cRxqaGNeW/Jb3NYgK+b3zPQjcBPHiSb7m8+qtgplnGh7TOosGipLOsUvGMqvJPFxEmlTsD30ff4Eo+BpcELnODzs+8nTrVeyOM/qi9frUnGqAXVfTued2WHWy9gRZnLkjEciwDPmPMASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=s3sT+Yq6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759353107; x=1759957907; i=quwenruo.btrfs@gmx.com;
	bh=vv+xRfh5cuoyd3YX/t0RpPyzNGrxjCmmpalQU9Rh2mI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s3sT+Yq667NdrTXNpTMKx/GxnU2CiGCKIq6+W6yohp5Ru8NGBpSHdSSxjleHToi4
	 bQ2oLf7u/nt5Qxo0wHOW79TNA3/69B/G0hbbgvzebwgctzS6zSdSxRiE8bWIC5lb6
	 Miv4f/APztG942DK+P6y2+Fk189Fqm39gDbPwpFflSMReyW1SCF8oMUr011hDsFMt
	 hqJUvE2qV3OZY3MSxbcZQrna/X+2HaMqWvZ9bpxiLYjRCyFdckSihQrVB9OGwBOD3
	 Fay/kfPJRziXwFDS+U1OMurK5csAt47nV5AAH8DcZXP4uPiVh1ENuZ1qnfxc3+yof
	 EztfWeoxOo7HakcWkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDkm-1u6Zjf0ik4-010DLn; Wed, 01
 Oct 2025 23:11:47 +0200
Message-ID: <73d3e951-1b40-45c1-82d4-54dbd2003fa0@gmx.com>
Date: Thu, 2 Oct 2025 06:41:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs/012 btrfs/136: skip the test if ext* doesn't
 support the block size
To: Zorro Lang <zlang@redhat.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20250918224327.12979-1-wqu@suse.com>
 <20250918224327.12979-2-wqu@suse.com>
 <20250928145453.wyztv2kvfpgmlw3k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <471b4e77-a89a-4cc2-aafe-0c04e36036c9@gmx.com>
 <20251001205011.dgi6w3fr5udkcx55@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20251001205011.dgi6w3fr5udkcx55@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oYr9au3wMVZkh4SOb612Cdt3QM4rr9FulL3z+AaEtqlY4F4CnED
 Ppom5KJ84HRHWCZwBmpuYR+pI/ZeEz7gYtVmXrrjQnWAmrq0EIxhRCfu6lptWyUbYa+DhXz
 As4xx49TX/P3D0cwbRRJK1xmCSMu1SDvZXxs3vAq14X4JFioPZ7ZTDoEfNH1OB7g0ox9xwl
 c80vGQ5ZkTSrNC1CKENGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j/IpGL2YVh8=;qwKb9l+eOd6/26FSSMSfFoO7Ttk
 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
 wjdlm4wOjPeOajLyjlBTZbkoLCwkd+iviH+m2w



=E5=9C=A8 2025/10/2 06:20, Zorro Lang =E5=86=99=E9=81=93:
> On Mon, Sep 29, 2025 at 06:12:17AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/9/29 00:24, Zorro Lang =E5=86=99=E9=81=93:
>>> On Fri, Sep 19, 2025 at 08:13:25AM +0930, Qu Wenruo wrote:
>>>> [FALSE ALERT]
>>>> When testing btrfs bs > ps support, the test cases btrfs/012 and
>>>> btrfs/136 fail like the following:
>>>>
>>>>    FSTYP         -- btrfs
>>>>    PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #285 SMP=
 PREEMPT_DYNAMIC Mon Sep 15 14:40:01 ACST 2025
>>>>    MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
>>>>    MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>>>
>>>>    btrfs/012       [failed, exit status 1]- output mismatch (see /hom=
e/adam/xfstests/results//btrfs/012.out.bad)
>>>>        --- tests/btrfs/012.out	2024-07-17 16:27:18.790000343 +0930
>>>>        +++ /home/adam/xfstests/results//btrfs/012.out.bad	2025-09-15 =
16:32:55.185922173 +0930
>>>>        @@ -1,7 +1,11 @@
>>>>         QA output created by 012
>>>>        +mount: /mnt/scratch: wrong fs type, bad option, bad superbloc=
k on /dev/mapper/test-scratch1, missing codepage or helper program, or oth=
er error.
>>>>        +       dmesg(1) may have more information after failed mount =
system call.
>>>>        +mkdir: cannot create directory '/mnt/scratch/stressdir': File=
 exists
>>>>        +umount: /mnt/scratch: not mounted.
>>>>         Checking converted btrfs against the original one:
>>>>        -OK
>>>>        ...
>>>>        (Run 'diff -u /home/adam/xfstests/tests/btrfs/012.out /home/ad=
am/xfstests/results//btrfs/012.out.bad'  to see the entire diff)
>>>>
>>>>    btrfs/136 3s ... - output mismatch (see /home/adam/xfstests/result=
s//btrfs/136.out.bad)
>>>>        --- tests/btrfs/136.out	2022-05-11 11:25:30.743333331 +0930
>>>>        +++ /home/adam/xfstests/results//btrfs/136.out.bad	2025-09-19 =
07:00:00.395280850 +0930
>>>>        @@ -1,2 +1,10 @@
>>>>         QA output created by 136
>>>>        +mount: /mnt/scratch: wrong fs type, bad option, bad superbloc=
k on /dev/mapper/test-scratch1, missing codepage or helper program, or oth=
er error.
>>>>        +       dmesg(1) may have more information after failed mount =
system call.
>>>>        +umount: /mnt/scratch: not mounted.
>>>>        +mount: /mnt/scratch: wrong fs type, bad option, bad superbloc=
k on /dev/mapper/test-scratch1, missing codepage or helper program, or oth=
er error.
>>>>        +       dmesg(1) may have more information after failed mount =
system call.
>>>>        +umount: /mnt/scratch: not mounted.
>>>>        ...
>>>>        (Run 'diff -u /home/adam/xfstests/tests/btrfs/136.out /home/ad=
am/xfstests/results//btrfs/136.out.bad'  to see the entire diff)
>>>>
>>>> [CAUSE]
>>>> Currently ext* doesn't support block size larger than page size, thus
>>>> at mkfs time it will output the following warning:
>>>>
>>>>    Warning: blocksize 8192 not usable on most systems.
>>>>    mke2fs 1.47.3 (8-Jul-2025)
>>>>    Warning: 8192-byte blocks too big for system (max 4096), forced to=
 continue
>>>>
>>>> Furthermore at ext* mount time it will fail with the following dmesg:
>>>>
>>>>    EXT4-fs (loop0): bad block size 8192
>>>>
>>>> [FIX]
>>>> Check if the mount of the newly created ext* succeeded.
>>>>
>>>> If not, since the only extra parameter for mkfs is the block size, we
>>>> know it's some block size ext* not yet supported, and skip the test
>>>> case.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    tests/btrfs/012 | 3 +++
>>>>    tests/btrfs/136 | 3 +++
>>>>    2 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/tests/btrfs/012 b/tests/btrfs/012
>>>> index f41d7e4e..665831b9 100755
>>>> --- a/tests/btrfs/012
>>>> +++ b/tests/btrfs/012
>>>> @@ -42,6 +42,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $s=
eqres.full 2>&1 || \
>>>>    	_notrun "Could not create ext4 filesystem"
>>>>    # Manual mount so we don't use -t btrfs or selinux context
>>>>    mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
>>>> +if [ $? -ne 0 ]; then
>>>> +	_notrun "block size $BLOCK_SIZE is not supported by ext4"
>>>> +fi
>>>
>>> Hmm... the mount failure maybe not caused by the "$BLOCK_SIZE is not s=
upported",
>>> I'm wondering if this _notrun might ignore real bug. How about check t=
he
>>> "blocksize < pagesize" at least?
>>
>> The only extra parameter passed to mkfs.ext* is "-b $BLOCKSIZE", and if=
 it's
>> really some bug inside e2fsprog and it only affects bs > ps, we're stil=
l
>> going to miss the bug.
>>
>> Is there any proper way to reliably check the supported block size of e=
xt*?
>> Like some sysfs knobs?
>=20
> If there's not a proper way to check ext4 supports LBS, how about check
> blocksize < pagesize" before _notrun directly, e.g:
>=20
>    pz=3D$(_get_page_size)
>    if [ $? -ne 0 -a $BLOCKSIZE -gt $pz ]

OK, I'll just add the manual block size check.

Thanks,
Qu

>=20
> Thanks,
> Zorro
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>>>    echo "populating the initial ext fs:" >> $seqres.full
>>>>    mkdir "$SCRATCH_MNT/$BASENAME"
>>>> diff --git a/tests/btrfs/136 b/tests/btrfs/136
>>>> index 65bbcf51..6b4b52e4 100755
>>>> --- a/tests/btrfs/136
>>>> +++ b/tests/btrfs/136
>>>> @@ -45,6 +45,9 @@ $MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_=
DEV > $seqres.full 2>&1 || \
>>>>    # mount and populate non-extent file
>>>>    mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
>>>> +if [ $? -ne 0 ]; then
>>>> +	_notrun "block size $BLOCK_SIZE is not supported by ext3"
>>>> +fi
>>>>    populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
>>>>    _scratch_unmount
>>>> --=20
>>>> 2.51.0
>>>>
>>>>
>>>
>>>
>>
>=20


