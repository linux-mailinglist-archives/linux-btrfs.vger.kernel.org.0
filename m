Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4E636445B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 15:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242256AbhDSN0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 09:26:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:53991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240564AbhDSNZi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 09:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618838700;
        bh=P2YZq2d9g+MXO6fT8wEdUkNOFp42EkTmwbE8kE88RwQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BWf6jEXLhaIbCul7YulMaltxbFExmkMN8I3fO0QjJrgkPgIvqHqNoCC8jqO1hRrSN
         77x0GKkHVgO+1edf+diXu96ZigcwD4BkyVlQPxoVqsO9Ca88ULyNIaq54KBTInFt31
         OJRwSfZ527vdpRi2TmUoJDgJ4ChnaZs7Na0tdokA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDjA-1lMyMX3fuI-00CmWi; Mon, 19
 Apr 2021 15:25:00 +0200
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
To:     Qu Wenruo <wqu@suse.com>, riteshh <riteshh@linux.ibm.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
 <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
 <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
 <20210415145207.y4n3km5a2pawdeb4@riteshh-domain>
 <8bdb27e4-af63-653c-98e5-e6ffa4eee667@gmx.com>
 <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
 <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
 <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
 <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
 <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
 <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
 <03236bad-ecb5-96c7-2724-64a793d669bf@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <344f81af-f36d-1484-3a0c-894d111d0605@gmx.com>
