Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4727520031A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgFSH7d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 03:59:33 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:54512 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbgFSH7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 03:59:32 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 49pB696YWmz1XLDQy;
        Fri, 19 Jun 2020 09:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rs.bosch.com;
        s=key1-intmail; t=1592553569;
        bh=lwdBTjrkigbqwL5cXQXvdSyAWgYAqpK4bCVvC2a9wgA=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=T30BunSMcUNZ1AsUdP9HlW7b4eVxMA7iunj+xxtlvmmq/As5vVLOVh8TiJizOgM+o
         9gNt+J0YEwlh+Cw266GqIrL2NqH09rTv+KdDgfSJN2Jy/jmm4uNP1YaK0wuRQAUoun
         HQZJGkrlZrzLzDJWDn67MBqzZ0aWPo2e+vqvkXMI=
Received: from fe0vm02900.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 49pB6969wrzHDB;
        Fri, 19 Jun 2020 09:59:29 +0200 (CEST)
X-AuditID: 0a3aad0c-cf1ff7000000304a-40-5eec70611ffe
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm02900.rbesz01.com (SMG Outbound) with SMTP id 3A.D7.12362.1607CEE5; Fri, 19 Jun 2020 09:59:29 +0200 (CEST)
Received: from FE-MBX2028.de.bosch.com (fe-mbx2028.de.bosch.com [10.3.231.38])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 49pB695N7zzB15;
        Fri, 19 Jun 2020 09:59:29 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (10.3.231.39) by
 FE-MBX2028.de.bosch.com (10.3.231.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Fri, 19 Jun 2020 09:59:29 +0200
Received: from FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b]) by
 FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b%3]) with mapi id
 15.01.1979.003; Fri, 19 Jun 2020 09:59:29 +0200
From:   "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Physical address offset of the inline extent
Thread-Topic: Physical address offset of the inline extent
Thread-Index: AdZFbyvOGU84GVKARDy4IQ9SM0Ag6v//7duA///Sv7CAAMTXAP//RcUQ
Date:   Fri, 19 Jun 2020 07:59:29 +0000
Message-ID: <11dae29ab3684e02833021d006621213@rs.bosch.com>
References: <31850f19929b40e4ade80a264c1af97d@rs.bosch.com>
 <02fcfb22-6b2b-6f99-99c8-b132ee511530@gmx.com>
 <db80cbe323fd4114962f7dee1dfc3ad5@rs.bosch.com>
 <d0a0d1fa-4f77-6f94-b82e-72f44a3e2a80@gmx.com>
In-Reply-To: <d0a0d1fa-4f77-6f94-b82e-72f44a3e2a80@gmx.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.252.58]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsXCZbVWVjex4E2cwdbDRhaXHq9gt1jc/YbF
        gcnj7v2FTB6fN8kFMEVx2aSk5mSWpRbp2yVwZVzYtJ2poEOlouFXP1MD4wTlLkZODgkBE4mX
        E6+zdDFycQgJzGSSeHLhBCuEs5tRYv/aV0wQzltGiQd926AyexglzrVdYQTpZxNwljh/cTEz
        iC0ikCpxbfdOsLiwgKXE2eNXWCHiVhL3dnayQdhuEt8f3AeaysHBIqAq8We+DUiYV8BaYkLb
        VKhl5xklPv5tB5vDCZSYfWIXC4jNKCAr0dnwjgnEZhYQl7j1ZD4TxA8CEkv2nGeGsEUlXj7+
        xwphK0qcf7SaEWQXs4CmxPpd+hCtihJTuh+yQ+wVlDg58wnLBEaxWUimzkLomIWkYxaSjgWM
        LKsYxdJSDcpyDYwsDQz0ipJSi6sMDPWS83M3MUIiiGcH46meD3qHGJk4GA8xSnAwK4nwOv9+
        ESfEm5JYWZValB9fVJqTWnyIUZqDRUmcV4VnY5yQQHpiSWp2ampBahFMlomDU6qByUydt8BI
        c3NKpe6jF9v7/Ord65fM91Y1YhCwfO/wXeJj9LVdmhqHMh5MFJvv3bnk+OuWDX+4XX+lp7T/
        CffkkriVLrbfpTvu5vXF1wwmyx0/v6HK5I0l79OLL9RfvuawZbryKeexxuQ3Njypzg7hL39K
        fvMt84xoMN9usim5dt8epUyjJ5FHXtzyFt5//JVSlEjjrGK5DS4SgucUmT67/XgivGT5/oXM
        39yMI/SEmbbsjnsv1bB+wuWvArYKWr379ukkbWDdZG6maD/33qzw08ZfLcS7gz88Wfr0JmfK
        tQSmc1OSn1llSVzneVb6aklR1UH1yr5Cn2sf2ox99q5J9JiirBe3tziwyt76Hd99JZbijERD
        Leai4kQAZNX8TA8DAAA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

