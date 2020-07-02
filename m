Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E82121C1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 13:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgGBLIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 07:08:49 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:49648 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGBLIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 07:08:48 -0400
Received: from fe0vm1649.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 49yFhY3kwTz1XLm4Z;
        Thu,  2 Jul 2020 13:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rs.bosch.com;
        s=key1-intmail; t=1593688125;
        bh=5Qv8K7sjybUcFbdUKFQ6IEewjuDzLH3KZksBsrRqirg=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=PWHvOvLasZJ4CJSHzoFayw5z2NrvmeyMpEH77exmYnm3lSHjz4NJtweFeCH61NBLn
         wddjfze/Vm2m2amLMtpg+YJUC0n+h/SHzfRYrCJOyTMwy2PJBAD6LC0tPDIkwQkoE2
         ijrWQ5gmnh+WitTPpvQJBWm6aSflcIWrN6MI78eQ=
Received: from fe0vm7918.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 49yFhY3LCVz3Lf;
        Thu,  2 Jul 2020 13:08:45 +0200 (CEST)
X-AuditID: 0a3aad10-183ff70000004153-3a-5efdc03d093a
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm7918.rbesz01.com (SMG Outbound) with SMTP id A1.B1.16723.D30CDFE5; Thu,  2 Jul 2020 13:08:45 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (fe-mbx2029.de.bosch.com [10.3.231.39])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 49yFhY2XzczW7X;
        Thu,  2 Jul 2020 13:08:45 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (10.3.231.39) by
 FE-MBX2029.de.bosch.com (10.3.231.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Thu, 2 Jul 2020 13:08:45 +0200
Received: from FE-MBX2029.de.bosch.com ([fe80::c815:e4fb:f7f:69ab]) by
 FE-MBX2029.de.bosch.com ([fe80::c815:e4fb:f7f:69ab%3]) with mapi id
 15.01.1979.003; Thu, 2 Jul 2020 13:08:45 +0200
From:   "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: FIEMAP ioctl gets "wrong" address for the extent
Thread-Topic: FIEMAP ioctl gets "wrong" address for the extent
Thread-Index: AdZQUL8TC28qUku1QeuTriBPGQAMhf//8VEA///XotA=
Date:   Thu, 2 Jul 2020 11:08:45 +0000
Message-ID: <c3b2c46ca5314285a79536cb3c233e1b@rs.bosch.com>
References: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
 <1d41a247-a4f7-124a-4842-f7d886e9aa70@gmx.com>
In-Reply-To: <1d41a247-a4f7-124a-4842-f7d886e9aa70@gmx.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.30.238]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsXCZbVWVtf2wN84g+sLpC0uPV7BbrG4+w2L
        A5PH3fsLmTw+b5ILYIrisklJzcksSy3St0vgyphzahFbwSqlipN7d7E0MO5Q7GLk5JAQMJFY
        9OUsexcjF4eQwAwmiZ4nL1khnN2MEu82zmGDcN4wSkxffZAJwtnLKLGzaT8jSD+bgLPE+YuL
        mUFsEYFUiWu7d4LFhQVsJZZP+skCEbeTONK/nBHCtpJYdeMVmM0ioCLR/XIhK4jNK2Atcf3T
        KXYQW0ggR2LbiS9gvZxA8ct/1oHNZxSQlehseMcEYjMLiEvcejKfCeIHAYkle84zQ9iiEi8f
        /wOayQFkK0rM+a0EYjILaEqs36UP0akoMaX7ITvEVkGJkzOfsExgFJuFZOgshI5ZSDpmIelY
        wMiyilE0LdWgLNfc0tBCrygptbjKwFAvOT93EyMkegR2MN7u/qB3iJGJg/EQowQHs5II72mD
        X3FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVV4NsYJCaQnlqRmp6YWpBbBZJk4OKUamNw4l2++
        cK6D9bbFdym+B7uVdz6X+n3T+aIte3/En1xNNpup7y43JG61CAuY+aWpJuDJUuM6zrq/SxsM
        f9uaR/4T2rtdPC1V+vGdm4cE2lmV/utc/nt486KvbdvXfuYvnPQxO1L4+o87Ed3+bX9WWloJ
        lz9y+3V7p8SErlOHzqZbVno4LFjFVPyOWWq63daytJOS+neLviu+2dn3xfR5o/bciIPHJiXM
        8v5yNHXH7mXFW77M4p99U3jp9r0ak5aVz+0wkri2Ts4lMIc9ZIZO5JUjmyXPnkm8UCBQJbH4
        3Kwt3JEHyvvyk/VNlu37VSp73HdSRteWlLblFpuj9f8Un108s7vqRYruj6N22ZLvGbOVWIoz
        Eg21mIuKEwFK0gI9DQMAAA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGkgUXUsDQoNCkknbSB1c2luZyB0aGlzIHN0cnVjdHVyZSB0byBnZXQgdGhlIGFkZHJlc3Mgb2Yg
