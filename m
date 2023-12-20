Return-Path: <linux-btrfs+bounces-1076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751F819AE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 09:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4A4B227A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9AD1CA8C;
	Wed, 20 Dec 2023 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sZIAilne"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D651C695
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703062265; x=1703667065; i=quwenruo.btrfs@gmx.com;
	bh=AHXdoxSosAj0WwaoIwW2XnJPZqriuhEH4H4Y/pFx0Hw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=sZIAilneBcOMNdJfsFkuWW/p/dWgdCIQXEbF/A4S141GyctrFkfaSI5L860AExqO
	 z4ucwGrJqDLflCHXgam83QRrcK3PcEZ+jz6GXESzdskCDMDZt75OFi1tjIdqVWFcn
	 jIXug1PGeWbGun+yuTS76zm1cplIpjjY0Vghr5VphTXn6Rj6xReAyQgXU/KD6WziR
	 gNltCFWQV3Ibho5xayf10+mHKZ6rFvihlZyhTLxB9JZuTu4jTP/c0iau2OR4rq8Yl
	 Pnor4CvFwKX7c8i6N4l2E162rEMzSPSnOm2HEoKAVwhv0bR0QqOUfdBBL9ho8pODn
	 3KZMJc8Z3jXDJEmj8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([115.64.109.135]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWAOQ-1rmMZ02A5i-00XfTK; Wed, 20
 Dec 2023 09:51:05 +0100
Message-ID: <4b4089fd-9ea5-4b09-aafb-ed3cd6d51505@gmx.com>
Date: Wed, 20 Dec 2023 19:21:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Logical to Physical Address Mapping/Translation in Btrfs
Content-Language: en-US
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: saranyag@cdac.in, linux-btrfs@vger.kernel.org
References: <000b01da326e$b054cdb0$10fe6910$@cdac.in>
 <0f6ab509-2403-4ab6-af3f-d5beb559b450@gmx.com>
 <CAA91j0XoJ9JTqvFpeSJ+SKbhHc=QrX49SNJ0yJo+j8TjzGTsRw@mail.gmail.com>
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
In-Reply-To: <CAA91j0XoJ9JTqvFpeSJ+SKbhHc=QrX49SNJ0yJo+j8TjzGTsRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uGdlETSEyuC8d1ZR7uTRKgZ7CKCV93Hb9spiGxwg20fk3OsaFP/
 X9QPsnp8alS9rlb/VNlC7a2aKstWbxELm5WJT4i+bhDkQAEqcXH6ItWtmZAFBgsKUbr1psS
 9akPzKEbS6G+oryw2NysNwZF4f5iYfI6QMFknHu48SMAJD7eLaJpyoQabTWiSAla/e3IATr
 nEMb5KVbh/icvQnGbqO5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gYR2K+qqd8A=;rl5bLooFG0mltOjwt2Px9PiTUqQ
 OKbtnLipiqHn+ocpzLB6md8WObwTWuQyP203ZnckomBhLNhdEmUjxD5C8qzFOG5XHtatMXUU5
 5WGqonUVrVdK7+lcu5Kv4qbuXFIEDJUffPJgWukUqgpBbxfvRbbrvowjsCbm3X36Esu8cnJtX
 yRQbFxbH7aptmAO+lgennpDHXQt4GT5/vuc5dYewwsMM66fZ0TUR0gvKmhDLlLmGEqHdcN/hW
 y4khAgYf9QYjHZ/nbY1o9Kc4x0qpr3MQ+OUsa/804ZrMiFpwDsrIDofmAYgsEkiGMVEjb1aRI
 LP2SlssnbGKeJbPs39Wy+IQvWQ0P8n2M5cS8CYL4/rg1+snPY6+FtQW6kSlXUS83I7zsYxlYi
 YFUr4ueA2ryxyySS5KuLIde6B1RY6re4/HrqjSTr19v023CPktspIBo8PmN8aAW/6JlYe0Thr
 /5g53Q89v47q9oCSP7EUjbjabXx+R7mD4bYFphUDTuhb+JttWt5/YLjBYDkTSoRKIHmNRFNee
 HBAtC2oAZgPyouqDZH5o+fN5O0KuhkKqd4+xkmbuAIO8XBgLvXc1q8Vkm0AlX0HyXFBDL9tPe
 cDhQjbGku8udoT4192iVobYIu5uy7njs2Snv7bFYw4zYAAcHnFsQd5Q/NKUs9fbwJsBWKwAym
 CchHqn/jjLYFO6f+JH5UYxHS9HAv9oMQuXkXtJig+Pu4rXD4ZzMFg3PmtMBoVA//wZ/+xTGM5
 29bTbaQM+4MghqMc6/e4DX0M+Eo/n10/pZqonWXJHGFI5423mA2GddAG2H6kcu17IWlP8NajS
 mniqV3t5w96/vQWzjd9+8SLRlJNnGy+ZrVsj9fcDAyCxFMF8vyuFyiAvNMj9L9jJ9vPNa5lGE
 oIqdxW9xPSfFke818oSjYF+1AyM/NKX6oGw5VOa5mQis//QJA1CpxuvYnwRcwZ1QgzN33glRn
 QoOUO40AXIFEIg7Go3Mmq3o/mEM=



On 2023/12/20 17:54, Andrei Borzenkov wrote:
> On Wed, Dec 20, 2023 at 1:20=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> On 2023/12/19 21:59, saranyag@cdac.in wrote:
>>> Hi,
>>>
>>> May I know how the logical address is translated to the physical addre=
ss in
>>> Btrfs?
>>
>> This is documented in btrfs-dev-docs/chunks.txt:
>>
>> https://github.com/btrfs/btrfs-dev-docs/blob/master/chunks.txt
>>
>
> I tried to read it three times and I still do not understand it.
>
> It starts with showing two chunks - metadata and data
>
> --><--
> item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 4593811456) itemoff 15863 itemsi=
ze 112
> length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 2 sub_stripes 1
> stripe 0 devid 2 offset 2425356288
> dev_uuid a7963b67-1277-49ff-bb1d-9d81c5605f1b
> stripe 1 devid 1 offset 2446327808
> dev_uuid 5f8b54f0-2a35-4330-a06b-9c8fd935bc36
>
> item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 2446327808) itemoff 15975 itemsi=
ze 112
> length 2147483648 owner 2 stripe_len 65536 type DATA|RAID0
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 2 sub_stripes 1
> stripe 0 devid 2 offset 1351614464
> dev_uuid a7963b67-1277-49ff-bb1d-9d81c5605f1b
> stripe 1 devid 1 offset 1372585984
> dev_uuid 5f8b54f0-2a35-4330-a06b-9c8fd935bc36
> --><--
>
> Then it apparently talks about writing into metadata chunk, judging by
> the logical address

