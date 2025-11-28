Return-Path: <linux-btrfs+bounces-19420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BF7C931E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 21:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA8BD34D022
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACF62D47E9;
	Fri, 28 Nov 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eoYfAM6b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB425487C
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764361951; cv=none; b=D8K3NvKppMP00bsiAEbziVFKxTn2OAyb8XDVEIx/nmKURoEa7RgVEE/nWb11zjO+S6rVdU0Nfh9gTG7F8ElwBOaih3UaxemauZoYoykCFNSVbQXelj2Y0HZL6WWz2mkQeo05Jf89nLOOUupyymJW/d3LPrdXEoQc2Is39t20rgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764361951; c=relaxed/simple;
	bh=JNad8aZo9aNRX9Wc+64aXHRQT26aX0WGOJm+LMIaleY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+IcMMpa/5BHhAXUMRnqeOK4o6C2LMN1xasO6kn4WsWnqTshyF4V8/HGpixRyojUffEEm/d8btdy1jXN0Ns3FlMNR3Bv9ab+6RnQn3N1ITvngYbCLyOWt+6URxwf97P3TjCjIShXO1vilG5HxROB3XG0MY6RMJf3eNMt9BZ2ll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=eoYfAM6b; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764361946; x=1764966746; i=quwenruo.btrfs@gmx.com;
	bh=3xIvfv4Z7FzqhUl/IhQLch2dCsOluVw/Dk/VdkUspoo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eoYfAM6bAxVqPxjxouU0wHjDwr7ULm9h5rkQQ/k0VzRRZsSeSXGegAgr0IyPVftc
	 wuY8EVQqdmo0DMZxUBzsGzRBezGwehi/nEubQnU14twhsDL4MiUw/hmzwUfbXUYCh
	 HEN4ia2AFkGvvTr/C+Ul7Clpx+tkO49JH3fvq0g4V2w7cbbCekX2mMWMu20euRmzC
	 O4anmHvbw+Yv1Y1JTjuoFpRjh+BhCbI8USZSzcjq57+6Do/kcpDY4t9rKoxPLhrXp
	 AaSt8egG0fA5+HAbdTmJ5WYZ8Fu06SuMel1jWlpKdbUUy7KbwPXwchDY3/3mDv4hW
	 9Kqbo4g/GGClRla64Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6ux-1vrbKk3PIJ-00b5bW; Fri, 28
 Nov 2025 21:32:26 +0100
