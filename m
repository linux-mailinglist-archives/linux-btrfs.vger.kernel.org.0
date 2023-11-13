Return-Path: <linux-btrfs+bounces-110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019D17EA44A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 21:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C0EB20AA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01A2420C;
	Mon, 13 Nov 2023 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WegM24Kb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252722F18
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 20:07:25 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66B2D72
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 12:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1699906040; x=1700510840; i=quwenruo.btrfs@gmx.com;
	bh=SE4HwzzMkZ/IZSY4U0a90gsf0vpmabs7V5ulwUiScbo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=WegM24KbghpC9M0j7hWbBUaTdVcsNqgdN34QCvL6ZN2B9aJGU4Y8PndPhoZlP4Dv
	 aamK9gN88uBOh17xeoQKK1Ln/SIBDD7IElYTP+gMwGmxULDxDISqB70kBjdL9SEuT
	 MHkCNaQDK/HE9047wJrz6i/+jNcUfnKj02myT7YjCQdvGJhujj73u5hL586qY3S59
	 0dAE/iy4BQVltyAU3ZN/fH51QvWRIN6RTqRU/JSZANu+BAMjDp0mg/WLVJ0FvPSYV
	 QzM5i+dvp2KA+3gaz4FubqTZ1K0sgQwVuWC70fz52Z7uvwrE+PYXeOwhGPZFuspXv
	 4am0ZQr0sfdb4y1CgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wuk-1qzLxD3gZA-005c5S; Mon, 13
 Nov 2023 21:07:20 +0100
Message-ID: <83b7280d-6396-45c2-aa5e-fcd1f6f44963@gmx.com>
Date: Tue, 14 Nov 2023 06:37:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
 <20231113174502.GX11264@twin.jikos.cz>
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
In-Reply-To: <20231113174502.GX11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MEQKjT+V3fo81e1P7nJycsEfob9kBaEWrv02Ea73CwCe+OF6pV9
 fciN+NGirpb0Mf4tpIf+Emyqxtj+xOomIbRVi5N+8NOiUhLoNYk7FDSOWS8FE5APiGJbJ1I
 Qk/XlpsihJQVFMcaIgDr7/h84Cm3sY1nZ4V95CF9uONQJkarey6cxVzf0Uo1fNARkfKN6OD
 8cNbC+Fo/EYChYFr399NQ==
UI-OutboundReport: notjunk:1;M01:P0:ymCBgWt/bmE=;ESEe+l6PtX3HrnkpfeUf11qtM2O
 GLiTtMH1yFfNHVGRibz8sZDvpco8vNKvOkLAFQFQQtRSXwAH8CGluYXzhdM7dFYeqhmL0RVoe
 k8HvElIAbANXl9Bl3HX8feTAMPD19ZYY7P7Ir5ylDHmiLmMuwSx8lkf4RAYoEer4ILmTTgywn
 Ux+00HqcFQn6lAPQi/aGkdIu7t0RQ/F4NCB37clTzAECXNoIG4cEeaulUPJf9NAt2YT/N3nOy
 ObH/ZhvanS4U9Zy42ZdESvNUbpb4iD9NcjIFCf9gZlgsFhJ621t2wZSbTemdDlTzbEcYU3l48
 lRw7cS+6hrzluWcaTJnF6lcc2RWvcR3nFydw9Hv/RLeC4IaEdmAKifiaGyLwX5Nh10j+akYO9
 SQTN6NG5n/6ek9iTxehzxrU1qHAwfc0+mzi3v5vhkJ68jfs1aIuvkYjiWpEcmPELVnsetxk8k
 hog+c2TEjP7IFQcnTwAZ4bsbYgHC03+tMn0+5Upt556RK7nmFywoMxZY6QjZxvyd8qVc8Rpqv
 ljq4GlOwVtgRuUK9GUqrGw6KIybvXT2VAA8eWdrPnWNzm0UaT82iWpIRtfu5jYmhOniezIx4I
 P6rP61kK5rPPX6fPhpknHgIsHj58UjOCffIro2FBr/QHU+e6tz346x7bQMvUCcoPPAlTIIKWM
 8jWsQ82ufwfBuS8ismw153b+VbVoqR9ReqKX9ghid0BhHLa6l9fNYxfkGFsGnA3xRZMQYDjYA
 +XFdie9IWN2jiB6Ip8btH/GM22OxNSRhrxuTeX9yuU8pzjjYdrh9y8g5ayFDP2cT9SrF28wek
 6HMFgX0TkrauU2/8VCy68D/tPWust7R9ESCG7hqJgX7d5TxNT5tkYKQr6eNS9aBZwpk8MYiQe
 KeqRs9S3MVkA3oyaQutKgHP7hLnSRIfcuXPHMz8Xw5xvF56ZYhKEXpxhI2S/PLFMw+d5ndanP
 +vHVRT/eBmUTcIcgn3Y7yEHdzqo=



On 2023/11/14 04:15, David Sterba wrote:
> On Thu, Nov 02, 2023 at 07:54:50AM +1030, Qu Wenruo wrote:
>> There is a feature request to add dmesg output when unmounting a btrfs.
>>
>> There are several alternative methods to do the same thing, but with
>> their problems:
>>
>> - Use eBPF to watch btrfs_put_super()/open_ctree()
>>    Not end user friendly, they have to dip their head into the source
>>    code.
>>
>> - Watch for /sys/fs/<uuid>/
>>    This is way more simpler, but still requires some simple device -> u=
uid
>>    lookups.
>>    And a script needs to use inotify to watch /sys/fs/.
>>
>> Compared to all these, directly outputting the information into dmesg
>> would be the most simple one, with both device and UUID included.
>>
>> And since we're here, also add the output when mounting a btrfs, to kee=
p
>> the dmesg paired.
>>
>> Now mounting a btrfs with all default mkfs options would look like this=
:
>>
>> [   81.906566] BTRFS info (device dm-8): mounting filesystem 633b5c16-a=
fe3-4b79-b195-138fe145e4f2
>> [   81.907494] BTRFS info (device dm-8): using crc32c (crc32c-intel) ch=
ecksum algorithm
>> [   81.908258] BTRFS info (device dm-8): using free space tree
>> [   81.912644] BTRFS info (device dm-8): auto enabling async discard
>> [   81.913277] BTRFS info (device dm-8): checking UUID tree
>> [   91.668256] BTRFS info (device dm-8): unmounting filesystem 633b5c16=
-afe3-4b79-b195-138fe145e4f2
>
> On a fresh look, I' suggest to write the messages like
>
> BTRFS info (...): first mount of filesystem UUID
> ...
> BTRFS info (...): last umount of filesystem UUID
>
> This is not for each mount so it's slightly confusing.
>
Sure, I'm totally fine to change the words.

Do I need to resend or the change is small enough to get updated in the
branch?

Thanks,
Qu

