Return-Path: <linux-btrfs+bounces-22085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCb8MwEEomkGyQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22085-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:52:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CBF1BDF96
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25EBF30BC1DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695DB38A718;
	Fri, 27 Feb 2026 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="P2IA+3eL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6AD2DB785;
	Fri, 27 Feb 2026 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225432; cv=none; b=eQUEqfqnCF9RFu6mdcc4OTD+Lm2wOyEk2inpD4FPmff/elRhnpMiCJiErIwUMeKk1C5ZqBJtE9zZYE2gIM4CwWn0QLTgLbYWvWQxzlIAedhlDyY6+8gAWGKzU+EmsU/yrtGcalyI/EIEZLt71b1pT0HbOmpN1vPVRLapNtqbp3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225432; c=relaxed/simple;
	bh=Fk+gRzrCrUpikhfBf744YF03i7x3Ck76jsuaB7CLh50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMsug+Ia9LgzRYqyjwq8IAnObKTndXwD0kFI79Hv4JkI/TuCZrR7xkKLZy57EcaLo3LR2BRuD0/BfLycYdPkq/p9NwdUwI5UpAsPHc2Y5XyOqoVsb39qon+PX2L9CyWDT2BsgDqM3oNnFAgogpdpHHeNA7hRz8qPwPPblHBrOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=P2IA+3eL; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772225419; x=1772830219; i=quwenruo.btrfs@gmx.com;
	bh=qRGqqKpT0OvAAd2+He14L0B6ijC+Nw5/5KLTeSAG/t4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P2IA+3eLyyMKyz+QtyZetskJsrSJJ/h9UDCYapDl+B9Fln2hR2s9sxcs7AOmvcbh
	 YUBH3XMNkRHtKMTx8JkhxQ3HTIsXQHPPUCmFctxKmi6M2kJQfp4+IupkBOtUahfj5
	 zxHgAJOu1Px4xPH9bXz6amAT8owOvgSjfrbHdOvC2eOUtfmA+jdsRnUIbk2RBg3r4
	 SqeAMvHfWWlDbdDZL62Dj8T6WVtopLoCWtDPt/KgpRWr8T/BMWecsuBkfYsRO0Q8m
	 gbM6a3Qj4NxqjBFelMbRj/96ghPj8290GV6kxAsqKehMEDBJL3hVTneDnllTq9NEi
	 pkD+TiXkEYJ6lNAUyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1vabpz0PAX-00tmWi; Fri, 27
 Feb 2026 21:50:18 +0100
Message-ID: <00a3386c-e386-4cba-97f2-8142c16a4c50@gmx.com>
Date: Sat, 28 Feb 2026 07:20:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: return early if allocations fail on raid56
To: =?UTF-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>,
 dsterba@suse.com
