Return-Path: <linux-btrfs+bounces-7466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8A95D892
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 23:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255E328894D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077121C8229;
	Fri, 23 Aug 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aBdSYuLf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA581925A9
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448795; cv=none; b=VRDyS+cbVrhlETZHw8lX3+nQcLqA64HGR1Yr6tzWbwyEIqWI0q36k9QbkY1nPnFWEnYwaisomPIb2ZogNGBAh0GnGY5j77Zo5dIMioZdGClGrVgADz3l9fYMo4z2DRuxHV5CqSike+x0dBo3IZmDX34eTD9kOEky2Z5PXPVuvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448795; c=relaxed/simple;
	bh=AP2xtfJQX0InD9GAAWbPHaYN3MmlCUYnRVZF3VZi/L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHpv9hvDVPxS1B7uoxOOS69eNNMXGJ6QUiuqd0qmc94pCKqf6YQyytNljHlABVvC/+t94FDBF3pZ80cReu1pjPG3cpflMjbd1QGkemmKsxOzl9QW27BbhIgX+l098auw7Zm97g8snM7ic0F9kQnFxgdGWRe2xKa2Catm8CqMPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aBdSYuLf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724448753; x=1725053553; i=quwenruo.btrfs@gmx.com;
	bh=f8mSwkgnyQPo6Q0vx0G71jWyqffsVfB3oVMh6Szvr+c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aBdSYuLfQpzFvGNyShvTzHN0BagH6u+o2kLEjGtGQkTVzF7+BKZ0mSspyKLdARsu
	 EmsYYSIhLzuKqGqng6R2/bFwe1YDtg5ZLbaaKUDv5KSNwKDHHitdNmREi6ErDo0/t
	 a67rp4L/eMlrLchSVZIWyv+bplubZAytsMNvMnbansJL12UpK+PFgzOF2YUCHoHbo
	 /jAWiG8g24rpfa6ui73fGstUm8s+/Cj7YMA/oUHOXhbWC4EmXuasvzJAAefDnjURo
	 4ePtiLJi2kg43ghyUji8KrUIBrw7irTnrFAcM2kSniIo3s3RyY1GRBSSkKWQO9DTK
	 Z4Gk+p9pyHdZo5Gr7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdvmY-1s9uyN0ajG-00dTSY; Fri, 23
 Aug 2024 23:32:33 +0200
Message-ID: <ff1e31d3-5c4a-407b-89a3-ded574dc3a2a@gmx.com>
Date: Sat, 24 Aug 2024 07:02:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] btrfs: convert get_next_extent_buffer() to take a
 folio
To: Matthew Wilcox <willy@infradead.org>
Cc: Li Zetao <lizetao1@huawei.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, terrelln@fb.com, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
 <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>
 <ZscqGAMm1tofHSSG@casper.infradead.org>
 <38247c40-604b-443a-a600-0876b596a284@gmx.com>
 <7a04ac3b-e655-4a80-89dc-19962db50f05@gmx.com>
 <Zsis82IKSAq6Mgms@casper.infradead.org>
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
In-Reply-To: <Zsis82IKSAq6Mgms@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9tQbeQ4b9S06l9tgBRI1QlrRc+ehSgemh/yVOGcPn+/pR3zjk7I
 jFtzJKpp+b9OdTIWvUEvRAa2Gow/R4Wq4e0lbE1Y/AtLKfVnOC+WeCGCe6GICxnT66ez8EA
 WJOvO6Xk3+9uvAfOt+ai5mOiUa/wWK1HmFxMztIEOUXoOWN7FzjG1cf4BU+VyVyY2lKGlRq
 uhj3uPR2jnzx4mk1ELjGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yWGEyrX/yws=;hK+f8NUt9DZu4i4h88xhVlO42Um
 fOrILI5FZIGtrdyuGT2OpV3ULziEGuy/sLyFpnJFKPTAvNm6C0qIUyyzoeIl2Ss07nt6JlhJ3
 8/Fy+LlbLY4kn4DzLSuWlKaKQeHW02Dc0jydD2WuIFR2dwoIkMGJfarJHWeUgkhU3UjOZdDwv
 UnWyObAUqE3PDomwG9ROySnmuKk236vf1R6Gy5Aa3Q/cYoHSRI7akwIabsUegsVz717gkL37e
 3lDVw2QE7N/+D/Xh3IB/D0cg1vf8BrSkOhYdR6+h6pMQk3NP5Qb3T2eW6kDJT0BKYAFZ4QAVg
 HCY+6RrODXi6KtbJiTij/gx6TR0YCc+hirx1GXmXINSfUmXKrYPrel8Z/c+e1CWutS9fRqWHn
 o1I/k0FtT+jeW958DQgqz71pVbVEBvlwi335T5kD/VWJy53Kn0PlosAVq/R0DG/TyMS0X9Fpz
 h12wKi1UutEWEvIyul/jJnHIHwrCKZMwSN0MVATWCzhhM+L688vunjYWc5cr3FfwxA1VAyyIy
 wBCFCrdKZCgMY2EK+nRegk6QEe+NzNXIuaMEipaGz3VbERoQQMWFmi0N8jXO+FimPiEKt5SXU
 Gv6UjqP0bmeGME9CVmFiCgT6YuNgwSisruLfbD/xlel7nTDJCYMc4ojx0dPgz3aZCOLGpBTuT
 x43pkYUFFM3Hm/lPn5i9PBkLsx7skij/iLFkGfrnc/UnfyvJeawgI3/6xVnAgfkgULRiX4SoN
 FmRQEnInYA5Cs1iOVLmyn58akRt6/oe7R0NNmQ11NzxfStQfB+PFlJB8uLAF9nU0Ongy1vy2m
 pHKz22yniVqywUg6VGywSJnQ==



