Return-Path: <linux-btrfs+bounces-423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED627FC57C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 21:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF301B216FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720565B5DE;
	Tue, 28 Nov 2023 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eXZCOQFO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FCE19AC
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 12:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701203500; x=1701808300; i=quwenruo.btrfs@gmx.com;
	bh=nalpZcs5f539p7qKqlXSw2vaw2DMh98Er8IzH8J2YjQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=eXZCOQFOVo6jgM/KK37XAw+3vJ3vM67mskGerROUIf4NitlKsYo8HLFkFUFxxO/s
	 jjZKh0q3KX97EhNwDF9lvJJ3o5Zq9O+GUC5+1X+sNaBTnSxJ8mVM+dMmZ9OiF/2vw
	 jfHnAqoVQ1x6F8mDl97v7SCVV7F9Mgb0q46xWLbaCcCF69zE+r2nWYUPdNqgBkmul
	 o5x6PpECG3EQw3ltXkrbe3LLcUhkaWXeyX1Al44aaxltBoXMiMgp/t64wwZep4rmb
	 ubiU/RZZ12wrnPhJ6rXuWZAymujyAm55tiWQlyiRPhv5O5T5FxC3lbzGC6nzBpjMq
	 xKFBf7AQ+6ObOtUztQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1rBO8N3Ham-005aKq; Tue, 28
 Nov 2023 21:31:40 +0100
Message-ID: <adc6357c-2c7d-4a62-b49f-b0d8f59f6626@gmx.com>
Date: Wed, 29 Nov 2023 07:01:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] Enforce 4k sectorize by default for mkfs
Content-Language: en-US
To: Roman Mamedov <rm@romanrm.net>, Qu Wenruo <wqu@suse.com>
Cc: Hector Martin <marcan@marcan.st>, Josef Bacik <josef@toxicpanda.com>,
 Neal Gompa <neal@gompa.dev>,
 Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
 Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.cz>,
 Sven Peter <sven@svenpeter.dev>, Davide Cavalca <davide@cavalca.name>,
 Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
 Asahi Linux <asahi@lists.linux.dev>
References: <20231116160235.2708131-1-neal@gompa.dev>
 <20231127160705.GC2366036@perftesting>
 <fb78d997-cb99-4b98-8042-bdcdbff22b88@marcan.st>
 <f229058e-4f5d-4bd0-9016-41b133688443@suse.com> <20231129010913.295c0fa9@nvm>
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
In-Reply-To: <20231129010913.295c0fa9@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZEJPhwEXtL2FDRyD/fw2bAxjv0oDJftv4EBlCBZTU5Mg4U8kls
 8cye+KAydd6nk/gqqw0bfQRDShUIE5fs9TRTIiUH8AJ2YV4/FdyN+k8780+k+9fkPrNllYT
 927ZCFesvGt99YNJnNahZuVnQeFEUa9sS9wil+5Ws9vit/PkTRZyEnFd8fCDfl7L4lKadkz
 YVk6K/pv8mDWRG4leFZPg==
UI-OutboundReport: notjunk:1;M01:P0:DvUOtfvsQWw=;Y08afEn6lPGK2Pl9bUWM5KiieKg
 jaIGaRuFJUrJFG7HN3E/e6Wq4o6TzQxNv9l8Bmp6ETcynmpcCnYMjF38WCEOM7KJO8SbZVGYb
 jvP8bU9W3kG3p+XrN+G0XOhTnXXO9n24vUoD+hapQHSUOIEVGaHelFAA9Khb/WxfBF8KFZLfS
 TCnyg0G1d+CH84jBMJ5Jw7XG+YajbP3EJ8fOn2n1kOZuMa56PXRVhwIDJ03bJNBWh+186xwFU
 92wXnYjPhdaR/MVLaUkO2K2XNrw+ejLUXoFCqePM1ND3/FAU+4agJyYVh8m9idzmoubmsSG2j
 GrPih645JmEp8t0isjE5VP6Fhptlt7AvwkusucYcuIQLhD8R3cNyjQwvkFGdgl4LryWbFXx7J
 LrJvogEcCaQJ9n8/PO9MpB0XxBVsxtbV/hBrNSvZRJhG80ZsNpq/iDBEW71VRYis1lz435hnt
 nd73JJedqrBVTv50Fs8qs/HQUyuXQt1MhuYI9uZZvPEO8Rh7a43DYrLTLY67lRXCsdzl1RX0o
 0bNPsq/2LNEXfS1k0WjtNKVXRTkn/Ne2IT6pD4pyAb4P/C7ihBQoJAyX7sZK2zDdrgaJ2vMGw
 MYIYcLATzaNY4M95tMr+r0kqiMdIFGp+L+N6NdBQ16WCKVUrkNr2s7Mt6nR2m0/qduO0dFJDC
 xswEVg/0nYjmkWTMTNYm9Rq2LpmsKSZmM+u8XjXwUZnvAoWqsTGn0X73C9a1YG8YfZ+oNdL08
 NRojPVIJcA48vpQVRiarxWWB15BmPyEUOEaFIZy4nAVLIejbhl4C0UrKbiyltap53sX72SxWq
 hcve/q9UuatNcLeDXpdab5rWR1Pp05PKwD1afm/eQ0bUNT72C85c1QgW616WwOeIHoOBtyZJ6
 PXMRYHQkyuJUlDpmDYwHNjNa/pmHnFwgJK139sOr/KfeXk/iU50BDeKeP3Ik4Tz+8E98pqcdg
 6wJzubRFutQ5PtvIdeFusRVqP+c=



On 2023/11/29 06:39, Roman Mamedov wrote:
> On Wed, 29 Nov 2023 06:27:26 +1030
> Qu Wenruo <wqu@suse.com> wrote:
>
>>> Reminder that the Raspberry Pi 5 is also shipping with 16K pages by
>>> default now. The clock is ticking for an ever-growing stream of people
>>> upset that they can't mount/data-rescue/etc their rPi5 NAS disks from =
an
>>> x86 machine ;)
>>
>> As long as they are using 5.15+ kernel, they should be able to mount an=
d
>> use their RPI NAS with disks from x86 machines.
>
> Doesn't the subpage sectorsize featureset only support sectors less than=
 page
> size, not the other way round?

Well, if using the existing disks, it's really more common to let 16K
page size systems to mount 4K sector systems.

>
> "mkfs.btrfs -s 16K" fails to mount on 6.1.62:
>
> [1077897.120376] BTRFS error (device dm-22): sectorsize 16384 not yet su=
pported for page size 4096
> [1077897.120624] BTRFS error (device dm-22): superblock contains fatal e=
rrors
> [1077897.121394] BTRFS error (device dm-22): open_ctree failed
>

That's always the case.

Although with the recent folio changes, we may add support for
multi-page sectorsizes in the future.

Thanks,
Qu

