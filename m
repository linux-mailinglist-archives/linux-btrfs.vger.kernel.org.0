Return-Path: <linux-btrfs+bounces-19647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715FCB4FE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD85A3009FA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67732D0606;
	Thu, 11 Dec 2025 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gqEX+rt5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E258254841
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765438674; cv=none; b=XkpV2LLK7TAnp8BHpWJuUcfkN1raMbC1waJTLlzFU+GAX6R0m9KZOs3GSOYUpO/zOBYOCAs2yO+2IDxq773drrl7x0fBNbhxUqUMDjH8R8DTciI3qoVBUTKxgyR+i3QO2jLqVfHdmfPDxH3MYOArOpF4hmBFHS6m1Q6h0rMtn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765438674; c=relaxed/simple;
	bh=7oL/89N/bOTnkbMwvKXpBKGbQXo21CAWIssrYP6K9Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MPRYvstdkfm3cTE8fDLsTVe1bDYzgIOvU3XeVcF6F4ZIZBhE6L4b1/zLmb4x3hKoy5C/xvGpuYNMz6gE/Xs0PdzuoBbvf/WMCH1+EwuppqwipEspbqQhE+3AOsvjxrI5aIBxc/7IapIwC+Ftddl7GKXq+guPyZ3bEG1sM42ZUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gqEX+rt5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765438670; x=1766043470; i=quwenruo.btrfs@gmx.com;
	bh=7oL/89N/bOTnkbMwvKXpBKGbQXo21CAWIssrYP6K9Qc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gqEX+rt5F4/xyIQ8t+ucQLEirK4wb7z/WczcphXQifJBRG1UR0JX5O+Zf1Yzq5t6
	 sHhsusUoTdJjpwDr1IdL05gbjGMb+Xd6Iw+MCNIrADJUQrx0p43pZlRrJXLKW/Qaw
	 7++LJ0upbVMSAT0vp5TenHGApJru1R8ArraTrjqKsPBdQB8PsNMbgSxykm7zRca2M
	 c1bBITxi/tKwU8uzRix996wRdPLkXLYUPstqspj2VTWg48CkP5dsDknro5tWsaCKg
	 t13PrKVrh8WCJHeyktN4cAJsrbcfVxE4/vQXho9J8mN88YB60eOJ3ZYVPfEf+7xbd
	 +T5wBVBYH3raSKvZTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9Mtg-1w8JFB39SW-00wH4U; Thu, 11
 Dec 2025 08:37:50 +0100
Message-ID: <d18e6504-95e5-4a61-8000-f3a8526d25ec@gmx.com>
Date: Thu, 11 Dec 2025 18:07:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: search for larger extent maps inside
 btrfs_do_readpage()
