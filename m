Return-Path: <linux-btrfs+bounces-17907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA3BBE5B6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 00:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53F724E0F91
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B52D6E6F;
	Thu, 16 Oct 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MWVtGeIY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927668834
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655008; cv=none; b=hWa26/j+aiSVzUYB5hL4jSMa4wUFi4j1FOcwrLpBcOX3wIHVHJzSF4x0VBEYiC7VFGSzBlHrV9QaXP+gl8x7wtUykzERj2LnzkV148PHkNaA6XQw7cLP35BBU1FF9btR8RAYTVAjs8Q9z0ninGaYIQJlR0TG8ZI/tal1dhmMx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655008; c=relaxed/simple;
	bh=7Pg1rAiuyLXQYmw0Y8lZ5LQseOeqA6rPZCVOyGneHHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lpq+AQF2heyNUk2G5bivAhGzcwLN/3X6vEaKK3SjHeWLGnR2OjtikGNDcG89LTXP+P9Ai4tuDWZMqepvudKMS8WrnU4fV9KrAPXguihcohkxfkYmTO11Sp4sJFW1BLqsW1sipj1QQtZFCnIfYq9bgY5/4K0g5gbMKJI5Rded1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MWVtGeIY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760655004; x=1761259804; i=quwenruo.btrfs@gmx.com;
	bh=BPEhjkVXZmK+NsFztlGyOpJrAY60eM54N4yGDUYuQgQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MWVtGeIYURlK8/oW9n7OmkBZYv+I4KfuVOwZuSrMU04XWmxmS5vqen7ErGhptTwx
	 jRr75ShLm9pnrZ6aB7s+PmDfJJRhrToVceIrN4hlZe4Ewigymg7tgFY3SyOmsPdwu
	 Tz8LoOTACZHhpD6o7X/ALFpG+CpPXIZZzEyR5UFZ2GETwtP2VWxsNyzcQxx13uayh
	 jsXDIgGDThYguWY/fdzfLU9ziasfMdCrUS+lfM/g86xfO7sMI3CUIWfxJU2UFSu7b
	 zZhNxmloWb9xf+qOltREjxuiep9KsPD8qP8N2UD8sUH7CKyQ0QJRJiIVMnak5Q6lK
	 qpls31Z+C7Ue5vm2Rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1ubHyL0gBp-00ZQNS; Fri, 17
 Oct 2025 00:50:04 +0200
