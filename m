Return-Path: <linux-btrfs+bounces-12167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2881CA5B012
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 00:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B130F18902EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 23:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844D2222B6;
	Mon, 10 Mar 2025 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k0FICVzA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506001922C0
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650980; cv=none; b=oNAwoPnJJQVDCwHIULe28oLnynEoSjAQY57rV9MsKnBcAp3VM7Ikq4ZZKcHYi+XLDpNTUqb79R6ojtFhwLlQbn+T0JVt2TJqgDT0XCVa/H6ncN7BwyaPjy0MAobmbOt+wioVy3Pzu9IshWXsVyeTYXCDMcfn7GyiuN5nf/y8SUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650980; c=relaxed/simple;
	bh=5ocYZL6lIA1XN/fclPKm41pG/Bm3MBeWAWt3naQFj/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvUD1+mcevDWFTibDDMU/rsYVgc/y1VVPIbGpRm/nEIGMsRICpY4TRuAnZ6IJQGk5KYKVmpjnb/kfYtTWccEEZyxolKMuLm1iI9/sN7uevrI80/mXK9jEOF8Bc5mfIk17greKJIR3Im161Biqo/PplAFuRnXHzZxEdNU1j15Ops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k0FICVzA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741650976; x=1742255776; i=quwenruo.btrfs@gmx.com;
	bh=p6IuBY9206EPpmvgFYditBY6OZ2hMzydktY6K0zhdFg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k0FICVzAhNld6981GWv6HACTvzF3MPgW3C9D6NPY4qJWbzEkNbJQGyTCz0+YHaty
	 HNkfohmIpqc74H+9mftNgSCWpV/qJFULx8oD1NwEIaWzkLXhJyYMvPih+Fk7oH+Ih
	 oVX59vlhzr8M+luczV//naPayRkyOE2+vjqmgVD9RAQXx5IgUApPpKCATc5lJIDvh
	 X/jwdBuOSp2/C2YfXRU8XFhEXmBSGumHufiY1ygqu08GVxgfBEAP8CO94Y3cqnjNO
	 6YTbht3B4/xqenycmJhDlb1HgxZeoxHkr9PUa1IXce25EC2ZP5yyMe2+s2I38Xx4b
	 llEp6Km21RSVrI1Zeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MS3ir-1tfrAi3KXr-00VD2M; Tue, 11
 Mar 2025 00:56:16 +0100
Message-ID: <f9f19507-f33d-4db3-afda-ac39363c7db0@gmx.com>
Date: Tue, 11 Mar 2025 10:26:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] btrfs: prepare for larger folios support
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1741591823.git.wqu@suse.com>
 <20250310233235.GB967114@zen.localdomain>
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
In-Reply-To: <20250310233235.GB967114@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EMbHdsNRg0D9kbgJdKjdbZNd1+1KmNBJy0a78VOyhCLLE5L3KjX
 56kL0qJJ8dVe0PiQsqJMsr56l5OCucQWWsboHigOqX2aeynV8WhjpuO2lCE+Mt495jDQdYo
 Tz/M5ZlOYBe8S8ZnFGCLHOC78hN5QDscGe9HkaQTrBFMSihKh52JRY7g6f4JgdTrOizTaQG
 DNNdDzNZdo9TvjZu8siaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eyymiQvcqqw=;JexELREe4+LctwzXSTIx1S3JXT8
 bK3XDH1x5kNty6WPvqUYUuR8PYSZSXPcRgORyPPpQNv0NRHmIsiPGB3aWc0tmYEiXKiXk5iTI
 dxkqfG8MO/tnnHgsK9Ld57+f3ze4oRX6F8M6bgJoj6Sn+zTUPBpovZPyXEsNMB+aAEqzN/hLC
 OlADfNmyAZgCrRDxDGvrLdA5UDVRTKAQ2ctEPh+OsW/BTOpzAVEubbJ1B9vpM0vGLpap4rCSl
 ky3v3nroif245X1yiEvLMKCpXP30j6cziTXIJ+019SPZ56JPW9JUSWYzZKn+tzX4jvJ4UMFem
 V4csvsf5VgP+Mz7JGahG9M95B98pXoUk1gb54Nk+P1xSlzvSfdOeK1bzlW6QUijqS2f2Fnnjo
 sVlHDsyR1eUp0wZdiTj6wmOMisbL/YwvaOzIeuTB2RcLJo/hIgxti+Q4mNaQEo+iZrZvr0cDi
 Spdpl/n9HS9KNEveO10PCj2ZM3OnmkpD/heRnd0uw7LTlpIcfH1H4QHpCYWBNingrnYkGlIHh
 BdtlChQj9UYigkqWTGBBrBUuQnX9H6MQkHdM90xcxrO76rpzoTlDVc5qX536VrFEaigcNqzIs
 of8mrf9M6GIrG0bErLyk2HouDIYwGZ9T/Wm8lx8mFNN3fpBhYNeSM9sJgq0LHXvEKYK7ZWQMR
 +11cl9Crz+06apXsVu+FLOACs4MER1bAL0Ps8v+ClfhigATSRq8KAMfelrhLfac3KkK+IrxZ3
 D6wmzcB6OljSljVnJ0QZ1O1wrCFlxd5K7KR6GzBUQF+UE9gPAF+ecVFR9gwX57sbUj6ommNLL
 tfqNcIzULMrQzGOBgCMQhu3jtCEoWXtbM1AF17q3ZAOElgAgdzHQSC25NaPnTOf5aRQ4/CRFU
 cFe4PDpzYmK28jerWF2cPQ8yiq3RC29wh3f7rQAr2aRoFkcXQ03QNqsNRgNzZGEHLTdXn3qu8
 nhvfYAhfrNfKvQjmdC1ehpatE+21R90ACUlLdGvkBxczQrMrDp9DonkNXHyhw5DGDtOBvAoSM
 wvoW8xrIODk7n6UixGB2Tp8fgC/+j2ZSqtnAC11kq40uAF3b8BMZeTUdtIUXd8Eb22dNVtckf
 n2KgfzV2GqzZTF/epbqbhE3M6Fmv8bdor8c5GRGSvK7DErbYobBHj+BORQ3LWB6uYnRsc55uS
 5IVrEM+pltdjXkQB+HsdvSN2McUrBILUxsC3kIyfQ6DatG8tEQct7Ndh/VTs7Tlc7BjAsooi9
 KGv+CzgZrLEWlgKg4WUehQy6XZivV6HkJ8/WEESqaEK0CRvOSlvpgt7oWo5f9vcJuI4/QbtTI
 EXYbZzoSDKqo61eGik+7nK2Hbff1EX6HdDEctvxShwTPG+kki9mMcpsVZTUUHpKR09Lu4gMKI
 k/6cQpZ+qmT5wFva14I8x6/BLvpO2o3DbzCOU=



