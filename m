Return-Path: <linux-btrfs+bounces-2313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857C9850D16
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 05:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6471C213BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 04:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D20A5235;
	Mon, 12 Feb 2024 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="GYPFTPvP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2764428
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707710488; cv=none; b=iEukw8mLxR7uFcsusVpje6KMLFlVAjBj2iAcI0dXNzZGYpy95CK2pTvN+KoS4PpIVKdOfy26S8MWWKLIWNiOY6m3xqMrqwkhVdEd6v9uRGd7G8rqO71+YKFv0UU572/6TevGKNMC7OMczjtwcwcE/PoUy2h6rYG+45hZOV6WfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707710488; c=relaxed/simple;
	bh=wL21n9mxfLqXAYsZLyqczhz/jW2KQVtvQzXz2GDHtH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGokB9yh8z5AFh3lDYtLpI8sfgiR1d/5u6Jmi8yxo3ishheNwLSufCU9UNzjXIsKesZCvVlAYsk5tVCgSAMuDsVdiioIPac6rebHvI2giN8Qr2QJPB5HXgN3hCKjEyb7cR5qiIxq78xd58I07IIxsyExxz/AXSfwkesp3YTCVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=GYPFTPvP; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1707710434;
	bh=wL21n9mxfLqXAYsZLyqczhz/jW2KQVtvQzXz2GDHtH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GYPFTPvPXbL10yzJGq9n/+P+0Z7vq4KEC3CC7duX4uWmYtirzmWG5PtnqRv4xOGrY
	 ok7i/C7VrKpVHKJDiBDi3tyDiXaEm1gdpmgB0k6TcG52wX1COK2gIWEFZjIbkRHsC/
	 jZcLqaUNkQjYC93j9G//VCcrE/WWcKu2P7hBNbdM=
