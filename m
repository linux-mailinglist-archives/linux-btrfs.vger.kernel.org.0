Return-Path: <linux-btrfs+bounces-16885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A30B7C7F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532AF1C00B42
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 08:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E216309DB1;
	Wed, 17 Sep 2025 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="b1O3Jq/c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095563093AD
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097731; cv=none; b=uUCme26hPNSxDMwY0uI8wKHu32tyxjPHNn6ycUogSmmmSpJQQka8T2TVaAxfGYOGe2gvTh7Sb9XI5PodFm1NGU5etkV2GHvna9jHK486V4uQuTSUNM3R7YaeBiIoPnw9uLIb/eF/6r4kr0Q9aJeTnQNMMYrcx/8eP3nbgVLnvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097731; c=relaxed/simple;
	bh=LBryPsoAHIvhcrQtsVoMLKcHob40wgFHiCTAVGVLpVc=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=n9P5BfwsTRwvkAgKMzf8+Q0LXb9WfECA3vQEGcOhFylrtkAPkYSkBfgJ4/ytNq+ZPD64SLEnoFV2NotpkqxgGjCljCLyWISt+7lI2ZgRY8IS0/jyOzE0MKcqHUzlw4V9vi/wJJqYwuo5wBYQAXbzi841QocNxuXAcl0bLriNs50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=b1O3Jq/c; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1758097712;
	bh=LBryPsoAHIvhcrQtsVoMLKcHob40wgFHiCTAVGVLpVc=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=b1O3Jq/caRhWNpEmnxCnygz8m+hh8hVXGNbwTBCuGeXXNlb8x2Z9WKXk16x/lLkx7
	 7t2phLhkCP6RVjE1eDBiUXo6thcb3FyG+kOz7zKy8v8+Yjbmj7PK/0tEC3FqeYFfOL
	 3I+UjAEANvgY7/vbDifGbcjKxhyl1lhIslZjyyMQ=
EX-QQ-RecipientCnt: 5
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqTSsxwgbpkr0M8gCX1hkE+9JM3kgOdjz2A=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: hIApsADu/rnK+avX+yH/4xAiWe0pB4HqO/1GxjSB+8M=
X-QQ-STYLE: 
X-QQ-mid: lv2gz5a-1t1758097710tdc3889f7
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
Date: Wed, 17 Sep 2025 16:28:30 +0800
X-Priority: 3
Message-ID: <tencent_29ACBA272F8BC2BE2BCCB091@qq.com>
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
	<tencent_6AE63A4E1F1CC94E1625B595@qq.com>
	<b86ab184-7028-4d58-8acf-1f995348a6f6@wdc.com>
