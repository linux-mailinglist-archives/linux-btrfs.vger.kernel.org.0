Return-Path: <linux-btrfs+bounces-7704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D0966F27
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 05:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16D01C21E02
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 03:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28115674E;
	Sat, 31 Aug 2024 03:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="C9Zn7d2j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8621446B4
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Aug 2024 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725076572; cv=none; b=UMEJkohwI5ec6CmjDDr0hLzpWqtwnrnTQIlc5MgxMaMPzN2fVqU/WUQRzOUWW1ct5mcmZ6W+HTbvjJWSzaRP1iVQxhnvQyrkIsvzawLRIwO4QVD3R/+PjyWvF2sPzO8z1bmq4UuY2ki3YKsaNXUHHBoMjMGdMfVNiQuOYG/BkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725076572; c=relaxed/simple;
	bh=Vn9FV12YIFsbNKeJI7hK2AuUMxcLVGnXywypeLnQs0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUlzQY+vnEd17yZwyAnYTQwhRJfzRok4YeHf3JZMbt4yRjFo82jttyDycoKFwyDTbi32n1VztcXDFBraNmxfrKJAGhySa8nVNQo8Nihh6Flhs34oUdrhcp3byOs44BL+pE9oIa2L/U7whVFr9LraSNhIty/9DONzcwYq2hR0gT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=C9Zn7d2j; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1725076555;
	bh=Vn9FV12YIFsbNKeJI7hK2AuUMxcLVGnXywypeLnQs0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=C9Zn7d2jLevfOb6pcZyBeTjtiToYdAc04myjJEN2QtjEqeol3jPKhSsJmc8fG1hhX
	 b4y8uHqdM5OnbOtlhWypnSijgM3l4tCPEoBkyDuDyisitGhGm+k13i3g8SfzwlsFPj
	 qSH+scI4U0JM5XgwVK5tFy2eZx26H9R6egh4dpik=
