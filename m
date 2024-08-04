Return-Path: <linux-btrfs+bounces-6973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4670B94712B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 00:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33031F21145
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 22:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32A13A24A;
	Sun,  4 Aug 2024 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OLRGR3Re"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD20AD59
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Aug 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722810003; cv=none; b=M15vFSMIHzaY3PgmItpYhTAcWWOcc5jusAPK6+0mlVWbQzYe480YluzxJq9c+uTPjLYxCTeGwCAElgfUiXLmUJ8Hi7xfQQi6yoPhNA6Li4ApWkLA/K2bVqJytKEcmohgorDdBa1cvAU+kmwprPNQCLm+PYFlFaxMDNgEOVx4BS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722810003; c=relaxed/simple;
	bh=XU2Tbjhgzt6gnggaKl/vZmlq5UZDL5Kd80vW9POKo4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rrkU5hzp7YZG9wBm3qMM1wu8CJjZECdG2AiAD6EAoDNHCsFwMHFWOXkKJptoDXuPKaLzt1D86mtinbjELyy2tErMQXSUGzJlXJTsXbofOpp3JoG1pY9pLpEytZ7bKK9FPaBiZnwupHlxTyIDxOCcsuYBL+I4xGp6Sau+tWZsDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OLRGR3Re; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722809997; x=1723414797; i=quwenruo.btrfs@gmx.com;
	bh=XU2Tbjhgzt6gnggaKl/vZmlq5UZDL5Kd80vW9POKo4E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OLRGR3Reu5LBPYUe5jGheAIb51Fk/rlPL3N+iOlYBbc4v9rC/Drl3y+8EZLSgaXc
	 hIGv+glr0L4HP4B+EC8OVjuDfW2hrBCDAeRL5GlEGCQ1gz/J51MK3L6YGKpZnMOo0
	 2CZv79sk+mxUHJ3iG5zKfTdDRtIJJJWsIi62I33mm9ruM5GWBGeFzwkj4n3P/q/Yb
	 WnqN0jp80nJGlEdZifUq7P6ocw/rG29Ajrp/NXTq0qkf4eZNHnsgWNpSzWTdkeO+P
	 m2CuZj2SVK9YUHevRIgtwCj0fC6ADEeH4PmzZIBffbaZU3OjSorkxvnChoXSa8zn6
	 KOS638HoUs4umH7BoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoRK-1sUcv51ET0-005yeF; Mon, 05
 Aug 2024 00:19:57 +0200
Message-ID: <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
Date: Mon, 5 Aug 2024 07:49:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: i.r.e.c.c.a.k.u.n+kernel.org@gmail.com, linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
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
In-Reply-To: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:4a4fNtN3/wGrCqr768CFkKzCs2fNuWszQa0i9JDlT4xwgD6WNQ6
 aXV7slTGgBSVbDWoxbzD9iQrYJtinOj0MeCQf490Pwio0Kq1tbcbehGrHufIVNpLkX/3Gci
 D8fWZZ2Xb6hI+Lfk57o5bf/sHx2CrEeEbc/c3uvLAcy7Xp51QQgPg38hjXZq0ihHhoFgTPr
 Qlq2VpfAYBC/iioBrPyvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kGv5Ux6vCfw=;4oIJoNnt5IkPXwwLHAVFy8ZOQXc
 wYbPmnIg5aTaywfXjb2IB1IhngPqvBw8H9df3oEGUyCIOCira5w+I04vjd2y/kHbQcQotA96M
 +VfmZSH3qWwByMY5HyyXAXL46qr8lSzuu3xWDDE8+HGHtKhXspjzPZOLW0VSGOlxH9wfQHo9H
 ED8DrUDmST+GA9JAPxRvt81KSpCMRY8BSL5xD/nGxOlzjRir/1SsaCaIoLL3ktHtHKmIfYeKs
 22zUaO4ddqnobo5vG0Va8N9yn2C8g6R2Lt/L7AQEnCP+Cx6LPL5WZZla9NFsxSv1Dnv9bZTI1
 k+JG7XN99nMNc5T5TGJT+izZPcwLu5C4HZjIZvQDDpivmH+LZ3I1lKNZSS31rXkSAHihJix8V
 eRaf+/C33PLaGIn/oEZtSTys2de8htp/kBjQ6g0NqKfQbBiJRJFve02HioE8EGI8xEeUedSBv
 z6hpBvKKNVDUxsHWm6W6Hm85WSQli1QYQUfWLV9QgRT5pe9ARNRhzWsJrH5jhtu7j1QPz8wb4
 VCoxJm75PNG5a+ePlEJsNLQEQwU9A/0ooCZC88SqF5NKp9n1+9KuZF89ZECkmSKmJ3gOEMH5N
 inknTVLXbB1B0Oy7Gs8G0ACft6TXmrINPvkxdaeto9eJaOV7lf9c+CKuS+ZBUPSlX4pHG8jo8
 o5dZixAtoaRBa+Nuc1TSsnJeqrpCOpS7A7eYcqEoOilwoooLwL7i7EWhMuYgpB6Svn/4YAO/A
 q+2Evsfm7DFBgAAY2Qo2OVg+JkyzeTbfmtecCu6WRMKnNIf7BShdGqs8BTZ+jxEwSPkO7lrUW
 RrpdrncLzYOVMPxbr3OoMtsOQC8M91u3oLFb0S7YiIYiQ=

