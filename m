Return-Path: <linux-btrfs+bounces-3741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DAE890B58
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 21:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DEC295F7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 20:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E421386A3;
	Thu, 28 Mar 2024 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XfqBj+bx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B91F93E
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657808; cv=none; b=HCh9xx4lu2ekgiz1DuxHXGlZMR7YTPrImxDWH7EOTmDODrfONtre9bJmPCt1fHb7AUHJPhwauQvFIvH0iXd3aIRc90tNXqi1H1onoMU8iTovhBIvmiGNI+xDDW0pLSKoKWAYYp5e+O7LhTh75T9JZLf4S9p7n954AzUWoCOxJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657808; c=relaxed/simple;
	bh=yryWXLXXvgMWSVLf2mzeRg2zsYZvYIzTHN6VuOC3URk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuJ/hd0GJD0DT+HWesefluW4Q+FOrySAeLWZwJ+VK77BogfQxPCsdknjQ5p2ie8fiWv46aOKzc4x0SNka0jzxA/xFoioTMCDBaVNQa1wKBS2AtcCTC8Fjykgz94lr7HYhFrMudtsQDtFjm84GJCAnIGDF6bmUC/nny05yAT7eH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XfqBj+bx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711657801; x=1712262601; i=quwenruo.btrfs@gmx.com;
	bh=H5Es6DgqAR89T1TNqpIpFaOGykjQXAmLmjApd6JmMbo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=XfqBj+bxk7hXpJymBCMxooC7htuT3iLYZjkZEwuUz2EbgOIkhKK6ADl7DPqibIWI
	 S0Lyp2pnnw9KFNNdW594O4hMsa95PEK2rnSqJX6mc/d+cUcexQbY5fEbqxKBkIhrC
	 ULC7V8xIZ841HE0wf0UjBp5JbzZT9GUuo4mE7/Yhr4dtED1PjpuCFyr99n69Vb/Mb
	 PZRRMd/CYGwuoxepuzIofh/OOQG2oLlpp5tLKXsaDci2lwROd0fONQgxT0fxhzu6J
	 NSkEPRCU3uBecZbTYDINSeuWpKBaKlX3rb5amafU0X5OVJfYckqvAkDaLQesfDNfz
	 DBaMp5jdW3thRO93GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O2Q-1rrbLL07CA-003xys; Thu, 28
 Mar 2024 21:30:01 +0100
Message-ID: <ec65443a-b7ba-4c60-9cbd-23ffd45c8994@gmx.com>
Date: Fri, 29 Mar 2024 06:59:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not wait for short bulk allocation
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Julian Taylor <julian.taylor@1und1.de>,
 Filipe Manana <fdmanana@suse.com>
References: <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
 <20240328155746.GY14596@twin.jikos.cz>
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
In-Reply-To: <20240328155746.GY14596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iPCzudhhOikc7L75PPXz0xLua2onBptyV+gURt9Z7HVNekI2vuw
 6l8enutpU7BDBhZaLlTqBVAF/fUfY83vOVzBSOyf99LaG9RAQ/kUBSIl4feS/EKkdMtMcLI
 ByurLDr4Z3SwJmSMyO7nm7ApGpGtHJl0L4K6D+LUnmRrybiBjWPM0jLQ+jBJGHe3APOlKcK
 7JWkQ826rzB3hIc5n9xxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qd+OV1rpD1Q=;mJiJH0acB9DhD1k/8REs3aoeyQC
 lPCycLiqu0520U70xCAiufEro3DjNfnqxYAi1k47uFGX9xaxW/JBqdMLDs8fpDOPhcWvrh/7I
 twYPrHtGyOiVgTASMr+P1IZWcbzz05uD7nMtNk3NybXWPO6qlLR3y6YRv+tRubEPk7NAG5Q6P
 8a305ix9MxlDMAnSBzBC4IPEJiYrmpNWuJhGWEm3uzFngfYU4Utz07nFG/sZ8coMnqangOBpj
 eoVn5Ojrs0tvvpIopKO1w/vjfnu2AYsOrThbkC+E3AuBbNJRKfLBtJU1BscjZhGcyp1xoUFfj
 GkCk4rut9HijKEF2aBhsEglyUM612dcPpKQyj9ZYrb9bWSY+wxj458v0TGOfu2F2bqwkv6/6Y
 /97Wpt2Y9rgAcS6nULkJtEm4fpjZ6FhdTas+Ja1uQl9uZTrODUo/FeYiAJDe4M6nLisAD4l5Y
 /+KHDzHPA882yz/S8FuZa+hFoLBaJBi/DFb7Oj2UCvfzeM+MudwuYATC6zxAGvSSbPQaqJXN6
 F7Sr8c9yyLTQKegHJo1evtnNNETEWLMB6Mlu/pZnXigcfpNzyhACOErHiDhkOA19+3VrH6tQW
 fTApxR/IUMYDgn5U7VG5ejOEFFR9iGsrNRiZmXfnKVK0egeIbsUHvl9RPmOXCcJRtvJo69F/5
 2e/I1O5dIeKJWh0qpbIQ9dI+opY1QBx7oVBgtR1Qszs4I7KrI2MlUfJA3/7rDPteYwH9596cZ
 T28uXOVsS+wBijmUXJsQdmNmB9Rp8npFmqQ/c7XbBrrxFR82nKXjpdStEF+R3DCIFl3AHPHeg
 50UXjZwzSeUtB5q64ajwnVLAwb06n5dv51RzdHwKkJup0=



