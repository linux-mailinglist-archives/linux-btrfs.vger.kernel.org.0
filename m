Return-Path: <linux-btrfs+bounces-456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53A57FFD3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 22:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BFCB2096F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2B55C18;
	Thu, 30 Nov 2023 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JGO1hB7F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A9170D
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 13:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701378298; x=1701983098; i=quwenruo.btrfs@gmx.com;
	bh=4qB500sCrLCWF8aSqANofWE6YhiWvWLE//oB3BEwD18=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JGO1hB7FQ12qMhebCj3o2hbD3oCeDvZDx4/TNPcEl4VS2JLgmpbtfB0T9ZHNCuj8
	 k0GzDEETHlRC9f7PtOsUCTikgDIr0/RDvLjqzje+CraB0zeJwj9pmi9XvlTC3K86J
	 E2g3DSwUoOtrHH6Xyt3Ouhp5bmEDWhiK00MBvA+c7Nb/auSuKft6xytPpATsfkZu+
	 uxV9JmY8SDOLJuFRAeBoPn/YVB/L64UxpwtHpTEPbnMhkJR7eQqHuFPt/fnSz+XKj
	 TnoJQDpeg9HEfRRHHYsLV44qp9BMuNUKlYBSMfbiOHScESKkeCYjfYOR6+7gpjy13
	 JPIvW0teHZLkgjS10A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeCtZ-1rjnjC2SoB-00bOZU; Thu, 30
 Nov 2023 22:04:58 +0100
Message-ID: <0895e527-84dc-481f-9413-71abcd0fdd03@gmx.com>
Date: Fri, 1 Dec 2023 07:34:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
To: Neal Gompa <ngompa13@gmail.com>
Cc: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
 <20231127163236.GF2366036@perftesting>
 <84df53e7-7034-4aba-a35a-143960d626a3@gmx.com>
 <20231129160217.GT18929@twin.jikos.cz>
 <9e8ba9d7-34b2-4918-a4e9-2aaa3464d9ee@gmx.com>
 <CAEg-Je_jRXoYY60Prf87S45Pzt4q6zDz53JaHT8XyPoG7OSMPg@mail.gmail.com>
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
In-Reply-To: <CAEg-Je_jRXoYY60Prf87S45Pzt4q6zDz53JaHT8XyPoG7OSMPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8kSaJJSIRc16rzcMMklWW+A+MzVp6e25gN/Ri3eEPvcJ9q8P973
 Vrab8kXg0TmqwJh6CaaX2L+1jh8I+hOb7FhKlNgSx3/bGhfkpFMzTloZ0pIUvusPmdER3iy
 7MH5OXDi+N3Ode7flH2tMTpQb/QI2ER6c+tRswknGGD0L6IvbzgBw5UtXuG3XTu9gBi/4L4
 NOeQZWUtzuBXXHS7jFNTg==
