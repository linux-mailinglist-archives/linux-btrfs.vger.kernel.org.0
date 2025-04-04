Return-Path: <linux-btrfs+bounces-12784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56002A7B565
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 03:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F0F1755D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 01:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8ADF71;
	Fri,  4 Apr 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="E5rSCC4F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2222E62C4
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743729811; cv=none; b=tlfnH9HrB54DjM1MVkRJ3oR+asNEaFHeaHl9zfTXrT4kRbZ6iyAPU/bcrBBeHSLBkxD6fRw0JFuvxoIbBCaQlXxcrhpd4/V6ygXvd5WNIg2k0tU7ZKLyO74PccxOo4TIKELQB85CpcEldu+78UWx2NOnmhEKbqXZmA0PR6Rhn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743729811; c=relaxed/simple;
	bh=GchJ8n+8mjcKqA8ZGzLL31oOzyET8y3qWrmixpdXhbg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qALYsIDpLGCSTkvn3f9k6Ej+2eEXV7cx2RC06p0WdvDsbJCwXXCLtWcR+2bsVxAKsrpJoUtOCgZOqYLN+wNOLscqnVr2s+9izbqdcO8EFKdXIESEZpgkP/wzMAr87zcTwLPxe/YJdtQwrt+wwchxuTmcHsIyBVqd425KLI0943I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=E5rSCC4F; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1743729803; x=1744334603; i=jimis@gmx.net;
	bh=rIoElOsTe/74YMb/hdhCJywjXvR5zdYT0L42QuodE80=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E5rSCC4FvxQdgx+dRfr2XKnEQJjAHIFaQ6DPLpQYJkzXjWJmRK9nwLzWe2ChbGbZ
	 cmhaFHY13IsTKPN1Yi8Sk/PpY1rj+G+FqbzcnxqdFE0T7b7hayLo2L7/PX8gJKsn+
	 CSL7unZ537v5H7HEQcnjHsLvjakzBurGw5275Izr8r+j1u5L1uRCQRFUKnnJfjz0P
	 LBJQJK4fcHTDUgBZ4/z4hjlqcOq8B+J1U9q9KLS+UOxjjDGYAISeD/WzNyUD6HZoN
	 Ltdx48wh7CnnpB7t3A48/+JXmWFBC0zfQT/Ac3ghTEe3R2oIyDr4zeVSAt1ScEQbO
	 XTMVYRVbwQlJWSKHkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from qtjimis-OpenSUSE-2.lan ([84.215.109.181]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N3bSt-1t0GWP2nXn-012qTY; Fri, 04 Apr 2025 03:23:22 +0200
Date: Fri, 4 Apr 2025 03:23:13 +0200 (CEST)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <939a6f4a-837b-4613-8761-b03f8d4809ea@gmx.com>
Message-ID: <b338d808-f691-9969-9e48-d4a9f0363af3@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com> <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net> <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
 <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net> <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com> <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net> <939a6f4a-837b-4613-8761-b03f8d4809ea@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770111-148246556-1743729802=:139110"
X-Provags-ID: V03:K1:RKO+r3k5qiERM1lvB6R+yxuyLnLLym+mU27/frCwrzv0ooIzNOC
 DQP8oFLTcUzeO9KbOhm3O+13t1umGDQi/r/47qqI5uksdZd+2hAyVEYRhEhwYK9whkxAqIf
 hwmPbuJRTGutvS+iuE9n5STaRx/4Mi71YPXCHxXnjgb/Na4qNxXQqEcT6vTfdhqNWxo1usF
 /5rlXwai9I+JeJkeAx/Rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EdPJ0vMImAg=;H/RD3aD2tiw7PyAsXU5Gye3LNyd
 kAc+dyt32wq68tGh3srTAXxsotRa4Wk3FpqhEnkG4heEfFm5OPcWgYFXicvNiorwxgaOF+M0p
 G/zSMvefoJ4kvU7hIvG0y/LhE6xrH0L8QW0oFvK8HjIhiwIpL4nPi8AKak3879pAlUqWuRbRl
 JgedlQJ7hGfqywJEEYGFTOo8ZYBv++wTf7Kb4X57ir4Dx8nUp0sqUGQX7bbXFOQHc/r1x7QXZ
 scMGLHx9ekyeFeVrFLpCJpjEi+wvZyRdFzBIOt19ntcVW3yvIZSAWyK1SHgxqf5TkwCn10rdj
 yVxxuQ5KZT0FMZotBynhnjZYVWz30YGS+PCnBPbi60KV8UKY9JiEPAbW55+CNdWWRXvHMmV9p
 T8o3yOU3b1SqnRMNsszg6El4MKQ9VX3qwAeRU9tunymI4XSunvbyHkVIJNHB0ovhpwoNnCRWt
 cJNtGnz4fQ9Kz7fsA7wmjJGNBfsWyOubrz71OySiuvYb+JPIfkxQN6Q64muQlQ8Y28lWYSn8b
 wH9MDe5qJUVREOEx0EtxuAjQdnbmSn6jSZ4KnvEChlDHLs0btoxlwsIUga8u1KoaKDS1chVVP
 jWVCz2I7v6EIuSSx2d+VintbMgq2wY7gptykFHYzRkvyEkDUBj7uNu0P5KK5SUFoB0Rbm44KI
 AONXYTX+0L1a5qMj8bHPG2MzHEfzyyMSi8/5iRKZ7woxUe/nyz/THk5A4Z/8F4kaOgUL19scM
 uRsqKoJUsO8anC3v2+h9ZVJKubZUbrNgOCbiTFmGP79U4KCy1EX6TdMm2I1lYTUD8og3ElfRN
 w1nm4bZwBsYEcj/cqVH0bjgJA2oIJPW5Uq2l1kJRMnkD+vYt/g18afgvSEMOB4QPBaQPbrOwU
 NzwePiYVJrkb3GFNcsRDWx1m2iE3fIKr3smIRbLf8k0n4/P4F3/jfoqhr8vepbgL+qaJF161Q
 fZmKGmUgKsUM/Up/zWNDCAkH04AVh+M3Hv7zgCOT+feXquaXntUfysbYAwjgLwBF+6rvV/e+O
 ENriG2/il/0EhzThSsz3usaOh8gEBBRGdQYG7dFPW3sgUTBAjh97n1AQB3iAXypNq/I2iW6jT
 X470DBQLE2Eb3OlnktZOVqnUkqz8SN4ZmipKiZsnVLXREKFhAOAtSJCC+5cP8awSzGkz+XWY1
 livXj94UOSjJuLIh6E+9isw9dr7uOOQOrr6anDCLdIy/npP3uV4inTz/yKSDp8DbJh37T66dO
 XV/XWWpjp8B640y6f7hcbchlT4ivcL2+sr+HdRZVMQLsSb1ranWrYt/JfuIG6uDtckhOxokE2
 6OtituXfHDxS7oxuDv1qbJhfMBqdgWCxR26pJ/rHkxaq3fzk/MptkQt6MS0zxtIpzhEQO3qOU
 xbFJXikhczv0JQHOuHWDSzJXWmTryVzTMWvcx4zbFGIGDLyInxX+zcIWTFmaBaX/dUa+4IXGq
 0YZsSNe48hNqfH4mVvJEvLN8s3zs=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770111-148246556-1743729802=:139110
Content-Type: text/plain; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback, please see the attached patches. I decided to
omit some details. I also include another simple patch clarifying that
compress-force might end up writing uncompressed blocks.

Thanks,
Dimitris

---1463770111-148246556-1743729802=:139110
Content-Type: text/x-patch; name=v1-0001-btrfs-compress-doc-clarify-compress-force-mount-o.patch
Content-Transfer-Encoding: BASE64
Content-ID: <9f7d5b8d-7555-21fa-a58c-a4e2ad0595e5@NO.WHERE>
Content-Description: 
Content-Disposition: attachment; filename=v1-0001-btrfs-compress-doc-clarify-compress-force-mount-o.patch

RnJvbSBjYWQ3ZDk4MDNmNWYxOWEwNWU4MjQ4MjAyY2U2ZTQ0ZThiYTVmMGJj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogRGltaXRyaW9zIEFw
b3N0b2xvdSA8amltaXNAcXQuaW8+DQpEYXRlOiBGcmksIDQgQXByIDIwMjUg
MDM6MDI6MzQgKzAyMDANClN1YmplY3Q6IFtQQVRDSCB2MSAxLzJdIGJ0cmZz
IGNvbXByZXNzIGRvYzogY2xhcmlmeSBjb21wcmVzcy1mb3JjZSBtb3VudA0K
IG9wdGlvbg0KDQotLS0NCiBEb2N1bWVudGF0aW9uL2NoLWNvbXByZXNzaW9u
LnJzdCB8IDkgKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vY2gtY29tcHJlc3Npb24ucnN0IGIvRG9jdW1lbnRhdGlvbi9j
aC1jb21wcmVzc2lvbi5yc3QNCmluZGV4IDMwYjg4NDljLi5iYzhmZWY4YiAx
MDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vY2gtY29tcHJlc3Npb24ucnN0
DQorKysgYi9Eb2N1bWVudGF0aW9uL2NoLWNvbXByZXNzaW9uLnJzdA0KQEAg
LTk4LDIyICs5OCwyMyBAQCBtb3JlIENQVSB0aGUgc3lzdGVtIHBlcmZvcm1h
bmNlIGlzIGFmZmVjdGVkLg0KIExldmVsIDAgYWx3YXlzIG1hcHMgdG8gdGhl
IGRlZmF1bHQuIFRoZSBjb21wcmVzc2lvbiBsZXZlbCBkb2VzIG5vdCBhZmZl
Y3QNCiBjb21wYXRpYmlsaXR5Lg0KIA0KIEluY29tcHJlc3NpYmxlIGRhdGEN
CiAtLS0tLS0tLS0tLS0tLS0tLS0tDQogDQogRmlsZXMgd2l0aCBhbHJlYWR5
IGNvbXByZXNzZWQgZGF0YSBvciB3aXRoIGRhdGEgdGhhdCB3b24ndCBjb21w
cmVzcyB3ZWxsIHdpdGgNCiB0aGUgQ1BVIGFuZCBtZW1vcnkgY29uc3RyYWlu
dHMgb2YgdGhlIGtlcm5lbCBpbXBsZW1lbnRhdGlvbnMgYXJlIHVzaW5nIGEg
c2ltcGxlDQogZGVjaXNpb24gbG9naWMuIElmIHRoZSBmaXJzdCBwb3J0aW9u
IG9mIGRhdGEgYmVpbmcgY29tcHJlc3NlZCBpcyBub3Qgc21hbGxlcg0KLXRo
YW4gdGhlIG9yaWdpbmFsLCB0aGUgY29tcHJlc3Npb24gb2YgdGhlIGZpbGUg
aXMgZGlzYWJsZWQgLS0gdW5sZXNzIHRoZQ0KLWZpbGVzeXN0ZW0gaXMgbW91
bnRlZCB3aXRoICpjb21wcmVzcy1mb3JjZSouIEluIHRoYXQgY2FzZSBjb21w
cmVzc2lvbiB3aWxsDQotYWx3YXlzIGJlIGF0dGVtcHRlZCBvbiB0aGUgZmls
ZSBvbmx5IHRvIGJlIGxhdGVyIGRpc2NhcmRlZC4gVGhpcyBpcyBub3Qgb3B0
aW1hbA0KLWFuZCBzdWJqZWN0IHRvIG9wdGltaXphdGlvbnMgYW5kIGZ1cnRo
ZXIgZGV2ZWxvcG1lbnQuDQordGhhbiB0aGUgb3JpZ2luYWwsIHRoZSBjb21w
cmVzc2lvbiBvZiB0aGUgd2hvbGUgZmlsZSBpcyBkaXNhYmxlZC4gVW5sZXNz
IHRoZQ0KK2ZpbGVzeXN0ZW0gaXMgbW91bnRlZCB3aXRoICpjb21wcmVzcy1m
b3JjZSogaW4gd2hpY2ggY2FzZSBidHJmcyB3aWxsIHRyeQ0KK2NvbXByZXNz
aW5nIGV2ZXJ5IGJsb2NrLCBmYWxsaW5nIGJhY2sgdG8gc3RvcmluZyB0aGUg
dW5jb21wcmVzc2VkIHZlcnNpb24gZm9yDQorZWFjaCBibG9jayB0aGF0IGVu
ZHMgdXAgbGFyZ2VyIGFmdGVyIGNvbXByZXNzaW9uLiBUaGlzIGlzIG5vdCBv
cHRpbWFsIGFuZA0KK3N1YmplY3QgdG8gb3B0aW1pemF0aW9ucyBhbmQgZnVy
dGhlciBkZXZlbG9wbWVudC4NCiANCiBJZiBhIGZpbGUgaXMgaWRlbnRpZmll
ZCBhcyBpbmNvbXByZXNzaWJsZSwgYSBmbGFnIGlzIHNldCAoKk5PQ09NUFJF
U1MqKSBhbmQgaXQncw0KIHN0aWNreS4gT24gdGhhdCBmaWxlIGNvbXByZXNz
aW9uIHdvbid0IGJlIHBlcmZvcm1lZCB1bmxlc3MgZm9yY2VkLiBUaGUgZmxh
Zw0KIGNhbiBiZSBhbHNvIHNldCBieSAqKmNoYXR0ciArbSoqIChzaW5jZSBl
MmZzcHJvZ3MgMS40Ni4yKSBvciBieSBwcm9wZXJ0aWVzIHdpdGgNCiB2YWx1
ZSAqbm8qIG9yICpub25lKi4gRW1wdHkgdmFsdWUgd2lsbCByZXNldCBpdCB0
byB0aGUgZGVmYXVsdCB0aGF0J3MgY3VycmVudGx5DQogYXBwbGljYWJsZSBv
biB0aGUgbW91bnRlZCBmaWxlc3lzdGVtLg0KIA0KIFRoZXJlIGFyZSB0d28g
d2F5cyB0byBkZXRlY3QgaW5jb21wcmVzc2libGUgZGF0YToNCiANCi0tIA0K
Mi40OS4wDQoNCg==

---1463770111-148246556-1743729802=:139110
Content-Type: text/x-patch; name=v1-0002-btrfs-compress-doc-mention-that-fallocate-disable.patch
Content-Transfer-Encoding: BASE64
Content-ID: <dd9edc6e-3745-0c7f-1ab6-7050f063c58f@NO.WHERE>
Content-Description: 
Content-Disposition: attachment; filename=v1-0002-btrfs-compress-doc-mention-that-fallocate-disable.patch

RnJvbSBjYjZkNTY1OWViOGFmYmRlNjhhNTM1NzBlNmIyMmQ5MzFiNmFmZmVk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogRGltaXRyaW9zIEFw
b3N0b2xvdSA8amltaXNAcXQuaW8+DQpEYXRlOiBGcmksIDQgQXByIDIwMjUg
MDM6MDY6NDAgKzAyMDANClN1YmplY3Q6IFtQQVRDSCB2MSAyLzJdIGJ0cmZz
IGNvbXByZXNzIGRvYzogbWVudGlvbiB0aGF0IGZhbGxvY2F0ZSBkaXNhYmxl
cw0KIGNvbXByZXNzaW9uDQoNCi0tLQ0KIERvY3VtZW50YXRpb24vY2gtY29t
cHJlc3Npb24ucnN0IHwgMTcgKysrKysrKysrKysrKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9jaC1jb21wcmVzc2lvbi5yc3QgYi9Eb2N1bWVudGF0aW9u
L2NoLWNvbXByZXNzaW9uLnJzdA0KaW5kZXggYmM4ZmVmOGIuLjkxNzRmOTdj
IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9jaC1jb21wcmVzc2lvbi5y
c3QNCisrKyBiL0RvY3VtZW50YXRpb24vY2gtY29tcHJlc3Npb24ucnN0DQpA
QCAtOTIsMTggKzkyLDM1IEBAIFRoZSBaU1REIHN1cHBvcnQgaW5jbHVkZXMg
bGV2ZWxzIC0xNS4uMTUsIGEgc3Vic2V0IG9mIGZ1bGwgcmFuZ2Ugb2Ygd2hh
dCBaU1REDQogcHJvdmlkZXMuIExldmVscyAtMTUuLi0xIGFyZSByZWFsLXRp
bWUgd2l0aCB3b3JzZSBjb21wcmVzc2lvbiByYXRpbywgbGV2ZWxzDQogMS4u
MyBhcmUgbmVhciByZWFsLXRpbWUgd2l0aCBnb29kIGNvbXByZXNzaW9uLCA0
Li44IGFyZSBzbG93ZXIgd2l0aCBpbXByb3ZlZA0KIGNvbXByZXNzaW9uIGFu
ZCA5Li4xNSB0cnkgZXZlbiBoYXJkZXIgdGhvdWdoIHRoZSByZXN1bHRpbmcg
c2l6ZSBtYXkgbm90IGJlDQogc2lnbmlmaWNhbnRseSBpbXByb3ZlZC4gSGln
aGVyIGxldmVscyBhbHNvIHJlcXVpcmUgbW9yZSBtZW1vcnkgYW5kIGFzIHRo
ZXkgbmVlZA0KIG1vcmUgQ1BVIHRoZSBzeXN0ZW0gcGVyZm9ybWFuY2UgaXMg
YWZmZWN0ZWQuDQogDQogTGV2ZWwgMCBhbHdheXMgbWFwcyB0byB0aGUgZGVm
YXVsdC4gVGhlIGNvbXByZXNzaW9uIGxldmVsIGRvZXMgbm90IGFmZmVjdA0K
IGNvbXBhdGliaWxpdHkuDQogDQorRXhjZXB0aW9ucw0KKy0tLS0tLS0tLS0N
CisNCitBbnkgZmlsZSB0aGF0IGhhcyBiZWVuIHRvdWNoZWQgYnkgdGhlICpm
YWxsb2NhdGUqIHN5c3RlbSBjYWxsIHdpbGwgYWx3YXlzIGJlDQorZXhjZXB0
ZWQgZnJvbSBjb21wcmVzc2lvbiBldmVuIGlmICpmb3JjZS1jb21wcmVzcyog
bW91bnQgb3B0aW9uIGlzIHVzZWQuDQorDQorVGhlIHJlYXNvbiBmb3IgdGhp
cyBpcyB0aGF0IGEgc3VjY2Vzc2Z1bCAqZmFsbG9jYXRlKiBjYWxsIG11c3Qg
Z3VhcmFudGVlIHRoYXQNCitmdXR1cmUgd3JpdGVzIHRvIHRoZSBhbGxvY2F0
ZWQgcmFuZ2Ugd2lsbCBub3QgZmFpbCBiZWNhdXNlIG9mIGxhY2sgb2Ygc3Bh
Y2UuDQorVGhpcyBpcyBkaWZmaWN1bHQgdG8gZ3VhcmFudGVlIGluIGEgQ09X
IGZpbGVzeXN0ZW0uIFRvIHJlZHVjZSB0aGUgY2hhbmNlcyBvZg0KK2l0IGhh
cHBlbmluZywgYnRyZnMgcHJlYWxsb2NhdGVzIHNwYWNlIGFuZCBkaXNhYmxl
cyBjb21wcmVzc2lvbiBmb3IgdGhlIGZpbGUuDQorDQorQXMgYSB3b3JrYXJv
dW5kLCBvbmUgY2FuIHRyaWdnZXIgYSBjb21wcmVzc2VkIHJld3JpdGUgZm9y
IHN1Y2ggYSBmaWxlIHVzaW5nIHRoZQ0KKypidHJmcyBkZWZyYWcqIGNvbW1h
bmQuIEJlIGF3YXJlIHRoYXQgaWYgdGhlIGZpbGUgaXMgdG91Y2hlZCBhZ2Fp
biBieSB0aGUNCisqZmFsbG9jYXRlKiBzeXN0ZW0gY2FsbCwgaXQgd2lsbCBi
ZSBleGNlcHRlZCBhZ2FpbiBmcm9tIGNvbXByZXNzaW9uIGZvciBhbGwgdGhl
DQorbmV3IGRhdGEgd3JpdHRlbiB0byBpdC4NCisNCisNCiBJbmNvbXByZXNz
aWJsZSBkYXRhDQogLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIA0KIEZpbGVzIHdp
dGggYWxyZWFkeSBjb21wcmVzc2VkIGRhdGEgb3Igd2l0aCBkYXRhIHRoYXQg
d29uJ3QgY29tcHJlc3Mgd2VsbCB3aXRoDQogdGhlIENQVSBhbmQgbWVtb3J5
IGNvbnN0cmFpbnRzIG9mIHRoZSBrZXJuZWwgaW1wbGVtZW50YXRpb25zIGFy
ZSB1c2luZyBhIHNpbXBsZQ0KIGRlY2lzaW9uIGxvZ2ljLiBJZiB0aGUgZmly
c3QgcG9ydGlvbiBvZiBkYXRhIGJlaW5nIGNvbXByZXNzZWQgaXMgbm90IHNt
YWxsZXINCiB0aGFuIHRoZSBvcmlnaW5hbCwgdGhlIGNvbXByZXNzaW9uIG9m
IHRoZSB3aG9sZSBmaWxlIGlzIGRpc2FibGVkLiBVbmxlc3MgdGhlDQogZmls
ZXN5c3RlbSBpcyBtb3VudGVkIHdpdGggKmNvbXByZXNzLWZvcmNlKiBpbiB3
aGljaCBjYXNlIGJ0cmZzIHdpbGwgdHJ5DQogY29tcHJlc3NpbmcgZXZlcnkg
YmxvY2ssIGZhbGxpbmcgYmFjayB0byBzdG9yaW5nIHRoZSB1bmNvbXByZXNz
ZWQgdmVyc2lvbiBmb3INCi0tIA0KMi40OS4wDQoNCg==

---1463770111-148246556-1743729802=:139110--