In-Reply-To: <b86ab184-7028-4d58-8acf-1f995348a6f6@wdc.com>
X-QQ-ReplyHash: 45238568
X-BIZMAIL-ID: 15054322753913127284
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 17 Sep 2025 16:28:31 +0800 (CST)
Feedback-ID: lv:bupt.moe:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MWLCkAjnYYm5ijnfWeKu7uIgvPj+rc4S+s/228pPqZ8oUi0LLvn2m7p3
	AEDS/lHAdwjVJbC/iEhV4GH2UYCil8PpKrQqVWaILehc69hW23ixiEAt5MJX5aDF/Ro2tSB
	+nh4LCpaPxfsvlpGswNY9/tvwHqlIuiLu2NWnBGuNT1aoNJxAtwMYvSNq3qOsNIOur7KakT
	VUX7+kuVT9+xUVbCwY2iRv0dINtFuCa47q1FZKYDfKluW4mxnDEfAo7Os4077YfTvbXELLp
	qLcfThYDBmg81iYhrKygpY8OvwVHuMzXlFg3dDTcDMHUXqnKEB8JDwjwBZEUzl6GuOf/Abu
	ylN7LfF6c4tyChCVaUzPOLj1HH1Ks1EbjqrkFlFfArqMXS5aXSLMziFBPJbbg3ZtjXRZCvJ
	bv9ZsVH9GFWeGvWSbyGVuSYSks+aHa/amMbEexoXdcOLiDK+ziNVdRKbZXgX/SuG/qUD+NG
	E9saFGOyrEYvJZ3AhLRtyeFh+weGvgXiiEXnK5saSgdhSQ2mxfuBUeay2jXXZLxEgqF7rx4
	0nwtE1FGJC5bDsBUNcgFd8gPypraKzda8vrB1HggH/xHWjYNLt07N14drYPnuxpyvklXhHZ
	hJrv7fQmmUeuQ9HNYlaxtEejb4IIhopYQ/hIrGc78pnCg+26+Zbo5XUn0orB7ZQ9gscGGnt
	Oywnts4whUnfkyBh4QaWG2NwCmcW0NrvkkUe8/33GDjEs8a3B3wupdAJtLV25oqgIqmLneG
	Ka2eOM76tXFzSPCSQiBENdtLsJ5TLEzAoWiiofPHV8GE/qplJMQyhqvS5jeo6LB7OEDP0iK
	+NR4RGJORefY1CdGUoQx1bYgR3CxBd+uPPPGwIwc9cDZFSFI45YEQsPynJ20Be4sRw3KrJQ
	hDGpMkq5nSOd6co+FWGAevqM7g8XjWVMzXJ3LdgJkvgOtJ509vi8KymAZgvhpQHLNeoDIRr
	SJJ0cYv0lmeL2oAYkCVwjw/0Bnk7qgm9Rkjuf1ZXLTEpb4j9Oy1bMpjEdUnVa1LfdLl8=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Pk9uIDkvMTcvMjUgNjoyMCBBTSwgSEFOIFl1d2VpIHdyb3RlOg0KPj4+IENhbiB5b3UgdHJ5
