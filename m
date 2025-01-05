Return-Path: <linux-btrfs+bounces-10727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565EA01C71
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 00:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B38C1882CDA
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2025 23:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202041A8F99;
	Sun,  5 Jan 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="d6dcFAAo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64623647
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Jan 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736119084; cv=none; b=Dd1Wq0b/Gv7P49jT7aGObrczBpfDU72YKF2S2S7WbYGmTk9jpbyE1K2a28uLvYYbvuOYVVuVu8j2ezJd8deA//gOJhjAVx/z9DALGLQq0pSFFJpssDEu13plotPm1yGNe7So9A3XCf+yaQWy45L5VPw51iO8dTyLDmVZNJlfmhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736119084; c=relaxed/simple;
	bh=mUl3Nss9ij/fb4v+4c0Wvx5RAvcg0hdBB1Tz/eEJSzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D08i6w+zcqjl/CLOJJFxyN0iF+MYqpFzjQWpc+fVNhhg5t0vizYEeOK1wOSeMEknDx+oOTErnNpYAA+AyfxyiKwKckzg0ZfmWYrs/vBrqZgo+xKdEmVA4ezlNsrqgO5nptbcNnV7ZUj5AJe8dH/C2sfcLhageIGSnYxM6qGE4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=d6dcFAAo; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736119070; x=1736723870; i=quwenruo.btrfs@gmx.com;
	bh=mUl3Nss9ij/fb4v+4c0Wvx5RAvcg0hdBB1Tz/eEJSzA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=d6dcFAAozdh+M8NnZFU2c4LO4c+Ok5ixGErclO1HGpPUjlbUaUmbTXyIeCixqRzR
	 BR2iy0aDXjuNbbnc8UyKJ1Ev8f2lXitPfbWnY3KDdm8RenWzqicHIJMVkUJDFKoyd
	 QvZ+CVcemSswLPapLfAVYOzQXc/pJUz3cetsaap9JlE0xiIC3B7yoOOycPmlILMlx
	 BycUFiLCAJCzGaGAJYsn3Ja1giA61O4nspZ7tV7pqeS4/uPjmJtjAfnBj/XrNOYLI
	 YwEK8zyE64yiv3pK92xbQ7/y+CktZZce7DzENdfSvBg+3lmyZdfxw8w0Pe/3zXUH1
	 JiIdotFE0SYOQK9eKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQvCv-1t8uHy2jyh-00NCoN; Mon, 06
 Jan 2025 00:17:50 +0100
