Return-Path: <linux-btrfs+bounces-7057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE694C73C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 01:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE981F22845
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 23:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B1715F402;
	Thu,  8 Aug 2024 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="E8M5VVqi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E915F316
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158836; cv=none; b=SYpKRmVyQ49175eEYH/LYg362qSSNRqPAcGApizRLWT7xJVd9ns7JreXBexFXseqbhDlUPNQrKgeZgBRq8bS0dr3sFOzqOIK8Ejpk+l/GHgtcYEl5/fWE7uDFZhHGXfEI21/9kmFHxARcx1I7KWcKT5JMrw6hZUgNOFLQS89fWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158836; c=relaxed/simple;
	bh=/XRjxkisSTxnq8WmCCoUprVei6aw/fXxBKjXzhTajiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYIiRF13W0rN5Mw5/a7uv0rXhffynH4fYWHuDPbSC9fcU4c9gjmXAL5e0kUl6udTS+82LETLO5yedxTliWekYIWrv51q9Y/5XekEn1RYARl+CfnDcE+FCKnW9uiAII00JbKfm+UoIyT1hSKwO0LGPYNjed5x9Eol7CZa9rE7sHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=E8M5VVqi; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723158827; x=1723763627; i=quwenruo.btrfs@gmx.com;
	bh=LCQSVf5vPof6560ztRK9QrtoDxLEGVQRn1ZJiG7l42E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E8M5VVqii+35id/2kBcOOgWQZB/td5zKf6ccKJzmBV7evlWsuvZfVUzIRzOhZ9gU
	 JdeV63x42xkBJaAC6Ql7Q6M4SxLBdX0yq2SBqTeWWdNVPuj5qHzw9OO6+h/gbzCOz
	 t5mNYrFFWywXmWJLRSSYfXC+3ycuN4ovGvmQ8B42p0V1O16EYy5CJUlrkOTSpaEP1
	 sZZtQ7R9zSD90cJGvxStdz3mqde3SMaqHk79LJZaUfEStGbzNeTFIUzsTntKTY9bJ
	 cjHTnOU9ReVyaCm0wrIVyhHQKHwRRIBze+VNGCEK/cmSbOb3ng7l8LomZJHOdYhKj
	 uPjypHFvLzQN3TpaBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7R1J-1s8K6I0hUD-015oTN; Fri, 09
 Aug 2024 01:13:47 +0200
Message-ID: <1197adb6-332f-4b93-a614-fe78f74f1e9e@gmx.com>
Date: Fri, 9 Aug 2024 08:43:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: introduce extent_map::em_cached member
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1723096922.git.wqu@suse.com>
 <3843c1c37c19f547236a8ec2690d9b258a1c4489.1723096922.git.wqu@suse.com>
 <CAL3q7H7kXGi7WBnm3eGDTAsvxS7+xr194Yi1bRhJ44FrivEHXw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7kXGi7WBnm3eGDTAsvxS7+xr194Yi1bRhJ44FrivEHXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/9KvSUqgc8SjLSDOV59r17slfyEpcnV3ayWdak5QhExtyr/ny0q
 1V6bQ5d6Shg4UvsRHWCEskoUl4OnnaqBE/aN9mIXLSxvuKS86tMUgUoEWmFL1HMPqhZ1ZW2
 9QuK4mI2OgRxrJ+AIwT8sfB9g8tRRKgU38V0vm2Fg0u2NWNnZrqNGselwIgRWt8kVJI0J4d
 EVTgsXi121QiUiqGp1ILA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U1gNdjgFfCI=;XwQemGJpFJHY5XmsJ48/D+nAhcE
 b40mbeon/LAh4LL8FFXNIFo7GJ4dr/Gew5u/oVBbeheAFXERUld+MtYG8qZrVdNokcfOg/srj
 mBib8PbJgWj144p7oL1WGkD7ZPAwfVxWKJDPCQW/LUbEZxlnR5nzpSeJ4ygQ5xzUvsnFxcKOP
 6NHmERgj4Gkd5vSFK6th8q086IPuEjJ9ax3V8gTdvTHPDBxdTdG63QdDW7NvU3eRn91/C15/b
 ho3dRtsSSR1dJypa3MkhZOQp+FnUp+gRhrEiXVNB2MpDqP9Lor8LOqzry8itJVHtseOMLurGa
 e3sQANHGx8SZvGBxprjST82C3GoLzDWUh8hj8N5jt0E7D/ZPKP4q56CWBK3vkPi2sz34490b4
 hUf+6IXBB8rWL6EmLGtU+RsEq+LuZsod7IRZzpZynEPomF0wBdWkF/6kXAs+94pauI0x7R313
 K9fz0uzjCmOcKxzph4xGdsmdWx985ecMj0tSC6lTqg/eRe96WGPRaI4ECfn0cbrvon9MOitaF
 tgyySIwZT7PjWMy1hURlrvcSHQFqgyOEjdzIDLkC/ZzELV5rb11CnjMu90Tkbg0AU1qPy1iYH
 6RXkmjpSgnpqEo0SFboO/ydqUXK7RCt2UADc3yQMP8ItcOdhuHuBYXJqIwZMRv+2AEZtMe5S9
 VwQK9JtqEPLSc9xuh/W8UjeBzjX0BQZzfgQmdVAEQ6aL6pVKCf5jq3VIVHHbvboD+BbhsS9+m
 b/1i3qCiC9QqXMxaFBd2lg8Y3fzyC8LqC5tRx2yM7tBJD2RrBDLGuDnjFRRWnVWxdc5vEBmMl
 qmUQAHHlyVWJxTLLlyz/SWsw==



