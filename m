Return-Path: <linux-btrfs+bounces-21506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEw6FMr4iGm2zwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21506-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:57:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F2410A26C
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72A323003999
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 20:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7D344037;
	Sun,  8 Feb 2026 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TRru4WVQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6833FE06
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770584259; cv=none; b=D/NS7yU5ymJw26mqXnx1EQCdPhYu88+N7SuG9M96J74dyY6TDyzG6DdL7HdtI4lrDw8lP+OI7X0a85yqN9W6FEHwbnE5rjm57/8JxAAAZ5d15Na7PTb9ubrU093Ia/3yRsZO856Fcl9RjGGPcEWxU7uSZAMVM3EOXCco+/Xkus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770584259; c=relaxed/simple;
	bh=pqfUc9bgozazrrREGTOCxNQcAZ1UP5lGC2yAjdZX1s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZ9Ngy4M2ki3FAoyTK0n7aTvd5HsFbT/xIpPQYNu9h6pypLvG+orZRpZM/ZDpZhd69uFxiYN7CB1ICsFzRVVoScZRj6pfFeHkQNLJwfljkSd5/JDGTDFJAVLmNB1uoQuDZ48odf/YLe3HnynjU5I7RKoN31DAGHmkCd6U+ZoYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TRru4WVQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770584254; x=1771189054; i=quwenruo.btrfs@gmx.com;
	bh=lCNPLZFnPgFXKWexKwDz/hhDp+25YaC7lIb5nJHeKLM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TRru4WVQlRIMUw9ydb7ITFwzjpHwgiN7645e76b6A202d+J/fifD1/jP00YQdSJx
	 HuvDPBEULPyd8KqmZ5olbS5zAW3yTw7Pn8X3fwJ7k5s43lWvh+bGyjwc3oIXDywU2
	 TQsIMeFtCe876sOLrBCnbclRHWh8t41NbAzD2ySSomLvHsZrb46zsR/ketT6Ik+h6
	 xsw1i8kwTSRdK0KAqGViTMjduF3GRRFxt6UrXbgD5B3Yu/qPXN/dJWOyqaaxw9kCc
	 tC8jHHuWdbASm49CHzK2d3vrrIw4B+MbdbO6EzIXCAsAlKL2o70KVFlkIJwsJiRVU
	 8ACTAvFWqTmzdqNGrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTmY-1wLWYv2O4k-00P14t; Sun, 08
 Feb 2026 21:57:32 +0100
Message-ID: <6543ae65-d62f-4877-8e58-76d28477973b@gmx.com>
Date: Mon, 9 Feb 2026 07:27:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] btrfs: introduce the device layout aware
 per-profile available space
