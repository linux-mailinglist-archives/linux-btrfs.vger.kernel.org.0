Return-Path: <linux-btrfs+bounces-1110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1781BFB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 21:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C425628AA05
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2EB76915;
	Thu, 21 Dec 2023 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bm2QSibt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F0760B8
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703191307; x=1703796107; i=quwenruo.btrfs@gmx.com;
	bh=pxfEGc6vbRkuoi0YJ/WNu6KgVqi02hR+f0C+i7zNWzk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bm2QSibtBrDh3fHYiSJ7ae4d5wUtCespnTegGb4wnI7HN/FE7xfJEdqfSUsre8Nt
	 o9bJyDTIhr/vpyLGlil9fQ0PLk1xKOqHNk6V9sG+I60XD3RteZZI5l5XW9e9h3Kv6
	 tqzRpEEsWgobvyXoiqAmKLXDbv/K+y8vQC4dvf7V79N0Ps+gchezkjBHSE/Yke8QQ
	 KqGQgMT1U68lNf7aNucW08gMTrdZh5c9QuwkuEssuuSiSAZfRa2Jw9fBuiguTeIyK
	 8jndnpKTK6Ev2u4ofmcP1nJreipRjCaS2WhsxsnrPiXekEjHSteL4j3JxtO7/YHy+
	 ISY4XHiFVkR+Mr3S/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.114.154]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5QF5-1rFaut3Kuz-001UPc; Thu, 21
 Dec 2023 21:41:47 +0100
Message-ID: <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
Date: Fri, 22 Dec 2023 07:11:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 Andrei Borzenkov <arvidjaar@gmail.com>
Cc: kreijack@inwind.it, linux-btrfs@vger.kernel.org
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
 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
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
In-Reply-To: <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZqYHgV1/gnj0/9O8+pymWkAEF6c91w5zSY7BGB9LGFRP1S4V8/q
 IBksFwKuKNOg9SuGv6neSANkFoFw+6NKEt+yg0zWHFgQIgi6iIqIet8pTg0WRI2K1e1W34l
 571GiPXNjICd4nHsW/yF7hELvr6TQPDQuS8NSlzVVzt+PTjtXGzKoOyrx1SCrPsklW8Wjya
 w453ye6wuGR8bVZcWs6iw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EOsnoRGh5SM=;sRRQ2HQ3IyRiW9JLe4uzXJi6qpn
 zUOVVsFnGNXgR8yYwedOzpbziQhQ0xlfgTjgR2NTNyxNLCd/oCa0DMfCHYqw7Q0jdYKkhc7bn
 Nvu8eUeojq1XnRYrSl4Iq4rKA1ZoHmNs2rnlt50sWQ/CyqArvCp9wpbCmvaDe4RfKOWmsGjuX
 uCSkCl6ihjOfdzDVMSqZThASS2HKywh4q71AYjkYCBBEa1jJjfzN2cYCcIPv6g81l8H6J2CZK
 insf15M2VnSigmdOKe378zfR770jdht9SLtLW/Jsjw+k77eEg7zYu/0Md+e/a6l5Bg/MbThAq
 I04YxmnHZ48QjG946RLvGqvFvfR5PFlbcsv7ShAMm0xAHsbE48AuS9Va+TwpDMA716sLzKc8m
 KYU5rFQLvGrQqnXFbu1oKnkGQLh48541MLTVbgZAQs6BscWPdOkDy6md6ZinPUttSy6mlSONc
 KJDGctfWE6FAppftxhAUmUL5oNXeuij5h/bMTn9l1yu9gysg/RaEOkVuCRnsQL2vNausOgWy+
 eeMKufgGNyCCp2JgOXyHu1HgX+0gi5/ZKnmMRNfznwaKk/hxwc5cBOoUaWABZoWJnpJToRRwI
 aRTpBzJeBS/4k3PdNJkQ8SmqL/zw+bDCTVzOuJp9SMLVb2wRT/t9TMsHMCOPsz/PWOWLGXsmV
 ix9IP653SUkFLJCXdNMNMM3PuU1pTYGYD3CmMKPTGcmPqxdeNKJBi1+fqBfkzB+3OeW82/nHz
 rOgwKjOQrLVE5CLt9ZPX8V9Zrw5hvzSnDoIrPoK41kr76l+CtpHIC8JVDtbcUGMs6qMcaHkuK
 MdmfFtbGCrNtINs2UwPKWalQoXV77jWnGHO700z1zdzAkJdyxIVWJJvWB8tYKHCzV5ihBniou
 bkpXvrcCvPXvbvwn0G3zUijlCL7efB+yNgob2arJ9PlrVw4xnnSJKlQWscFkSzyXFj65zQ/0s
 Up9rBO2OrrscDA1WIils7p4ZG7Y=



On 2023/12/22 00:16, Christoph Anton Mitterer wrote:
> On Tue, 2023-12-19 at 11:22 +0300, Andrei Borzenkov wrote:
>> /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/0000
>> 01
>> Processed 1 file, 1 regular extents (1 refs), 0 inline.
>> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 D=
isk Usage=C2=A0=C2=A0 Uncompressed Referenced
>> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
256M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 256M=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15M
>> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 256M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 256M=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15M
>>
>> I would try to find out whether this single extent is shared, where
>> the data is located inside this extent. Could it be that file was
>> truncated or the hole was punched in it?
>
> How would I do that? :-)

Grab the INODE number of that file (`stat` is good enough).

Know the subvolume id.

Then `btrfs ins dump-tree -t <subvolid> <device> | grep -A7 "key (256 "

I guess it's time to add a way to dump all the items of a single inode
for dump-tree now.

Thanks,
Qu
>
> Thanks,
> Chris.

