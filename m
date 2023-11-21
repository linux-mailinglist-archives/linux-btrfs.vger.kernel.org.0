Return-Path: <linux-btrfs+bounces-268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7467F3798
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 21:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557F2B21658
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2465577C;
	Tue, 21 Nov 2023 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mKH7qOW6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C49D
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 12:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700599035; x=1701203835; i=quwenruo.btrfs@gmx.com;
	bh=lJuEGXdC87S4Oo/Zk1TqhEEEZ6Gg5NnaJdYAP3JQKyE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=mKH7qOW6nGf5TBnoGYB4QvRrAIfOPAZJzqbIN4Fm0/oDYnBs2J0AAuc9czcQkHFU
	 TTCNmA4dAnTfmJq5qJNgN5U4S5HQGTcJvVJMlhwBdW3jvhnW+Usjkp/bFIgcOx5Eq
	 z1sf3hjcVSt4lemOk9qJ0kZx1ymLmCAshyK0oBkKWgvN2ZYEFuErNab8o5j71Iw4J
	 UYLikynE9sa+kjGEXrqLjUAGetdnsauIHpqUp70Tpwbx/wgN+7u/PBxHMbRjzCjs5
	 0C8zDkjTj+Yrp8csMK8tn+JMtHxwC7jeaPNdDOtOit/hOTJmgg7P38VUfK1aTMNPG
	 mVSxfeT1sz93EbRpeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel7v-1rdUnm0piH-00aqNr; Tue, 21
 Nov 2023 21:37:15 +0100
Message-ID: <1b63c587-c2c5-44d5-bbc3-5facc34f5361@gmx.com>
Date: Wed, 22 Nov 2023 07:07:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip cross-page
 handling
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231120170015.GM11264@twin.jikos.cz>
 <a73faeae-1925-4894-9512-7a049ff8353b@gmx.com>
 <20231121153529.GS11264@twin.jikos.cz>
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
In-Reply-To: <20231121153529.GS11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SHWeh54xPaXRLIKOM452OqUm1leimcue3F+LuOGmmhnlbUVySJp
 nVKuCS/xxg+qlae0Xl16PKUZnYeOZMyA+vn/Qyqqfg7MsRaEf12OW8/6xGq64CJaMkwFaV7
 1Wo7MxlTLwOYTiVAqGdyJa/3Y1jYJDHce68RLkW1cJN9tRtrC3lfGA+hsDW5luQaU5XLGSH
 9dV6oi3lrbS0upw4rRSww==
UI-OutboundReport: notjunk:1;M01:P0:7v7OG2ZXydk=;bjETbUBuNvAdFfvgwcaxJnwPi/V
 qHdPjYxOAy0zSDh83ru21YJucI7mz5Ho3h73UgwH04WO+dStQHeVxpGNj7NRXW6F9zbVBbGg0
 rYgcmP0AjtnCrmMsQ/kEk6R14tapagoiSItwH3U2103p7EmXJUt9XOlaQd3Sa+RaZZbggfU8R
 D+WSDvOoD98ph9l/zbFuyLkieHk8OQn5U8oZhHGfQxPeThoTevtTtmmpfLIQ4UQgj+ejGVG5v
 2GEBR+RPnGKyT0vHcmY1yw/Tt6DeeMEH5IzN8m0K4ErwrV5i1ePoPn+InIPqDar9i1MNZYHGY
 bX5NZnRhD2LBqqmXapRwRqkeGW6pFroOKYYFJbI31BVHrh1BNGp79Vy45/rHNU66M0x79XICz
 LpgwX+klIgMSU5csKo4CYayZEt7euZRfa+07CtOTmRXYy86dS2LChF9rf7dLgo1AH8u9jg6KP
 8voeLV5y+bvBsgHjTauxTG8yZTsOkDPXdRE5kP4IuMLp0lHY2NamueTGBPozXCgC9Zix973Be
 AEuySEfzCS8H2+krJ72DJyV/wTiiwyJQ+iVonTFNESgp/vGy+VG1596rOs2CcUoJ5qFRLScgr
 ZQ8/ThgmX4O5hCUVToxZLUerVE6LujJUu28TW9+vpALryCjWmRWZiUjE0NvRwCVOwz5BBQ8yz
 Df8XlJyOOn+erIYh0KyF47SKtcDJa+zE52Eik0ebURDpy/hNMpgA1o9Pvs7w3oz7Ei9yFWci4
 Cazd/5xEngDaMH85jvs+pquvIZPGEw3R2CQbPZ0zNCj7qv9F/LAbCP1RuQuZ0MsR6zShIxFOq
 blP3kOzZ5G3sbff1/h9oK7dSy9+4fFOdD6zgOVowUfnTpayvdsDNw1OzWyDpD8cuo54pyKjXx
 +S1JTgDaZVUohJy13WtZbdyZkRV4NjrrrmTT+XeG5vfCKqiw+OP2DYeaZh9tbCqD2WxSUIFRc
 A+y4kR7VUTS0mUjzbE7aED77Z0s=



