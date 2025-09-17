Return-Path: <linux-btrfs+bounces-16873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C4FB7E114
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06294581859
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2E223AE62;
	Wed, 17 Sep 2025 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="uanGyMaB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB08249F9
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 04:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082829; cv=none; b=Lvh9WIwzLTgVmZjPF4/AcR4buyCJF82fSJQHMPTo+9oyj1UwAEiNVlinQ2/ebTjGuGIzDpLMfG+xnlvNAlwvNZB7F2Fn6EyvqRFmyjlT9q2uDLtlhYg6hI0azcUOBCPfdhD4o2sNEcVXOEFk14/BzoXESZz1yzfs1h8p/T5CJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082829; c=relaxed/simple;
	bh=l0SUqfjCuAjos/QHXSpWXwqKDbeSUewJsw63b8l/7IY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=A7s514UJrQyGS6dmDDNtTK4asJ9K4uLbIBQmi+G6jBzAQmpXcA/OfZYiY4GaXxf1cHav1/MoHEFEN80XZm/r4mhg8FA9WdVWSqSUlEx2YR9jTlDOBS37hmDrInlje5/PtO1eaVFMbu/pGoJNgQstNGHw7sg4rq+bA2PzouZgp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=uanGyMaB; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1758082801;
	bh=l0SUqfjCuAjos/QHXSpWXwqKDbeSUewJsw63b8l/7IY=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=uanGyMaBVRBIpt+ktKyhPUBNLDlWhmklsro+9C9vTebkUfsRuNHl07yNFXJh/TJQE
	 QUfWun2304hXtrAfJYjP+hIcNl/bX0uPvEUJDG/x8z5jBzNnbnW5nGm4YHZ5zzhe6v
	 FCiA/QnuOd9nQNC4183tarS/bA6bwiwJ0yYpWl80=
EX-QQ-RecipientCnt: 5
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqTSsxwgbpkr0M8gCX1hkE+9JM3kgOdjz2A=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 1hCHy5pY9w0DEmhkyoCKiFRPGW1WqxsikkIi6Ftls6c=
X-QQ-STYLE: 
X-QQ-mid: lv2gz5a-1t1758082799tca3aeb49
From: "=?utf-8?B?SEFOIFl1d2Vp?=" <hrx@bupt.moe>
To: "=?utf-8?B?Sm9oYW5uZXMgVGh1bXNoaXJu?=" <Johannes.Thumshirn@wdc.com>
Cc: "=?utf-8?B?UXUgV2VucnVv?=" <quwenruo.btrfs@gmx.com>, "=?utf-8?B?bGludXgtYnRyZnM=?=" <linux-btrfs@vger.kernel.org>, "=?utf-8?B?RGFtaWVuIExlIE1vYWw=?=" <dlemoal@kernel.org>, "=?utf-8?B?TmFvaGlyb0FvdGE=?=" <Naohiro.Aota@wdc.com>
Subject: Re: performance issue when using zoned.
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 17 Sep 2025 12:19:58 +0800
X-Priority: 3
Message-ID: <tencent_6AE63A4E1F1CC94E1625B595@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_694B88D85481319043E0CE14@qq.com>
	<873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
	<BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
	<c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
	<2F48A90AF7DDF380+1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
	<1c5e2ef7-f2e5-401d-8acd-0605b117dfcb@wdc.com>
	<43f21464-c084-42e0-bb5a-0572e3385b02@wdc.com>
In-Reply-To: <43f21464-c084-42e0-bb5a-0572e3385b02@wdc.com>
X-QQ-ReplyHash: 3904542442
X-BIZMAIL-ID: 3133821396095370377
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 17 Sep 2025 12:20:00 +0800 (CST)
Feedback-ID: lv:bupt.moe:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NpzNf8JHXbEITAkXGvcIJ9ZxzOHeFhCI0JPkRpbspg4e25J8/TuNrYd7
	+ojsLBYQRnTK5Tt5ewAjYqM2+nS7onCJfgSnmsguzDgE3XiIrq6VZoHQSlVsBsvunJWluoR
	DZSJ4qqEqmKgXsLV+c1Qxz9naVts9pDNJz9nhrNRcKGTFqJ86kUQ8rGmUBkpGe/tIkd5DmF
	aSUHjRtuAkV/mjl6Uj1JbIeqN/6LK1ZB5z5VDyij2tEviJTfnSz9Re1oNFHG1N11sAgKEyi
	jezb1k7vdcdt/MvOrd6n54gYsX0kyIdWISMC1jlPDhEhXQ+z1vU6MCFljmCqLUyLjTLYosn
	OJVnwhryRlYv+F1rQKrCN+IUpFjeU96xTKE+vuzj24QZvMbVS6gNNnWCqm1JooACQdyoRhK
	7DjhiAyUkLvRv4lbGs4J3kVNe9uYWCcPYKkUZPcBG4omC2Doh8dFw/yBAfNOe57g39GHoEz
	tq8NinapA1IlIGB3I/lZjl3qrcDCciw7ulNQpwaeWPPgQJMILcs1yHIcqRXWxDxyxBu7JaP
	rKVEBCvN77DgHDcKNEdfeAiQY5/RSjEyTsN//NCxrxSP6E6qAr4CYTy3i7ji79DTCKaJHIK
	rFuYp2fPM+8JL0sbr8DNidenVIrqDOIEB9SQVou0Izg2yQ6Z13QMxPkbdVumxKQ7EbkmY9I
	RIiFopBL0OUrdMTObxQ/VVyjEhTeFtJ51YzRYtHxc/nlmYqi8sLaTFxM7GbCwIGl/alxCF/
	gzQtIjcwwrteqehmDgcU7D5b/qtFMGpyXEwDVfZXwV5ijeDDOFAwvWjbB0CngwHiH5jZ5P+
	7PlBGpDW8eWG2JjlCdcdrMylkj8vDlip6ehE1tlgHsJk68iLMGOEavUg2MpJfvPtLxa8AmY
	AYJ+eNwcZt2lUlF2n44DJXcAOCR4AntN186poua9Aj5bMEG+xWo6Ni0aTCcb1rPMAc4PE76
	vdA0x9DV7xnwmXMa1VF9qW4SDflwAhSA3VO4vzj6904fhcB+b9d/hC9AlObXuqhIrakk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Pk9uIDkvMTYvMjUgODowNSBQTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24g
