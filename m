Return-Path: <linux-btrfs+bounces-17241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF7BA77A4
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 22:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82B8188EA28
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 20:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA6272E61;
	Sun, 28 Sep 2025 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="A5RS8SJA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DCE1DB125;
	Sun, 28 Sep 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759092146; cv=none; b=nzcUKC226NrytA9VMITSCLSfT/27ijsb/zEtUxbdn9VFhHzre+eG00r9RGVWX3KxuJfVvQNriCLtxg15jwlREZc63X4HKOb3OF3FI532aYH8P9od/RHWQHRjYrIX9vxGprTkiZ89bFerFhCAOqa9Vswse1hiMfgbUV8vgOHeA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759092146; c=relaxed/simple;
	bh=rn8d1w+gYM8DLkhri1LKlPy/Zts8X+eWLrzMh241HEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tu8HjsuUeZ9krWBXlQPYmYlCXBjU0juoRwcPS1zZN0adxuZuLt1cdoqgEwz7qx8nHEX2q2V38T5M+XgnQi0MXgRNoZUS9ZCXgyy5vsp0WDjwiz9kamOW6AMppjFMOo2li+nSzVjYupBGz3yW44OzcnioCqsqKzo7kjUEjjAkJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=A5RS8SJA; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759092142; x=1759696942; i=quwenruo.btrfs@gmx.com;
	bh=mV2+WviAL0cButFuc4DUr5MN1uypXaiN2ZtQRXgHAPE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A5RS8SJAdq/sfR0O9PSIroJX6MPVHNqXuaVdFNWO3WBkQs5ffqgaXgZGuvrl0i6r
	 PO0myfoFQuvpY4PTt0UD2yvXXgxxYu47RHfa4bAwOzxxsdK58KtTvZm6TqCjyHv5M
	 YPxfhWWiVm8fnxco823yhSbspl5XSHOa7wfO5L8ma0Vy+xag3HFlSPzbukxg7HTSZ
	 5kKQoa655vfMC96JhTQbyN0QimTp3owTLSrcIl0dnUywA1IXtiR+36eWx5q7Mvmwv
	 w1afXhT3y576rxaD+vacFn8VpLlo+hkxFwscBDyZ4IKqeXw0MLDngLRJwY5Lxv8Bg
	 K4QSixN08YVGQ7ZTCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1uJpFB04my-013geW; Sun, 28
 Sep 2025 22:42:21 +0200
Message-ID: <471b4e77-a89a-4cc2-aafe-0c04e36036c9@gmx.com>
Date: Mon, 29 Sep 2025 06:12:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs/012 btrfs/136: skip the test if ext* doesn't
 support the block size
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250918224327.12979-1-wqu@suse.com>
 <20250918224327.12979-2-wqu@suse.com>
 <20250928145453.wyztv2kvfpgmlw3k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250928145453.wyztv2kvfpgmlw3k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k2bSFVA3njHggTzJMPw/37kAqD5EeutLr3gNCpzX0nZPo8banrc
 qdjbpZ8LkZsLXkw9S70l5U8onSkO1c17W4DWuzF2iSdzWRnzmXXM35t2geXwddBIzpoQDjT
 x8AXAzLWqfSH8T2IzAJ1oBn7wBYM3KgKUGeIxQ4ZIzzcEzlJPZQyc4Rtn+gOn1lIWrKlev1
 jkV5JTJsFxISWYUS2qeWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pEI+J8BY2Tc=;WyeKQhimIAXu+U/VdggFo1GmHvV
 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
 RBfCZa4oDW3IAhqASRhOUy7cKA=