On 2023/11/22 02:05, David Sterba wrote:
> On Tue, Nov 21, 2023 at 06:55:35AM +1030, Qu Wenruo wrote:
>>>> @@ -3562,6 +3563,14 @@ struct extent_buffer *alloc_extent_buffer(stru=
ct btrfs_fs_info *fs_info,
>>>>
>>>>    		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
>>>>    		eb->pages[i] =3D p;
>>>> +
>>>> +		/*
>>>> +		 * Check if the current page is physically contiguous with previou=
s eb
>>>> +		 * page.
>>>> +		 */
>>>> +		if (i && eb->pages[i - 1] + 1 !=3D p)
>>>> +			page_contig =3D false;
>>>
>>> This hasn't been fixed from last time, this has almost zero chance to
>>> succeed once the system is up for some time.
>>
>> I have the same counter argument as the last time.
>>
>> If so, transparent huge page should not work, thus I strongly doubt
>> about above statement.
>>
>>> Page addresses returned
>>> from allocator are random. What I was suggesting is to use alloc_page(=
)
>>> with the given order (16K pages are 2).
>>
>> Nope, this patch is not intended to do that at all.
>>
>> This is just the preparation for the incoming changes.
>> In fact alloc_page() with order needs more than those changes, it would
>> only come after all the preparation, including:
>>
>> - Change how we allocate  pages for eb
>>     It has to go allocation in one-go, then attaching those pages to
>>     filemap.
>>
>> - Extra changes to how concurrent eb allocation
>>
>> - Folio flags related changes
>>     Remember a lot of folio flags are not applied to all its pages.
>>
>>>
>>> This works for all eb sizes we need, the prolematic one could be for 6=
4K
>>> because this is order 4 and PAGE_ALLOC_COSTLY_ORDER is 3, so this woul=
d
>>> cost more on the MM side. But who uses 64K node size on x8_64.
>>
>> As long as you still want per-page allocation as fallback, this patch
>> itself is still required.
>>
>> All the higher order allocation is only going to be an optimization or
>> fast path.
>>
>> Furthermore, I found this suggestion is conflicting with your previous
>> statement on contig pages.
>> If you say the system can no longer provides contig pages after some
>> uptime, then all above higher order page allocation should all fail.
>
> No, what I say is that alloc_pages would be the fast path and
> optimization if there's enough memory, otherwise allocation page-by-page
> would happen as a fallback in case of fragmentation.

That's also my understanding.

But the counter argument is still there, if you really think after some
uptime there would be no contig pages, then the fast path will never
trigger, and all fall back to page-by-page routine, thus defeating any
changes to introduce any patch like this one.

>
> The idea is to try hard when allocating the extent buffers, with
> fallbacks and potentially slower code but with the same guarantees as
> now at least.
>
> But as it is now, alloc_pages can't be used as replacement due to how
> the pages are obtained, find_or_create_page(). Currently I don't see a
> way how to convince folios to allocate the full nodesize range (with a
> given order) and then get the individual pages.

I'm doing a preparation to separate the memory allocation for metadata
page allocation.

The current patch is to do the allocation first, then attach the new
pages to the address space of btree inode.

By this, we can easily add new method of allocation, like trying higher
order folio first, if failed then page by page allocation.

But unfortunately there is a big problem here, even if we can forget the
argument on whether we can get contig pages after some uptime:

- My local tests can still sometimes lockup due to some phantom locked
   pages

Thanks,
Qu
>
> Roughly like that in alloc_extent_buffer():
>
> +       fgp_flags =3D fgf_set_order(fs_info->nodesize);
> +       fgp_flags |=3D FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
> +       eb_folio =3D __filemap_get_folio(mapping, index, fgp_flags, GFP_=
NOFS | __GFP_NOFAIL);
>
> 	for (i =3D 0; i < num_pages; i++, index++) {
> -               p =3D find_or_create_page(mapping, index, GFP_NOFS|__GFP=
_NOFAIL);
> +               p =3D folio_file_page(eb_folio, index);
>
> fgf_set_order() does not guarantee the order, it's just a hint so I
> guess we'll have to do full conversion to folios.
>
> As an intermediate step we can take your patch with the contig
> heuristic.