Message-ID: <0b099290-03bf-4a1d-8411-716f78058586@gmx.com>
Date: Fri, 17 Oct 2025 09:20:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mkfs.btrfs reproducibility
To: Demi Marie Obenour <demiobenour@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <0ff47dc5-cf0d-4b5a-8d84-f309a74cbf32@gmail.com>
 <9194ad3f-183d-46e9-afc3-b52ab2bf28cb@suse.com>
 <fa8d6257-649b-4de1-b723-64cbc34c0a7f@gmail.com>
 <3247ee84-5a0d-4561-8d25-b1b8e180215a@gmx.com>
 <14681d38-fbdf-4ac2-93fa-7eba21588930@gmail.com>
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
In-Reply-To: <14681d38-fbdf-4ac2-93fa-7eba21588930@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qed2mVlxFU8zb6OX+G3RSYf+hq+VVNNYshftWPAg+4vH69APW/7
 C/zu6hvi3/CGmcAWy5a12EafwrMgLv6ALTrvUk3wnkHT9Pqp+Gmd1NxIJg7CZNnkff6qZoL
 nYGWzdNIlwwuU3R7Zdr/MV4KyEasTtT35jHjI980Y0mPJ3y83SP90JBr7ZS5rVOuERQ8RFC
 3qBF9o3snMzyrf6+zEeQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KOsPjfHOijs=;mQMy6Jg2SQJCP1ADSAXtYjRsBnY
 o6LE/wMUBJQygMvL2K69CHkqwQqa8FRZFlTndnactJMwjrxRlUJXX2sN6CuAE/M9c4SIAxBnM
 Yny1pvxbI1be4lc/sW2Hp6cua2GwPhdsmTKajXcXtA+rwVoebF2OepBIe5GcjrBQECo4p82DR
 4Yyspk1YcPKdlezZoUcGMdNYuch6HbtyFFnYq9yqaWnENnw9WDOv2qrKYTDbhjEvI16P0IfNk
 NHdYwJmUyaHmrkklqf/470+Rb65rPJ8ad0RMy0AhBIhPdJ0MlVyMYb6H0Llr8iihSuATKu1x8
 ZfsV9WOxKr1goSzzO2YBqqUC0hjm2tZUuq3XhxtCUhQDi3UyvcYN9DXZ5QUtP3gpIlCt6a936
 jgPR19cakc58JKm4nPX+XwvUrhrgo61SOuMNb4VR2C23qmYitWm9y/D4GQAxqVNtiVRAt7agd
 DR95XyLaWiDiZhTeyL6EI7nNL4fXEXKbIfEfoitDbe91Md3qWI2E0QibZaJCzjFbY7Kg56pNz
 4ICsEnqWwjZdAQqRXsPjqYwcVETcqKNCkmAFMCgCOmB3cc0Pd+11p3gIb/gD2uRL3ehXJUbHX
 22jaHWS5BQhZsG6xl5YhZ9g1A3WTIwMxptfG0gwQWY78zmtLLvb3xvavBrpOD28TrFLx762K8
 if+hzAipCgaUtEgnoKtTjyOIq2JzM1WM2fZOtf5V3nKIlhxMXWym9aSURK71bi8gT1HJvgHhI
 mZORKMkJxCCyePBPxnysRJP7/PU3HxWVCEVrMJeQaTCwiPJYPHMJ6hpw9yxg4Qu9/wcZLyLP4
 dnfl9B/mSyY79GyK/mWkCNX1NQg9yir/Wcw95T4OcjRjL+xVC3C+UhIvGPOIvqnEfvbQgJWfl
 KfA33WFxEPqZ9LV5D4vCvPVbLfhRjfLe+tjM/exLftgNA6zylRqAEp8KPm7yUA5OrXHYvRqh2
 ZpEqsFxIOPfig7ugDLXd5wzwAylgRkhDuZ+9OaOFKKLQwEnR4avWscqeDiYB+UyMsfN4eDkAp
 d0pE4p9gmzBMWMK0dRlIPW5HymiwG1nVJwqCI4SMsJL7xMbsGfU4lE6eqCRg4Wtt+suR0PDVl
 ePDSyHEF5D488p+q5AUx70Xhix1DYjlMMN2H38otyewSSfq0+G//hmnKSGaXFCOeyASQvFi7B
 3Za7UzH2XNwZXOuxjB4sIiSR7+RmyAt4o2XbRBGsS2kYLvQQJYNw7T9h9tDq3auEv2E4nHWCa
 +1E1vLnRCGmhkNZ8PhQmKW5Dydo3oinKtHi9KGmBYw4lHUTfpqTixAKdcaoSM0SSmsCa39Fx6
 /LUNIvTIWg8SMNBMDh+NwwyQfFnVQvc8naM+Uj56gkvxYrq3A1jXc313Ksz16/iSvGcV/hveQ
 sP25rXBjlzr6fkbA0LUs5+m0S4kx5hFF9Hr/SnyWLLJBmC8B2WBqquWP00gsOGCgXkkbu3rPZ
 pqlcSk6ej47pHGdFrGjsIGlD9Eh0l3dyHOcZR7H06Q8+bVgszDdnRSmue781FCDN6H1V83WXr
 ndPXl4VwVxifTwnwSwI+2Geclsdcg7rffOhQ3MHjjCv38rt+zJ4CGOdG1QmJ/umc5Z3tYTd+2
 Y3/BwwjkfLdYxutsK/pMZr8w01zY26pT9VAPcDeBGaTI/bto2K2410qOVcMGqYkMIvCTDzdRJ
 Ax5FOx0RRdwe88yFsz9xEVxLDRF1ySRKC5GsQDqK155mZBT5FcFltQBHF4ujwNMlNLkR9CrZE
 YUBIfMhgGF/UmWnDMXeS60oeOis53e04taJtj25lyYtdL+MkUhYtcvgXLdrXDov2kzpLVS2yC
 829VldpwNHZWDFtIHEGQAiVOylFrBTM2ZVMZ+86+tK889b9kOsOdFOHlGglBovnJjKGppjRXP
 Sx3NfqPcEX7Iwi15yPcwiJkObqC92B9IzBx3Er4Nm0/W1pBYidDfP/xrm26bu7h271XNmd1bW
 2/mVuWYudX9Gcgmmxp6XPZCqWSxTMp+DFN7W7Z80GSMWTprBKhiL08SScZg/X0msiM6BnyJ51
 spbM2wDqnXy/pPD/ZwLVOdd6CSR3ZgwBHsP2V+2WUniQyYoFYECymqGhKyFj00JjkkRKCvYr4
 IzfvlcM71Ua6iiyeVIgMD/Yp1OZPaZD3k1LT9fN6ylkB6srU7DFNAiVhs9QgqHMZvTfx8kf9u
 iKdcm9Q/lFVeuyKYoE318WtgqQ89CRLnc+fhiq0EbUdCh3kekImnA8VQDCOLZGTssfze7aIhU
 9/BA98Nm/VRTDYgEKbE1envGMZwtcb4FDuK8DVLAc/ox/AlHWTYUwEUVEiznsmzdgiUQSxf2c
 Dt4u92ex0XHwZrMDoBcv22vpqGdf7N2Y80RxIgttnIEdccmzBF7n1gt07iT7ya3Gb4N4oBpBt
 1QlrUVpo68jCwumanL25IrO+LwzhsaCkf9dNoPi9cuvMYmnFmn89ZC/Vzcg55pyYc/QHvGj9l
 1DXTRDN+G+XlSdH3fDXb2tA563u8OWnrY1KY/cWHCS9NnCMdokV/RmUIPuvOosC2Hoi1QNfR3
 oDxuv/8HeZPNO6B9fMKG2JGCwW3EqSzbkBNTUqcQem0MWuwwDN0QJw4OamGbmsyoz41WVfBww
 x3DZRg8XzssXACVgrTL8WJit9fg5Kq9l4JuE+T1AZcoEBcBv4NXivqzeD+FfT7xKOpccFdFK4
 AqCbXV55mdaXEn1KjOP+pj/huzDiDrjv7/pH3ko+0AbPOvt4z/a3hFOWHoOxpSOKoz7FwERVu
 71057uHsdTP5r0xv4oMHcV+VlNtd6pVruPhAZ2JUnQXtt9y22xpxWlkv4FffF8ZsciD878sCn
 rdiSdgbrk08xZyrqXbysx45gqzTOXPbYSvGmjAbJwXeVqCKfapI1fKtyXCT3GrgLhdqCztmIS
 xEqZZT0N/3pmpufUPzPrcKTwHCacbRxOHiBaCVg4G072tIitz5f0dAmY5l3DPd5KXFrM0bSd3
 Yf0TJ8LitSlqXVOU4yduTx8yNhlIr7GAbl/BFZE1IuqUXnmrvkwjC305nnPJuj7dqqvUXLwkh
 m6JGxe4Ypw79C3ESbFF/k8cY669bakyxC94Z7Qxh+CDdXASZikBhjRZk98vKLNNxLE1FKXPrp
 7dotxVQA5KqtFebgZ1sW7EgQq3NZAGhItqQsEH5Pq80A8DpCOsLEIwiJLgMemCGbSwJitLuDq
 a7InYy06ijkgQrrdyr7kSQDB0dHSz+8sOqAA/rfpyXU8+dFZ0GRw58otJL7CNr4JQWp4zwnh4
 Ps5aQYKoWxC0/D0XzfAjBINWfE6VoFQHgYDY9MhjpUYmFzRZLiSgpEnft2PZ11pBOMeRhVy8j
 ofyK9ehqHp1w51aHcTqRtHgCE/SQjpK6gktOxNO0mW5RF2yCcBEB3Z3ag+brav7uONTP+g3fm
 l0J6uByDhZZmGPznmjWFLDE7tl4pZBfffD4uztbrRrReFsfbOwONy5HrESzcL0oEHcJeT1wNy
 TO5UgUqt2UTa0RsM74bCKACgJvVpH5kV43XD5CDHScLLc8lbw8pvncyYynmxT3i1BzcfSrEjj
 8CKr3E5X0TtrrUKiJbCPHJD41Tek4Nt/ViRecPuRAjWqf/+TSBElnryFJYU3hlMu7RLgrrL/u
 xUlSDhcKjmCn226QVOBQRd+xA24i5hjvRO7kVf1sz5PsIzdaI5hv16+OSPMs5B/QXa4H3rix9
 SfpvV2OWgEnILmjnwMS3icQ0M7FT60ElrXTZUSI7CGzkfTjs/sncPLAkXvoamx0SAbdVRP7KR
 2tOUtlHZm74D1A6Pr0oA2h3UuIWpmGLdmTXCF9hLzEb0U/wz3rDIaNJo7NswxPdPgGLwm8hG0
 dT04TgDeWeM3GjfR5b8rU53wXZ7a2fyqHgofpkR0OGK3N33vVy50nI4X136Qs40r9St8h4jdc
 udMdf/ZaJMfVQVZ5KvxFv4tsLnIhYNy4VFxm1wI902FLET6t7NlvPp3ixhD9PCTBTrXzx6v8u
 wjtMXG3U/xwlrmss/GOU+GIKDTXiIjHWJxZhohK1AgbFmP4iuJYZPs+Uvxv5P1qqO2l0F1HHy
 r0ojGa4PAfWyL11iNsfCc2w/8Eju/h0PK3ts45arexbOim1wwKViE2ZUx7+XfyU2yMOGeqrwJ
 IdCS5BjLmRcN8Cd70ImeN5OaVianE6kt/NE46TfZONiE5ThD4mD8wRdPHL/97bLvK5puqEmcw
 yuuIEA3EmA9PhK/++tdISXj5mrR3kf36PLcfjwuVLdyrca7BSnYjGgk13i46HmkKuFsLBn1Qn
 +lzTiQEawSWWR/jJIl4n7Cv4f6V2xqrAmuFtxcK8Rf03QB1dxv5AbPfGuTA/Ix6bx59ofsPLP
 D/z0PgEDTyVWn6aAEHTFV5iJsQsK/C1NzyYF1YPMbd19zlXTU0dxJ5JHG5JEIAmcCGIy8SX/Y
 dT6OAIIpUc4Y4cP+PqjkguzLkeyy+tSK2F112h3QfO7qlXRlh6+tZTj0nRw4IqJeUToixodQG
 QE6/V9HShUkWZLmqIALQuBy6qGzGxQG7ewcsHeJuEtL4ue4W1SOyLmlogdTJgYclqcc2izI6k
 lUDiYL8TX7RW1QfsCWMWBoNcGM3XpaWx5sV0NFfQt5GKOb9/MHy5gfjAWRfTF8QKdAMoOyh7/
 FxB6ynJNfavQ9HHV0/OcgxfcnUI5bfvR7SG2nbswvm///tWIrL0YoFZbxaI4mMpFXbfkZQZph
 oMFJpsmqVecjb0RC+l7hp6cHirxOrokPy36MhqCfKEIyAwKnF3ib08ddbBEmXLV08EIqAuXGW
 pShwCetG00TjY1PMiDSZU8JwvI3TggUPJwzqPvhhK7jxBKXnklTI111nQyk0D5jdJeBUdUKH0
 APVxK6s7+YyOdhO0FsIY58Eji6BcpEnlS57ziQnWBXW+diXCMP4wy2Ukgpz9LFuks1BN/jsPS
 75q6tSy3QCuNj0CT3iM9C7gEiXWYUK5TJoY4deW/89P+hcDXY87O8/wKxY38safruMkjIDX6X
 Rp6dT1SUfeYoLQ==



