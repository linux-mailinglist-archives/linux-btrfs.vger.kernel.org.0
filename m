Return-Path: <linux-btrfs+bounces-2140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6B84ABC0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 02:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37201F26F03
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 01:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC61915A4;
	Tue,  6 Feb 2024 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="v/WD66Y3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB11113
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183954; cv=none; b=udUXC8XUXZSfq1JUSWzE9yTai0zPfdwQn5c6ue8m4WduhwpW5wpeDzafO6rea0xxWegkaoExB+mbHydvYow6k1+B4+Gfi7zEkAGlMrrvPE4VcZoDq7U4Z1WCTw09OCRAxvQxdkT9ZeKdxwYHU/2atWrt4Ref2XiZ+FMgjtEPYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183954; c=relaxed/simple;
	bh=vb9GpLsnPnFA99Wvl3qp3TS4Qis/znX8aDhK72QT194=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYOl48s0olXKY/17gyZcbkuJHj9FpRGxreDF6JP5rDjV+kBXeN6N725vrPl1upWeFcGLtPgNZWFApBZCAwoNy2oK3XLh9yVd5ZCS/RYBYjl61Hxdbg9KzDSoARlg8q9hSdGPLUE9EoQMZ98qXxUImqEE4sSa/smX4hycjHup1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=v/WD66Y3; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1707183946;
	bh=vb9GpLsnPnFA99Wvl3qp3TS4Qis/znX8aDhK72QT194=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=v/WD66Y3m4tlfgmn86ixt/IhoR5hz4W4mn+iU0/OzVuHJcfNca33xeja9KZeKPXRB
	 /Oz6PkWPH4lp2e1qMA+y4M+S3AfaRGYVIZRn2E1l04vEH8Tjrf+to+hQeYZbTIQO/o
	 B9oYZ5xnMAEIvam/8ucaEH7x3tMbyjAdWawuE/YU=
