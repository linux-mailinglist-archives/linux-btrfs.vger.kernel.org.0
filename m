Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F75127BDC
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 14:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLTNlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 08:41:05 -0500
Received: from nwxsbs11.networkx.de ([217.91.82.83]:24300 "EHLO
        nwxsbs11.networkx.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfLTNlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 08:41:05 -0500
Received: from NWXSBS11.networkx.de ([fe80::4091:24d0:23e7:9e44]) by
 NWXSBS11.networkx.de ([fe80::4091:24d0:23e7:9e44%14]) with mapi id
 14.03.0468.000; Fri, 20 Dec 2019 14:38:45 +0100
From:   Ralf Zerres <Ralf.Zerres@networkx.de>
To:     "andrea.gelmini@gmail.com" <andrea.gelmini@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "quwenruo.btrfs@gmx.com" <quwenruo.btrfs@gmx.com>
Subject: Re: How to heel this btrfs fi corruption?
Thread-Topic: How to heel this btrfs fi corruption?
Thread-Index: AdW2puxRpbYJ6wGOS3W1/yTrAS6zvAATB0uAAAumBoAAAuDcAAABY/2A
Date:   Fri, 20 Dec 2019 13:38:44 +0000
Message-ID: <f7e605c02edc406a9f11472ccbde6fdc5d37cda9.camel@networkx.de>
References: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
         <CAK-xaQbGiO=b3XFS929DFcG=B3fsuT7AAFKLSaECaXbgUyZqzw@mail.gmail.com>
In-Reply-To: <CAK-xaQbGiO=b3XFS929DFcG=B3fsuT7AAFKLSaECaXbgUyZqzw@mail.gmail.com>
Reply-To: Ralf Zerres <Ralf.Zerres@networkx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.2 
x-originating-ip: [89.1.209.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <059B392BC7846F489CFE58E203FBB602@networkx.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

QW0gRnJlaXRhZywgZGVuIDIwLjEyLjIwMTksIDE0OjAxICswMTAwIHNjaHJpZWIgQW5kcmVhIEdl
bG1pbmk6DQo+IA0KPiBJbCB2ZW4gMjAgZGljIDIwMTksIDEyOjQwIFJhbGYgWmVycmVzIDxSYWxm
LlplcnJlc0BuZXR3b3JreC5kZT4gaGENCj4gc2NyaXR0bzoNCj4gDQo+IA0KPiA+IFdlbGwsIGkg
ZG8gZXhwZWN0IDUuNC4wIHRvIGJlIGVxdWFsbHkgdmFsaWQuIFRvIGJhZCB0aGF0IHRoZXJlIGlz
DQo+ID4gbm8NCj4gPiBvZmZpY2lhbCBiYWNrcG9ydCBmb3IgVWJ1bnR1IHN0YWJsZSAoYWthIDE4
LjA0LngpDQo+ID4gDQo+ID4gVXNlIHRoaXM6DQo+IA0KPiBodHRwczovL2tlcm5lbC51YnVudHUu
Y29tL35rZXJuZWwtcHBhL21haW5saW5lLw0KDQpUaGFua3MgZm9yIHRoZSBsaW5rLiBUaGF0IGlz
IGV4YWN0bHkgd2hlcmUgaSBkbyBwdWxsIHRoZSBrZXJuZWxzIC4uLg0KPiBJIHVzZSBpdCBzaW5j
ZSB5ZWFyIGluIHByb2R1Y3Rpb24uDQo+IA0KPiBBbHNvLCBteSBwZXJzb25hbCBwb2ludCBvZiB2
aWV3LCBRdSBhbmQgRmFjZWJvb2sgZ3V5cyBhcmUgZG9pbmcNCj4gaW5jcmVkaWJpbGUgd29yayBh
bmQgaW1wcm92ZW1lbnQgb24gYnRyZnMuIEJ1dCBJIGRvbid0IGZlZWwNCj4gY29tZm9ydGFibGUg
dG8gdXNlIEl0IGluIHByb2R1Y3Rpb24uIEl0J3Mgc3RpbGwgdG9vIGVhcmx5Lg0KPiANCg0KWWVz
LCB0aGUgaW1wcm92ZW1lbnQgaXMgc2VlbiBpbiBldmVyeSB2ZXJzaW9uIGFuZCB2ZXJ5IG11Y2gN
CmFwcHJlY2lhdGVkLiANCkJ1dCBiZSBmYWlyLCBpZiB5b3UgdXNlIGJ0cmZzIGFzIGFkdmVydGlz
ZWQgKFJhaWQxIG9yIFJhaWQwLCBubw0KZ2lnYW50aWMgcWdyb3VwIGRlcGVuZGVuY2llcywgcmVh
c29uYWJsZSBhbW91bnQgb2Ygc25hcHNob3RzIHByZXINCnN1YnZvbHVtZXMgKDwgNjQpDQp0aGUg
ZmlsZXN5c3RlbSBpcyBzdGFibGUuIEknbSBydW5uaW5nIGl0IHNpbmNlIDJ5ZWFycyBpbiBwcm9k
dWN0aW9uDQplbnZpcm9ubWVudC4NCg0KPiBDaWFvLA0KPiBHZWxtYQ0KPiANCg0KanVzdCBteSB0
d28gY29pbnMgLi4uDQpSYWxmDQo=
