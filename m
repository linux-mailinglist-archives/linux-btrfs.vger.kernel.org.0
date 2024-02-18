Return-Path: <linux-btrfs+bounces-2478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383A28599A7
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Feb 2024 23:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF411C20A18
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Feb 2024 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C28745C6;
	Sun, 18 Feb 2024 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uvic.ca header.i=@uvic.ca header.b="R4j/L3AA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from isopod.comp.uvic.ca (isopod.comp.uvic.ca [142.104.177.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956A1E86E
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Feb 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.104.177.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708293637; cv=none; b=RVVz5GLHvskC4rS66sY7LI1sEPghVMmmUVCPaH+mmy0o+cT3iXY9JrW50spNI3zNd7i+a5kAWudCDMuJALdeMAVo5nBvwxOOChv2b9S32FTm4LdTWXEzguZrgM1qds1aSL6zw/ulpBjZRczBKzCHnEcO7jh1Nee5jnxUPemGTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708293637; c=relaxed/simple;
	bh=0Mr0lJkxTWo0V42Vz5ZSw9bjsDCoLmqRG8J/Uu9gdAE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gomDSQJQEvtWIqQBvRVIBX1HjpmRSdV5sFc5aEK3wUyHgr53eNjcFFnYv2Zn3KePM68ZxJ8apArMf3f/Ygrk5bNi1NGEN+TiSoOkNCMIHF5vK4Ptbd85Ay+QxtNTrr/moAa6w0Eq2u7223ip71qo2lusoFZf4eS2hjRB4wLICPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uvic.ca; spf=pass smtp.mailfrom=uvic.ca; dkim=pass (1024-bit key) header.d=uvic.ca header.i=@uvic.ca header.b=R4j/L3AA; arc=none smtp.client-ip=142.104.177.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uvic.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uvic.ca
