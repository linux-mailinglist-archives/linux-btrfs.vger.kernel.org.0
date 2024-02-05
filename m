Return-Path: <linux-btrfs+bounces-2099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A888493FA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 07:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD584281CBF
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 06:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB840D310;
	Mon,  5 Feb 2024 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="R3UFt+FE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA311184
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115590; cv=none; b=QLg5aTVeJFioRzpnUQMKgWrWzY6wgPqq7TMTwgJpAObtLhhe9foyg5AHyO30PCeo4g18IFx8grjvzRXJWBUVuYhd0lkH+dEEZ2ZsGg9guqn1kWRiRUofZebsy09eIMrQe7MojHFuqMY6vuTap/deE/Iq30/23LPDjEu4y/cNIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115590; c=relaxed/simple;
	bh=qiyNLK0+XIwMirUKkBJW9uO2FJqy9lO4JmWm4LGP38s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4J90XX3J90pyox3keSmMZY8KEKdSwZvgkQPFrgMCcuaHYotjEgHBdEheosIHSZFwtx1yJqnH/5tf7RXriXldJDCuh6za0hdH6gTFTt6BdWCGzgWXKy+iqVqgOxQUQQx5R+ZfxpIV1L4c29q2CyWr8I49OKGHf6j7qhlfKeye2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=R3UFt+FE; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1707115575;
	bh=qiyNLK0+XIwMirUKkBJW9uO2FJqy9lO4JmWm4LGP38s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=R3UFt+FEdPUovjlnvQTijGx79Kr+fHgf2TVbgKn4wbNqhtFS5DxZBiLoLgq0gvGz9
	 aRvZytk+Q2C9MEf5YoUFaKSRTbuHtXXIG4y53HxcGVRc1tyEUWKyptPzSXsBCYgHDg
	 RxqjbEUEBlaJSIG4mt2EfSRDVoWWsTbeQL41kAC0=
