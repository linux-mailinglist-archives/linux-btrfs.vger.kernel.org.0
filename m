Return-Path: <linux-btrfs+bounces-752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA268091FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 20:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9BB1C20A04
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 19:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5C5024A;
	Thu,  7 Dec 2023 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TbeaS6SH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371DB171F
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 11:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701979016; x=1702583816; i=quwenruo.btrfs@gmx.com;
	bh=4cxWDwn68GSq8c6RxZRPA8WPDZ+2oVp72co4sJdUGE8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TbeaS6SHtenxV+z5g3Jwura0YIi76VURdVszUTcO5NvIwThUPf35O2xkzOaIeVQW
	 pOJsrosgh69ZMo2Zha6HSph3Rg5HlwGooP8+lylBdwz4nTd+d8gEKLi45apopwUGy
	 LJz0049q874WIMJPy8QKXIie0R46vFXcgXimckfeeheDTYvhI51pT/pf0zqnMA5fc
	 rD98UoYlSAKn0QDUGvGT+y0vczGeEJwmFCJO79v2jET2lOIT83oPkDPpbycsO//OT
	 cAO/56DrkafmPklH7CzEhDf/EzbCD9RCDP0/y9sSco0D1RoOc7CO0UJVklbwcjYez
	 SKcrGCPOu0KqUPbt4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mj8qd-1rheyI2Nkb-00fCiX; Thu, 07
 Dec 2023 20:56:56 +0100
Message-ID: <d8cd0a73-9ea8-4990-bcbe-949ff9c8cad8@gmx.com>
Date: Fri, 8 Dec 2023 06:26:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: David Disseldorp <ddiss@suse.de>, linux-btrfs@vger.kernel.org
References: <20231205111329.6652-1-ddiss@suse.de>
 <19fc847b-7df6-41fc-ad52-f4e7f6d13201@suse.com>
 <20231207121537.GU2751@twin.jikos.cz>
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
In-Reply-To: <20231207121537.GU2751@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jY9hUNVsRLjN9mUp2tVPLD2NQxVGoeq+VXsPm4jUuYXvnX5UYb5
 mZYx0Pm9+/SuIPoSNerTtfaLy1VVMOvQ0gedqrJqfQKI4EdnkL/QYuoRsg9qrfJzAZTFyV0
 7m+zOi/mKv+T3bT8x1DltxahQFLN3IHSAHxlYWkkgTfCpN3vwoC6AcfXZRFXtQ4L8bRHkvt
 Sz9p12NpijrQHruy88pDA==
UI-OutboundReport: notjunk:1;M01:P0:3SVBxJi3P/M=;gb94Qe0lQ/p22WNQgSN0Re304/Y
 NW7bXCRaHlLqBzhXeiZKBN3rjdQf8WwCOIn4N1uiU+BEJ02DjOMwWR3PRqRAB1qeP5cqgQOpP
 ecziLkRHnNAzpkrDoUaiigf0nIxlX4B0KtJ57JFwDUWqGMI6gc8//X2F3gUruYzfPvEbzy7ux
 FUxkvgMQKbMsLHX33+9LEtNpSyQgca0i4X3JK7lmWaNyX+3JhntjKxW88BbV/ZiibsyhE9TYF
 lItg3DtMfOpeIFcvY1ufXEv67Pzd59sEmfxdzozyT1X+YMdkMHQ6fl6O+QRKfLkIzr1J5oU8p
 UBSUsj/MW4oK3YTIB9qDi9hESl02chqV2Snn9136XZ+Zz3Z2ijbBuv+rl++YGSFup8br6ts3X
 6AjpP1x7VYJWa+aGLbE8esap2o4LdKQ36OilkDTITPehqaY/sQm9g7uAJk1/rHYUyGCMvpFlf
 TAgYiiwTp3SkwoRSpY42CPFKhKgrQBmRVCNKfq03cu657ffoleGss9KoOgdtevzmPr93WSU9d
 7cKdSbV4ztc7P16mQkSYvgzbzdvDPylZZc3XBsv+IellYvXKFQ8yzEBMXX3HpduuFEUyCBJL7
 BqV8rh6Th/1Ql+T5sHH+MkLKa9qiKGCrT3Bl++Dbg3laJQFGkYjocAif5Nnxt8wEtW9eYP+Uo
 HrtbaSeu1Q8ApPh7T8LwGJqdOWBRlKjVCxVjXHyh8OTOAFlMK/URd+Tceyruh2UdNBIbqB2O/
 fP9kHXuSxESKIKp6PaR+4UvwtONpl2fIGO8u4Ih2XVH1U9Z1fSiP3+0vQ5hTfQ42hKlJHEovD
 8qvKx2JmH7v5c4LvQ1igzcL0kaWml8RfPnb7TWYtCZnEbNpFjnbgZruEUfdbdfIejbA+4Ui/B
 JWTI6adMysYUBDgYMigBm9ayuz+WMerkoMAPoOZeeM2HOa0wi093ZIHXJhax6wJrCs7u2xxQ1
 I74Ysr67j5B9aiA5jWvNyyhMQ1k=



On 2023/12/7 22:45, David Sterba wrote:
> On Thu, Dec 07, 2023 at 01:01:50PM +1030, Qu Wenruo wrote:
>>
>>
>> On 2023/12/5 21:43, David Disseldorp wrote:
>>> The @retptr parameter for memparse() is optional.
>>> btrfs_devinfo_scrub_speed_max_store() doesn't use it for any input
>>> validation, so the parameter can be dropped.
>>
>> To me, I believe it's better to completely get rid of memparse().
>>
>> As you already found out, some suffix, especially "e|E" can screw up th=
e
>> result.
>> E.g. "25e" would be interpreted as 25 with "e" as suffix, which is fine
>> according to the rule. (without prefix, the base is 10, so only "25" is
>> valid. Then the remaining part is interpreted as suffix).
>>
>> And since btrfs is not going to do pretty size output for sysfs (as mos=
t
>> sysfs is not directly for end users, and we need accurate output), to b=
e
>> consistent there isn't much need for suffix handling either.
>>
>> So can't we just replace memparse() with kstrtoull()?
>
> The value that can be read from the sysfs file is in bytes and it's so
> that applications do not need to interpret it, like multiplying with
> 1024. We'll probably never return the pretty values with suffixes in
> sysfs files.
>
> However, on the input side the suffixes are a convenience, setting to
> limit the throughput as '32m' is better than typing '32000000' and
> counting zeros or $((32*1024*1024)) or 33554432.
>
> This is why memparse is there and kstrtoull does not do that.

That suffix is causing confusion already, just check my "25e" case.
(It does not only lead to huge number, but also lead to incorrect value
even if we treat "e" as a suffix)

Furthermore, the convenience argument is not that strong, you won't
expect end users to do the change for a fs every time.
Thus it's mostly managed by a small script or some other tool.

In that case I don't think doing extra bash calculation is a big deal
anyway.

Thanks,
Qu