=E5=9C=A8 2024/8/24 01:08, Matthew Wilcox =E5=86=99=E9=81=93:
> On Fri, Aug 23, 2024 at 11:43:41AM +0930, Qu Wenruo wrote:
>> =E5=9C=A8 2024/8/23 07:55, Qu Wenruo =E5=86=99=E9=81=93:
>>> =E5=9C=A8 2024/8/22 21:37, Matthew Wilcox =E5=86=99=E9=81=93:
>>>> On Thu, Aug 22, 2024 at 08:28:09PM +0930, Qu Wenruo wrote:
>>>>> But what will happen if some writes happened to that larger folio?
>>>>> Do MM layer detects that and split the folios? Or the fs has to go t=
he
>>>>> subpage routine (with an extra structure recording all the subpage f=
lags
>>>>> bitmap)?
>>>>
>>>> Entirely up to the filesystem.=C2=A0 It would help if btrfs used the =
same
>>>> terminology as the rest of the filesystems instead of inventing its o=
wn
>>>> "subpage" thing.=C2=A0 As far as I can tell, "subpage" means "fs bloc=
k size",
>>>> but maybe it has a different meaning that I haven't ascertained.
>>>
>>> Then tell me the correct terminology to describe fs block size smaller
>>> than page size in the first place.
>>>
>>> "fs block size" is not good enough, we want a terminology to describe
>>> "fs block size" smaller than page size.
>
> Oh dear.  btrfs really has corrupted your brain.  Here's the terminology
> used in the rest of Linux:
>
> SECTOR_SIZE.  Fixed at 512 bytes.  This is the unit used to communicate
> with the block layer.  It has no real meaning, other than Linux doesn't
> support block devices with 128 and 256 byte sector sizes (I have used
> such systems, but not in the last 30 years).
>
> LBA size.  This is the unit that the block layer uses to communicate
> with the block device.  Must be at least SECTOR_SIZE.  I/O cannot be
> performed in smaller chunks than this.
>
> Physical block size.  This is the unit that the device advertises as
> its efficient minimum size.  I/Os smaller than this / not aligned to
> this will probably incur a performance penalty as the device will need
> to do a read-modify-write cycle.
>
> fs block size.  Known as s_blocksize or i_blocksize.  Must be a multiple
> of LBA size, but may be smaller than physical block size.  Files are
> allocated in multiples of this unit.
>
> PAGE_SIZE.  Unit that memory can be mapped in.  This applies to both
> userspace mapping of files as well as calls to kmap_local_*().
>
> folio size.  The size that the page cache has decided to manage this
> chunk of the file in.  A multiple of PAGE_SIZE.
>
>
> I've mostly listed this in smallest to largest.  The relationships that
> must be true:
>
> SS <=3D LBA <=3D Phys
> LBA <=3D fsb
> PS <=3D folio
> fsb <=3D folio
>
> ocfs2 supports fsb > PAGE_SIZE, but this is a rarity.  Most filesystems
> require fsb <=3D PAGE_SIZE.
>
> Filesystems like UFS also support a fragment size which is less than fs
> block size.  It's kind of like tail packing.  Anyway, that's internal to
> the filesystem and not exposed to the VFS.

