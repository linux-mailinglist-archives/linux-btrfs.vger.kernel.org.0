Return-Path: <linux-btrfs+bounces-316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C930D7F510C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 21:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD2C1C20B63
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A75C8E4;
	Wed, 22 Nov 2023 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GV5DyGVn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B1ED41
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 12:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700683440; x=1701288240; i=quwenruo.btrfs@gmx.com;
	bh=wAG6wGuAVTaeAxCYCUxVudyRsPTPGIDinLrzfAiQUGw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=GV5DyGVn7vfUGCnvmuq809brQK9QquqcEKV0JiVJN6H8zp995yJrKMIXaJuc5PxB
	 AH3EM4RDIrOBmC925NM9YnvgInjPruRRPeRfHzBsaTNiU4aSWWcE2dAGd9rOAjTLD
	 aa2GZFdsJ92+Cbou22jbcgh8ieQz/0LD23y4hoLvpG/vDaP+1Fsnu/MI/Ibe7NFNH
	 te5KA5IGRI5P/2eNFbH7NfVHe/Si0a6SvMTPYxnZTjtwtibWiOy0nss86zrY6gI5V
	 DfVKXXCHVJ8sSsvRbG6T+POvz1W+QgWrx9zahZwxN1sRh/zNFhS3C+B8f5g8CpTUM
	 Z8yP1kV9t3l9T8WPTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9dwd-1rR9Jl0mLV-015W75; Wed, 22
 Nov 2023 21:04:00 +0100
Message-ID: <71d723c9-8f36-4fd1-bea7-7d962da465e2@gmx.com>
Date: Thu, 23 Nov 2023 06:33:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: refactor alloc_extent_buffer() to
 allocate-then-attach method
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
 <20231122143815.GD11264@twin.jikos.cz>
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
In-Reply-To: <20231122143815.GD11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gADGZEXA3Bu3xSyNLsqOk4MKInr7VxzZJvp9buVLZo4XUe7RQ8f
 F6nSkWUG1OYIyMCeFfO/Ph8gG6R49F8mA7ceZm7chH1yBttNan7OMU5PoUcUvZNG7lLi9KO
 boIBjlbjtB1n3uNXyVuHeAkF5lY9sXA//AfvlIifiUH0qbmG/Gmd0Q05zuwBqq4/58nxZDI
 plR05VSApQSfdfyLNBPYA==
UI-OutboundReport: notjunk:1;M01:P0:mc6FR/sTbFE=;d8kpfiKiY1xdNBUcInym7AhFdqb
 ngwSFo0VUUw+gI2G5wtkV49PnbxBUMgTsgd1cbhO8197svEkn9gT/MyYvbUjX8DvxeHQqoWf+
 E9yb/7RcsVj5HPoPY25czawMK4uFe5+FUw8hwSAGUpu/dIyS78gqoQROAKd5NPtSflcjCwKDc
 hmli747DXIVyi+ZnM6VEY77/+ktLUBOlrhMoiesKW2wY9DWOD8PuaRArX0igK+7Efk4UnMiSQ
 A0iAxuvGAYUlHTPVlfmW0I30af61NEX1FFVDrA7YoBjEvmCl+Yf7EWVnHPXnG4M+Kt40vvsdZ
 s7Wmqnpdfsbyn1oM2VCtIMUdZFM/Dctv3iPepC7QGvIGx4KNAyPZMIs4RtNBoHJNqvjyqgRM6
 RjPATVQSCJWpO5Qn6918hX77DASs/wGcxyaMF3xRdaUoxi+69GIMnnBvfy90RPMgkdTXnKs6O
 7WPfSxYi15/H3p0OjF+c1XL10CpCVw3Jm927OkoQp2SkM4gTquQiP5+ksUyduP4HzIS23oc4L
 T9nDvChMf8MxsR0GKD2fuF5T2+zJaBstuZu018U97iPbkn2hXiddcRIetLJWZ3lLhEZNZfCNq
 h2WwupLch1X9g8alHz1BhO+RZ40uGLvQHZ1c77iLcAYv7YGIw38s0H/n19UnE5at/RaChFqVh
 pa6BezXjWYJRSSrUbFf1tOZm2vH4tIF7UXrmybFMoHQY3aT1Ri/UD6sOYNcyDhGi5CXsMwaEe
 V5kWTkCEllubD/2kC0eS4nY8M2I4+ZdPIE0WRMLVSOENMLqgNHDLGlGRq3ESz1emHo9GECfYU
 8GtJ0n8XytmP0JhG161qULi8zVe//vhHBcPSEcf7SEGaJDWh2b6zSAKh9keX/PZAWlnxuPKUm
 3Y2QcZpi/ap5EHTKaG2U/wQthawcRdD6AzBL1XkoffTl3xeqRkFeicxlFJVuC8uORas/kS9Pc
 k8gISMNtA+wXcxQqHKmsDXERa2M=



On 2023/11/23 01:08, David Sterba wrote:
> On Wed, Nov 22, 2023 at 10:05:04AM +1030, Qu Wenruo wrote:
>> -	for (i =3D 0; i < num_pages; i++, index++) {
>> -		p =3D find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
>> -		if (!p) {
>> -			exists =3D ERR_PTR(-ENOMEM);
>> -			btrfs_free_subpage(prealloc);
>> -			goto free_eb;
>> +	/* Alloc all pages. */
>> +	ret =3D btrfs_alloc_page_array(num_pages, eb->pages);
>
> This looks promising.  Assuming everything else works, this can be
> changed to do:
>
> - alloc_pages(order), the optimistic fast path, contig pages right from
>    the allocator, can fail
> - fall back to btrfs_alloc_page_array(), this fills the array with
>    order-0 pages, similar what we have now, they could be contiguous

Yep, that's the next step planned.

Although I'd prefer to fully migrate to folio interfaces, e.g.
eb::pages[] -> eb::folios[]

But that's not really a big deal considering under most cases
folio/pages are interchangeable.

>
> I wonder if we still can keep the __GFP_NOFAIL for the fallback
> allocation, it's there right now and seems to work on sysmtems under
> stress and does not cause random failures due to ENOMEM.
>
Oh, I forgot the __NOFAIL gfp flags, that's not hard to fix, just
re-introduce the gfp flags to btrfs_alloc_page_array().

Thanks,
Qu