Date:   Mon, 19 Apr 2021 21:24:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <03236bad-ecb5-96c7-2724-64a793d669bf@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:2FxBGOeGvXFwnX+kev5eF5ern0upJOlmy6BFj+xexE0002apmZt
 J2hPFCr1znFmiALe/lb3Yq4UF95AnIxNvTpUehD8bJhEL+cuCaigggsxY1G1+wrvXLi8s++
 VSp7exQ8F2YAuDYLwmxW5UUKrQ53tPiEZkwVXBuomBnJ93i9C90e2d/3PpLbTOua2zNausp
 kW1b2H8gWP35KblQ5KN4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iDGqgvRnI2w=:u45E8jLfRIfhdM0UTr/JaQ
 m18KoscAZuTzDABKuj07Hf8Y9fbiSxoI5izmV+r3mmbK3n5RhWBoVPqoS3SKEAj9DnhvwBboq
 CStFZHpT9qx9XhcxPpmjvX0XwUh/+OZOFKWvYjSyu2YjCogKEtG8qXa/KB6NGG0tlTlRtP7Cd
 ySebbI3DDky3EXogVeEpUaDc/NhPwOtyv7346gR92x53cR0CTB7UIZqb4NQ/BGzlmQeP6URM7
 ON4AH1xlOIDSnTUtuFvkmd2Vm2KiWDqrEP4m8gPoehd1HUK1E1JyWCuTorUUe94VKgeyiVFo8
 L5ca83R8h+P2cdYqrVpKmLeqg0SiJRLGVp5iKdiXTCLYW1LiWsBBO9KTip0zkd6DleYadnPZB
 6+Zhxdih+CQwCTcLqVf7pCJcpMVP8wwzAe84k3zh5sr5mD9u9PDHxHbcnu8HKgbR01lp1Xu/O
 RZDeQeS9UvIUceiAJjb+Qc+jl0jVtLh/BQMqqWLFHT7tzsJFphS0S5cf4rDH+zvjgh/X/XI87
 /W7/t9XKGhBFMfoU0K9cbULWUnQj9+0YIXv/mMISa91nOeE/E2+yah0Nenuo4C+EjpeL2OUI8
 QxWTX1j3rPcwn7m04nbzi39+gZpl+DOd0+pw5ZXKmDTLT9F5gsjk2raKHAdWGlZoT/uqmBoha
 9RtwG7dPxiF+6QajpSJuqa1jiWhsBMxZMg9xFY2b2l08vMbcLZsSK4URR62CZmzQBBLxl1VpS
 tRDlRCVwZW4jBiO11o25LxOtSwzRpam3kEy+ZQvFh+hm/YktAM7Z5cd/fpPrFpav8DA1Cd1YD
 C6c8pOCAn4ev2z3wooG4AN3AJqhVfXugwtJiz1LzqyXPbW1igyYBKOjO6f04tQWQennM4Wv9e
 gG3vjvDyRaqm3ZcD5FnfH8IWOxXSnCbP1lFkOQuvhheAKk78v/8rlXObQBzJnsKHa4sC1jDk4
 WMDGkH7caY7ZHO2DezCIWPxjYXAJY412tSOUfxMIa2GXfAu+CIjuk/HOO8xwWS52E2cECIIag
 cLYbFAeMec/tnPWdFR/JOOcHcENCNsAHDjkVBsvOWlXj/avCAdhJUw7S9NOrlAeKGKSdsexxi
 gr+OweJRW36ZLg8AtshS7MTFsLWs8AuKW+nlNdY9zUVuGZtvkqe2HTym13I4UX9j/I4/JLxeq
 brDGw27ZMngUM0Os46ilsChjeMqHhM7CjaCTAFGKoaJM5XnrZ8B2GpPBHKF6laF8v+EEXBy9m
 0Z4GVDbjpRwaM6J9E
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Wy4uLl0NCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZmlsZS5jIGIvZnMvYnRyZnMvZmls
ZS5jDQo+PiBpbmRleCA0NWVjM2Y1ZWY4MzkuLjQ5Zjc4ZDY0MzM5MiAxMDA2NDQNCj4+IC0tLSBh
L2ZzL2J0cmZzL2ZpbGUuYw0KPj4gKysrIGIvZnMvYnRyZnMvZmlsZS5jDQo+PiBAQCAtMTM0MSw3
ICsxMzQxLDE3IEBAIHN0YXRpYyBpbnQgcHJlcGFyZV91cHRvZGF0ZV9wYWdlKHN0cnVjdCBpbm9k
ZSANCj4+ICppbm9kZSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdW5sb2NrX3BhZ2UocGFnZSk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlPOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChwYWdl
LT5tYXBwaW5nICE9IGlub2RlLT5pX21hcHBpbmcpIHsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8qDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
U2luY2UgYnRyZnNfcmVhZHBhZ2UoKSB3aWxsIGdldCB0aGUgcGFnZSB1bmxvY2tlZCwgd2UNCj4+
IGhhdmUNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBhIHdpbmRvdyB3aGVy
ZSBmYWR2aWNlKCkgY2FuIHRyeSB0byByZWxlYXNlIHRoZSBwYWdlLg0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIEhlcmUgd2UgY2hlY2sgYm90aCBpbm9kZSBtYXBwaW5nIGFu
ZCBQYWdlUHJpdmF0ZSgpIHRvDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
bWFrZSBzdXJlIHRoZSBwYWdlIGlzIG5vdCByZWxlYXNlZC4NCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRo
ZSBwcmlhdnRlIGZsYWcgY2hlY2sgaXMgZXNzZW50aWFsIGZvciBzdWJwYWdlIGFzIHdlDQo+PiBu
ZWVkDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdG8gc3RvcmUgZXh0cmEg
Yml0bWFwIHVzaW5nIHBhZ2UtPnByaXZhdGUuDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICovDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocGFnZS0+bWFw
cGluZyAhPSBpbm9kZS0+aV9tYXBwaW5nIHx8DQo+PiBQYWdlUHJpdmF0ZShwYWdlKSkgew0KPiAg
wqBeIE9idmlvdXNseSBpdCBzaG91bGQgYmUgIVBhZ2VQcml2YXRlKHBhZ2UpLg0KDQpIaSBSaXRl
c2gsDQoNCk1pbmQgdG8gaGF2ZSBhbm90aGVyIHRyeSBvbiBnZW5lcmljLzA5NT8NCg0KVGhpcyB0
aW1lIHRoZSBicmFuY2ggaXMgdXBkYXRlZCB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWl0IGF0IHRv
cDoNCg0KY29tbWl0IGQ3MDBiMTZkY2VkNmYyZTJiNDdlMWNhNTU4OGE5MjIxNmNlODRkZmIgKEhF
QUQgLT4gc3VicGFnZSwgDQpnaXRodWIvc3VicGFnZSkNCkF1dGhvcjogUXUgV2VucnVvIDx3cXVA
c3VzZS5jb20+DQpEYXRlOiAgIE1vbiBBcHIgMTkgMTM6NDE6MzEgMjAyMSArMDgwMA0KDQogICAg
IGJ0cmZzOiBmaXggYSBjcmFzaCBjYXVzZWQgYnkgcmFjZSBiZXR3ZWVuIHByZXBhcmVfcGFnZXMo
KSBhbmQNCiAgICAgYnRyZnNfcmVsZWFzZXBhZ2UoKQ0KDQpUaGUgZml4IHVzZXMgdGhlIFBhZ2VQ
cml2YXRlKCkgY2hlY2sgdG8gYXZvaWQgdGhlIHByb2JsZW0sIGFuZCBwYXNzZXMgDQpzZXZlcmFs
IGdlbmVyaWMvYXV0byBsb29wcyB3aXRob3V0IGFueSBzaWduIG9mIGNyYXNoLg0KDQpCdXQgY29u
c2lkZXJpbmcgSSBhbHdheXMgaGF2ZSBkaWZmaWN1bHQgaW4gcmVwcm9kdWNpbmcgdGhlIGJ1ZyB3
aXRoIA0KcHJldmlvdXMgaW1wcm9wZXIgZml4LCB5b3VyIHZlcmlmaWNhdGlvbiB3b3VsZCBiZSB2
ZXJ5IGhlbHBmdWwuDQoNClRoYW5rcywNClF1DQo+IA0KPiBUaGFua3MsDQo+IFF1DQo+IA0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bmxvY2tfcGFn
ZShwYWdlKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FQUdBSU47DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0K
Pj4NCj4+DQo+Pj4NCj4+Pg0KPj4+IC1yaXRlc2gNCj4+Pg0KPiANCg==