X-QQ-mid: bizesmtpipv603t1707115573trii
X-QQ-Originating-IP: P6fwaVetOUSclFD/UJ9I/aa0vo1dqjbMZuOKuaYXook=
Received: from [IPV6:240e:381:70b1:9300:6009:d ( [255.217.104.8])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 05 Feb 2024 14:46:12 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: 5q30pvLz2ifmU14zGePFXYX1kaNzk2AUowFCLj+q36akHUkVldghsfCP+Xck+
	IZQas8ZJ0nvfH7zg/lXEMZu13kWQltPRyHCFs+7cY96qkCglI9V+ck0+Wf1kir9ZnuKcyeA
	+8dnlbEaCySezlEUOvHMpszHzQ+8qtdJpcK80d3f1xIWYZ/MJxlC3EKJJpWnWfjHSvh/Opo
	qZMy2WFevwZHBQ8PcEGtanBxZj0tap/s7WFoCQmWU4CtqDG5asbYxIMwNpicVicqc+/uvX1
	LBzIugjCrXOjNDy91Ya1VL06UQqpind2aYRrZ6VLm/HHRfCqoUUhpV5+RJw6NJklzBtoHJd
	oVd/tYy7IfzGe3SW0R2qAfl6y/0JA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17763136370063475400
Message-ID: <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
Date: Mon, 5 Feb 2024 14:46:12 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
In-Reply-To: <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

ID4gQW55IGNsdWUgaG93IGNhbiBJIHB1cmNoYXNlIHN1Y2ggZGlza3M/DQogPiBBbmQgd2hh
dCdzIHRoZSBpbnRlcmZhY2U/IChOVk1FPyBTQVRBPyBVMj8pDQoNCkkgcHVyY2hhc2VkIHRo
ZXNlIG9uIHVzZWQgbWFya2V0IGFwcCBjYWxsZWQgWGlhbnl1KOmXsumxvCkgd2hpY2ggbWF5
IGJlIA0KZGlmZmljdWx0IGZvciB1c2Vycw0Kb3V0c2lkZSBDaGluYSBtYWlubGFuZC4gQW5k
IGl0cyBzdXBwbHkgaXMgZXh0cmVtZWx5IHVuc3RhYmxlLg0KDQpJdHMgaW50ZXJmYWNlIGlz
IFNBVEEuIE1pbmUgbW9kZWwgaXMgSFNINzIxNDE0QUxONk0wLiBTcGVjIGxpbms6IA0KaHR0
cHM6Ly9kb2N1bWVudHMud2VzdGVybmRpZ2l0YWwuY29tL2NvbnRlbnQvZGFtL2RvYy1saWJy
YXJ5L2VuX3VzL2Fzc2V0cy9wdWJsaWMvd2VzdGVybi1kaWdpdGFsL3Byb2R1Y3QvZGF0YS1j
ZW50ZXItZHJpdmVzL3VsdHJhc3Rhci1kYy1oYzYwMC1zZXJpZXMvZGF0YS1zaGVldC11bHRy
YXN0YXItZGMtaGM2MjAucGRmDQoNCiA+IEFuZCBoYXZlIHlvdSB0cmllZCBlbXVsYXRlZCB6
b25lZCBkZXZpY2UgKG5vIG1hdHRlciBpZiBpdCdzIHFlbXUgem9uZWQNCiA+IGVtdWxhdGlv
biBvciBuYmQgb3Igd2hhdGV2ZXIpIHdpdGggNEsgc2VjdG9yc2l6ZT8NCg0KSGF2ZSB0cmll
ZCBvbiBteSBsb29uZ3NvbiB3aXRoIHRoaXMgc2NyaXB0IGZyb20gDQpodHRwczovL2dpdGh1
Yi5jb20vUm9uZ3JvbmdnZzkNCg0KID4gLi9udWxsYiBzZXR1cA0KID4gLi9udWxsYiBjcmVh
dGUgLXMgNDA5NiAteiAyNTYNCiA+IC4vbnVsbGIgY3JlYXRlIC1zIDQwOTYgLXogMjU2DQog
PiAuL251bGxiIGxzDQogPiBta2ZzLmJ0cmZzIC1zIDE2ayAvZGV2L251bGxiMA0KID4gbW91
bnQgL2Rldi9udWxsYjAgL21udC90bXANCiA+IGJ0cmZzIGRldmljZSBhZGQgL2Rldi9udWxs
YjEgL21udC90bXANCiA+IGJ0cmZzIGJhbGFuY2Ugc3RhcnQgLWRjb252ZXJ0PXJhaWQxIC1t
Y29udmVydD1yYWlkMSAvbW50L3RtcA0KDQpXaGV0aGVyIGl0IGlzIDRrIG9yIDE2aywga2Vy
bmVsIHdpbGwgaGF2ZSAiem9uZWQ6IGRhdGEgcmFpZDEgbmVlZHMgDQpyYWlkLXN0cmlwZS10
cmVlIg0KDQogPiBJZiB5b3UgY2FuIHByb3ZpZGUgc29tZSBoZWxwLCBpdCB3b3VsZCBzdXBl
ciBncmVhdC4NCg0KU3VyZS4gSSBjYW4gcHJvdmlkZSBhY2Nlc3MgdG8gbXkgbG9vbmdzb24g
dy8gZHVhbCBIQzYyMCBpZiB5b3Ugd2lzaC4gWW91IA0KY2FuIGNvbnRhY3QgbWUgb24gdC5t
ZS9oYW55dXdlaTcwLg0KDQogPiBjYW4geW91IHByb3ZpZGUgdGhlIGZhZGRyMmxpbmUgb3V0
cHV0IGZvcg0KID4gImJ0cmZzX2ZpbmlzaF9vcmRlcmVkX2V4dGVudCsweDI0Ij8NCg0KSSBo
YXZlIHJlY29tcGlsZWQga2VybmVsIHRvIGFkZCBERUJVR19JTkZPLiBIZXJlJ3MgcmVzdWx0
Lg0KDQpbaHl3QGxvb25nM2E2IGxpbnV4LTYuNy4yXSQgLi9zY3JpcHRzL2ZhZGRyMmxpbmUg
ZnMvYnRyZnMvYnRyZnMua28gDQpidHJmc19maW5pc2hfb3JkZXJlZF9leHRlbnQrMHgyNA0K
YnRyZnNfZmluaXNoX29yZGVyZWRfZXh0ZW50KzB4MjQvMHhjMDoNCnNwaW5sb2NrX2NoZWNr
IGF0IA0KL2hvbWUvaHl3L2tlcm5lbF9idWlsZC9saW51eC02LjcuMi8uL2luY2x1ZGUvbGlu
dXgvc3BpbmxvY2suaDozMjYNCihpbmxpbmVkIGJ5KSBidHJmc19maW5pc2hfb3JkZXJlZF9l
eHRlbnQgYXQgDQovaG9tZS9oeXcva2VybmVsX2J1aWxkL2xpbnV4LTYuNy4yL2ZzL2J0cmZz
L29yZGVyZWQtZGF0YS5jOjM4MQ0KDQrlnKggMjAyNC8yLzUgMTM6MjIsIFF1IFdlbnJ1byDl
hpnpgZM6DQo+DQo+DQo+IE9uIDIwMjQvMi80IDIwOjA0LCDpn6nkuo7mg58gd3JvdGU6DQo+
PiDCoD4gaWUuIG1rZnMuYnRyZnMgLS1zZWN0b3JzaXplIDE2ay4gaXQgd29ya3MhIEkgY2Fu
IHN5bmMgd2l0aG91dCBhbnkNCj4+IHByb2JsZW0gbm93LiBJIHdpbGwgY29udGludWUgdG8g
bW9uaXRvciBpZiBhbnkgaXNzdWVzIG9jY3VycmVkLiBzZWVtcw0KPj4gbGlrZSBJIGNhbiBv
bmx5IHVzZSB0aGVzZSBkaXNrcyBvbiBteSBsb29uZ3NvbiBtYWNoaW5lIGZvciBhIHdoaWxl
Lg0KPg0KPiBBbnkgY2x1ZSBob3cgY2FuIEkgcHVyY2hhc2Ugc3VjaCBkaXNrcz8NCj4gQW5k
IHdoYXQncyB0aGUgaW50ZXJmYWNlPyAoTlZNRT8gU0FUQT8gVTI/KQ0KPg0KPiBJIGNhbiBn
byB0cnkgcWVtdSB6b25lZCBudm1lIG9uIG15IGFhcmNoNjQgaG9zdCwgYnV0IHNvIGZhciB0
aGUgU29DIGlzDQo+IG9mZmxpbmUgKHdvbid0IGJlIG9ubGluZSB1bnRpbCB0aGlzIHdlZWtl
bmQpLg0KPg0KPiBBbmQgaGF2ZSB5b3UgdHJpZWQgZW11bGF0ZWQgem9uZWQgZGV2aWNlIChu
byBtYXR0ZXIgaWYgaXQncyBxZW11IHpvbmVkDQo+IGVtdWxhdGlvbiBvciBuYmQgb3Igd2hh
dGV2ZXIpIHdpdGggNEsgc2VjdG9yc2l6ZT8NCj4NCj4NCj4gU28gZmFyIHdlIGRvbid0IGhh
dmUgZ29vZCBlbm91Z2ggY292ZXJhZ2Ugd2l0aCB6b25lZCBvbiBzdWJwYWdlLCBJIGhhdmUN
Cj4gdGhlIHBoeXNpY2FsIGhhcmR3YXJlIG9mIGFhcmNoNjQgKGFuZCBWTXMgd2l0aCBkaWZm
ZXJlbnQgcGFnZSBzaXplKSwgYnV0DQo+IEkgZG9uJ3QgaGF2ZSBhbnkgem9uZWQgZGV2aWNl
cy4NCj4NCj4gSWYgeW91IGNhbiBwcm92aWRlIHNvbWUgaGVscCwgaXQgd291bGQgc3VwZXIg
Z3JlYXQuDQo+DQo+Pg0KPj4gSXMgdGhlcmUgYW55IHByb2dyZXNzIG9yIHByb3Bvc2VkIHBh
dGNoIGZvciBzdWJwYWdlIGxheWVyIGZpeD8NCj4+DQo+PiDlnKggMjAyNC8yLzQgNjoxNSwg
RGF2aWQgU3RlcmJhIOWGmemBkzoNCj4+PiBPbiBTYXQsIEZlYiAwMywgMjAyNCBhdCAwNjox
ODowOVBNICswODAwLCDpn6nkuo7mg58gd3JvdGU6DQo+Pj4+IFdoZW4gbWtmcywgSSBpbnRl
bnRpb25hbGx5IHVzZWQgIi1zIDRrIiBmb3IgYmV0dGVyIGNvbXBhdGliaWxpdHkuDQo+Pj4+
IEFuZCAvc3lzL2ZzL2J0cmZzL2ZlYXR1cmVzL3N1cHBvcnRlZF9zZWN0b3JzaXplcyBpcyA0
MDk2IDE2Mzg0LCB3aGljaA0KPj4+PiBzaG91bGQgYmUgb2suDQo+Pj4+DQo+Pj4+IGJ0cmZz
LXByb2dzIGlzIDYuNi4yLTEsIGlzIHRoaXMgcmVsYXRlZD8NCj4+PiBObywgdGhpcyBpcyBz
b21ldGhpbmcgaW4ga2VybmVsLiBZb3UgY291bGQgdGVzdCBpZiBzYW1lIHBhZ2UgYW5kIHNl
Y3Rvcg0KPj4+IHNpemUgd29ya3MsIGllLiBta2ZzLmJ0cmZzIC0tc2VjdG9yc2l6ZSAxNmsu
IFRoaXMgYXZvaWRzIHVzaW5nIHRoZQ0KPj4+IHN1YnBhZ2UgbGF5ZXIgdGhhdCB0cmFuc2Fs
YXRlcyB0aGUgNGsgc2VjdG9ycyA8LT4gMTZrIHBhZ2VzLiBUaGlzIGhhcw0KPj4+IHRoZSBr
bm93biBpbnRlcm9wZXJhYmlsaXR5IGlzc3VlcyB3aXRoIGRpZmZlcmVudCBwYWdlIGFuZCBz
ZWN0b3Igc2l6ZXMNCj4+PiBidXQgaWYgaXQgZG9lcyBub3QgYWZmZWN0IHlvdSwgeW91IGNh
biB1c2UgaXQuDQo+Pj4NCj4NCj4gQW5vdGhlciB0aGluZyBpcywgSSBkb24ndCBrbm93IGhv
dyB0aGUgbG9vbmdzb24ga2VybmVsIGR1bXAgd29ya3MsIGJ1dA0KPiBjYW4geW91IHByb3Zp
ZGUgdGhlIGZhZGRyMmxpbmUgb3V0cHV0IGZvcg0KPiAiYnRyZnNfZmluaXNoX29yZGVyZWRf
ZXh0ZW50KzB4MjQiPw0KPg0KPiBJdCBsb29rcyBsaWtlIG9yZGVyZWQtPmlub2RlIGlzIG5v
dCBwcm9wZXJseSBpbml0aWFsaXplZCBidXQgSSdtIG5vdA0KPiAxMDAlIHN1cmUuDQo+DQo+
IFRoYW5rcywNCj4gUXUNCj4NCg==