Message-ID: <b9f84c46-998a-4f45-a78c-fa501b24e912@gmx.com>
Date: Sat, 29 Nov 2025 07:02:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mkfs.btrfs reproducibility
To: Calvin Owens <calvin@wbinvd.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <0ff47dc5-cf0d-4b5a-8d84-f309a74cbf32@gmail.com>
 <9194ad3f-183d-46e9-afc3-b52ab2bf28cb@suse.com>
 <fa8d6257-649b-4de1-b723-64cbc34c0a7f@gmail.com>
 <3247ee84-5a0d-4561-8d25-b1b8e180215a@gmx.com>
 <14681d38-fbdf-4ac2-93fa-7eba21588930@gmail.com>
 <0b099290-03bf-4a1d-8411-716f78058586@gmx.com>
 <aSnkiEKGUon3pqa9@mozart.vkv.me>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <aSnkiEKGUon3pqa9@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QJJPUlbWU7TpCLp5m1VAfu9vvYkAX40je39TKngyWWVlljiZtH7
 oFM62fzfkWID1+5Ig7yvnkGux5Euycdv7U4uxezBjC9isSo0pkZe1hUQDsESThRS1pndrtA
 SzbLcnYp2VPOFLsQABytwcvDmj6Yh4SHmBMNVWSjlE9NGAPHvWkYA/KodsbOy2JHIQoEd+C
 XVXnDof8KlcLMKm309NUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3tutVNIfwDs=;8EGfKmqGR5TfVx1ZNsUPCwmgdNk
 cQcJEv+8Rqa00HmcBz1MpvX2C6FoFm2uN61Zb+7je9+HaicFckiAyRafxv8OQRDJ3SytvJvfW
 nPigLuAEGrWXBVmA/Y4JOEBoa4PNqsNEWwH2wVnfnz42zmA6iNxa9ynn6HTewmUj/qlPyAsRl
 Wx/a9edxG/3+eyrq48gV0kQLhowDiM8dzvLGSVbjveVeRFu61VTq6dJ9SijkGtHpQchMHZKrg
 yR4+BpgoQMX/gcIpKpK4AubfhVR+NrZKxCF5TRIr0uKXnSnFvV/7+1kD5tIftjvx368dYXc5j
 KUgY6MDf5ERIU7BJz8ysbcEED2wSzQO0aovGjGgM2/Qe29LwDfs7rbTkZzab0MYaZcVWujsGy
 3jfm2Jcv+d3732mvH1WFuOklA4pFncEIMft4IPSBRbr2OxCvLbzmZiTCeY1HRM5BTGuG05jKt
 IDZXL3DFcCZCItSUSFiYOqTWx9pMQL3iOcQzJV4+wDL/eh8GjB3LzRSeYS36ry113xnkLtRZB
 /AlCujvpVmpwX8PCFcoevk4BRlI03FUNIdLv5iVah+/O9VKah9apmfSK44mUGhhJhuywJEXD4
 Kcz8jdx9ATJVAMSKRmWvqqMkCTJ1BnQCQEa9CYvXPbB8cMdMQ9yVUFYP5TIr0KndaC2liZbes
 UwejURidFKEZWT1DIi6KUTI7cqgmqjwpTKV3bcSn3PJ71VVex93RhM45DiJy7HEmrfcw5qLTb
 6NYeXwci3GUhAezTW8uD7NMqYfFhINU2P2KlxLVUgsgjkTc3XOa9aTCz9l1Bszn2815wwXtda
 Y0iPDCAV7Hd655i8DSWxC28PkEhBTyRp14UZdNiB/jF6MZdJHGLkzI+FfHZJ8dcHwbYN26mTK
 b/5Ipia1yFJnySU9KQVbdZcuE9H0rTQEriQh3y2yALLrt1iHQZim1+nakiXZfVvCm/rOrSuPR
 Jh0+wKrasckCh7JTG5tCIzdxT7dSXij/bqJSSa1P4C9KUZIPzik5VCSHnnlNpLZqhv02aax2F
 /4OA549ErFgBQqnErIpIgDYA+kTlVhTOqen34VsIjnTt0w5oRg09Pv+XI5CUXpkMnVxQIPqgt
 K/thUVisV7G9qiO1jljZ1g7SsLpI7oFCRwaXb6PUZO3cSZM8q+br/4yvA2bs+zTBfAIjjru1G
 BQOOBQYKb7d/7VPBAqwiUnFmE9kfbvCmGCLRw5tFJ/R2ElFDOolG0yFQj9ktR7uvc9mXEEvIP
 0G8n0X2c0twqkjUPZ8T/V4C6dcvctgZc9K++uTguYRadyAfGWPE6QHY62nzXTiMgk+Q1IuBOV
 k/NQOweWzAHL5EKvu09rBIPTUOnHy7HRGPGFy/OJABFd9eWE33MsFf62Fms65/lwnicK38Dfi
 x5kUHvxl7s7BKPNYsd49sH+u3Xjb9hXLpdfA5BsZtbKOVhBmSYhEG6PbuKKLWTRY2I/HPMq53
 B2B/DDHeLE15Yt8cNZjZ3UxhEvIe6U/Q809+PrEogIMTcZxtRR6BIKPVUcuPgFQIAuviVuX3W
 dkREpmilWI9hc5xVQpJVTP1Ctv1urHElM1LlsURd8bqGDAip0UNsyd6TvbvDnN+a+QHuCfVvN
 3oaRLbJU5eYg0k6mYDLq8zQQMTM21+xGNkINYo5o26dh15NoveglPWOobCfVsK8ouYmYDU1+M
 g9iFo2XPXUPB3o/n43B24NKT/jpgJ1JSoAd4soDijf2N7JstolGucpz3tScPyZfG/aRFpkGV8
 eUoB+HykzX053/a7K5hB+7UNDHURxRJvEijwO5rJpCGYjq70oo3rbtq17Onm2sAG8PXmOGobT
 /bMb2Tw+oBNXStx/bXivk08udfdO8k4Mme0Dfo7Ic5BB/9CdJErucgH97Ph9hSx9aRDKvgQwi
 7tOBKGVeybj85HstL4VDijpYGyaBnoUNPEFeoeY590Oeb2FTPhyIa5qqpvqtxIov7+el2xZvO
 pljxKLrecFdg2zDLPG+uYZo+/v/PxLsnZvvRPyLLJ7SWfUh2sg9ZXKk+C3fhHJDZbf6z4cf5z
 Wi1Mrn6a4+Uut0BO/M3EkZfy5dZQJ2EIa0T1yus9uLmYkK2fVg1IQ65Lkl3dZ96BZnBLD801z
 t+ZyQBjQEfmCuppCI00JzuEiuKnvAu2LoXlIWKZUNegc8U6mExebx4d/Plw9LkMIOT5ourFZK
 DoHqz03AbAYgdcpzlsp7zaIPlCnXsuuQl9a7Q2dDPx8c1oqmUqpoteSol6cAoHAIKKAYBJ8bL
 EfvMoiwP5IqIErupKrWf8deq06LeJii0rG2bh6UvX5VHJZfnvpuE4zcYDMb0zUNJeP4Jcw7aH
 I7IfhzhhPxMKGZJCoPVvAir2fQcUwDEOBomsylkQ+7hzdOACDtUbK6hJx4pg+8mgINnmVehaK
 xWPK/65IHGxo1G8ZVe7R534e91wJpNlu/Gs3uqv1XLweWNe27/EQkAxiBVslS+VKqnFzTERoL
 nIzm6kwiH7py9Nw4tScsAPWPJ295MQwDc1czQo2NTAe56v0EoSD3+0Zv6QpHBUNFPNEzEltmk
 JRpIzbYhJrb5OdF2kglomo7Pg9GKlwDtgedyk3gvI8vt7Tb8AWJwHXPmxNvIan9/0IWavlQNi
 l4mkTtBvRnB5JFviPulrBBfABGrsayczUmylwnt17M+mjazIXc4Qvgnvteww8K7Cy0pLkIJMu
 Ayp4IKg3hiYgy7DWTJ6HfdVXpbhtl1GHFBrkofU+ao8MoRwJXhWwrkLLcHOelKqWLQZDkPvmG
 2pQ3k8T65fgETnqPu8vkKCO8bA3AgT2enThEoKWojrVFmpodI7ueFA2DSji0uvi5qI22Af6XY
 dlGVNGviaYyTZfHUQrc0zEwOE2S4JkuHtKPPnAca9gt1lqfCrLovA6bUcXbZZ57N4TYf5NGK2
 oLz8Ylv103RTQeHxg7Zly7GQEM2053b93Hedrhcw8bMCfckANUrmY1cu6H/5awmXg61nbKKOU
 uF6dQYUr1rR5LBa6y7Lvg2DjvKjEIvJDEfCtYvZd721atjR9tjDGALGjbxBEPzfeoBeY5dMm0
 F1duZLSQMXzgllmsjYlfDA1dJkvokWwYUNKzQXNXa6Y+GvrHfRbiWIj2c6eEzbnZA0WrXiFdd
 hL8JGTBJO2NTc5fpRDAbtdVS0/P2axVlf34+/rqro5tUraKfOMYv4dNFzg/riDd7zWt9PRPCj
 ixhVyvS8yztbTzinYU35s7W/wmhu+abkg+AjfC7pOKxuDkgBa1kz5wixh/OhkbXrdR5+h1h2A
 umhc1SHyStjRYsfDf2jO5bHIfW3K8ARS3eyfOicRVm0ycmnBNoDtY48QZ04ZET4wJzLrv+qs5
 nwOID+ZQ9tejeWpQOgERnY1NBMQOPqftduY+osP5gY773HRnn6ASFWF50xJUeZf3wh1BpNTT9
 usyjSvzJjm5K3thAwkcdp/NLjl6+PE7Sx+0lOZUsHkrYXCl7b4TGaDqL+MdYSRLBG83+oKnnV
 q0I2B5i2pUOf2KxeTDS3iOtcTtpOiDtDTjHESYgGV+bl+Q0N2cWcGYWPwEafttDx36y4UQ8Zy
 YLsMbGRFNVYQzdXjLDkuDbiIezFwZQYwn9i9/Sc80e44wZpYrSJdJCUv2Z/0R8QV2Di4ToaA6
 vCNbK0ZbubGSB7npkxEMgPxxeBi6i8Zfa0v0WODU2faW7z4A79LPsqx6g7bcWCAjU0dh0nxWf
 nRR5VAbG9H0kNb/r7/kSl71fuW7aQJsbBNDuwI/Trd7PUL76XBdNJmVULCC98L8QYV2gnKcjU
 LeM2IUpM5wH1Zz/tMgn9+f6oW2DZIymntv5ZuRo3O4lzrubzR5jKf1vhAQI/uzQTTW1Tf3Qjs
 GL85a08uq9c7WJDBDnetjF2xK2ZhNzeEogOqiQfrwcgG1I5Ka04tOr17p/bSOj4QbhdLNyUW3
 PzKgy2+Y//PXcfk0bE7mJjFupkYA9PsF6oBXeTZ0vAXAI9Gzil/sHVpVDLs7Y/ukM/mdZQB9Z
 FNtelSfiAzLLaAjlGeyoZWkuREarzu+1Q9+YG8WqTcHq3YkDBzqdYzTXMVdN1N8eceo2JKKIp
 VE0ckfilwVkVm+u5x7fjVhA1Bmwpv6y9ItSTDuIUPjheptavMCaahFw2kaptga89+9MaRSVGD
 PbWEWChSikFwBaFwtuYhQvFcjdKDe67ddHLflR1KmQx0qlf90/ZOZ1DKin5ruhA2KOkYfjJ9y
 0Go82ozDuvOJcXEY72OA1jsDh2LJmLEVyFquy7Ra1IFBeCNdnZSuKf7cFVfZckjANnTivgJIr
 psmaMrFNwg1JBaOIqTn37kTt1tLbxd7m1XAR7tQnPxStUD50g9uw+d+OUOZYbPz3DHzJT6cAI
 oT8ixMJJ0pX8C4Q/P3/f2U6474UJqab1SUbiXIFmmtP6kMroqj4QY6dtaiC8NQ9C0NJIqZNim
 tPn949HEq7udylxQ6mVtfblu0Z+qpdyp7r+yXlRbBr6ho/Ku2VLSBfWjekCGSNU6mSFE6vnWw
 3ubUi0nA9dQNG+fMVhQeYedE74kL55m8/2nXPH+njeuWwjrDRUmkEi6UY79ofyiXNUtwCSo2u
 fA8xu0nQJDKw+dLlkVR2CVNsIS2VnocKlNHPeWr3TONklRrYNmB1OnLu+UpcZgJ2dV1l1g2CO
 DRwRU1wFgQDMUoUNm2fKIBTbetyWN6tGTdTsi5OqdwXKAY2iVEOzSxpV+K2BjFxX08UXe4+sb
 HHrQBOXIVOlbp+FXEyASR6OBxDNopF3RjhxqrAG/3AWkP/PUHqm5+BRbrBenviVR+09CQfRZk
 HaNEnIf/tkCaGJZCjVcw9xAZqz9QyvMENDE1qUaeFHz5su2nqkU6C7psGRAlEsG+G2kYca7nG
 mcnx+4bJaUVWWDeBbtTdAFahAnxlXDrtsPXQ0dzyz35gW9UXQMU9HSOmHyRf8ToMLNJO3s6rq
 TV7lv8J3qvj5E4eazQZ4MV96uqKAFhqd4rRuhF6sjdR1V39VeVgbWbEz7yt8oOEfYHPYzQr+j
 NANdWs68OYecOgk8G/wTn1aYSRyaMadw0EVcF2tYwaBpDu09mshpA+1xM6WQyCquV7aG7uGDp
 oDrtyg3Z9iPFdjdCp2eNI1RTNMBT7XYspzDU2/dvt+IoOBOnJkxltxudk2QiZCFaZpB6A==



