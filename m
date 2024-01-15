Return-Path: <linux-btrfs+bounces-1457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295AF82E2B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 23:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59F01F22E08
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 22:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516DE1B7E1;
	Mon, 15 Jan 2024 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="g1eTzcvj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0A6FBB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jan 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705359062; x=1705963862; i=quwenruo.btrfs@gmx.com;
	bh=PF1bgRbag44r4vDa3Lx3HzX/gn3ltfO/ycOgULkWRt4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=g1eTzcvj8bCrnF4X5hHhbw4qn8s70198m/DvzpoZI+5g2SvV/SY86JJI72j36Jk0
	 VtqIn2s5/OH7O+j7i8l99Tnc2yBFMAKCGy5vAW5J9coJLMcd7C871ULio7PaUG6mj
	 TBt2EmdEBYgielS+qku8mfIXPxMtKIeXmoaQ+8+VFLW64700yYea4+C3TDEOeq3o1
	 Y1KC00nyPuFMEEALxUPf3YDV4O69Gqqn95qBWwQ1zzoQIyfTGNkGTIUSyuM24wa4S
	 6QylK/bA4uIqM7isz2aV6NhI0HrEqEzA1tWdYhEWur85Cypj94DPzY7vS8YLFz8Sy
	 /qG4KPXFF4LyH8Lp7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5G9t-1qxdDf0bcT-011Cz0; Mon, 15
 Jan 2024 23:51:02 +0100
Message-ID: <de82a8aa-7b51-4aa1-9cd6-a2f749a6e941@gmx.com>
Date: Tue, 16 Jan 2024 09:20:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: avoid use-after-free when chunk end is not
 64K aligned
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Qu Wenruo
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: Rongrong <i@rong.moe>
References: <8531c41848973ac60ca4e23e2c7a2a47c4b94881.1705313879.git.wqu@suse.com>
 <12744dd0-a56e-487e-b27d-4ad66498d7e5@wdc.com>
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
In-Reply-To: <12744dd0-a56e-487e-b27d-4ad66498d7e5@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SFx3GDNGL97MW4N2J3aljBhhk2h9qcHn4IYvgS2raS4B+UkdGr5
 5sHnUhCAzF1YuW4B1di++3nd/aI9M+Jp+D83bf+ITlJm8YhwuYe1xC8vF3dXes/xSHzrj5C
 4+ygEBMfdDvGXDvVeKYJzBzZjtjI8rwQ8ELqhQe1GjgSSvxDEwXhsQ7CmDOySPT16tWTieI
 mdE575gn0Zh1u87yZCuPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u3zp7IECfpk=;/nx30j+Ej7l7pddMa/WSkwPWO5f
 68ISSHsx4HQWNCQMAegtnJWdkEiQ1Kw3Oc0xRae3ge0YZzGywaNlX+4U0ZLdyjL6jgfE/lBch
 wP0At9H3xOXyFcmWKXTlbZIZhbIckOe1tG1tnNuAsiMu71JtX/5/gaNqZ8CPdh1Bk/wGkYJyw
 m4/aOQE9mxtvE/cS3oNgd43mbwCYxI9iCXgoQ8hJJ20unvSE6eT4HOlTDXUWbEQO6H5dQj4M7
 uuZEkkQ9lQsI3MWhJCaXz1SGt1GdlFHjj/+51YNnLfWPxM1QpKZZy/YTwpP5+MfAuuz0Uieje
 xxByBZrwlLYXVGzT1CBmop0vZB9DyyNu43UO9DMGToKhWJyIAY9V4Ik2kIh3X1d+y0cN3Gs3o
 0yoIggZBYph6BQcQ+iTrMFox4EHX50Rk0coEYJuojU7I4yP14hUYIoIwAINkSpoRsdqzReSG9
 4gphkv0NMHcEBbHZcd4ZrQYE7rfbcsptgacorIBKBQR1syfJsweaUZaVC6ahGcf30f1OGFLH4
 qrXSxqSlcQpp+LsdshOD9N3TU4BoIfcQqB8vtLuZSQRX9BUWVeJiUe2EvSh9krn5zw1ZKAEeg
 /g0Ak2zQZNvdwkeSOTYAXkoOQ1d/P5PT6fqMKvz9DmQqEXmLZozqe4wOTIk33YhDgM+fy9xkx
 /sDxBvl6hq+ssITMCAeo4BqREX0F0taI4VZJjh06uboxKi7VVQWoJuh1IYBKZuiVn3H2TPzMp
 d2dAGY03+nLcLGiTNfCMqPazS8HKnn+SmbCVfIaSIyRC1HuGPYYuwRMFykURz1kzjxmMSMkuA
 MK39a+7HVr7/LH9Y/MS1hTm3UqiifThOuaMHTllKVxK57S18/xrLv7eIuI9yC2l5+0F+anryH
 NqD1z8op+eSQJufTGEjEYc3T5ZU77M3IsjAf1E6Lvbvuad+BBcwTCRvOf7m//lxiausGrkYYe
 PGazWA==



On 2024/1/15 22:39, Johannes Thumshirn wrote:
[...]
>
>> - Make sure scrub_submit_initial_read() only to read the chunk range
>>     This is done by calculating the real number of sectors we need to
>>     read, and add sector-by-sector to the bio.
>
> Why can't you do it the same way the RST version does it by checking the
> extent_sector_bitmap and then add sector-by-sector from it?

Sure, we can, although the whole new scrub code is before RST, and at
that time, the whole 64K read behavior is considered as a better option,
as it reduces the IOPS for a fragmented stripe.

And initially to make the code much simpler, but it turns out that the
"simpler" code is also less robust, requiring very strict never-be-split
condition, and finally leading to the bug.

Thanks,
Qu