=E5=9C=A8 2024/3/29 02:27, David Sterba =E5=86=99=E9=81=93:
> On Tue, Mar 26, 2024 at 09:16:46AM +1030, Qu Wenruo wrote:
>> [BUG]
>> There is a recent report that when memory pressure is high (including
>> cached pages), btrfs can spend most of its time on memory allocation in
>> btrfs_alloc_page_array() for compressed read/write.
>>
>> [CAUSE]
>> For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
>> even if the bulk allocation failed (fell back to single page
>> allocation) we still retry but with extra memalloc_retry_wait().
>>
>> If the bulk alloc only returned one page a time, we would spend a lot o=
f
>> time on the retry wait.
>>
>> The behavior was introduced in commit 395cb57e8560 ("btrfs: wait betwee=
n
>> incomplete batch memory allocations").
>>
>> [FIX]
>> Although the commit mentioned that other filesystems do the wait, it's
>> not the case at least nowadays.
>>
>> All the mainlined filesystems only call memalloc_retry_wait() if they
>> failed to allocate any page (not only for bulk allocation).
>> If there is any progress, they won't call memalloc_retry_wait() at all.
>>
>> For example, xfs_buf_alloc_pages() would only call memalloc_retry_wait(=
)
>> if there is no allocation progress at all, and the call is not for
>> metadata readahead.
>>
>> So I don't believe we should call memalloc_retry_wait() unconditionally
>> for short allocation.
>>
>> This patch would only call memalloc_retry_wait() if failed to allocate
>> any page for tree block allocation (which goes with __GFP_NOFAIL and ma=
y
>> not need the special handling anyway), and reduce the latency for
>> btrfs_alloc_page_array().
>
> Is this saying that it can fail with GFP_NOFAIL?

I'd say no, but never say no to memory allocation failure.

>
>> Reported-by: Julian Taylor <julian.taylor@1und1.de>
>> Tested-by: Julian Taylor <julian.taylor@1und1.de>
>> Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@=
1und1.de/
>> Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory alloc=
ations")
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Still use bulk allocation function
>>    Since alloc_pages_bulk_array() would fall back to single page
>>    allocation by itself, there is no need to go alloc_page() manually.
>>
>> - Update the commit message to indicate other fses do not call
>>    memalloc_retry_wait() unconditionally
>>    In fact, they only call it when they need to retry hard and can not
>>    really fail.
>> ---
>>   fs/btrfs/extent_io.c | 22 +++++++++-------------
>>   1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 7441245b1ceb..c96089b6f388 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -681,31 +681,27 @@ static void end_bbio_data_read(struct btrfs_bio *=
bbio)
>>   int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_=
array,
>>   			   gfp_t extra_gfp)
>>   {
>> +	const gfp_t gfp =3D GFP_NOFS | extra_gfp;
>>   	unsigned int allocated;
>>
>>   	for (allocated =3D 0; allocated < nr_pages;) {
>>   		unsigned int last =3D allocated;
>>
>> -		allocated =3D alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
>> -						   nr_pages, page_array);
>> +		allocated =3D alloc_pages_bulk_array(gfp, nr_pages, page_array);
>> +		if (unlikely(allocated =3D=3D last)) {
>> +			/* Can not fail, wait and retry. */
>> +			if (extra_gfp & __GFP_NOFAIL) {
>> +				memalloc_retry_wait(GFP_NOFS);
>
> Can this happen? alloc_pages_bulk_array() should not fail when
> GFP_NOFAIL is passed, there are two allocation phases in
> __alloc_pages_bulk() and if it falls back to __alloc_pages() + NOFAIL it
> will not fail ... so what's the point of the retry?

Yeah, that's also one of my concern.

Unlike other fses, btrfs utilizes NOFAIL for metadata memory allocation,
meanwhile others do not.
E.g. XFS always do the retry wait even the allocation does not got a
page allocated. (aka, another kind of NOFAIL).

If needed, I can drop the retry part completely.

>
> Anyway the whole thing with NOFAIL flag that's passed only from
> alloc_extent_buffer() could be made a bit more straightforward. The gfp
> flags replaced by a bool with 'nofail' semantics or 2 helpers one that
> is for normal use an the one for the special purpose.
>

Sure I can do extra cleanups on this.

Thanks,
Qu