UI-OutboundReport: notjunk:1;M01:P0:u9uDE5HLkDU=;a88GnA4/zMF8kvAkkx6w9QeLVyk
 3UDITYUXv8IASLSPf/DeeBuuUHW7ccSkWw4y1daSxFT2hgyTY5KPkME5Y8efGKxPVgezHJJgc
 70bpMTZq0HLt2FE1SXK7uiIiuj6iWxeMIFqfAKR5N+DseS+tiqMVzvtqoK7FVyqoVV4kLbtaz
 j2Ua9m4tnhwgVhWgoy/GA3dJilsnyoSJDoVA6VCwcjUspvkvCc9mz6izlF4kpJMiKlq8U5MeB
 aWHZx411wYkoAYJA+Q/AXAesgQAuEVYbeXLhhnHrPiQvj3NoJr2zM9xoV+mA0qcNXZPrtEjnQ
 J8hKW62s2jb1Tr6JygL+3+D2MfkkguDm8bTn9/2kFySB+NXPa5SvH/10Y5V5JJ6Pd8djAbdQA
 7YpHkyBj5kwugtA7xnXgLemBciuN7gX0iR42cKdhuRVahB2aRJoNbLRUEZOiA4dN58uRsJ6+8
 nG8LGH5DHLQaArZF+2CYeg6Apij9M+JiGNPqnOLZ07ksGU5b0NpvOXvlrPANhkI2vJHM9RtR6
 fqmQ0njZl76/jeLCLwpNo6hOaS48nXN250H1+sgA4f5oKHOoLxXxDxwFXrmbO9ZhtiDHtA8nc
 vmyoUI8UnXM6ZpMrbOs0bGIjBsrKukiZQ2lRW+siTX3NuakcE2DBonwOZxhDfWyGswhZVGyce
 oLdfqMPrpC7BSk4O/1jdpKKP7b2iEEHWtPVyoBWAJKzDkaXGKbdisd9m6n6HOcDhRzKAJfqs8
 xDzSlJisk0xbL04jITjWRxkktEUlyMfHFV+skqdTNF/Yr4L/WOcH7mWB3XKy4ANmiia59vx8o
 bDT/ysMET9X+sCb8q2TcvIbwKX8VRAXGBrafoCWzYQwu1wIsO3SniGUU9Ropl0C6mArSNH0xX
 zPy0OK0P8e9kerqMgmKj+FD8QUVvX/wEFNzfDXVWKvmxvghc3naOZKltPM0BXM/uMwEor0TLd
 iGX2UOIDHbO5GNTB6Ot47fvO8Sk=



On 2023/11/30 22:49, Neal Gompa wrote:
> On Thu, Nov 30, 2023 at 1:56=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> On 2023/11/30 02:32, David Sterba wrote:
>>> On Tue, Nov 28, 2023 at 08:47:33AM +1030, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2023/11/28 03:02, Josef Bacik wrote:
>>>>> On Mon, Nov 27, 2023 at 08:48:45AM +1030, Qu Wenruo wrote:
>>>>>> For now extent_buffer::pages[] are still only accept single page
>>>>>> pointer, thus we can migrate to folios pretty easily.
>>>>>>
>>>>>> As for single page, page and folio are 1:1 mapped.
>>>>>>
>>>>>> This patch would just do the conversion from struct page to struct
>>>>>> folio, providing the first step to higher order folio in the future=
.
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>
>>>>> This doesn't apply to misc-next cleanly, so I can't do my normal rev=
iew, but
>>>>> just swapping us over to the folio stuff in name everywhere is a val=
uable first
>>>>> start.  I'd like to see this run through our testing infrastructure =
to make sure
>>>>> nothing got missed.  Once you can get it to apply cleanly somewhere =
and validate
>>>>> nothing weird got broken you can add
>>>>>
>>>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>>>>
>>>> Thanks, the failed apply is due to the fact that this relies on anoth=
er
>>>> patch: "btrfs: refactor alloc_extent_buffer() to allocate-then-attach
>>>> method".
>>>
>>> V3 of the patch has a comment from Josef, please send an update so I c=
an
>>> apply both patches and we can start testing the folio conversion.
>>>
>>
>> For the folio conversion, I'd like to add more cleanups, mostly related
>> to bio_add_page() -> bio_add_folio() and page flags conversion.
>>
>> Those are pretty safe as long as we're only using order 0 pages.
>>
>> But the more conversion I have done in this patch, the less I need to d=
o
>> in the final patch introducing the higher order folios.
>>
>
> With higher order folio support, will we be able to support blocksize

It's the first step towards multi-page sectorsize.

But not yet there. We need MM (filemap) layer to provide a way to only
allocate in certain folio size, which needs some API changes.

For now, we're working around it by doing the folio allocation all by
ourselves then attach them into the filemap, and still allow single page
allocation for metadata.

That would not be possible for data without the help from filemap codes.

Thanks,
Qu
>> pagesize?
>
>

