Return-Path: <linux-btrfs+bounces-7421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B9A95C324
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 04:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B63FB234B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 02:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C31D52D;
	Fri, 23 Aug 2024 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tBpVTJPU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C9111A1
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724379266; cv=none; b=lvLZQ8M86IOgSjr5cXdTphVrXt3HKHgCtaw4SRoV+Pq7gmP+dJIfmmjoxnUn4X6hwXWjdP8VKY+bDWwQmApvsvzMrtmhUb0g2s54hTb0CM5Izjfgr5zyEwUz1kziupNfhK7NJ9bgd681XwHnz9boNIM8h5M9kcxz5U8v5NkNqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724379266; c=relaxed/simple;
	bh=D5a8lMjYh3fZDSEpW/gsSl2As2iqDYpdNnjzsfeBuEk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mowp1Yn37tdcohufydX2q3YtA4oQ5cw/JUbaQR8ynBuwctVdxzckUy5UV5kScuZrL+p/P6RA0P2FThw0YeBDH2Bs+UwYqTOqJJ9QdYNqZtod8M+57lhTzad/ZdOv57yjz1SVKm8HU9B/gL6LO0ro0bQJ5Eqju5sv+841Zn7oNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tBpVTJPU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724379227; x=1724984027; i=quwenruo.btrfs@gmx.com;
	bh=aXrScm3PulmHUJmCd/1Rzxhhm/hbcv77BnAf8YXDiGk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tBpVTJPUqx0mw75Ux8Eg/aqpfKFHe8BXr9vGTMIByIco0wHodPaC5jr6ZsJ6QuHm
	 jv4VFflZ/yvauqkpXEqMLNRkMEZK43+sCTwdMKmD3iFMnZhHgl7KnfdAcQI6NTF4a
	 siRPh4dL4NP9oCZfnsj8C/YmNkjX03bTVefh192uOK1olmfZsQfNUiJwmoCGpzLNl
	 nPtrA/9ieJjSSqaNgcpU+sWiur44HJDNmKMuyD0AeVqcv6sgTqpvGDKmjxrVOF7eo
	 hevGbJxrjScVMO5vX6B7+2ej6/rTITfxweZcpjcj1lqw9P1Y6qE9s1V4vBZQfkHTb
	 Th7GGgo/jcCI5xRoqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxlzC-1rvGOC46KE-00xM5F; Fri, 23
 Aug 2024 04:13:47 +0200
Message-ID: <7a04ac3b-e655-4a80-89dc-19962db50f05@gmx.com>
Date: Fri, 23 Aug 2024 11:43:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] btrfs: convert get_next_extent_buffer() to take a
 folio
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Content-Language: en-US
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
In-Reply-To: <38247c40-604b-443a-a600-0876b596a284@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dvs7VzrjjFpp1r9ZI7YTkeiaqLMrnufdKl4GmRyuV81uEUpg2wR
 UYH3V8I+oLGRz56PAYi+AD9lW4h56rk+tD0Yy60vL21bhYsL1rjV8V8Y6NQq0j9r9urCIve
 9a8CHXR6v7LdOL5Vpj0HAiybaX758eCxxWPASKXkXhsEiOr+W9ZxLZX5zGFdME7joJVzJ3D
 AYlVW6mAsaIYCwdFuksnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KWAnWs1w4AI=;FIDgK7OOtFR8xkoc9zyy0TDH69H
 0T2FOALWLke2bZxHZv0umErh1y+/bO4LMARgoUciODzxIbNgO6cWEFU8uNo9t1Sx92Qx4hDUo
 uRg938njahko1ByVwhM0HdY14nerzenEXTHR5sw4EraAKj4HWyiXb1fP7Zw2z6LxdgudsQj4a
 3pKbkwvUh5ajI2D7o5wKpIiG71qPGQ4SZZAHz0wZpevQklMHjCy17+QGFQdgEyjcogqG2e8hV
 gxSmVeKuc/TbOdsEPD4BKqhgZOTbQAWfmKOPohX4+XEnpHTaJlmkrzQq2Thqh9meJIl7XrWbZ
 g1cUzbotELMLOy4UizNOXcVDFPto7B6rjPXLP8/kDU6l+wacVlMlDFQ5FrYcwlJkA99uaA/3S
 sjd8z/wjgVk5UgwP0vIuFgq6cQSAlyxfibhVTlnNMl/IE2Nf7/LgYLLlM6NDx+hRze9ajrUZu
 BIa0fzYxtKaE8Uftz2y/KKlIV85G5QPM5tY8k8S2n9IwptANw/DFmXPPAwdJ95JsvMGcYESt2
 bLjwr8dbNU0dSKuQAK1n5XmC42XCmHpQYQD0i42BrjwA2iqwgza18H7eiK7kRqDdZipS4F2E+
 2dcZjXu5WezfkMh57r8acvHSKJJKUOu4Ij+vUKlzQFp1oPdBUrF/m16NdYKeAiKNo2wxgl8Gd
 iYn2ElZjV0kxiuHt7okG3S0c8j9QjYFs7BzZVc9F+LnJyDtj9I0er/vrU6+HyRbhnZpP74ZzR
 0sq0EyVRnKc+az4jheYViSuNDJ6A1RtQ2z1SJBexvo9GyVkDOOMnq145LAmmkVcBf5ihthF8V
 +HyR2o5W9Jdmwuz+oKDdQ3UQ==



