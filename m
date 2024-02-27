Return-Path: <linux-btrfs+bounces-2846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1CA86A1F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 22:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19B4B2728F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 21:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45614F976;
	Tue, 27 Feb 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G6jbzie/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C714EFD4
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070752; cv=none; b=LtgHZmXKcfmhvcESh1+chXbsGrE+Ky45nzlrcGi6EpAKtz/eFYjVr8BgPH9ZN5SA2nLOC0evtvRmmlu+3ZfBPdZN3EiGrsDyiWljhptnN9Ad6wDVdJnuJsM9QkHAXGUMBTJ8EO2/qMnJVAAjMFWC1BA9dJLnn5F773sjmu7Uztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070752; c=relaxed/simple;
	bh=6sqA681S/QOLFK4Ds8f1d2CCAJFKzObafW6HXM1aBAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuBRdkJH2H9E98o1nABfbOxkPja5xCPErN/i71uVutR3EZgcfzw4DtaynteLyDvNYVhCqLVnDzVZ+W537StRYGgx0JGkgQuOXUXOdS1RiFPm2Z0NbYWA77D1QycFTQuneiat8jH0F+gmOeag1w9nm0dr1pcsbCzzI7DV/K4D078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G6jbzie/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709070736; x=1709675536; i=quwenruo.btrfs@gmx.com;
	bh=6sqA681S/QOLFK4Ds8f1d2CCAJFKzObafW6HXM1aBAY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=G6jbzie/TXU5BMEP5N+xT0DdbzMYsnCVvSnW7uHce0Yh1sjSvU0jFBpuIZ1SvFyn
	 rZxRByI2Kv0tZqZT/IQOfeZdE64TAI6SHwmBBgP4y8NWZl4u90eVBDd+HfARpdng5
	 E3iF1IO93KunM8OESxDUhFgMfIkaTtJOwMJioSYlSVGm3eNEmFEeroZ0KtUOCb1zB
	 HhszzdGAXH2rdiCVEf231rD3/gGUUZsVaY2mBujEfleHDcR099o6H9VuL438aV3jL
	 s/VBkTRVKHAVeHRNrJd57d1fEFMSPRphAjfuR3xnXl1QVW2esNQXzZSNzM+BQjDtS
	 iBy+jILMsWxkrsd4gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1rN90t1Frv-00IX2j; Tue, 27
 Feb 2024 22:52:16 +0100
Message-ID: <ef6d6e5c-7f9d-4841-af2c-91dfcd9819e4@gmx.com>
Date: Wed, 28 Feb 2024 08:22:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Convert add_ra_bio_pages() to use a folio
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20240126065631.3055974-1-willy@infradead.org>
 <Zd5ViSKqkVl-g2wG@casper.infradead.org>
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
In-Reply-To: <Zd5ViSKqkVl-g2wG@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nhm/qvkZTHbKqnuL0Oy0g1P1R07/WbphS2di/moLZ+0IcvE/RI/
 K1rwfzul/PuQ4rhobcBmm7/p0R4lZwdUNkjV7MAe7+tnBqavZX4OOG7cCH2xZCofVmaIQDp
 gDG/ONUB0G+gjJkdL7J5KODrpeQPAEIsz0/73NDSu9zWJdzH2Rq+2cITC+lxac8sBLYlg09
 0uIk0n9hZzGSYqhgd2kjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wiTfFo8qf+M=;Vyar+bB7GclcJdBQTH14upO3Ock
 aVJgfoYFfuBN2H14lG0QDkGeiaLlR2npi22p0o7jVkkUag34gn13B2faI10i6TsQuhfRHHDSs
 vxOpejXfAt5kYSE8ZkhUT3vfVMiTEu32GGbqsdu5bs1GZ622rGYQmx9PCSPKrJRLnHW11oB8l
 2xn46cia90G6f+fK66CHk/lX1HV4aFmaPCs++HIRXzadY/TKdzf6dssQ/FMq4HsaVPJZ9xNrY
 oOXK6aw2sM+DGxo4LFGiM+zba4A7hG+s30fwEaPX2ys5KUNoAW6E3G9xwReFYmyrm+qmuFmDk
 c3m92fyc/2YJo1o+/j+FTnlyOyKi2m8qzGYI4Vi+Djk6x6IMRCy0O4ghrf40/w84+xWewqEyb
 Lj5z7L/y+KUpU/K1hPfNX8Q5G1eD3A5AtIL4O/6QFagu3X6Ts8AgESNdCy6e/rZt8oODX2jt9
 FLmB3/g6PsXW3G6FtFCCkDPtESAZjYAA0YDldmVXLjTHO3RSC2LZ97enZBoVVNYaba5xwzWQ4
 7kWk1A+02IjGxFPaymYICaMH0izmuIOYnjt8YXGgG3/ltprpczTPCXmw7szD/4jtFWt3FL/vf
 z+R7o5ndcgHUgR3o0GWagvi5DW5g5OcO82lAL16dOgolFZY7LoocHaogEJ1C1sAr3pAlN23Pd
 vSvM3y5zwyG1wCD+JyIhqyB0tJeFc49RHxzxbzn6OVhpkugmdKTvXv47xliEG3AD+OWeKbuyN
 jAAXVtKOZPAyE81jcuCvIMCCY/G89umWRI6m4oE+iigCpZ38mue5VlSKbSTOQfKeNZVpJULUA
 abYV7RGxaW0X9nz+po4Z8k9QAnuCiJRYTAa9nyvdd/H1w=