Firstly, btrfs uses chunk and block groups interchangeably.

Block groups are more used inside extent tree, as we have
BLOCK_GROUP_ITEM, focusing on the used/free space.
Meanwhile for logical -> physical mapping, we use chunk more frequently,
as that's the name of the chunk tree, and CHUNK_ITEM.


>
> --><--
> Consider we want to write 2m at at 4596957184 - that's 3m past the start=
 of
> the data chunk in the previous example. In order to see where in the phy=
sical
> stripe this write will go into we need to derive the following values:
>
> block group offset =3D [address within block group] -  [start address of
> block group]
> block_group_offset =3D 4596957184 - 4593811456 =3D 3145728 =3D> 3m
> --><--
>
> The chunk start 4593811456 is metadata. But when talking about
> physical location it suddenly takes address of the device extent of
> the data chunk
>
> --><--
> physical_address =3D [physical stripe start] + [logical_stripe] *
> [logical stripe_size]
> physical_address =3D 1351614464 + 48 * 64k =3D 1351614464 + 3145728 =3D =
1354760192
> --><--

Damn it, this part is for RAID0, and is not correct since our write
should arrive in RAID1 METADATA chunk.

In that case, RAID1* is pretty simple, every mirror is the a full copy
of each other, no striping/rotation.

Thus in that block group offset of 3M writes, we should write into both
mirrors:

physical_address =3D [physical stripe start] + [offset inside bg]

Thus the result should be:
Mirror 1 [devid 2] physical address =3D 2425356288 + 3m
Mirror 2 [devid 1] physical address =3D 2446327808 + 3m.


>
> 1351614464 is the address of the stripe 0 of the data chunk. It is
> completely unclear whether it is intentional or not.
>
> Nor does it explain how the device extent (physical stripe) is
> selected and how it jumps from the block_group_offset to the
> (physical) stripe number.

For RAID0 the whole situation is a little complex, but still easy to
understand.

Firstly for a RAID0 chunk, they are split into 64K length stripes, and
each 64K stripe are spread into each device.
If we have a RAID0 chunk with 2 devices, just like the data chunk example:

Off inside bg        0          +64K       +128K      +192K
                      | Stripe 0 | Stripe 1 | Stripe 2 | ...

Then Stripe 0 would be at the first dev extent of that data chunk, with
offset 0 to the dev extent (devid 2 physical 1351614464 + offset 0)
Stripe 1 would be at the second dev extent, with offset 0 to the dev
extent. (devid 1 physical 1372585984 + offset 0).

And for stripe 2, it would be at the first dev extent again, but offset
64K to the dev extent.

So for the bg offset 1m write for the RAID0 data chunk, it would be at:

1) stripe_nr =3D bg_offset / stripe_length
                       1M / 64K              =3D 16

2) Choose which dev-extent to be write into:
    stripe_index =3D (bg_off / stripe_len) % nr_dev
                   (    1M / 64K       ) % 2     =3D 0
    Thus we choose the dev stripe 0 ( devid 2 offset 1351614464) of that
    data chunk.

3) Final physical offset
    physical_off =3D dev_extent_off + offset_in_stripe + skipped_physical
		=3D dev_extnet_off + (bg_off & stripe_mask) +
                   stripe_nr / nr_dev * stripe_len
                 =3D 1351614464     + (1M & (64K - 1)) + 16 / 2 * 64K
                 =3D 1351614464     + 0 + 8 * 64K

Remember, all these calculation is the same for regular RAID0.

For RAID10, it's RAID1 for each RAID0 stripe.
Just make above nr_dev to be (nr_dev / 2).
In btrfs' case, we use sub_stripe to distinguish the calculation.
For RAID10, sub_stripe would always be 2, and RAID0 would always have
sub_stripe as 1.

Thus above nr_dev can be replaced to (nr_dev / sub_stripes), and then
can cover both RAID0 and RAID10.

>
> Intermixing "chunk" and "block group" does not help in understanding it =
either.
>
> And I suspect RAID5/6 is something entirely different ...

RAID5/6 is mostly based on RAID0, but with more rotation involved, thus
more complex.

I can explain RAID56 in more details, if you can grasp the RAID0 and
RAID1, and RAID10 part first.

And RAID0 behavior are shared between LVM striped/dm-raid0/btrfs RAID0,
following the same behavior (IIRC).

The same for RAID1, among LVM mirrored/dm-raid1/btrfs RAID1.

Thanks,
Qu
>

