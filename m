Return-Path: <linux-btrfs+bounces-18377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD8C12E26
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 05:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1406B4EA1A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 04:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D927B50F;
	Tue, 28 Oct 2025 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b="RftOKkj9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1626C391
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627401; cv=none; b=fv/H4HWrsjywPP4puDMfMmD7H5PoPsTTx0N4sAL6bxpD6il/0d6oN5RXSLP4KRCcqfwbGNhzZ/1Cny33tjKaSSO/vNZIJawAAn9N6mT1QfALo1/tjcbFGUpp5n60Xa0vsEkvXq4leZA9nUPfwSsVGuttDFyTEFjrFCxMnD0sWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627401; c=relaxed/simple;
	bh=MkJnqiw/ZfpsmX/PlvIUteXIu8oZehB2S8uhxFfmL28=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=qKWKg1eVpC5hoJzmks5tcspu3ofi/zKgENcxJaXVQK/y3rwBxt46exxpgbcL5ebR/qvsQpNSZFVhdR1LgqFbSqoO62DJdgS1Rg1oP6LXSswFEgg6gALA5M2LFSa47bhgABLvI4KJOIh/3wu9YfEaJPGJ3WFky170zt0/ZaFIKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net; spf=pass smtp.mailfrom=sonic.net; dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b=RftOKkj9; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sonic.net
Received: from [192.168.3.25] (45-29-69-9.lightspeed.frokca.sbcglobal.net [45.29.69.9])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 59S4k2GL012668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 21:46:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonic.net; s=net23;
	t=1761626764; bh=0g33++plusN+Bi9+6X9j7GXK05QHabhJOncsHrj7X7E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:From:Subject;
	b=RftOKkj9dRAC4zCDb+YqYn/FH24+8Hb8HZh8Gh4fIp7pkxqGtHayyr05McuMRaNEl
	 EuxemcNpg36QYQI6RFCIF1H/YLqy5e3U5oaa7UeG67Va8nPWF/IV4FYBVK47JSH2uy
	 hi4JnNFYx80vQAuWpUmpMWP+tymztf5LohEJnOpmXSdAz0hYsAvXse5WqJy8bGuL0h
	 T3oLaaXPAsVxPfSfrpPoj0mMCnvtGI6kOgS5yX9R78ihUKC4o8f/WxY9bt6FZ9c/2Y
	 +4PiUc0vmCih8yjgZQRiulKUHhmbzLbTTcuPltnjqNfBQzYF/+TxDHMrUqKc/uncoo
	 VZuUDkaBPY2+A==
Content-Type: multipart/mixed; boundary="------------uIY5CDn6Kav6D1lPwMJCJr3v"
Message-ID: <596aeaaa-38fb-484f-b987-572a1096982a@sonic.net>
Date: Mon, 27 Oct 2025 21:46:01 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: Nathan Little <nathan.little@sonic.net>
Subject: Missing Device Blocks Mount After Replace
X-Sonic-CAuth: UmFuZG9tSVa9gHn78lKak0u6Wt7O9e1InLZq1d7X8CDl2IdKy7zZRD+thATomdnD1vuy9y+fPJq8/9ncOgA1sdGWOGk75uY77dXGwWqCo9s=
X-Sonic-ID: C;gN9JAbmz8BGcrbo7kIO7Ng== M;wDG3Abmz8BGcrbo7kIO7Ng==
X-Spam-Flag: No
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd

This is a multi-part message in MIME format.
--------------uIY5CDn6Kav6D1lPwMJCJr3v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I've got issues following an apparently successful replace of a failed 
drive in RAID6.

The replace was interrupted a couple of times.  First by motherboard 
failure. Subsequent tries aborted due uncorrectable errors caused by MB 
fail. Corrupted files were identified and deleted, and the replace 
restarted.

Replace and a subsequent balance finished successfully. Now on reboot, 
mount attempts fail and return errors indicating array is still looking 
for replaced disk.

Attached are relevant checks I thought to run, as well as the errors and 
dmesg output following attempts to mount with or without the degraded option

There's a line in dmesg about "btrfs device scan --forget" but running 
that on the new device does not result in a successful mount. It can't 
be run on the failed device, as that is no longer in the system.

My Best,

Nathan

