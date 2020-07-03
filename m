Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA42134B4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 09:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgGCHN3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 03:13:29 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:49194 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCHN2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jul 2020 03:13:28 -0400
Received: from fe0vm1650.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 49ymQX6V4cz1XLm4H;
        Fri,  3 Jul 2020 09:13:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rs.bosch.com;
        s=key1-intmail; t=1593760404;
        bh=lwdBTjrkigbqwL5cXQXvdSyAWgYAqpK4bCVvC2a9wgA=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=Ltdyc/1HoW6CbVAr+vveiRKRacB5G0TbX4rHTnAppDAgRxXnsEfYlVql/qKekmT6c
         q/wM07i4swzeN4/T9MqQpNOv3LKbNzIzPSvxrewOEBlldpPIEinpWpOxjydcKyzkKt
         ONLXbNfBznVHswmaLYDRRHMZ3xGsqFU+XxLGHfK0=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 49ymQX68Srz1y4;
        Fri,  3 Jul 2020 09:13:24 +0200 (CEST)
X-AuditID: 0a3aad14-e0fff70000003b75-e8-5efeda940617
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 28.71.15221.49ADEFE5; Fri,  3 Jul 2020 09:13:24 +0200 (CEST)
Received: from FE-MBX2028.de.bosch.com (fe-mbx2028.de.bosch.com [10.3.231.38])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 49ymQX4pZZz6CjZP2;
        Fri,  3 Jul 2020 09:13:24 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (10.3.231.39) by
 FE-MBX2028.de.bosch.com (10.3.231.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Fri, 3 Jul 2020 09:13:24 +0200
Received: from FE-MBX2029.de.bosch.com ([fe80::c815:e4fb:f7f:69ab]) by
 FE-MBX2029.de.bosch.com ([fe80::c815:e4fb:f7f:69ab%3]) with mapi id
 15.01.1979.003; Fri, 3 Jul 2020 09:13:24 +0200
From:   "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: FIEMAP ioctl gets "wrong" address for the extent
Thread-Topic: FIEMAP ioctl gets "wrong" address for the extent
Thread-Index: AdZQUL8TC28qUku1QeuTriBPGQAMhf//8VEA///XotCAADnzAP/+kpBQ
Date:   Fri, 3 Jul 2020 07:13:24 +0000
Message-ID: <8bce872d6fbe41d7a987e93aa1f1a77a@rs.bosch.com>
References: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
 <1d41a247-a4f7-124a-4842-f7d886e9aa70@gmx.com>
 <c3b2c46ca5314285a79536cb3c233e1b@rs.bosch.com>
 <a18bcf27-4c65-6033-0ea7-45da2b521864@gmx.com>
In-Reply-To: <a18bcf27-4c65-6033-0ea7-45da2b521864@gmx.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.68.130]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsXCZbVWVnfKrX9xBo+u6FpceryC3WJx9xsW
        ByaPu/cXMnl83iQXwBTFZZOSmpNZllqkb5fAlfHg1XbWgh3aFfeunWNpYFyh1cXIySEhYCKx
        6Pldli5GLg4hgRlMEg0/bjJBOPsYJX4uP8IKUiUk8IZR4sgdRYjEXkaJwyv3M4Mk2AScJc5f
        XAxmiwikSlzbvZMRxBYWsJVYPuknC0TcTuJI/3JGCNtN4v/ivWA2i4CKxPm/X4EWcHDwClhL
        XH5jCDH/PKPEzcvP2UFqOIHiTWtmgNUzCshKdDa8YwKxmQXEJW49mc8E8YKAxJI955khbFGJ
        l4//sULYihLbTx9mB5nPLKApsX6XPkSrosSU7odg43kFBCVOznzCMoFRbBaSqbMQOmYh6ZiF
        pGMBI8sqRtG0VIOyXENzEwO9oqTU4ioDQ73k/NxNjJDoEdnBeLLng94hRiYOxkOMEhzMSiK8
        Car/4oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzqvBsjBMSSE8sSc1OTS1ILYLJMnFwSjUwZXJ3
        pL98wL6o3lNfQWi/m1JS5pc/gu03E9Vm3TiyySXzsoDDhurMH3YRl7dnNU+Lfun6QJTpvvH6
        KuVLXx58mh3Df2NtPa+m0ukkgUt7LoYZfdKeV6DKNEV0zVKGG9M5T+1jbjD8fXLb3bi0aVMr
        Q1UNcm6ovPt1RWNNzCvFkp2rJ0UKdawq6XNYWXw0VbzevyiOs7ZLUE92XcG1I1+7csxV30as
        rnLqucbElqf79LFq3tQb//83ub0oFsldfSg5SXqqHIOW1xk9RYYP0oHzmTmubpwUEHPR/Ou5
        eLl1M7xPrP/g6rfHkrNGLfqzRXZa6A4bnxv5Px2esZvOvpj89H9+o6zI1Xkmyvmbfy1TYinO
        SDTUYi4qTgQADp2FDQ0DAAA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

