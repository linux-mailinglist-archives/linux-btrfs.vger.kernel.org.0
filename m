Return-Path: <linux-btrfs+bounces-16545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D15B3D806
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 06:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B68418960E4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 04:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854421C17D;
	Mon,  1 Sep 2025 03:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GUTgCGk2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D04153BE9;
	Mon,  1 Sep 2025 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756699191; cv=none; b=ryqW5Fa2YawupcycoEQQFiTRAec+I7JCBHj6FnL25mStkS+a8GNcscAvnOXBSSYrjaiLNyAcdUOS7415pOmMt1ct64566ywuM8JirzNKmkrlMYznBfv7Fo1DQDncf0hKtEEIcm9dHngRjaDmX7nzJlzv9PE8xjjwSwysbB7YrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756699191; c=relaxed/simple;
	bh=EkJ9fGsyfck66TR4y8BR5h4E2eqiXcOaXu0XRgkdkSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AZ5PbsAhABbO4L6nX5IbAIMjIhzh4V32oTP1Ve0CJxXaEAQ+y/gS+d25J5JnJp2UGt18VTtk/kXiqj4KQVAlS9xQ0ysFUPe2MiZ/8DxB83t4PrxOBaCDxVJepyuvpDrV5rwzWsLi1h7oPurN+Aj/jSv23piPR2LDk1QcYezA5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GUTgCGk2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756699185; x=1757303985; i=quwenruo.btrfs@gmx.com;
	bh=FgzqdPjeEsnbzYFgcWySlkS61dC13rcrGJNrAoQqxRU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GUTgCGk2HJujLT7o4c71aOjgUrY0z0ohhTC+YxMayegN9PQoC3Q/sS+en346GeKV
	 Qph2Ptkk0Ae5zxVJad5FL+CcRjO9PG7RIDmx6sk4bEXxrvg3mBVMlFpQUbXPkBxF/
	 C/k/bEGDPl9LFcA4TNqvT+gu2CdvV+AmiJ5XLIsrB5T78dSbAni2ELzv4dCHnVRTc
	 rAMCseHSYLzuOlBbjCqLCBDBz8E+bNNqOIPSidqY3nJnvOmYNOjLWko4LuSdIXbwq
	 jV262Q08pNMZKxFsvGXD8i9RlovW4Z0roHw+QL0QqhoDvZ1KQMM8RroikYBOarO2Z
	 AEilQZNyXFaSq/ebQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKu0-1v41X61bei-00IHFK; Mon, 01
 Sep 2025 05:59:44 +0200
