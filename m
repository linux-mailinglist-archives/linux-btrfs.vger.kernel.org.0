Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86071FF5C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbgFROx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 10:53:56 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:55292 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbgFROx4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 10:53:56 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 49nlLm64Bgz1XLm4M;
        Thu, 18 Jun 2020 16:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rs.bosch.com;
        s=key1-intmail; t=1592492032;
        bh=5Qv8K7sjybUcFbdUKFQ6IEewjuDzLH3KZksBsrRqirg=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=bPt9YwrUqkWq/dHn9uRx2Lfua/vBdsZrZ3HN3OikDb5KwGDGcZgS8Udvd9H9bI9EI
         DMPnkSossD1EmZgKzfvxdwUNbbwlgboiUzot37+PrRePGHImEt3D50Fa0wWoSb8Bpe
         ZKQsq10vEubqDd/Afzw+45gAZ9wllLeAWj4WENVE=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 49nlLm5jLlz7Jg;
        Thu, 18 Jun 2020 16:53:52 +0200 (CEST)
X-AuditID: 0a3aad14-e0fff70000003b75-89-5eeb8000a1ed
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 4C.06.15221.0008BEE5; Thu, 18 Jun 2020 16:53:52 +0200 (CEST)
Received: from FE-MBX2028.de.bosch.com (fe-mbx2028.de.bosch.com [10.3.231.38])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 49nlLm4yDlzvl9;
        Thu, 18 Jun 2020 16:53:52 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (10.3.231.39) by
 FE-MBX2028.de.bosch.com (10.3.231.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Thu, 18 Jun 2020 16:53:52 +0200
Received: from FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b]) by
 FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b%3]) with mapi id
 15.01.1979.003; Thu, 18 Jun 2020 16:53:52 +0200
From:   "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Physical address offset of the inline extent
Thread-Topic: Physical address offset of the inline extent
Thread-Index: AdZFbyvOGU84GVKARDy4IQ9SM0Ag6v//7duA///Sv7A=
Date:   Thu, 18 Jun 2020 14:53:52 +0000
Message-ID: <db80cbe323fd4114962f7dee1dfc3ad5@rs.bosch.com>
References: <31850f19929b40e4ade80a264c1af97d@rs.bosch.com>
 <02fcfb22-6b2b-6f99-99c8-b132ee511530@gmx.com>
In-Reply-To: <02fcfb22-6b2b-6f99-99c8-b132ee511530@gmx.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.184.223]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsXCZbVWVpeh4XWcwek2fYtLj1ewWyzufsPi
        wORx9/5CJo/Pm+QCmKK4bFJSczLLUov07RK4Mla17mMruCNdcelJQQNjg3QXIyeHhICJxKGl
        h5i6GLk4hARmMElMWtjBDOHsZpS49eotG4TzllGie0UPI4Szh1HiTt9LRpB+NgFnifMXFzOD
        2CICqRLXdu8EiwsLWEqcPX6FFSJuJXFvZycbjL3q6F6WLkYODhYBVYm9i2pBwrwC1hL/Xsxn
        ArGFBHIkXsxfATaSEyj+cuMSsDijgKxEZ8M7MJtZQFzi1hOIegkBAYkle84zQ9iiEi8f/2OF
        sJUkLp17zAqyillAU2L9Ln2IVkWJKd0P2SHWCkqcnPmEZQKj2CwkU2chdMxC0jELSccCRpZV
        jKJpqQZluYbmJgZ6RUmpxVUGhnrJ+bmbGCGxI7KD8WTPB71DjEwcjIcYJTiYlUR4nX+/iBPi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOq8KzMU5IID2xJDU7NbUgtQgmy8TBKdXAVHfYaaa3tc0x
        laKj6xoNYybZ7amZNz+Ao8hQsPS24rtz2nEmhu/9MqeosRau9Ht65H1xokKeE2vdrH+hTydp
        HmaeZvtUsoq5afuWWRaSC0ok4rYn/3IrcP+Ul6JoePDMYsNPTY6xVcqr75csn8pdJHTmWkhI
        cLbXwQ6zLRMnxHxxqg+sM7iWx6jXUtB85XHxx0PGbCuNBLXuK25crrBxQuJ/v0nvShz/TXRl
        X7/2wUHGioNSLDoiC5JsorVuH4+r/F7WZC5dv/GE78kei4oiqzVZKwJPCifUzeLO3Om9pEA5
        WUV8Yc1tz+t7VZ6tK/A7wj4l/s+fWQUZCsu7Ny+x77Vz594dFW+g6VI865sSS3FGoqEWc1Fx
        IgCYhvDyDAMAAA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGkgUXUsDQoNCkkndmUgcmVhZCB0aGlzOg0KaHR0cHM6Ly9idHJmcy53aWtpLmtlcm5lbC5vcmcv