Received: from valais.uvic.ca (valais.uvic.ca [142.104.225.15])
	by isopod.comp.uvic.ca (8.14.4/8.14.4) with ESMTP id 41IM0YTm018190
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Feb 2024 14:00:35 -0800
Received: from angora.uvic.ca (142.104.224.13) by valais.uvic.ca
 (142.104.225.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 14:00:02 -0800
Received: from angora.uvic.ca ([fe80::68b1:e757:9b99:5910]) by angora.uvic.ca
 ([fe80::68b1:e757:9b99:5910%3]) with mapi id 15.01.2507.035; Sun, 18 Feb 2024
 14:00:22 -0800
From: Ryan Taylor <rptaylor@uvic.ca>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: unresolved ref dir errors (no dir item, no inode ref, no dir index)
 with blob storage
Thread-Topic: unresolved ref dir errors (no dir item, no inode ref, no dir
 index) with blob storage
Thread-Index: AQHaYrXeHvmvO9gTx0W9av6VlBfaww==
Date: Sun, 18 Feb 2024 22:00:22 +0000
Message-ID: <dc96dfb53835c6c5ff3614c3fade276eaa1092e2.camel@uvic.ca>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
x-tm-as-product-ver: SMEX-14.0.0.3152-9.1.1006-28200.001
x-tm-as-result: No-10--13.274700-5.000000
x-tmase-matchedrid: TxbrEr7oi5yvxJaYc6X9S6zSsZt54aj7oBe8oeqCz7Pgm7lSO4VWy3uL
	dMlaRil5g4Xtz31CEYMVYUBO1fgbB5GZilTi8ctSIVybEvvop46ZmLDnd2pI3+fdksK3etFJJEb
	gebEoSmW52iSWYVSDCKUWLdaCfonFTUKe5cExMcvece0aRiX9Wk0s9CXRACW0/kWkeuI3AgUteS
	BVDS/hEwDddf3t8m3wPk+OpnRLoHEz5pZcUDYjcPi9hrAKwILaBGvINcfHqhfgmDZo451ggody9
	x5D78Kl4K9FmervsqVV6m6JPINuuoYCBZzro74fxVQFfLw4zf82ZWOmuJUS2Za5+gecZQ1+4rl+
	FHG3VoBbdScq6YVMbtGXbHm+gYIXYh5uOPXd4paeAiCmPx4NwJwhktVkBBrQovSVS26nOBcqtq5
	d3cxkNW+OOV+GMO7MmAFJj76Sqs18MzG/mpqRVvXhP+MZOav93mFeuwYwb94=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--13.274700-5.000000
x-tmase-version: SMEX-14.0.0.3152-9.1.1006-28200.001
x-tm-snts-smtp: 12A1554941C7F8E17D865E6BEA0ED3C5262B57A30A32D00046DCFBC54342C4EA2000:9
Content-Type: text/plain; charset="utf-8"
Content-ID: <49C1448214F7FB42B083E83932E0D60E@local.uvic.ca>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UVic-Virus-Scanned: OK - Passed virus scan by ClamAV (clamd) on isopod
X-UVic-Scan: isopod.comp.uvic.ca filter_version 3.7.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=uvic.ca; h=from:to:subject:date:message-id:content-type:content-id:content-transfer-encoding:mime-version; s=default; bh=0Mr0lJkxTWo0V42Vz5ZSw9bjsDCoLmqRG8J/Uu9gdAE=; b=R4j/L3AAewkkakWUCXS46iSS7wcjk+c8T0ypaxYA0OPvb/bczDedeb+BKFhicVi8XUJBf1wSbAuyMeMtdkPOIr5XT9gKM89SzabIU7Stje0oKYEUQ/ISEzgSBPWf2cPDnNGyA1SSI1slOJUjdMLXsBwP5PChfu0LCusqWcXLDAE=
X-Scanned-By: MIMEDefang 2.78

SGVsbG8sDQoNCkkgaGF2ZSBhIHZlcnkgc2ltaWxhciBwcm9ibGVtIGFzIGRlc2NyaWJlZCBpbiBo
dHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1idHJmcy9tc2cxMzkxNzYuaHRtbA0K
DQpJbiBteSBjYXNlIHRoZSBjb3JydXB0ZWQgZmlsZXMgYXJlOg0KDQokIGxzIC1sIH4vLmNvbmZp
Zy9nb29nbGUtY2hyb21lL0RlZmF1bHQvYmxvYl9zdG9yYWdlLw0KbHM6IGNhbm5vdCBhY2Nlc3Mg
Jy9ob21lL3VzZXIvLmNvbmZpZy9nb29nbGUtY2hyb21lL0RlZmF1bHQvYmxvYl9zdG9yYWdlL2Yy
NWJlNjNkLTBmODgtNDU0MS05OTI4LTNmMTg2ZmI1MmViNyc6IE5vIHN1Y2ggZmlsZSBvciBkaXJl
Y3RvcnkNCnRvdGFsIDANCmRyd3gtLS0tLS0uIDEgdXNlciB1c2VyIDAgRGVjIDE0IDE4OjQxIDkx
MjQwN2Q2LTMyMDMtNGNkYS05YzQ4LWNhYzYyMmViNDZkZQ0KZD8/Pz8/Pz8/Pz8gPyA/ICAgICAg
ICA/ICAgICAgICA/ICAgICAgICAgICAgPyBmMjViZTYzZC0wZjg4LTQ1NDEtOTkyOC0zZjE4NmZi
NTJlYjcNCg0KSG93ZXZlciBpbiBib3RoIGNhc2VzLCB0aGUgYWZmZWN0ZWQgZmlsZXMgYXJlIG9m
IHRoZSBzYW1lIGJsb2Jfc3RvcmFnZS88aGFzaD4gZm9ybWF0LCBzbyBtYXliZSB0aGVyZSBpcyBz
b21lIGJsb2Igc3RvcmFnZSBsaWJyYXJ5IHVzZWQgYnkNCmJvdGggR29vZ2xlIENocm9tZSBhbmQg
VmlzdWFsIFN0dWRpbywgd2hpY2ggZG9lcyBzb21lIHBhcnRpY3VsYXIgZmlsZSBvcGVyYXRpb25z
IHRoYXQgdHJpZ2dlciBhIGJ0cmZzIGJ1Zy4NCg0KVGhlIHN5c3RlbSB3YXMgaW5zdGFsbGVkIHVz
aW5nIEZlZG9yYSAzNyBpbiBOb3YgMjAyMiwgdXNpbmcga2VybmVsLWNvcmUtNi4wLjctMzAxLmZj
MzcueDg2XzY0IGF0IHRoYXQgdGltZS4NCg0KTW9yZSBkZXRhaWxzIGFyZSBzaG93biBiZWxvdy4g
SSB0aGluayB0aGVzZSBkaXJlY3RvcmllcyBhcmUgbGlrZWx5IG5vdCBpbXBvcnRhbnQgYnV0IEkg
Y2FuJ3QgZmluZCBhIHdheSB0byBkZWxldGUgdGhlbS4NCkFsc28gYnRyZnMgcmVwYWlyIHNlZW1z
IHRvIGJlIHdpZGVseSBjb25zaWRlcmVkIGRhbmdlcm91cy4gSG93IGNhbiBJIHJlc29sdmUgdGhl
c2UgZXJyb3JzPw0KDQoNCiQgc3VkbyBidHJmcyBjaGVjayAtLWZvcmNlIC1wIC0tcmVhZG9ubHkg
IC9kZXYvZGlzay9ieS1sYWJlbC9mZWRvcmENCk9wZW5pbmcgZmlsZXN5c3RlbSB0byBjaGVjay4u
Lg0KV0FSTklORzogZmlsZXN5c3RlbSBtb3VudGVkLCBjb250aW51aW5nIGJlY2F1c2Ugb2YgLS1m
b3JjZQ0KQ2hlY2tpbmcgZmlsZXN5c3RlbSBvbiAvZGV2L2Rpc2svYnktbGFiZWwvZmVkb3JhDQpV
VUlEOiA4ZTU5MzBjOC1kNjZjLTQzNjQtOWU5Mi1hNTdhNGVmODQxMTENClsxLzddIGNoZWNraW5n
IHJvb3QgaXRlbXMgICAgICAgICAgICAgICAgICAgICAgKDA6MDA6MDEgZWxhcHNlZCwgODM4Mzk5
IGl0ZW1zIGNoZWNrZWQpDQpbMi83XSBjaGVja2luZyBleHRlbnRzICAgICAgICAgICAgICAgICAg
ICAgICAgICgwOjAwOjA0IGVsYXBzZWQsIDYyMTYwIGl0ZW1zIGNoZWNrZWQpDQpbMy83XSBjaGVj
a2luZyBmcmVlIHNwYWNlIHRyZWUgICAgICAgICAgICAgICAgICgwOjAwOjAwIGVsYXBzZWQsIDI0
MSBpdGVtcyBjaGVja2VkKQ0Kcm9vdCAyNTcgaW5vZGUgMzk5Mzg3NSBlcnJvcnMgMSwgbm8gaW5v
ZGUgaXRlbSAoMDowMDowMSBlbGFwc2VkLCAyMzg2NCBpdGVtcyBjaGVja2VkKQ0KCXVucmVzb2x2
ZWQgcmVmIGRpciA1MDk5MSBpbmRleCAyNzUgbmFtZWxlbiAzNiBuYW1lIGYyNWJlNjNkLTBmODgt
NDU0MS05OTI4LTNmMTg2ZmI1MmViNyBmaWxldHlwZSAyIGVycm9ycyA1LCBubyBkaXIgaXRlbSwg
bm8gaW5vZGUNCnJlZg0KCXVucmVzb2x2ZWQgcmVmIGRpciA1MDk5MSBpbmRleCAyNzUgbmFtZWxl
biAzNiBuYW1lIGZjYjMyMDI3LTFkYTEtNDgwNi05Y2MxLTU1YjZkOTgxM2JhNyBmaWxldHlwZSAy
IGVycm9ycyAyLCBubyBkaXIgaW5kZXgNCls0LzddIGNoZWNraW5nIGZzIHJvb3RzICAgICAgICAg
ICAgICAgICAgICAgICAgKDA6MDA6MDIgZWxhcHNlZCwgNDEyODkgaXRlbXMgY2hlY2tlZCkNCkVS
Uk9SOiBlcnJvcnMgZm91bmQgaW4gZnMgcm9vdHMNCmZvdW5kIDIxOTc2MDYxNTQyNCBieXRlcyB1
c2VkLCBlcnJvcihzKSBmb3VuZA0KdG90YWwgY3N1bSBieXRlczogMjEzNTU5MDA0DQp0b3RhbCB0
cmVlIGJ5dGVzOiAxMDE4MTgzNjgwDQp0b3RhbCBmcyB0cmVlIGJ5dGVzOiA2Nzg5MjAxOTINCnRv
dGFsIGV4dGVudCB0cmVlIGJ5dGVzOiA4MTM2Mjk0NA0KYnRyZWUgc3BhY2Ugd2FzdGUgYnl0ZXM6
IDE5OTczOTY2OA0KZmlsZSBkYXRhIGJsb2NrcyBhbGxvY2F0ZWQ6IDI1MDM2MTQyNTkyMA0KIHJl
ZmVyZW5jZWQgMjI2OTMyMDM1NTg0DQoNCiQgc3VkbyBidHJmcyBmaSBzaG93DQpMYWJlbDogJ2Zl
ZG9yYScgIHV1aWQ6IDgjIyMjIyMjLSMjIyMtIyMjIy0jIyMjLSMjIyMjIyMjIyMjIw0KCVRvdGFs
IGRldmljZXMgMiBGUyBieXRlcyB1c2VkIDIwNC42N0dpQg0KCWRldmlkICAgIDEgc2l6ZSA0NDku
OThHaUIgdXNlZCAyMzkuMDNHaUIgcGF0aCAvZGV2L21hcHBlci9sdWtzLTEjIyMjIyMjLSMjIyMt
IyMjIy0jIyMjLSMjIyMjIyMjIyMjIw0KCWRldmlkICAgIDIgc2l6ZSA0NDkuOThHaUIgdXNlZCAy
MzkuMDNHaUIgcGF0aCAvZGV2L21hcHBlci9sdWtzLTIjIyMjIyMjLSMjIyMtIyMjIy0jIyMjLSMj
IyMjIyMjIyMjIw0KDQokIHN1ZG8gYnRyZnMgZmkgZGYgL2hvbWUNCkRhdGEsIFJBSUQxOiB0b3Rh
bD0yMzYuMDBHaUIsIHVzZWQ9MjAzLjcyR2lCDQpTeXN0ZW0sIFJBSUQxOiB0b3RhbD0zMi4wME1p
QiwgdXNlZD02NC4wMEtpQg0KTWV0YWRhdGEsIFJBSUQxOiB0b3RhbD0zLjAwR2lCLCB1c2VkPTk3
MC45N01pQg0KR2xvYmFsUmVzZXJ2ZSwgc2luZ2xlOiB0b3RhbD0zMjMuNzBNaUIsIHVzZWQ9MC4w
MEINCg0KJCB1bmFtZSAtYQ0KTGludXggc2VydmVyIDYuNy40LTEwMC5mYzM4Lng4Nl82NCAjMSBT
TVAgUFJFRU1QVF9EWU5BTUlDIE1vbiBGZWIgIDUgMjI6MTk6MDYgVVRDIDIwMjQgeDg2XzY0IEdO
VS9MaW51eA0KJCBidHJmcyAtLXZlcnNpb24NCmJ0cmZzLXByb2dzIHY2LjcNCg0KDQpUaGFua3Mh
DQotcnQNCg0KDQo=

