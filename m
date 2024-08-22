Return-Path: <linux-btrfs+bounces-7417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A4095C0D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 00:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEA61F246C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C61D1728;
	Thu, 22 Aug 2024 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jbpB3nI8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC3EC5
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724365570; cv=none; b=bDEBIcbX/Bfwpu4W6DnOGuOJRglnArEGvInU7iRIdplrfg0+KCKLToLOjY6GYrFc0p2+SlSzqTCBHJgU6hOqUXzQ4Sp+1ItQzy3pz4o2usj4V9/LvJbK5bIx2+iUJx1TLua/QkciRLdQ+K0SyaALZFB3jIg/Njmb+ypS29Ccbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724365570; c=relaxed/simple;
	bh=dG7W6uX1/qy2GRzwKis7eF8mUursOzNqqbLaQQGtI6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzJa0oj6vytNPzRESO7LwBZ605KevjgYyZ8RgWWI4jEGpZINzLv2/4DDnpv+5en1ticcJxc1Wi0tmBwkRxeVU4lt7I/REO1NxJ3Qmg+NL+XIapi5zSkRUaw8BhOOgxIKayhb2vXha4mkTl37An4GB8/QG8jhjbPeqts69K82eVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jbpB3nI8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724365537; x=1724970337; i=quwenruo.btrfs@gmx.com;
	bh=/MU6KgJvG7ddTcuqUsaRiwPMSXbM1laEUvP/S1Qg768=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jbpB3nI8aO4MCB+/MbRbjrOq15x+PDwAVNxy0RAobL01s3jrv5KCmZ7se+movdkk
	 aEgv9pqjmNDumHkqbMS02qfqAbBgDwmZ0fSZ2WQyBdFznPglU3vvDuFaQiZnGm1A4
	 YLm1eNJBKrtrkAEaz4m5LEepZA0L/UGL5b2L7N8OlVfOsYnWtclRxSSCRI9W3Qxo5
	 NYEp/K2NuKe5Ui0DWFaSeu2q/lP5Hl/nHxyPqnmmmf6O4eBeKq79RftiUjcX5fvUU
	 jUV/raHMsUo4ERzlxkZfOEbMz1Ew8V14Pa5Bj8T8eAIFdLi72X33Xz2tB+RmV7bog
	 mKODg38/Tw63N4R5Zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDnC-1sqZNG3uMI-00E3hN; Fri, 23
 Aug 2024 00:25:37 +0200
Message-ID: <38247c40-604b-443a-a600-0876b596a284@gmx.com>
Date: Fri, 23 Aug 2024 07:55:30 +0930
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
In-Reply-To: <ZscqGAMm1tofHSSG@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/9WKVUdnzyydlFtroztkO05heOwmOHUlvPTrr8IrCIl1eCKv2v9
 X1s+UpR3DY0lx9npliKRqpC+9XhtByy5h5P1/bSp583EnMWj6BH96XYA18iK9KbT2rYXFor
 giqMlXHWV2+81zwILEI5fmoJCQzTDVKFDEqw0zQVLed2v/Y/d0sUgLCcZRNDn0SJGTFbqZh
 D+kYrci7xTbQu+ChiJ0vg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hEYuEQ3KozY=;igA7M5AM+n0gRO9BHKW5DF57umv
 WpK8uj0JVl1BTO8FsktwF6NPmtNY7bN1iYUNJoVY7iNmXZQR82crQ3qDaM7AXRXA6t08h1x48
 YryRQBthE+LKvusagS9hj7OQUIv2ZPI79lmrnCKD/wgMx8wMs2TBXwwbq8yZQGjexpBChc37v
 iGM6nS626P9nP2smco9x+GCNQNuTw3wXcShiOpYZQhAZzkJx0C7bIUSIHNBB5k5wlwmK0TWB2
 IuXSybihsq8gjzO51OuTNO1zbWy2XSjSPVS0ZBdVMcy8SJ3tvhyIRvLQgclLa34Zp7++10/dM
 Ts4VbGsOCsoByC2pYAT4NA0vdX4ydRh383GEtbjSVcF+1bXSuKeeWN+eyq9i26HpVnNO0VUUe
 BX98fjbF9hQmRdM0U33+3sfkmytUtatfQ88j8MrZJeVC5/R696i2c2ndlns+cqIl7RVllBybo
 zDkgdP6hp0J4afmLkRLLQLjK77kjgHz+IyRexrN2s/20FaewDoVQrSLNPEu1hPySXqU35qnX5
 D4b7dW2D3G3cCk/97uzTClwA3TrUfGTGM3iLBYrs9yxxfNKLirdArtlSjPF56es91wBVcH5ZR
 m4wSyK01dz44xcNc6KqysqIac8/1FQAMRCXktzNas3ksjUj8IsVsH0RmkCFy1KSHVhIy8DYGs
 eyLidVxgHDvzNXSlTi/S6xgrtd2EsRH8RRiU9RVdaYvWgjTpS1OTg5SY/hJfNmIYrXg7STi/5
 fRQMHWIUpbD5mnfDga5xaO3O2EosTjZdVfodx63DCi45R94E0rfU9zlinhg0wqezPSxZ+KOvS
 IWS+uBwC8K50L2klsQh5US9w==



