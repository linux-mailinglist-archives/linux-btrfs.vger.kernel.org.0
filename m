Return-Path: <linux-btrfs+bounces-10988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEDAA147D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 03:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1D8168179
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548BC1E3DD1;
	Fri, 17 Jan 2025 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="o+MDPDwy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A441E2843
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737079231; cv=none; b=iKrHjzHHLWbAvJTfw0q9XDm5JRihIgs3DbaFM0uAvZJbgQdqVbrA3tHYbWzOJxW+EZ9NO/CZW7cUIMH7X7ugd9huC6grYq30C5sEqTbYNnueVWJg7mtWyfyq7ozyQqyeKubpV5UpvtzwkuFR8bs+mravWHNro8sGpSEWrcBGI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737079231; c=relaxed/simple;
	bh=P4mS3u/Ji+++U496uDgJKYFHWPi8pqXTvcH62T/IEFY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WVFARSPMKmQbh1UYNebJIbLCjvcTgsNbq9+ycdW0x10mzbsezCZYtvgGWVCPyPye1SU6onPHyAIv/cdIp4s3Sl28/ANmZf6CCGSnQgBeDoH5dDdfc8DWpwz4/hrSMEW0X0BYmtPLrtT0dhzb0VBgVKSidqN/kVZ5caHesmwSd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=o+MDPDwy; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1737079223;
	bh=P4mS3u/Ji+++U496uDgJKYFHWPi8pqXTvcH62T/IEFY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=o+MDPDwy3hw/2O92ehYnIMToa8RGx1xuObPtRw1v1DOyef9UBStxa7uPiHRBsWGBg
	 PyiaVphTOrZK3ux4Mh7zoSGQvv//HW3EYBK2DyQDUuIyOA1Yx8W4ucpE4+t3Rueibl
	 5fLWKqm9akJH+1w7ohcbed57EUP9Y3wwNvuGgBlM=
