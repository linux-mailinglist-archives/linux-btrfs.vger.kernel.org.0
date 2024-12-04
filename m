Return-Path: <linux-btrfs+bounces-10062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003059E47E9
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 23:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CB028185A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 22:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA01A1F03F6;
	Wed,  4 Dec 2024 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GplG7o+d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3F18DF6D
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351685; cv=none; b=QA/OJzlqEGdWkhVaDSGkOlhfNTROQvCFPPbsm/LTbI4tHTH32daxx/TzA4MC3Rm4/mtPyzrtjBWaEsDBGlHJvOXpTsq5GNqgF1DSUgNnzMqXfgpAA0yziwp15zwsyQDBqHCwAVvcWgtGAyjXJ+Q06A5o+UBFR/eWWTh8ZdAwJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351685; c=relaxed/simple;
	bh=KZPECitkvZ3fULIGmTA5Ad0RvFenwF4zQrOk2foYrfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bNXaAGiYOs8m9NXYFJVP+J2l9YdvVmlNXJ818Ziep+vN9RM4qCE7WKz5wZ9olHdXBwMbICnmMHhJDldO294dNxlhIVgn+HPOxyM1IjXFqpUjNgy3x8/A7boaYJP4w6eqVLxSioLPbtdop+KHyRPfrodukMqgGCJY+Vxl0lk6Q9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GplG7o+d; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733351679; x=1733956479; i=quwenruo.btrfs@gmx.com;
	bh=KZPECitkvZ3fULIGmTA5Ad0RvFenwF4zQrOk2foYrfo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GplG7o+d6uJrwnyhDq3Pj0AfDLEayPHyUla7o092m3KRV9veOexVmxbhxxQjNhuU
	 UXp5s1BlPGVWVPzExK8HID9hDzqvpNpOtbqMGHh7ZuJZuD1LquGxsw0JMXoHl3Xds
	 ddiYRnRaicmQ5Rk2sqXzQlvDxo6cyXaHGkekQrR7jIwEz7cqNjC0hM20erg6gmd1L
	 wVEyoYDjfwyK4IhH7KleX82ar6SCRs2GKtMOYx8BJEf+Q9P1YO210Mw1cWzouuz32
	 HgYJUh6Zq/wh1AmyRSL3wH9C+lqDhumFpbj9xELwRfyGCtmYnpr+VnyMDGfwD96np
	 qKsE1C5HOZr4DevVCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPXd2-1sxQvE0zkw-00WWXQ; Wed, 04
 Dec 2024 23:34:38 +0100
Message-ID: <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
Date: Thu, 5 Dec 2024 09:04:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
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
In-Reply-To: <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PJ1s6tfwQIOtyeQDyuCs+UbEhRCOBBWJQEsx3oLthvuLvuG1BuF
 eDBOR6UZNBbbo6QiLWbeLDWVeoctwIvXxeG1zBcgjS/Gu140B5MLq6duxshmMB4PmRgNPb7
 E/Yo2HBg0n/nXu6SzFlPCZtQ8eSYL9GT9hqL83E7SeKSvzWcx+XcbiygBB40NVW8QH+UVfH
 DkS4svb5D3/dl96HCsVCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RuONW1rEh80=;qE13RoE8wBv+zqjovTtDSj9q6DJ
 a7xh7ZEwGbt1YvTLXWnnx2BPc8ZXrrTFcPdIVQaRK9ewKEE/smqTVKB+gaRLjDuCkkynpWnBr
 LoXci9BuutE8BF/TTZ8/sQLvCpTm52pm7np+WsC6CYnD/ixz+QsYfGSB7LzVjKkRG39+u+o4H
 9qTnBnVgzPRxmSN8Vn853xUVaOh/iAxqzaFxng6d1IBsCPAdsvQKFYExAEhha0uhToki1xlmx
 NtuKaeF2ZrHlMJYTBuDi5S8E+0ozil5523bzRT4Rw+8PplW92tGCJ4Bl2aCVkk5KCgtoHrahy
 EVD5oa3JswddDwFJ6YzmcSP1fM031QOK/vbzH25mYHS01Fwxr1iUIR/yGCxdPEnZYB/ik5AG4
 Upc30XYRpw7dbyh4dLpIzSi2ODpXe9pVkIRLmyo/Megq9S41M+djOmsm10X3Hzv/ADuzrzPCp
 +w/XZyEGd+hJxaJqi129n7jf6ko0ZxcoLTPphyJ7K5H13e9AwW3F96h+cUwk0k1xP2wpLY5dZ
 j2hogMaL4mZsJSiXYWodmpJVEUrQ0K4AtWDpjxxVJkgkXNggg9DcPelFJIRvYxeArmqdhlYpR
 Yf0IlxJwIKTdYzWE8ryCAqi2MBFenOQRY6INpr+NUSI/d8UNq4qGU1nN00lYywHg73UoqwH7U
 xPJmaNY7SYcxuPLGPeOD3ITYgep9E2EK1eXC2iwpnfohsmxTTeTfR+PAWN+TdOo7QZP8SRLQD
 UjKkPUE1S87bq4CDJr8L/RbzgwaCXiHAZIyr4B4DYcXrazPnWwPnnmc5Sns8almMUVCgNf0am
 XaY4Au1/+sr+0L/9q3JiTGR5fADLkmcur2AXpCcnJj1KO6laOoDEAT7m4UFi3EzU3SdjOBm9y
 j7hCCMrOAtIsqg0pjlgsPfwes2S8U93rnbm/AOlzVtW47bY0zfumGlOF+7ezUYTqdGGARHOrK
 oA0yuAsGEAi83kRftJB8Z4OkMypvMs2KZ9MHb3SywE+5Zhb2w5Xr2OxazBV0O08T+R+pUSIr3
 PYCOAuiL95OkFYxL89YQv7YBGsjHNtQMoWK4GTjlLQiszMzhxdrTckr4GnTO0ZdN1CTTD2+Dk
 9Tv/KzrpsAGWnT4CRX2fSGI2siLSX0



=E5=9C=A8 2024/12/5 05:47, Andrei Borzenkov =E5=86=99=E9=81=93:
> 04.12.2024 07:40, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/12/4 14:04, Scoopta =E5=86=99=E9=81=93:
>>> I'm looking to deploy btfs raid5/6 and have read some of the previous
>>> posts here about doing so "successfully." I want to make sure I
>>> understand the limitations correctly. I'm looking to replace an md+ext=
4
>>> setup. The data on these drives is replaceable but obviously ideally I
>>> don't want to have to replace it.
>>
>> 0) Use kernel newer than 6.5 at least.
>>
>> That version introduced a more comprehensive check for any RAID56 RMW,
>> so that it will always verify the checksum and rebuild when necessary.
>>
>> This should mostly solve the write hole problem, and we even have some
>> test cases in the fstests already verifying the behavior.
>>
>
> Write hole happens when data can *NOT* be rebuilt because data is
> inconsistent between different strips of the same stripe. How btrfs
> solves this problem?

An example please.

>
> It probably can protect against data corruption (by verifying checksum),
> but how can it recover the correct content?
>