=E5=9C=A8 2024/8/22 21:37, Matthew Wilcox =E5=86=99=E9=81=93:
> On Thu, Aug 22, 2024 at 08:28:09PM +0930, Qu Wenruo wrote:
>> =E5=9C=A8 2024/8/22 12:35, Matthew Wilcox =E5=86=99=E9=81=93:
>>>> -	while (cur < page_start + PAGE_SIZE) {
>>>> +	while (cur < folio_start + PAGE_SIZE) {
>>>
>>> Presumably we want to support large folios in btrfs at some point?
>>
>> Yes, and we're already working towards that direction.
>>
>>> I certainly want to remove CONFIG_READ_ONLY_THP_FOR_FS soon and that'l=
l
>>> be a bit of a regression for btrfs if it doesn't have large folio
>>> support.  So shouldn't we also s/PAGE_SIZE/folio_size(folio)/ ?
>>
>> AFAIK we're only going to support larger folios to support larger than
>> PAGE_SIZE sector size so far.
>
> Why do you not want the performance gains from using larger folios?
>
>> So every folio is still in a fixed size (sector size, >=3D PAGE_SIZE).
>>
>> Not familiar with transparent huge page, I thought transparent huge pag=
e
>> is transparent to fs.
>>
>> Or do we need some special handling?
>> My uneducated guess is, we will get a larger folio passed to readpage
>> call back directly?
>
> Why do you choose to remain uneducated?  It's not like I've been keeping
> all of this to myself for the past five years.  I've given dozens of
> presentations on it, including plenary sessions at LSFMM.  As a filesyst=
em
> developer, you must want to not know about it at this point.
>
>> It's straightforward enough to read all contents for a larger folio,
>> it's no different to subpage handling.
>>
>> But what will happen if some writes happened to that larger folio?
>> Do MM layer detects that and split the folios? Or the fs has to go the
>> subpage routine (with an extra structure recording all the subpage flag=
s
>> bitmap)?
>
> Entirely up to the filesystem.  It would help if btrfs used the same
> terminology as the rest of the filesystems instead of inventing its own
> "subpage" thing.  As far as I can tell, "subpage" means "fs block size",
> but maybe it has a different meaning that I haven't ascertained.

Then tell me the correct terminology to describe fs block size smaller
than page size in the first place.

"fs block size" is not good enough, we want a terminology to describe
"fs block size" smaller than page size.

>
> Tracking dirtiness on a per-folio basis does not seem to be good enough.
> Various people have workloads that regress in performance if you do
> that.  So having some data structure attached to folio->private which
> tracks dirtiness on a per-fs-block basis works pretty well.  iomap also
> tracks the uptodate bit on a per-fs-block basis, but I'm less convinced
> that's necessary.
>
> I have no idea why btrfs thinks it needs to track writeback, ordered,
> checked and locked in a bitmap.  Those make no sense to me.  But they
> make no sense to me if you're support a 4KiB filesystem on a machine
> with a 64KiB PAGE_SIZE, not just in the context of "larger folios".
> Writeback is something the VM tells you to do; why do you need to tag
> individual blocks for writeback?

Because there are cases where btrfs needs to only write back part of the
folio independently.

And especially for mixing compression and non-compression writes inside
a page, e.g:

       0     16K     32K     48K      64K
       |//|          |///////|
          4K

In above case, if we need to writeback above page with 4K sector size,
then the first 4K is not suitable for compression (result will still
take a full 4K block), while the range [32K, 48K) will be compressed.

In that case, [0, 4K) range will be submitted directly for IO.
Meanwhile [32K, 48) will be submitted for compression in antoher wq.
(Or time consuming compression will delay the writeback of the remaining
pages)

This means the dirty/writeback flags will have a different timing to be
changed.

I think compression is no long a btrfs exclusive feature, thus this
should be obvious?

Thanks,
Qu

