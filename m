Return-Path: <linux-btrfs+bounces-8547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256F990049
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B192837B5
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F2D146000;
	Fri,  4 Oct 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FmteCzLP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A821148827;
	Fri,  4 Oct 2024 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035592; cv=none; b=syn7wuO9u9rkoC9gJeIkr0Suq56c+D/K8y8gHdFF13uL2WsQyf5K6Tr7HU05O+5M0inIxn6KPQEbW2tWsXyc/cEcOiLHyq+2odSNk0UH5BXaNOrkbNlgt6600qSB4pR7jSkCyHlRwXWF7g858HGgdnjExxNjLVSlkL/FUBhcrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035592; c=relaxed/simple;
	bh=Cx//6DAvo2hVyoNezFO6tB8R0SypKlUC9Pyrj1YD6AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rlox0HIggHjT7rE9EXu9ChVgiuNWYgHaD5yUdkhF5i7a12vlyhyRjVMj7810euyg+GrHrrntIKSMD8mLB05Ohh1GnZCc2LM/nJxuPleLzNfD1mIOlj/cCahgu1xh9xXzB1UcAr9KLigG4/KTMHRyPiBhFNAS9k4mpOSqECQnAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FmteCzLP; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728035579; x=1728640379; i=quwenruo.btrfs@gmx.com;
	bh=WyXEBwfOPTiJH0CUnJlXc+6egK2jO7/LeF30KtVM7fE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FmteCzLPUnhO8KWzROUCxp/NbLRuBGM1/0yfyENYJ4/P/zX2DTzjFMsIDhywjq79
	 Z05d2XJIwWits+OA9JXH/SWwYCL+yhaT8cOsX3LZI/j33cr6APPx2QFFJgG8dnITA
	 YYdNHactFBdEX2nGXoI//CKeVLzKocmBTZGc8jAecyPib8jd93lE63d0EtYUjLK5W
	 6V8McScyFgtY/q/68Mi3LrbRgvanod/Tn4DenJXizKJgiFwD0SBnCEq+krhWylU4H
	 ovFhNlFTFMJlVMvKXnbttIn0Wse7Vn1yBqIDp9zU8NNfDAWo6JXKmkQpL2/0vCqvx
	 qi2OwfrN51mj2r9phA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDQeK-1smB803Rmo-00BMBx; Fri, 04
 Oct 2024 11:52:59 +0200
Message-ID: <509d89fa-56a2-4c01-bd3a-828e00e7a314@gmx.com>
Date: Fri, 4 Oct 2024 19:22:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/563: use fs blocksize to do the writes
To: Mark Harmstone <maharmstone@meta.com>, Qu Wenruo <wqu@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Boris Burkov <boris@bur.io>
References: <20240929235038.24497-1-wqu@suse.com>
 <805c5e48-050e-48b2-be53-1a2f0fa4a088@meta.com>
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
In-Reply-To: <805c5e48-050e-48b2-be53-1a2f0fa4a088@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KADHVFpjtr+re8a/mpZyteEE38hajyj7hxtCo3AStpamBAtx0uE
 AYdHb5VlLtvEPb1pWQCVz6hqYL2ghd/3w25HGrGyIx4hGVIUcso+2lycXXevOjvwo8IQAeu
 rSsLq1PohDntMKxIsDaCqYu13EpZ2Zew6NFQEFSjnbL4yZ49u05iwAB7SW5DlF0vkV6pXiG
 GG6znBbf4KyJGbOheA60g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XuLbYaxgl8I=;OWen7R5S1Uvb6YUJv8KAZqnJ068
 h9FoSWE2e1rlKoeTT5R7DwfGQeLYYQOctQ0fNXY7ljwLp5tPGtWgWxxGjPtHipAWNqN2xT+Ac
 qqcMi5n8Rw1/BuwrNpRE0f1KlJL6xb6e4YUJwO4Jf/3XclGhnCz2pkYLNoT4eGIusGmUPpbP6
 7ELahdNh3pAeZ5kMkosPV5ibsUHbAUsROZuqozUt3MF86AGDlgeNWwPgqwEaINKm2/GY8saaV
 iS7ggXsYFi50uM0mcSPge0M5SQw+i1CR6DI8dXrZqKsJugGDKrpjg+zRdQF58/JDB12EZBfAu
 Upd70m2Tz63/wVzX0mUNy7ad8ZiRcuLx7pbcVfNViMJkHib3NBv+PzPnNRQ1eOJtJ+94pmFDH
 iQb/TVg23FXssfYpnhvRSFzuEIH+WpGibWVjX5xzUPLdxKnPFH3A5R23EGnBny2bYmjWHhL+G
 h1d2gxCMXBEcJt2LEE66FhXnzCxVEf8F5Gop+VZkF23ol3O3MhZIMLAcyktX4unra0F2n9xRz
 o1i3JrOu11EnGsiErFgiOFOepewox40gfi38jzElIefk3pMs/4IJv+JsPm9AcOSxKWCNFT9qK
 X3CpwP8HYpPExfaSDsLPSqsp9ElvEsgfyH0dku0qNLktJP2HoU1Kej8dm4Lpe4jQ4p3wf/50i
 sJX5GnbEMIMYVNQewieGLSwwbOq9MqN0Y3tFpzvFJyrfFYOSnMOSGHv9+JYZedJ7w9uHFSr3M
 pfyqQAgTUSQzKcMF4qKUFCo/iMYjSjs7Jiw3endBJOe6W1JUepf3bpwJCcUlQ4xmtqBr+ZBTb
 0SLA1Q3ObbN71wLpHGnR3dOg==