X-QQ-mid: bizesmtp91t1725076554tlz1hsr6
X-QQ-Originating-IP: GvUhMle0trNgokR43CFKMirE0X11BpLpXZ6iuq6FJgk=
Received: from [192.168.1.105] ( [60.215.125.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 31 Aug 2024 11:55:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9680354208277392040
Message-ID: <DA75CD1FC5E6DF1D+d9249015-4fb1-478d-8064-e8e9ab4d25f8@bupt.moe>
Date: Sat, 31 Aug 2024 11:55:45 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: handle broken write pointer on zones
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: xuefer@gmail.com
References: <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------opDbCn2ljKrp3mqV2SlXAsxr"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------opDbCn2ljKrp3mqV2SlXAsxr
Content-Type: multipart/mixed; boundary="------------cz9O1ufFYeJAf7xtMmRS6Jyr";
 protected-headers="v1"
From: Yuwei Han <hrx@bupt.moe>
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: xuefer@gmail.com
Message-ID: <d9249015-4fb1-478d-8064-e8e9ab4d25f8@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: handle broken write pointer on zones
References: <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>
In-Reply-To: <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>

--------------cz9O1ufFYeJAf7xtMmRS6Jyr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCuWcqCAyMDI0LzgvMzEgMDA6MzIsIE5hb2hpcm8gQW90YSDlhpnpgZM6DQo+IEJ0cmZz
IHJlamVjdHMgdG8gbW91bnQgYSBGUyBpZiBpdCBmaW5kcyBhIGJsb2NrIGdyb3VwIHdpdGgg
YSBicm9rZW4gd3JpdGUNCj4gcG9pbnRlciAoZS5nLCB1bmVxdWFsIHdyaXRlIHBvaW50ZXJz
IG9uIHR3byB6b25lcyBvZiBSQUlEMSBibG9jayBncm91cCkuDQo+IFNpbmNlIHN1Y2ggY2Fz
ZSBjYW4gaGFwcGVuIGVhc2lseSB3aXRoIGEgcG93ZXItbG9zcyBvciBjcmFzaCBvZiBhIHN5
c3RlbSwNCj4gd2UgbmVlZCB0byBoYW5kbGUgdGhlIGNhc2UgbW9yZSBnZW50bHkuDQo+IA0K
Q2FuIHRoaXMgKGJyb2tlbiB3cml0ZSBwb2ludGVyKSBiZSByZXByb2R1Y2VkIHdpdGggc29t
ZSBnZW50bGUgd2F5PyBTbyBJIA0KY2FuIHRlc3QgaXQgd2l0aG91dCB3b3JyeWluZyBidXJu
aW5nIG91dCBteSBwcmVjaW91cyBIQzYyMCAoIHRoZXkgYXJlIA0KdmVyeSBkaWZmaWN1bHQg
dG8gcHVyY2hhc2UpLg0KPiBIYW5kbGUgc3VjaCBibG9jayBncm91cCBieSBtYWtpbmcgaXQg
dW5hbGxvY2F0YWJsZSwgc28gdGhhdCB0aGVyZSB3aWxsIGJlDQo+IG5vIHdyaXRlcyBpbnRv
IGl0LiBUaGF0IGNhbiBiZSBkb25lIGJ5IHNldHRpbmcgdGhlIGFsbG9jYXRpb24gcG9pbnRl
ciBhdA0KPiB0aGUgZW5kIG9mIGFsbG9jYXRpbmcgcmVnaW9uICg9IGJsb2NrX2dyb3VwLT56
b25lX2NhcGFjaXR5KS4gVGhlbiwgZXhpc3RpbmcNCj4gY29kZSBoYW5kbGUgem9uZV91bnVz
YWJsZSBwcm9wZXJseS4NCj4gDQo+IEhhdmluZyBwcm9wZXIgem9uZV9jYXBhY2l0eSBpcyBu
ZWNlc3NhcnkgZm9yIHRoZSBjaGFuZ2UuIFNvLCBzZXQgaXQgYXMgZmFzdA0KPiBhcyBwb3Nz
aWJsZS4NCj4gDQo+IFdlIGNhbm5vdCBoYW5kbGUgUkFJRDAgYW5kIFJBSUQxMCBjYXNlIGxp
a2UgdGhpcy4gQnV0LCB0aGV5IGFyZSBhbnl3YXkNCj4gdW5hYmxlIHRvIHJlYWQgYmVjYXVz
ZSBvZiBhIG1pc3Npbmcgc3RyaXBlLg0KPiANCj4gRml4ZXM6IDI2NWY3MjM3ZGQyNSAoImJ0
cmZzOiB6b25lZDogYWxsb3cgRFVQIG9uIG1ldGEtZGF0YSBibG9jayBncm91cHMiKQ0KPiBG
aXhlczogNTY4MjIwZmE5NjU3ICgiYnRyZnM6IHpvbmVkOiBzdXBwb3J0IFJBSUQwLzEvMTAg
b24gdG9wIG9mIHJhaWQgc3RyaXBlIHRyZWUiKQ0KPiBDQzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZyAjIDYuMSsNCj4gUmVwb3J0ZWQtYnk6IEhBTiBZdXdlaSA8aHJ4QGJ1cHQubW9lPg0K
PiBDYzogWHVlZmVyIDx4dWVmZXJAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBOYW9o
aXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPiAtLS0NCj4gICBmcy9idHJmcy96
b25lZC5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZnMvYnRyZnMvem9uZWQuYyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4gaW5kZXgg
NjZmNjNlODJhZjc5Li4wNDdlMzMzNzg1MmUgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3pv
bmVkLmMNCj4gKysrIGIvZnMvYnRyZnMvem9uZWQuYw0KPiBAQCAtMTQwNiw2ICsxNDA2LDgg
QEAgc3RhdGljIGludCBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX2R1cChzdHJ1Y3QgYnRyZnNf
YmxvY2tfZ3JvdXAgKmJnLA0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCX0NCj4gICAN
Cj4gKwliZy0+em9uZV9jYXBhY2l0eSA9IG1pbl9ub3RfemVybyh6b25lX2luZm9bMF0uY2Fw
YWNpdHksIHpvbmVfaW5mb1sxXS5jYXBhY2l0eSk7DQo+ICsNCj4gICAJaWYgKHpvbmVfaW5m
b1swXS5hbGxvY19vZmZzZXQgPT0gV1BfTUlTU0lOR19ERVYpIHsNCj4gICAJCWJ0cmZzX2Vy
cihiZy0+ZnNfaW5mbywNCj4gICAJCQkgICJ6b25lZDogY2Fubm90IHJlY292ZXIgd3JpdGUg
cG9pbnRlciBmb3Igem9uZSAlbGx1IiwNCj4gQEAgLTE0MzIsNyArMTQzNCw2IEBAIHN0YXRp
YyBpbnQgYnRyZnNfbG9hZF9ibG9ja19ncm91cF9kdXAoc3RydWN0IGJ0cmZzX2Jsb2NrX2dy
b3VwICpiZywNCj4gICAJfQ0KPiAgIA0KPiAgIAliZy0+YWxsb2Nfb2Zmc2V0ID0gem9uZV9p
bmZvWzBdLmFsbG9jX29mZnNldDsNCj4gLQliZy0+em9uZV9jYXBhY2l0eSA9IG1pbih6b25l
X2luZm9bMF0uY2FwYWNpdHksIHpvbmVfaW5mb1sxXS5jYXBhY2l0eSk7DQo+ICAgCXJldHVy
biAwOw0KPiAgIH0NCj4gICANCj4gQEAgLTE0NTAsNiArMTQ1MSw5IEBAIHN0YXRpYyBpbnQg
YnRyZnNfbG9hZF9ibG9ja19ncm91cF9yYWlkMShzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAg
KmJnLA0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCX0NCj4gICANCj4gKwkvKiBJbiBj
YXNlIGEgZGV2aWNlIGlzIG1pc3Npbmcgd2UgaGF2ZSBhIGNhcCBvZiAwLCBzbyBkb24ndCB1
c2UgaXQuICovDQo+ICsJYmctPnpvbmVfY2FwYWNpdHkgPSBtaW5fbm90X3plcm8oem9uZV9p
bmZvWzBdLmNhcGFjaXR5LCB6b25lX2luZm9bMV0uY2FwYWNpdHkpOw0KPiArDQo+ICAgCWZv
ciAoaSA9IDA7IGkgPCBtYXAtPm51bV9zdHJpcGVzOyBpKyspIHsNCj4gICAJCWlmICh6b25l
X2luZm9baV0uYWxsb2Nfb2Zmc2V0ID09IFdQX01JU1NJTkdfREVWIHx8DQo+ICAgCQkgICAg
em9uZV9pbmZvW2ldLmFsbG9jX29mZnNldCA9PSBXUF9DT05WRU5USU9OQUwpDQo+IEBAIC0x
NDcxLDkgKzE0NzUsNiBAQCBzdGF0aWMgaW50IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfcmFp
ZDEoc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpiZywNCj4gICAJCQlpZiAodGVzdF9iaXQo
MCwgYWN0aXZlKSkNCj4gICAJCQkJc2V0X2JpdChCTE9DS19HUk9VUF9GTEFHX1pPTkVfSVNf
QUNUSVZFLCAmYmctPnJ1bnRpbWVfZmxhZ3MpOw0KPiAgIAkJfQ0KPiAtCQkvKiBJbiBjYXNl
IGEgZGV2aWNlIGlzIG1pc3Npbmcgd2UgaGF2ZSBhIGNhcCBvZiAwLCBzbyBkb24ndCB1c2Ug
aXQuICovDQo+IC0JCWJnLT56b25lX2NhcGFjaXR5ID0gbWluX25vdF96ZXJvKHpvbmVfaW5m
b1swXS5jYXBhY2l0eSwNCj4gLQkJCQkJCSB6b25lX2luZm9bMV0uY2FwYWNpdHkpOw0KPiAg
IAl9DQo+ICAgDQo+ICAgCWlmICh6b25lX2luZm9bMF0uYWxsb2Nfb2Zmc2V0ICE9IFdQX01J
U1NJTkdfREVWKQ0KPiBAQCAtMTU2Myw2ICsxNTY0LDcgQEAgaW50IGJ0cmZzX2xvYWRfYmxv
Y2tfZ3JvdXBfem9uZV9pbmZvKHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqY2FjaGUsIGJv
b2wgbmV3KQ0KPiAgIAl1bnNpZ25lZCBsb25nICphY3RpdmUgPSBOVUxMOw0KPiAgIAl1NjQg
bGFzdF9hbGxvYyA9IDA7DQo+ICAgCXUzMiBudW1fc2VxdWVudGlhbCA9IDAsIG51bV9jb252
ZW50aW9uYWwgPSAwOw0KPiArCXU2NCBwcm9maWxlOw0KPiAgIA0KPiAgIAlpZiAoIWJ0cmZz
X2lzX3pvbmVkKGZzX2luZm8pKQ0KPiAgIAkJcmV0dXJuIDA7DQo+IEBAIC0xNjIzLDcgKzE2
MjUsOCBAQCBpbnQgYnRyZnNfbG9hZF9ibG9ja19ncm91cF96b25lX2luZm8oc3RydWN0IGJ0
cmZzX2Jsb2NrX2dyb3VwICpjYWNoZSwgYm9vbCBuZXcpDQo+ICAgCQl9DQo+ICAgCX0NCj4g
ICANCj4gLQlzd2l0Y2ggKG1hcC0+dHlwZSAmIEJUUkZTX0JMT0NLX0dST1VQX1BST0ZJTEVf
TUFTSykgew0KPiArCXByb2ZpbGUgPSBtYXAtPnR5cGUgJiBCVFJGU19CTE9DS19HUk9VUF9Q
Uk9GSUxFX01BU0s7DQo+ICsJc3dpdGNoIChwcm9maWxlKSB7DQo+ICAgCWNhc2UgMDogLyog
c2luZ2xlICovDQo+ICAgCQlyZXQgPSBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3NpbmdsZShj
YWNoZSwgJnpvbmVfaW5mb1swXSwgYWN0aXZlKTsNCj4gICAJCWJyZWFrOw0KPiBAQCAtMTY1
MCw2ICsxNjUzLDIzIEBAIGludCBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3pvbmVfaW5mbyhz
dHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmNhY2hlLCBib29sIG5ldykNCj4gICAJCWdvdG8g
b3V0Ow0KPiAgIAl9DQo+ICAgDQo+ICsJaWYgKHJldCA9PSAtRUlPICYmIHByb2ZpbGUgIT0g
MCAmJiBwcm9maWxlICE9IEJUUkZTX0JMT0NLX0dST1VQX1JBSUQwICYmDQo+ICsJICAgIHBy
b2ZpbGUgIT0gQlRSRlNfQkxPQ0tfR1JPVVBfUkFJRDEwKSB7DQo+ICsJCS8qDQo+ICsJCSAq
IERldGVjdGVkIGJyb2tlbiB3cml0ZSBwb2ludGVyLiAgTWFrZSB0aGlzIGJsb2NrIGdyb3Vw
DQo+ICsJCSAqIHVuYWxsb2NhdGFibGUgYnkgc2V0dGluZyB0aGUgYWxsb2NhdGlvbiBwb2lu
dGVyIGF0IHRoZSBlbmQgb2YNCj4gKwkJICogYWxsb2NhdGFibGUgcmVnaW9uLiBSZWxvY2F0
aW5nIHRoaXMgYmxvY2sgZ3JvdXAgd2lsbCBmaXggdGhlDQo+ICsJCSAqIG1pc21hdGNoLg0K
PiArCQkgKg0KPiArCQkgKiBDdXJyZW50bHksIHdlIGNhbm5vdCBoYW5kbGUgUkFJRDAgb3Ig
UkFJRDEwIGNhc2UgbGlrZSB0aGlzDQo+ICsJCSAqIGJlY2F1c2Ugd2UgZG9uJ3QgaGF2ZSBh
IHByb3BlciB6b25lX2NhcGFjaXR5IHZhbHVlLiBCdXQsDQo+ICsJCSAqIHJlYWRpbmcgZnJv
bSB0aGlzIGJsb2NrIGdyb3VwIHdvbid0IHdvcmsgYW55d2F5IGJ5IGEgbWlzc2luZw0KPiAr
CQkgKiBzdHJpcGUuDQo+ICsJCSAqLw0KPiArCQljYWNoZS0+YWxsb2Nfb2Zmc2V0ID0gY2Fj
aGUtPnpvbmVfY2FwYWNpdHk7DQo+ICsJCXJldCA9IDA7DQo+ICsJfQ0KPiArDQo+ICAgb3V0
Og0KPiAgIAkvKiBSZWplY3Qgbm9uIFNJTkdMRSBkYXRhIHByb2ZpbGVzIHdpdGhvdXQgUlNU
ICovDQo+ICAgCWlmICgobWFwLT50eXBlICYgQlRSRlNfQkxPQ0tfR1JPVVBfREFUQSkgJiYN
Cg==

--------------cz9O1ufFYeJAf7xtMmRS6Jyr--

--------------opDbCn2ljKrp3mqV2SlXAsxr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZtKUQQAKCRBLkKfpYfpB
U+75AQC6MaAYxv2kM0ox+g8eUvtlf1vxsVGw4Gpd1w6zMuxiGgEAthxXxsa/Hee1
EFAA9zefsQLujgaMhK5XBCr323qkuAI=
=2SmF
-----END PGP SIGNATURE-----

--------------opDbCn2ljKrp3mqV2SlXAsxr--

