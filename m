Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38F2DCC21
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 06:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgLQFoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 00:44:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:40811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgLQFn7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 00:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608183745;
        bh=nIZH0Np3R+qfCzGQ1OF3xklHljTImIhCQjpm51zWdQw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XSVBPsuv/fbkW8HHefgut4r1rxhe8GW7PbEm1UecKUKDE1cWi+4J885EQYpWKktOa
         KY5Hfs7Dix/5LKmo3sOPvgLQJwSdQdSpmuzPrd8sxqixwoaEUpcx0iDF1AysPuNsZz
         5RsOmheW8viS3oAoUeKgquj8HXoWzCdbsJmIdCxw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpDNf-1kJQj93BuR-00qirt; Thu, 17
 Dec 2020 06:42:25 +0100
Subject: Re: [PATCH 2/4] btrfs: inode: remove variable shadowing in
 btrfs_invalidatepage()
To:     Su Yue <l@damenly.su>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20201217045737.48100-1-wqu@suse.com>
 <20201217045737.48100-3-wqu@suse.com> <k0thhu00.fsf@damenly.su>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ee628954-63db-2328-9d47-b1f0ed3bd8a7@gmx.com>
Date:   Thu, 17 Dec 2020 13:42:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <k0thhu00.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:0r2vuDCFZhUq27TPacJyfoOr7Nyni4vgE7AlabySAVf7bA3lxAL
 HnU1pkrqm111Ssk3TL6qkNMjhVQDvpNvvioSPjkeAOWbSiOzjHBjD7M0nL1EHCdElhrBM/l
 Dpn04Oo/FbYstMqZ7qLT37AzwwQZHSsCqPdCbpoEXjgVKahOje/+vPz7Qm6+bs9+Vnp010o
 Yu7vIXYmSFq1p53VT3hPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CI1dj6WQTiU=:5RgD6MsvJXiRZV7kQ1Gv7k
 XOEGM1X/7zbr+9l/7FRbluvEqGQF7Ie9RyBB6v/j7bsyugTUpemoB95W3U8jrM/uiqZPSF/D8
 Nome2Y3asbDYX+4YY5RyIjG1wDQGNqm7F8bh773Wk88V6oBtwZsJ3UGuh6igb/QCk5xytcdK4
 Kn6HOWQNLgvaowwJWg5yGUBJCOEbTsQ7OJ3k2FaIntujxneNm0379+2E4hnYKkqHl+Yvnm/cr
 APBqk7L8e1ODLO9Mczkr/ihLNrwGnuh3IsCO+2X0czG4jJnwiLHgRZ/tTzO1iE1V+B03FHjwH
 mAxjY9snB/NLP7bJXnD6I5EJhMHKfmFQXex5sGrknrfFMyZWSv8So3djHs66BXKWjXYPF2W9E
 4PdY59yjGsCB0Y0DgWH1WjRfrhPf1IhD77Sd/R3cIeqLw0/AD9HStXcVwR1iXAJwXKsEJsy2N
 3KglLMDoBSGjo5PzOUNCeiO00SV5qgLnDdBYteg0YdL8ZesfKzDMlVn15LTdVnTXRqiIman+Z
 CS3IQHQo9k6SPW1Bkgs8ttc3gYiU0PC/CufVvwDXY1rQ7UKcJb9QnQOWhWb2Pd6pNn7dxYuNK
 f0tmVZeLVnsv00TsZ0ToQXbcWwmHlsKI5VIzQayPV+FVfUViatrdkxAE6ibsINIDTUWGcTiYb
 YLE2QfFc/Pz1xqEvTZRr2wAW/VPkY2welUTo2Cf8tK2ebe0PSD40KF5fAbYWkVotpI7rRHfyp
 E2XZApidtl0vhtK21a231Sp8F5G2FJOZ1UW7Hf/Y3x2+AcHBv/aRWtXzAg6JCyXbAJf59Ywjv
 bAvxWnv/klSA7wv89nl/D3w5NiVbJ7QypQ3Z7pCjujb3DaIeDU+NT85rCBV2Ofg3WK0l2XhaD
 VpiQnFVCoLQkOVSzBpvQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjAvMTIvMTcg5LiL5Y2IMTozOCwgU3UgWXVlIHdyb3RlOg0KPiANCj4gT24gVGh1
