Return-Path: <linux-btrfs+bounces-8178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A502E983AA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 02:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7964DB21C14
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 00:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2DD4C92;
	Tue, 24 Sep 2024 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="q0VWf4u4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603F38C;
	Tue, 24 Sep 2024 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727138794; cv=none; b=mXiKJTpZCNTmaD5bm4W1U7SCLsL9pvYkUe0o77lF1gEPHvgGbavS3vFT92J5zcBg5JOL4HC+mW8/brTyXcUVIvm5odEtteTH1hGfbXMxCfmMJys8Ex6gREmp8gGw1dRGSHfglvkdqRFtDw54SrLDfFvP9Un0xab2f3OnJkc6Mro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727138794; c=relaxed/simple;
	bh=u5MQJ64TxRY7byNeC+CNZ82eYueW7qffSg0KV3+7mSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7fdWfU3i6zFnufIF0aL+j1Z0cDYDeh+aWaIpjWIhU4V3m82fP76uGheg74dqvPoWDUvsgf91a1siCHoZW0RPEDtG5RBZLWc+0aH7isfDFXVs6MqM1wni0oa5y1iW+My9kpKydPHcpC3DxE8TA8CepWiAAuQF4lXhlVKCTIa+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=q0VWf4u4; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727138778; x=1727743578; i=quwenruo.btrfs@gmx.com;
	bh=u5MQJ64TxRY7byNeC+CNZ82eYueW7qffSg0KV3+7mSU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q0VWf4u4YU/uCPXe5VXEzybKmJzW4XXN5z31BpMSLM1Nx4tJ8zkv0Vn3cNUTSinL
	 u8ZLYI9m+gAad7r1+0B3coleBP0TjqyQOqZ+/gqDckEonWPGBH5yWQ/T7dRY3oDa2
	 8TXf+LLdUAhcdFS/SNA/GehaLRwqp4skI7mshMHfMQ1rSU+7nAbzuCXqFVRpEm5rJ
	 BLHwxX9wGUTVxD5tg4e0SzC5jVSnUofhxK4HkSjwa5yos1MdyRhpYIWcvEW05A4xQ
	 Pipzd8YHTMQTnPEZj+BImlPdmtohi/rY5LhyoDFc6z0jT4BqoKjUK546BPl2hCLdq
	 HR1V+osNW8dgslQtkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6KUd-1rrcjQ28nB-00vNQl; Tue, 24
 Sep 2024 02:46:18 +0200
Message-ID: <3f16658c-56f9-4ec5-ba6e-4c56a0b8f5e4@gmx.com>
Date: Tue, 24 Sep 2024 10:16:13 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
To: Josef Bacik <josef@toxicpanda.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Qu Wenruo <wqu@suse.com>,
 Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240923064549.14224-1-jth@kernel.org>
 <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
 <20240923152046.GA159452@perftesting>
 <d881d399-96fc-4cf5-8a40-96f2e76b7644@gmx.com>
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
In-Reply-To: <d881d399-96fc-4cf5-8a40-96f2e76b7644@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TjoOxA5fAWmDm1sQiJaN0KL6gFnDVSI7IMcmR0UaaePkT9rolyY
 1dX1zWgqGwruiNl98zZ0+zeBAPMbStsPiTHiJAIjUKVZBUmDchHk0+pP4EhsASJv61IB+YG
 /3JMwg90l/1q4FBrNifXDmTjQIctEhLxJl0qPeTGN6iWzXy33UNAM96sRpAjKLDDFB0P1ge
 KYreqo6DrYdPemx4bfong==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uWEYTuIKBnA=;/mBpxPIV9cpqkP74pQ2uHUA4sX1
 fHWtlIm8YlPcVD9nTY5p2yCAHFsdbzEXx0nZmdc/HgJ0/NG3CJQLGtDFIGhPnoFMxy9va829O
 ZIiOCPjbJmhqO7T7oR9z9jqIr3ot4DaNRFkm9K1GQaRZ+SxkTrcM6/L8cp9sA2xhDIhfiRBYS
 6g1QnA0ZVN0djFnmg1uGIG+6PkykX5IPuF9ywFXyoK3Ap037T3whSlvHH3Q/89YqZgBz4nB9F
 n6dzRuHwi1DYsVZGh1stkLUcCCH1VSLvltZSbuzbGWSmK0EmTl0dkqdeu0gynHf3t7ZXLNmMx
 mCkS3GtR/c2xmJ1X6woidc7renQUx5kEBDprRwIZOPiPXruvEf19M8hPV+hmeBjOPuBwW5j9n
 nT+R58if05AUeyUhM3jYE0TWadGJJH1ia7GElZNZ++n83yWAPpdInpcmU/4Pblr64hXWwwdyO
 /PHLJFfecLUd1q4Cbg0ncYvS9zvVJNXv4Iejmx5hHX1NGQC5mnVWFO2wNdHaWVmK8jvyUonnl
 9E39lGDx/bB37PuZtihCP+aMhDeNTNUGOQkuYc39OKWFVAkPC53VOHfWd0EUjZNkcWnFi47xw
 Z/0YU0I8Lbu7kb0oR7nAo1ngYM3AjStfz5KVzylM404JPu73NCEtEaKYYF2PaRcwbf4+eEHoZ
 zPVZKU2o5bp0iZlCsIfP70OayhhRTzUqMvEr9cnst+8/XWOD4kXE2NVSTIFeFs9evw29xHbHV
 hYIR/XvKr7OIN11PAOZ3OxRPZGHbLO2dZpbU1tJIKNbffeKseOiwl5ddT3SRK6qTj3dP7EpXW
 xwLd1oeHi7swXMhm85iEdxDdWGErcCu7SElDPQTgvJNFY=