IGF0dGFjaGVkICh1bnRlc3RlZCkgcGF0Y2g/DQo+PiBbICAgMTguOTM1NjQwXSBCVFJGUyBl
cnJvciAoZGV2aWNlIHNkYyk6IHpvbmVkOiAzOTAyMCBhY3RpdmUgem9uZXMgb24gL2Rldi9z
ZGMgZXhjZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KPj4gWyAgIDE4LjkzNzMzNV0gQlRS
RlMgZXJyb3IgKGRldmljZSBzZGMpOiB6b25lZDogZmFpbGVkIHRvIHJlYWQgZGV2aWNlIHpv
bmUgaW5mbzogLTUNCj4+IFsgICAxOC45NTcwNDJdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2Rj
KTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+PiBbICAgMTkuMDM3OTAyXSBCVFJGUyBlcnJv
ciAoZGV2aWNlIHNkZCk6IHpvbmVkOiAzMTQxOSBhY3RpdmUgem9uZXMgb24gL2Rldi9zZGQg
ZXhjZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KPj4gWyAgIDE5LjA0MDY1MF0gQlRSRlMg
ZXJyb3IgKGRldmljZSBzZGQpOiB6b25lZDogZmFpbGVkIHRvIHJlYWQgZGV2aWNlIHpvbmUg
aW5mbzogLTUNCj4+IFsgICAxOS4wNjAzNDldIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RkKTog
b3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+PiBTZWVtcyBzdGlsbCByZWplY3RpbmcgbW91bnQg
ZXhpc3Rpbmcgdm9sdW1lLg0KPiANCj4gT2sgbmV4dCB0cnkgYXR0YWNoZWQuDQoNCnN0aWxs
IHVuYWJsZSB0byBtb3VudC4gIEkgYWRkZWQgYSBkbWVzZyBsaW5lIHRvIG91dHB1dCB0aGVz
ZSB2YXJpYWJsZXMuDQoNClsgIDMwOC4zNTEyNzJdIEJ0cmZzIGxvYWRlZCwgZXhwZXJpbWVu
dGFsPW9uLCBkZWJ1Zz1vbiwgYXNzZXJ0PW9uLCB6b25lZD15ZXMsIGZzdmVyaXR5PXllcw0K
WyAgMzEyLjM3OTQ3OF0gQlRSRlM6IGRldmljZSBsYWJlbCBEQVRBNCBkZXZpZCAxIHRyYW5z
aWQgNzgzMCAvZGV2L3NkYyAoODozMikgc2Nhbm5lZCBieSBtb3VudCAoMzE2MykNClsgIDMx
Mi4zODMwOThdIEJUUkZTIGluZm8gKGRldmljZSBzZGMpOiBmaXJzdCBtb3VudCBvZiBmaWxl
c3lzdGVtIDI2NjJjNWEzLWVhYzAtNDc3YS1hODJhLWIyOThhMTZkYWUwMg0KWyAgMzEyLjM4
MzEyMl0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYyk6IHVzaW5nIGNyYzMyYyAoY3JjMzJjLWxp
YikgY2hlY2tzdW0gYWxnb3JpdGhtDQpbICAzMTMuMzI3Njk4XSBCVFJGUyBlcnJvciAoZGV2
aWNlIHNkYyk6IHpvbmVkOiAzOTAyMCBhY3RpdmUgem9uZXMgb24gL2Rldi9zZGMgZXhjZWVk
cyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KWyAgMzEzLjMyNzc0NV0gQlRSRlMgZXJyb3IgKGRl
dmljZSBzZGMpOiB6b25lZDogYmRldl9tYXhfYWN0aXZlX3pvbmVzOiAwIGJkZXZfbWF4X29w
ZW5fem9uZXMgOjEyOA0KWyAgMzEzLjMyNzkzMV0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGMp
OiB6b25lZDogZmFpbGVkIHRvIHJlYWQgZGV2aWNlIHpvbmUgaW5mbzogLTUNClsgIDMxMy4z
NDQ1MTVdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RjKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01
DQpbICAzMTMuMzU1NjkwXSBCVFJGUzogZGV2aWNlIGxhYmVsIERBVEEyIGRldmlkIDEgdHJh
bnNpZCAxMjA2NyAvZGV2L3NkZCAoODo0OCkgc2Nhbm5lZCBieSBtb3VudCAoMzE2MykNClsg
IDMxMy4zNTg4MjhdIEJUUkZTIGluZm8gKGRldmljZSBzZGQpOiBmaXJzdCBtb3VudCBvZiBm
aWxlc3lzdGVtIDZhNzVmMzRiLTFiMmUtNDBmNS04N2VmLWQ4M2Q5ODAxNDhiOA0KWyAgMzEz
LjM1ODg0NF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkZCk6IHVzaW5nIGNyYzMyYyAoY3JjMzJj
LWxpYikgY2hlY2tzdW0gYWxnb3JpdGhtDQpbICAzMTQuMTc1MDM3XSBCVFJGUyBlcnJvciAo
ZGV2aWNlIHNkZCk6IHpvbmVkOiAzMTQxOSBhY3RpdmUgem9uZXMgb24gL2Rldi9zZGQgZXhj
ZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KWyAgMzE0LjE3NTEwNl0gQlRSRlMgZXJyb3Ig
KGRldmljZSBzZGQpOiB6b25lZDogYmRldl9tYXhfYWN0aXZlX3pvbmVzOiAwIGJkZXZfbWF4
X29wZW5fem9uZXMgOjEyOA0KWyAgMzE0LjE3NTMyNl0gQlRSRlMgZXJyb3IgKGRldmljZSBz
ZGQpOiB6b25lZDogZmFpbGVkIHRvIHJlYWQgZGV2aWNlIHpvbmUgaW5mbzogLTUNClsgIDMx
NC4yMDAzMzJdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RkKTogb3Blbl9jdHJlZSBmYWlsZWQ6
IC01


