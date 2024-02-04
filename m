Return-Path: <linux-btrfs+bounces-2091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC76848C7F
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 10:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941BD1C21187
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEF318C28;
	Sun,  4 Feb 2024 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="lA+I9Uei"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0D18AF8
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Feb 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707039305; cv=none; b=S25Yv0MBskJKtcsH+tpq81OOY+nILreIp/apOBfHB66+QRY0dv/s9FwvbKmnI1wopNWDDgtxvvSeNMCrDhttJOKJRh4v3aJ84MMfufrkKTyyzaortFubE5g8jJfgPNOEu30ciT43TkXn4K7EUclrhswqNvHvQWX0AJO7DkNZcDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707039305; c=relaxed/simple;
	bh=PHU4ZbeaqpOPlMXiYOLGCeRXrnTTM9HRpz8xCxMvSNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNQ3oErV1jbSSdowHnCkXcOFLmAKU+TZJ544exto3rPBHf5CXeldztCAAx7dXUNk+1UMlBdTKuVL54abxIpTxlNjVaDw4hRahFADrNDgeomrmCpX0RN3szA8t5TQEesQNIFdAAT8eykZ+a3qQwC8Bn6HjqkXHbTC8GY3rN5hDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=lA+I9Uei; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1707039293;
	bh=PHU4ZbeaqpOPlMXiYOLGCeRXrnTTM9HRpz8xCxMvSNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lA+I9UeiTzIdHefOVKUOm+1KWYXK/ArcT8b5uQo+z9cWTt4O7Fd4ysM97CxkWUxWF
	 ZpDEKp9hlXrolRWd5wCIDi5d/douCHl7ziKANuqSztRJX2L7Ambn6xp8V6bZFgYuFm
	 +sS2JV8vU4mSDV74Ey0q57ND+ZgpaSuiFvZ+AevU=
X-QQ-mid: bizesmtpipv602t1707039291tk07
X-QQ-Originating-IP: n1okoY0K7JFlRulpsvHbzXxfTc96wP7PT5mkzN2TZJU=
Received: from [IPV6:240e:381:70b1:9300:65:5b0 ( [255.153.124.8])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 04 Feb 2024 17:34:50 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: W+onFc5Tw4PPmchNWVMgeTlPQdfgbbgKg7KEjeR8K3/RENNV3sHpxEuKY8cfg
	9LkuG/JCKlWxQ66juROMviSMPzkJnaXP76RYJNi6oZoNdB1FgwzTeGPL1I3g0vyNTdwu6UW
	wLDgJtRmjsDZAoiHDMjM2DP11rjFcXmOOU8Kmee8suOQ+QfcJ1pdL1J60tDgwxT6tNFGHsG
	egolTGQGgigQ7N63HzblXClmj+WGS2+43C+hRsTTdKYxiyUkDTgFm/Lbz2Rh731yqUQJkVF
	RpNxowoRocsgPVN66CKmMYuaN0xKKZau6drKB29TyaQs/FgC8rEjc3L+zOiEpLd1Q6vQ+4Y
	yXTx/yxospi8aa6c8X+B+tFNigPOg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8243664719964208446
Message-ID: <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
Date: Sun, 4 Feb 2024 17:34:50 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
In-Reply-To: <20240203221545.GB355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

ID4gaWUuIG1rZnMuYnRyZnMgLS1zZWN0b3JzaXplIDE2ay4gaXQgd29ya3MhIEkgY2FuIHN5
bmMgd2l0aG91dCBhbnkgDQpwcm9ibGVtIG5vdy4gSSB3aWxsIGNvbnRpbnVlIHRvIG1vbml0
b3IgaWYgYW55IGlzc3VlcyBvY2N1cnJlZC4gc2VlbXMgDQpsaWtlIEkgY2FuIG9ubHkgdXNl
IHRoZXNlIGRpc2tzIG9uIG15IGxvb25nc29uIG1hY2hpbmUgZm9yIGEgd2hpbGUuDQoNCklz
IHRoZXJlIGFueSBwcm9ncmVzcyBvciBwcm9wb3NlZCBwYXRjaCBmb3Igc3VicGFnZSBsYXll
ciBmaXg/DQoNCuWcqCAyMDI0LzIvNCA2OjE1LCBEYXZpZCBTdGVyYmEg5YaZ6YGTOg0KPiBP
biBTYXQsIEZlYiAwMywgMjAyNCBhdCAwNjoxODowOVBNICswODAwLCDpn6nkuo7mg58gd3Jv
dGU6DQo+PiBXaGVuIG1rZnMsIEkgaW50ZW50aW9uYWxseSB1c2VkICItcyA0ayIgZm9yIGJl
dHRlciBjb21wYXRpYmlsaXR5Lg0KPj4gQW5kIC9zeXMvZnMvYnRyZnMvZmVhdHVyZXMvc3Vw
cG9ydGVkX3NlY3RvcnNpemVzIGlzIDQwOTYgMTYzODQsIHdoaWNoDQo+PiBzaG91bGQgYmUg
b2suDQo+Pg0KPj4gYnRyZnMtcHJvZ3MgaXMgNi42LjItMSwgaXMgdGhpcyByZWxhdGVkPw0K
PiBObywgdGhpcyBpcyBzb21ldGhpbmcgaW4ga2VybmVsLiBZb3UgY291bGQgdGVzdCBpZiBz
YW1lIHBhZ2UgYW5kIHNlY3Rvcg0KPiBzaXplIHdvcmtzLCBpZS4gbWtmcy5idHJmcyAtLXNl
Y3RvcnNpemUgMTZrLiBUaGlzIGF2b2lkcyB1c2luZyB0aGUNCj4gc3VicGFnZSBsYXllciB0
aGF0IHRyYW5zYWxhdGVzIHRoZSA0ayBzZWN0b3JzIDwtPiAxNmsgcGFnZXMuIFRoaXMgaGFz
DQo+IHRoZSBrbm93biBpbnRlcm9wZXJhYmlsaXR5IGlzc3VlcyB3aXRoIGRpZmZlcmVudCBw
YWdlIGFuZCBzZWN0b3Igc2l6ZXMNCj4gYnV0IGlmIGl0IGRvZXMgbm90IGFmZmVjdCB5b3Us
IHlvdSBjYW4gdXNlIGl0Lg0KPg0K