ZmlsZSBleHRlbnQ6DQoNCnN0cnVjdCBmaWVtYXBfZXh0ZW50IHsNCglfX3U2NAlmZV9sb2dpY2Fs
OyAgLyogbG9naWNhbCBvZmZzZXQgaW4gYnl0ZXMgZm9yIHRoZSBzdGFydCBvZg0KCQkJICAgICAg
KiB0aGUgZXh0ZW50ICovDQoJX191NjQJZmVfcGh5c2ljYWw7IC8qIHBoeXNpY2FsIG9mZnNldCBp
biBieXRlcyBmb3IgdGhlIHN0YXJ0DQoJCQkgICAgICAqIG9mIHRoZSBleHRlbnQgKi8NCglfX3U2
NAlmZV9sZW5ndGg7ICAgLyogbGVuZ3RoIGluIGJ5dGVzIGZvciB0aGUgZXh0ZW50ICovDQoJX191
NjQJZmVfcmVzZXJ2ZWQ2NFsyXTsNCglfX3UzMglmZV9mbGFnczsgICAgLyogRklFTUFQX0VYVEVO
VF8qIGZsYWdzIGZvciB0aGlzIGV4dGVudCAqLw0KCV9fdTMyCWZlX3Jlc2VydmVkWzNdOw0KfTsN
Cg0KQW5kIHVzaW5nIGZlX3BoeXNpY2FsIGZpZWxkIEkgdmVyaWZpZWQgdGhhdCBpdCByZWFsbHkg
cmVmbGVjdHMgdGhlIG9mZnNldCBpbiBmaWxlc3lzdGVtIGltYWdlIC0gSSBjYW4gc2VlIHRoYXQg
ZmlsZSBjb250ZW50IGJlZ2lucyBhdCB0aGlzIG9mZnNldC4NClRoZSBwcm9ibGVtIGlzIHRoYXQg
SSBydW4gaW50byBzb21lIHNwZWNpZmljIGNhc2Ugd2hlcmUgZmlsZSBjb250ZW50IGRvZXNuJ3Qg
YmVnaW4gYXQgZmVfcGh5c2ljYWwsIEkgcmF0aGVyIGhhdmUgc29tZXRoaW5nIGVsc2UgYXQgdGhp
cyBvZmZzZXQuDQoNClRoYW5rcywNCkRlamFuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBRdSBXZW5ydW8gPHF1d2VucnVvLmJ0cmZzQGdteC5jb20+IA0KU2VudDogxI1ldHZy
dGFrLCAwMi4ganVsIDIwMjAuIDEyOjE5DQpUbzogUmVicmFjYSBEZWphbiAoQlNPVC9QSi1FUzEt
QmcpIDxEZWphbi5SZWJyYWNhQHJzLmJvc2NoLmNvbT47IGxpbnV4LWJ0cmZzQHZnZXIua2VybmVs
Lm9yZw0KU3ViamVjdDogUmU6IEZJRU1BUCBpb2N0bCBnZXRzICJ3cm9uZyIgYWRkcmVzcyBmb3Ig
dGhlIGV4dGVudA0KDQoNCg0KT24gMjAyMC83LzIg5LiL5Y2INToxMSwgUmVicmFjYSBEZWphbiAo
QlNPVC9QSi1FUzEtQmcpIHdyb3RlOg0KPiBIaSBhbGwsDQo+IA0KPiBJJ20gY29sbGVjdGluZyBm
aWxlIGV4dGVudHMgZm9yIG91ciBhcHBsaWNhdGlvbiBmcm9tIEJ0ckZzIGZpbGVzeXN0ZW0gaW1h
Z2UuDQo+IEkndmUgbm90aWNlZCB0aGF0IGZvciBzb21lIGZpbGVzIGEgZ2V0IHRoZSAid3Jvbmci
IHBoeXNpY2FsIG9mZnNldCBmb3Igc3RhcnQgb2YgdGhlIGV4dGVudC4NCg0KRmlyc3QgdGhpbmcg
Zmlyc3QsIGJ0cmZzIGZpZW1hcCBpb2N0bCBvbmx5IHJldHVybnMgYnRyZnMgbG9naWNhbCBhZGRy
ZXNzLg0KVGhhdCdzIGFuIGFkZHJlc3Mgc3BhY2UgaW4gWzAsIFU2NF9NQVgpLCB0aHVzIGl0J3Mg
bm90IGEgcGh5c2ljYWwgb2Zmc2V0IHlvdSBjYW4gZmluZCBpbiB0aGUgZGV2aWNlLg0KDQpGb3Ig
ZXhhbXBsZSwgZm9yIGEgYnRyZnMgb24gYSAxMEcgZGlzaywgYnRyZnMgZmllbWFwIGNhbiByZXR1
cm4gYWRkcmVzcyBhdCAxMjhHLCB3aGljaCB5b3UgY2FuIG5ldmVyIGZpbmQgb24gdGhhdCBkaXNr
Lg0KDQpUaGlzIGlzIG5vdCB0aGF0IHN0cmFuZ2UsIGFzIGJ0cmZzIGNhbiBiZSBhIG11bHRpLWRl
dmljZSBmcywgdGh1cyB3ZSBtdXN0IGhhdmUgYW4gaW50ZXJuYWwgYWRkcmVzcyBzcGFjZSwgYW5k
IHRoZW4gbWFwIHBhcnQgb2YgdGhlIGxvZ2ljYWwgYWRkcmVzcyBpbnRvIHBoeXNpY2FsIGRpc2sg
c3BhY2UuDQoNCj4gSSB2ZXJpZmllZCBpdCB1c2luZyBoZXhkdW1wIG9mIHRoZSBmaWxlc3lzdGVt
IGltYWdlOiB3aGVuIGR1bXAgdGhlIGNvbnRlbnQgc3RhcnRpbmcgZnJvbSB0aGUgYWRkcmVzcyBy
ZXR1cm5lZCBmcm9tIEZJRU1BUCBpb2N0bCwgSSBzZWUgdGhhdCB0aGUgY29udGVudCBpcyBhYnNv
bHV0ZWx5IGRpZmZlcmVudCBmcm9tIHRoZSBjb250ZW50IG9mIHRoZSBmaWxlIGl0c2VsZi4gQWxz
bywgdGhlIEZJRU1BUCBpb2N0bCByZXBvcnRzIHJlZ3VsYXIgZXh0ZW50LCBpdCBpcyBub3QgaW5s
aW5lLg0KDQpJZiB5b3UncmUgdXNpbmcgdGhlIGxvZ2ljYWwgYWRkcmVzcyByZXR1cm5lZCBmcm9t
IGRpc2sgZGlyZWN0bHksIHRoZW4geW91IHdvbid0IGdldCB0aGUgY29ycmVjdCBkYXRhIG9idmlv
dXNseS4NCg0KV2hhdCB5b3UgbmVlZCBpcyB0byBtYXAgdGhlIGJ0cmZzIGxvZ2ljYWwgYWRkcmVz
cyB0byBwaHlzaWNhbCBkZXZpY2Ugb2Zmc2V0LCB0aGF0IGlzIGRvbmUgYnkgcmVmZXJyaW5nIHRv
IGNodW5rIHRyZWUuDQpBbmQgZXZlbiBhZnRlciB0aGUgY29udmVyc2lvbiwgaXQncyBub3QgYWx3
YXlzIHRoZSBjYXNlIGZvciBhbGwgcHJvZmlsZXMuDQpGb3IgU0lOR0xFL0RVUC9SQUlEMC9SQUlE
MS9SQUlEMTAvUkFJRDFDKiwgeW91IGNhbiBmaW5kIHRoZSBkYXRhIGRpcmVjdGx5LCBidXQgZm9y
IFJBSUQ1LzYsIHlvdSBuZWVkIHRvIGJvdGhlciB0aGUgUC9RIHN0cmlwZS4NCg0KQW5kIGZ1cnRo
ZXJtb3JlLCB0aGVyZSBhcmUgY29tcHJlc3NlZCBkYXRhIGV4dGVudHMsIHdoaWNoIG9uLWRpc2sg
ZGF0YSBpcyBjb21wcmVzc2VkLCB3aGljaCBhbHNvIGRpZmZzIGZyb20gdGhlIHVuY29tcHJlc3Nl
ZCBkYXRhLg0KDQoNCkZvciB0aGUgY2h1bmsgbWFwcGluZywgeW91IGNhbiB2ZXJpZnkgdGhlIG1h
cHBpbmcgb2YgPGxvZ2ljYWwgYWRkcmVzcz4gdG8gPHBoeXNpY2FsIGFkZHJlc3M+IHVzaW5nIGJ0
cmZzIGluc3BlY3QgZHVtcC10cmVlIC10IGNodW5rIDxkZXZpY2U+Lg0KDQpUaGUgZGV0YWlscyBv
ZiB0aGUgYnRyZnNfY2h1bmsgb24tZGlzayBmb3JtYXQgY2FuIGJlIGZvdW5kIGhlcmU6DQpodHRw
czovL2J0cmZzLndpa2kua2VybmVsLm9yZy9pbmRleC5waHAvT24tZGlza19Gb3JtYXQjQ0hVTktf
SVRFTV8uMjhlNC4yOQ0KDQpUaGFua3MsDQpRdQ0KDQo+IA0KPiBFbnZpcm9ubWVudDoNCj4gLSA0
LjE1LjAtOTYtZ2VuZXJpYyAjOTd+MTYuMDQuMS1VYnVudHUgU01QIFdlZCBBcHIgMSAwMzowMzoz
MSBVVEMgMjAyMCANCj4geDg2XzY0IHg4Nl82NCB4ODZfNjQgR05VL0xpbnV4DQo+IC0gYnRyZnMt
cHJvZ3MgdjQuNA0KPiANCj4gRG9lcyBhbnlvbmUgaGFzIGFueSBpZGVhPyBJIHdvdWxkIGFwcHJl
Y2lhdGUgeW91ciBoZWxwIG9uIHRoaXMgb25lLg0KPiBUbnguDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IERlamFuDQo+IA0KDQo=