Message-ID: <469e3880-c9b2-4ad3-94d3-2afeaf6d03ad@gmx.com>
Date: Mon, 1 Sep 2025 13:29:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: generic/563 failure caused by losetup no longer handles block
 device anymore
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <db593e62-1d57-4d11-84b0-18d0f49cf0e4@gmx.com>
 <fc1e2106-2974-474a-aa5c-89178383f4be@dorminy.me>
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
In-Reply-To: <fc1e2106-2974-474a-aa5c-89178383f4be@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tXeQKDecccIE5UaAqlhyu1QY3ugUwmP+fIZCzl0nT4/P95ag5cu
 15Jf75pgCqC7dVnPdnS72nCuURldNyojauly7HP8Wbia4T45D5D6Th+NtyEJVimr+6xwZw4
 qTD+/W5lGsuFGyKtepDN2yZ/Yp9ZCQawgAUdcoQZHScTqQgoSU1jR+9/1UT0BKl+VKHew78
 bDlk/u7vvwxBqyplUZRBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8yWIwI8YS3Y=;CamuvrRhSuV5U6qOPXLkq/0pIiy
 olE6NTYGOg6BN4blnqRYyaowQOBthNrGUzEdeSyDJKnGKBciuP5hp9r5IXPHMmgiB0YabEJx/
 ceMmqqgCmu2hBAbyiTLv6i84B9bivxuwh6Yi5Vg5x6C+qDnMDXXcjg+gOmlM8SgeSz00qBHa7
 3iKniM/Eebl3Muxqfh7ZXG22H6bFR3LMAs/mM09X3sjDr1lwNF2TMnml2pvEDsk8y7Q+/v3nW
 f8jeIAPOia38fHA9iA2ecAvzwBSRZHI4qQiwUPxH6aCvZRsWRk+t3KDeBCzqWCDFyrOl0zCux
 WD4XxiY5qjhQySWWnOMvWtGI2xKQo5eqUQ8Peexs/IxmwmDZ8iHjEi6qzkGjQfw2IX5+8Qq3o
 DSILWcxFBe6CIURc1qocT/TL8FgXVilyI+RaYamF6Nf7BCqcEppJTk0k4gDHyP3StyO/vCyT5
 GA/Iij0cJa6iSZlHaEzVPsbORa65EGwyCElgsW46mQTjbPS8BO914T5+rAfIZHc49lFs3v1fk
 aBTWNtB/MtODdhzBU/0ZsdHP7w/7gRAXgWtAZyn5p2yhPQpakps1x3+FHHBk9XCJmwwu4cQTM
 WOiDGHdeFu5cJgpwQdsO137+hwg3ioum4LIlAH8NSUlqOhBuZY519hXVZUz6w/aHBzm2UL8zj
 Ak64b51MoPNM6jEyBbUno1iWSsuktjoMkZaQ9fUSPaFTcSK3nTDQH8rWbgjwheR3PYFmvQOBK
 C3Ac817hiumHm0f77rDzxKAwbHL2NInuWMF89yQBGUQxgiVfpg8Ethlgq2CGOcYq50rFWFmBZ
 zMEwastl279GYByWs4IA0S21VIcc44X9lN06U+Y9UVb31Uwf/AH1DJz9lACNHrGBcbdFRBnOu
 2TcZGhEi2atOoSozqwfpAwfyfYg1GpHC4f9dt153VWC7Tk7MgcVVrze0DyjyEUMdPN7HDKCQ4
 Kr2lss88NDPcUhqSe5T2awFSNTz8o5FQUlRFGVPRPlFzbCFyMKd/ZfBDhtE2Un+N+wF4bvcGo
 dxUI+5m4PZEQfIPEQKbx2/ho26knGrqX4GtOVEbpe1NksiLJczvdaX5sFVgQel88FcGzIb27N
 ABbsMDgkRRrtHUWKVscCrdfVMRn5igTpSEqhcjnKSo3wA1YZ270+o96zqdALuk1V3Ds+sv/uj
 IpQ4+7Z07NNFkLJAiefPVqWm6MByLeS/ZGyXHBYcBpbZIZUHJzuahZEJ705GNQtlKh4N5BRpe
 scOHQX0ejs00PjZtNxVMUkQIei+gL5ju6/bL+Z3BAQkCTS7+no2HZe01ATbOnndrjuhPbDD1c
 3JX5xJmp1/GSkVYgggMvGAzwy7QybOMgjjp18l4EIGRLZrw+Y5nSRiAO1s78F+UTlLb8AXLsP
 6FvObDHEqyG551C3SSYh4608o5K1gdjmhwOzNr5KSiqmBPGuv81jerrk79tx7a/I2L0fr+wKo
 7i0DA0yrGAlSLZ6Z5RMH+SEuhEOjl5GseH7+yRLo8DsMKDbZYhv77nhBupwW5UMNbFaQ9hmj9
 7rmv0czroNfB9YLb0VoHPaqy6sQtgz2gScKm1cMXBWkCqw0mLZE2yK3MISTcT68xE1g9IAbLG
 UTHrg9EZn+W5v0gJ/e5rvJnr6SDLF76/H9WAGLvRbL0LOhUYrEbkwBruf5KKzy4KOSUzzs+8c
 8kBd69ia3fpNS3/qvHu92gxyt0NHirW7oL/PqzA38rBxYh1En6DjOEABVb8cQmhqPmw3AJ1Tw
 uB3Og7cq8Wxyb7EETcGZpNpXTfgmb7yHQFW2kisCJM7etChXexvFwOgWoL7JpiXUTENN59w1X
 aVTAteQn/ZASVbEL4ccJWiBVjGgGTUS3Jmbydb2erx1T52++iErtvvwVd+1PORVP515JbmqGm
 2mQ5povtzEv+n4Q67zeGHCPAQr6oOTeqoLPICnbt3A93nnIRDwjmdKGlOxIPmyE1l0CdPLgPd
 WziAObjnpQJtuIFOfhzDL29fYftG6i4tBrKxR668A7EC8uTELs8IKM0DV0Ttn7i4pFHt5J2zs
 U2adMHyGqnr2Pua0I/5pxjJ+CH7hJbzpeK8QCrpVpO7mFp8xqM8X9tZECmlA53Na39BvmMaJh
 W8Oe+DZPl+cVPT59QbOZ3fOSy34JyyP7Ud2kbKm3eVY0+KsuRojZ+2VK4eVi2ehZxvB6scoVH
 0rAEvOmbm1yzYx+zl1oaRVHCd0xUN/xaL02g5e142fR1xpJCqNkKAbIkPzKot9UHK7xI41B4H
 gyVmRUJxu4xgYwqmjytqCy1rG5NM0I/urk/25Q+kZC29j7oQcsGEXTiPFGGqvG5PcYeWM5euG
 s09vbnYRWP1o8Z2TbDvkMKRtI3Hd+qTwFidkoGV2TPn1H8mdCx/mUneWBRTJH4MmSe+tLMX1h
 bgS2FyAWHkyUdEpE4guuz0htZGYoQsgaEaqDWAQDdLoHLygbRwAJ6h2p3mp72F+RnyxC8WCAP
 H6g9RKsRJwR0dgud/MI/y6A5c/YiP2UigFSQjRgP60s3M1WTo6XLGELZ3lS4RnoogM2wvifsv
 LWWWTOr6mrv1PhiHgvNNwgjWPc1J1Vn88dXRVNt2Sr3lvVIq5PN2Ed+QdPPJltCvU3LLhx1z7
 ZNOBoXdzpUp/TKmozT+tYqE6b3UXr94ikAWMVcfZ1ymdVDR4ICE3Mr42YyG2xfwFLhxtGg3hO
 l+3mZqgLSESoymKUDDjLnX9MFAnvX9ZcVH3gXFZ7s/CqRRji4NMDTYPejHMlKio8Pe1G0B/Pb
 KjSSgwDHu4BS9brhHHXTVzsCaQTbdADEUz2M5dAvFNW/piiIoF0rPU8jpmzTfnkVpPKHZ+2AB
 etdeY9yzPGoQT1ncUUeGEY880AFYoqZmnJdtBr16f5UcoU2/EReWProGXEJIEVnPH8X5Y2n0v
 tk0gowLLmlhlmoex+HRVIMhYQIiypDp2Ew5dh2yse8QUKNX9w3coys8tb1iiAM8tBZpm5fkXU
 fqPU+crCh02BwxyKpd6pc4JTmKMXHp6pIifztBYkkMyZusCkfMHR2JyPg66u2/9ZgZMOW88yZ
 gTeyMSFyDHBWQZfSjIRSzk018G/i3J49vYIyia7hi52J2zzVSgCp6t73SZXUc64CkJkbIObH5
 CZf93iWLONidWdBplXWEfVcYc2VWn7+dGwBBPdPfse91xq1FmNiC65NNLLC2XTfA/qNAQddp9
 M7LJ8/ksXu84t7sQQhYx1ddoKYGPXkOngAoHk53N2RtrHj23rQpI+EIRiQqy6Fex0/qQxRk97
 zdFeTQlnsb1SeEre0MkQEABTUqNrIkv6+oqHZz2m09tpYzWv7TV8d21fZqrhx0JN+/CFn/dht
 +UJPR7p2tx5/VhbTVYv48EyOT3w1x7F6F4lHgMI8gdA8GklE4p2RBdXTSHuoaNS/sb7tSmu//
 Fj7iXHb4IwgIJoy0QWqUeJ6kHrS7caOQoLQkmO0l0pa+v/9W4j1tL4Omrtlgb2Im8/BspwY58
 QuDnyWeckiIIByS7Q2txjX+eqE21diRXqx35if4Sl7fU/Z/REdSrKT4tCo9Ln1KO6TIuGCu+U
 JUkvaVOi05XDbbBXYkleScLGsJ9cn452STYtqWorDB0QcgPiAkv5/CB2izcaYdRlI2V3YoMRU
 RvwAn3ez0qUeAWigSvGFBFgutsFw0QxcuYiuWjLe/sGJU3V7HDJjNAErxghpAqLLdlRFpspS9
 87mdUbP1z5BEt8pnLBovh2ETo8ng21uWmDp2Od9qAhyLzkZTFthuxbrhdg2oaIiHuhHY1VSQV
 cVXtzaBOYPNNOtL/z7U4lFikixBI8GIguROlmo1k3hI1Y002IEcy0qjhi/RIUvllbEdHJeZZ5
 VmrB4AnUDgBVmWU/H52T1cGHgISA5QZnvdrDI4JWVYF8rFMqMC76hhHsWfvckNBXQV2Y85SQM
 4MX1qG1VquFHLAxzVPvOEP8KcjBx0GcQ5Pmn7fZkYWQoREDRFX77+4lJAEWoLYuO9OTLkRqAy
 kvonpzd1QqgTNTYLAnhER1rsXQYFllJ01UurczC7OWCJqFOWjk76qy+iyGxDO2+N3kwdDGdem
 OJ7pr/+6AxbD0hm5vOTcJX+O6Do8IlqcrS9GleuEJyGtERD5n9b84QeyJ/ZMbWKBOhmODT37I
 y0acyQxpMPmTox4fx6826DJpWXpYtzIwBGUEy42DTMgecrjydhpJa/XC8vZR9lXWJYcmuNssT
 TrcWvaSNzv4cw5I9Nme4KpZ5tqe7R2xwdXFctbOI1N7fUCqjXrOQAG4ryckfgHiViYkwjAzku
 hhzADh1jiv1SxHvIM3HHlhoO5YgvvQKkztcHhy62FqfMRoZVEH4wBmmwFryWVjFRp7bnlhp+N
 +NZ/ZRde4ZZxF0ndnt1bk3AAb0SztZ+2ULQ+H0SYIAKFxYwlUqzOAmejGcrH2CkD+JbFlTTTI
 Zq0JOxL3W0Mf3IqbqtdKob+krUgOPxEC4ZP8cSmeu101PSuJxHzAaqM+OGY9elkx9bbSJF/TT
 1WjP8S3a0WRukSTDGx5nCBouCw77FRVhaaTxwChPU48uY2D/2XzevmM5p4EwPSkE9d0OawBUE
 bc2htwAGArLqQ11+Gd3YPHtChLo5ol2YUifqjr7twLOTZABSFxrZINSQUCi1RCNpsztwDBvol
 V1WsqaSMAQmhvotK7X4B92CcbHcIJsnjzTMkPZCtqyDdKTiOEdG6DrhrTAxB11FttV9fYOHqM
 tu3gCQ7bknanAe+EoW+2kVpekIEhCWQIvaeG3VdPT2Cy/z/4Salw9N0+rofs8SbcZ51jIkGLf
 khM6UgdwXlNaXw+nkXAzEVWwHUCi1Z9bliRcigW+A==



