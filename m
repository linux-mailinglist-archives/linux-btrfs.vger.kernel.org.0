Return-Path: <linux-btrfs+bounces-10025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9111E9E15FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 09:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5156B28166C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA21DB52A;
	Tue,  3 Dec 2024 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NouttaQl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A971DA63F
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215137; cv=none; b=ChfAx2EyQGv09/BuHoJYF5flmSH05bqPNlnUKT6sjY3WkOzp4SKig/QbDG8vwgNabJ/rlGsufSS3Ewwv6G1IszqgN7arbunZZXu9T+G+VCWnrTeib36JPA17XiJhe9nW/9GQMImAD4gSgms6KtozPiCy5eoskIwuEDrKngo5m84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215137; c=relaxed/simple;
	bh=T6+nZxW47LPKL/nRShOtLQ9xhbtmdpbzkxdK8WBndm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8BPXYSz72LUMKaZy4iFyd7VV5n+KW+UOC4e7uvNCm+WWoFKeLrA8y3T2COvVXLnviMl5cw+0Mfsmy5rxynNLLA9hZnJFQqYJDgMDhK3dGkp0ZZqarijWKNVWbd+mP1ZkXGYwWLaNQnQQvpUWiNaTSy5VKvgawgQJ4qxLZaZIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NouttaQl; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733215132; x=1733819932; i=quwenruo.btrfs@gmx.com;
	bh=WWCXjk9yUcaV1GdH9gLp+LUVrveXBqxls4pXHh5fIgI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NouttaQlDp4S+ij2bIVC4272Bkc8JK5wsfF1bNuMfxDigfPIJpHmNKNeJrk32+fp
	 KDHNvpa3tkaO2CaGnP0se12qXQnXyaNTcdIX1uGKFNwceWrwyX+/pNB37LxXHJLmR
	 DFr5u8CB9SzrVLjP4DsR+1Dc3XOW+VNywroetmuypIXYj0fcuBhxYQtdbTPIn2n7i
	 QGraZavA7bK5FoGTEUyPr4Y2Vne3ml/fZPWhrfjerNSTquixsf5DUpBV81XGZP+Mj
	 bnr6zvc60jG2EPspfpc/5vsCmJV9dA0iyFTnsko5NIRv7BWIEp4+Vr+tTuPxqn1mV
	 6r/PiZV/IsZmEyYzUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Mj-1trAsq3dSt-00mgIp; Tue, 03
 Dec 2024 09:38:52 +0100
