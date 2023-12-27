Return-Path: <linux-btrfs+bounces-1148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302B681F1DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 21:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FD61C225B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 20:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1212C47F65;
	Wed, 27 Dec 2023 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="F1ofzNPV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7AA47F53;
	Wed, 27 Dec 2023 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703708958; x=1704313758; i=quwenruo.btrfs@gmx.com;
	bh=coGxLO1xjfB+I0nXBEM3KYB+AYsCBtjhmWVIL1BxfDw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=F1ofzNPVVZziFXcc3OHlbk4dlhQy6FWPxnsQ/ScMjD0InyQCy1UQBUGIn102jJK1
	 e1+Dh8YP4uC3Y4GEjze7I/TKaDtCMrMXIR0slKslXvccQU3+Ydz7nMiMdwbSO5uQm
	 WezSGE/fUWmQCavFhkmOpsJrnljoCSbQApoP28r1XDOy1IffXV3wesV8kw/MW5P8t
	 kf91/T10Y0fx6e9FUxnaEYm//wjUUXkC8LYhEx1XeTycI1qSU1nX5+TZh6/EuYhuD
	 C6OBJgPFdU3j2GmvTLAzsYFN8+zKMqs7AasbJcOFU7RgIj/IjOGT6vQX05Ep8ZioA
	 SFKaWG/WmR4cJun9zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mg6Zq-1qkuzj39R8-00hbXY; Wed, 27
 Dec 2023 21:29:18 +0100
Message-ID: <291b8b6c-7421-4796-b283-46ac46ce3e36@gmx.com>
Date: Thu, 28 Dec 2023 06:59:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kstrtox: introduce a safer version of memparse()
To: David Disseldorp <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM
References: <cover.1703324146.git.wqu@suse.com>
 <7fd6e5cf2b7258c3c076334f443d5fee7b1086d6.1703324146.git.wqu@suse.com>
 <20231228002603.059bfb1c@echidna>
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
In-Reply-To: <20231228002603.059bfb1c@echidna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Kus+rPDU83mnij4glVIs3LjLXWKXPHFpN2JtBPvgw+o4lpGyYs
 bPF8KMZB75aI0hrEQAUuun8JLnTzID4XTgQMRwp/RH2gup+Wgx2GMIM1Kh0SO7IowSyOypZ
 hOicZNV57bFT+yvxW6uz01oo/omgmpbsV+qc0xzWL3mPbxnhrsQAxQXmamboZblfotE/nBb
 OvBDhPGtIW0UXYHDwDqSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Sjv25Gal26g=;hPCQtvjrNlb3LivY4L+q79oiyxY
 SBfxhKBWdfR/GtdLnTq7SywboumbImoZNptYco/okdo+vjV0qJOuKTIKSPBVpe4WwJHbiEREK
 BMqpZ0KCYHUVoBZj1h6I+B9Zd2SmC/EQHmABJOIzIgU9cLatVRuD1nh07VHWMA3DGei839KCP
 9hixctr5DaGHh+rkYNCFrb589oxhCFUwTouLvyR7FDKS3gU0bd9XAfcR2RDmHTNA9dD94Mf8H
 96LEIqSP3OYH4975XjWkbl4RC2jbaOCIdzB84vLh9Qcq2L+DSmrYWNgnNkR1PWEet4utfBVVi
 QCNWPhRQOtQt/Hck/wSKLM7NDtyTKvBs6+j6+vplKRPLgSweRAlQrVcs/O+NSHMBquTK0pN3k
 V6RfQuewSpiIWSaTYzlVCgT7yY5Yp6Q3pHwyq1eOa3jxMDRlJD+WTKpbdI4pMZr3TWJzl93I9
 s6Cq2zPkLl9KGo7xyIhktNhYd5mnjGnlZOcD1pX0tday6NxszHB/TYNap8zNM6NLMsIzmzcW2
 s6fDfmg2vRHL5hqyOSkISWRga4FGYOhaalR/7UqqpXmAE2AXzSo+5/y22aM+21QAfmItOZ+u3
 uZKcTMDxOYNq042RCnZEXk3hldjSRL2zoXxUIR7sgRJwRmnbsSEaoX+CBE2lMW4LUt7xKmpQs
 +EpHty/E5sPszRy0tV5l3Syg7ZXP73BuDatwjsEXUUCp8xdDjUT4TEtDnBqUFy1h20u+Pzbnb
 wc0sl/XcG11z6DYBKA8KRPzQBhRaLWMcWHqAod7zMvDfADUOB4iXoyERkDH+Ddsv/gHmOvple
 P2ZePxRGJ1f1PGcUr97bEDq1nzq4sUn9/i/PT/qKem13iZft1DN3Zepcg1q3jfkPcxUxUcmq+
 h7kL6jP+fyRqb81lOW9IW6OOdEajOjxyVLShEfQyXvVd4BY/PtdnAtisChhxhypJEU8NkSXpP
 ZAu56g==



On 2023/12/27 23:56, David Disseldorp wrote:
> On Sat, 23 Dec 2023 20:28:05 +1030, Qu Wenruo wrote:
>
>> +	s =3D _parse_integer_fixup_radix(s, &base);
>> +	rv =3D _parse_integer(s, base, &value);
>> +	if (rv & KSTRTOX_OVERFLOW)
>> +		return -ERANGE;
>> +	if (rv =3D=3D 0)
>> +		return -EINVAL;
>
> I was playing around with your unit tests and noticed that "0xG" didn't
> reach the expected rv =3D=3D 0 -> -EINVAL above. It seems that
> _parse_integer_fixup_radix() should handle 0x<non hex> differently, or
> at least step past any autodetected '0' octal prefix.

Yes, that's also the problem I hit, but I'm not 100% sure if changing
_parse_integer_fixup_radix() is safe for other call sites thus I didn't
put such test case here.

My initial failure cases includes things like "0x" which would still
return 0 is already a warning sign.

Thanks,
Qu
>
> Cheers, David
>

