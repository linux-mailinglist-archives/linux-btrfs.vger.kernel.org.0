Return-Path: <linux-btrfs+bounces-2398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17A8554DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 22:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D37284A0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4913F01D;
	Wed, 14 Feb 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C9ASXEAW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881D13F01A
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946412; cv=none; b=LglZoZ3tNRqTQISwkIxNB/GEMUd5DDxFoLRK3dw/2dqzQDqVKA6SO4nm3W9MusPZGP8hrGviIOi3cR/Brqi+i8D3En7teIbDpWNEXQYpVeJZhBrSswUKdK83KtfiBqqk4AdkMc9XBTPWT25Vx1JYi+ZDr3TG0neJN3qWvuPI6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946412; c=relaxed/simple;
	bh=0BOdWwZMk/UbJlhBoWtPi+EmOFPgBc7eWCp8+52rYIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxnVLyQUHz8AilyB5Q3DmYLFVEIQZRJzavr9JK2ohIXKPSPofZKkZoqE7PyhmIT/3Vk7DIVzRLBv/J/RF6/UpB4Y+ugEiAHrGY2YWWZFbNuugrzsJ+q4hDIQyqwdFCKdXCecRC15QiPkVmAPtYUUkYKoi88KCtL8yAz8uRcZz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C9ASXEAW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707946403; x=1708551203; i=quwenruo.btrfs@gmx.com;
	bh=0BOdWwZMk/UbJlhBoWtPi+EmOFPgBc7eWCp8+52rYIk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=C9ASXEAW8lQcBtsjvvDg/8zwN7DvmXdmGKsWm8fLniG0S6Q7dpcmeGHD41vdxLM1
	 5MwbZSgdXT09fSKJJqaai41R+fIZnivA70WVE9RpVBdtp5SFe6c7fn09738gkuZYd
	 z2bAu3fQN87DW6Hid4GNQyBQvIh5h4GE2plxWhi3e/+vijJA8ti74ZYPmBLrjtGKL
	 SDmoV+legi1ZUZ4JHfRZkO3MTFJzf11NvzVs4CzNfwu6crxynYJq+uFnVTOfndc4H
	 ik0clmr1/LFISod/2AekJFdo2nhe3kLgIfF/7JgZw9pIVfb6TsLEWjMRReWKoBp8n
	 I3tUA6WGsU1cUqv2Jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOiDX-1rKD5345QV-00QBFM; Wed, 14
 Feb 2024 22:33:23 +0100
Message-ID: <a55340df-9a6c-48a2-be7d-bc3ee98351e3@gmx.com>
Date: Thu, 15 Feb 2024 08:03:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: make subpage reader/writer counter to be
 sector aware
Content-Language: en-US
To: Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>
References: <cover.1707883446.git.wqu@suse.com>
 <20240214182117.GA377066@zen.localdomain>
 <28cd604c-230f-4f80-be5c-f835372d80d0@gmx.com>
 <20240214212537.GA481589@zen.localdomain>
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
In-Reply-To: <20240214212537.GA481589@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wjDvCVun80AO3Oe6kNLJ4dt8IjGf4/Ek0RFIuLrl6DZ9jxtd1zz
 MbY1r/n4274itUxNFqWggeEfomFhz4QPDgK6ToW3HQzsoC5bpn+mMUIIQHxmcdY/KC51PeP
 4Eb7Dwz+CHH9QS2d8TgceGOQzQF4cRCo/JMgPiCdiiBclK0ieNWonTr7BeOQprspWyg0Qv0
 vQ5xg35kNDfZyHmyQWmaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i89Fu59QcJQ=;pXioiaGHCZIlPlNCccCyoS5hTL3
 beY2i8GrIhtqt78xy1W65ywE4kkUgo7WXupXRBBj4Mih4O8nZd8JbiY+UxL7Pxb6FtRo8Jn5y
 M9IXh65Dz2+RoabxZhomdo6Jc7KuhwXkJ1SQKyw4L9il/ZEvQkYuZkl0S86teNC9IpOqLIdsK
 0MwGb5J/8eWPlsBzXIRm8ckll9Y7IsclJbg/CrRP9I6WvEKGHoi80spDObCUXqnVc1uguC295
 LLF2pPQ0i5MdLz/rSA1+xBkBuxAWyJC9iYPq4izCdHyj6ygpc87mvh5JYV7ym35z9iJNkhkkv
 WVaw1xQou/DT+CU6qYIj+u9ZTH5Xag7Azr+dYeBr9z6wt2jrCG/Vpk9dTyqckH/A+VnkD+jJe
 +fst8F60LBBVVuvlCntEGxxZloutx9aX0wqKv0A6dnnz/ABIx3umJRKZ3Xu3a4g9l3yrXQ36b
 JOAGQuArYDYTW33QFpvSCkxBtatAlWUWhCjPTnYXKahpLfMhZbUdX4AhtgnyRthqFlCCpZDLU
 1LM8MuplbhX0HAcL5Zg+a0zoiTXhdo8fRZwbSI1Znw1wF4nD9u2HBYcGqB2OkJnwmvJwEG9SX
 zp0xHv4As/P22vPWLwYFMrX7NhAA04EOX0w8sCMMUDYky4hyda2HikuS9S+avYjWYSTTKm25z
 R57WEarr0+3loQ2Xuyua5Q/q+lABrDDBeEbUEWXpy6GeMP1fwq1P0Z5MpqYLS4yAVZreF+d0X
 rULxhvRoAT6qn/BQ+QO0NIRv6YLq5kXb+3f2B9QisjkKYK/nV3LCttc46osV+Pg8L9D/2kQq6
 w3Nqsy/9KBhySyctO7tKwWBCfOJEDbIsBWxhrkTAzOdaI=