IDE3IERlYyAyMDIwIGF0IDEyOjU3LCBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4gd3JvdGU6DQo+
IA0KPj4gSW4gYnRyZnNfaW52YWxpZGF0ZXBhZ2UoKSB3ZSByZS1kZWNsYXJlIEB0cmVlIHZhcmlh
YmxlIGFzDQo+PiBidHJmc19vcmRlcmVkX2lub2RlX3RyZWUuDQo+Pg0KPj4gUmVtb3ZlIHN1Y2gg
dmFyaWFibGUgc2hhZG93aW5nIHdoaWNoIGNhbiBiZSB2ZXJ5IGNvbmZ1c2luZy4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gwqBmcy9i
dHJmcy9pbm9kZS5jIHwgOSArKystLS0tLS0NCj4+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvaW5v
ZGUuYyBiL2ZzL2J0cmZzL2lub2RlLmMNCj4+IGluZGV4IGRjZWQ3MWJjY2FhYy4uYjRkMzZkMTM4
MDA4IDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvaW5vZGUuYw0KPj4gKysrIGIvZnMvYnRyZnMv
aW5vZGUuYw0KPj4gQEAgLTgxNjksNiArODE2OSw3IEBAIHN0YXRpYyB2b2lkIGJ0cmZzX2ludmFs
aWRhdGVwYWdlKHN0cnVjdCBwYWdlIA0KPj4gKnBhZ2UsIHVuc2lnbmVkIGludCBvZmZzZXQsDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBsZW5ndGgp
DQo+PiDCoHsNCj4+IMKgwqDCoMKgIHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUgPSBCVFJGU19J
KHBhZ2UtPm1hcHBpbmctPmhvc3QpOw0KPj4gK8KgwqDCoCBzdHJ1Y3QgYnRyZnNfb3JkZXJlZF9p
bm9kZV90cmVlICpvcmRlcmVkX3RyZWUgPSANCj4+ICZpbm9kZS0+b3JkZXJlZF90cmVlOw0KPj4N
Cj4gQW55IHJlYXNvbiBmb3IgdGhlIGRlY2xhcmF0aW9uIGhlcmU/IEkgZGlkbid0IGZpbmQgdGhh
dCBwYXRjaFszLzRdIHVzZSBpdC4NCg0KRGlkbid0IHRoYXQgb3JkZXJlZF90cmVlIGdldCB1c2Vk
IGxpbmVzIGJlbG93Pw0KDQo+IA0KPj4gwqDCoMKgwqAgc3RydWN0IGV4dGVudF9pb190cmVlICp0
cmVlID0gJmlub2RlLT5pb190cmVlOw0KPj4gwqDCoMKgwqAgc3RydWN0IGJ0cmZzX29yZGVyZWRf
ZXh0ZW50ICpvcmRlcmVkOw0KPj4gwqDCoMKgwqAgc3RydWN0IGV4dGVudF9zdGF0ZSAqY2FjaGVk
X3N0YXRlID0gTlVMTDsNCj4+IEBAIC04MjE4LDE1ICs4MjE5LDExIEBAIHN0YXRpYyB2b2lkIGJ0
cmZzX2ludmFsaWRhdGVwYWdlKHN0cnVjdCBwYWdlIA0KPj4gKnBhZ2UsIHVuc2lnbmVkIGludCBv
ZmZzZXQsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgKiBmb3IgdGhlIGZpbmlzaF9vcmRlcmVkX2lv
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKFRlc3RD
bGVhclBhZ2VQcml2YXRlMihwYWdlKSkgew0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGJ0cmZzX29yZGVyZWRfaW5vZGVfdHJlZSAqdHJlZTsNCj4+IC0NCj4gQmV0dGVyIHRvIGp1
c3QgcmVuYW1lIHRoZSBAdHJlZSB0byBAb3JkZXJlZF90cmVlLg0KDQpJc24ndCB0aGF0IGV4YWN0
bHkgd2hhdCBJIGRpZD8NCg0KVGhhbmtzLA0KUXUNCj4gDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0cmVlID0gJmlub2RlLT5vcmRlcmVkX3RyZWU7DQo+PiAtDQo+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzcGluX2xvY2tfaXJxKCZ0cmVlLT5sb2NrKTsNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNwaW5fbG9ja19pcnEoJm9yZGVyZWRfdHJlZS0+bG9jayk7DQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2V0X2JpdChCVFJGU19PUkRFUkVEX1RSVU5DQVRFRCwgJm9yZGVy
ZWQtPmZsYWdzKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcmRlcmVkLT50cnVuY2F0
ZWRfbGVuID0gbWluKG9yZGVyZWQtPnRydW5jYXRlZF9sZW4sDQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXJ0IC0gb3JkZXJlZC0+ZmlsZV9vZmZzZXQpOw0K
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2tfaXJxKCZ0cmVlLT5sb2NrKTsN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrX2lycSgmb3JkZXJlZF90cmVl
LT5sb2NrKTsNCj4+DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVNTRVJUKGVuZCAtIHN0
YXJ0ICsgMSA8IFUzMl9NQVgpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChidHJm
c19kZWNfdGVzdF9vcmRlcmVkX3BlbmRpbmcoaW5vZGUsICZvcmRlcmVkLA0KPiANCg==
