Return-Path: <linux-btrfs+bounces-273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACD7F3853
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 22:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265DE1C20D4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 21:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBF6584E6;
	Tue, 21 Nov 2023 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="e/aKNGr6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64081BB
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700602257; x=1701207057; i=quwenruo.btrfs@gmx.com;
	bh=VyO5k86cwRd6E4OuN/wOnS9+ZvtHo/Yw9vndQ8VWC5M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=e/aKNGr6ePZHyrVjZJ1+En11EWCFmeLrqi7WRy/lwFFjhxChDRd7jRlhLgeWbaJw
	 ZJaulZpnCI2Wf40TQ5cF1N/qjd/Zy10PTcbRUju3QKuu9wmaJ7fxYcOE/dXKRdeBz
	 Ks+8Gt21qBu5TsvfA3RCcdYFSVbgaxX4e8SubO+gVDfJSUzGegfcgyCByDO3GRGvw
	 366b/AIVjxnRxhpcGhnM0tNQILKtxnazi10gxczPMkRcKprmQEI1Qlrf8Tu2VeARj
	 qKE9SnxZg9GgKPG9kTsqK32iA0NvihqbPkv2crFwZ+NU2U3Hdi6ecwO70QNnUr7m2
	 1zNnQaz06tO0tb6fpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7sHo-1r1iqI2Qyo-0051ki; Tue, 21
 Nov 2023 22:30:57 +0100
Message-ID: <513bbc52-8f0b-4105-a079-a81f9b67fc55@gmx.com>
Date: Wed, 22 Nov 2023 08:00:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip cross-page
 handling
Content-Language: en-US
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231120170015.GM11264@twin.jikos.cz>
 <a73faeae-1925-4894-9512-7a049ff8353b@gmx.com>
 <20231121153529.GS11264@twin.jikos.cz>
 <1b63c587-c2c5-44d5-bbc3-5facc34f5361@gmx.com>
 <20231121211437.GX11264@twin.jikos.cz>
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
In-Reply-To: <20231121211437.GX11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MgyJ9HotIQBxKuizOHcRoWkXDzchVnHnDJscN1s5c3IY//hD8sW
 yclVjdUNHR3A15EN4Ke1Sy4WA9SlrefNAvLk8xoSzKb51h9lq9twGVscwUlWV7GaIelHPgW
 aLbyFmUeLWXpq/uzeCL2+bzjjd8PMj+U+2+Nrgd8APK5n3TVI0lxz/+RMtkkoUcFG6ULZEG
 pYMzUHFGeRIDvA9wo1EmQ==
UI-OutboundReport: notjunk:1;M01:P0:YGRk5eIbT80=;G9P+B4oiNqstegVJ5n23MnnoM+X
 rB2DL8rgSdvsfTgjlncWSc16kPQliz3a501KkAjdnq3HlegRcvG9LqK+h2NNTFQ3zsIVxAZlb
 H4NWYXY42JED0CfBIbQSZilldbsiSI2JLNPZcFgg2VN2WD59J2NuNTWCX4gxll7v5O4v0VwQ8
 tGhJKrwt5bIWqhV1aDOHdnntE1ywnvYhlf7SmbY9/BgWegToIw66o1H4P1wzPfabZ7++ED/+1
 siiIHP1PkdhzJZEBFPKXD4Fc9bumzyxZls+RFMfVALBH+yIdviA5cLOOWx0GrayF6aCxat0tD
 Y+goBgh1w+prxlNWuUvjUvPJ/5BRkMzpTS44MJ/h9bsO3XrOEtFmpx9dEVJfYoKAMkaW1Qsbg
 vgDxOZtoyVLfHl4hSRxqUu9CpsAVSeL0QTADFk3cxakBNPxeRXnGThfb5XveunvXpbwqbgj8q
 jcOV1hC9lUoVGsVvq3vGjaeYZ8WGo9QIf6NoTtJCZXCQAaDW6DywJU7o8rJhzuI3PMjTIAEVA
 0Si+izH9cXVM6AaEb1yIgpbi09PCVsUmS1auf4ceioJRDgWhFmlACDnGSRbR0cl3uKhwieSFl
 B8ekGZsn9OV5ZhmRKZsc3y+QOE6qPfL664xyQeSnrrbQKIgAeC8Oc+y27bPYdEBQGA3JNqWAO
 r0S70vuEwvO3Fj+CG0SUV6d/OZVGKwk2ZtZlJfhdHfcNUh7biozDs0swJTzD3TlYjwYcDNsne
 IohKQmhTt8Vgp4n8wJDlWwgLpcrJfXS4upASLaTtPUOtmgL+Ar2Pt9CW0GlMn2H0XlMNiI2Jx
 ugEplPLz5nZH40LC04vwyCXp5nC8SBSxgPJbVwv06q1Mo/ca5B31W7nZ+KV/BV+JD0LLr+Iht
 GagYs8l01mr4v8S5deGV+4fEIDlZ4OiJZw+ukZA+cCxyX9g6moKkoo12A+cjIdoi0ztHNaWqy
 YmzKgg==