=E5=9C=A8 2025/11/29 04:36, Calvin Owens =E5=86=99=E9=81=93:
> On Friday 10/17 at 09:20 +1030, Qu Wenruo wrote:
>> =E5=9C=A8 2025/10/17 09:12, Demi Marie Obenour =E5=86=99=E9=81=93:
>>> On 10/15/25 02:49, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2025/10/15 16:31, Demi Marie Obenour =E5=86=99=E9=81=93:
>>>>> On 10/15/25 01:47, Qu Wenruo wrote:
>>>>>> =E5=9C=A8 2025/10/15 16:13, Demi Marie Obenour =E5=86=99=E9=81=93:
>>>>>>> I need to create a BTRFS filesystem where /home and /tmp are BTRFS
>>>>>>> subvolumes owned by root.  It's easy to create the subvolumes with
>>>>>>> --subvol and --rootdir, but they wind up being owned by the user t=
hat
>>>>>>> ran mkfs.btrfs, not by root.  I tried using fakeroot and it doesn'=
t
>>>>>>> work, regardless of whether fakeroot and btrfs-progs come from Arc=
h
>>>>>>> or Nixpkgs.
>>>>>>>
>>>>>>> What is the best way to do this without needing root privileges?
>>>>>>> Nix builders don't have root access, and I don't know if they have
>>>>>>> access to user namespaces either.
>>>>>>
>>>>>> Not familiar with namespace but I believe we can address it with so=
me
>>>>>> extra options like --pid-map and --gid-map options, so that we can =
map
>>>>>> the user pid/gid to 0:0 in that case.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>
>>>>> Thank you!  This would be awesome.  In the meantime I worked around
>>>>> the issue by having systemd-tmpfiles fix up the permissions.
>>>>
>>>> Mind to share some details? I believe this will help other users, and=
 I