X-QQ-mid: bizesmtp74t1707710431td2k75sr
X-QQ-Originating-IP: TyCNjafdO0U0ZPpZouP4GarfUWZPhhNnQbIFzaFfbuM=
Received: from [192.168.1.136] ( [223.150.251.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Feb 2024 12:00:30 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: qcKkmz/zJhx0NenOBQzlluWF84gwkJQO783SRce9ZPggX1RJucz1zRMgUb/0F
	DUrYywhXdI6BKSj5ZOgWKuNVxhXnaXeIQvhH3AmFdZjTF4fUcZwmgUmviaiqlcC2uxwq95K
	4xkvFekaj7m11nGsopD+Eylo3W+MK242+xQWtTbK7LnCchAVXIQ5Witv/8Kk+RPasyvrJ8s
	yHnfflOQMi2ld6Qwo7WZOME+sX2PxxFSivQTGCwpCheJQt+Lzic7TxExGjJYjCjbttGSUJh
	wL7nDhZxYA5kjFPum/+BahY+Ma+pqIuAwXeEAURqEJWRAziyeGhYDNF8egm8y+OXJtqnPeg
	rSJcynSCNANIMbSo59gcqAA3mOm2kMmpvX7WUVuWFWfDmsjn3A=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16330151264162165331
Message-ID: <5CC35B932F67CCB9+9e353874-5b52-4d77-bcf6-1eefc247a53d@bupt.moe>
Date: Mon, 12 Feb 2024 12:00:29 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
References: <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
 <c34e93ef-8bc1-4e53-b009-0d8fc150e635@kernel.org>
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <c34e93ef-8bc1-4e53-b009-0d8fc150e635@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------l0s2c0wTS7J5EvbxjGH9Y1z7"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------l0s2c0wTS7J5EvbxjGH9Y1z7
Content-Type: multipart/mixed; boundary="------------ErPbzmdh4k1Ui0YP5gYHVG8s";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
Message-ID: <9e353874-5b52-4d77-bcf6-1eefc247a53d@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
References: <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
 <c34e93ef-8bc1-4e53-b009-0d8fc150e635@kernel.org>
In-Reply-To: <c34e93ef-8bc1-4e53-b009-0d8fc150e635@kernel.org>
Autocrypt-Gossip: addr=quwenruo.btrfs@gmx.com; keydata=
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

--------------ErPbzmdh4k1Ui0YP5gYHVG8s
Content-Type: multipart/mixed; boundary="------------LiVFfgx3JButxRlzM3Yt06cU"

--------------LiVFfgx3JButxRlzM3Yt06cU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQrlnKggMjAyNC8yLzEyIDk6NTksIERhbWllbiBMZSBNb2FsIOWGmemBkzoNCj4gT24gMi85
LzI0IDE5OjQ2LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBPbiBhIHpvbmVkIGZp
bGVzeXN0ZW0gd2l0aCBjb252ZW50aW9uYWwgem9uZXMsIHdlJ3JlIHNraXBwaW5nIHRoZSBi
bG9jaw0KPj4gZ3JvdXAgcHJvZmlsZSBjaGVja3MgZm9yIHRoZSBjb252ZW50aW9uYWwgem9u
ZXMuDQo+Pg0KPj4gVGhpcyBhbGxvd3MgY29udmVydGluZyBhIHpvbmVkIGZpbGVzeXN0ZW0n
cyBkYXRhIGJsb2NrIGdyb3VwcyB0byBSQUlEIHdoZW4NCj4+IGFsbCBvZiB0aGUgem9uZXMg
YmFja2luZyB0aGUgY2h1bmsgYXJlIG9uIGNvbnZlbnRpb25hbCB6b25lcy4gIEJ1dCB0aGlz
DQo+PiB3aWxsIGxlYWQgdG8gcHJvYmxlbXMsIG9uY2Ugd2UncmUgdHJ5aW5nIHRvIGFsbG9j
YXRlIGNodW5rcyBiYWNrZWQgYnkNCj4+IHNlcXVlbnRpYWwgem9uZXMuDQo+Pg0KPj4gU28g
YWxzbyBjaGVjayBmb3IgY29udmVudGlvbmFsIHpvbmVzIHdoZW4gbG9hZGluZyBhIGJsb2Nr
IGdyb3VwJ3MgcHJvZmlsZQ0KPj4gb24gdGhlbS4NCj4+DQo+PiBSZXBvcnRlZC1ieTog6Z+p
5LqO5oOfIDxocnhAYnVwdC5tb2U+DQo+IExldCdzIGtlZXAgdXNpbmcgdGhlIHJvbWFuIGFs
cGhhYmV0IGZvciBuYW1lcyBwbGVhc2UuLi4NCg0KVXBkYXRlZC4gQ2FuIGNoYW5nZSB0byAi
SEFOIFl1d2VpIi4NCg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+IC0tLQ0KPj4gICBmcy9idHJmcy96b25l
ZC5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9mcy9idHJmcy96b25lZC5jIGIvZnMvYnRyZnMvem9uZWQuYw0KPj4gaW5kZXgg
ZDk3MTY0NTZiY2UwLi41YmViNmI5MzZlNjEgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy96
b25lZC5jDQo+PiArKysgYi9mcy9idHJmcy96b25lZC5jDQo+PiBAQCAtMTM2OSw4ICsxMzY5
LDEwIEBAIHN0YXRpYyBpbnQgYnRyZnNfbG9hZF9ibG9ja19ncm91cF9zaW5nbGUoc3RydWN0
IGJ0cmZzX2Jsb2NrX2dyb3VwICpiZywNCj4+ICAgCQlyZXR1cm4gLUVJTzsNCj4+ICAgCX0N
Cj4+ICAgDQo+PiAtCWJnLT5hbGxvY19vZmZzZXQgPSBpbmZvLT5hbGxvY19vZmZzZXQ7DQo+
PiAtCWJnLT56b25lX2NhcGFjaXR5ID0gaW5mby0+Y2FwYWNpdHk7DQo+PiArCWlmIChpbmZv
LT5hbGxvY19vZmZzZXQgIT0gV1BfQ09OVkVOVElPTkFMKSB7DQo+PiArCQliZy0+YWxsb2Nf
b2Zmc2V0ID0gaW5mby0+YWxsb2Nfb2Zmc2V0Ow0KPj4gKwkJYmctPnpvbmVfY2FwYWNpdHkg
PSBpbmZvLT5jYXBhY2l0eTsNCj4+ICsJfQ0KPj4gICAJaWYgKHRlc3RfYml0KDAsIGFjdGl2
ZSkpDQo+PiAgIAkJc2V0X2JpdChCTE9DS19HUk9VUF9GTEFHX1pPTkVfSVNfQUNUSVZFLCAm
YmctPnJ1bnRpbWVfZmxhZ3MpOw0KPj4gICAJcmV0dXJuIDA7DQo+PiBAQCAtMTQwNiw2ICsx
NDA4LDE2IEBAIHN0YXRpYyBpbnQgYnRyZnNfbG9hZF9ibG9ja19ncm91cF9kdXAoc3RydWN0
IGJ0cmZzX2Jsb2NrX2dyb3VwICpiZywNCj4+ICAgCQlyZXR1cm4gLUVJTzsNCj4+ICAgCX0N
Cj4+ICAgDQo+PiArCWlmICh6b25lX2luZm9bMF0uYWxsb2Nfb2Zmc2V0ID09IFdQX0NPTlZF
TlRJT05BTCkgew0KPj4gKwkJem9uZV9pbmZvWzBdLmFsbG9jX29mZnNldCA9IGJnLT5hbGxv
Y19vZmZzZXQ7DQo+PiArCQl6b25lX2luZm9bMF0uY2FwYWNpdHkgPSBiZy0+bGVuZ3RoOw0K
Pj4gKwl9DQo+PiArDQo+PiArCWlmICh6b25lX2luZm9bMV0uYWxsb2Nfb2Zmc2V0ID09IFdQ
X0NPTlZFTlRJT05BTCkgew0KPj4gKwkJem9uZV9pbmZvWzFdLmFsbG9jX29mZnNldCA9IGJn
LT5hbGxvY19vZmZzZXQ7DQo+PiArCQl6b25lX2luZm9bMV0uY2FwYWNpdHkgPSBiZy0+bGVu
Z3RoOw0KPj4gKwl9DQo+PiArDQo+PiAgIAlpZiAodGVzdF9iaXQoMCwgYWN0aXZlKSAhPSB0
ZXN0X2JpdCgxLCBhY3RpdmUpKSB7DQo+PiAgIAkJaWYgKCFidHJmc196b25lX2FjdGl2YXRl
KGJnKSkNCj4+ICAgCQkJcmV0dXJuIC1FSU87DQo+PiBAQCAtMTQ1OCw2ICsxNDcwLDkgQEAg
c3RhdGljIGludCBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3JhaWQxKHN0cnVjdCBidHJmc19i
bG9ja19ncm91cCAqYmcsDQo+PiAgIAkJCQkJCSB6b25lX2luZm9bMV0uY2FwYWNpdHkpOw0K
Pj4gICAJfQ0KPj4gICANCj4+ICsJaWYgKHpvbmVfaW5mb1swXS5hbGxvY19vZmZzZXQgPT0g
V1BfQ09OVkVOVElPTkFMKQ0KPj4gKwkJem9uZV9pbmZvWzBdLmFsbG9jX29mZnNldCA9IGJn
LT5hbGxvY19vZmZzZXQ7DQo+PiArDQo+PiAgIAlpZiAoem9uZV9pbmZvWzBdLmFsbG9jX29m
ZnNldCAhPSBXUF9NSVNTSU5HX0RFVikNCj4+ICAgCQliZy0+YWxsb2Nfb2Zmc2V0ID0gem9u
ZV9pbmZvWzBdLmFsbG9jX29mZnNldDsNCj4+ICAgCWVsc2UNCj4+IEBAIC0xNDc5LDYgKzE0
OTQsMTEgQEAgc3RhdGljIGludCBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3JhaWQwKHN0cnVj
dCBidHJmc19ibG9ja19ncm91cCAqYmcsDQo+PiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+PiAg
IAl9DQo+PiAgIA0KPj4gKwlmb3IgKGludCBpID0gMDsgaSA8IG1hcC0+bnVtX3N0cmlwZXM7
IGkrKykgew0KPj4gKwkJaWYgKHpvbmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfQ09O
VkVOVElPTkFMKQ0KPj4gKwkJCXpvbmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPSBiZy0+YWxs
b2Nfb2Zmc2V0Ow0KPj4gKwl9DQo+PiArDQo+PiAgIAlmb3IgKGludCBpID0gMDsgaSA8IG1h
cC0+bnVtX3N0cmlwZXM7IGkrKykgew0KPj4gICAJCWlmICh6b25lX2luZm9baV0uYWxsb2Nf
b2Zmc2V0ID09IFdQX01JU1NJTkdfREVWIHx8DQo+PiAgIAkJICAgIHpvbmVfaW5mb1tpXS5h
bGxvY19vZmZzZXQgPT0gV1BfQ09OVkVOVElPTkFMKQ0KPj4gQEAgLTE1MTEsNiArMTUzMSwx
MSBAQCBzdGF0aWMgaW50IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfcmFpZDEwKHN0cnVjdCBi
dHJmc19ibG9ja19ncm91cCAqYmcsDQo+PiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgIAl9
DQo+PiAgIA0KPj4gKwlmb3IgKGludCBpID0gMDsgaSA8IG1hcC0+bnVtX3N0cmlwZXM7IGkr
Kykgew0KPj4gKwkJaWYgKHpvbmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfQ09OVkVO
VElPTkFMKQ0KPj4gKwkJCXpvbmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPSBiZy0+YWxsb2Nf
b2Zmc2V0Ow0KPj4gKwl9DQo+PiArDQo+PiAgIAlmb3IgKGludCBpID0gMDsgaSA8IG1hcC0+
bnVtX3N0cmlwZXM7IGkrKykgew0KPj4gICAJCWlmICh6b25lX2luZm9baV0uYWxsb2Nfb2Zm
c2V0ID09IFdQX01JU1NJTkdfREVWIHx8DQo+PiAgIAkJICAgIHpvbmVfaW5mb1tpXS5hbGxv
Y19vZmZzZXQgPT0gV1BfQ09OVkVOVElPTkFMKQ0KPj4gQEAgLTE2MDUsNyArMTYzMCw2IEBA
IGludCBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3pvbmVfaW5mbyhzdHJ1Y3QgYnRyZnNfYmxv
Y2tfZ3JvdXAgKmNhY2hlLCBib29sIG5ldykNCj4+ICAgCQl9IGVsc2UgaWYgKG1hcC0+bnVt
X3N0cmlwZXMgPT0gbnVtX2NvbnZlbnRpb25hbCkgew0KPj4gICAJCQljYWNoZS0+YWxsb2Nf
b2Zmc2V0ID0gbGFzdF9hbGxvYzsNCj4+ICAgCQkJc2V0X2JpdChCTE9DS19HUk9VUF9GTEFH
X1pPTkVfSVNfQUNUSVZFLCAmY2FjaGUtPnJ1bnRpbWVfZmxhZ3MpOw0KPj4gLQkJCWdvdG8g
b3V0Ow0KPj4gICAJCX0NCj4+ICAgCX0NCj4+ICAgDQo=
--------------LiVFfgx3JButxRlzM3Yt06cU
Content-Type: application/pgp-keys; name="OpenPGP_0xCC7801A4C3E3A368.asc"
Content-Disposition: attachment; filename="OpenPGP_0xCC7801A4C3E3A368.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEYd2CwRYJKwYBBAHaRw8BAQdA+Cjl7faceXuI8bf4TOInbIgM8RRMSrlNqkJM
iX6XUOjNLUhBTiBZdXdlaSAoaGFueXV3ZWk3MCkgPGhhbnl1d2VpNzBAZ21haWwu
Y29tPsKQBBMWCAA4FiEE5jAMjRwseUJjIHytzHgBpMPjo2gFAmHdg0QCGwEFCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AACgkQzHgBpMPjo2huYQD+IBK5NHWTngw/Ujcf
wnTmjXVBqJdrjC8XSHoMQepgwE4BALosq8/PFwesiQjXRo5a7dGyvswgkWtr0LMo
Bp5SQXkKzSXpn6nkuo7mg58gKGhhbnl1d2VpNzApIDxocnhAYnVwdC5tb2U+wpAE
ExYIADgWIQTmMAyNHCx5QmMgfK3MeAGkw+OjaAUCYd2CwQIbAQULCQgHAgYVCgkI
CwIEFgIDAQIeAQIXgAAKCRDMeAGkw+OjaLlDAP9Wh3ee0/6NIL76n6qx9jvM3EKm
51/AzDdLEz1T26b+fwEAg9vWtLc8gPfjVGsKsXMBJAv57qkz+kws/229mux51wHN
HemfqeS6juaDnyA8aGFueXV3ZWk3MEBxcS5jb20+wpAEExYIADgWIQTmMAyNHCx5
QmMgfK3MeAGkw+OjaAUCYd2DJAIbAQULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
CRDMeAGkw+OjaIxvAP9PxxZKTM60lDb/SbyDbfP8Bzi4LfZSa8T6GcBK5gUbGQD/
cw7hCEHEYdqIa1HATmXIsWozofsrlc4nRVeOjBm7SAbOMwRh3YXMFgkrBgEEAdpH
DwEBB0BjhXs3EEqaQMMe+y6eQPrN/iijsRn0+V7Yfxgv3LZNMsLANQQYFggAJhYh
BOYwDI0cLHlCYyB8rcx4AaTD46NoBQJh3YXMAhsCBQkJZgGAAIEJEMx4AaTD46No
diAEGRYIAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCYd2FzAAKCRBLkKfpYfpB
U/OHAP98maDWlKN7WlOaIlIuL4nnmeeKlW1zRweQ4nbngJWTZQD+IZ07dJMb41M7
3k3jPaT+uspGa+D3HivKAvnYGogLAw14AQEAywpAA/ze6ujATllsN9bQFOMThnaC
FYS3fYEVucLp57sA/RBfjnsQxA4ADe1EJaE0YYwDMo5UKga/wT9Wk90a5LIPzjgE
Yd2DUhIKKwYBBAGXVQEFAQEHQObBEtGrlnW9aBtHCkwYROmOqVF9AZuLZnAyJotA
j/4KAwEIB8J+BBgWCAAmFiEE5jAMjRwseUJjIHytzHgBpMPjo2gFAmHdg1ICGwwF
CQlmAYAACgkQzHgBpMPjo2jG2gD+LkrU5GPlDTUEYxBYBEyfd4igkf2TyeGbwFU5
pUwrFtgA/0tbB+3oaUUI3jwAbGWlUpXn2+iROFfqokr+fGa4SSUM
=3D/880
-----END PGP PUBLIC KEY BLOCK-----

--------------LiVFfgx3JButxRlzM3Yt06cU--

--------------ErPbzmdh4k1Ui0YP5gYHVG8s--

--------------l0s2c0wTS7J5EvbxjGH9Y1z7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZcmX3QAKCRBLkKfpYfpB
Uzy5AP9brReIbBu8wbil2Thi5IPxLPa1LHoMSeS4lKasgFVlfgD9FmNp5ln+HZZy
n7UnW1vhTZFh+TWYIVk/snFZ58qiugQ=
=03QA
-----END PGP SIGNATURE-----

--------------l0s2c0wTS7J5EvbxjGH9Y1z7--