X-QQ-mid: bizesmtpipv602t1707183944t6og
X-QQ-Originating-IP: icEd1URcFICFsojHX66h5j+4O+ApM7PHMK9zt/9KA7U=
Received: from [IPV6:240e:381:70b1:9300:b0be:2 ( [255.229.87.6])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 06 Feb 2024 09:45:43 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: znfcQSa1hKYxXCo+c/G0hsWm8GZz9yuPPpbWcba/JL7+996hDMv6eHnQosa4Y
	IJdJ7SsJ2ucQgjoNZUJpXwPh2ri/0wKj7brpCAf9KYQFuzCj/3KUVYN5CsknOzi3B1h6guZ
	W0zvRTv0Hy5ScdNVdqwW/HCocewg+hr/3AuyBWvdkVUCjvkMNaFjBfGb/BujfCqxoFmYd2o
	yg5C4Kcfj3XNb6srKowacBlHF4cSNXvm0EETFvcxIB7Q8Y+pqVy1zP3RmMxJDJac1OP5LRW
	UJoslM5dvimD934KQ893sx2NVuXt2amHW4k105cE8d6IvgcGnojrL6Pt6RkwBBDUw9+d6bj
	M1jHReiPRcQcOAadrPcpr7aDcvlxQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18382312641052253452
Message-ID: <1889B611E39B320D+fdc8e149-c294-491b-8a31-c747f2ad83d6@bupt.moe>
Date: Tue, 6 Feb 2024 09:45:45 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
 <ED3C933B1371DD79+bdc357d3-3efb-49f4-9b54-8cb0ab9350d1@bupt.moe>
 <b96844a3-41b6-4bb1-b4b1-85f07d1d1310@gmx.com>
Content-Language: en-US
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
In-Reply-To: <b96844a3-41b6-4bb1-b4b1-85f07d1d1310@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

DQrlnKggMjAyNC8yLzYgNDo0MCwgUXUgV2VucnVvIOWGmemBkzoNCj4NCj4NCj4gT24gMjAy
NC8yLzUgMjE6MjAsIOmfqeS6juaDnyB3cm90ZToNCj4+DQo+PiDlnKggMjAyNC8yLzUgMTU6
NTYsIFF1IFdlbnJ1byDlhpnpgZM6DQo+Pj4NCj4+Pg0KPj4+IE9uIDIwMjQvMi81IDE3OjE2
LCDpn6nkuo7mg58gd3JvdGU6DQo+Pj4+IMKgPiBBbnkgY2x1ZSBob3cgY2FuIEkgcHVyY2hh
c2Ugc3VjaCBkaXNrcz8NCj4+Pj4gwqA+IEFuZCB3aGF0J3MgdGhlIGludGVyZmFjZT8gKE5W
TUU/IFNBVEE/IFUyPykNCj4+Pj4NCj4+Pj4gSSBwdXJjaGFzZWQgdGhlc2Ugb24gdXNlZCBt
YXJrZXQgYXBwIGNhbGxlZCBYaWFueXUo6Zey6bG8KSB3aGljaCBtYXkgYmUNCj4+Pj4gZGlm
ZmljdWx0IGZvciB1c2Vycw0KPj4+PiBvdXRzaWRlIENoaW5hIG1haW5sYW5kLiBBbmQgaXRz
IHN1cHBseSBpcyBleHRyZW1lbHkgdW5zdGFibGUuDQo+Pj4+DQo+Pj4+IEl0cyBpbnRlcmZh
Y2UgaXMgU0FUQS4gTWluZSBtb2RlbCBpcyBIU0g3MjE0MTRBTE42TTAuIFNwZWMgbGluazoN
Cj4+Pj4gaHR0cHM6Ly9kb2N1bWVudHMud2VzdGVybmRpZ2l0YWwuY29tL2NvbnRlbnQvZGFt
L2RvYy1saWJyYXJ5L2VuX3VzL2Fzc2V0cy9wdWJsaWMvd2VzdGVybi1kaWdpdGFsL3Byb2R1
Y3QvZGF0YS1jZW50ZXItZHJpdmVzL3VsdHJhc3Rhci1kYy1oYzYwMC1zZXJpZXMvZGF0YS1z
aGVldC11bHRyYXN0YXItZGMtaGM2MjAucGRmIA0KPj4+Pg0KPj4+Pg0KPj4+PiDCoD4gQW5k
IGhhdmUgeW91IHRyaWVkIGVtdWxhdGVkIHpvbmVkIGRldmljZSAobm8gbWF0dGVyIGlmIGl0
J3MgcWVtdQ0KPj4+PiB6b25lZA0KPj4+PiDCoD4gZW11bGF0aW9uIG9yIG5iZCBvciB3aGF0
ZXZlcikgd2l0aCA0SyBzZWN0b3JzaXplPw0KPj4+Pg0KPj4+PiBIYXZlIHRyaWVkIG9uIG15
IGxvb25nc29uIHdpdGggdGhpcyBzY3JpcHQgZnJvbQ0KPj4+PiBodHRwczovL2dpdGh1Yi5j
b20vUm9uZ3JvbmdnZzkNCj4+Pj4NCj4+Pj4gwqA+IC4vbnVsbGIgc2V0dXANCj4+Pj4gwqA+
IC4vbnVsbGIgY3JlYXRlIC1zIDQwOTYgLXogMjU2DQo+Pj4+IMKgPiAuL251bGxiIGNyZWF0
ZSAtcyA0MDk2IC16IDI1Ng0KPj4+PiDCoD4gLi9udWxsYiBscw0KPj4+PiDCoD4gbWtmcy5i
dHJmcyAtcyAxNmsgL2Rldi9udWxsYjANCj4+Pj4gwqA+IG1vdW50IC9kZXYvbnVsbGIwIC9t
bnQvdG1wDQo+Pj4+IMKgPiBidHJmcyBkZXZpY2UgYWRkIC9kZXYvbnVsbGIxIC9tbnQvdG1w
DQo+Pj4+IMKgPiBidHJmcyBiYWxhbmNlIHN0YXJ0IC1kY29udmVydD1yYWlkMSAtbWNvbnZl
cnQ9cmFpZDEgL21udC90bXANCj4+Pg0KPj4+IEp1c3Qgd2FudCB0byBiZSBzdXJlLCBmb3Ig
eW91ciBjYXNlLCB5b3UncmUgZG9pbmcgdGhlIHNhbWUgbWtmcyAoNEsNCj4+PiBzZWN0b3Jz
aXplKSBvbiB0aGUgcGh5c2ljYWwgZGlzaywgdGhlbiBhZGQgYSBuZXcgZGlzaywgYW5kIGZp
bmFsbHkNCj4+PiBiYWxhbmNlZCB0aGUgZnM/DQo+Pj4NCj4+IE5vLiBJIGRpZG4ndCBzcGVj
aWZpZWQgc2VjdG9yIHNpemUgaW4gZmlyc3QgcGxhY2UsIGp1c3QgIm1rZnMuYnRyZnMNCj4+
ICRkZXYiIG9uIGRlZmF1bHQgbG9vbmdhcmNobGludXggKGtlcm5lbCA2LjcuMCkuDQo+DQo+
IE1pbmQgdG8gcmUtcnVuIHRoZSBta2ZzLmJ0cmZzIG9uIHRoZSBwaHlzaWNhbCBkaXNrIGFu
ZCBwcm92aWRlIHRoZSANCj4gb3V0cHV0Pw0KPg0KPiBJIGJlbGlldmUgdGhpcyBpcyBiZWNh
dXNlIHlvdSdyZSB1c2luZyB0aGUgbGF0ZXN0IGJ0cmZzLXByb2dzLCB3aGljaCBieQ0KPiBk
ZWZhdWx0IGlzIHVzaW5nIDRLIHNlY3RvcnNpemUgYnkgZGVmYXVsdC4NCj4NCkkgaGF2ZSBj
aGVja2VkIHVzaW5nIGR1cG0tc3VwZXIgYWZ0ZXIgZmlyc3QgbWtmcywgc2VjdG9yIHNpemUg
aXMgMTZrLg0KPg0KPj4gQW5kIGl0IHN1Y2NlZWQgd2l0aCBhZGQNCj4+IGRldmljZSAmIGJh
bGFuY2UuIFRoZW4gSSBzdWNjZXNzZnVsbHkgd3JpdGUgJiByZWFkIHNvbWUgc21hbGwgZmls
ZXMuIEl0DQo+PiBvb3BzIHdoZW4gSSBzdGFydGVkIHVzaW5nIHRyYW5zbWlzc2lvbiB0byBk
b3dubG9hZCBzb21ldGhpbmcgYW5kDQo+PiBleGVjdXRlZCAic3luYyIuDQo+Pj4gSUlSQyB0
aGUgYmFsYW5jZSBpdHNlbGYgc2hvdWxkIG5vdCBzdWNjZWVkLCBubyBtYXR0ZXIgaWYgaXQn
cyBlbXVsYXRlZA0KPj4+IG9yIHJlYWwgZGlza3MsIGFzIGRhdGEgUkFJRDEgcmVxdWlyZXMg
em9uZWQgUlNUIHN1cHBvcnQuDQo+Pj4NCj4+PiBJZiB0aGF0J3MgdGhlIGNhc2UsIGl0IGxv
b2tzIGxpa2Ugc29tZSBjaGVja3MgZ290IGJ5cGFzc2VkLCBhbmQgb25lIA0KPj4+IGNvcHkN
Cj4+PiBvZiB0aGUgcmFpZDEgYmJpbyBkb2Vzbid0IGdldCBpdHMgY29udGVudCBzZXR1cCBw
cm9wZXJseSB0aHVzIA0KPj4+IGxlYWRpbmcgdG8NCj4+PiB0aGUgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlLg0KPj4+DQo+Pj4gQW55d2F5LCBJJ2xsIHRyeSB0byByZXByb2R1Y2UgaXQg
bmV4dCB3ZWVrIGxvY2FsbHksIG9yIEknbGwgYXNrIGZvciB0aGUNCj4+PiBhY2Nlc3MgdG8g
eW91ciBsb29uc29uIHN5c3RlbSBzb29uLg0KPj4+DQo+Pj4gVGhhbmtzLA0KPj4+IFF1DQo+
Pj4+DQo+Pj4+IFdoZXRoZXIgaXQgaXMgNGsgb3IgMTZrLCBrZXJuZWwgd2lsbCBoYXZlICJ6
b25lZDogZGF0YSByYWlkMSBuZWVkcw0KPj4+PiByYWlkLXN0cmlwZS10cmVlIg0KPj4+Pg0K
Pj4+PiDCoD4gSWYgeW91IGNhbiBwcm92aWRlIHNvbWUgaGVscCwgaXQgd291bGQgc3VwZXIg
Z3JlYXQuDQo+Pj4+DQo+Pj4+IFN1cmUuIEkgY2FuIHByb3ZpZGUgYWNjZXNzIHRvIG15IGxv
b25nc29uIHcvIGR1YWwgSEM2MjAgaWYgeW91IA0KPj4+PiB3aXNoLiBZb3UNCj4+Pj4gY2Fu
IGNvbnRhY3QgbWUgb24gdC5tZS9oYW55dXdlaTcwLg0KPj4+Pg0KPj4+PiDCoD4gY2FuIHlv
dSBwcm92aWRlIHRoZSBmYWRkcjJsaW5lIG91dHB1dCBmb3INCj4+Pj4gwqA+ICJidHJmc19m
aW5pc2hfb3JkZXJlZF9leHRlbnQrMHgyNCI/DQo+Pj4+DQo+Pj4+IEkgaGF2ZSByZWNvbXBp
bGVkIGtlcm5lbCB0byBhZGQgREVCVUdfSU5GTy4gSGVyZSdzIHJlc3VsdC4NCj4+Pj4NCj4+
Pj4gW2h5d0Bsb29uZzNhNiBsaW51eC02LjcuMl0kIC4vc2NyaXB0cy9mYWRkcjJsaW5lIGZz
L2J0cmZzL2J0cmZzLmtvDQo+Pj4+IGJ0cmZzX2ZpbmlzaF9vcmRlcmVkX2V4dGVudCsweDI0
DQo+Pj4+IGJ0cmZzX2ZpbmlzaF9vcmRlcmVkX2V4dGVudCsweDI0LzB4YzA6DQo+Pj4+IHNw
aW5sb2NrX2NoZWNrIGF0DQo+Pj4+IC9ob21lL2h5dy9rZXJuZWxfYnVpbGQvbGludXgtNi43
LjIvLi9pbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6MzI2DQo+Pj4+IChpbmxpbmVkIGJ5KSBi
dHJmc19maW5pc2hfb3JkZXJlZF9leHRlbnQgYXQNCj4+Pj4gL2hvbWUvaHl3L2tlcm5lbF9i
dWlsZC9saW51eC02LjcuMi9mcy9idHJmcy9vcmRlcmVkLWRhdGEuYzozODENCj4+Pj4NCj4+
Pj4g5ZyoIDIwMjQvMi81IDEzOjIyLCBRdSBXZW5ydW8g5YaZ6YGTOg0KPj4+Pj4NCj4+Pj4+
DQo+Pj4+PiBPbiAyMDI0LzIvNCAyMDowNCwg6Z+p5LqO5oOfIHdyb3RlOg0KPj4+Pj4+IMKg
PiBpZS4gbWtmcy5idHJmcyAtLXNlY3RvcnNpemUgMTZrLiBpdCB3b3JrcyEgSSBjYW4gc3lu
YyB3aXRob3V0IGFueQ0KPj4+Pj4+IHByb2JsZW0gbm93LiBJIHdpbGwgY29udGludWUgdG8g
bW9uaXRvciBpZiBhbnkgaXNzdWVzIG9jY3VycmVkLiANCj4+Pj4+PiBzZWVtcw0KPj4+Pj4+
IGxpa2UgSSBjYW4gb25seSB1c2UgdGhlc2UgZGlza3Mgb24gbXkgbG9vbmdzb24gbWFjaGlu
ZSBmb3IgYSB3aGlsZS4NCj4+Pj4+DQo+Pj4+PiBBbnkgY2x1ZSBob3cgY2FuIEkgcHVyY2hh
c2Ugc3VjaCBkaXNrcz8NCj4+Pj4+IEFuZCB3aGF0J3MgdGhlIGludGVyZmFjZT8gKE5WTUU/
IFNBVEE/IFUyPykNCj4+Pj4+DQo+Pj4+PiBJIGNhbiBnbyB0cnkgcWVtdSB6b25lZCBudm1l
IG9uIG15IGFhcmNoNjQgaG9zdCwgYnV0IHNvIGZhciB0aGUgDQo+Pj4+PiBTb0MgaXMNCj4+
Pj4+IG9mZmxpbmUgKHdvbid0IGJlIG9ubGluZSB1bnRpbCB0aGlzIHdlZWtlbmQpLg0KPj4+
Pj4NCj4+Pj4+IEFuZCBoYXZlIHlvdSB0cmllZCBlbXVsYXRlZCB6b25lZCBkZXZpY2UgKG5v
IG1hdHRlciBpZiBpdCdzIHFlbXUgDQo+Pj4+PiB6b25lZA0KPj4+Pj4gZW11bGF0aW9uIG9y
IG5iZCBvciB3aGF0ZXZlcikgd2l0aCA0SyBzZWN0b3JzaXplPw0KPj4+Pj4NCj4+Pj4+DQo+
Pj4+PiBTbyBmYXIgd2UgZG9uJ3QgaGF2ZSBnb29kIGVub3VnaCBjb3ZlcmFnZSB3aXRoIHpv
bmVkIG9uIHN1YnBhZ2UsIEkgDQo+Pj4+PiBoYXZlDQo+Pj4+PiB0aGUgcGh5c2ljYWwgaGFy
ZHdhcmUgb2YgYWFyY2g2NCAoYW5kIFZNcyB3aXRoIGRpZmZlcmVudCBwYWdlIHNpemUpLA0K
Pj4+Pj4gYnV0DQo+Pj4+PiBJIGRvbid0IGhhdmUgYW55IHpvbmVkIGRldmljZXMuDQo+Pj4+
Pg0KPj4+Pj4gSWYgeW91IGNhbiBwcm92aWRlIHNvbWUgaGVscCwgaXQgd291bGQgc3VwZXIg
Z3JlYXQuDQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gSXMgdGhlcmUgYW55IHByb2dyZXNzIG9y
IHByb3Bvc2VkIHBhdGNoIGZvciBzdWJwYWdlIGxheWVyIGZpeD8NCj4+Pj4+Pg0KPj4+Pj4+
IOWcqCAyMDI0LzIvNCA2OjE1LCBEYXZpZCBTdGVyYmEg5YaZ6YGTOg0KPj4+Pj4+PiBPbiBT
YXQsIEZlYiAwMywgMjAyNCBhdCAwNjoxODowOVBNICswODAwLCDpn6nkuo7mg58gd3JvdGU6
DQo+Pj4+Pj4+PiBXaGVuIG1rZnMsIEkgaW50ZW50aW9uYWxseSB1c2VkICItcyA0ayIgZm9y
IGJldHRlciBjb21wYXRpYmlsaXR5Lg0KPj4+Pj4+Pj4gQW5kIC9zeXMvZnMvYnRyZnMvZmVh
dHVyZXMvc3VwcG9ydGVkX3NlY3RvcnNpemVzIGlzIDQwOTYgMTYzODQsDQo+Pj4+Pj4+PiB3
aGljaA0KPj4+Pj4+Pj4gc2hvdWxkIGJlIG9rLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IGJ0cmZz
LXByb2dzIGlzIDYuNi4yLTEsIGlzIHRoaXMgcmVsYXRlZD8NCj4+Pj4+Pj4gTm8sIHRoaXMg
aXMgc29tZXRoaW5nIGluIGtlcm5lbC4gWW91IGNvdWxkIHRlc3QgaWYgc2FtZSBwYWdlIGFu
ZA0KPj4+Pj4+PiBzZWN0b3INCj4+Pj4+Pj4gc2l6ZSB3b3JrcywgaWUuIG1rZnMuYnRyZnMg
LS1zZWN0b3JzaXplIDE2ay4gVGhpcyBhdm9pZHMgdXNpbmcgdGhlDQo+Pj4+Pj4+IHN1YnBh
Z2UgbGF5ZXIgdGhhdCB0cmFuc2FsYXRlcyB0aGUgNGsgc2VjdG9ycyA8LT4gMTZrIHBhZ2Vz
LiANCj4+Pj4+Pj4gVGhpcyBoYXMNCj4+Pj4+Pj4gdGhlIGtub3duIGludGVyb3BlcmFiaWxp
dHkgaXNzdWVzIHdpdGggZGlmZmVyZW50IHBhZ2UgYW5kIHNlY3Rvcg0KPj4+Pj4+PiBzaXpl
cw0KPj4+Pj4+PiBidXQgaWYgaXQgZG9lcyBub3QgYWZmZWN0IHlvdSwgeW91IGNhbiB1c2Ug
aXQuDQo+Pj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gQW5vdGhlciB0aGluZyBpcywgSSBkb24ndCBr
bm93IGhvdyB0aGUgbG9vbmdzb24ga2VybmVsIGR1bXAgd29ya3MsIA0KPj4+Pj4gYnV0DQo+
Pj4+PiBjYW4geW91IHByb3ZpZGUgdGhlIGZhZGRyMmxpbmUgb3V0cHV0IGZvcg0KPj4+Pj4g
ImJ0cmZzX2ZpbmlzaF9vcmRlcmVkX2V4dGVudCsweDI0Ij8NCj4+Pj4+DQo+Pj4+PiBJdCBs
b29rcyBsaWtlIG9yZGVyZWQtPmlub2RlIGlzIG5vdCBwcm9wZXJseSBpbml0aWFsaXplZCBi
dXQgSSdtIG5vdA0KPj4+Pj4gMTAwJSBzdXJlLg0KPj4+Pj4NCj4+Pj4+IFRoYW5rcywNCj4+
Pj4+IFF1DQo+Pj4+Pg0KPj4+DQo+Pg0KPj4NCj4NCg==


