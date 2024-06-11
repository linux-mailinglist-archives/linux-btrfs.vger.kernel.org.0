Return-Path: <linux-btrfs+bounces-5639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897EF9032F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 08:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD5E284B97
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67500171E43;
	Tue, 11 Jun 2024 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="y87O2nEr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F7418641
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088526; cv=none; b=Pphg7ZMnb17aikZEwh1TnDxmjO0++/pwU4TLY+IQOO2f4SJDnGbXPv8MfwUqIdOac6Qbp/HnJmXGDWccDvheCZdskqqcu/dzhtneSqc2dYJXvAcaM3at92mMPHgpaINS6c2StvU5ZC2nne69jEqgDziSEKnYbbaYJbUz00Qa7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088526; c=relaxed/simple;
	bh=o2J5cvz8z2QPWIe467V6iRqId633NWjyx4KoRW/pSy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+81kh78QuloVRzWfdoG6xKZBXLJ/5p2bIgyL8Wnd2SnRs9gF+jn40fqUIQ2echWSSluOrE5Gkvgxb8+WI8RT5cdD/saHA+eMdR827pLE8LhSjhofCwFvfpsR8gPuqIIJRgh51ZHVJaqRAj9o5kjXhtha3yKiXSjSe15ClkUUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=y87O2nEr; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1718088517;
	bh=o2J5cvz8z2QPWIe467V6iRqId633NWjyx4KoRW/pSy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=y87O2nEruV8RYEPfiv+zom4I5kbH63SbiFE7H/73bY+pNWS74JNsghaugoJ2FvW2k
	 +Vt9SHDRn0cQMEHwoMO0oZarbftIZVwf3Rkqq/PWxo793qzs2ude7XgsW+jKJ6ZILj
	 VpHmBmKMrNs90b7zAUk4EDrIgUYbK3kEhPsF7rEs=
X-QQ-mid: bizesmtpsz8t1718088516t8864on
X-QQ-Originating-IP: enDIgRAeooZjUhyrzJyUR0s4hLmUbqeXulQxs1F1KWc=
Received: from [192.168.1.5] ( [223.150.249.230])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Jun 2024 14:48:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17707310812674445700
Message-ID: <B15555845F2CCB38+2636f283-c234-44b4-9044-4f25650023f0@bupt.moe>
Date: Tue, 11 Jun 2024 14:48:33 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] unable to mount zoned volume after force shutdown
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
 <ab92f3bd-c1ca-496f-bcf7-d806459d9ce7@wdc.com>
 <2112398B543F8373+1a8c3746-b3f1-436a-97b1-debe2682cbf1@bupt.moe>
 <pidc6y4h62zt44c5m3rdwqbfauik5xtjbijoe6oqmqnkeig2ky@wfxoqxp6rvt7>
Content-Language: en-US
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <pidc6y4h62zt44c5m3rdwqbfauik5xtjbijoe6oqmqnkeig2ky@wfxoqxp6rvt7>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3aQIwWxUq4cAvfFdCIXS84IH"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3aQIwWxUq4cAvfFdCIXS84IH
Content-Type: multipart/mixed; boundary="------------Fl9xp4t3gWEx3I0WM8u1E1r8";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <2636f283-c234-44b4-9044-4f25650023f0@bupt.moe>
Subject: Re: [BUG] unable to mount zoned volume after force shutdown
References: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
 <ab92f3bd-c1ca-496f-bcf7-d806459d9ce7@wdc.com>
 <2112398B543F8373+1a8c3746-b3f1-436a-97b1-debe2682cbf1@bupt.moe>
 <pidc6y4h62zt44c5m3rdwqbfauik5xtjbijoe6oqmqnkeig2ky@wfxoqxp6rvt7>
In-Reply-To: <pidc6y4h62zt44c5m3rdwqbfauik5xtjbijoe6oqmqnkeig2ky@wfxoqxp6rvt7>