On 2023/11/22 07:44, David Sterba wrote:
> On Wed, Nov 22, 2023 at 07:07:10AM +1030, Qu Wenruo wrote:
>> On 2023/11/22 02:05, David Sterba wrote:
>>> On Tue, Nov 21, 2023 at 06:55:35AM +1030, Qu Wenruo wrote:
>>>>>> @@ -3562,6 +3563,14 @@ struct extent_buffer *alloc_extent_buffer(st=
ruct btrfs_fs_info *fs_info,
>>> No, what I say is that alloc_pages would be the fast path and
>>> optimization if there's enough memory, otherwise allocation page-by-pa=
ge
>>> would happen as a fallback in case of fragmentation.
>>
>> That's also my understanding.
>>
>> But the counter argument is still there, if you really think after some
>> uptime there would be no contig pages, then the fast path will never
>> trigger, and all fall back to page-by-page routine, thus defeating any
>> changes to introduce any patch like this one.
>
> Such state is not permanent and memory management tries to coalesce the
> freed pages under the costly order back to bigger chunks. So in a system
> under heavy load the fragmentation can become bad, we would be ready for
> that. It would have to be very bad luck for a long time not to be able
> to get any higher order allocation at all. The process stacks depend on
> contig allocations 16K, slabs are backed by 2x4K pages, it wouldn't be
> just us depending on that.

Great we can finally be on the same page.

>
>>> The idea is to try hard when allocating the extent buffers, with
>>> fallbacks and potentially slower code but with the same guarantees as
>>> now at least.
>>>
>>> But as it is now, alloc_pages can't be used as replacement due to how
>>> the pages are obtained, find_or_create_page(). Currently I don't see a
>>> way how to convince folios to allocate the full nodesize range (with a
>>> given order) and then get the individual pages.
>>
>> I'm doing a preparation to separate the memory allocation for metadata
>> page allocation.
>>
>> The current patch is to do the allocation first, then attach the new
>> pages to the address space of btree inode.
>>
>> By this, we can easily add new method of allocation, like trying higher
>> order folio first, if failed then page by page allocation.
>
> Right, that would work and probably be the easiest way how to switch to
> folios.
>
>> But unfortunately there is a big problem here, even if we can forget th=
e
>> argument on whether we can get contig pages after some uptime:
>>
>> - My local tests can still sometimes lockup due to some phantom locked
>>     pages
>
> I don't know how your patches do it, it could be that the page is not
> attached the same way as find_or_create_page/pagecache_get_page/__filema=
p_get_folio
> would do.

I'm doing the same filemap_add_folio() call, which is the final call of
all the above functions.
The tricky part is when there is already a page.
We need to lock the existing page, and do the existing eb detection etc.

My latest version seems to trigger very weird page count overflow.

Still debugging the various lock up/crashes though.

>
> So do you want this patch (adding the contig detection and eb::addr)
> applied?

I still want this patch to get merged, as it's really the first step for
the incoming higher order folio conversion.

Thanks,
Qu