Message-ID: <bad71f4e-fd17-4fd0-94de-4064efce70e1@gmx.com>
Date: Mon, 6 Jan 2025 09:47:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs-progs: btrfstune --remove-simple-quota
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>
Cc: kernel-team@fb.com
References: <cover.1720732480.git.boris@bur.io>
 <75ec1c40-afe5-4d26-b1bf-ebd4adb7e4f8@oracle.com>
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
In-Reply-To: <75ec1c40-afe5-4d26-b1bf-ebd4adb7e4f8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:oe0E35fPfTIvi2w8pTCcEqWxWU0MM6OhPKifjX60We6TUvAouRq
 urc0uoXW3szukzIlCPoWwSD+b6zltuyT4huOHdXcc4gyXpaZ8isbXBOtP/05kJWmVAEuPbf
 ixKrvQPWhayuGXMuGYvXxQBs6pOCKXgvgEo/qprY3lZGHfsVnot/95beoQVLZ1qxrZGEvxU
 A2C4V5I5ZzEpU4SKhpeqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i0BxDMW386I=;iC3R12T2kYojPk8zTY10YgxIlVi
 MKieHSTH61ShjIlZUDScS6cLNhoAK28KpE31sYHTeRIfLAyOZHiexJFnFgfdm9Qa8+neSiQnZ
 eZqhTi7xxAG1/4XxG6SPqlPTtCIGKucbD3BkNy1Y6C/iCSXAquJCJrbsJo43FD7VH2qNpN/b5
 H5qDv5fsHcSJ/XpRuWH6gLR3ArN53Fa7WAAj630dD0s0XGGovU+wVBQikMfUkSVmPPoNtmoRh
 K8cHxWkMJ533X2bk+4o2rcQ9wcmcmj+waH69uIXCr8gyGZgMxUvq1ATznGZgQTskzyvPuJsGw
 hczE+1cnWT4UTH1UX/DSsuQjIgGt1np7TWnt1kOtQ/l9QVOMaaugaBmdaXc9xvn9cf4xD4MRD
 EMV5U09pCZu5ZH+g8RzsSQgeca/eOgUw8BKirb5t4UatbNJWBjXBMCHHwSDMmOhGXk8hv4aA7
 Hql8B4Ub34zi/xmC4xjI7L9Ap+3pkHjKFbH4TKs/tuurtMEZt8SQsvcOY80/8UPjpcWOVPI3l
 adsYaz1Wqu3B6i47sTCBoeE92/z74Tq0OuuIjhzMEPzBV3DmBNyGUbbhEiDLK6kXfPXMo6wdx
 ZTbhHxvZHPW9r4Kdn5UwNiFZzwPTkUHEEuM3RksNbosz7D6CH4x8VP49T8Ncn42/iC1sBefW8
 ywrOE/Fgvi1pVnsDvNisNtzR0Y1bnhnnvvW5LxJJngLL2zWszwNCDSJonEHYbOMXkC+0yg1yK
 dI1DxeyBLkalQ6njEdQxzNHE9qWjf6mHB2Y/S3oZWrZjzvLhYqo17xm3TyTLgyaVNsFsJobFz
 cXjRuT+4T2mPr8K14bYgN3KfQV9iSsVeI6JRqE6uhGidLERW953AtnY7S0xSDM3wlHvEW8l2u
 ogwpZ2xnJBw1qxNVM9Zs03hJ3lHBdQ0oiSeWJ6K5Sa/hVF1iwuNe0kJEpXcKQh//NAA7zRdww
 fv+VSTRzM3cYQ0YNyXtN8BC4NqaOtVb6kn8U65Ul+tG1Ni1BGl/BQxTLTmYqTjn3mLV5/nM/j
 tpWadkJPrjCCIqH8Ccz/tFq253gU+ykDvYg+2u+EpGDb5A8sgPZj7uPIzUdBGSJxfKgwd9QQU
 oeisNWN7igb7LcsspAcqcSkUHfEiWw

