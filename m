Return-Path: <linux-btrfs+bounces-7054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF43F94C6CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 00:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B39285937
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 22:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53D015DBAB;
	Thu,  8 Aug 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hmqBjvIb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246B154BE0
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155032; cv=none; b=g9dFOOwd1Q1st/Zjb+JYaOMqenIiheMW5uSvq0dyxL4doL0FNylOga2AGb/qeQEFRKGu5NtTAKIuYPTdCqsFOJlngAwe/KgRJhnR2uxdM2IxDszxtNPHs46qFKnPEWgu4RKuBE9FuwZ3qrp2ZRmSFBVhXSvXscT06hfQx2Axdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155032; c=relaxed/simple;
	bh=5PKj59AdfHAM3veNQoF6Q9uhQ6rGbpRVaONd8PC1jcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gckcj02WHVKMmeWqbaC6Q3crbTx8ZRG29hzaVsr4POU2J4lSiltAiZoMBP6cHPxEQdloR6u9cjdXXh5NgISTwvNCuB8G2IBLrs+6Jgx9xz01KBc/nSItZNYBcHe1gbcvKLcvrqXiBIUwN3UOmJRVFcIBrYGJXBXF7wOhUMSK1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hmqBjvIb; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723155025; x=1723759825; i=quwenruo.btrfs@gmx.com;
	bh=5PKj59AdfHAM3veNQoF6Q9uhQ6rGbpRVaONd8PC1jcc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hmqBjvIbMPpED4Sp9yvk6agvGuMkxBGQROlR1MqJUPJSRVwzNDh67qMCAIfji3fP
	 tCidsvhT213owpzudpRADK0xcAyl7OhAaCS6V1Sknzjxy4y0B9pBG7fGNgEhbm5a/
	 ktOHnxcaOb9uN9ZC5hzHHuM+I5gEaMTZV7mJ3mSHQmYsp9LwjNGXVSGpwn7Cw1hEW
	 VwtStnB4JktHYk9sYSi++0PsfzBIsH/dsqcpPkmwhissXdDlIhoDR+0oPyOqlAWVJ
	 zS3vnhho6bCT4MgLFWL6wHWe/8aVwUMhlcAfJaxNS3HjiA0kSPzQ+34jVRCSVzT6+
	 agpCMrk1IRM9LVr88A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXUN-1sstF80KOd-00Kw8C; Fri, 09
 Aug 2024 00:10:25 +0200
Message-ID: <722d228d-7607-478c-b531-54688a74ac3c@gmx.com>
Date: Fri, 9 Aug 2024 07:40:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] btrfs-progs: add --subvol option to mkfs.btrfs
To: Mark Harmstone <maharmstone@meta.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20240807151707.2828988-1-maharmstone@fb.com>
 <80981aba-5434-42d6-9180-5ecf2625b3ba@gmx.com>
 <231c34dd-43fc-4829-82d7-94a6f9886691@meta.com>
Content-Language: en-US
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
In-Reply-To: <231c34dd-43fc-4829-82d7-94a6f9886691@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:wiPdQUzC1lj55bPQz8VoZzVF4Q4Z98S6hEVfgso9eQFzmwS0UN1
 SyRV73KAJUaIC6unCLFiLzs+UmnJVZqbm+gHXpLYkTWo8lHYH7Rz/irXPBqhEhDDgyBVIaE
 /i4Lm/5Px56V8hKGPcwFr3RsPlPFJWDZ8qugiABU1aOc2a2jR8n3lJOYj7R68k5Rm+o4QB7
 fav08HyOfhXo7DYzWMXBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FsXNlNN+6fI=;VZFXTfnJ0ygOZrDrgZrWWpW8Amg
 4nIVUsGbfw1ZcHCveNN7p+mAumj1EOR/Cwx6yJnTwA3YzLOn+hk3aS5ZiTD8EOQ7wc993VkhB
 T5QDLjgMoMHqb1xDh0OpBh/ygegvPAVHT2AQEjyatrvD6hnsd8rxQhKasCVZyFRL+zuiAdN8c
 iuIiWoFJGIzKqF+8eGmmHFF9+BJNTMrUcI3pPKVzvoNp3x8bWvHM77wPz1gInRaBLYarGSGS+
 mL+Jeb495n/cSXM5fw9EabXMwOv470YR6+Vs1WDX7A/nMQiqaWX50KUz8fPSGslA7rO4r/QxX
 9nmimAi/q9kjJw3g/Z85Vl1fBqQXq95sxhKUyHWqc3JaxjOdMX4bDv0sgy+DIJTL06/tKqPh6
 +V30Hyg3P1TyE59WwE6s/eO3NLrw+Spxk30EndIlkQS2wiWl6hFZX2n/fqphSyRO6lWvMqLDC
 yd/RIVeO1G+5AzQlJSG/W1VmbXCTI/CWVTJyzDZ0UDmxUTM68f/uwzAYsXg3cNTmAth+qHxdD
 hbWCK7Otxg2pm8PUvtbgN8aj/rbRCUhhagWyef4ZJlR28233peOwxbWyel7zsDJjzBXH8Q8Ho
 HfY4pLWAmuTDGfT4NN7OSbn46+V3x6FUbv5+sj9weuNrcc0743jfyMciEc7f3Ufjv3QJpKqlX
 Z5gMyjyijhvv7vG8VI7G5bo7b0JE1y6F83KDJBY8qBmE53SUxjuCzJ3MZMfJDMGKE0pguzBNT
 di3suPqyUKF/DLAJFvwZaUWjMVCqYdYAxoKRzgFw13Mxe2Cztde+FrBswNUf3w0U5ioBGSvvH
 WMhBckaNnAMK62fGOw6GGvwg==