--------------uIY5CDn6Kav6D1lPwMJCJr3v
Content-Type: text/plain; charset=UTF-8; name="btrfs command output.txt"
Content-Disposition: attachment; filename="btrfs command output.txt"
Content-Transfer-Encoding: base64

CiMjI0tlcm5lbCBWZXJzaW9uCnVuYW1lIC1yCjYuMTIuNDgrZGViMTMtYW1kNjQKCgojIyNC
VFJGUyB2ZXJzaW9uCmJ0cmZzLXByb2dzIHY2LjE0Ci1FWFBFUklNRU5UQUwgLUlOSkVDVCAt
U1RBVElDICtMWk8gK1pTVEQgK1VERVYgK0ZTVkVSSVRZICtaT05FRCBDUllQVE89YnVpbHRp
bgoKCiMjI0JUUkZTIFNob3cKYnRyZnMgZmkgc2hvdwpMYWJlbDogJ0FDNUItYnRyZnMnICB1
dWlkOiAzODNkNmE3ZC0wODI1LTRlZjktOTQ0MS03NmM0YTk1MWIxMTEKICAgICAgICBUb3Rh
bCBkZXZpY2VzIDIgRlMgYnl0ZXMgdXNlZCA4My40N0dpQgogICAgICAgIGRldmlkICAgIDEg
c2l6ZSAxMDkuOTFHaUIgdXNlZCA5NC4wM0dpQiBwYXRoIC9kZXYvbWFwcGVyL2NyeXB0LUFD
NUIKICAgICAgICBkZXZpZCAgICAyIHNpemUgMTA5LjkxR2lCIHVzZWQgOTQuMDNHaUIgcGF0
aCAvZGV2L21hcHBlci9jcnlwdC1BQzVBCgpMYWJlbDogJzgzOUUtMTJUQicgIHV1aWQ6IDg0
ZGJlZmQ2LWJmODctNGE4ZS05MjdkLWEzYjRjMDYwYjMyNgogICAgICAgIFRvdGFsIGRldmlj
ZXMgNCBGUyBieXRlcyB1c2VkIDUuNTlUaUIKICAgICAgICBkZXZpZCAgICAwIHNpemUgMTAu
OTFUaUIgdXNlZCAzLjE4VGlCIHBhdGggL2Rldi9tYXBwZXIvY3J5cHQtSjlXRS0xMlRCCiAg
ICAgICAgZGV2aWQgICAgMSBzaXplIDEwLjkxVGlCIHVzZWQgMy4xNVRpQiBwYXRoIC9kZXYv
bWFwcGVyL2NyeXB0LTgzOUUtMTJUQgogICAgICAgIGRldmlkICAgIDMgc2l6ZSAxMC45MVRp
QiB1c2VkIDMuMTZUaUIgcGF0aCAvZGV2L21hcHBlci9jcnlwdC05SjRFLTEyVEIKICAgICAg
ICBkZXZpZCAgICA0IHNpemUgMTAuOTFUaUIgdXNlZCAzLjE2VGlCIHBhdGggL2Rldi9tYXBw
ZXIvY3J5cHQtTDIxSC0xMlRCCgojIyNCVFJGUyBDaGVjawpidHJmcyBjaGVjayAvZGV2L2Rp
c2svYnktbGFiZWwvODM5RS0xMlRCCk9wZW5pbmcgZmlsZXN5c3RlbSB0byBjaGVjay4uLgp3
YXJuaW5nLCBkZXZpY2UgMiBpcyBtaXNzaW5nCgpDaGVja2luZyBmaWxlc3lzdGVtIG9uIC9k
ZXYvZGlzay9ieS1sYWJlbC84MzlFLTEyVEIKVVVJRDogODRkYmVmZDYtYmY4Ny00YThlLTky
N2QtYTNiNGMwNjBiMzI2ClsxLzhdIGNoZWNraW5nIGxvZyBza2lwcGVkIChub25lIHdyaXR0
ZW4pClsyLzhdIGNoZWNraW5nIHJvb3QgaXRlbXMKWzMvOF0gY2hlY2tpbmcgZXh0ZW50cwpF
UlJPUjogc3VwZXIgdG90YWwgYnl0ZXMgNDgwMDA0NzkwMDI2MjQgc21hbGxlciB0aGFuIHJl
YWwgZGV2aWNlKHMpIHNpemUgNjAwMDA1OTg3NTMyODAKRVJST1I6IG1vdW50aW5nIHRoaXMg
ZnMgbWF5IGZhaWwgZm9yIG5ld2VyIGtlcm5lbHMKRVJST1I6IHRoaXMgY2FuIGJlIGZpeGVk
IGJ5ICdidHJmcyByZXNjdWUgZml4LWRldmljZS1zaXplJwpbNC84XSBjaGVja2luZyBmcmVl
IHNwYWNlIHRyZWUKWzUvOF0gY2hlY2tpbmcgZnMgcm9vdHMKWzYvOF0gY2hlY2tpbmcgb25s
eSBjc3VtcyBpdGVtcyAod2l0aG91dCB2ZXJpZnlpbmcgZGF0YSkKWzcvOF0gY2hlY2tpbmcg
cm9vdCByZWZzCls4LzhdIGNoZWNraW5nIHF1b3RhIGdyb3VwcyBza2lwcGVkIChub3QgZW5h
YmxlZCBvbiB0aGlzIEZTKQpmb3VuZCA2MTQyMjE1NjMwODQ4IGJ5dGVzIHVzZWQsIGVycm9y
KHMpIGZvdW5kCnRvdGFsIGNzdW0gYnl0ZXM6IDExOTQ5NjEzNDY0CnRvdGFsIHRyZWUgYnl0
ZXM6IDI0MDEzNTM3MjgwCnRvdGFsIGZzIHRyZWUgYnl0ZXM6IDk1NzY2OTM3NjAKdG90YWwg
ZXh0ZW50IHRyZWUgYnl0ZXM6IDExODc4NDAwMDAKYnRyZWUgc3BhY2Ugd2FzdGUgYnl0ZXM6
IDMwODY2MTY5NzcKZmlsZSBkYXRhIGJsb2NrcyBhbGxvY2F0ZWQ6IDEzMzY3NjkzNDkxODE0
NAogcmVmZXJlbmNlZCAxMDk3MDY1MzQ1MDI0MAoKCiMjIyBNb3VudCB3L28gZGVncmFkZWQK
IG1vdW50IC1vIHN1YnZvbGlkPTI2MiAvZGV2L21hcHBlci9jcnlwdC1KOVdFLTEyVEIgL21l
ZGlhLzEyLXBvb2wvCiBtb3VudDogL21lZGlhLzEyLXBvb2w6IGZzY29uZmlnKCkgZmFpbGVk
OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5LgogICAgICAgZG1lc2coMSkgbWF5IGhhdmUg
bW9yZSBpbmZvcm1hdGlvbiBhZnRlciBmYWlsZWQgbW91bnQgc3lzdGVtIGNhbGwuCmRtZXNn
CmZpcnN0IG1vdW50IG9mIGZpbGVzeXN0ZW0gODRkYmVmZDYtYmY4Ny00YThlLTkyN2QtYTNi
NGMwNjBiMzI2ClsgODA2Ni44NjQ1NTRdIEJUUkZTIGluZm8gKGRldmljZSBkbS0yKTogdXNp
bmcgeHhoYXNoNjQgKHh4aGFzaDY0LWdlbmVyaWMpIGNoZWNrc3VtIGFsZ29yaXRobQpbIDgw
NjYuODY5OTIzXSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTIpOiBkZXZpZCAyIHV1aWQgYmRm
ZmY1NTUtYzljYi00ZDJlLTliMDAtM2ZlMTk0Yzk4OTMwIGlzIG1pc3NpbmcKWyA4MDY2Ljg3
MDAyM10gQlRSRlMgZXJyb3IgKGRldmljZSBkbS0yKTogZmFpbGVkIHRvIHJlYWQgY2h1bmsg
dHJlZTogLTIKCiMjI01vdW50IHcvIGRlZ3JhZGVkCm1vdW50IC10IGJ0cmZzIC1vIHN1YnZv
bGlkPTI2Mixjb21wcmVzcz16c3RkOjUsZGVncmFkZWQgL2Rldi9kaXNrL2J5LWxhYmVsLzgz
OUUtMTJUQiAvcm9vdC9tZWRpYS8xMi1wb29sL15DCm1vdW50OiBtb3VudGluZyAvZGV2L2Rp
c2svYnktbGFiZWwvODM5RS0xMlRCIG9uIC9yb290L21lZGlhLzEyLXBvb2wvIGZhaWxlZDog
U3RydWN0dXJlIG5lZWRzIGNsZWFuaW5nCgpkbWVzZwpbIDE1MDMuOTIyNDgwXSBCVFJGUyBp
bmZvIChkZXZpY2UgZG0tMik6IGZpcnN0IG1vdW50IG9mIGZpbGVzeXN0ZW0gODRkYmVmZDYt
YmY4Ny00YThlLTkyN2QtYTNiNGMwNjBiMzI2ClsgMTUwMy45MjI1MTBdIEJUUkZTIGluZm8g
KGRldmljZSBkbS0yKTogdXNpbmcgeHhoYXNoNjQgKHh4aGFzaDY0LWdlbmVyaWMpIGNoZWNr
c3VtIGFsZ29yaXRobQpbIDE1MDMuOTI1NDg5XSBCVFJGUyB3YXJuaW5nIChkZXZpY2UgZG0t
Mik6IGRldmlkIDIgdXVpZCBiZGZmZjU1NS1jOWNiLTRkMmUtOWIwMC0zZmUxOTRjOTg5MzAg
aXMgbWlzc2luZwpbIDE1MDMuOTQ0MTA1XSBCVFJGUyB3YXJuaW5nIChkZXZpY2UgZG0tMik6
IGRldmlkIDIgdXVpZCBiZGZmZjU1NS1jOWNiLTRkMmUtOWIwMC0zZmUxOTRjOTg5MzAgaXMg
bWlzc2luZwpbIDE1MDQuNjI2ODkzXSBCVFJGUyBpbmZvIChkZXZpY2UgZG0tMik6IGJkZXYg
PG1pc3NpbmcgZGlzaz4gZXJyczogd3IgMzM5OTI1NywgcmQgMzAsIGZsdXNoIDQ3OSwgY29y
cnVwdCAwLCBnZW4gMApbIDE1MDQuNjI2OTIxXSBCVFJGUyBpbmZvIChkZXZpY2UgZG0tMik6
IGJkZXYgL2Rldi9kbS01IGVycnM6IHdyIDMzOTczNTMsIHJkIDAsIGZsdXNoIDQ3MCwgY29y
cnVwdCAwLCBnZW4gMApbIDE1MDQuNjI2OTM2XSBCVFJGUyBpbmZvIChkZXZpY2UgZG0tMik6
IGJkZXYgL2Rldi9kbS0yIGVycnM6IHdyIDAsIHJkIDAsIGZsdXNoIDAsIGNvcnJ1cHQgNDcs
IGdlbiAwClsgMTUwNC42MjY5NDldIEJUUkZTIGluZm8gKGRldmljZSBkbS0yKTogYmRldiAv
ZGV2L2RtLTMgZXJyczogd3IgMCwgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAzMzUsIGdlbiAw
ClsgMTUwNC42MjY5NjNdIEJUUkZTIGluZm8gKGRldmljZSBkbS0yKTogYmRldiAvZGV2L2Rt
LTQgZXJyczogd3IgMjIzOTAsIHJkIDMxMjQsIGZsdXNoIDY4LCBjb3JydXB0IDMyNzc0LCBn
ZW4gMApbIDE1MDQuNjI2OTc5XSBCVFJGUyBlcnJvciAoZGV2aWNlIGRtLTIpOiByZXBsYWNl
IHdpdGhvdXQgYWN0aXZlIGl0ZW0sIHJ1biAnZGV2aWNlIHNjYW4gLS1mb3JnZXQnIG9uIHRo
ZSB0YXJnZXQgZGV2aWNlClsgMTUwNC42MjY5ODhdIEJUUkZTIGVycm9yIChkZXZpY2UgZG0t
Mik6IGZhaWxlZCB0byBpbml0IGRldl9yZXBsYWNlOiAtMTE3ClsgMTUwNC42MzgyNDldIEJU
UkZTIGVycm9yIChkZXZpY2UgZG0tMik6IG9wZW5fY3RyZWUgZmFpbGVkOiAtMTE3CgoK

--------------uIY5CDn6Kav6D1lPwMJCJr3v--