VGhhbmtzIGEgbG90IFF1IGZvciB0aGlzIGNsYXJpZmljYXRpb24sIEkgd2FzIG5vdCBhd2FyZSBv
ZiBpdC4NCg0KQ2hlZXJzLA0KRGVqYW4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogUXUgV2VucnVvIDxxdXdlbnJ1by5idHJmc0BnbXguY29tPiANClNlbnQ6IMSNZXR2cnRh
aywgMDIuIGp1bCAyMDIwLiAxMzoyMg0KVG86IFJlYnJhY2EgRGVqYW4gKEJTT1QvUEotRVMxLUJn
KSA8RGVqYW4uUmVicmFjYUBycy5ib3NjaC5jb20+OyBsaW51eC1idHJmc0B2Z2VyLmtlcm5lbC5v
cmcNClN1YmplY3Q6IFJlOiBGSUVNQVAgaW9jdGwgZ2V0cyAid3JvbmciIGFkZHJlc3MgZm9yIHRo
ZSBleHRlbnQNCg0KDQoNCk9uIDIwMjAvNy8yIOS4i+WNiDc6MDgsIFJlYnJhY2EgRGVqYW4gKEJT
T1QvUEotRVMxLUJnKSB3cm90ZToNCj4gSGkgUXUsDQo+IA0KPiBJJ20gdXNpbmcgdGhpcyBzdHJ1
Y3R1cmUgdG8gZ2V0IHRoZSBhZGRyZXNzIG9mIGZpbGUgZXh0ZW50Og0KPiANCj4gc3RydWN0IGZp
ZW1hcF9leHRlbnQgew0KPiAJX191NjQJZmVfbG9naWNhbDsgIC8qIGxvZ2ljYWwgb2Zmc2V0IGlu
IGJ5dGVzIGZvciB0aGUgc3RhcnQgb2YNCj4gCQkJICAgICAgKiB0aGUgZXh0ZW50ICovDQo+IAlf
X3U2NAlmZV9waHlzaWNhbDsgLyogcGh5c2ljYWwgb2Zmc2V0IGluIGJ5dGVzIGZvciB0aGUgc3Rh
cnQNCj4gCQkJICAgICAgKiBvZiB0aGUgZXh0ZW50ICovDQoNCmZlX3BoeXNpY2FsIGluIGJ0cmZz
IGlzIGJ0cmZzIGxvZ2ljYWwgYWRkcmVzcy4NCg0KPiAJX191NjQJZmVfbGVuZ3RoOyAgIC8qIGxl
bmd0aCBpbiBieXRlcyBmb3IgdGhlIGV4dGVudCAqLw0KPiAJX191NjQJZmVfcmVzZXJ2ZWQ2NFsy
XTsNCj4gCV9fdTMyCWZlX2ZsYWdzOyAgICAvKiBGSUVNQVBfRVhURU5UXyogZmxhZ3MgZm9yIHRo
aXMgZXh0ZW50ICovDQo+IAlfX3UzMglmZV9yZXNlcnZlZFszXTsNCj4gfTsNCj4gDQo+IEFuZCB1
c2luZyBmZV9waHlzaWNhbCBmaWVsZCBJIHZlcmlmaWVkIHRoYXQgaXQgcmVhbGx5IHJlZmxlY3Rz
IHRoZSBvZmZzZXQgaW4gZmlsZXN5c3RlbSBpbWFnZSAtIEkgY2FuIHNlZSB0aGF0IGZpbGUgY29u
dGVudCBiZWdpbnMgYXQgdGhpcyBvZmZzZXQuDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgSSBydW4g
aW50byBzb21lIHNwZWNpZmljIGNhc2Ugd2hlcmUgZmlsZSBjb250ZW50IGRvZXNuJ3QgYmVnaW4g
YXQgZmVfcGh5c2ljYWwsIEkgcmF0aGVyIGhhdmUgc29tZXRoaW5nIGVsc2UgYXQgdGhpcyBvZmZz
ZXQuDQoNCkFzIHNhaWQsIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IGJ0cmZzIGxvZ2ljYWwg
YWRkcmVzcyBpcyBtYXBwZWQgMToxIG9uIGRpc2suDQpJdCdzIHBvc3NpYmxlLCBidXQgbmV2ZXIg
Z3VhcmFudGVlZC4NCg0KWW91IG5lZWQgdG8gcGFzcyB0aGF0IGZlX3BoeXNpY2FsIG51bWJlciB0
byBidHJmcy1tYXAtbG9naWNhbCB0byBmaW5kIHRoZSByZWFsIG9uLWRpc2sgb2Zmc2V0Lg0KDQpU
aGFua3MsDQpRdQ0KDQoNCj4gDQo+IFRoYW5rcywNCj4gRGVqYW4NCj4gDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNv
bT4NCj4gU2VudDogxI1ldHZydGFrLCAwMi4ganVsIDIwMjAuIDEyOjE5DQo+IFRvOiBSZWJyYWNh
IERlamFuIChCU09UL1BKLUVTMS1CZykgPERlamFuLlJlYnJhY2FAcnMuYm9zY2guY29tPjsgDQo+
IGxpbnV4LWJ0cmZzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogRklFTUFQIGlvY3Rs
IGdldHMgIndyb25nIiBhZGRyZXNzIGZvciB0aGUgZXh0ZW50DQo+IA0KPiANCj4gDQo+IE9uIDIw
MjAvNy8yIOS4i+WNiDU6MTEsIFJlYnJhY2EgRGVqYW4gKEJTT1QvUEotRVMxLUJnKSB3cm90ZToN
Cj4+IEhpIGFsbCwNCj4+DQo+PiBJJ20gY29sbGVjdGluZyBmaWxlIGV4dGVudHMgZm9yIG91ciBh
cHBsaWNhdGlvbiBmcm9tIEJ0ckZzIGZpbGVzeXN0ZW0gaW1hZ2UuDQo+PiBJJ3ZlIG5vdGljZWQg
dGhhdCBmb3Igc29tZSBmaWxlcyBhIGdldCB0aGUgIndyb25nIiBwaHlzaWNhbCBvZmZzZXQgZm9y
IHN0YXJ0IG9mIHRoZSBleHRlbnQuDQo+IA0KPiBGaXJzdCB0aGluZyBmaXJzdCwgYnRyZnMgZmll
bWFwIGlvY3RsIG9ubHkgcmV0dXJucyBidHJmcyBsb2dpY2FsIGFkZHJlc3MuDQo+IFRoYXQncyBh
biBhZGRyZXNzIHNwYWNlIGluIFswLCBVNjRfTUFYKSwgdGh1cyBpdCdzIG5vdCBhIHBoeXNpY2Fs
IG9mZnNldCB5b3UgY2FuIGZpbmQgaW4gdGhlIGRldmljZS4NCj4gDQo+IEZvciBleGFtcGxlLCBm
b3IgYSBidHJmcyBvbiBhIDEwRyBkaXNrLCBidHJmcyBmaWVtYXAgY2FuIHJldHVybiBhZGRyZXNz
IGF0IDEyOEcsIHdoaWNoIHlvdSBjYW4gbmV2ZXIgZmluZCBvbiB0aGF0IGRpc2suDQo+IA0KPiBU
aGlzIGlzIG5vdCB0aGF0IHN0cmFuZ2UsIGFzIGJ0cmZzIGNhbiBiZSBhIG11bHRpLWRldmljZSBm
cywgdGh1cyB3ZSBtdXN0IGhhdmUgYW4gaW50ZXJuYWwgYWRkcmVzcyBzcGFjZSwgYW5kIHRoZW4g
bWFwIHBhcnQgb2YgdGhlIGxvZ2ljYWwgYWRkcmVzcyBpbnRvIHBoeXNpY2FsIGRpc2sgc3BhY2Uu
DQo+IA0KPj4gSSB2ZXJpZmllZCBpdCB1c2luZyBoZXhkdW1wIG9mIHRoZSBmaWxlc3lzdGVtIGlt
YWdlOiB3aGVuIGR1bXAgdGhlIGNvbnRlbnQgc3RhcnRpbmcgZnJvbSB0aGUgYWRkcmVzcyByZXR1
cm5lZCBmcm9tIEZJRU1BUCBpb2N0bCwgSSBzZWUgdGhhdCB0aGUgY29udGVudCBpcyBhYnNvbHV0
ZWx5IGRpZmZlcmVudCBmcm9tIHRoZSBjb250ZW50IG9mIHRoZSBmaWxlIGl0c2VsZi4gQWxzbywg
dGhlIEZJRU1BUCBpb2N0bCByZXBvcnRzIHJlZ3VsYXIgZXh0ZW50LCBpdCBpcyBub3QgaW5saW5l
Lg0KPiANCj4gSWYgeW91J3JlIHVzaW5nIHRoZSBsb2dpY2FsIGFkZHJlc3MgcmV0dXJuZWQgZnJv
bSBkaXNrIGRpcmVjdGx5LCB0aGVuIHlvdSB3b24ndCBnZXQgdGhlIGNvcnJlY3QgZGF0YSBvYnZp
b3VzbHkuDQo+IA0KPiBXaGF0IHlvdSBuZWVkIGlzIHRvIG1hcCB0aGUgYnRyZnMgbG9naWNhbCBh
ZGRyZXNzIHRvIHBoeXNpY2FsIGRldmljZSBvZmZzZXQsIHRoYXQgaXMgZG9uZSBieSByZWZlcnJp
bmcgdG8gY2h1bmsgdHJlZS4NCj4gQW5kIGV2ZW4gYWZ0ZXIgdGhlIGNvbnZlcnNpb24sIGl0J3Mg
bm90IGFsd2F5cyB0aGUgY2FzZSBmb3IgYWxsIHByb2ZpbGVzLg0KPiBGb3IgU0lOR0xFL0RVUC9S
QUlEMC9SQUlEMS9SQUlEMTAvUkFJRDFDKiwgeW91IGNhbiBmaW5kIHRoZSBkYXRhIGRpcmVjdGx5
LCBidXQgZm9yIFJBSUQ1LzYsIHlvdSBuZWVkIHRvIGJvdGhlciB0aGUgUC9RIHN0cmlwZS4NCj4g
DQo+IEFuZCBmdXJ0aGVybW9yZSwgdGhlcmUgYXJlIGNvbXByZXNzZWQgZGF0YSBleHRlbnRzLCB3
aGljaCBvbi1kaXNrIGRhdGEgaXMgY29tcHJlc3NlZCwgd2hpY2ggYWxzbyBkaWZmcyBmcm9tIHRo
ZSB1bmNvbXByZXNzZWQgZGF0YS4NCj4gDQo+IA0KPiBGb3IgdGhlIGNodW5rIG1hcHBpbmcsIHlv
dSBjYW4gdmVyaWZ5IHRoZSBtYXBwaW5nIG9mIDxsb2dpY2FsIGFkZHJlc3M+IHRvIDxwaHlzaWNh
bCBhZGRyZXNzPiB1c2luZyBidHJmcyBpbnNwZWN0IGR1bXAtdHJlZSAtdCBjaHVuayA8ZGV2aWNl
Pi4NCj4gDQo+IFRoZSBkZXRhaWxzIG9mIHRoZSBidHJmc19jaHVuayBvbi1kaXNrIGZvcm1hdCBj
YW4gYmUgZm91bmQgaGVyZToNCj4gaHR0cHM6Ly9idHJmcy53aWtpLmtlcm5lbC5vcmcvaW5kZXgu
cGhwL09uLWRpc2tfRm9ybWF0I0NIVU5LX0lURU1fLjI4ZQ0KPiA0LjI5DQo+IA0KPiBUaGFua3Ms
DQo+IFF1DQo+IA0KPj4NCj4+IEVudmlyb25tZW50Og0KPj4gLSA0LjE1LjAtOTYtZ2VuZXJpYyAj
OTd+MTYuMDQuMS1VYnVudHUgU01QIFdlZCBBcHIgMSAwMzowMzozMSBVVEMgDQo+PiAyMDIwDQo+
PiB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgNCj4+IC0gYnRyZnMtcHJvZ3MgdjQuNA0K
Pj4NCj4+IERvZXMgYW55b25lIGhhcyBhbnkgaWRlYT8gSSB3b3VsZCBhcHByZWNpYXRlIHlvdXIg
aGVscCBvbiB0aGlzIG9uZS4NCj4+IFRueC4NCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+PiBEZWph
bg0KPj4NCj4gDQoNCg==
