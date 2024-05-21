Return-Path: <linux-btrfs+bounces-5181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE48CB5E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 00:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5044A282DAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 22:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A500149DE5;
	Tue, 21 May 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kHSrn6/m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE71865A
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716329820; cv=none; b=r6AI/IoL0SW5uptREUvVt3KGjufhoEBbiC+ommYgjkWdevxISo1J3DhUuT/GKZvCQvYMSSZROU8NvtmA3T6nAw1VZtUouY8DtPO+J9zdqT24P85I+d3iYDPZM3hzNu/ukLaRNFyYOwB4cxFIfQ7SGHpQtgKXbIUGWu+acW8Ykno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716329820; c=relaxed/simple;
	bh=HJvQW79g9fDpodE9D/cPypz3aHJEALosbGYmgiuGZl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ird9qk4ntRxuNGo6KwVU9mnWSUMRbgw6xnIcehAFCxDqLVv4GWi3B0rPham2R6zaS7cw7wHZyfZaAhDC9fz2O53lJxZ8qKx0sjfC2FZBCL0GmrJKzUaKXiioLQ85Kb2rRHzqj5gwF6re2Mmp06EvDBzr7Q4MD+RyVcjCftV/6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kHSrn6/m; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716329812; x=1716934612; i=quwenruo.btrfs@gmx.com;
	bh=x3Nr+FtTF9aV6ykpd48yVExP3CsuNItQ0tBZMIJxUpE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kHSrn6/mTN5RynNGXWOmpBHDkyqnaX8a6VVu/97R6bn563PHoiMN0yiOJWS7eh7q
	 03VLZT7DR6KUawXZ2hb+c6FVC4xJztcUk5Mc6/okdaprRVCD4kKfz9/S5qESpCxHA
	 odiRgahX+vhGAziO/5jAhZ038cAiHXHv5+uiFuf+tLhJ+fP7ObJAxU3bB25V2SKOm
	 igGED9xD2y8DEXzp35F9aADqydVocS3PWN7TkOT0tax0Xs83QQoo8XOC/5Taa4qff
	 579UxXeKUHfgUaPOKgjhMaUAniWq5GkwWKx94EPteZGrULVfIHCkCoQJ7e9tdJRi1
	 Bg8UymiBKgoaHtGveQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17YY-1sYWjZ3o54-012Yt6; Wed, 22
 May 2024 00:16:52 +0200
Message-ID: <2b26245e-7602-4a00-b79a-eac481708ab3@gmx.com>
Date: Wed, 22 May 2024 07:46:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <cover.1716008374.git.wqu@suse.com>
 <b067a8a2c97f58f569991987ad8c3e9a2018cf06.1716008374.git.wqu@suse.com>
 <7oxv5xm6n4yg5r523pzm7hxql5pihrfylrducrsiwlk5k4jl7a@wxvlrl6w6cbu>
 <30371f39-18b1-4c3f-af31-b4927eab99a5@suse.com>
 <tdxf76yhloruo4pubudlhr2p4xf4spvmhrfsf56jfzxh544id3@fcaaplcp6vwp>
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
In-Reply-To: <tdxf76yhloruo4pubudlhr2p4xf4spvmhrfsf56jfzxh544id3@fcaaplcp6vwp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0azIaVDyMdFlrBPa84fHiHF3LRioIjprfrDFpeif4/9Md6WPPns
 WmbRkWI0y0lD8uwd6EGyNFBH4kb5iCatDTStV4UNjaMUqw796aOqsO369cXG34s78D67Y+H
 DohvtbwdxprR2GFGYW8KOT2yrvnSGDHEEVXMsEo14fzY+3+q9rPeankmEOIvhVAq8rn6k6L
 akjQU0EGpfYTutZhcRGqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ejY7m/958kI=;Xd/BWD3nLQSol15xDw5Ii+/7wCV
 gMU1UeI95FuOT5L/K7xVcbTp3HRIXRix1i9/k/GeSH7+cAdm5ObiMlwJEvUnqUPb9AOwYFa9u
 y1N1fLbFUvltfzf1B7jZW1fYQ4Q3Sz7AlBzJfgLy3SEWwDGq5GnyVE9Ih+KJgcRL8ydWcqkeo
 cXTKtcGpQ2D2ViVp2+iVlV6id5aNcU+BZFHnS6IQCh9oslxUp9gQG5guyW/qseicc9SPr2Q1H
 x/KKy6FHbQ57I+7ET/2/l7YHcEwclqeF5ZRToUcrX+O4B089llX6OSK3aKl8B/0CDbvXkWmdV
 o7QyZ21FbyNFp5juaE2SSQus3fhuGG3Aq5VUq15ylmcqNfpMmuGT79q3qbnN64UDm9MG5HMdH
 byCduoH7UbThHBY3DRXEfbQcDqoJdjrp0UaFyPbKonPqkUSwLqM3a2FJk/JFIDWtCi8Q3rbmU
 9z1XLY+6WhaTCrVAF8rE/ah2XblKAfZ7m2t934id20D+8kpFm9Tf81AQ5PilWvbXd3fyVoXGv
 /LaNdUS+lRi9ZazYkEEMPIELD1ac30lGcV3Vj4Sur4XNTQrt6EaAtzmXWxp6ZM8S6BXYqwMop
 hyVzjBWlWghhQf8JvVIWmtbHYR2zap0pUmrxb/SVzLiEL2GUobgoR2wakShTxomOV8mr40D9c
 Fzf8ptEceSuClVTQqwHOZJvtuKq7SIyc5AtgM7hsGzWqOCzl4ZxDClFZkoOxB36YK3WiRAKdz
 CdoX1QizEoU7Rrh5AzJspGR3FG4YehBfCtUn8ippJOOI2GoWOYWW6F5KqWAGxI9XOpJcyTQTG
 A6GyzSiHuYceHyGojryj2Knz2UoX92C9Kqc82NEeo0Dh0=