To: Chris Mason <clm@meta.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1770173615.git.wqu@suse.com>
 <ef73e5bf75b19e839f68c018596f10437a8ba23b.1770173615.git.wqu@suse.com>
 <20260208160052.3757174-1-clm@meta.com>
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
In-Reply-To: <20260208160052.3757174-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u6mc1j4hXtM33hF4TkCiYR1rnE4gbc7K3J6mBti8VCudi01eUIy
 YO96h/lCiFOrA9wgVLh0CnZOgIwBYSMg8Aowe7KumAEpZi1tKK+xKioDmbblk5Mvs70i8D/
 6iewWsmqXPqqTzuyM1opzyUj6by76AKG+F+Kiat4lTVRaOF4U/jsJZU/CVqasUk10zf0wDM
 l4vmUqSsuESq56CsjOjIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PIarmUA3tVw=;6stU3OJc8/fE87N/ET41ragYTSJ
 pZPJWmizX9yF20I6yntoAoN/lizaTGlNi8Khu9bxXD4M/9mU9Xpvjg68BcZWPcvlhOtKKE2sW
 aCxaie0LLtmfzo2jvCGdadacDtEVZD3VHtEtJV4Vv9OBXunEu3s3HhwbrANvO/iKOxVC2rCOG
 tnPmzxMTlzeKZNtmHnppdD+dTfvavUcBi2xbQYkvfdXT5yKZ7NFe2Z4FmwCKLfNTLyxDet3LW
 bObeVFktcDa42+PcfJl8rpiuVzrxHTx+boOQ4K2FtuVEaFsxtDMUVQlRpzHPRcCnPVzqOJbgW
 6aUjw1Tx2tfWeH7z2nQpXykmPNoF3OO6YXTdsJEYT+jC6z5SWqhe0F+0gBb2MJRtPASpFnac0
 9ocTyIVNvHh2fkCb8TLxlbuP5aOnGab9O82sf6Cqe+/fKo8NQMAsUkRjhYDl8lLlGcNAdbZwp
 koY9T4fltECiuEUVhBKXDYDjWSmS5uLYw5ts3B5cCvY1UdcboFWnppE1Ny4cwFtO07z1wtcLj
 vCELcl/8SUWADSeGsXakDP2QcZ2eG/y5hiH13DbPOEp+fMsANSv0AX7UCK1O8e/yP9b4phh55
 274Mu0fvXnYTllHiiq9g6RXptvW3/R+8wk5g0Q9LnQqazkrOKnix/m4IRwjgf7m7+2JpcOpEL
 ZvFpcs6tixSgEvSqGKO5NWsa3FDxjjyLDOF4RLLrnzhEiV2gnKFE+z3SALVwERM5/tKlrV0DL
 2vQHp/U1Nwca7yYCRHCPV+2T4e0H/YwuMCXk6MSuiUOOeRLBZzU4vfnJTlMAH2pyRBBkuiiU6
 jX0vaTcN620iJvoQs+itzkvDdKM8HYbji/T8WqWZpLxWwfJjQsUpCWX9kY0nlJre89wl/MWN+
 5WHntSd3IMMA80LzIKURebT1MKSz/ii+gC2RXnFB4GwsidFDg+IyZyapVQxEuE13KPbZRAhyj
 SWxFCvB7C8ddmt2mPSy8CKPIYH69fjlerjnYIj6j9tQrExNuwm/8HWAlgsm02B31yQSMBh5Ve
 dLHhEOc1MO819lU5EpZylylQq3hYSl8bBjSpIQLNa41kHAD6NnfZbqtGaaFpvKGDca7EX7H/1
 zyJ19AaV2mg1xD/kn9rZo775U4LXp8/nV/LD9CWTm2bHsNnWo416SQ3mmpAOftsroInYvzUaJ
 USLpFebhP/9u398LrPuR95cb/VBpBUJ0JPGjyOYL9VH9qbgVNv+auaC8Z1cNN9KeN+3OnbatG
 H/GqlHdFM2lCWuPx829vzg5Y4dCyW/5xrKI1xayL51SrCqHiwWJQr5YbuQksdgInC+SURLqnj
 rO18cqKLDgFyf5GnoNB5uwT0z8zIHSpTxqdjEHrBhHYocT9I4XX0EJsAdzRyh30JwMWiVMEjB
 us3mMR1THbPpdbQRXaafnLKSo13AtEREvt7dLPAg4o9DWbskOAUn1LyWLvfbXa3cenRNOvYcR
 DM1yRUz/N5ItBpQoU5j026P6y7OqG8gtOEA6G0m0yhUcVo8I8CiYcEk9WXtjwet2zrfd6Afeb
 a+AzRTEdl1SqYHcajE0bJsD9G1C2aRJ+u0T6jfZQaPSHtI7ScFUWQ/pco1ko5mBGIUkODS7TZ
 bvg7WP9vjCuWQvZH/sZDqahwtcuPNdMhwiHLyf4l8jLHXrkdPUPrcVqDjy1fbjGMoxRdYmqLJ
 g743pyEw3becbFkRPOil4nBIJ5Kp5DNJAfyiYHvIZJxydQzX51SmR6m+SOWgsJ0ZyFGWnEloB
 30WklLpaJKknof9d2w5dedX2txrr9kxjZLwNyM3olMNCrAHS2cwpq16VegQBa9BR8w1isPB3V
 FTKIYCcKR984/UaqKqqU/4SC1ZBETiUY+fcpD9GIn/Oa7ld92sCRs54UZSfPRX+vDzctW151+
 sATDMGwFHoO2aOfbaVdChWHG7uGwz4Snbtejfoj4tjDZVpHbu0cSX36gKbomPZrEAeGV1xF7j
 qDTW5AaxECzrvZJMZB65bzPDhaqIDisifbjhIMO8Q3SbzO+Fe0qnYWAcKK1op0hiV2Q8ld4ij
 Bwg0dqrF5slgMbYsebo2WUn2WARQHzqxe94mkow9zodDs6MzMDWvyRcYV4/sxyxK81u0eiKig
 0rdm/HHr2G1a1D0dPPj0mTUSAF7N2IGWj4bBY8cl/8H+Dzk8T3UsyYTv5Fq+g/8aPg0JWJMv6
 EzHvtFnefB+B0r95UigFhpd/CGsmEyVPxGaI/VvhIUFKR9wjufMHRq2+8fwWM/l01bxg6QWVy
 ZhBcB3oad8CtTaFVCwYyM0ET4qS8c3bUZReD4UWY+LcAoLNuRzU2evcAuRptws7wBAnjnPICj
 OdUPyqZoiYVyCM8DVsXBR65gn63r4AQFEhgdRxjIhjuESSAgh3Ta9msFkxa4IE4tyjF1QNWi9
 KO3EtAuORokI2cQEYRPzlLepWyIZl6ch/cn+C1oHVwrE7hzQo8haPS3Zm+jrv/xLK9JvlMuRG
 N0LG4QQKYJv3WxZ+T0n0gcaPHUdrm8pJsgcK7+9LnD4O4LV6C4uyQzi7CWY4SJuO/r1FXfPTZ
 OKWssWGdbeeZ0PRAsyjNQKiskuzKkLhLlHoR3Gu1WfVqUHyheN2jvpiiyKRil3IdRHFHjJugM
 QOVBeOR/97NAmj6l1takagqdUvyzdrDfizejK8YTR10AqjP2v9mAJLlejUQBJUID+xErC+A0x
 mJAsdFwd012/i9d3xxFPWfs6rSuclsifV7fMua4djpsSS/wtw9meJ0Oxc69YtOqlIAT88AV3e
 xoeLJn8JuwLm61ZRM4nhVr8stM56ljvD4zIQvrpX/L+B+otzcMWcf4a7mZy7InTLe3gm71VA7
 e0MPXSAYjyI5QKaDSqfWk1+z7kq6Yj0lEReqSR+3INaXinH2XYBKILuKqoCwkvCUwAoDCRT83
 s8B6NQKCa9bkSE2hUQ/yNU6GuPfLUD+aVF98GvodPdPLI8v9G1qoeCSfL+G7TTyDXlMo8L/Wg
 oVNCjflNvKmDTaXPwj0+Gwy8w/49dSrlVLXXMXC4eEIfZAW0FHkzfd880+NtX9fJRZRtH1gZc
 BD+0Kf6CifYW5vsvpQisuSE3MZVhGyCQL/9iMforEevDheqnMC7AybiqF5jJnaYKhH9EIQgL7
 Q1ijm25nIgTwREbof+iKBdmRg+ZTR/TZ/NNoiKhWZXJbmE2HfYyrhtE+e2UBDmQkiv+I9Xu5Q
 f39/Mku+3CtmSov67pMedWCff3JLtXKcF8f0CVYDvSbpxhJuWo2cQAnmA/T6EtFhjCf/2QoxT
 QHvAjfjPQIIpBn4WkxtIl2NAdrxXzzzR6tAqXb6Z4PirhlSkbk/+gLhd4A+YR7hPHRt0XRuhk
 cZ/xzy7UKnN3nZ9QdyEsDkl1g5fJiqVIVTES0kY4HCnnSvAWSxpzrAz5C9xphNxHZs+VLa/hF
 kuGWdwOyU9SPDH40dlsKMPT0YJPwFh/z7tVoecMp7iNAIu9FXBCkukDnJTk77+Q+/A5vR9ru3
 5/5Homqa3TVbLwkx7uWRkb+eXQvQE3NTGsklPTJ3J7WC3TeoW4ousa+8UH1pvkcgH9xYj8OJw
 RzGpIeqTTc+gCmCfuIqQ/7WwFKkRyq/pn6a1WgIYfBjKXsUMLCgvME4wHJo85bB7zyPKLTi54
 RyqezTmJn2DDTecO5VRMyd5izW9t6SpBuNzYIBO2XtEn//64olRrl4Fbwwnli9YkoXKjuNd6M
 1zzb3RkNyh2VFBlrSoNJRvcIjt3Ykqrz23p6w+owW1w6AqY22wK8VVgSX2rkp4GnE8uOO9exj
 l8kAQP+sTvNXgw3k1EJFNTSmL27PaYYYM7o+mNvJAluvl5ZrIOVZPGSMD/E3aOQQuUY1ypRWD
 EB3mjDz/n9alnl+a+8S3VYxtueSHXWW8lLHF9fQ8/mRhWeeH8AMWA6HhdAI35Sjd2wotEyQoi
 yJMOl+PvnC79mWVmzIdNnkWcQmOQqnz5FbhSkBqqSEelr2dM8xxZWcaWtHJ3xvJnANySOUOYh
 ja14OltRkY1lloss1xZcsiibl+p6k4z+Qpi9XKful4xS7M3pfEkkcRKXZsTWMS0M0f4HWwzXP
 5oPZp8XiHq1ZoSHLngvLbTWw4KeCgExo0/MVi+InxYpdSaaCYrjfpiTn7N/FNU+ErYHzjnfAY
 hox9YAqdjorxaYH2ttF0RJsMafjzw3VjFlmwYNxe3oBKxdvUCzXH50ISLVfEE12P8qa5XcIZq
 o6MSKaqsx7syPqKDzCYnww6N3IF7DXK8coIwOYJS7wrwY6w1G4OG5HJ236g7iY/fnfulKJU5y
 bPokJJ4WnF5BVLvBLftn1Zy552IT+r0lWQnMo7ivc+9S+6/5nxMtHolucp/u6wJMblY/scmCx
 PQUQgT6Qrr8qwW9jfDTghr00LuU74UUPfe+u9f8M4EmKBA5PTLRzbQZW1GyG1mO6o7+kQJY+M
 5lt2RdMSwiJVvNza7O9xIqwUHwW9klqGo1+qgP14UhPGsYOd4u4TzzpVynAQ3KNeis+eeyc/s
 hcfEWs+efSj6gUDA5iRM1lYqlY+9OhpggFOiLt1fQSn542/l/NAQJ3UJDLrrF0MOsmnva991f
 qv0ggSfik4LYnPxwil1SHgWLNszOnSuSjWM35cuQ2TJRxVrfwXCn+g6xTESO17cxpSWBkYE4E
 ooyTNSqNGujaKHy2NzS9lRJiKtt7RtRXydgV310M3q5iwgyA5KP7yfDYE53anEiumM6wFzJKm
 eLQMSYs57A/THU6m+Gm0R7ep/rT6WiDNeaItxRGsOoJ8x1TU2K07AetFsFHdAzYwtA3yA+TR4
 nWJrf3TLzWU30Mf242aszrfhkBNysROF1+PYrww1yCp0ELyoiaqKOs/xyXpn8focBThhDdKiV
 yfPs/PFrzYLN3OO1zE4yJnPKXD+zizU+h5V7ftCEUQUVgbePpJ72/GrptP3tzLdI+zdJp7RJg
 Fj2rL1iocSPaqIp4mgxB1yzQN+IdGLY4laD+8g7I0h36YGocybOtc/KeeBqRkpXgQwLpDdNmT
 /2Tcco5+kt2Tln9oUpamtBJE+1ZSd5vsSsvCD4ZWv5hLQtdoyhQ0IIXhzDMvfhNAAmP84j5vj
 AHlwgoS3Es9x03wUMRCf3eo/hCHwBmc7+p4W2xqXRT4yXEZeDimV1DD+/FIvBUuROosnARHhp
 GmH+Q5QzJYUlmKHg+Y8KI0eRumbOHQ4oNzRjNAJRwVSiegeRiLy/aEPNxFVCWjAqyAmO1jLtT
 6bNZ1f9Vk8DCRAPVpgA6pEVlQBp6rcn6I131JSZCF+a3tOnHcOVD1YqLqj3RjNjHIFnxLH9QT
 PVj5fsHy6QpzslPolq4m
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21506-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: E2F2410A26C
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/9 02:29, Chris Mason =E5=86=99=E9=81=93:
> Qu Wenruo <wqu@suse.com> wrote:
>> [BUG]
>> There is a long known bug that if metadata is using RAID1 on two disks
>> with unbalanced sizes, there is a very high chance to hit ENOSPC relate=
d
>> transaction abort.
>>
>> [CAUSE]
>> The root cause is in the available space estimation code:
>>
>> - Factor based calculation
>>    Just use all unallocated space, divide by the profile factor
>>    One obvious user is can_overcommit().
>>
>> This can not handle the following example:
>>
>>    devid 1 unallocated:	1GiB
>>    devid 2 unallocated:	50GiB
>>    metadata type:	RAID1
>  =20
> Hi everyone,
>=20
> I'm running the btrfs for-next branch, along with the encryption patch s=
et
> through my AI review prompts:
>=20
> https://github.com/masoncl/review-prompts
>=20
> I'm working on some btrfs specific instructions, but hopefully these rev=
iews
> are already useful.  I've kept the headers to make it easier to double c=
heck
> that I'm actually replying to the right email, but please let me know if=
 any