DQoNCuWcqCAyMDI0LzgvNCAxODo1MCwgaS5yLmUuYy5jLmEuay51Lm4ra2VybmVsLm9yZ0BnbWFp
bC5jb20g5YaZ6YGTOg0KPiAoT3JpZ2luYWxseSByZXBvcnRlZCBvbiBLZXJuZWwub3JnIEJ1Z3pp
bGxhOiANCj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTkw
MzMpDQo+IA0KPiBUaGVyZSBpcyBhIHZlcnkgd2VpcmQgcXVpcmsgSSBmb3VuZCB3aXRoICdidHJm
cyBmaWxlc3lzdGVtIGRlZnJhZ21lbnQnIA0KPiBjb21tYW5kLiBBbmQgbm8sIGl0J3Mgbm90IGFi
b3V0IHJlZmxpbmtzIHJlbW92YWwsIEknbSBhd2FyZSBvZiB0aGF0Lg0KPiANCj4gSXQgaXMga2lu
ZGEgaGFyZCB0byByZXBsaWNhdGUsIGJ1dCBJIGZvdW5kIGEgc29tZXdoYXQgcmVsaWFibGUgd2F5
LiBJdCANCj4gcmVhY2hlcyBleHRyZW1lcyB3aXRoIGZhbGxvY2F0ZWQgZmlsZXMgc3BlY2lmaWNh
bGx5Lg0KPiANCj4gMS4gQ3JlYXRlIGEgZmlsZSBvbiBhIEJ0cmZzIGZpbGVzeXN0ZW0gdXNpbmcg
J2ZhbGxvY2F0ZScgYW5kIGZpbGwgaXQuIA0KPiBUaGUgZWFzeSB3YXkgdG8gZG8gdGhhdCBpcyBq
dXN0IHRvIGNvcHkgc29tZSBmaWxlcyB3aXRoICdyc3luYyANCj4gLS1wcmVhbGxvY2F0ZScuDQo+
IA0KPiAyLiBDaGVjayBjb21wc2l6ZSBpbmZvOg0KDQpNaW5kIHRvIGR1bXAgdGhlIGZpbGVtYXAg
b3V0cHV0ICh4ZnNfaW8gLWMgImZpZW1hcCAtdiIpIGJlZm9yZSBhbmQgYWZ0ZXIgDQp0aGUgZGVm
cmFnPw0KDQpUaGFua3MsDQpRdQ0KPiANCj4gIyBjb21wc2l6ZSBmb28NCj4gUHJvY2Vzc2VkIDcx
IGZpbGVzLCA3MSByZWd1bGFyIGV4dGVudHMgKDcxIHJlZnMpLCAwIGlubGluZS4NCj4gVHlwZcKg
wqDCoMKgwqDCoCBQZXJjwqDCoMKgwqAgRGlzayBVc2FnZcKgwqAgVW5jb21wcmVzc2VkIFJlZmVy
ZW5jZWQNCj4gVE9UQUzCoMKgwqDCoMKgIDEwMCXCoMKgwqDCoMKgIDYzME3CoMKgwqDCoMKgwqDC
oMKgIDYzME3CoMKgwqDCoMKgwqDCoMKgIDYzME0NCj4gbm9uZcKgwqDCoMKgwqDCoCAxMDAlwqDC
oMKgwqDCoCA2MzBNwqDCoMKgwqDCoMKgwqDCoCA2MzBNwqDCoMKgwqDCoMKgwqDCoCA2MzBNDQo+
IA0KPiBBbGwgaXMgZmluZSBoZXJlIGZvciBub3cuIDEgZXh0ZW50IHBlciAxIGZpbGUsICJEaXNr
IFVzYWdlIiA9ICJSZWZlcmVuY2VkIi4NCj4gDQo+IDMuIFJ1biBkZWZyYWdtZW50Og0KPiANCj4g
IyBidHJmcyBmaWxlc3lzdGVtIGRlZnJhZ21lbnQgLXIgZm9vDQo+IA0KPiA0LiBDaGVjayBjb21w
c2l6ZSBhZ2FpbjoNCj4gDQo+ICMgY29tcHNpemUgZm9vDQo+IFByb2Nlc3NlZCA3MSBmaWxlcywg
NzYgcmVndWxhciBleHRlbnRzICg3NiByZWZzKSwgMCBpbmxpbmUuDQo+IFR5cGXCoMKgwqDCoMKg
wqAgUGVyY8KgwqDCoMKgIERpc2sgVXNhZ2XCoMKgIFVuY29tcHJlc3NlZCBSZWZlcmVuY2VkDQo+
IFRPVEFMwqDCoMKgwqDCoCAxMDAlwqDCoMKgwqDCoCA2MzhNwqDCoMKgwqDCoMKgwqDCoCA2MzhN
wqDCoMKgwqDCoMKgwqDCoCA2MzBNDQo+IG5vbmXCoMKgwqDCoMKgwqAgMTAwJcKgwqDCoMKgwqAg
NjM4TcKgwqDCoMKgwqDCoMKgwqAgNjM4TcKgwqDCoMKgwqDCoMKgwqAgNjMwTQ0KPiANCj4gT29w
cywgYmVzaWRlcyB0aGUgZmFjdCB0aGF0IHRoZSBhbW91bnQgb2YgZXh0ZW50cyBpcyBhY3R1YWxs
eSBpbmNyZWFzZWQsIA0KPiB3aGljaCBtZWFucyAnYnRyZnMgZmlsZXN5c3RlbSBkZWZyYWdtZW50
JyBhY3R1YWxseSBtYWRlIGZyYWdtZW50YXRpb24gDQo+IHdvcnNlLCBwaHlzaWNhbCBkaXNrIHVz
YWdlIGluY3JlYXNlZCBmb3Igbm8gcmVhc29uLiBBbmQgSSBkaWRuJ3QgZmluZCANCj4gYW55IHdh
eSB0byBzaHJpbmsgaXQgYmFjay4NCj4gDQo+IC0tLQ0KPiANCj4gVGhlIGVuZCByZXN1bHQgc2Vl
bXMgdG8gYmUgcmFuZG9tIHRob3VnaC4gQnV0IEkgbWFuYWdlZCB0byBhY2hpZXZlIHNvbWUgDQo+
IHRydWx5IGhvcnJpZnlpbmcgcmVzdWx0cy4NCj4gDQo+ICMgY29tcHNpemUgZm9vDQo+IFByb2Nl
c3NlZCA0NSBmaWxlcywgNDUgcmVndWxhciBleHRlbnRzICg0NSByZWZzKSwgMCBpbmxpbmUuDQo+
IFR5cGXCoMKgwqDCoMKgwqAgUGVyY8KgwqDCoMKgIERpc2sgVXNhZ2XCoMKgIFVuY29tcHJlc3Nl
ZCBSZWZlcmVuY2VkDQo+IFRPVEFMwqDCoMKgwqDCoCAxMDAlwqDCoMKgwqDCoCAzNjBNwqDCoMKg
wqDCoMKgwqDCoCAzNjBNwqDCoMKgwqDCoMKgwqDCoCAzNjBNDQo+IG5vbmXCoMKgwqDCoMKgwqAg
MTAwJcKgwqDCoMKgwqAgMzYwTcKgwqDCoMKgwqDCoMKgwqAgMzYwTcKgwqDCoMKgwqDCoMKgwqAg
MzYwTQ0KPiANCj4gIyBidHJmcyBmaWxlc3lzdGVtIGRlZnJhZ21lbnQgLXIgLXQgMUcgZm9vDQo+
IA0KPiAjIGNvbXBzaXplIGZvbw0KPiBQcm9jZXNzZWQgNDUgZmlsZXMsIDE0NCByZWd1bGFyIGV4
dGVudHMgKDE0NCByZWZzKSwgMCBpbmxpbmUuDQo+IFR5cGXCoMKgwqDCoMKgwqAgUGVyY8KgwqDC
oMKgIERpc2sgVXNhZ2XCoMKgIFVuY29tcHJlc3NlZCBSZWZlcmVuY2VkDQo+IFRPVEFMwqDCoMKg
wqDCoCAxMDAlwqDCoMKgwqDCoCA3MTZNwqDCoMKgwqDCoMKgwqDCoCA3MTZNwqDCoMKgwqDCoMKg
wqDCoCAzNjBNDQo+IG5vbmXCoMKgwqDCoMKgwqAgMTAwJcKgwqDCoMKgwqAgNzE2TcKgwqDCoMKg
wqDCoMKgwqAgNzE2TcKgwqDCoMKgwqDCoMKgwqAgMzYwTQ0KPiANCj4gWWlrZXMhIFRyaXBsZSB0
aGUgZXh0ZW50cyEgRG91YmxlIGluY3JlYXNlIGluIHNpemUhDQo+IA0K