=E5=9C=A8 2025/9/1 13:24, Sweet Tea Dorminy =E5=86=99=E9=81=93:
>=20
>=20
> On 8/31/25 8:07 PM, Qu Wenruo wrote:
>> Hi,
>>
>> Recently generic/563 is failing on btrfs and ext4, and it turns out=20
>> the losetup inside _create_loop_device_like_bdev() is not properly=20
>> creating a valid loopback device if a block device file is passed in:
>>
>> E.g:
>>
>> # lsblk=C2=A0 /dev/test/scratch1
>> NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAJ:MIN RM S=
IZE RO TYPE MOUNTPOINTS
>> test-scratch1 253:2=C2=A0=C2=A0=C2=A0 0=C2=A0 10G=C2=A0 0 lvm
>>
>> # losetup -f --show /dev/test/scratch1
>> /dev/loop0
>>
>> # lsblk /dev/loop0
>> NAME=C2=A0 MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
>> loop0=C2=A0=C2=A0 7:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 0B=C2=A0 0 loop
>>
>> Thus all filesystems, not only btrfs is affected.
>> This looks like a regression in loopback device size handling.
>>
>>
>> What should we as the next step? Waiting for loopback fix or start=20
>> using files inside TEST_MNT as a workaround?
>>
> This looks like it might be the same thing that Lennart references here:
> https://lore.kernel.org/linux-block/1182267c-=20
> d291-47bc-8e5f-2e11aa93421b@kernel.dk/
>=20
> Which should be fixed in -rc4 according to that email.
>=20
> Hope this helps;

Thanks a lot.  With that fix applied, now the test passes again.

Thanks,
Qu

>=20
> Sweet Tea


