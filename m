Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7103B9A27
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 02:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhGBAmB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 20:42:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:55967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234251AbhGBAmA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 20:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625186351;
        bh=eCC5xvwtPXKGPhNA/9k9IS5mbJ3dtdO5y6cv2UQl2rg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cR5COYfYfVXclZXAnC3eVErq5VlREWOhh0thDdz9iJ3OiFLQ6l9xux3swiWZx+9Qv
         P3mBBkn/L3IVsm/SxxYdfwx5TpSWpCLYDDjyEsxcbs+L37pTGrQQLgwUtk2IDvScTE
         au32mYTIRkqZ+FBE92X8P5q3jDuCrRrw27x34BZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VHG-1lA21E2nU2-016zKZ; Fri, 02
 Jul 2021 02:39:11 +0200
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210701160039.12518-1-dsterba@suse.com>
 <20210701215740.GA12099@embeddedor>
 <fc90ec53-1632-e796-3bf0-f46c5df790bb@gmx.com>
 <dd4346f9-bc3d-b12f-3b32-1e1ecabb5b8b@embeddedor.com>
 <62ec2948-77a3-6e50-7940-8de259b8671f@gmx.com>
 <20210702003936.GA13456@embeddedor>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <77ce2806-9be0-6ed7-4657-a0ce8b3ab0c6@gmx.com>
Date:   Fri, 2 Jul 2021 08:39:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702003936.GA13456@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:W870MYFixAaymqEVUoPZxRPad1GXzwXCA6fY34gHXxd/Qf5B9MI
 Q7vJ/vTIH8CsEVJrNbdvQ57vM920uXyT0j0vGGRofD5Qogb+o6lO7xj9YZa7vtK3b3lUpAS
 JPBF9QYvu88krMj5m2pz/jqBL3BxQAv4XPKM7MR4hiIvdN6qbwYhWEgvXeyzWlkE81EpUuH
 HGMWacOVNsI998ECKERZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yB3h/CJIn+4=:VoDponVf2z0cmqhJf6a7fl
 9nfI4UqCw1mxhCtQem+JdprTKsIzoA1gIam1fCS87gPq0GTjLiYQr9WUFZsMN58W8IPjwFSRH
 e+9cHNHkGlsTPyEDuZEaLIoSG+wBSp3zIPklOhN+Fxq5MukK2gjIHjrja/CU8maN5jmbWA8FJ
 JYDys2W3M268YZuUvjI/muk4U8vG9LBT9h0h2qeEunIzyRaGzl3ClIJDhTzubGJYs6RhY4Eb+
 T6OyNeHe4OVGFMTkIHx+g0K4+I3WQCvmBR+gyIe893PVIbkE1AVlouT9WRzyT1wBEDWPr9veQ
 oeH3C69kVSFOUuPs8kA/ZypIk9SeO2WHpWIsKPzHO1JUtLti5MJldiGGy9F7VdO9K8LBgWTDQ
 6yXvwwEyNYILTwwtQGL0NIojuXPkrG/5vxOWTVZCSHFaXDYlJqCp3n0tPp5NI3juGoLTV9V/j
 s3Bou+hDeseZB9wRl3jqZuoo4feozStxKoPR21f7WLQSjGcJkoQag+8AGbjYzjG+Yu/WXvFPG
 Tzy3goG7+NqdvW3NAMfN0RjT3kZ0mv1shcs8HhsbsiQpLc2PSoDKzNUSLEQZqc4yo9kxRk5Mb
 3yjsX6NlziiLsGtD1Wcpx1I5v5LlFc2smDQnLsCrIsX4ki/6Jm4T+kz9Chr37o2n5rfFVZPBV
 D19ekm/MuzKnI8GiC7BQl8zq00I2CXuXH+Di4h9wmG3soGczZFVcCBWQzz0srsxQOeJIyh7mS
 ERKcBI0xiep7YA8Xq7CvmBIrndMBlfb0tS5npUWzT+TpTB7gbdVIZP/hSpOERJySrRYhm7G8B
 mtoGr9CrY+2zK7hgIoQ20u5lUHfSFXxQ2fhpnSgm6G4F0zwD+/Og2udtZdxHP0kW1mSPLlAWg
 sLu8ZU9aBkEWCFPAN04Aw43efHd22rTMF7DqxhwVJWXsiaaiC3vhWYUKjUWjKdnB6zQ+587SM
 eugZMzMHxdcXT/BGJ1hL1ZjRP5aGKhA9raGy4x076znX+qtYxKWfehW9nlmQKAnnyydfjrg+b
 j/Btkvkk9cxojpnx7YOEccwafDZnk9PKw189KiS8KZxI2Nk8N3g5/nBoXrS3BQd4Kt7xi2pk8
 201SZpMS9ui5xoE6ht3x/hTxtQTh+E5BPWTAniYv2n0OH2M/m84dV12dg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjEvNy8yIOS4iuWNiDg6MzksIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6DQo+