OS8xNi8yNSA3OjU5IFBNLCBZdXdlaSBIYW4gd3JvdGU6DQo+Pj4+IFRoaXMgaW4gb3VyIHRl
c3RpbmcgaGFzIGJvb3N0ZWQgcGVyZm9ybWFuY2UgcXVpdGUgYSBiaXQuDQo+Pj4gc2FkbHkg
dGhpcyBsaW1pdCBjYXVzZWQga2VybmVsIHRvIHJlamVjdCBteSBtb3VudC4gQW55IGZpeCBh
dmFpbGFibGU/DQo+Pj4gWyAgIDE4LjE4NTA2MV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGQp
OiB6b25lZDogMzE0MTkgYWN0aXZlIHpvbmVzIG9uDQo+Pj4gL2Rldi9zZGQgZXhjZWVkcyBt
YXhfYWN0aXZlX3pvbmVzIDEyOA0KPj4+IFsgICAxOC4xODU4NDhdIEJUUkZTIGVycm9yIChk
ZXZpY2Ugc2RkKTogem9uZWQ6IGZhaWxlZCB0byByZWFkIGRldmljZQ0KPj4+IHpvbmUgaW5m
bzogLTUNCj4+PiBbICAgMTguMjE3NDA1XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IG9w
ZW5fY3RyZWUgZmFpbGVkOiAtNQ0KPj4+IFsgICAxOC40NDkzNjJdIEJUUkZTIGVycm9yIChk
ZXZpY2Ugc2RjKTogem9uZWQ6IDM5MDIwIGFjdGl2ZSB6b25lcyBvbg0KPj4+IC9kZXYvc2Rj
IGV4Y2VlZHMgbWF4X2FjdGl2ZV96b25lcyAxMjgNCj4+PiBbICAgMTguNDUwMDgzXSBCVFJG
UyBlcnJvciAoZGV2aWNlIHNkYyk6IHpvbmVkOiBmYWlsZWQgdG8gcmVhZCBkZXZpY2UNCj4+
PiB6b25lIGluZm86IC01DQo+Pj4gWyAgIDE4LjQ2NjQwNV0gQlRSRlMgZXJyb3IgKGRldmlj
ZSBzZGMpOiBvcGVuX2N0cmVlIGZhaWxlZDogLTUNCj4+IE5vLCBJJ20gd29ya2luZyBvbiBp
dCENCj4+DQo+IENhbiB5b3UgdHJ5IGF0dGFjaGVkICh1bnRlc3RlZCkgcGF0Y2g/DQpbICAg
MTguOTM1NjQwXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYyk6IHpvbmVkOiAzOTAyMCBhY3Rp
dmUgem9uZXMgb24gL2Rldi9zZGMgZXhjZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KWyAg
IDE4LjkzNzMzNV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGMpOiB6b25lZDogZmFpbGVkIHRv
IHJlYWQgZGV2aWNlIHpvbmUgaW5mbzogLTUNClsgICAxOC45NTcwNDJdIEJUUkZTIGVycm9y
IChkZXZpY2Ugc2RjKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQpbICAgMTkuMDM3OTAyXSBC
VFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IHpvbmVkOiAzMTQxOSBhY3RpdmUgem9uZXMgb24g
L2Rldi9zZGQgZXhjZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KWyAgIDE5LjA0MDY1MF0g
QlRSRlMgZXJyb3IgKGRldmljZSBzZGQpOiB6b25lZDogZmFpbGVkIHRvIHJlYWQgZGV2aWNl
IHpvbmUgaW5mbzogLTUNClsgICAxOS4wNjAzNDldIEJUUkZTIGVycm9yIChkZXZpY2Ugc2Rk
KTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQpTZWVtcyBzdGlsbCByZWplY3RpbmcgbW91bnQg
ZXhpc3Rpbmcgdm9sdW1lLg==