Message-ID: <ba4f665d-f7fe-438f-a7ba-dc92d16b9f68@gmx.com>
Date: Tue, 3 Dec 2024 19:08:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Balance failed with tree block error
To: Neil Parton <njparton@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAAYHqBbMeLYXdhNondp8JwQCsp-n1cCvnAubS3f2FxD6PBOEsQ@mail.gmail.com>
 <8276d833-d4f2-42dd-8190-c98265896ee3@gmx.com>
 <CAAYHqBZMBmD2yT2C95KrGXNqYjkecEO3jQQ74X5iT+MKxWhpMA@mail.gmail.com>
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
In-Reply-To: <CAAYHqBZMBmD2yT2C95KrGXNqYjkecEO3jQQ74X5iT+MKxWhpMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wOfCj1AdC5ohU5VnOPdlGRfhNapRbKHdGGuoBsRVB+9dqPTZ+lF
 NZe2cht87gSYdnZsg+JWIHtRXXVryt2GwtsfwtCxR7eXFaX083j1UdN3ByQMHJea7zlXh6o
 gnXfkOfrTaRUIqXWp+F4+8tOn0w8+TTfpyd14X32N1ZM2asqTwuLZeIjnmjuHyKXYJdYXbu
 toLcyVFVnPjAuOcbWa0JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bQTW0VzuI0Q=;6mnkUHpYGW2c6DZp3YyuHAaIWa5
 NN62YL720jBF2qAE2seBpHcv+g+MLKxFvARg099lZDcwtLq2d1/wNR559VRhZwJn/PMmAMcIL
 e27l8JPb4JDmGeEQmjdGQzpakZ8y1iysdzvxnKt2aKRike1MAkNVDWxgikQCIPfL2yiT/KhTz
 krBzict9csWmdVAjhopv1yi9Q4F5SjgxGsdyS0OT6iaQoXYeNcIZVmY8lyaGc8m/WcVrmtvGI
 z9A7onac3i0N7PHFfjWdNHjEEuP3CcT2xc+jEP0BH1LkEV/p3Vc0F0N7+w5C0W/2wzPpBNfYk
 /2WCu/tMY7oLO5e3ywi0rq/gh8YaSjixnmPj9F/I0r+fHmcXuRAm6mbTiulIW3tt2cWb2hzsi
 lDTXT7KoHG/oPmZNz0/UXmi2qgvvwljNWmu9FpyzV5eEHq6QyDcAqBu7/nx+7nhgtTxey6/DX
 t/x4xNWP8RYmavohP+q2Vz4bFEVKrHFuu2Pz2/j3KwwTko4V/x179DDZLPKaBUY7ELUAscfYc
 SoBBFRRjPrjtYiQeYmaDRbEqvPa6fp62lVX3czYlKjxWgMGUnROSpgUzx7IrEWrS5lzaFa/8C
 8grq679Lo5x7Gh+BFmZw1T9kSxYRFOYMNBBlO0bD4IYjO1s6d3IT+adjlyax7y1AZFAk2ZTlu
 VUS49EMZUcDUq7bP6TMxEBoGGgMi0T9VwfXS57JcxKGbUkr6xkVJHoWXH7n5eXNzZmH+bZTfT
 8IMIv8MK9e+QrbRgavFFq6pDgydJf1uTjXyjPKjWKRfFvwtyFJfOBDTLM2HTX4a6Jb9HF7G87
 R8FqnwzPUEO+9Z0/Duuslxvdtz4PdStn0nwEGhpTJVZfz1hAgQpzAL3jKxuBpCfkkwODTH28b
 maw0NRRkIJBxyTsAOCnPPKg1SM/PuH8NRymF24IILtUtcj015jwKH+QvBrFZyzTlc+8viuf5A
 aEWkFNnSLBbmGxBtbwkSbSgh7+d5XMwzx01tlxtSBrLswbsKXy0tdZJzpCeY5xYHna9afMqls
 l9EFYEqdnk80s04O3OtC6aGJDJ6q8ZOn7mDPAIlsF9hSGYpdWQ34T8M8jUuvVrotU3D0RMc6h
 SLuus/O75vhJLtYIEKvKALeTr8oxsu



=E5=9C=A8 2024/12/3 18:50, Neil Parton =E5=86=99=E9=81=93:
> OK I've output dmesg to a text file attached, glad you remembered my
> previous experience as I forgot to mention that!

The tree block backref btrfs is searching for is 332886134538240.

But there are only two tree block backref near that number:

[16181.904739] 	item 63 key (332886134521856 168 16384) itemoff 13019
itemsize 51
[16181.904740] 		extent refs 1 gen 12802640 flags 2
[16181.904741] 		tree block key (18446744073709551606 128
334290896531456) level 0
[16181.904741] 		ref#0: tree block backref root 7
[16181.904742] 	item 64 key (332886134554624 168 16384) itemoff 12968
itemsize 51
[16181.904743] 		extent refs 1 gen 12802640 flags 2
[16181.904744] 		tree block key (18446744073709551606 128
334290913148928) level 0
[16181.904745] 		ref#0: tree block backref root 7

So far it's very hard to judge if it's a memory bitflip.

The bytenr 332886134538240 is 0x0x12ec217cc8000, meanwhile the target is
0x12ec217ccc000.

The diff is 0x4000, so it may be a bit flip.