=E5=9C=A8 2025/9/29 00:24, Zorro Lang =E5=86=99=E9=81=93:
> On Fri, Sep 19, 2025 at 08:13:25AM +0930, Qu Wenruo wrote:
>> [FALSE ALERT]
>> When testing btrfs bs > ps support, the test cases btrfs/012 and
>> btrfs/136 fail like the following:
>>
>>   FSTYP         -- btrfs
>>   PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #285 SMP PR=
EEMPT_DYNAMIC Mon Sep 15 14:40:01 ACST 2025
>>   MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
>>   MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>
>>   btrfs/012       [failed, exit status 1]- output mismatch (see /home/a=
dam/xfstests/results//btrfs/012.out.bad)
>>       --- tests/btrfs/012.out	2024-07-17 16:27:18.790000343 +0930
>>       +++ /home/adam/xfstests/results//btrfs/012.out.bad	2025-09-15 16:=
32:55.185922173 +0930
>>       @@ -1,7 +1,11 @@
>>        QA output created by 012
>>       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock o=
n /dev/mapper/test-scratch1, missing codepage or helper program, or other =
error.
>>       +       dmesg(1) may have more information after failed mount sys=
tem call.
>>       +mkdir: cannot create directory '/mnt/scratch/stressdir': File ex=
ists
>>       +umount: /mnt/scratch: not mounted.
>>        Checking converted btrfs against the original one:
>>       -OK
>>       ...
>>       (Run 'diff -u /home/adam/xfstests/tests/btrfs/012.out /home/adam/=
xfstests/results//btrfs/012.out.bad'  to see the entire diff)
>>
>>   btrfs/136 3s ... - output mismatch (see /home/adam/xfstests/results//=
btrfs/136.out.bad)
>>       --- tests/btrfs/136.out	2022-05-11 11:25:30.743333331 +0930
>>       +++ /home/adam/xfstests/results//btrfs/136.out.bad	2025-09-19 07:=
00:00.395280850 +0930
>>       @@ -1,2 +1,10 @@
>>        QA output created by 136
>>       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock o=
n /dev/mapper/test-scratch1, missing codepage or helper program, or other =
error.
>>       +       dmesg(1) may have more information after failed mount sys=
tem call.
>>       +umount: /mnt/scratch: not mounted.
>>       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock o=
n /dev/mapper/test-scratch1, missing codepage or helper program, or other =
error.
>>       +       dmesg(1) may have more information after failed mount sys=
tem call.
>>       +umount: /mnt/scratch: not mounted.
>>       ...
>>       (Run 'diff -u /home/adam/xfstests/tests/btrfs/136.out /home/adam/=
xfstests/results//btrfs/136.out.bad'  to see the entire diff)
>>
>> [CAUSE]
>> Currently ext* doesn't support block size larger than page size, thus
>> at mkfs time it will output the following warning:
>>
>>   Warning: blocksize 8192 not usable on most systems.
>>   mke2fs 1.47.3 (8-Jul-2025)
>>   Warning: 8192-byte blocks too big for system (max 4096), forced to co=
ntinue
>>
>> Furthermore at ext* mount time it will fail with the following dmesg:
>>
>>   EXT4-fs (loop0): bad block size 8192
>>
>> [FIX]
>> Check if the mount of the newly created ext* succeeded.
>>
>> If not, since the only extra parameter for mkfs is the block size, we
>> know it's some block size ext* not yet supported, and skip the test
>> case.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/012 | 3 +++
>>   tests/btrfs/136 | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/tests/btrfs/012 b/tests/btrfs/012
>> index f41d7e4e..665831b9 100755
>> --- a/tests/btrfs/012
>> +++ b/tests/btrfs/012
>> @@ -42,6 +42,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seq=
res.full 2>&1 || \
>>   	_notrun "Could not create ext4 filesystem"
>>   # Manual mount so we don't use -t btrfs or selinux context
>>   mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
>> +if [ $? -ne 0 ]; then
>> +	_notrun "block size $BLOCK_SIZE is not supported by ext4"
>> +fi
>=20
> Hmm... the mount failure maybe not caused by the "$BLOCK_SIZE is not sup=
ported",
> I'm wondering if this _notrun might ignore real bug. How about check the
> "blocksize < pagesize" at least?

The only extra parameter passed to mkfs.ext* is "-b $BLOCKSIZE", and if=20
it's really some bug inside e2fsprog and it only affects bs > ps, we're=20
still going to miss the bug.

Is there any proper way to reliably check the supported block size of=20
ext*? Like some sysfs knobs?

Thanks,
Qu

>=20
>>  =20
>>   echo "populating the initial ext fs:" >> $seqres.full
>>   mkdir "$SCRATCH_MNT/$BASENAME"
>> diff --git a/tests/btrfs/136 b/tests/btrfs/136
>> index 65bbcf51..6b4b52e4 100755
>> --- a/tests/btrfs/136
>> +++ b/tests/btrfs/136
>> @@ -45,6 +45,9 @@ $MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_DE=
V > $seqres.full 2>&1 || \
>>  =20
>>   # mount and populate non-extent file
>>   mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
>> +if [ $? -ne 0 ]; then
>> +	_notrun "block size $BLOCK_SIZE is not supported by ext3"
>> +fi
>>   populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
>>   _scratch_unmount
>>  =20
>> --=20
>> 2.51.0
>>
>>
>=20
>=20