Cc: clm@fb.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227151759.704838-1-mssola@mssola.com>
 <20260227151759.704838-3-mssola@mssola.com>
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
In-Reply-To: <20260227151759.704838-3-mssola@mssola.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kj8Cs1T4KSUAwOGd1lcm6qTqmDxz88z1EkarNGazh9Le5PU7HjH
 mmAXWiroXc4nhkWI5/IVUx5xQB8dCklk4MeoGUvGZDTHlY7uYbnQjg7kBEv7OrlrWajkRmK
 gJCiwv3EsHnzbJYmGn+mwifQmwVAl4Z0g+d6hT9VTUKja6I0mceVwFMAufYS0yRfHpK/o1Y
 AievFpmL0DJnnwSwkcvmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3P96XX5jPA4=;YHy4kN8naJdMOtV/+eTUuFBkihq
 13NxnGkLYDvItIprmp60FmDWc9aSYj4wQLlRTOGu3P9g6W2/dm/f8qdYU3crDTcjDZ0JLen+m
 RwUtmylY5Mj9Eg7ErJJQcgD61BzINub8MM7IOJLx/bNKw6NIWBg9By47Ad1RxwJ3DufkoEpJ5
 67a8IyazVVyT7TwpLQmWljxyDzmHgCU1nh0FZSwQWap7E2UmgfB+O38/MDIbXbW+m7FieHIEu
 HAFkYD8cby0hclYDz26HkfMNu/DbHRTzvbkmbSqd1Bl4W6tVXoKh1hR2yY97ZgJNiCpU38xAD
 Psy/BMSX5j7zX0wnYZVQ8HFHfbgnNZSLmu+Lnx3cJkPMICimr8zv6M1sN1+g2jdNjkjG0mS/1
 Xi52NArFV8dijL2fbb8QZtfItzhXMmo5LhVksz10pLk0XqOEHutyW2twH09SOmc9LHjZR3jJ8
 uVykD5qEWMehNtxOfAgmOiQUOdagwPuRlCGgRWsKHq0MfgL6JkGEj47O9Dsd196njDyZkQzXS
 IXagN//gJAwN2sqVgCsmLTsBmk/eZ2m6a6B3ts+vwZTg2YqMJEumKkIjv2s22LWRQGJRPA9ud
 9bDWeWxs2MCsVSWQVI2P+hpUdylKn/UCFMU9g9t3l5Vrkl2ZKzXcDPh6jdIxLYobufMRlfv6x
 3Kg/NVsVwcaQzMF7mM/LMXumThp24Q/M22/w1cTaVDVmVt9MF1ZlnRH3SbR0EAksj8jYVf9rz
 MHKwTFTIeAJuaw4lR5ZRJWcr/a3fGUslzxQRnU971LnobKuLVyzh6r4rafR9eLaIZU9CrPpb7
 D/ejbXCmO7vOUh5YE8a+6usphbSETL0DEmUka1PIh1rMgZoiK9WiJc+FeWTbYf/LoCKrIcaAK
 +ID9Zf64QsgetWrtDyZxi7MghwkC1BYGW3Cs9JwtCwRm/4I82vFdj8dkuiMdVfBjlIlQHwfFO
 V58ca/t3Lb9ffEIIq8kH5RG+TsUKt18eQGWTeVwSPrmGkAfWHWUctO/2Xy4JLJpiR2R1kd4Ti
 fXUUUiP2eJ8PNFsorb2Ewx8dzq+4x+fh1CbOvjCE0Y7MERlzqjPBf/i1qPdWLZW+JPV35oA04
 Xjm7DpVeICO6syd4Y8bAYkgA8q3AQCYMKTy8kHrXXIJSrvZmWI2LRyfGBA3Ymz61dQQgVmbUb
 H0XigaIF2/0RmpgbXb09Wn49JML9SbWTCctJfJXuMpNFqCA3BtL5l49jJpbJpYYrWu/+TVLk0
 C7KmuxWTb8r87CGd2MfDNIIl/sN+XFRzFMlJCA56EiZp6rrKH612/Y+dJmooSaUmakC0rfLNs
 QNPkeBHcW878QSZ+Qcb1ddaJRK8TCSqq0mJs7wRMVe5LivHYmW6l40T6ylU0rDVh8NyfQb6qH
 oxxVV80QRGrakeh0EhxSomrJg7thgq6P9fqUr5pq3BRAkAVcqQGuhp4WziIKEiLwH9cukrkUm
 tJ6eF45cVyFEKQXcJ1oIYXK1afjxPfkGXs/7s91oTnq8T6v5HpEtIiYGACfNF6VeipmHxerec
 nntXGkHkDAV179gaTmnIAypX5Hag1yGS0sr8xuNY2IEePgZCBR5LbKhCN/oTldXJ/rOtiM8zP
 L9xpwUe3G9mOfKMjO9BFvEFGmKDfqkOdvZF51RdNabvfiB+Gt3KGwiEr0qH3Pp2w2D0mk0a6P
 6fHloiukULdVIxx9PXceG9GgLEGs86XS2wMHB/QdTL6udUJvXqCNiw7oJefob7p1iiansSjYc
 /vymJVsYZOMYEi1PyozJxt6XmnALG9JRMw0bHkx9HO20JkUujXT7QbisDdDjurV7jsCdmIgS/
 pSQUqRoulK95PuEdwfmkcxa/5/kP/MCBrnQGsE3+05142zv4DbBIiajEiSQjFdmOXvbBo4ubu
 SViNJ9mny9saSb8B0LgyvyeeCfegYGzmoHtlJ9Sy3jBFgxIyrnuRvCiC+4yb1xljbTBojtB+x
 CzlvvJu0zW+BuvStChSshFujxcraK7hXIRUu/mg/UOJBh0pTwKFT6omQp1cWkM1dAvRFRHcBt
 2AhcIKbiZ+s3PmxUHch8JfmwbUTZLc1tWIT+sTdeB9cplKbUVunaotsc9WAgF1s5IVPrkLlo+
 51DagNZbZKDCIv8kJWIsZaB1nZrR/kbloTm52kvyubRQMiozIOYmGMXhqohRN1jxG2q2EFFUh
 eOk2XMZQdHbirdpIg2h6Rdv26ZXXLrGSJSmA0UxEMo+VC3VuRU4L9yhQ+ZTjdOd73hRwK6STT
 Txn9fOcEt+JZukyv7Swio1EsUZRHV+exetLZm9PE6jz839VyA2XOtBqTMOLFIKzOLrPmPnSvp
 BBXlkM0Sgv/VctcgGUfGXvIZ5dbY13HAnuPfrbk/CigAM4ZiqbdatZ53VBZBk+CLz3nigUAVu
 ARb4VY+g8oZ3qt7URPGL1hBcD6SGDqDOGMetF5lHEPybqaFlNv6ZpkQplglw1fHdKCZPptNHh
 q5KBgbNexCalfOc0kRC0m1piCzIjuxArHpFMh29E6As7vRIUjytNtTkmX/VzX4ks5/x6Eh4pV
 RfBmjAP/Y++Uj56+wPECNV5UrpHnksJmt3J/Eafbr1dGMxbRLsNMH4w3CrBkFUzxPtI8wNMYV
 QODC0yCKwihOHsJqjGnPeifIGHSE3s6Eb6CGSeCQQX4dsbi8jdG3pM03GMMU68zw1Z8WrBeuq
 r5G1XCVtXmJONDrCBBCIYIY+Vk32eOX4ydK3y7Ig2IUQ30ZgyY+9XDL3w1sb3yx1OZgBSvcER
 hOK60fPV+gNg0Wh6x5Sz7By4X1SzsS2QeixY2EE6wLivPx9tAUbRLrPvFqOvKX7JfM8FSRT6K
 DeuZ+s35PnezIoOT9cKsQhzPtkPTfpvD38Y1tF/sAkHkndv6oHaxxL+Xf4yCi67Sj4KxJJX1K
 4Ozn9j3S45QXcPfcmvcgTiC8zaZM0VWcQIMlrpU7boqyvTrIo1HQQlhrqcTpv3nQYwR/1gNSY
 GVbSNWdZQWSBIw/ShCVWwO1JK8zRyCMqGR49sSe6kiTH9c5IujcBpgagu7iKAQoJ1/PgKbtx5
 1zRvtd+8ns7mp2aCzdL8fdfIaphBXlkAu3bGX2C3uNy8+gYRpOEFa8jUafKzcl53X7k6zt85M
 2/ZcXd8+w342JGdGb/gGMG41nq1oJowp0RxB4VawvfbF5urTQOGe/PWhLsXkKNnsCyTpognV2
 pBS3tI597tROgvPXZ1dacS1L3A1tCGmLYFlsFT9F1c9FPQLQRoUkQ+00dZDNK0WoAv4zc/Cyq
 YHXBGXNMUcXzmL862l1wof5K9MvJz2ZVYQCmFnvPva855y94aeAY1j78k6eJZNPZzyhppixeT
 iUl3KhTsS1agIb0/78diy9OpSicQ1Uz8WMZm4I2Z1B0ES5ArY7K1WZQUJSPZAe6f3LZDMxXdr
 avsFdggsGvO2U+qFStfy7JnpHKEoAQa04zSFcSjXGNC4zWz4oPMH2JR2HnxdYNwRGPKgtpqji
 byBH4kkH/jdIOMTg37VqkmDT2NgOPyVWa/yH87kk3NGLVCsl0wVq/kmNORs60ZHCvOkKsjMHn
 hUBGMd/issb2sZB3JE2cUy/rJSxBhJxxppTa0ph5MRVUZiPrY2aT8F2Bom47oUMkbB+CUXVyw
 22lkKs52KFddoLYl8WgCycggLK++84cJIceT3+WK+1aRVDoPbDCTJwOV+SWNgGCx9P9sbxX30
 yg6gvmBFQtpZv6x7OnMHBhPmojwACqnFA0Bb87ZBriCvngnBJpDj1O22HOOQ72hVhST0/jt4B
 bUwrbTjKqU4MF0R0P040qPqTYt+p+twT95350FULsYtVnGI2La0S6ToCkuIGHyj1UgA1Xe14k
 yQcwMtUOaWQzN0qASL2cCtn+8bBTQ18dZPAyv9jqZh5R180zlGx/1FxNuERf6pZ7UqcsXVRPd
 eMCNJuVbpIAQBHIBiZILYWDFVbegaxF14iq0TqVE5n1iFTslhdtRa787AIU5RKznedorXGjKT
 7SQMzf+bU1ZCw8TlQR5J38H85xOCzjqlJTZA4+sHvaTiKIe2u3sGmSDki+PmWFy5iojK4WQI/
 S8+nFw2phm+HLOmW/NE6ynVaOPAOmx4bTU5NGT1LVRhYbil8QOsaEd907p3JKTYQwZiKXdUAT
 XBujewGcQyGNAuA/cxNuD/K8BN0TskTrTKyu0Ad7357NTd8AucaeAEUe4Zac1uv2yUbpnzfJ7
 koZy1lUC2lsi3sLNOJbOCAGcGVVxEhl35ASKzP3CJztPRNinoRnk7VPsDDpOzI/dNCYGLz16X
 5XX9JPcAzkjskDW1VAJfl6wTrNypbl8SPVhaEWuMca5MU+l99FrnkmZJQGvRh9P68RJsxWCu8
 MtWkrV5ORqOHJtAMDz3VljFXW5CYtnHgpDTbceEu/SjLdtnA6eC2MZI4kiETwoEgbfobibF+L
 6yWeA58p0CZ5gP9nP9YMoS9Z5OiopDBTUJAso3zG92mvxNTUesVCyzkgzIGFPwYxK5PimPosw
 PiQjofAaKuonif6MHM7wBgXQNzKw76hm4njq4jU12lyG3F0jMCimB3BjjyqZijotuWs+ZxQQv
 YC3TH02AxwABTlQ9UUERbm2k7M48stnepVTCTAUpRe8j4uTepBE3cLAmQ6FlCMC3JPS3pXC72
 +ydbh0pqzQPmt3rwa5/n0sMxdbyPXjAbV46uWgEHqUAwuEFUTd7QofoN2XIYI1IDernCXYukH
 QbDMsboLsuelZi0/rLzr56X7jWXulPw6Zxcbn8v/RFKOYqiL1Fzz1Cl5v+QBaenchBqmrlDno
 TwYA0hWUQ7fuXh2F5wHrltyEawq6cqiTn+kaRcLLqBr/PArIFNx2tpFkq+tN7d9QZ8m+dxLx/
 V7evkyZjJ7jGkUSs1DTh1MhcG5ZDBPrrPTrscU8QaXgwAhiCBub0wTR04gl8b30IVrQ2HVlgo
 7rj9190p0v7k4VwiYgGUEFAH/wCTQ+1XU4aVRglEfstPY7LGQrUTZbvwNNDYpg7il6sEYw8dF
 AdMDMV0BuLvLbrsPxHoo/U21U96/XDNINgAjzQvhlsgD0mSEDiXBVwy/hOoYUGNXlTvvrxlrT
 oya7qbgOKRz7AnmbxTEJdesV7e2GxUdvdY6yOnA6vcovdsrtUDEYzXecmQgSY6idKTb1W05RP
 GmWQjc1NMiBOEQrBrSib9XpTGZXgjGuGXQDPpEch52Y/aXteeRbKcyL6yAmmbg25tWFy/RunK
 YCzdkQDQ=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22085-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,mssola.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50CBF1BDF96
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/28 01:47, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=93=
:
> In both the recover_sectors() and the recover_scrub_rbio() functions we
> initialized two pointers by allocating them, and then returned early if
> either of them failed. But we can simply allocate the first one and do
> the check, and repeat for the second pointer. This way we return earlier
> on allocation failures, and we don't perform unneeded kfree() calls.
>=20
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>