=E5=9C=A8 2024/5/21 21:24, Naohiro Aota =E5=86=99=E9=81=93:
> On Tue, May 21, 2024 at 06:15:32PM GMT, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/5/21 17:41, Naohiro Aota =E5=86=99=E9=81=93:
>> [...]
>>> Same here.
>>>
>>>>    	while (delalloc_start < page_end) {
>>>>    		delalloc_end =3D page_end;
>>>>    		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
>>>> @@ -1240,15 +1249,68 @@ static noinline_for_stack int writepage_delal=
loc(struct btrfs_inode *inode,
>>>>    			delalloc_start =3D delalloc_end + 1;
>>>>    			continue;
>>>>    		}
>>>> -
>>>> -		ret =3D btrfs_run_delalloc_range(inode, page, delalloc_start,
>>>> -					       delalloc_end, wbc);
>>>> -		if (ret < 0)
>>>> -			return ret;
>>>> -
>>>> +		btrfs_folio_set_writer_lock(fs_info, folio, delalloc_start,
>>>> +					    min(delalloc_end, page_end) + 1 -
>>>> +					    delalloc_start);
>>>> +		last_delalloc_end =3D delalloc_end;
>>>>    		delalloc_start =3D delalloc_end + 1;
>>>>    	}
>>>
>>> Can we bail out on the "if (!last_delalloc_end)" case? It would make t=
he
>>> following code simpler.
>>
>> Mind to explain it a little more?
>>
>> Did you mean something like this:
>>
>> 	while (delalloc_start < page_end) {
>> 		/* lock all subpage delalloc range code */
>> 	}
>> 	if (!last_delalloc_end)
>> 		goto finish;
>> 	while (delalloc_start < page_end) {
>> 		/* run the delalloc ranges code* /
>> 	}
>>
>> If so, I can definitely go that way.
>
> Yes, I meant that way. Apparently, "!last_delalloc_end" means it get no
> delalloc region. So, we can just return 0 in that case without touching
> "wbc->nr_to_write" as the current code does.
>
> BTW, is this actually an overlooked error case? Is it OK to progress in
> __extent_writepage() even if we don't run run_delalloc_range() ?

That's totally expected, and it would even be more common in fact.

Consider a very ordinary case like this:

    0             4K              8K            12K
    |/////////////|///////////////|/////////////|

When running extent_writepage() for page 0, we run delalloc range for
the whole [0, 12K) range, and created an OE for it.
Then __extent_writepage_io() add page range [0, 4k) for bio.

Then extent_writepage() for page 4K, find_lock_delalloc() would not find
any range, as previous iteration at page 0 has already created OE for
the whole [0, 12K) range.

Although we would still run __extent_writepage_io() to add page range
[4k, 8K) to the bio.

The same for page 8K.

Thanks,
Qu