IE9uIEZyaSwgSnVsIDAyLCAyMDIxIGF0IDA4OjIxOjMxQU0gKzA4MDAsIFF1IFdlbnJ1byB3cm90
ZToNCj4+DQo+Pg0KPj4gT24gMjAyMS83LzIg5LiK5Y2IODowOSwgR3VzdGF2byBBLiBSLiBTaWx2
YSB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24gNy8xLzIxIDE4OjU5LCBRdSBXZW5ydW8gd3JvdGU6
DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDIwMjEvNy8yIOS4iuWNiDU6NTcsIEd1c3Rhdm8gQS4gUi4g
U2lsdmEgd3JvdGU6DQo+Pj4+PiBPbiBUaHUsIEp1bCAwMSwgMjAyMSBhdCAwNjowMDozOVBNICsw
MjAwLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+Pj4+Pj4gT24gNjRLIHBhZ2VzIHRoZSBzaXplIG9m
IHRoZSBleHRlbnRfYnVmZmVyOjpwYWdlcyBhcnJheSBpcyAxIGFuZA0KPj4+Pj4+IGNvbXBpbGF0
aW9uIHdpdGggLVdhcnJheS1ib3VuZHMgd2FybnMgZHVlIHRvDQo+Pj4+Pj4NCj4+Pj4+PiAgIMKg
wqAga2FkZHIgPSBwYWdlX2FkZHJlc3MoZWItPnBhZ2VzW2lkeCArIDFdKTsNCj4+Pj4+Pg0KPj4+
Pj4+IHdoZW4gcmVhZGluZyBieXRlIHJhbmdlIGNyb3NzaW5nIHBhZ2UgYm91bmRhcnkuDQo+Pj4+
Pj4NCj4+Pj4+PiBUaGlzIGRvZXMgbmV2ZXIgYWN0dWFsbHkgb3ZlcmZsb3cgdGhlIGFycmF5IGJl
Y2F1c2Ugb24gNjRLIGJlY2F1c2UgYWxsDQo+Pj4+Pj4gdGhlIGRhdGEgZml0IGluIG9uZSBwYWdl
IGFuZCBib3VuZHMgYXJlIGNoZWNrZWQgYnkgY2hlY2tfc2V0Z2V0X2JvdW5kcy4NCj4+Pj4+Pg0K
Pj4+Pj4+IFRvIGZpeCB0aGUgcmVwb3J0ZWQgb3ZlcmZsb3cgYW5kIHdhcm5pbmcgYWRkIGEgY29w
eSBvZiB0aGUgbm9uLWNyb3NzaW5nDQo+Pj4+Pj4gcmVhZC93cml0ZSBjb2RlIGFuZCBwdXQgaXQg
YmVoaW5kIGEgY29uZGl0aW9uIHRoYXQncyBldmFsdWF0ZWQgYXQNCj4+Pj4+PiBjb21waWxlIHRp
bWUuIFRoYXQgd2F5IG9ubHkgb25lIGltcGxlbWVudGF0aW9uIHJlbWFpbnMgZHVlIHRvIGRlYWQg
Y29kZQ0KPj4+Pj4+IGVsaW1pbmF0aW9uLg0KPj4+Pj4NCj4+Pj4+IEFueSBjaGFuY2Ugd2UgY2Fu
IHVzZSBhIGZsZXhpYmxlLWFycmF5IGluIHN0cnVjdCBleHRlbnRfYnVmZmVyIGluc3RlYWQsDQo+
Pj4+PiBzbyBhbGwgdGhlIHdhcm5pbmdzIGFyZSByZW1vdmVkPw0KPj4+Pj4NCj4+Pj4+IFNvbWV0
aGluZyBsaWtlIHRoaXM6DQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2V4dGVu
dF9pby5oIGIvZnMvYnRyZnMvZXh0ZW50X2lvLmgNCj4+Pj4+IGluZGV4IDYyMDI3ZjU1MWI0NC4u
YjgyZThiNjk0YTNiIDEwMDY0NA0KPj4+Pj4gLS0tIGEvZnMvYnRyZnMvZXh0ZW50X2lvLmgNCj4+
Pj4+ICsrKyBiL2ZzL2J0cmZzL2V4dGVudF9pby5oDQo+Pj4+PiBAQCAtOTQsMTEgKzk0LDExIEBA
IHN0cnVjdCBleHRlbnRfYnVmZmVyIHsNCj4+Pj4+DQo+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqAg
c3RydWN0IHJ3X3NlbWFwaG9yZSBsb2NrOw0KPj4+Pj4NCj4+Pj4+IC3CoMKgwqDCoMKgwqAgc3Ry
dWN0IHBhZ2UgKnBhZ2VzW0lOTElORV9FWFRFTlRfQlVGRkVSX1BBR0VTXTsNCj4+Pj4+ICAgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbGlzdF9oZWFkIHJlbGVhc2VfbGlzdDsNCj4+Pj4+ICAgwqAg
I2lmZGVmIENPTkZJR19CVFJGU19ERUJVRw0KPj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBsaXN0X2hlYWQgbGVha19saXN0Ow0KPj4+Pj4gICDCoCAjZW5kaWYNCj4+Pj4+ICvCoMKgwqDC
oMKgwqAgc3RydWN0IHBhZ2UgKnBhZ2VzW107DQo+Pj4+PiAgIMKgIH07DQo+Pj4+DQo+Pj4+IEJ1
dCB3b3VsZG4ndCB0aGF0IG1ha2UgdGhlIHRoZSBzaXplIG9mIGV4dGVudF9idWZmZXIgc3RydWN0
dXJlIGNoYW5nZQ0KPj4+PiBhbmQgYWZmZWN0IHRoZSBrbWVtIGNhY2hlIGZvciBpdD8NCj4+Pg0K
Pj4+IENvdWxkIHlvdSBwbGVhc2UgcG9pbnQgb3V0IHRoZSBwbGFjZXMgaW4gdGhlIGNvZGUgdGhh
dCB3b3VsZCBiZQ0KPj4+IGFmZmVjdGVkPw0KPj4NCj4+IFN1cmUsIHRoZSBkaXJlY3QgY29kZSBn
ZXQgYWZmZWN0ZWQgaXMgaGVyZToNCj4+DQo+PiBleHRlbnRfaW8uYzoNCj4+IGludCBfX2luaXQg
ZXh0ZW50X2lvX2luaXQodm9pZCkNCj4+IHsNCj4+ICAgICAgICAgIGV4dGVudF9idWZmZXJfY2Fj
aGUgPSBrbWVtX2NhY2hlX2NyZWF0ZSgiYnRyZnNfZXh0ZW50X2J1ZmZlciIsDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVjdCBleHRlbnRfYnVmZmVyKSwgMCwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICBTTEFCX01FTV9TUFJFQUQsIE5VTEwpOw0KPj4NCj4+IFNv
IGhlcmUgd2UgY2FuIG5vIGxvbmdlciB1c2Ugc2l6ZW9mKHN0cnVjdCBleHRlbnRfYnVmZmVyKTsN
Cj4+DQo+PiBGdXJ0aGVybW9yZSwgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgYXQgYnRyZnMgbW9k
dWxlIGxvYWQgdGltZSwNCj4+IGF0IHRoYXQgdGltZSB3ZSBoYXZlIG5vIGlkZWEgaG93IGxhcmdl
IHRoZSBleHRlbnQgYnVmZmVyIGNvdWxkIGJlLCB0aHVzIHdlDQo+PiBtdXN0IGFsbG9jYXRlIGEg
bGFyZ2UgZW5vdWdoIGNhY2hlIGZvciBleHRlbnQgYnVmZmVyLg0KPj4NCj4+IFRodXMgdGhlIHNp
emUgd2lsbCBiZSBmaXhlZCB0byB0aGUgY3VycmVudCBzaXplLCBubyBtYXR0ZXIgaWYgd2UgdXNl
IGZsZXgNCj4+IGFycmF5IG9yIG5vdC4NCj4+DQo+PiBUaG91Z2ggSSdtIG5vdCBzdXJlIGlmIHVz
aW5nIHN1Y2ggZmxleCBhcnJheSB3aXRoIGZpeGVkIHJlYWwgc2l6ZSBjYW4gc2lsZW50DQo+PiB0
aGUgd2FybmluZyB0aG91Z2guDQo+IA0KPiBZZWFoOyBJIHRoaW5rIHRoaXMgbWlnaHQgYmUgdGhl
IHJpZ2h0IHNvbHV0aW9uOg0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2V4dGVudF9pby5j
IGIvZnMvYnRyZnMvZXh0ZW50X2lvLmMNCj4gaW5kZXggOWU4MWQyNWRlYTcwLi40Y2YwYjcyZmRk
OWYgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2V4dGVudF9pby5jDQo+ICsrKyBiL2ZzL2J0cmZz
L2V4dGVudF9pby5jDQo+IEBAIC0yMzIsOCArMjMyLDkgQEAgaW50IF9faW5pdCBleHRlbnRfc3Rh
dGVfY2FjaGVfaW5pdCh2b2lkKQ0KPiAgIGludCBfX2luaXQgZXh0ZW50X2lvX2luaXQodm9pZCkN
Cj4gICB7DQo+ICAgICAgICAgIGV4dGVudF9idWZmZXJfY2FjaGUgPSBrbWVtX2NhY2hlX2NyZWF0
ZSgiYnRyZnNfZXh0ZW50X2J1ZmZlciIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHNpemVv
ZihzdHJ1Y3QgZXh0ZW50X2J1ZmZlciksIDAsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIFNM
QUJfTUVNX1NQUkVBRCwgTlVMTCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdF9z
aXplKChzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqKTAsIHBhZ2VzLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJTkxJTkVfRVhURU5UX0JVRkZFUl9QQUdFUyksDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIDAsIFNMQUJfTUVNX1NQUkVBRCwgTlVMTCk7DQo+ICAgICAgICAg
IGlmICghZXh0ZW50X2J1ZmZlcl9jYWNoZSkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVO
T01FTTsNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9leHRlbnRfaW8uaCBiL2ZzL2J0cmZz
L2V4dGVudF9pby5oDQo+IGluZGV4IDYyMDI3ZjU1MWI0NC4uYjgyZThiNjk0YTNiIDEwMDY0NA0K
PiAtLS0gYS9mcy9idHJmcy9leHRlbnRfaW8uaA0KPiArKysgYi9mcy9idHJmcy9leHRlbnRfaW8u
aA0KPiBAQCAtOTQsMTEgKzk0LDExIEBAIHN0cnVjdCBleHRlbnRfYnVmZmVyIHsNCj4gDQo+ICAg
ICAgICAgIHN0cnVjdCByd19zZW1hcGhvcmUgbG9jazsNCj4gDQo+IC0gICAgICAgc3RydWN0IHBh
Z2UgKnBhZ2VzW0lOTElORV9FWFRFTlRfQlVGRkVSX1BBR0VTXTsNCj4gICAgICAgICAgc3RydWN0
IGxpc3RfaGVhZCByZWxlYXNlX2xpc3Q7DQo+ICAgI2lmZGVmIENPTkZJR19CVFJGU19ERUJVRw0K
PiAgICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkIGxlYWtfbGlzdDsNCj4gICAjZW5kaWYNCj4gKyAg
ICAgICBzdHJ1Y3QgcGFnZSAqcGFnZXNbXTsNCj4gICB9Ow0KPiANCj4gICAvKg0KPiANCj4gDQo+
IEkgc2VlIHplcm8gd2FybmluZ3MgYnkgYnVpbGRpbmcgd2l0aA0KPiBtYWtlIEFSQ0g9cG93ZXJw
YyBDUk9TU19DT01QSUxFPXBvd2VycGM2NC1saW51eC1nbnUtIHBwYzY0X2RlZmNvbmZpZw0KPiAN
Cj4gYW5kIC1XYXJyYXktYm91bmRzIGVuYWJsZWQgYnkgZGVmYXVsdDoNCj4gDQo+IGRpZmYgLS1n
aXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlDQo+IGluZGV4IGMyY2MyZmEyODUyNS4uMzEwNDUyMTE5
YWI1IDEwMDY0NA0KPiAtLS0gYS9NYWtlZmlsZQ0KPiArKysgYi9NYWtlZmlsZQ0KPiBAQCAtMTA2
OCw3ICsxMDY4LDYgQEAgS0JVSUxEX0NGTEFHUyArPSAkKGNhbGwgY2MtZGlzYWJsZS13YXJuaW5n
LCBzdHJpbmdvcC10cnVuY2F0aW9uKQ0KPiANCj4gICAjIFdlJ2xsIHdhbnQgdG8gZW5hYmxlIHRo
aXMgZXZlbnR1YWxseSwgYnV0IGl0J3Mgbm90IGdvaW5nIGF3YXkgZm9yIDUuNyBhdCBsZWFzdA0K
PiAgIEtCVUlMRF9DRkxBR1MgKz0gJChjYWxsIGNjLWRpc2FibGUtd2FybmluZywgemVyby1sZW5n
dGgtYm91bmRzKQ0KPiAtS0JVSUxEX0NGTEFHUyArPSAkKGNhbGwgY2MtZGlzYWJsZS13YXJuaW5n
LCBhcnJheS1ib3VuZHMpDQo+ICAgS0JVSUxEX0NGTEFHUyArPSAkKGNhbGwgY2MtZGlzYWJsZS13
YXJuaW5nLCBzdHJpbmdvcC1vdmVyZmxvdykNCj4gDQo+ICAgIyBBbm90aGVyIGdvb2Qgd2Fybmlu
ZyB0aGF0IHdlJ2xsIHdhbnQgdG8gZW5hYmxlIGV2ZW50dWFsbHkNCj4gDQo+IERvIHlvdSB0aGlu
ayB0aGVyZSBpcyBhbnkgb3RoZXIgcGxhY2Ugd2hlcmUgd2Ugc2hvdWxkIHVwZGF0ZQ0KPiB0aGUg
dG90YWwgc2l6ZSBmb3IgZXh0ZW50X2J1ZmZlcj8NCg0KTm9wZSwgdGhhdCBzaG91bGQgYmUgZW5v
dWdoLg0KDQpUaGFua3MsDQpRdQ0KPiANCj4gLS0NCj4gR3VzdGF2bw0KPiANCj4gDQo+Pg0KPj4g
VGhhbmtzLA0KPj4gUXUNCj4+Pg0KPj4+IEknbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCB0aGlzIGNv
ZGUgYW5kIHNlZSB0aGUgcG9zc2liaWxpdHkgb2YNCj4+PiB1c2luZyBhIGZsZXgtYXJyYXkgdG9n
ZXRoZXIgd2l0aCBwcm9wZXIgbWVtb3J5IGFsbG9jYXRpb24sIHNvDQo+Pj4gd2UgY2FuIGF2b2lk
IGhhdmluZyBvbmUtZWxlbWVudCBhcnJheSBpbiBleHRlbnRfYnVmZmVyLg0KPj4+DQo+Pj4gTm90
IHN1cmUgYXQgd2hhdCBleHRlbnQgdGhpcyB3b3VsZCBiZSBwb3NzaWJsZS4gU28sIGFueSBwb2lu
dGVyDQo+Pj4gaXMgZ3JlYXRseSBhcHByZWNpYXRlIGl0LiA6KQ0KPj4+DQo+Pj4gVGhhbmtzDQo+
Pj4gLS0NCj4+PiBHdXN0YXZvDQo+Pj4NCj4+Pj4NCj4+Pj4gVGhhbmtzLA0KPj4+PiBRdQ0KPj4+
Pj4NCj4+Pj4+ICAgwqAgLyoNCj4+Pj4+DQo+Pj4+PiB3aGljaCBpcyBhY3R1YWxseSB3aGF0IGlz
IG5lZWRlZCBpbiB0aGlzIGNhc2UgdG8gc2lsZW5jZSB0aGUNCj4+Pj4+IGFycmF5LWJvdW5kcyB3
YXJuaW5nczogdGhlIHJlcGxhY2VtZW50IG9mIHRoZSBvbmUtZWxlbWVudCBhcnJheQ0KPj4+Pj4g
d2l0aCBhIGZsZXhpYmxlLWFycmF5IG1lbWJlclsxXSBpbiBzdHJ1Y3QgZXh0ZW50X2J1ZmZlci4N
Cj4+Pj4+DQo+Pj4+PiAtLSANCj4+Pj4+IEd1c3Rhdm8NCj4+Pj4+DQo+Pj4+PiBbMV0gaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92NS4xMC9wcm9jZXNzL2RlcHJlY2F0ZWQuaHRtbCN6
ZXJvLWxlbmd0aC1hbmQtb25lLWVsZW1lbnQtYXJyYXlzDQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDYyMzA4MzkwMS4xZDQ5ZDE5
ZEBjYW5iLmF1dWcub3JnLmF1Lw0KPj4+Pj4+IENDOiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0
YXZvYXJzQGtlcm5lbC5vcmc+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgU3RlcmJhIDxk
c3RlcmJhQHN1c2UuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICAgwqAgZnMvYnRyZnMvc3RydWN0
LWZ1bmNzLmMgfCA2NiArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4+Pj4+ICAgwqAgMSBmaWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9u
cygtKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3N0cnVjdC1mdW5jcy5j
IGIvZnMvYnRyZnMvc3RydWN0LWZ1bmNzLmMNCj4+Pj4+PiBpbmRleCA4MjYwZjhiYjNmZjAuLjUx
MjA0YjI4MGRhOCAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9mcy9idHJmcy9zdHJ1Y3QtZnVuY3MuYw0K
Pj4+Pj4+ICsrKyBiL2ZzL2J0cmZzL3N0cnVjdC1mdW5jcy5jDQo+Pj4+Pj4gQEAgLTczLDE0ICs3
MywxOCBAQCB1IyNiaXRzIGJ0cmZzX2dldF90b2tlbl8jI2JpdHMoc3RydWN0IGJ0cmZzX21hcF90
b2tlbiAqdG9rZW4swqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICAgwqDCoMKgwqDCoCB9wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XA0KPj4+Pj4+ICAgwqDCoMKgwqDCoCB0b2tlbi0+a2FkZHIgPSBwYWdlX2FkZHJlc3ModG9rZW4t
PmViLT5wYWdlc1tpZHhdKTvCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gICDCoMKgwqDCoMKgIHRv
a2VuLT5vZmZzZXQgPSBpZHggPDwgUEFHRV9TSElGVDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXA0KPj4+Pj4+IC3CoMKgwqAgaWYgKG9pcCArIHNpemUgPD0gUEFHRV9TSVpFKcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgIGlmIChJ
TkxJTkVfRVhURU5UX0JVRkZFUl9QQUdFUyA9PSAxKSB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFwNCj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZ2V0X3VuYWxpZ25l
ZF9sZSMjYml0cyh0b2tlbi0+a2FkZHIgKyBvaXApO8KgwqDCoCBcDQo+Pj4+Pj4gK8KgwqDCoCB9
IGVsc2Uge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBcDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChvaXAgKyBzaXplIDw9IFBBR0VfU0la
RSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBnZXRfdW5hbGlnbmVkX2xlIyNiaXRzKHRva2VuLT5rYWRkciArIG9p
cCk7IFwNCj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAtwqDCoMKgIG1lbWNw
eShsZWJ5dGVzLCB0b2tlbi0+a2FkZHIgKyBvaXAsIHBhcnQpO8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXA0KPj4+Pj4+IC3CoMKgwqAgdG9rZW4tPmthZGRyID0gcGFnZV9hZGRyZXNzKHRva2VuLT5l
Yi0+cGFnZXNbaWR4ICsgMV0pO8KgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAtwqDCoMKgIHRva2Vu
LT5vZmZzZXQgPSAoaWR4ICsgMSkgPDwgUEFHRV9TSElGVDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwNCj4+Pj4+PiAtwqDCoMKgIG1lbWNweShsZWJ5dGVzICsgcGFydCwgdG9rZW4tPmthZGRyLCBz
aXplIC0gcGFydCk7wqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+IC3CoMKgwqAgcmV0dXJuIGdldF91
bmFsaWduZWRfbGUjI2JpdHMobGVieXRlcyk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgbWVtY3B5KGxlYnl0ZXMsIHRva2VuLT5rYWRkciAr
IG9pcCwgcGFydCk7wqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB0b2tl
bi0+a2FkZHIgPSBwYWdlX2FkZHJlc3ModG9rZW4tPmViLT5wYWdlc1tpZHggKyAxXSk7wqDCoMKg
IFwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdG9rZW4tPm9mZnNldCA9IChpZHggKyAxKSA8PCBQ
QUdFX1NISUZUO8KgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgbWVtY3B5
KGxlYnl0ZXMgKyBwYXJ0LCB0b2tlbi0+a2FkZHIsIHNpemUgLSBwYXJ0KTvCoMKgwqAgXA0KPj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZ2V0X3VuYWxpZ25lZF9sZSMjYml0cyhsZWJ5dGVz
KTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgIH3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+
Pj4gICDCoCB9wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gICDCoCB1IyNiaXRzIGJ0cmZzX2dldF8j
I2JpdHMoY29uc3Qgc3RydWN0IGV4dGVudF9idWZmZXIgKmViLMKgwqDCoMKgwqDCoMKgIFwNCj4+
Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgdm9pZCAqcHRyLCB1bnNp
Z25lZCBsb25nIG9mZinCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gQEAgLTk0LDEzICs5OCwxNyBA
QCB1IyNiaXRzIGJ0cmZzX2dldF8jI2JpdHMoY29uc3Qgc3RydWN0IGV4dGVudF9idWZmZXIgKmVi
LMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAgIMKgwqDCoMKgwqAgdTggbGVieXRlc1tzaXplb2Yo
dSMjYml0cyldO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+
PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAgIMKgwqDCoMKgwqAgQVNTRVJUKGNoZWNr
X3NldGdldF9ib3VuZHMoZWIsIHB0ciwgb2ZmLCBzaXplKSk7wqDCoMKgwqDCoMKgwqAgXA0KPj4+
Pj4+IC3CoMKgwqAgaWYgKG9pcCArIHNpemUgPD0gUEFHRV9TSVpFKcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgIGlmIChJTkxJTkVfRVhURU5U
X0JVRkZFUl9QQUdFUyA9PSAxKSB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+
Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZ2V0X3VuYWxpZ25lZF9sZSMjYml0cyhr
YWRkciArIG9pcCk7wqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICvCoMKgwqAgfSBlbHNlIHvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAob2lwICsgc2l6ZSA8PSBQQUdFX1NJWkUpwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gZ2V0X3VuYWxpZ25lZF9sZSMjYml0cyhrYWRkciArIG9pcCk7wqDCoMKgIFwNCj4+Pj4+
PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAtwqDCoMKgIG1lbWNweShsZWJ5dGVzLCBr
YWRkciArIG9pcCwgcGFydCk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+
PiAtwqDCoMKgIGthZGRyID0gcGFnZV9hZGRyZXNzKGViLT5wYWdlc1tpZHggKyAxXSk7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gLcKgwqDCoCBtZW1jcHkobGVieXRlcyArIHBhcnQs
IGthZGRyLCBzaXplIC0gcGFydCk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gLcKg
wqDCoCByZXR1cm4gZ2V0X3VuYWxpZ25lZF9sZSMjYml0cyhsZWJ5dGVzKTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBtZW1jcHkobGVieXRl
cywga2FkZHIgKyBvaXAsIHBhcnQpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCBrYWRkciA9IHBhZ2VfYWRkcmVzcyhlYi0+cGFnZXNbaWR4ICsgMV0pO8Kg
wqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgbWVtY3B5KGxlYnl0ZXMgKyBw
YXJ0LCBrYWRkciwgc2l6ZSAtIHBhcnQpO8KgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIGdldF91bmFsaWduZWRfbGUjI2JpdHMobGVieXRlcyk7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gK8KgwqDCoCB9wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICAgwqAgfcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICAgwqAgdm9pZCBidHJmc19zZXRfdG9rZW5fIyNiaXRzKHN0
cnVjdCBidHJmc19tYXBfdG9rZW4gKnRva2VuLMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgdm9pZCAqcHRyLCB1bnNpZ25l
ZCBsb25nIG9mZizCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gQEAgLTEyNCwxNSArMTMyLDE5IEBA
IHZvaWQgYnRyZnNfc2V0X3Rva2VuXyMjYml0cyhzdHJ1Y3QgYnRyZnNfbWFwX3Rva2VuICp0b2tl
bizCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gICDCoMKgwqDCoMKgIH3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4g
ICDCoMKgwqDCoMKgIHRva2VuLT5rYWRkciA9IHBhZ2VfYWRkcmVzcyh0b2tlbi0+ZWItPnBhZ2Vz
W2lkeF0pO8KgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAgIMKgwqDCoMKgwqAgdG9rZW4tPm9mZnNl
dCA9IGlkeCA8PCBQQUdFX1NISUZUO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+
Pj4+Pj4gLcKgwqDCoCBpZiAob2lwICsgc2l6ZSA8PSBQQUdFX1NJWkUpIHvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gK8KgwqDCoCBpZiAoSU5MSU5FX0VY
VEVOVF9CVUZGRVJfUEFHRVMgPT0gMSkge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBc
DQo+Pj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgcHV0X3VuYWxpZ25lZF9sZSMjYml0cyh2YWws
IHRva2VuLT5rYWRkciArIG9pcCk7wqDCoMKgIFwNCj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0
dXJuO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBcDQo+Pj4+Pj4gK8KgwqDCoCB9IGVsc2Uge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChv
aXAgKyBzaXplIDw9IFBBR0VfU0laRSkge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBc
DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHV0X3VuYWxpZ25lZF9sZSMjYml0cyh2
YWwsIHRva2VuLT5rYWRkciArIG9pcCk7IFwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm47wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBc
DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBwdXRfdW5h
bGlnbmVkX2xlIyNiaXRzKHZhbCwgbGVieXRlcyk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG1lbWNweSh0b2tlbi0+a2FkZHIgKyBvaXAsIGxlYnl0ZXMs
IHBhcnQpO8KgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdG9rZW4tPmth
ZGRyID0gcGFnZV9hZGRyZXNzKHRva2VuLT5lYi0+cGFnZXNbaWR4ICsgMV0pO8KgwqDCoCBcDQo+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHRva2VuLT5vZmZzZXQgPSAoaWR4ICsgMSkgPDwgUEFHRV9T
SElGVDvCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG1lbWNweSh0b2tl
bi0+a2FkZHIsIGxlYnl0ZXMgKyBwYXJ0LCBzaXplIC0gcGFydCk7wqDCoMKgIFwNCj4+Pj4+PiAg
IMKgwqDCoMKgwqAgfcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAtwqDCoMKgIHB1dF91bmFsaWduZWRfbGUjI2Jp
dHModmFsLCBsZWJ5dGVzKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+
IC3CoMKgwqAgbWVtY3B5KHRva2VuLT5rYWRkciArIG9pcCwgbGVieXRlcywgcGFydCk7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gLcKgwqDCoCB0b2tlbi0+a2FkZHIgPSBwYWdlX2Fk
ZHJlc3ModG9rZW4tPmViLT5wYWdlc1tpZHggKyAxXSk7wqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+
IC3CoMKgwqAgdG9rZW4tPm9mZnNldCA9IChpZHggKyAxKSA8PCBQQUdFX1NISUZUO8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+IC3CoMKgwqAgbWVtY3B5KHRva2VuLT5rYWRkciwgbGVi
eXRlcyArIHBhcnQsIHNpemUgLSBwYXJ0KTvCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gICDCoCB9
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gICDCoCB2b2lkIGJ0cmZzX3NldF8jI2JpdHMoY29uc3Qg
c3RydWN0IGV4dGVudF9idWZmZXIgKmViLCB2b2lkICpwdHIswqDCoMKgIFwNCj4+Pj4+PiAgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIG9mZiwgdSMjYml0cyB2
YWwpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gQEAgLTE0NiwxNSArMTU4LDE5IEBA
IHZvaWQgYnRyZnNfc2V0XyMjYml0cyhjb25zdCBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIsIHZv
aWQgKnB0cizCoMKgwqAgXA0KPj4+Pj4+ICAgwqDCoMKgwqDCoCB1OCBsZWJ5dGVzW3NpemVvZih1
IyNiaXRzKV07wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+
ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICAgwqDCoMKgwqDCoCBBU1NFUlQoY2hlY2tf
c2V0Z2V0X2JvdW5kcyhlYiwgcHRyLCBvZmYsIHNpemUpKTvCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+
Pj4gLcKgwqDCoCBpZiAob2lwICsgc2l6ZSA8PSBQQUdFX1NJWkUpIHvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gK8KgwqDCoCBpZiAoSU5MSU5FX0VYVEVO
VF9CVUZGRVJfUEFHRVMgPT0gMSkge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+
Pj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgcHV0X3VuYWxpZ25lZF9sZSMjYml0cyh2YWwsIGth
ZGRyICsgb2lwKTvCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVy
bjvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XA0KPj4+Pj4+IC3CoMKgwqAgfcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgIH0gZWxzZSB7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKG9pcCArIHNpemUgPD0gUEFHRV9TSVpFKSB7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
dXRfdW5hbGlnbmVkX2xlIyNiaXRzKHZhbCwga2FkZHIgKyBvaXApO8KgwqDCoCBcDQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAg
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAtwqDCoMKgIHB1dF91bmFsaWduZWRfbGUjI2Jp
dHModmFsLCBsZWJ5dGVzKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+
IC3CoMKgwqAgbWVtY3B5KGthZGRyICsgb2lwLCBsZWJ5dGVzLCBwYXJ0KTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+IC3CoMKgwqAga2FkZHIgPSBwYWdlX2FkZHJlc3Mo
ZWItPnBhZ2VzW2lkeCArIDFdKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiAtwqDC
oMKgIG1lbWNweShrYWRkciwgbGVieXRlcyArIHBhcnQsIHNpemUgLSBwYXJ0KTvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcHV0X3VuYWxpZ25lZF9sZSMj
Yml0cyh2YWwsIGxlYnl0ZXMpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBtZW1jcHkoa2FkZHIgKyBvaXAsIGxlYnl0ZXMsIHBhcnQpO8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBrYWRkciA9IHBhZ2VfYWRkcmVz
cyhlYi0+cGFnZXNbaWR4ICsgMV0pO8KgwqDCoMKgwqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgbWVtY3B5KGthZGRyLCBsZWJ5dGVzICsgcGFydCwgc2l6ZSAtIHBhcnQpO8KgwqDCoMKg
wqDCoMKgIFwNCj4+Pj4+PiArwqDCoMKgIH3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+Pj4+Pj4gICDCoCB9DQo+Pj4+Pj4N
Cj4+Pj4+PiAgIMKgIERFRklORV9CVFJGU19TRVRHRVRfQklUUyg4KQ0KPj4+Pj4+IC0tIA0KPj4+
Pj4+IDIuMzEuMQ0KPj4+Pj4+DQo=
