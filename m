Return-Path: <linux-btrfs+bounces-1077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE626819B6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 10:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F630284148
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B9E1F613;
	Wed, 20 Dec 2023 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TKxKyyQe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0221F5F4;
	Wed, 20 Dec 2023 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703064731; x=1703669531; i=quwenruo.btrfs@gmx.com;
	bh=RmcNpCoJv8JMDhdDtTD8JTG4zy09q5k4fiaUhfHwTpc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TKxKyyQexREmWCysAwBClFck41AihhdWaZazSqVWwTcWJ0DNuXqRmr1BHphvLjCs
	 puvdM0bef+K5oyJMSU4flJ+qM9E8S+gW/mbhwRnvFw/8+Ag6Af3ALH61SgXzBR9aN
	 L4dq1iIrICxNYAHJ7PpXyZdgvVM1rKdEsi5A38UbMg2yKIMvDuCB+ld/E86WO8yUP
	 gI5GQYdeDt4ys1UNJXQE73Wpg1bOpubbfMBJAdYZqeaMmWvBL4VAiv1+0CdZqnVql
	 /mbeTKkR4w4PBVGoBt56XnN2oSbAY+fcQVB4s50mmvRLcvLUHmfhY/Nd0tKParwAT
	 sPn0eVWm1IPP13nTaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([115.64.109.135]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDysm-1rPkJ41pxM-009wYK; Wed, 20
 Dec 2023 10:32:11 +0100
Message-ID: <ce40090c-f918-4239-8b98-40f3209e5044@gmx.com>
Date: Wed, 20 Dec 2023 20:02:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, 'David Disseldorp'
 <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1702628925.git.wqu@suse.com>
 <11da10b4d07bf472cd47410db65dc0e222d61e83.1702628925.git.wqu@suse.com>
 <20231218235946.32ab7a69@echidna>
 <8095c6ae5f8d412d8e6ff95707961a08@AcuMS.aculab.com>
 <4fbcab63-347f-4cef-ad35-686844c983ed@gmx.com>
 <3f8ee41745ac40e58e0aa535029e8751@AcuMS.aculab.com>
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
In-Reply-To: <3f8ee41745ac40e58e0aa535029e8751@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n9xSg9cZiYmNhQQFK6SDW5MlADcP1MBIqspeEBCjddohlHyXYeL
 WuoSWLS6rPFh1PMV8U23tu5XQdvjaPN3Id7VYrZzsEgfnrH76V1pgWRK+18v3cUyNN+sWG8
 7c7VTPIsVvgvK3uCqjoyHzpSiDi69X67hWJNL3B77T4d0zJGImueP663ddz8Va+FbbBqRjr
 4x8BdOn2WEEZcbPuwQ7Fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mdEFmaWL+Bc=;7ddx42WlRz3s+zTrgoZ+6rRzxFo
 Wrfr5TNxBIwfZ72puFbpWXsYrOx3eG0uviO92V4oyppcA8nBL4eDIkMltytn5KF9Ui4dWpg1v
 yvIdgTdnT4zu7xv1YWVHyEa6NIvPH5NaQdpzrZJu+kvsTh8CI2cvEeRAbjYXXeWytTJ7vlbiq
 2kYQh911GrXNlIdFXaZ34ZicKgyXJwF7w+YNBbpQVAkSVLnEApJOBojDfKzdGtwIRaESp7IFG
 aOaLrJ72V/GKejlZvwVTC5T2pwvGDXtvleFqVyYlrvi0vaDXXZqtIhoeNe1zX8Kt9iV0IKFrG
 TjrlEHpsR3OaPGyHQzrNPWg88MibWpXFfSWm6izRDxFFF71cJCWhi/NZcf41j9lFrbg9ESJtG
 siDMn23OR0V9I44XW/UGa5wiOwfoRAwu5qxx38KXOVEMk9lTq0lylWvI+3TqcKUktVglhX0ef
 Ah5H65pu6uzGi1J98SUaifPMdMt6H/qxkzANUKPT5rSckuDbiPvt3X3DVUIBlapxSZMGMheUJ
 Ziulqr5oLIcfz5QLZxrzb1gqz8pxgaeG/k+2Z55fsl66Fbmx67YauWpa5hR4rL8eBiYnXT1oe
 8rg8Xie4dNHhMPNQ2+t03uNSy4k05y03y0DDm6alaMr4KNNnWpt2CtjFlweJQnCIy/5ceGpHq
 iofhNnRpkjYGZ9GVIMKhK0jTci4tzCre+kZUsHtuO57ldBDWmHd0xtPfvDEZc1+JbC35MDYem
 tQQ3V0BadASQwO7yp7PEoAlUnNBtrWsZo/4+tDKgQ3KDTYl8iuH5vmA2APdmCF9tS2Xu5b6to
 b3qa7pursEgDzF01HFDSgZNfpoUsujsSStBBVHFvRU7pFsjsZGtUyGmEZBNBonL+UzlDY58E0
 UdS1UaOMA+a3tUvfp6jSZ7mIYg/3yHFaiGh9Ie72SdAHGAFujYp6cFe4ghPNNzDyZQMhVDGDo
 Fa91t3DKdsuSUUJ1k/PxLl1C+rU=



On 2023/12/20 19:01, David Laight wrote:
> From: Qu Wenruo
>> Sent: 19 December 2023 21:18
> ...
>>> How about:
>>> 	suffix =3D *endptr;
>>> 	if (!strchr(suffixes, suffix))
>>> 		return -ENIVAL;
>>> 	shift =3D strcspn("KkMmGgTtPp", suffix)/2 * 10 + 10;
>>
>> This means the caller has to provide the suffix string in this
>> particular order.
>
> No, The strchr() checks that the suffix is one the caller wanted.
> The strcspn() is against a fixed list - so the order can be
> selected to make the code shorter.

Ah, got it.
Although in that case, the 1st parameter should be ("KkMmGgTtPpEe"), as
we still support "Ee", just not by default.

Thanks,
Qu
>
> Actually strcspn() isn't the function you need.
> There might be a function like strchr() that returns a count
> but I can't remember its name and it may not be in kernel.
> You might have to write:
> 	shift =3D 0;
> 	for (const char *sfp =3D "KkMmGgTtPp"; suffix !=3D *sfp; sfp++, shift++=
) {
> 		if (!*sfp)
> 			return -EINVAL;
> 	}
> 	shift =3D shift/2 + 1 * 10;
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK=
1 1PT, UK
> Registration No: 1397386 (Wales)