> parts of this are incorrect:
>=20
> commit 6f42a3863d937025e9670539658409ed668a7d48
> Author: Qu Wenruo <wqu@suse.com>
>=20
> btrfs: introduce the device layout aware per-profile available space
>=20
> This commit introduces per-profile available space estimation to fix a
> long-standing ENOSPC bug with RAID1 on unbalanced device sizes. It adds
> infrastructure for chunk-allocator-like calculations to provide accurate
> (conservative) estimations.
>=20
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 8288d79372a56..0082c166af91f 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>=20
> [ ... ]
>=20
>> @@ -458,6 +465,15 @@ struct btrfs_fs_devices {
>>   	/* Device to be used for reading in case of RAID1. */
>>   	u64 read_devid;
>>   #endif
>> +
>> +	/*
>> +	 * Each value indicates the available space for that profile.
>> +	 * U64_MAX means the estimation is unavailable.
>> +	 *
>> +	 * Protected by per_profile_lock;
>> +	 */
>> +	u64 per_profile_avail[BTRFS_NR_RAID_TYPES];
>> +	spinlock_t per_profile_lock;
>>   };
>=20
> Where is this spinlock initialized? Looking at alloc_fs_devices() in
> fs/btrfs/volumes.c:381, it uses kzalloc() which zeroes the memory, but
> spinlocks require explicit initialization.
>=20
> The follow-up commit 185737deaf9dc adds calls to
> btrfs_update_per_profile_avail() which uses spin_lock() at line 5532, an=
d
> btrfs_get_per_profile_avail() also uses this spinlock. Using an uninitia=
lized
> spinlock is undefined behavior and will trigger warnings/BUGs with
> CONFIG_DEBUG_SPINLOCK.
>=20
> Other locks in the same struct (device_list_mutex) are properly initiali=
zed
> with mutex_init() at line 389. Is there a missing spin_lock_init() call =
for
> per_profile_lock?
>=20

You're right, thanks for catching this missing initialization.

Thanks,
Qu