=E5=9C=A8 2024/2/28 08:05, Matthew Wilcox =E5=86=99=E9=81=93:
> On Fri, Jan 26, 2024 at 06:56:29AM +0000, Matthew Wilcox (Oracle) wrote:
>> Allocate order-0 folios instead of pages.  Saves twelve hidden calls
>> to compound_head().
>
> Ping?  This is one of the few remaining callers of
> add_to_page_cache_lru() and I'd like to get rid of it soon.

Not an expert thus I can only do some basic reviews here.

>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>   fs/btrfs/compression.c | 58 ++++++++++++++++++++---------------------=
-
>>   1 file changed, 28 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 68345f73d429..517f9bc58749 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -421,7 +421,6 @@ static noinline int add_ra_bio_pages(struct inode *=
inode,
>>   	u64 cur =3D cb->orig_bbio->file_offset + orig_bio->bi_iter.bi_size;
>>   	u64 isize =3D i_size_read(inode);
>>   	int ret;
>> -	struct page *page;
>>   	struct extent_map *em;
>>   	struct address_space *mapping =3D inode->i_mapping;
>>   	struct extent_map_tree *em_tree;
>> @@ -447,6 +446,7 @@ static noinline int add_ra_bio_pages(struct inode *=
inode,
>>   	end_index =3D (i_size_read(inode) - 1) >> PAGE_SHIFT;
>>
>>   	while (cur < compressed_end) {
>> +		struct folio *folio;
>>   		u64 page_end;
>>   		u64 pg_index =3D cur >> PAGE_SHIFT;
>>   		u32 add_size;
>> @@ -454,8 +454,12 @@ static noinline int add_ra_bio_pages(struct inode =
*inode,
>>   		if (pg_index > end_index)
>>   			break;
>>
>> -		page =3D xa_load(&mapping->i_pages, pg_index);
>> -		if (page && !xa_is_value(page)) {
>> +		folio =3D xa_load(&mapping->i_pages, pg_index);

Not familiar with the xa_load usage, does this mean for order-0 pages,
folio and page pointers are interchangeable?

And what if we go higher order folios in the futuer? Would that still be
interchangeable?

[...]
>>   		}
>>   		free_extent_map(em);
>>
>> -		if (page->index =3D=3D end_index) {
>> -			size_t zero_offset =3D offset_in_page(isize);
>> -
>> -			if (zero_offset) {
>> -				int zeros;
>> -				zeros =3D PAGE_SIZE - zero_offset;
>> -				memzero_page(page, zero_offset, zeros);
>> -			}
>> -		}
>> +		if (folio->index =3D=3D end_index)
>> +			folio_zero_segment(folio, offset_in_page(isize),
>> +					folio_size(folio));

This doesn't sound correct to me. If @isize is page aligned, e.g. 4K,
and we're the first folio of the page cache, this would zero the first
folio, meanwhile the old code would do nothing.

Thanks,
Qu

>>
>>   		add_size =3D min(em->start + em->len, page_end + 1) - cur;
>> -		ret =3D bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
>> +		ret =3D bio_add_folio(orig_bio, folio, add_size, offset_in_page(cur)=
);
>>   		if (ret !=3D add_size) {
>>   			unlock_extent(tree, cur, page_end, NULL);
>> -			unlock_page(page);
>> -			put_page(page);
>> +			folio_unlock(folio);
>> +			folio_put(folio);
>>   			break;
>>   		}
>>   		/*
>> @@ -541,9 +539,9 @@ static noinline int add_ra_bio_pages(struct inode *=
inode,
>>   		 * subpage::readers and to unlock the page.
>>   		 */
>>   		if (fs_info->sectorsize < PAGE_SIZE)
>> -			btrfs_subpage_start_reader(fs_info, page_folio(page),
>> +			btrfs_subpage_start_reader(fs_info, folio,
>>   						   cur, add_size);
>> -		put_page(page);
>> +		folio_put(folio);
>>   		cur +=3D add_size;
>>   	}
>>   	return 0;
>> --
>> 2.43.0
>>