=E5=9C=A8 2024/9/24 08:02, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/9/24 00:50, Josef Bacik =E5=86=99=E9=81=93:
>> On Mon, Sep 23, 2024 at 04:58:34PM +0930, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2024/9/23 16:15, Johannes Thumshirn =E5=86=99=E9=81=93:
>>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>>
>>>> NOCOW writes do not generate stripe_extent entries in the RAID stripe
>>>> tree, as the RAID stripe-tree feature initially was designed with a
>>>> zoned filesystem in mind and on a zoned filesystem, we do not allow
>>>> NOCOW
>>>> writes. But the RAID stripe-tree feature is independent from the zone=
d
>>>> feature, so we must also allow NOCOW writes for zoned filesystems.
>>>>
>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> Sorry I'm going to repeat myself again, I still believe if we insert a=
n
>>> RST entry at falloc() time, it will be more consistent with the non-RS=
T
>>> code.
>>>
>>> Yes, I known preallocated space will not need any read nor search RST
>>> entry, and we just fill the page cache with zero at read time.
>>>
>>> But the point of proper (not just dummy) RST entry for the whole
>>> preallocated space is, we do not need to touch the RST entry anymore f=
or
>>> NOCOW/PREALLOCATED write at all.
>>>
>>> This makes the RST NOCOW/PREALLOC writes behavior to align with the
>>> non-RST code, which doesn't update any extent item, but only modify th=
e
>>> file extent for PREALLOC writes.
>>
>> I see what you're getting at here, but it creates a huge amount of
>> problems
>> later down the line.
>>
>> I prealloc an extent, I map that logical extent to a physical extent
>> and then I
>> insert a RST entry for that mapping.=C2=A0 Now I rip out one of my disk=
s,
>> and now I
>> have to update RST entries for extents I'm not going to rewrite
>> because they're
>> prealloc.
>
> Why do we even need to do anything update the RST entries?
>
> RST is just an extra layer for logical bytenr mapping, and did you see
> the non-RST btrfs do relocation just because one device went missing?
>
> Can you explain more on the "have to update RST entries" part?
> That mismatches from my understanding of RST.
>
>>
>> RST is a logical->physical mapping.=C2=A0 We do not need to update or
>> insert anything
>> until we create that logical->physical mapping.
>
> Just consider the fallocate of non-RST as an example.
>
> We DO allocate real data extents, they have real location on the disk.
>
> Then add the RST layer. Now preallocated extent suddenly do not have RST
> mapping, but still have extents allocated for them.
>
> I do not think this is any more consistent.
>
>> =C2=A0Keeping the rules consistent
>> across the different layers will make it easier to reason about and
>> easier to
>> maintain.
>
> I think all data extents should have RST mapping, that's way more
> consistent than two different handling for different data extents.
>
> Just like we do not bother if a data extent is preallocated or not in
> scrub.
>
>
>> =C2=A0Adding an index at endio time for NOCOW makes sense, we now have
>> created a thing on disk that we need to have a mapping for.=C2=A0 The s=
ame
>> goes for
>> prealloc, adding an entry at prealloc time doesn't make logical sense
>> as we
>> haven't yet instantiated that space on disk.=C2=A0 Thanks,
>
> But we allocated data extents. Even if we won't really utilize them for
> now, we should have RST for it.
>
> In fact, I do not even think it's correct to insert/update RST at
> endio/ordered extent time.
>
> It will be way more consistent to update/insert RST entries at data
> extent allocation time.

My bad, this is impossible for zoned devices, and that's why RST is here
to help the situation.

So this indeed means we have to do the work at endio/finish_ordered_io()
time.

And in that case, it looks like we really have to handle preallocated
extents differently (thanks to these zoned devices)

Thanks,
Qu
>
> Thanks,
> Qu
>
>>
>> Josef
>>
>
>