=E5=9C=A8 2024/8/8 21:06, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Aug 8, 2024 at 7:06=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> For data read, we always pass an extent_map pointer as @em_cached for
>> btrfs_readpage().
>> And that @em_cached pointer has the same lifespan as the @bio_ctrl we
>> passed in, so it's a perfect match to move @em_cached into @bio_ctrl.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 822e2bf8bc99..d4ad98488c03 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -101,6 +101,8 @@ struct btrfs_bio_ctrl {
>>          blk_opf_t opf;
>>          btrfs_bio_end_io_t end_io_func;
>>          struct writeback_control *wbc;
>> +       /* For read/write extent map cache. */
>> +       struct extent_map *em_cached;
>
> As mentioned before, this can be named just "em", it's clear enough
> given the comment and the fact the structure is contextual.
> The naming "em_cached" is odd, and would be more logical as
> "cached_em" if it were outside the structure.
>

Definitely will fix the naming and subjective line.

[...]
>
> So instead of calling free_extent_map() before each submit_one_bio()
> call, it would be better to do the call inside submit_one_bio() and
> then set bio_ctrl->em_cached to NULL there,
> to avoid any use-after-free surprises and leaks in case someone later
> forgets to call free_extent_map(). Also removes duplicated code.

This is not that straightforward. E.g.

	|<- em 1 ->|<- em 2 ->|
         | 1  |  2  |  3  |  4 | <- Pages

For page 1, we got em1, and now bio_ctrl->em =3D em1, add the page into
the bio_ctrl->bio.
For page 2, the same, we just reuse bio_ctrl->em, add the page into
bio_ctrl->bio.


For page 3, we find bio_ctrl->em no longer matches our range, so we get
the new em2 and stored it into bio_ctrl->em, so far so good.

But at submit_extent_folio(), we found page 3 is not contig for
bio_ctrl->bio, thus we should submit the bio.

Remember the bio_ctrl->em is now em2, if we clear it right now, the next
page, page 4 will still need to do an em lookup.


So unfortunately we can not free the cached em at submit_one_bio(), as
at that timing, our cached em can be switched to the next range.

This is not a huge deal, as we're only doing at most 2 em lookups per
dirty range, but it's still not the ideal 1 em lookup of the existing code=
.

And considering there are only 4 call sites allocating an on-stack
bio_ctrl, the explicit free_extent_map() call is not that a big deal.

Thanks,
Qu

>
> Also, as mentioned before, the subject of the patch is incorrect, it
> should mention btrfs_bio_ctrl:: instead of extent_map::
>
> Thanks.
>
>>          submit_one_bio(&bio_ctrl);
>>   }
>
>>
>> --
>> 2.45.2
>>
>>
>