=E5=9C=A8 2025/10/17 09:12, Demi Marie Obenour =E5=86=99=E9=81=93:
> On 10/15/25 02:49, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/10/15 16:31, Demi Marie Obenour =E5=86=99=E9=81=93:
>>> On 10/15/25 01:47, Qu Wenruo wrote:
>>>> =E5=9C=A8 2025/10/15 16:13, Demi Marie Obenour =E5=86=99=E9=81=93:
>>>>> I need to create a BTRFS filesystem where /home and /tmp are BTRFS
>>>>> subvolumes owned by root.  It's easy to create the subvolumes with
>>>>> --subvol and --rootdir, but they wind up being owned by the user tha=
t
>>>>> ran mkfs.btrfs, not by root.  I tried using fakeroot and it doesn't
>>>>> work, regardless of whether fakeroot and btrfs-progs come from Arch
>>>>> or Nixpkgs.
>>>>>
>>>>> What is the best way to do this without needing root privileges?
>>>>> Nix builders don't have root access, and I don't know if they have
>>>>> access to user namespaces either.
>>>>
>>>> Not familiar with namespace but I believe we can address it with some
>>>> extra options like --pid-map and --gid-map options, so that we can ma=
p
>>>> the user pid/gid to 0:0 in that case.
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> Thank you!  This would be awesome.  In the meantime I worked around
>>> the issue by having systemd-tmpfiles fix up the permissions.
>>
>> Mind to share some details? I believe this will help other users, and I
>> can add a short note into the docs.
>=20
> I fixed the owner and permissions at startup.  This is not good
> because it means that the image is not reproducible.

OK, so it's not the proper fix.

I'll continue working on the new --pid-map/--gid-map solution so that=20
the files will have the proper gid/pid set.

Thanks,
Qu

>=20
> Is it possible for mkfs.btrfs to be reproducible, or should one run
> mkfs.btrfs at install-time instead of shipping the BTRFS image?