--------------Fl9xp4t3gWEx3I0WM8u1E1r8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQrlnKggMjAyNC82LzEwIDIyOjEzLCBOYW9oaXJvIEFvdGEg5YaZ6YGTOg0KPiBPbiBNb24s
IEp1biAxMCwgMjAyNCBhdCAwODo0NzozN1BNIEdNVCwgSEFOIFl1d2VpIHdyb3RlOg0KPj4g
5ZyoIDIwMjQvNi8xMCAxNjo1MywgSm9oYW5uZXMgVGh1bXNoaXJuIOWGmemBkzoNCj4+PiBP
biAwOS4wNi4yNCAwNDoyNCwgSEFOIFl1d2VpIHdyb3RlOg0KPj4+PiBJIGNhbid0IG1vdW50
IHZvbHVtZSBvbiBtdWx0aXBsZSB6b25lZCBkZXZpY2Ugd2hpY2ggZGF0YSBwcm9maWxlIGlz
DQo+Pj4+IHNpbmdsZSAmIG1ldGFkYXRhIHByb2ZpbGUgaXMgcmFpZDEuDQo+Pj4+IEl0IGV4
cGVyaWVuY2VkIG11bHRpcGxlIGZvcmNlZCBzaHV0ZG93biBkdWUgdG8ga2VybmVsIDYuMTAg
Y2FuJ3QNCj4+Pj4gcHJvcGVybHkgc2h1dGRvd24gb24gbG9vbmdhcmNoLg0KPj4+Pg0KPj4+
PiAjIGRtZXNnDQo+Pj4+DQo+Pj4+IFsgMTk2My42OTg3OTNdIEJUUkZTIGluZm8gKGRldmlj
ZSBzZGIpOiBmaXJzdCBtb3VudCBvZiBmaWxlc3lzdGVtDQo+Pj4+IGI1YjJkN2Q5LTlmMjct
NDkwNy1hNTU4LTc3ZThlODZkZjkzMw0KPj4+PiBbIDE5NjMuNzA3ODAxXSBCVFJGUyBpbmZv
IChkZXZpY2Ugc2RiKTogdXNpbmcgY3JjMzJjIChjcmMzMmMtZ2VuZXJpYykNCj4+Pj4gY2hl
Y2tzdW0gYWxnb3JpdGhtDQo+Pj4+IFsgMTk2My43MTU1OTddIEJUUkZTIGluZm8gKGRldmlj
ZSBzZGIpOiB1c2luZyBmcmVlLXNwYWNlLXRyZWUNCj4+Pj4gWyAxOTY1LjQ5MjA2Nl0gQlRS
RlMgaW5mbyAoZGV2aWNlIHNkYik6IGhvc3QtbWFuYWdlZCB6b25lZCBibG9jayBkZXZpY2UN
Cj4+Pj4gL2Rldi9zZGIsIDUyMTU2IHpvbmVzIG9mIDI2ODQzNTQ1NiBieXRlcw0KPj4+PiBb
IDE5NjYuOTUzNTkwXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogaG9zdC1tYW5hZ2VkIHpv
bmVkIGJsb2NrIGRldmljZQ0KPj4+PiAvZGV2L3NkYywgNTIxNTYgem9uZXMgb2YgMjY4NDM1
NDU2IGJ5dGVzDQo+Pj4+IFsgMTk2Ny4zNDY3NThdIEJUUkZTIGluZm8gKGRldmljZSBzZGIp
OiB6b25lZCBtb2RlIGVuYWJsZWQgd2l0aCB6b25lDQo+Pj4+IHNpemUgMjY4NDM1NDU2DQo+
Pj4+IFsgMjAyNi4yODczNTZdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RiKTogem9uZWQ6IHdy
aXRlIHBvaW50ZXIgb2Zmc2V0DQo+Pj4+IG1pc21hdGNoIG9mIHpvbmVzIGluIHJhaWQxIHBy
b2ZpbGUNCj4+Pj4gWyAyMDI2LjI5NjQ0NV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGIpOiB6
b25lZDogZmFpbGVkIHRvIGxvYWQgem9uZSBpbmZvDQo+Pj4+IG9mIGJnIDUzOTk4NDc2MzI4
OTYNCj4+Pj4gWyAyMDI2LjMwNDU3Nl0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGIpOiBmYWls
ZWQgdG8gcmVhZCBibG9jayBncm91cHM6IC01DQo+Pj4+IFsgMjAyNi4zNTI1NDddIEJUUkZT
IGVycm9yIChkZXZpY2Ugc2RiKTogb3Blbl9jdHJlZSBmYWlsZWQNCj4+Pj4NCj4+PiBDYW4g
eW91IGNoZWNrIHRoZSB3cml0ZSBwb2ludGVycyBmb3IgdGhlIHpvbmVzIG1hcHBpbmcgdG8g
dGhpcyBibG9jayBncm91cD8NCj4+Pg0KPj4+IHRoYXQgc2hvdWxkIGJlDQo+Pj4gYmxrem9u
ZSByZXBvcnQgLWMgMSAtbyAweDI3NEEwMDAwMCAvZGV2L3NkYg0KPj4gIyBibGt6b25lIHJl
cG9ydCAtYyAxIC1vIDB4Mjc0QTAwMDAwIC9kZXYvc2RiDQo+PiBzdGFydDogMHgyNzRhMDAw
MDAsIGxlbiAweDA4MDAwMCwgY2FwIDB4MDgwMDAwLCB3cHRyIDB4MDAwMDAwIHJlc2V0OjAN
Cj4+IG5vbi1zZXE6MCwgemNvbmQ6IDEoZW0pIFt0eXBlOiAyKFNFUV9XUklURV9SRVFVSVJF
RCldDQo+PiAjIGJsa3pvbmUgcmVwb3J0IC1jIDEgLW8gMHgyNzRBMDAwMDAgL2Rldi9zZGMN
Cj4+IHN0YXJ0OiAweDI3NGEwMDAwMCwgbGVuIDB4MDgwMDAwLCBjYXAgMHgwODAwMDAsIHdw
dHIgMHgwMDAwMDAgcmVzZXQ6MA0KPj4gbm9uLXNlcTowLCB6Y29uZDogMShlbSkgW3R5cGU6
IDIoU0VRX1dSSVRFX1JFUVVJUkVEKV0NCj4gYmxrem9uZSB0YWtlcyBhIHBoeXNpY2FsIG9m
ZnNldCBpbiBzZWN0b3IgdW5pdCAoNTEyIGJ5dGVzKS4gQWNjb3JkaW5nIHRvDQo+IHRoZSBk
dW1wLXRyZWUgb3V0cHV0IGJlbG93LCB0aGUgQkcgNTM5OTg0NzYzMjg5NiBpcyBhdCAiMTgx
OTQ1NTUyMDc2OCIgb24NCj4gL2Rldi9zZGIgYW5kICIxODE5NzIzOTU2MjI0Ii4gU28sICJi
bGt6b25lIHJlcG9ydCAtbyIgc2hvdWxkIHRha2UNCj4gIjB4ZDNkMDAwMDAiIGFuZCAiMHhk
M2Q4MDAwMCIuDQojIGJsa3pvbmUgcmVwb3J0IC1vIDB4ZDNkMDAwMDAgLWMgMSAvZGV2L3Nk
YQ0KDQogwqAgc3RhcnQ6IDB4MGQzZDAwMDAwLCBsZW4gMHgwODAwMDAsIGNhcCAweDA4MDAw
MCwgd3B0ciAweDA0ZjBlMCByZXNldDowIA0Kbm9uLXNlcTowLCB6Y29uZDogNChjbCkgW3R5
cGU6IDIoU0VRX1dSSVRFX1JFUVVJUkVEKV0NCg0KIyBibGt6b25lIHJlcG9ydCAtbyAweGQz
ZDgwMDAwIC1jIDEgL2Rldi9zZGENCiDCoCBzdGFydDogMHgwZDNkODAwMDAsIGxlbiAweDA4
MDAwMCwgY2FwIDB4MDgwMDAwLCB3cHRyIDB4MDgwMDAwIHJlc2V0OjAgDQpub24tc2VxOjAs
IHpjb25kOjE0KGZ1KSBbdHlwZTogMihTRVFfV1JJVEVfUkVRVUlSRUQpXQ0KDQpGWUk6IG15
IGxvb25nc29uIGRldmljZSBpcyBpbiBSTUEuIFNvIEkgYW0gdXNpbmcgRDIwMDAgKGFybTY0
IHcvIDRrIA0KcGFnZXMpIGZvciByZWFkaW5nLiBjYW4ndCB0cnkgYW55IG1vdW50IGZvciBu
b3cgYnV0IGNhbiBkbyBpbnNwZWN0LWludGVybmFsLg0KDQo+IFRoYW5rcywNCj4NCj4+IEZZ
SSwNCj4+ICMgYnRyZnMgaW5zcGVjdC1pbnRlcm5hbCBkdW1wLXRyZWUgL2Rldi9zZGJ8Z3Jl
cCAtQSAxMCAtQiAxMCA1Mzk5ODQ3NjMyODk2DQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlvX2FsaWduIDY1NTM2IGlvX3dpZHRoIDY1NTM2IHNlY3Rvcl9zaXplIDE2
Mzg0DQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9zdHJpcGVzIDEg
c3ViX3N0cmlwZXMgMQ0KPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RyaXBlIDAgZGV2aWQgMSBvZmZzZXQgMTgxOTE4NzA4NTMxMg0KPj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3V1
aWQgNzU0ZjI5MzItMzhlNS00NmI0LTkzZDItZGQ2OTkwNzY4NzllDQo+PiAgwqDCoMKgwqDC
oMKgwqAgaXRlbSAxMDQga2V5IChGSVJTVF9DSFVOS19UUkVFIENIVU5LX0lURU0gNTM5OTU3
OTE5NzQ0MCkgaXRlbW9mZg0KPj4gNzg1MSBpdGVtc2l6ZSA4MA0KPj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBsZW5ndGggMjY4NDM1NDU2IG93bmVyIDIgc3RyaXBlX2xl
biA2NTUzNiB0eXBlIERBVEF8c2luZ2xlDQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlvX2FsaWduIDY1NTM2IGlvX3dpZHRoIDY1NTM2IHNlY3Rvcl9zaXplIDE2Mzg0
DQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9zdHJpcGVzIDEgc3Vi
X3N0cmlwZXMgMQ0KPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RyaXBlIDAgZGV2aWQgMiBvZmZzZXQgMTgxOTQ1NTUyMDc2OA0KPj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3V1aWQg
ZWU2NjliODUtZjY0MS00ZDZhLTlhNjYtZGExMzkwN2Q1NWIyDQo+PiAgwqDCoMKgwqDCoMKg
wqAgaXRlbSAxMDUga2V5IChGSVJTVF9DSFVOS19UUkVFIENIVU5LX0lURU0gNTM5OTg0NzYz
Mjg5NikgaXRlbW9mZg0KPj4gNzczOSBpdGVtc2l6ZSAxMTINCj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbGVuZ3RoIDI2ODQzNTQ1NiBvd25lciAyIHN0cmlwZV9sZW4g
NjU1MzYgdHlwZQ0KPj4gTUVUQURBVEF8UkFJRDENCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW9fYWxpZ24gNjU1MzYgaW9fd2lkdGggNjU1MzYgc2VjdG9yX3NpemUg
MTYzODQNCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3N0cmlwZXMg
MiBzdWJfc3RyaXBlcyAxDQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJpcGUgMCBkZXZpZCAxIG9mZnNldCAxODE5NDU1NTIwNzY4DQo+
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZf
dXVpZCA3NTRmMjkzMi0zOGU1LTQ2YjQtOTNkMi1kZDY5OTA3Njg3OWUNCj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cmlwZSAxIGRldmlk
IDIgb2Zmc2V0IDE4MTk3MjM5NTYyMjQNCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl91dWlkIGVlNjY5Yjg1LWY2NDEtNGQ2YS05YTY2
LWRhMTM5MDdkNTViMg0KPj4gIMKgwqDCoMKgwqDCoMKgIGl0ZW0gMTA2IGtleSAoRklSU1Rf
Q0hVTktfVFJFRSBDSFVOS19JVEVNIDU0MDAxMTYwNjgzNTIpIGl0ZW1vZmYNCj4+IDc2NTkg
aXRlbXNpemUgODANCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGVuZ3Ro
IDI2ODQzNTQ1NiBvd25lciAyIHN0cmlwZV9sZW4gNjU1MzYgdHlwZSBEQVRBfHNpbmdsZQ0K
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb19hbGlnbiA2NTUzNiBpb193
aWR0aCA2NTUzNiBzZWN0b3Jfc2l6ZSAxNjM4NA0KPj4NCj4+PiBhbmQgZm9yIHRoZSBvdGhl
ciBkZXZpY2UgYXMgd2VsbA0KPj4+DQo+Pj4gVGhhbmtzLA0KPj4+IAlKb2hhbm5lcw0KPg0K


--------------Fl9xp4t3gWEx3I0WM8u1E1r8--

--------------3aQIwWxUq4cAvfFdCIXS84IH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZmfzQQAKCRBLkKfpYfpB
U233AQCLnfG7iv7E7bDPYvRlwKGhh+Lw6J432I/XIR1OJYi45AEAsLee3naOm/xS
TEAX5jCrvRSOEkpk6JVA2Nd4jMtORAA=
=dqfC
-----END PGP SIGNATURE-----

--------------3aQIwWxUq4cAvfFdCIXS84IH--