On the other hand, it may also be a case where it's really an extent
tree corruption that cause some backref missing for that 0x12ec217ccc000
bytenr.

I do not have a good call just based on the dmesg.

A full "btrfs check --readonly" output (including both stderr and
stdout) could help a lot.
And if your memtest exposed some error, then it's also very likely it's
a bitflip at runtime, and since such bitflip brings no obvious
corruption btrfs is unable to catch it and wrote it back to disk.

Thanks,
Qu

>
> Thanks
>
> Neil
>
> On Tue, 3 Dec 2024 at 08:16, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/12/3 18:41, Neil Parton =E5=86=99=E9=81=93:
>>> Arch Linux kernel 6.6.63-1-lts, btrfs-progs 6.12-1
>>>
>>> Yesterday I added a 5th drive to an existing raid 1 array (raid1c3
>>> metadata) and overnight it failed after a few percent complete.  btrfs
>>> stats are all zero and there are no SMART errors on any of the 5
>>> drives.
>>>
>>> dmesg shows the following:
>>>
>>> $ sudo dmesg | grep btrfs
>>> [16181.905236] WARNING: CPU: 0 PID: 23336 at
>>> fs/btrfs/relocation.c:3286 add_data_references+0x4f8/0x550 [btrfs]
>>> [16181.905347]  spi_intel xhci_pci_renesas drm_display_helper video
>>> cec wmi btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel
>>> xor raid6_pq
>>> [16181.905354] CPU: 0 PID: 23336 Comm: btrfs Tainted: G     U
>>>      6.6.63-1-lts #1 1935f30fe99b63e43ea69e5a59d364f11de63a00
>>> [16181.905358] RIP: 0010:add_data_references+0x4f8/0x550 [btrfs]
>>> [16181.905431]  ? add_data_references+0x4f8/0x550 [btrfs
>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>> [16181.905488]  ? add_data_references+0x4f8/0x550 [btrfs
>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>> [16181.905551]  ? add_data_references+0x4f8/0x550 [btrfs
>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>> [16181.905601]  ? add_data_references+0x4f8/0x550 [btrfs
>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>> [16181.905654]  relocate_block_group+0x336/0x500 [btrfs
>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>> [16181.905705]  btrfs_relocate_block_group+0x27c/0x440 [btrfs
>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>> [16181.905755]  btrfs_relocate_chunk+0x3f/0x170 [btrfs
>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>> [16181.905811]  btrfs_balance+0x942/0x1340 [btrfs
>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>> [16181.905866]  btrfs_ioctl+0x2388/0x2640 [btrfs
>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>
>>> and
>>>
>>> $ sudo dmesg | grep BTRFS
>>> <deleted lots of repetitive lines for brevity>
>>> [16162.080878] BTRFS info (device sdd): relocating block group
>>> 338737521229824 flags data|raid1
>>> [16175.051355] BTRFS info (device sdd): found 5 extents, stage: move
>>> data extents
>>> [16180.023748] BTRFS info (device sdd): found 5 extents, stage: update
>>> data pointers
>>> [16181.904523] BTRFS info (device sdd): leaf 328610877177856 gen
>>> 12982316 total ptrs 206 free space 627 owner 2
>>> [16181.905206] BTRFS error (device sdd): tree block extent item
>>> (332886134538240) is not found in extent tree
>>
>> There is a leaf dump, please paste the full dmesg, or we can not be sur=
e
>> what the cause is.
>>
>> Although I guess it may be a memory bitflip, considering all the past
>> experience.
>>
>> So after pasting the full dmesg, you may also want to do a full memtest
>> just in case.
>>
>> Thanks,
>> Qu
>>
>>> [16183.091659] BTRFS info (device sdd): balance: ended with status: -2=
2
>>>
>>> What course of action should I take so that the balance completes next=
 time?
>>>
>>> Many thanks
>>>
>>> Neil
>>>
>>