DQoNCuWcqCAyMDI0LzgvOSAwMjozNCwgTWFyayBIYXJtc3RvbmUg5YaZ6YGTOg0KPiBUaGFua3Mg
UXUuDQo+IA0KPiBPbiA3LzgvMjQgMjM6MzcsIFF1IFdlbnJ1byB3cm90ZToNCj4+PiBAQCAtMTI3
Miw2ICsxMjkxLDc3IEBAIGludCBCT1hfTUFJTihta2ZzKShpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
DQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAxOw0KPj4+ICDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBlcnJvcjsNCj4+PiAgwqDCoMKgwqDCoCB9DQo+Pj4gK8KgwqDCoCBpZiAoIWxpc3Rf
ZW1wdHkoJnN1YnZvbHMpICYmIHNvdXJjZV9kaXIgPT0gTlVMTCkgew0KPj4+ICvCoMKgwqDCoMKg
wqDCoCBlcnJvcigidGhlIG9wdGlvbiAtLXN1YnZvbCBtdXN0IGJlIHVzZWQgd2l0aCAtLXJvb3Rk
aXIiKTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gMTsNCj4+PiArwqDCoMKgwqDCoMKgwqAg
Z290byBlcnJvcjsNCj4+PiArwqDCoMKgIH0NCj4+PiArDQo+Pj4gK8KgwqDCoCBpZiAoc291cmNl
X2Rpcikgew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBjaGFyICpjYW5vbmljYWwgPSByZWFscGF0aChz
b3VyY2VfZGlyLCBOVUxMKTsNCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghY2Fub25p
Y2FsKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3IoImNvdWxkIG5vdCBnZXQg
Y2Fub25pY2FsIHBhdGggdG8gJXMiLCBzb3VyY2VfZGlyKTsNCj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXQgPSAxOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3I7
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGZyZWUo
c291cmNlX2Rpcik7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNvdXJjZV9kaXIgPSBjYW5vbmljYWw7
DQo+Pj4gK8KgwqDCoCB9DQo+Pj4gKw0KPj4+ICvCoMKgwqAgaWYgKCFsaXN0X2VtcHR5KCZzdWJ2
b2xzKSkgew0KPj4NCj4+IFdlIGNhbiBza2lwIHRoZSBsaXN0X2VtcHR5KCkgY2hlY2ssIGFzIHRo
ZSBsYXRlciBsaXN0X2Zvcl9lYWNoX2VudHJ5KCkNCj4+IGNhbiBoYW5kbGUgZW1wdHkgbGlzdCBw
cmV0dHkgd2VsbC4NCj4gDQo+IEkgZGlkIHRoaXMgdG8gYXZvaWQgYSBzdHJsZW4gY2FsbCBpZiB0
aGVyZSdzIG5vIHN1YnZvbHMsIGJ1dCB0aGF0J3Mgbm90DQo+IHZlcnkgaW1wb3J0YW50Lg0KPiAN
Cj4+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJvb3RkaXJfc3Vidm9sICpzOw0KPj4+ICsNCj4+
PiArwqDCoMKgwqDCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeShzLCBnX3N1YnZvbHMsIGxpc3Qp
IHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXN0cmNtcChmdWxsX3BhdGgsIHMt
PmZ1bGxfcGF0aCkpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBmdHdfYWRkX3N1YnZvbChmdWxsX3BhdGgsIHN0LCB0eXBlZmxhZywNCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmdHdidWYs
IHMpOw0KPj4NCj4+IEFub3RoZXIgb3B0aW1pemF0aW9uIGNhbiBiZSwgdG8gcmVtb3ZlIEBzIGZy
b20gdGhlIGdfc3Vidm9scyBsaXN0Lg0KPj4gU28gdGhhdCB0aGUgbmV4dCBzZWFyY2ggd2lsbCBz
cGVuZCBhIGxpdHRsZSBsZXNzIHRpbWUgdG8gZG8gdGhlIHNlYXJjaC4NCj4gDQo+IFVuZm9ydHVu
YXRlbHkgeW91IGNhbid0IGRvIHRoYXQsIGFzIGl0IG1lYW5zIHRoYXQgdGhlIHBvaW50ZXIgd2ls
bCBiZQ0KPiBtaXNzZWQgaW4gdGhlIG1rZnNfbWFpbiBjbGVhbnVwLg0KDQpXaHk/IFlvdSByZW1v
dmVkIGl0IGZyb20gdGhlIGxpc3QgYW5kIGZyZWUgdGhlIG1lbW9yeS4NCg0KQW5kIGF0IHRoZSBm
aW5hbCBjbGVhbnVwLCB0aGVyZSB3aWxsIGJlIG5vIGVudHJ5IGxlZnQuDQoNClRoYW5rcywNClF1
DQo+IA0KPiBNYXJrDQo+IA0K

