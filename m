Return-Path: <linux-btrfs+bounces-534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E0801B07
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 07:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0191F21147
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627398C16;
	Sat,  2 Dec 2023 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Db7Are/T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713A7D40
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 22:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701499393; x=1702104193; i=quwenruo.btrfs@gmx.com;
	bh=r8WQmgtxaqo8zeHuuqa6RNQBm4hnVimqmAf/FC6oGb0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Db7Are/TPcLK1SMT+KNowBuJuAVv2zlOBzQad4DKcS/L1qWVtDrqf34jekXLFExb
	 ZK8Y8ZV9TZRgZsSaZesKnucMbdsE8BO3KqGLQR8l4yEm7Xo/bEXK7x23T5M1YoBXq
	 KNYTA4U1hK12yRwAXvyqeJ1OopbCXOuApWKhP2jIrWBqojrkH6HcGMKy2QXZKvxuV
	 yYw0dEvb/EimKqo0STFqQlsntOjVFhkw6aibobgcljGbTuMH+97rMsolfccLqv+/u
	 +5IGLEGhwI3PctdIFEkOHyrywXIL3jCmI8WPFQvZPRleBAPCXHe7rIv3BeQF/zK4a
	 6XL8XBVLPZQQe+w3OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvPJ-1qkGUn1ztd-00Rmq4; Sat, 02
 Dec 2023 07:43:13 +0100
Message-ID: <bae5e86b-d215-4984-95f2-4f24a8ee6bd9@gmx.com>
Date: Sat, 2 Dec 2023 17:13:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS corruption after conversion to block group tree
To: Russell Haley <yumpusamongus@gmail.com>, linux-btrfs@vger.kernel.org
References: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
 <e20c7d59-c460-4236-9771-9cb4a3f9dfb2@gmx.com>
 <1b32a750-d464-49f1-a288-577ee2fd473e@gmail.com>
 <bf4ee7ec-ab90-496c-9117-b13a096994a6@gmx.com>
 <3b55e499-791b-4f98-9ca3-0ff0a218c0bf@gmx.com>
 <8dac2b61-0a42-4416-9477-4cecc1b0eb06@gmail.com>
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
In-Reply-To: <8dac2b61-0a42-4416-9477-4cecc1b0eb06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BU6BMvm/CSQlyBU8LujFsAoaihW0392FuiLQZMyGJKBWYtCUp6A
 RHKqGgrZ/v021XTnx4MlnAOmN6b2rHeOiUFjbef3kVtoTRxdbchSbuLCDGvFKEwwhZ+FMB7
 +vxKI8DweHVA8Kz00UQW7Q7Qywt51NldAZKIBUcnLshYUF8KM6bjEquCiggDQ9TNZ5EsQzG
 0zHH7Yu8mnvgeDDQ2B9yA==
UI-OutboundReport: notjunk:1;M01:P0:qYWK/1nLPgA=;uYrBmrWCVliEEntJ/LB6Mhf8764
 mwEMeHxCsLoqDpeIly/rwu7H9NtQIxa6aD6xiJt1Bev9DY0HRtQh3RX3KR4TvRVXLS9A/9AfS
 ZKj7FgzcILfq46unENHYObsfGNCjw/wSgCZqf3rTU0X1YukNoi+7v5BlfuBG9gKBBZOP2ho8L
 n9QkC5XYMBAml5ZysLWzJtLoMu8qbjxTK86zf00UrrLzTSd0w8toNE9Dnzk0s0OoU0J+eAuEK
 anOYVUARL2TgAq773LVBDE40xUYn9mvyURNwOcUZWCfZkL3ccd03SKZBvqsjdTM4EQU4B/qwC
 4hYcZ57HdU3oZOrzOaZ8xTODOoKR1Lb3ds9oorRYuqjGkcyMr05nwMQnKmHDuFjarzZak75W+
 PLIwi3f0wA7+rUQkJxD+Wf0KDg0O9p0/RLaqVTCX1aLpAv6Ybs14C4OgeUaTsvE3UkKb9TBgI
 7fKX7NUWas9Zy+bWgMHrNQJsEeFwIgCHfE7yPBv0gHRcRogrQE6jss1yvO2pVHogGYNM+h9Xw
 GBpl5Xgkgrc1/lGL1l8l4oXWclgIcbtlynX0T4KvU6DfI9eVFrvHY7wCvECS6F3BtgV/bZqCv
 A8hNoSBNKSzbDXj+nNJQrQbpSOZUvMBr+fxnb9qoGc2669j/PyFFmJfvOUSsVzDQB873JiY8Z
 Tbl7joaPD25Bohync4seFdJ9Z5pw5YGKcGbWmJ3QdUHLfWFS/rckCttEVggO7qZEyvNNBRy0y
 mBzeH9WuiCbwjZa+6p/WAzq0UhXgGxhnZVFdHF1dMe0JPZClbkwcR7rxtf7KqcxmR0m76AVVO
 7WKu/3eNvTCt1DGN+FutTxqKYd2tGoBYfdJ6N9B4bpdJkKQaKC63wGC++LkVOryNzeh+155AF
 0D/o6QSgxNgKGULnUg7dZIe4eKFGr+SnxQlNG0Lx/3kzEdQxxWqEuZLum3s1RDjupg9xUfknw
 MMYSXKNcA97syq3lBQ1fN9AXpdY=



On 2023/12/2 16:43, Russell Haley wrote:
> To be clear, there is no reason to be suspicious of the other disk that
> was converted to block group tree and has passed a scrub after
> rebooting? It should be safe to mount that one read-write again?

Scrub is only checksum verification, no comprehensive extent tree
cross-check like `btrfs check`.

If we really screwed up the block group tree conversion, btrfs check
should be able to expose it.

Thus that's why I'm going to add "btrfs check" runs before and after
block group tree conversion.

Just remember, scrub is never as good as "btrfs check".

>
> On 12/1/23 22:25, Qu Wenruo wrote:> Just one more question, is there any
> hibernation/suspension involved in
>> this particular corruption?
>>
>> I have seen exactly such unexplainable writes-from-future cases, which =
a
>> lot of them have hibernation/suspension involved.
>> (Thus personally speaking, I never go hibernation/suspension on my own
>> devices)
>
> Neither of those, but the affected disk *is* set hdparm -B 128 -S 240,
> which is Advanced Power Management set to the lowest-power value that
> "doesn't permit spin-down", AND a 20 minute spin-down timeout. It's
> possible that this contradictory combination causes firmware
> misbehavior, but this configuration has been in place since late
> December 2021 and there were no problems for almost 2 years.
>
> Unfortunately my notes don't say exactly I combined no-spindown APM with
> a spindown timeout, but it does for sure result in the drives spinning
> down after the configured duration of complete idle. Judging by the data
> I gathered before making that decision, the reason was probably that
> APM<128 gave different spindown timeouts for my 4 assorted hard drives,
> and there was no way to discover the mapping of APM levels to timeout
> durations.
>
> Needless to say, I have reverted that configuration and will just live
> with the extra noise and $20/year.

Very hard to say if it's the firmware's fault, but it can also be our
fault on the bg tree conversion.

Anyway two reports are more than enough for us to enhance bg tree
conversion code.

Thanks,
Qu
>
> Thanks,
>
>   Russell Haley