=E5=9C=A8 2024/10/4 19:15, Mark Harmstone =E5=86=99=E9=81=93:
> On 30/9/24 00:50, Qu Wenruo wrote:
>>>
>> [FALSE ALERTS]
>> If the system has a page size larger than 4K, and the fs block size
>> matches the page size, test case generic/563 will fail:
>>
>>       --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
>>       +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-=
30 09:09:16.155312379 +0930
>>       @@ -3,7 +3,8 @@
>>        read is in range
>>        write is in range
>>        write -> read/write
>>       -read is in range
>>       +read has value of 8388608
>>       +read is NOT in range -33792 .. 33792
>>        write is in range
>>       ...
>>
>> Both Ext4 and btrfs fail with 64K block size and 64K page size
>>
>> [CAUSE]
>> The test case writes the 8MiB file using the default block size xfs_io
>> pwrite, which is 4KiB.
>>
>> Since the fs block size is 64K, such 4KiB write is unaligned inside a
>> block, causing the fs to read out the full page.
>>
>> Thus the pwrite will cause the fs to read out every page, resulting the
>> above 8MiB+ read value.
>>
>> [FIX]
>> Fix the test case by using the fs block size to avoid such unaligned
>> buffered write.
>>
>
> I ran generic/563 on a Raspberry Pi running 6.4 and with a 64K page
> size, and got a similar error:
>
> FSTYP         -- btrfs
> PLATFORM      -- Linux/aarch64 fstests-aarch64 6.4.3-arm64-g0ef0e2e48724
> #61 SMP Tue Aug  6 16:51:45 BST 2024
> MKFS_OPTIONS  -- /dev/vdc
> MOUNT_OPTIONS -- /dev/vdc /mnt/scratch-dir
>
> generic/563       - output mismatch (see
> /root/xfstests/results//generic/563.out.bad)
>       --- tests/generic/563.out   2024-08-05 10:33:23.000000000 -0000
>       +++ /root/xfstests/results//generic/563.out.bad     2024-10-04
> 09:35:51.433413098 -0000
>       @@ -3,7 +3,8 @@
>        read is in range
>        write is in range
>        write -> read/write
>       -read is in range
>       +read has value of 8421376
>       +read is NOT in range -33792 .. 33792
>        write is in range
>       ...
>       (Run 'diff -u /root/xfstests/tests/generic/563.out
> /root/xfstests/results//generic/563.out.bad'  to see the entire diff)
> Ran: generic/563
> Failures: generic/563
> Failed 1 of 1 tests
>
> The same happens whether the btrfs volume has a sector size of 4K or
> 64K, and the patch doesn't seem to fix it.

For 4K sector size 64K page size btrfs, it needs several kernel patches
to proper fix it.
(https://github.com/adam900710/linux/tree/subpage_read)


The above case only shows the 4K sector size case (the new default of
mkfs.btrfs, no matter page size now).

For 64K sectorsize with 64K page size case, you need to specify the "-s
64K" mkfs option, apply the patch, only after that the test can pass:

Unpatched:

FSTYP         -- btrfs
PLATFORM      -- Linux/aarch64 btrfs-aarch64 6.11.0-rc7-custom+ #70 SMP
PREEMPT_DYNAMIC Thu Oct  3 07:25:40 ACST 2024
MKFS_OPTIONS  -- -s 64k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

generic/563 4s ... - output mismatch (see
/home/adam/xfstests-dev/results//generic/563.out.bad)
     --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
     +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-10-04
19:19:19.699153483 +0930
     @@ -3,7 +3,8 @@
      read is in range
      write is in range
      write -> read/write
     -read is in range
     +read has value of 8388608
     +read is NOT in range -33792 .. 33792
      write is in range
     ...
     (Run 'diff -u /home/adam/xfstests-dev/tests/generic/563.out
/home/adam/xfstests-dev/results//generic/563.out.bad'  to see the entire
diff)
Ran: generic/563
Failures: generic/563
Failed 1 of 1 tests

Patched:

FSTYP         -- btrfs
PLATFORM      -- Linux/aarch64 btrfs-aarch64 6.11.0-rc7-custom+ #70 SMP
PREEMPT_DYNAMIC Thu Oct  3 07:25:40 ACST 2024
MKFS_OPTIONS  -- -s 64k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

generic/563 4s ...  1s
Ran: generic/563
Passed all 1 tests


You can also do the same using ext4:

Unpatched:

FSTYP         -- ext4
PLATFORM      -- Linux/aarch64 btrfs-aarch64 6.11.0-rc7-custom+ #70 SMP
PREEMPT_DYNAMIC Thu Oct  3 07:25:40 ACST 2024
MKFS_OPTIONS  -- -F -b 64k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/mapper/test-scratch1 /mnt/scratch

generic/563 1s ... - output mismatch (see
/home/adam/xfstests-dev/results//generic/563.out.bad)
     --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
     +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-10-04
19:21:23.377651352 +0930
     @@ -3,7 +3,8 @@
      read is in range
      write is in range
      write -> read/write
     -read is in range
     +read has value of 8388608
     +read is NOT in range -33792 .. 33792
      write is in range
     ...
     (Run 'diff -u /home/adam/xfstests-dev/tests/generic/563.out
/home/adam/xfstests-dev/results//generic/563.out.bad'  to see the entire
diff)
Ran: generic/563
Failures: generic/563
Failed 1 of 1 tests

Patched:

FSTYP         -- ext4
PLATFORM      -- Linux/aarch64 btrfs-aarch64 6.11.0-rc7-custom+ #70 SMP
PREEMPT_DYNAMIC Thu Oct  3 07:25:40 ACST 2024
MKFS_OPTIONS  -- -F -b 64k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/mapper/test-scratch1 /mnt/scratch

generic/563 1s ...  1s
Ran: generic/563
Passed all 1 tests


Mind to re-verify with the proper mkfs options?

Thanks,
Qu
>
> Mark
>