U29ycnkgSSBmb3Jnb3QgdG8gbWVyZ2UgdGhlbSBmb3Igc28gbG9uZy4uDQoNCk5vdyBtZXJnZWQg
aW50byBkZXZlbCBicmFuY2ggd2l0aCBhbGwgcmV2aWV3ZWQtYnkgdGFncywgYW5kIHNvbWUgc21h
bGwgDQptb2RpZmljYXRpb25zOg0KDQotIFB1dCB0aGUgZG9jIGZpeCBmaXJzdA0KLSBBZGQgdGhl
IG1pc3NpbmcgbWFuIHBhZ2UgZW50cnkgZm9yICItLWVuYWJsZS1zaW1wbGUtcXVvdGEiDQotIE1h
a2UgcmVtb3ZlX2FsbF90cmVlX2l0ZW1zKCkgdG8gdXNlIGJ0cmZzX2NsZWFyX3RyZWUoKSBoZWxw
ZXINCi0gQWRkIHRoZSBtaXNzaW5nIG1hbiBwYWdlIGVudHJ5IGZvciAiLS1yZW1vdmUtc2ltcGxl
LXF1b3RhIg0KDQpUaGFua3MsDQpRdQ0KDQrlnKggMjAyNS8xLzQgMjE6MDUsIEFuYW5kIEphaW4g
5YaZ6YGTOg0KPiANCj4gYnRyZnN0dW5lIC0taGVscCBzaG93cyAtcSBhcyB0aGUgb3B0aW9uIHRv
IGVuYWJsZSBzaW1wbGUgcXVvdGEsIHdoaWNoIA0KPiBkb2VzIG5vdCB3b3JrLg0KPiANCj4gRGF2
aWQsIGhhcyB0aGlzIHNldCBtaXNzZWQgaW50ZWdyYXRpb24/IE9SIEJvcmlzIGNvdWxkIHB1c2g/
DQo+IA0KPiBUaGUgd2hvbGUgc2VyaWVzIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBSZXZpZXdl
ZC1ieTogQW5hbmQgSmFpbiA8YW5hbmQuamFpbkBvcmFjbGUuY29tPg0KPiANCj4gVGh4Lg0KPiAN
Cj4gDQo+IE9uIDEyLzcvMjQgMDI6NDgsIEJvcmlzIEJ1cmtvdiB3cm90ZToNCj4+IFRvIGJlIGFi
bGUgdG8gbnVrZSBzaW1wbGUgcXVvdGFzIGVudGlyZWx5IGlmIHlvdSBkZWNpZGUgeW91IGRvbid0
IHdhbnQNCj4+IHRoZW0gKGFuZCBlc3BlY2lhbGx5IHRoZSBPV05FUl9SRUZzKSBpbiB5b3VyIGZp
bGVzeXN0ZW0gYWZ0ZXIgYWxsLg0KPj4NCj4+IElmIHlvdSBydW4NCj4+IGJ0cmZzdHVuZSAtLXJl
bW92ZS1zaW1wbGUtcXVvdGEgPGRldj4NCj4+IG9uIGFuIHVubW91bnRlZCBmaWxlc3lzdGVtLCBp
dCB3aWxsIGJlIGFzIGlmIHNpbXBsZSBxdW90YXMgbmV2ZXIgZXhpc3RlZA0KPj4gb24gdGhhdCBm
aWxlc3lzdGVtLg0KPj4NCj4+IEJvcmlzIEJ1cmtvdiAoMyk6DQo+PiDCoMKgIGJ0cmZzLXByb2dz
OiBhZGQgYSBoZWxwZXIgZm9yIGNsZWFyaW5nIGFsbCB0aGUgaXRlbXMgaW4gYSB0cmVlDQo+PiDC
oMKgIGJ0cmZzLXByb2dzOiBidHJmc3R1bmU6IGZpeCBkb2N1bWVudGF0aW9uIGZvciAtLWVuYWJs
ZS1zaW1wbGUtcXVvdGENCj4+IMKgwqAgYnRyZnMtcHJvZ3M6IGJ0cmZzdHVuZTogYWRkIGFiaWxp
dHkgdG8gcmVtb3ZlIHNxdW90YXMNCj4+DQo+PiDCoCBrZXJuZWwtc2hhcmVkL2Rpc2staW8uY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzOSArKysrKw0K
Pj4gwqAga2VybmVsLXNoYXJlZC9kaXNrLWlvLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsNCj4+IMKgIGtlcm5lbC1zaGFyZWQvZnJlZS1zcGFj
ZS10cmVlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0MiArLS0tLQ0KPj4gwqAg
Li4uLzA2NS1idHJmc3R1bmUtc2ltcGxlLXF1b3RhL3Rlc3Quc2jCoMKgwqDCoMKgwqDCoCB8wqAg
MzMgKysrKw0KPj4gwqAgdHVuZS9tYWluLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTggKy0NCj4+IMKgIHR1
bmUvcXVvdGEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE2MCArKysrKysrKysrKysrKysrKysNCj4+IMKgIHR1bmUv
dHVuZS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+PiDCoCA3IGZpbGVzIGNoYW5nZWQsIDI1MyBp
bnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0
ZXN0cy9taXNjLXRlc3RzLzA2NS1idHJmc3R1bmUtc2ltcGxlLXF1b3RhL3Rlc3Quc2gNCj4+DQo+
IA0KPiANCg0K