=E5=9C=A8 2024/2/15 07:55, Boris Burkov =E5=86=99=E9=81=93:
> On Thu, Feb 15, 2024 at 07:39:15AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/2/15 04:51, Boris Burkov =E5=86=99=E9=81=93:
>>> On Wed, Feb 14, 2024 at 02:34:33PM +1030, Qu Wenruo wrote:
>>>> This can be fetched from github, and the branch would be utilized for
>>>> all newer subpage delalloc update to support full sector sized
>>>> compression and zoned:
>>>> https://github.com/adam900710/linux/tree/subpage_delalloc
>>>>
>>>> Currently we just trace subpage reader/writer counter using an atomic=
.
>>>>
>>>> It's fine for the current subpage usage, but for the future, we want =
to
>>>> be aware of which subpage sector is locked inside a page, for proper
>>>> compression (we only support full page compression for now) and zoned=
 support.
>>>
>>> The logic of the patches seems good and self-consistent to me, I don't
>>> see any issues.
>>>
>>> However, I think it would be helpful to at least see the client code t=
o
>>> motivate the bitmap a bit more for the ignorant :)
>>
>> Sure, if needed I can include them into the incoming subpage delalloc
>> patchset.
>>
>>>
>>> Also, from a semi-cursory inspection, it looks like this relies on
>>> extent locking to ensure that multiple threads don't collide on the
>>> subpage bitmap, is that correct?
>>
>> The current plan is to make find_lock_delalloc_range() to always lock
>> all the ranges inside the page, at least beyond the end of the page.
>>
>> The main work flow would look like this:
>>
>> find_lock_delalloc_range()
>> {
>> 	int cur =3D page_offset(page);
>>
>> 	/*
>> 	 * Subpage, already locked, just grab the next locked range
>> 	 * using the locked bitmap.
>> 	 */
>> 	if (btrfs_is_subpage() && write_count > 0)
>> 		return grab_the_next_locked_range();
>>
>> 	while (cur < page_end(page)) {
>> 		/*
>> 		 * The old find and lock code, including
>> 		 * the extent locking
>> 		 */
>> 		cur =3D locked_range_end();
>> 	}
>> 	*start =3D the_first_locked_range_start;
>> 	*end =3D the_first_locked_range_end;
>> }
>>
>> So for non-subpage cases, it's the same.
>> For subpage cases, the page would be kept locked until all its subpage
>> sectors are written.
>> (But would need extra cleanup if we hit some error during subpage secto=
r
>> write)
>>
>> And the above workflow is still being coded, not yet tested to see if
>> there is anything fundamentally wrong, thus it may change.
>>
>>> You should check with Josef that his
>>> plans with getting rid of the extent locking don't clash with this.
>>
>> It would still conflict, but the extent locking part would be the same
>> as usual, so I believe the conflict can be easily resolved.
>>
>> And I'm pretty happy to help solving the conflicts if needed.
>
> By conflict, I meant logically/conceptually, not in terms of git merge
> conflicts.
>
> Right now, AFAICT, your code relies on the fact that the extent is
> locked to ensure that two reads don't trip on the bitmap.

Read and write are ensured to not happen on the same page by page
lock/writeback flags.

If Josef takes extent locking away, it's still fine.

> If Josef takes
> that out, does the assumption still hold? Page lock gets taken after
> modifying the bitmap, right?

The page is already locked before taking the bitmap.

The page is locked in extent_write_cache_pages(), while we take that
locked page and update the bitmap in find_lock_delalloc_range().

extent_write_cache_pages()
|- folio_trylock()			<< Page locked
|- __extent_writepages()
    |- writepage_delalloc()
       |- find_lock_delalloc_range()	<< Update lock bitmap

The whole change is to address the page unlock part, so that the whole
page can only be unlocked by the last delalloc range of the page.

Thanks,
Qu
>
> Sorry if I am misunderstanding you.
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Boris
>>>
>>>>
>>>> So here we introduce a new bitmap, called locked bitmap, to trace whi=
ch
>>>> sector is locked for read/write.
>>>>
>>>> And since reader/writer are both exclusive (to each other and to the =
same
>>>> type of lock), we can safely use the same bitmap for both reader and
>>>> writer.
>>>>
>>>> In theory we can use the bitmap (the weight of the locked bitmap) to
>>>> indicate how many bytes are under reader/write lock, but it's not
>>>> possible yet:
>>>>
>>>> - No weight support for bitmap range
>>>>     The bitmap API only provides bitmap_weight(), which always starts=
 at
>>>>     bit 0.
>>>>
>>>> - Need to distinguish read/write lock
>>>>
>>>> Thus we still keep the reader/writer atomic counter.
>>>>
>>>> Qu Wenruo (3):
>>>>     btrfs: unexport btrfs_subpage_start_writer() and
>>>>       btrfs_subpage_end_and_test_writer()
>>>>     btrfs: subpage: make reader lock to utilize bitmap
>>>>     btrfs: subpage: make writer lock to utilize bitmap
>>>>
>>>>    fs/btrfs/subpage.c | 70 ++++++++++++++++++++++++++++++++++++------=
----
>>>>    fs/btrfs/subpage.h | 16 +++++++----
>>>>    2 files changed, 66 insertions(+), 20 deletions(-)
>>>>
>>>> --
>>>> 2.43.1
>>>>
>>>