Again, the old pattern is just fine.

Thanks,
Qu

> ---
>   fs/btrfs/raid56.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index e31d57d6ab1e..c8ece97259e3 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2094,8 +2094,8 @@ static int recover_vertical(struct btrfs_raid_bio =
*rbio, int sector_nr,
>  =20
>   static int recover_sectors(struct btrfs_raid_bio *rbio)
>   {
> -	void **pointers =3D NULL;
> -	void **unmap_array =3D NULL;
> +	void **pointers;
> +	void **unmap_array;
>   	int sectornr;
>   	int ret =3D 0;
>  =20
> @@ -2105,11 +2105,15 @@ static int recover_sectors(struct btrfs_raid_bio=
 *rbio)
>   	 * @unmap_array stores copy of pointers that does not get reordered
>   	 * during reconstruction so that kunmap_local works.
>   	 */
> +
>   	pointers =3D kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
> +	if (!pointers)
> +		return -ENOMEM;
> +
>   	unmap_array =3D kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
> -	if (!pointers || !unmap_array) {
> -		ret =3D -ENOMEM;
> -		goto out;
> +	if (!unmap_array) {
> +		kfree(pointers);
> +		return -ENOMEM;
>   	}
>  =20
>   	if (rbio->operation =3D=3D BTRFS_RBIO_READ_REBUILD) {
> @@ -2126,7 +2130,6 @@ static int recover_sectors(struct btrfs_raid_bio *=
rbio)
>   			break;
>   	}
>  =20
> -out:
>   	kfree(pointers);
>   	kfree(unmap_array);
>   	return ret;
> @@ -2828,8 +2831,8 @@ static inline int is_data_stripe(struct btrfs_raid=
_bio *rbio, int stripe)
>  =20
>   static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
>   {
> -	void **pointers =3D NULL;
> -	void **unmap_array =3D NULL;
> +	void **pointers;
> +	void **unmap_array;
>   	int sector_nr;
>   	int ret =3D 0;
>  =20
> @@ -2839,11 +2842,15 @@ static int recover_scrub_rbio(struct btrfs_raid_=
bio *rbio)
>   	 * @unmap_array stores copy of pointers that does not get reordered
>   	 * during reconstruction so that kunmap_local works.
>   	 */
> +
>   	pointers =3D kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
> +	if (!pointers)
> +		return -ENOMEM;
> +
>   	unmap_array =3D kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
> -	if (!pointers || !unmap_array) {
> -		ret =3D -ENOMEM;
> -		goto out;
> +	if (!unmap_array) {
> +		kfree(pointers);
> +		return -ENOMEM;
>   	}
>  =20
>   	for (sector_nr =3D 0; sector_nr < rbio->stripe_nsectors; sector_nr++)=
 {


