Return-Path: <linux-btrfs+bounces-967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BF814079
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 04:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DE41F22E48
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 03:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040EFC8C7;
	Fri, 15 Dec 2023 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Yj4Xdp/D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71498BEE
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702609945; x=1703214745; i=quwenruo.btrfs@gmx.com;
	bh=jimLw5oHGanbnxEfFxRsyKH7t6AItRTJEDB31EztvcQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Yj4Xdp/DL0czONeuDel+HDwnJ3l+tENhJvh2AA8sWmJ0gZQ6miK5LxNONGk1QvF7
	 E39XgevS15bA6zbOVndwpZkLQaaWf4z7IytA7e3AvtwO4Odx+skvv3/W3kMyWorXe
	 RWBgkO2+Sar5MtbcBhD4vIMaFQoIqnSlkAsI636522qHvV5I8FW4JGT+UfPlh819g
	 nOuyg3DiTdNvzceCtfZpyq8ZIHt8FsHfj/OGfC1hhn0Dn6Prm7A+xwVBGwe8SVRCV
	 7cx76VFZWetgE1WioOT4BbaQ25Zq48aSCHWXSqgo4f8c/2AfNPPKGFN3UpbiY9hjj
	 NRxoJLunkNslb0Gi2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0G1n-1rRGHP2RUt-00xMN2; Fri, 15
 Dec 2023 04:12:25 +0100
Message-ID: <a87beb1c-a787-4e66-8144-2c76bc5e40e4@gmx.com>
Date: Fri, 15 Dec 2023 13:42:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
To: Chris Murphy <lists@colorremedies.com>,
 Christoph Mitterer <calestyo@scientia.org>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
 <ef38bfd3-5195-4043-8ba4-20daf9cdbeda@app.fastmail.com>
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
In-Reply-To: <ef38bfd3-5195-4043-8ba4-20daf9cdbeda@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UUEGSlwSxQD84McdM008IS1pVN4VNyPwEGXexTv7lv6MWctuc+Q
 qPidOuWXevU1E0ah5z5v47NMXE8UGMCzw294X1SZo80ETJbf1KUMAq3KKgFIZxpwnJzM4mg
 ZhwEy/ooQjtBIwetMniLxpSyRpxn8v1MbloUhDoy1YaxIteIEK8LC5IhYdCvRIeR8AYFGYV
 ssLMfzk0ePStWfh0IQo3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FFE/6suw0EU=;uUadknw33XiDPXfD4HYHd9u//NW
 I77RA1xPJvlJuD+rrC8nrIF6LSk5PU80nPpIhEXqWSNUtpJRpyqS0HACk4vOKudBDK2c0QFRV
 4Va/3iAy6BZtn7o8157Oz+Gy2zIJuqptaTvUcwtGDG+ZWE7DKckm9tM4LbX6MQqURIx0abZWw
 twMOfOx0M0KdvVf52+TlHprRYGZctw4JzwN9dwPgPAc1E1nUevb33BVzel2+GtaDZna8/l+rl
 3VUoHGXwVytySkCTXLbdzlfxJMkE5V8ctpGY73oYbcNnu29rRaC1x+dfxP98ihI57KsWt8nMm
 hePUviIiSQbH2KX9K/P5zQrh4+H91laefD32YCQ5CYhFMeaBYNhdo/mQTObl9J9qEd42ajU0O
 8SzFmXjJNdoVk8XuSZbyDMdU05Ye230lrr3ru/9Pbax1gMYyt15EwbogcrzFCdC7B68OlS85Y
 Dv3owUW70XAUAzK0WHpG7HegYIs8tFCwpJ3JAqmPIvyC1ZfDFbQYymXrk35i62FLMAJTutt05
 ErDN92+0S0R0d3CpqvJS4aK9ebvlBrTqdPpDfrFMe1iVpAaFE+p0mrlER1uA6NQQDuVT2xPRX
 Rxjdth29EjMOvt+8hWTAlIA0vlhLVNRmoCU1nIzC4UY9HgyZPm0w7Zl9nNLX/dal3oQxRbyHE
 PdqtjxY9EgF925Lf9drGR9Xhl3V+sqswEjsZ4cma0Fd8kaT/or02MgBM1yVVsaSdiod95Q8JX
 AZRBbQLTO60xDPDybmKgLM34eLxGphyw57YM3NhALe4R+IGdaMMXKHt6cnB2Ig6kJsn03je0W
 t4qGqkztX/zAyGjBa9pbjp+L17St6rGMB8RJ2FVEgIWYLr/QS/R2BiBA3oWc7NKUMgYaM9T85
 Aa3io7k5hvu0GIC05fZ4q0zFdEGThEKnSJ6pKo5iqQ0+TsdI5xbwxAaxQEWDdnj4/aamMalKI
 uDmKY6git8UTh/GL2x0R2zFXSQY=



On 2023/12/15 13:03, Chris Murphy wrote:
>
>
> On Mon, Dec 11, 2023, at 11:13 PM, Qu Wenruo wrote:
>
>> IIRC we can set the AUTODEFRAG for an directory?
>
> How? Would be useful to isolate autofrag for the bookends and small data=
base (web browser) use case, but not for the large busy database use case.
>

I get confused it with NODATACOW, that would help a lot as long the
subvolume doesn't get snapshotted.

Thanks,
Qu

