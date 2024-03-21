Return-Path: <linux-btrfs+bounces-3502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E73886187
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 21:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA511C2216A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322D134CD0;
	Thu, 21 Mar 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HqViL/1B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAA13442F
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052239; cv=none; b=jg9JOvJTmVWsZvayVq58pmY/AExpaoIxDDmw560qgqC0z7JYoI4nWb7SP/HpuPHcEOHXGPqbpjLTjvAZyDmuxq+whZTl4MOTOuFmuI5wIaOu28CVr3lrvO/4sSAfy6ZPNmhpOW7La6wcdb2O4qDoQ2Nby9KZFlyuXHeea8eQ6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052239; c=relaxed/simple;
	bh=Jaq0MSWU8sPahMDxU0UN8MUyla1AjzIz21GpkGwohr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tra94tj2rKpZxRKHUYDxwKWzj0LfloTBimSXAgndv8a3HipmZ1kizyJ3JW3LVSiqxSKOUqGd05jWNol6Fn6hyD91wfa2kIQuDkg5Jo2mo4oJspoCfDMRszvdLtOVg9nsxVltz5LNzsXcJy9ocWp5pL+xqty3UNXK8jJfofWJYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HqViL/1B; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711052233; x=1711657033; i=quwenruo.btrfs@gmx.com;
	bh=Jaq0MSWU8sPahMDxU0UN8MUyla1AjzIz21GpkGwohr4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=HqViL/1B93FZCHNXLcHxIR5Gd9FN0kGrFG7QXQMxhD8K35IfHIkP0FIJY/BBTG8N
	 EkEDJJ6Kv0xwiWoN6EsyKarcwwWwWX85WQYBLW/wg7fAj2ruwNnkw10wItTQ2Mp65
	 +liBxnz6CrMgwqgCn1LnFMIKdcW+sY1ydLjLc60IituZ9z1I/0627v9LNk70Y0WKR
	 5Uenh5klJD7sQxL3U5Ra6tDfalOsgTsq3nlNFTiUSXqVBaENZcQZAJolV3Y66hr+0
	 ic6MEG8aZpmbyJZGDwRh+chtm5MmttDzhB3fXwMJ/+3QczoeQ+5233dvAazw/fYvx
	 F8VZn8h/FZnlpOjI8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDj4-1rbtKg2pUk-00CfIX; Thu, 21
 Mar 2024 21:17:13 +0100
Message-ID: <88553d8e-81fd-4fe1-bd3d-d5244de162ba@gmx.com>
Date: Fri, 22 Mar 2024 06:47:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: reflink: disable cross-subvolume clone/dedupe
 for simple quota
Content-Language: en-US
To: David Disseldorp <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>
 <20240322002544.6904f696@echidna>
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
In-Reply-To: <20240322002544.6904f696@echidna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lfqtz+vy3cNAPGfUGhO/15gPCNZY42xZ4cEKSGgx/2o6ILWQzTI
 BOwfS8f6vVCZhAdr1NNOuMmHpFhqgfVzuMAmPoOp8Q9HuafZ/NN2p7BlgaU1XM2ke+S0+pA
 576buHUT/KsTCeu6qjMUyzNw1hP0OGPZnaBLD20REFyAuHEPg+Qdlj0dBf+KwCat8JNyysv
 dvd5ZzaiSSBTuv6RIvWYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3x6QA4e15q4=;KW1mQ0RpyIgzYDQ+hczujE+qKUO
 ZBnEOdFHVSuYVQtB6EGMo6gLhed4yjfrDBRgXEqq6boNq/dxbKcd7AN4Yr8o/3+qUpjz0SLMg
 NgAq0eSRzLdlHQQY65AWnNWaWptqrsVJFF/oXbSazeB3b10X1su3njaeTslr0VFpOLI7m5yN5
 d5IlgLDh7CU/JR+EFuqFz+IDlLnW5RHvYVLaJUZmopshQ9OadryuVj3+K8ydiKWEPQ11BMbpo
 v9iuAChJifmsyPMg4A7TgWLx9wyzLFuc9Iql48zYPjRLSvYomVVv9xnRqTcc3a2vyLy1k5WgS
 CzquMj9Gq4E2amT1kyFjiURM7YAqvgOc7ZwNRrDeJJqhKj4JHv9TvzFMGO6eNQ4Oa9MMPpgw/
 BC9cHIyEwhDLdQ+v/w3UIKa1jsmofVfZpVyDIagIe12Mh85cmw+hlmOzfSsvTgE4zmUSJtp6p
 aDbEkbh7mJSbtrW36BAPHVCkMf737lpuXFcuXV4xHl8QVXGpyPeHjLJB1icaK2AQbmY2vZMoF
 gXe8EVUns/4GB2cfAGx3B7AnwwSDcH9opCzIJaCn+a/dD9oa7IYgr039Zqs4Y8hQx72w1vbSg
 TmzGXWG604GCyDPaIPuAWwQpyeNet68mXlCkGmy/nZcjyz9a0bEcIGj3hA/SXGXYcNsmNmmIi
 EFpdtzK1s8Svdosq6sRUbQjIJ6vkUXvG9pZpwYuBHA3TPjW5n0pJDNGy5DQRTnGC8jp6qvNi+
 ebuYwVlEenFSQjqk2XDO9G2yBW/ur4i2rTjzY0lLfteHtOpK24P8X266lmXCHmjBNUtCAvsZI
 3AL1/k4VJsmiCwRqq5BNNwnYONdeFLXNc7RKBQoeM3d+Y=



=E5=9C=A8 2024/3/21 23:55, David Disseldorp =E5=86=99=E9=81=93:
> On Thu, 21 Mar 2024 14:09:38 +1030, Qu Wenruo wrote:
> ...
>> [REASON FOR RFC]
>> I'm not sure how important the cross-subvolume clone functionality is i=
n
>> real-world.
>>
>> But considering squota is mostly designed for container usage, in that
>> case disabling cross-subvolume clone should be completely fine.
>
> I think copy_file_range() is reasonably common nowadays, and this would
> impact such workloads. I don't find the creator-subvol-pays simple quota
> behaviour too confusing, so would vote too keep things as is.
>
> Cheers, David
>
OK, thanks for all the feedback.

Please drop this patch.

Thanks,
Qu