=E5=9C=A8 2024/8/23 07:55, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/8/22 21:37, Matthew Wilcox =E5=86=99=E9=81=93:
>> On Thu, Aug 22, 2024 at 08:28:09PM +0930, Qu Wenruo wrote:
>>> =E5=9C=A8 2024/8/22 12:35, Matthew Wilcox =E5=86=99=E9=81=93:
>>>>> -=C2=A0=C2=A0=C2=A0 while (cur < page_start + PAGE_SIZE) {
>>>>> +=C2=A0=C2=A0=C2=A0 while (cur < folio_start + PAGE_SIZE) {
>>>>
>>>> Presumably we want to support large folios in btrfs at some point?
>>>
>>> Yes, and we're already working towards that direction.
>>>
>>>> I certainly want to remove CONFIG_READ_ONLY_THP_FOR_FS soon and that'=
ll
>>>> be a bit of a regression for btrfs if it doesn't have large folio
>>>> support.=C2=A0 So shouldn't we also s/PAGE_SIZE/folio_size(folio)/ ?
>>>
>>> AFAIK we're only going to support larger folios to support larger than
>>> PAGE_SIZE sector size so far.
>>
>> Why do you not want the performance gains from using larger folios?
>>
>>> So every folio is still in a fixed size (sector size, >=3D PAGE_SIZE).
>>>
>>> Not familiar with transparent huge page, I thought transparent huge pa=
ge
>>> is transparent to fs.
>>>
>>> Or do we need some special handling?
>>> My uneducated guess is, we will get a larger folio passed to readpage
>>> call back directly?
>>
>> Why do you choose to remain uneducated?=C2=A0 It's not like I've been k=
eeping
>> all of this to myself for the past five years.=C2=A0 I've given dozens =
of
>> presentations on it, including plenary sessions at LSFMM.=C2=A0 As a
>> filesystem
>> developer, you must want to not know about it at this point.
>>
>>> It's straightforward enough to read all contents for a larger folio,
>>> it's no different to subpage handling.
>>>
>>> But what will happen if some writes happened to that larger folio?
>>> Do MM layer detects that and split the folios? Or the fs has to go the
>>> subpage routine (with an extra structure recording all the subpage fla=
gs
>>> bitmap)?
>>
>> Entirely up to the filesystem.=C2=A0 It would help if btrfs used the sa=
me
>> terminology as the rest of the filesystems instead of inventing its own
>> "subpage" thing.=C2=A0 As far as I can tell, "subpage" means "fs block =
size",
>> but maybe it has a different meaning that I haven't ascertained.
>
> Then tell me the correct terminology to describe fs block size smaller
> than page size in the first place.
>
> "fs block size" is not good enough, we want a terminology to describe
> "fs block size" smaller than page size.
>
>>
>> Tracking dirtiness on a per-folio basis does not seem to be good enough=
.
>> Various people have workloads that regress in performance if you do
>> that.=C2=A0 So having some data structure attached to folio->private wh=
ich
>> tracks dirtiness on a per-fs-block basis works pretty well.=C2=A0 iomap=
 also
>> tracks the uptodate bit on a per-fs-block basis, but I'm less convinced
>> that's necessary.
>>
>> I have no idea why btrfs thinks it needs to track writeback, ordered,
>> checked and locked in a bitmap.=C2=A0 Those make no sense to me.=C2=A0 =
But they
>> make no sense to me if you're support a 4KiB filesystem on a machine
>> with a 64KiB PAGE_SIZE, not just in the context of "larger folios".
>> Writeback is something the VM tells you to do; why do you need to tag
>> individual blocks for writeback?
>
> Because there are cases where btrfs needs to only write back part of the
> folio independently.
>
> And especially for mixing compression and non-compression writes inside
> a page, e.g:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 16K=C2=A0=C2=
=A0=C2=A0=C2=A0 32K=C2=A0=C2=A0=C2=A0=C2=A0 48K=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 64K
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |//|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |///////|
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4K
>
> In above case, if we need to writeback above page with 4K sector size,
> then the first 4K is not suitable for compression (result will still
> take a full 4K block), while the range [32K, 48K) will be compressed.
>
> In that case, [0, 4K) range will be submitted directly for IO.
> Meanwhile [32K, 48) will be submitted for compression in antoher wq.
> (Or time consuming compression will delay the writeback of the remaining
> pages)
>
> This means the dirty/writeback flags will have a different timing to be
> changed.

Just in case if you mean using an atomic to trace the writeback/lock
progress, then it's possible to go that path, but for now it's not space
efficient.

For 16 blocks per page case (4K sectorsize 64K page size), each atomic
takes 4 bytes while a bitmap only takes 2 bytes.

And for 4K sectorsize 16K page size case, it's worse and btrfs compact
all the bitmaps into a larger one to save more space, while each atomic
still takes 4 bytes.

Thanks,
Qu

>
> I think compression is no long a btrfs exclusive feature, thus this
> should be obvious?
>
> Thanks,
> Qu
>