aW5kZXgucGhwL0RhdGFfU3RydWN0dXJlcyNidHJmc19rZXlfLjJGX2J0cmZzX2Rpc2tfa2V5DQp3
aGVyZSBrZXkub2JqZWN0aWQgb2YgRVhURU5UX0lURU0gY29udGFpbnMgdGhlIHN0YXJ0aW5nIGJ5
dGUgb2Zmc2V0IG9mIHRoZSBleHRlbnQgaXQgZGVzY3JpYmVzIGFuZCBrZXkub2Zmc2V0IG9mIEVY
VEVOVF9JVEVNIHN0b3JlcyB0aGUgc2l6ZSBvZiB0aGUgZXh0ZW50IHRoZSBpdGVtIGRlc2NyaWJl
cy4NCg0KRnJvbSB5b3VyIGR1bXA6DQppdGVtIDYga2V5ICgyNTcgRVhURU5UX0RBVEEgMCkgaXRl
bW9mZiAxMzc5NCBpdGVtc2l6ZSAyMDY5DQoNCml0cmVtb2ZmID0gMTM3OTQNClRoaXMgaXMgdGhl
IG9mZnNldCByZWxhdGl2ZSB0byB0cmVlIGJsb2NrIG9yIHRyZWUgbGVhZiwgcmlnaHQ/DQoNClRo
YW5rcywNCkRlamFuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFF1IFdl
bnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT4gDQpTZW50OiDEjWV0dnJ0YWssIDE4LiBqdW4g
MjAyMC4gMTU6NDYNClRvOiBSZWJyYWNhIERlamFuIChCU09UL1BKLUVTMS1CZykgPERlamFuLlJl
YnJhY2FAcnMuYm9zY2guY29tPjsgbGludXgtYnRyZnNAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0
OiBSZTogUGh5c2ljYWwgYWRkcmVzcyBvZmZzZXQgb2YgdGhlIGlubGluZSBleHRlbnQNCg0KDQoN
Ck9uIDIwMjAvNi8xOCDkuIvljYg5OjIxLCBSZWJyYWNhIERlamFuIChCU09UL1BKLUVTMS1CZykg
d3JvdGU6DQo+IEhpLA0KPiANCj4gRG9lcyBhbnlib2R5IGtub3cgaG93IHRvIGdldCBhbiBhZGRy
ZXNzIG9mZnNldCBvZiB0aGUgZmlsZSBkYXRhIGlubGluZSBleHRlbnQ/DQoNClNpbmNlIGl0J3Mg
aW5saW5lLCBpdCdzIGlubGluZWQgaW50byBtZXRhZGF0YSAodHJlZSBibG9jayksIHRodXMgbWFr
ZXMgbm8gc2Vuc2UgdG8gZ2V0IHRoZSAiYWRkcmVzcyIuDQoNClRoZSBhZGRyZXNzIHdpbGwgYmUg
aW5zaWRlIGEgdHJlZSBibG9jayBhbnl3YXkuDQoNCklmIHlvdSByZWFsbHkgd2FudCB0aGUgYWRk
cmVzcywgeW91IGNhbiBjaGVjayBpdCB3aXRoIGR1bXAtdHJlZS4NCg0KJCBidHJmcyBpbnMgZHVt
cC10cmVlIC10IDUgL2Rldi9udm1lL2J0cmZzIGZzIHRyZWUga2V5IChGU19UUkVFIFJPT1RfSVRF
TSAwKSBsZWFmIDUzMjQ4MDAgaXRlbXMgNyBmcmVlIHNwYWNlIDEzNjE5IGdlbmVyYXRpb24gNiBv
d25lciBGU19UUkVFIGxlYWYgNTMyNDgwMCBmbGFncyAweDEoV1JJVFRFTikgYmFja3JlZiByZXZp
c2lvbiAxDQogICAgIF5eXl5eXl4gVHJlZSBibG9jayBieXRlbnINCi4uLg0KICAgICAgICBpdGVt
IDYga2V5ICgyNTcgRVhURU5UX0RBVEEgMCkgaXRlbW9mZiAxMzc5NCBpdGVtc2l6ZSAyMDY5DQog
ICAgICAgICAgICAgICAgZ2VuZXJhdGlvbiA2IHR5cGUgMCAoaW5saW5lKQ0KICAgICAgICAgICAg
ICAgIGlubGluZSBleHRlbnQgZGF0YSBzaXplIDIwNDggcmFtX2J5dGVzIDIwNDggY29tcHJlc3Np
b24NCjAgKG5vbmUpDQoNCllvdSBuZWVkIHRvIHVzZSBleHRlbnRfYnVmZmVyIHRvIGdyYWIgdGhl
IGlubGluZSBmaWxlIGV4dGVudCBpdGVtLCBhbmQgdXNlIHRoZSBidHJmc19maWxlX2V4dGVudF9p
bmxpbmVfc3RhcnQoKSB0byBnZXQgdGhlIGlubGluZSBmaWxlIGV4dGVudCBvZmZzZXQgaW5zaWRl
IHRoZSBsZWFmLg0KDQpBbnl3YXksIHlvdSBuZWVkIGEgc29saWQgdW5kZXJzdGFuZGluZyBvZiBi
dHJmcyBvbi1kaXNrIGZvcm1hdCB0byBncmFzcCB0aGUgYWJvdmUgZHVtcC4NCg0KPiBLZXJuZWwg
cmV0dXJucyAwIHRyb3VnaCBGU19JT0NfRklFTUFQIGlvY3RsLCBidXQgSSB3b3VsZCByZWFsbHkg
bGlrZSB0byBnZXQgcmVhbCBwaHlzaWNhbCBvZmZzZXQgaWYgcG9zc2libGUsIG1vc3QgcHJvYmFi
bHkgbWVhbmluZzoNCj4gDQo+IEluIEZTIHRyZWUgLSBvbi1kaXNrIGFkZHJlc3Mgb2YgdGhlIGV4
dGVudCBkYXRhIGl0ZW0gZm9yIHRoZSByZWxldmFudCBmaWxlIG9iamVjdCArIHRoZSBvZmZzZXQg
d2l0aGluIHRoYXQgaXRlbSAoMHgxNSkuDQo+IA0KPiBJIHdhcyBob3BpbmcgdGhhdCB0aGUga2V5
Lm9iamVjdGlkIG9mIGtleS50eXBlID0gRVhURU5UX0lURU0gd291bGQgZ2l2ZSBtZSBzdWNoIGFu
IGluZm9ybWF0aW9uLCBidXQgYXBwYXJlbnRseSB0aGlzIGlzIG5vdCB0aGUgY2FzZS4NCg0KS2V5
Lm9iamVjdGlkIG9mIEVYVEVOVF9JVEVNIG9ubHkgbWVhbnMgdGhlIGlub2RlIG51bWJlci4NCktl
eS5vZmZzZXQgb2YgRVhURU5UX0lURU0gbWVhbnMgdGhlIGZpbGUgb2Zmc2V0LCBmb3IgaW5saW5l
IGZpbGUgZXh0ZW50IGl0J3MgYWx3YXlzIDAuDQoNClNvIGl0IGxvb2tzIGxpa2UgeW91J3JlIG5v
dCBmYW1pbGlhciB3aXRoIGJ0cmZzIG9uLWRpc2sgZm9ybWF0LCB0aHVzIEkgZG91YnQgdGhlIHVz
ZWZ1bG5lc3Mgb2Yga25vd24gdGhlIGlubGluZSBmaWxlIGV4dGVudCBvZmZzZXQgaW5zaWRlIHRo
ZSB0cmVlIGJsb2NrLg0KDQpUaGFua3MsDQpRdQ0KDQo+IA0KPiBUaGFua3MgdmVyeSBtdWNoLA0K
PiANCj4gRGVqYW4NCj4gDQo+IA0KPiANCg0K