To: Sun Yangkai <sunk67188@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <7b5888df903f412b05831ea5302e586cf38c231f.1765434313.git.wqu@suse.com>
 <d8037cc1-ba03-4bab-8165-0b0d2fdff58f@gmail.com>
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
In-Reply-To: <d8037cc1-ba03-4bab-8165-0b0d2fdff58f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nsw3As+0Vl9qwxmJXZL87E6qAdBSfSd3pl5E1AB2IZLrfRQ7G0C
 D7ZqqrKyVwcuJzAf/euJVZp3y174KyREnftwrnL3V9HWL0DHGX7JLX8JHshyCEXnqZEPxLr
 Phyh/wCBXJI0OqEREySgKoCy+Am45qUjAxB10O+n2BTidg0wJscLJzg55a+/qyFkkJ4oJpl
 3TMuGDPUsa0JSLvFBR2yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rQCDWcKUzqg=;dC8J31rZnjaQDopqwEwogI3mA/r
 f+B6/5vgjTmIKjxPQbOVCrjQUA5hYmhO2zY0K7IMKlv8dPR6z2uL0L53ZFBo3amILv5c3WLQW
 +wGXFk3MBkGhwsJJs+eJFAQh3gm09E9S15Zd2+BoM28o+7xwfpRmYYpsrAlTpzslbaE8tg8tR
 r50NSO5Jebon54lsX4D3AcABoUXZNakexKapx6p2hc2+E+aw8/V5hLwpdd1yQBhj6m5BtsEIP
 spzTgGidOHUaTiaYaPX+CpCQYks8e4/FpFSusBjNGp46w1rfpnI73pHEoBv+MclGjKxHlPkQd
 c5vvy9R7wWwZJQt85XpqIaiYRPi2g+dg15gY5TAT2h0QjBaFMchtW7f+zR5JPAfThbd0O6rWZ
 9Pwo8WhEHDr66i39LcHnjBhbBulk4wuwnMcieuZgGozBClcaUEXOa9HXoOYYepdIuDo4gyO4G
 GmVGFyobsKo4VQyt4ZFOqDieVfE/e6f8j4n6qTex13dsSu1832JYAyteGHcYyJH1k1lAfQz0l
 5A3NrWtyJzmwA2DgKRcqgMfCsNsUpH8omKJTl9gVi/6k/p0uyyknZ4emS4eBFduIuRfqjS9zQ
 /NInovUFTy4RIER4fY/KXuS/aKtusU4mduMY/gnVgl+mw95KRJcG4EZjcMwCODnRNQ7NFyxGc
 KO5HzaWyU2vAqEwsAzeowHmUGbL4Q1k2xwJa92vHlb3YF7clbBHsSt/1XygP4x9ZJb639wjUh
 dxIz/ru+5bG1aeQPORdkh8MfpM8fG7whifUCRrTnI2agjegZDVY09NFf5pSoybBWL17lJDde/
 +Vgul7rbKwTsHFOQa2MTeafLpUHHjAS/YDvrDy0WrSkPDD1FoTYZD63bGLgQCxqcr+ERSuREr
 /tltsTKxMo0oAOJD31b6QBw8YHrenX2gG8jYul67rU0wEQL6hoCtq3jO9eZph9QionsG90Mim
 Zrw4Ly8dqF0vTn8H9z4/dgfUa/RgOXNChjOAhxEHJhUKcrCVsZ4MuEjlm7CO6tUavdLbLb1MB
 NAqjBBA+OVkGE1ESZ8LeYNlK2N/udoIjN1rFgdAWOF0ertvNoIlBboyPIE+tuoc9DfUY7mW7G
 OdHJ2n7MBXLYLwrKIMqZyZBPVs77b+ycybPZVLJMA0l9Xwa1kOBuJ6QzsegtUxPINek1c1hOW
 tV8P4Ggxva7mkXCneYAbt77aBrgm9VN9jptZZkcxJ1bIr76yrLjGEmJ027+e1UJuShqKLOExN
 hnMiVSD3kcImOt/G4bpY8m4pgd09Wl4nOnwQ6LVSMHFsdhf+MRVbh+HzTd4Ec/DdotbI5WLDO
 Vvk85q2v4JxalyW5LCKYOgciSh0hO/fWHJ3TDciE6Kt0lIr0AZPweVnxBbEtkZ3KCIRU9DpH9
 a0D5Q1cJVuqD5qTwxAm43KZLu6oouBzvWcP+HQBe78E2SOyt8UwO953TNeID9cQS4/KG3MSYy
 El9P4c+/R+1qtLGnh7R7kjAC4awnjoCZz7oSo8GNwIBKZ/Oz960cd1oUL5o3kaffs0R4w5DXI
 VlaqfwjpFwvt0CbruGEb1BPWEMk2R0+8QM6minr4AtNXPPdNNTNUxr9qCFElVwPXYGNb5lvmf
 UdYvjABLvOmz1pWrez2g5dTfor/LMXeliwT7KbZW3rnbg9xWVCFogeiW77xTLqfVjtwn64uck
 m6aD3K2Do28yB6fMg71ysLXC7fCyGUG1OgcEdIzROdywDGhOi/LzwSrDxvorJancehZm8L2FN
 XSeWaQzZZrxehqZkRHJOh0vbqPpZtZVIlZUkWDBaZn9y2/39Zro9jIVjNOFXnwOqPcYqL1Ow4
 sNJBMPLQxd2H/Hw/dRB36eouWGGyNSRtD0i9mbmBcmYj4HeyY/6tr/nN003cKWNH/C6OGS1Ln
 CHJxsENIrNCn52ym1frPePb6lHCDWdEdVmx11J3ZYDYRRTA6ww9cdwQz8MMqI/lYjHctbAno0
 r7/XA1aPzNek4OZppqULg9iD0COK0Q6LO3hvWIkdIyceNhRG9HTN/tK0p7nltVyLOzgoQ7lv9
 wpaZIjZSILxpclP1ru9vtX8YIDK7mCNVNM06CFruSUTXTMm2v1svZTwNhSId1U96MtVTNAZZ7
 aRWUZfGIQhOGBC1d5bdg7IFvKlwcyap6JmKcuWKgymt6EFz3nAtDgk6LwPfiHCNiDmRB+ew+Q
 Ut/ECtcpyku4v6hwcL0Z8npHXDR9jTVY62+6zGCqnCABCciSkhntM1Yn8pwElT4u6f3rTWu+Q
 0boSGYIDi/ssTVRwRftdg93N8JVU6zB16fTGZAP0FRXkEhvbvt1AUt6ga04W63SpSyCfEE9Gi
 x+Sq1FNmpuPmv2irpL9rY5bOw1oFza/OMlX60rdfUHCHQpyVsBKAnEZjUF9UdMcfCKVzXWNMI
 9HVjA+OXvdmtaXfhbvl1avDF0PjVIUAgOWqFG6GsMoJ60loGvWY/BA26zimL9pIWv3Dzmitof
 bAXx5BPKFyAikdnFiK2qcarSfF91e/T0pjpIWGJtzy4pmU/SQ6CZD6Xrk1t5SP+MMVyOouC2w
 45TtI3W4/Z/EF353z/0TygdYxNQVsF1xIUFkL72lYA2m5pyfQM35HHtI2mudSyoDTancMslVg
 n0M06qBCSytuP+wYkRP3LT3ymnrYO0rpoqCQuUiJghXhCRnelIWEsqos/4+n6dAoTjlwE7UAG
 7SPcTNo8+ShNXFMOJSQ0Tq27XyiKPyqNPm19MpzcNt4iQCER5zRvxFtMdl5mEL8+dzIOmu9ON
 Zb0ww6+dQ3dwxlTW5dpqc51mKNTeqtUc07adugmR6/3Mun6HSvwPmS4tgmPK0DAj6RgBlkSe/
 0D58KxFF74bfMwyw71Ci7RQaTIbGrdlBaquF3ud4wEdthKewWwRb01vvi2cTV/7TmoHBd8LVq
 QqVZdxY4WlTNE86VW5cVKagh2H84wAWc8tKSfenhJWrFQafJdZgvCJbfte//DnEeXB7qFVXsz
 5k++1WwTkEeOxcFzsEc6oh+VS6RZaYpP8PONMJJcr9FRAE9GcjjSXBoiWzPc+5dbNftSHUXPI
 AEm1ZETPZO8zEKju4INlMpoYITm767SxhzZYYR2nFWGLW5qDAmd2QoVQObCVjtmkvahn465yP
 /TS7Dkw6Y9+UgdttM90FrFo105kwk3vspJHHP7Te1jZeANS2rO+emRkFCgXX0JhjDa3CIGCLV
 t+Uglxt/z8JpogrncK0dZ7LtRhYpPe9x7PNItgXOXwulOOUvpKCAG0bJopOSQuXnHWr4S48+5
 JVhfIa9qpivNLxKjJXi2GOKsYG79c262SN0CI2oK2oJ8nJdGrrVaDWP6KKqQf7nO7jeXxVmZV
 WnhvQaoeXv7+H0OmyXy8q2SVGxbQxrT4T59K4FXbocCLaeXLimJBk+KHSrRuBCFaaHS3wzz6l
 QFQVCpBphZIiU0GA/eaKtd1t1kelsPbD2p2euVg2s4/B+8ONrrxe7k7oWPIXyHUeNqRbW73ku
 KjudmBcGhgZ5aFWyKX3TGI/RsuZMXfG1e/fkKndj6AE8N6PkLzSmLZEgxcUv0EpRFqchV27Ff
 FBaDUsVdGTKXcyO0SYpnRnEpDjXn2i2BveoN8g9/iMLLnBTXsriEQY5N5IRmQa//NxWWJefZ0
 ta5l2WmlIYiZGNHJcD7p1wKrrQKuzbYWjfSvRkDokfW1PA/IxMMurVpK3U+fqlLYHCAshxQEJ
 O5yW9X0KrSPFHtKLnh8/PgGZaLgw+89cVxn4o7A2PvBu/waByaoQ0CyTvXB39+RYvJDytWeIG
 avn6Jxy6/kjByJZGBgMON0h3YKODT6AIpcPt/Fptn9kxj6VYJIwg7SbWPXcdamxkLFqyLYwNr
 3P8SkprJbQa/YO7bsC7OA7V+VCKPpwqlgryw2n+aH/iL8+wSnaZO2XcdVQ9KFMIHRmXjuWkV6
 LLNsm4PcDiPkorxqEybbiPUju9CqOmAgzdN6u/vf9qeSY97sBlf5Rx79OUui1Ug0ts3trRV9q
 W60Sp5CqGqRa1U2wkjh7P8ZOcSgX+zqKTZvA49Ex3VSw1JUqFLMOUF41azNy2RTIxwGgcFtu0
 WBUeMkrxwqVr1oyjla8+IUUJUOt2S6bHEpWawUz3py0yfVAulNqUfe1TCyfnAVzCOo4o5be/H
 mSTBbbhkJ+e2UxLcKSZEYIDyyomuHQy/HKfB6TN9L/sbtC2/zMjaJ754D82Aaqa0xU4nP3kq4
 vYh5rS7/2u91sVzMy8UoCdBRC27kvZ8O4wp4fRPHubUjZ4EiWr8/PloaIZJs5RN4iAag9YgmA
 776OdAYOgETL0ebe/ATeSwwIyPGknDrS5/kmB9uvGscHf3KWfWHTwhXduqY+Sng0fMA0+5uJl
 N70TiGYLBFAseAlCg1QQOrgrlZbkWwq2AKauKNdPwR/K1pUUN66zraJGKppX60ht1wes3G3AE
 JTzGw93mGIRMJQbnKWuWHPD/FBjKcYtW9Chj+1FAndO9Wbl8jvnz0486NCcGm+EF5bY3O913s
 EXFMtzb2+zNTwLeguQGj3YlOy+buGFqM2gHBEt6qh4usfZnYNWD0t1n8mG/YNrDtK6gKsGpLi
 FIS9PH6Vd0iAZaQnjJIs9K4NIXXxIzzxMcQYdhIO7vwVPaWq5VhjRvDdb9IP3RsbQR5bSdkrE
 oCTknjtSsEuETGJicmY2jmfSnOmvJGKKFkoKuPRqXBUK2Y4Rp+g8lEShdKb4UBiQYbH9zursc
 B0CnyYD3lrYFSl7ws2BDqL9Bcl9Q6W/qeX54Gr1r7RNouOyN9o6OqzZcuOqV/wkN4rjyDPPb6
 UpmU10ga03EpY12RXRY+/QVl9dBvu8D5wqvEFenH7F8B8gf7iZQX1EvtKrQrI4A+/XosrtnPw
 ZD7kKRqYRlKWDxcAUgDWtIPBDajMv0K4KjxI8/QSzRbK2czT0q5h+9jchlEOG5vE/fkba+s6X
 6lwSZMQUulyVnU/ZtFmTl9aliGqTUffY3CSn4oZxF9F6zNQBdzoz9EtmwdqJVrbuoHTvy9lMz
 mSaD28Elr76TiuDUFdJxeu3VzbDGLejig2vw6Qc0TGI3mitTV0XG16dnVcbX4AHcZgnUB43t0
 HrYnfV8sqeGYU1hcxe9Ylqo69MhtanojWbqTMppmAoCiKMhM/pANHOII1KcmEYCtdVj3rlmca
 gJgGy6e5YB0ucnTiAM0A/nSxtRGv8ivyfLcxLSqkVl9AgbHI3o8OZvW1oAdY6uXi3rCYGUiWZ
 8yw26klE=



=E5=9C=A8 2025/12/11 17:47, Sun Yangkai =E5=86=99=E9=81=93:
>=20
>=20
[...]
>> So we're calling btrfs_get_extent() again and again, just for a
>> different part of the same hole range [4K, 32K).
>>
>> [ENHANCEMENT]
>> Make btrfs_do_readpage() to search for a larger extent map if readahead
>> is involved.
>>
>> For btrfs_readahead() we have bio_ctrl::ractl set, and lock extents for
>> the whole readahead range.
>>
>> If we find bio_ctrl::ractl is set, we can use that end range as extent
>> map search end, this allows btrfs_get_extent() to return a much larger
>> hole, thus reduce the need to call btrfs_get_extent() again and again.
>=20
> I like the idea to reduce unnecessary tree searches. After reading more =
context
> about this, I wonder why we don't set the length of the hole as it is wh=
en
> searching the extent? So no matter how long the hole is, we could just r=
eturn
> its range in one search.

https://lore.kernel.org/linux-btrfs/CAL3q7H5x+t_P=3DCoxcvmNLr8YKM-pUF3mAUi=
ZBUkdRN3oN+273A@mail.gmail.com/