=E5=9C=A8 2025/3/11 10:02, Boris Burkov =E5=86=99=E9=81=93:
> On Mon, Mar 10, 2025 at 06:05:56PM +1030, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Split the subpage.[ch] modification into 3 patches
>
> I found the way you split it to be a little confusing, honestly. I would
> have preferred splitting it by operation (alloc_subpage, is_subpage,
> etc..), rather than a basically incorrect prep patch and then a sed patc=
h
> on the subpage file.

That's why I initially merge the first 3 patches into one.

If anyone else has some preference on the split, I'm pretty happy to follo=
w.

>
> You already iterated on this, so I absolutely don't want to hold
> anything up on this observation, haha. If it's something others agree
> on, I wouldn't mind seeing it before the patches go in.
>
> I asked a question on patch 5 that I think is interesting, but please
> feel free to add:
> Reviewed-by: Boris Burkov <boris@bur.io>

Thanks for the review,
Qu

>
>> - Rebased the latest for-next branch
>>    Now all dependency are in for-next.
>>
>> This means:
>>
>> - Our subpage routine should check against the folio size other than
>>    PAGE_SIZE
>>
>> - Make functions handling filemap folios to use folio_size() other than
>>    PAGE_SIZE
>>
>>    The most common paths are:
>>    * Buffered reads/writes
>>    * Uncompressed folio writeback
>>      Already handled pretty well
>>
>>    * Compressed read
>>    * Compressed write
>>      To take full advantage of larger folios, we should use folio_iter
>>      other than bvec_iter.
>>      This will be a dedicated patchset, and the existing bvec_iter can
>>      still handle larger folios.
>>
>>    Internal usages can still use page sized folios, or even pages,
>>    including:
>>    * Encoded reads/writes
>>    * Compressed folios
>>    * RAID56 internal pages
>>    * Scrub internal pages
>>
>> This patchset will handle the above mentioned points by:
>>
>> - Prepare the subpage routine to handle larger folios
>>    This will introduce a small overhead, as all checks are against foli=
o
>>    sizes, even on x86_64 we can no longer skip subpage completely.
>>
>>    This is done in the first patch.
>>
>> - Convert straightforward PAGE_SIZE users to use folio_size()
>>    This is done in the remaining patches.
>>
>> Currently this patchset is not a exhaustive conversion, I'm pretty sure
>> there are other complex situations which can cause problems.
>> Those problems can only be exposed and fixed after switching on the
>> experimental larger folios support later.
>>
>> Qu Wenruo (6):
>>    btrfs: subpage: make btrfs_is_subpage() check against a folio
>>    btrfs: add a @fsize parameter to btrfs_alloc_subpage()
>>    btrfs: replace PAGE_SIZE with folio_size for subpage.[ch]
>>    btrfs: prepare btrfs_launcher_folio() for larger folios support
>>    btrfs: prepare extent_io.c for future larger folio support
>>    btrfs: prepare btrfs_page_mkwrite() for larger folios
>>
>>   fs/btrfs/extent_io.c | 49 ++++++++++++++++++++++++-------------------=
-
>>   fs/btrfs/file.c      | 19 +++++++++--------
>>   fs/btrfs/inode.c     |  4 ++--
>>   fs/btrfs/subpage.c   | 38 +++++++++++++++++-----------------
>>   fs/btrfs/subpage.h   | 16 +++++++--------
>>   5 files changed, 66 insertions(+), 60 deletions(-)
>>
>> --
>> 2.48.1
>>
>