I know all these things, the terminology I need is a short one to
describe fsb < PAGE_SIZE case.

So far, in the fs' realm, "subpage" (sub page sized block size) is the
shortest and simplest one.

Sure you will get confused with a "subpage" range  inside a page, but
that's because you're mostly working in the MM layer.

So please give me a better alternative to describe exact "fbs <
PAGE_SIZE" case.
Or it's just complaining without any constructive advice.

>
>>>> I have no idea why btrfs thinks it needs to track writeback, ordered,
>>>> checked and locked in a bitmap.=C2=A0 Those make no sense to me.=C2=
=A0 But they
>>>> make no sense to me if you're support a 4KiB filesystem on a machine
>>>> with a 64KiB PAGE_SIZE, not just in the context of "larger folios".
>>>> Writeback is something the VM tells you to do; why do you need to tag
>>>> individual blocks for writeback?
>>>
>>> Because there are cases where btrfs needs to only write back part of t=
he
>>> folio independently.
>
> iomap manages to do this with only tracking per-block dirty bits.

Well, does iomap support asynchronous compression?

This proves the point of Josef, different people have different focus,
please do not assume everyone knows the realm you're doing, nor assume
there will always be a one-fit-all solution.

>
>>> And especially for mixing compression and non-compression writes insid=
e
>>> a page, e.g:
>>>
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 16K=C2=A0=
=C2=A0=C2=A0=C2=A0 32K=C2=A0=C2=A0=C2=A0=C2=A0 48K=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 64K
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |//|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |///////|
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4K
>>>
>>> In above case, if we need to writeback above page with 4K sector size,
>>> then the first 4K is not suitable for compression (result will still
>>> take a full 4K block), while the range [32K, 48K) will be compressed.
>>>
>>> In that case, [0, 4K) range will be submitted directly for IO.
>>> Meanwhile [32K, 48) will be submitted for compression in antoher wq.
>>> (Or time consuming compression will delay the writeback of the remaini=
ng
>>> pages)
>>>
>>> This means the dirty/writeback flags will have a different timing to b=
e
>>> changed.
>>
>> Just in case if you mean using an atomic to trace the writeback/lock
>> progress, then it's possible to go that path, but for now it's not spac=
e
>> efficient.
>>
>> For 16 blocks per page case (4K sectorsize 64K page size), each atomic
>> takes 4 bytes while a bitmap only takes 2 bytes.
>>
>> And for 4K sectorsize 16K page size case, it's worse and btrfs compact
>> all the bitmaps into a larger one to save more space, while each atomic
>> still takes 4 bytes.
>
> Sure, but it doesn't scale up well.  And it's kind of irrelevant whether
> you occupy 2 or 4 bytes at the low end because you're allocating all
> this through slab, so you get rounded to 8 bytes anyway.
> iomap_folio_state currently occupies 12 bytes + 2 bits per block.  So
> for a 16 block folio (4k in 64k), that's 32 bits for a total of 16
> bytes.  For a 2MB folio on a 4kB block size fs, that's 1024 bits for
> a total of 140 bytes (rounded to 192 bytes by slab).

Yes it's not scalable for all folio sizes, but the turning point is 32
bits, which means 128K folio for 4K page sized system.
Since the folio code already consider order > 3 as costly, I'm totally
fine to sacrifice the higher order ones, not the other way around.

Although the real determining factor is the real world distribution of
folio sizes.

But for now, since btrfs only supports 4K block size with 64K/16K page
size, it's still a win for us.

Another point of the bitmap is, it helps (at least for me) a lot for
debugging, but that can always be hidden behind some debug flag.


I'm not denying the possibility to fully migrate to the iomap way, but
that will need a lot of extra work like clean up the cow_fixup thing to
reduce the extra page flag tracking first.
(That always causes a lot of discussion but seldomly leads to patches)

Thanks,
Qu
>
> Hm, it might be worth adding a kmalloc-160, we'd get 25 objects per 4KiB
> page instead of 21 192-byte objects ...
>
>