X-QQ-mid: bizesmtpip2t1737079221twhqz31
X-QQ-Originating-IP: k24mYZUIMVE1zbFyT9GBOa1SihnDxYBmGriOxuotxo4=
Received: from [IPV6:2408:8214:5911:e450:e964: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 10:00:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5013459786761016107
Message-ID: <FC80D8E2329D01B2+8728a519-d248-4c20-95ad-91750de9fc88@bupt.moe>
Date: Fri, 17 Jan 2025 10:00:20 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Yuwei Han <hrx@bupt.moe>
Subject: [BUG] zoned device can't properly start full balance
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MXHIEC8P0R7heRGd1aoP1OZfw4fM9P88ELgv/FErtAY27/AdYNBAXBhN
	gKrjSK7VAXzbI5ha+qblxu1fVf5PsPrTUhX1hpIrChF2nUhInwTmtU+LLQgVWSxuEi2Tf2J
	KU0eiFz5GLIM6QzP0EtDmrezQSLR7AWmtucnk1yVlozhdnDasor9UnjnpV38jbfstaY1jLo
	tge3nz6E8cEx9mQhGDh0U1K0YaKZm/6tCjG/M3xhPfFiirctwxL8tdF8a39vFQNmIqAHjKZ
	fteMv4kv8t8z61jB01G5ap7ycJ0hh0uRL14JA6S3fZS7800g2YegeKhDi0h+xVbJCv91ihU
	YsxjgirfUZcXLvUVqKsQQ4asYTUW/3KjnrMEOV2Pu2VPh3ruodKCGCdeHkruZezKoLKjaJY
	kYc68mRRmMVs432p6k5J1b8zXY/cAgYvHCYKd3uxJUrg/EiTxFxzcFeCcLFiKlMct5ZCpaG
	FDNVuATTbg3bV+iToHwRZQ11Vb/z6Et8n8HSVB5icv0F0r1c0iqnyScjZnfMRVJYv4LbU4S
	k3H6KoQhzOJYjbqvim256V1ZfQw+ybZJlC3M5NmIiydqNaUVxeCDuvS/hjcZguHiDXLeZJT
	KxjvVXZCTJBjbY+aqCgBtyQF3BJYFDSqJQK+eWWCyBFw9ePPLTzfYulMhfTwdF8fMgh9oG7
	OeXgyoIiOnruCegfCwiQ6UsG9Lmz7IWmq6EbOVPwUw/E/S15SJ/i6yl1vC9Jb8V1mlcR9a1
	1clafgzf2LMxUC9zTfzEEWGsfBL17eFpqz+Unj393xm4PgqPAt8aZEBO5yoATVC8X91mJtW
	qc87Isqg2lTgSHRSuRu2aaRr0S/6SQFWY5E7eF8h7UAiuLDPyrHIWqtCPUqCFkXXe2TwB+E
	hu/7wPibWPrB6XXPENYbp6xPrU60NE9uz1a0iUS+62QVHCQeKSdK86iDGiJeUSozCdlMjr3
	Ldjk=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

SGksDQpJIGZvdW5kIHRoYXQgd2hlbiBJIGFtIHRyeWluZyB0byBmdWxsIHJlYmFsYW5jZSB6
b25lZCB2b2x1bWUsIGl0IGZhaWxlZCANCmFuZCBkbWVzZyBpcyBhcyBmb2xsb3dzOg0KDQpb
MjI2MDkyNi45NzYwMjddIEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiBiYWxhbmNlOiBzdGFy
dCAtZCAtbSAtcw0KWzIyNjA5MjcuMjAxNDE4XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTog
cmVsb2NhdGluZyBibG9jayBncm91cCANCjQ3OTg3MTMyNzI3Mjk2IGZsYWdzIG1ldGFkYXRh
fGR1cA0KWzIyNjA5MjguNDczNTU0XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogZm91bmQg
MTAxMSBleHRlbnRzLCBzdGFnZTogDQptb3ZlIGRhdGEgZXh0ZW50cw0KWzIyNjA5MjguNTY3
MTEyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogcmVsb2NhdGluZyBibG9jayBncm91cCAN
CjQ3OTg2ODY0MjkxODQwIGZsYWdzIG1ldGFkYXRhfGR1cA0KWzIyNjA5MjkuNTk3NDA2XSBC
VFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogZm91bmQgODMyIGV4dGVudHMsIHN0YWdlOiBtb3Zl
IA0KZGF0YSBleHRlbnRzDQpbMjI2MDkyOS43NTczNjddIEJUUkZTIGluZm8gKGRldmljZSBz
ZGIpOiByZWxvY2F0aW5nIGJsb2NrIGdyb3VwIA0KNDc5ODY1OTU4NTYzODQgZmxhZ3MgbWV0
YWRhdGF8ZHVwDQpbLi4uXQ0KWzIyNjEwOTguOTcyMTg4XSBCVFJGUyBpbmZvIChkZXZpY2Ug
c2RiKTogcmVsb2NhdGluZyBibG9jayBncm91cCANCjQ3ODUyMTA5NjkyOTI4IGZsYWdzIGRh
dGENClsyMjYxMTAxLjkzNjMxOV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYik6IGZvdW5kIDYx
MSBleHRlbnRzLCBzdGFnZTogbW92ZSANCmRhdGEgZXh0ZW50cw0KWzIyNjExMDIuMjc2MTc4
XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogZm91bmQgNjExIGV4dGVudHMsIHN0YWdlOiAN
CnVwZGF0ZSBkYXRhIHBvaW50ZXJzDQpbMjI2MTEwMi42MDc3NjRdIEJUUkZTIGluZm8gKGRl
dmljZSBzZGIpOiByZWxvY2F0aW5nIGJsb2NrIGdyb3VwIA0KNDc4NTE4NDEyNTc0NzIgZmxh
Z3MgZGF0YQ0KWzIyNjExMDMuNTAzNjY1XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYik6IGJk
ZXYgL2Rldi9zZGIgZXJyczogd3IgNTI5LCANCnJkIDAsIGZsdXNoIDAsIGNvcnJ1cHQgMCwg
Z2VuIDANClsyMjYxMTA0LjMxMTA5NF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYik6IGJhbGFu
Y2U6IGVuZGVkIHdpdGggc3RhdHVzOiAtNQ0KDQp1bmFtZSAtYTpMaW51eCBhb3NjM2E2IDYu
MTEuMTAtYW9zYy1tYWluICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgU3VuIERlYyANCjEgMTE6
MjY6MzIgVVRDIDIwMjQgbG9vbmdhcmNoNjQgR05VL0xpbnV4DQoNCkFueSBzdWdnZXN0aW9u
cz8NCg0KSEFOIFl1d2VpDQo=