VGhhbmtzIGEgbG90IGZvciB5b3VyIGhlbHAgZ3V5cy4NCkFzIEkgdGhvdWdodCwgaXQncyBub3Qg
c28gc3RyYWlnaHRmb3J3YXJkLCBJJ2xsIHNlZSB3aGF0IEkgY2FuIGRvLg0KDQpUaGFua3MsDQpE
ZWphbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUXUgV2VucnVvIDxxdXdl
bnJ1by5idHJmc0BnbXguY29tPiANClNlbnQ6IHBldGFrLCAxOS4ganVuIDIwMjAuIDAwOjQ5DQpU
bzogUmVicmFjYSBEZWphbiAoQlNPVC9QSi1FUzEtQmcpIDxEZWphbi5SZWJyYWNhQHJzLmJvc2No
LmNvbT47IGxpbnV4LWJ0cmZzQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFBoeXNpY2Fs
IGFkZHJlc3Mgb2Zmc2V0IG9mIHRoZSBpbmxpbmUgZXh0ZW50DQoNCg0KDQpPbiAyMDIwLzYvMTgg
5LiL5Y2IMTA6NTMsIFJlYnJhY2EgRGVqYW4gKEJTT1QvUEotRVMxLUJnKSB3cm90ZToNCj4gSGkg
UXUsDQo+IA0KPiBJJ3ZlIHJlYWQgdGhpczoNCj4gaHR0cHM6Ly9idHJmcy53aWtpLmtlcm5lbC5v
cmcvaW5kZXgucGhwL0RhdGFfU3RydWN0dXJlcyNidHJmc19rZXlfLjJGXw0KPiBidHJmc19kaXNr
X2tleSB3aGVyZSBrZXkub2JqZWN0aWQgb2YgRVhURU5UX0lURU0gY29udGFpbnMgdGhlIHN0YXJ0
aW5nIA0KPiBieXRlIG9mZnNldCBvZiB0aGUgZXh0ZW50IGl0IGRlc2NyaWJlcyBhbmQga2V5Lm9m
ZnNldCBvZiBFWFRFTlRfSVRFTSBzdG9yZXMgdGhlIHNpemUgb2YgdGhlIGV4dGVudCB0aGUgaXRl
bSBkZXNjcmliZXMuDQo+IA0KPiBGcm9tIHlvdXIgZHVtcDoNCj4gaXRlbSA2IGtleSAoMjU3IEVY
VEVOVF9EQVRBIDApIGl0ZW1vZmYgMTM3OTQgaXRlbXNpemUgMjA2OQ0KPiANCj4gaXRyZW1vZmYg
PSAxMzc5NA0KPiBUaGlzIGlzIHRoZSBvZmZzZXQgcmVsYXRpdmUgdG8gdHJlZSBibG9jayBvciB0
cmVlIGxlYWYsIHJpZ2h0Pw0KDQpSaWdodCwgYnV0IHlvdSBzdGlsbCBuZWVkIHRvIGNvbnNpZGVy
IHRoZSBvZmZzZXQgaW5zaWRlIGJ0cmZzX2ZpbGVfZXh0ZW50X2l0ZW0gZm9yIGlubGluZSBkYXRh
LCB0aGF0J3Mgd2h5IEknbSB1c2luZw0KYnRyZnNfZmlsZV9leHRlbnRfaW5saW5lX3N0YXJ0KCkg
dG8gZmluZCBvdXQgdGhlIHJlYWwgb2Zmc2V0Lg0KDQpUaGFua3MsDQpRdQ0KDQo+IA0KPiBUaGFu
a3MsDQo+IERlamFuDQo+IA0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogUXUgV2VucnVvIDxxdXdlbnJ1by5idHJmc0BnbXguY29tPg0KPiBTZW50OiDEjWV0dnJ0YWss
IDE4LiBqdW4gMjAyMC4gMTU6NDYNCj4gVG86IFJlYnJhY2EgRGVqYW4gKEJTT1QvUEotRVMxLUJn
KSA8RGVqYW4uUmVicmFjYUBycy5ib3NjaC5jb20+OyANCj4gbGludXgtYnRyZnNAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBQaHlzaWNhbCBhZGRyZXNzIG9mZnNldCBvZiB0aGUgaW5s
aW5lIGV4dGVudA0KPiANCj4gDQo+IA0KPiBPbiAyMDIwLzYvMTgg5LiL5Y2IOToyMSwgUmVicmFj
YSBEZWphbiAoQlNPVC9QSi1FUzEtQmcpIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gRG9lcyBhbnli
b2R5IGtub3cgaG93IHRvIGdldCBhbiBhZGRyZXNzIG9mZnNldCBvZiB0aGUgZmlsZSBkYXRhIGlu
bGluZSBleHRlbnQ/DQo+IA0KPiBTaW5jZSBpdCdzIGlubGluZSwgaXQncyBpbmxpbmVkIGludG8g
bWV0YWRhdGEgKHRyZWUgYmxvY2spLCB0aHVzIG1ha2VzIG5vIHNlbnNlIHRvIGdldCB0aGUgImFk
ZHJlc3MiLg0KPiANCj4gVGhlIGFkZHJlc3Mgd2lsbCBiZSBpbnNpZGUgYSB0cmVlIGJsb2NrIGFu
eXdheS4NCj4gDQo+IElmIHlvdSByZWFsbHkgd2FudCB0aGUgYWRkcmVzcywgeW91IGNhbiBjaGVj
ayBpdCB3aXRoIGR1bXAtdHJlZS4NCj4gDQo+ICQgYnRyZnMgaW5zIGR1bXAtdHJlZSAtdCA1IC9k
ZXYvbnZtZS9idHJmcyBmcyB0cmVlIGtleSAoRlNfVFJFRSBST09UX0lURU0gMCkgbGVhZiA1MzI0
ODAwIGl0ZW1zIDcgZnJlZSBzcGFjZSAxMzYxOSBnZW5lcmF0aW9uIDYgb3duZXIgRlNfVFJFRSBs
ZWFmIDUzMjQ4MDAgZmxhZ3MgMHgxKFdSSVRURU4pIGJhY2tyZWYgcmV2aXNpb24gMQ0KPiAgICAg
IF5eXl5eXl4gVHJlZSBibG9jayBieXRlbnINCj4gLi4uDQo+ICAgICAgICAgaXRlbSA2IGtleSAo
MjU3IEVYVEVOVF9EQVRBIDApIGl0ZW1vZmYgMTM3OTQgaXRlbXNpemUgMjA2OQ0KPiAgICAgICAg
ICAgICAgICAgZ2VuZXJhdGlvbiA2IHR5cGUgMCAoaW5saW5lKQ0KPiAgICAgICAgICAgICAgICAg
aW5saW5lIGV4dGVudCBkYXRhIHNpemUgMjA0OCByYW1fYnl0ZXMgMjA0OCANCj4gY29tcHJlc3Np
b24NCj4gMCAobm9uZSkNCj4gDQo+IFlvdSBuZWVkIHRvIHVzZSBleHRlbnRfYnVmZmVyIHRvIGdy
YWIgdGhlIGlubGluZSBmaWxlIGV4dGVudCBpdGVtLCBhbmQgdXNlIHRoZSBidHJmc19maWxlX2V4
dGVudF9pbmxpbmVfc3RhcnQoKSB0byBnZXQgdGhlIGlubGluZSBmaWxlIGV4dGVudCBvZmZzZXQg
aW5zaWRlIHRoZSBsZWFmLg0KPiANCj4gQW55d2F5LCB5b3UgbmVlZCBhIHNvbGlkIHVuZGVyc3Rh
bmRpbmcgb2YgYnRyZnMgb24tZGlzayBmb3JtYXQgdG8gZ3Jhc3AgdGhlIGFib3ZlIGR1bXAuDQo+
IA0KPj4gS2VybmVsIHJldHVybnMgMCB0cm91Z2ggRlNfSU9DX0ZJRU1BUCBpb2N0bCwgYnV0IEkg
d291bGQgcmVhbGx5IGxpa2UgdG8gZ2V0IHJlYWwgcGh5c2ljYWwgb2Zmc2V0IGlmIHBvc3NpYmxl
LCBtb3N0IHByb2JhYmx5IG1lYW5pbmc6DQo+Pg0KPj4gSW4gRlMgdHJlZSAtIG9uLWRpc2sgYWRk
cmVzcyBvZiB0aGUgZXh0ZW50IGRhdGEgaXRlbSBmb3IgdGhlIHJlbGV2YW50IGZpbGUgb2JqZWN0
ICsgdGhlIG9mZnNldCB3aXRoaW4gdGhhdCBpdGVtICgweDE1KS4NCj4+DQo+PiBJIHdhcyBob3Bp
bmcgdGhhdCB0aGUga2V5Lm9iamVjdGlkIG9mIGtleS50eXBlID0gRVhURU5UX0lURU0gd291bGQg
Z2l2ZSBtZSBzdWNoIGFuIGluZm9ybWF0aW9uLCBidXQgYXBwYXJlbnRseSB0aGlzIGlzIG5vdCB0
aGUgY2FzZS4NCj4gDQo+IEtleS5vYmplY3RpZCBvZiBFWFRFTlRfSVRFTSBvbmx5IG1lYW5zIHRo
ZSBpbm9kZSBudW1iZXIuDQo+IEtleS5vZmZzZXQgb2YgRVhURU5UX0lURU0gbWVhbnMgdGhlIGZp
bGUgb2Zmc2V0LCBmb3IgaW5saW5lIGZpbGUgZXh0ZW50IGl0J3MgYWx3YXlzIDAuDQo+IA0KPiBT
byBpdCBsb29rcyBsaWtlIHlvdSdyZSBub3QgZmFtaWxpYXIgd2l0aCBidHJmcyBvbi1kaXNrIGZv
cm1hdCwgdGh1cyBJIGRvdWJ0IHRoZSB1c2VmdWxuZXNzIG9mIGtub3duIHRoZSBpbmxpbmUgZmls
ZSBleHRlbnQgb2Zmc2V0IGluc2lkZSB0aGUgdHJlZSBibG9jay4NCj4gDQo+IFRoYW5rcywNCj4g
UXUNCj4gDQo+Pg0KPj4gVGhhbmtzIHZlcnkgbXVjaCwNCj4+DQo+PiBEZWphbg0KPj4NCj4+DQo+
Pg0KPiANCg0K