>>>> can add a short note into the docs.
>>>
>>> I fixed the owner and permissions at startup.  This is not good
>>> because it means that the image is not reproducible.
>>
>> OK, so it's not the proper fix.
>>
>> I'll continue working on the new --pid-map/--gid-map solution so that t=
he
>> files will have the proper gid/pid set.
>=20
> Hi Qu,
>=20
> I bumped into this: the issue is that mkfs.btrfs uses ntfw, which isn't
> instrumented by the LD_PRELOADs from fakeroot.
>=20
> The kludge patch below in btrfs-progs gives me the behavior I want, and
> what I think Demi wanted as well.
>=20
> Credit: https://github.com/NixOS/nixpkgs/issues/455331
>=20
> Really though, IMHO it should be fixed in fakeroot: the Yocto clone of
> it called pseudo does have ntfw support, as noted in the above issue. I
> haven't had time to follow up on that yet but I will soon.

To me the LD_PRELOAD looks like just another hack.

I'd like to know how many gid/uid maps normally there are for such usages.

If it's less than a few hundred, I think I can add some gid/uid mapping=20
options to mkfs.btrfs, so that no extra hacks are needed.

Thanks,
Qu

>=20
> Thanks,
> Calvin
>=20
> -----8<-----
> From: Calvin Owens <calvin@wbinvd.org>
> Subject: [KLUDGE][btrfs-progs] Make the --rootdir argument work with fak=
eroot
>=20
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>   mkfs/rootdir.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index 7bdd6245..0f2c23c9 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -1631,7 +1631,7 @@ out:
>   	return ret;
>   }
>  =20
> -static int ftw_add_inode(const char *full_path, const struct stat *st,
> +static int ftw_add_inode(const char *full_path, const struct stat *unus=
ed,
>   			 int typeflag, struct FTW *ftwbuf)
>   {
>   	struct btrfs_fs_info *fs_info =3D g_trans->fs_info;
> @@ -1639,10 +1639,23 @@ static int ftw_add_inode(const char *full_path, =
const struct stat *st,
>   	struct btrfs_inode_item inode_item =3D { 0 };
>   	struct inode_entry *parent;
>   	struct rootdir_subvol *rds;
> -	const bool have_hard_links =3D (!S_ISDIR(st->st_mode) && st->st_nlink =
> 1);
> +	struct stat kludgebuf;
> +	const struct stat *st;
> +	bool have_hard_links;
>   	u64 ino;
>   	int ret;
>  =20
> +	/*
> +	 * KLUDGE: Explicitly call lstat(), so our view of the filesystem is
> +	 * through the LD_PRELOAD installed by the fakeroot command.
> +	 */
> +	if (lstat(full_path, &kludgebuf)) {
> +		error("Kludge with second stat() call failed: %m");
> +		return ret;
> +	}
> +	st =3D &kludgebuf;
> +	have_hard_links =3D (!S_ISDIR(st->st_mode) && st->st_nlink > 1);
> +
>   	/* The rootdir itself. */
>   	if (unlikely(ftwbuf->level =3D=3D 0)) {
>   		u64 root_ino;


