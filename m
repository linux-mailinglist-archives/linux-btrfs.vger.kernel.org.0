Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0BB2E0009
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 19:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgLUSkM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 13:40:12 -0500
Received: from mail-db8eur06olkn2044.outbound.protection.outlook.com ([40.92.51.44]:13184
        "EHLO EUR06-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbgLUSkM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 13:40:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQlelWgk7WapNdT4S1yT/hNyzAx6G6rCxlKy5bihZogVuKDuVchoTUj+7PrUjINlxRCjRDfQT+ai/p514v+uiXIVtRACZjIa16PVhulRNdIJIKxhFXRXZZGdXkFR5cpErCIpAy9cVIm1FJy7kQz6/DK8RGi3+JeWTg/ResAmIHVGXWc5CaxJ1GXSitiofWb1P1KIm3rc9ysQ8QgBbrlxmFwl+blwzFQfajWy5xXkjXV3YHfR1snVJ98CDbVOvx/7KRmnFRqy5t/oe+BG4YIDtvFfpjhinaXHISZjlJYvbr+lygnd4CPqHEQynfWxs85daXI2WNZNME+MTF7qWqOpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHiUxgBj5HDgt2rtJ11E9VVYxirtQD8W0Dw7gUWGgqM=;
 b=DexWAZTeP6mMIv1ibdcFGrixG7W9nYNUlDrIE+N+EoEULRG40aQgnnr7x6wAmP3wUt+4G2zEUKgmV8Et4Y9R2M+fOaAKT8Lel3OAq5GrGPcBgNDUrsestF/5jeOKFS7ypKcyjtr7wFl7vUB9yMyyFK/fqIg6aLlSP63QwYBP/2KGo/En/3ZLNuSUIi/mGNyDYEQktalA1hCZJVfRnEeZnZUVOyww+vLSy7v8hEl6w0vtfUUv97HXAwz+SisaGKqqhCk0+Jc8X5RuZlbNmLY66tybGgtOkzxL4SPk6izto/l2oP5jroZhtbR/qE4MoBaz6p6VfpuTCUCSMDA/PzIVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8EUR06FT062.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc35::41) by
 DB8EUR06HT062.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc35::466)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.22; Mon, 21 Dec
 2020 18:39:24 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM (2a01:111:e400:fc35::49)
 by DB8EUR06FT062.mail.protection.outlook.com (2a01:111:e400:fc35::393) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.22 via Frontend
 Transport; Mon, 21 Dec 2020 18:39:24 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d]) by AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d%2]) with mapi id 15.20.3676.030; Mon, 21 Dec 2020
 18:39:24 +0000
From:   Claudius Ellsel <claudius.ellsel@live.de>
To:     Remi Gauvin <remi@georgianit.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: AW: AW: WG: How to properly setup for snapshots
Thread-Topic: AW: WG: How to properly setup for snapshots
Thread-Index: AQHWzwEUMIqawVdWg0mLNgWO6o19JqoBySKLgAAP3ICAAAzDuYAAC52AgAABMIM=
Date:   Mon, 21 Dec 2020 18:39:24 +0000
Message-ID: <AM9P191MB1650B4887CF3732391C1E32CE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
 <AM9P191MB1650AE92A25D9618163309E5E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>,<d93610c2-e8b8-0b79-90fe-ae8104130d96@georgianit.com>
In-Reply-To: <d93610c2-e8b8-0b79-90fe-ae8104130d96@georgianit.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:18EA7EC2B9567AB353D699BEDE1BDEB78EB5172CF7EB197E3A3BC70664C1DBEC;UpperCasedChecksum:8D42D91EB8F5B29F3E7C779F5A248887B47A1BEE69D2E00F03B962143B12D52B;SizeAsReceived:7353;Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [7b3enfs54d1GpwVxJIqKRMmfraw7kZn5Deljo8+XiM8M4vSSHyD2lOGSmsCbBvJ5]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 0cd4b68c-6158-4d13-8955-08d8a5dfbd55
x-ms-traffictypediagnostic: DB8EUR06HT062:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MV8nJbUUM+jFGVE0VRKadcQ1Jy+2vZYpO6AvMDilF1NPlEr1BgLxhsbLAdZ+tSYsasnnI9KrQSBI18kepGFt/RJn6mlwvL10YZUz2KXuTHOfNA1tqnpU7LU0jvCNoLrukTaQnMvrq6kBZuEcHosvmAEpptkHU+MniG7M6VWDTRYlzzKwP5J/PyIpgbtyziUmaLjTrMuFgU0ZXAfph9uW/ppYLdS2qHsoeuXJcErvrYSm5oaroX+KfKdOr8x4UP6
x-ms-exchange-antispam-messagedata: Gq7sY/AutP/hbPVeeVzB6QvL+t5e7QENw402KF8Ij0pgp9UdqN+4uYarXcJ0zBXsJxWrhuwdAQBFzunGEiemtQPlipu6o7TML2+fydgf12VGet4i1LDdOt+Br4MJUSjDzQdFoyJVZEHVNujxcCb7DfaK7rNYcFvAWN9hu7kULI2byi5gjsMbBbV6IllvbX9n+p1WWi+5nRnRc8Z6J6dYNA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR06FT062.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd4b68c-6158-4d13-8955-08d8a5dfbd55
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 18:39:24.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR06HT062
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TmljZSwgdGhhbmtzIGZvciBjbGFyaWZ5aW5nIGl0LCB0aGF0IGlzIGEgZmlyc3Qgc3RlcCB0b3dh
cmRzIGNsZWFyaW5nIHVwIG15IGNvbmZ1c2lvbiDwn5mCCgpWb246IFJlbWkgR2F1dmluIDxyZW1p
QGdlb3JnaWFuaXQuY29tPgpHZXNlbmRldDogTW9udGFnLCAyMS4gRGV6ZW1iZXIgMjAyMCAxOToz
MgpBbjogQ2xhdWRpdXMgRWxsc2VsIDxjbGF1ZGl1cy5lbGxzZWxAbGl2ZS5kZT4KQ2M6IGxpbnV4
LWJ0cmZzIDxsaW51eC1idHJmc0B2Z2VyLmtlcm5lbC5vcmc+CkJldHJlZmY6IFJlOiBBVzogV0c6
IEhvdyB0byBwcm9wZXJseSBzZXR1cCBmb3Igc25hcHNob3RzIArCoApPbiAyMDIwLTEyLTIxIDE6
MDQgcC5tLiwgQ2xhdWRpdXMgRWxsc2VsIHdyb3RlOgoKPiAKPiBJIHN0aWxsIGRvdWJ0IHRoYXQg
YSBiaXQsIGBzdWRvIGJ0cmZzIHN1YnZvbHVtZSBsaXN0IC9tZWRpYS9jbGVsL05BU2AgKHdoaWNo
IGlzIHdoZXJlIEkgbW91bnQgdGhlIHZvbHVtZSB3aXRoIGFuIGZzdGFiIGVudHJ5IGJhc2VkIG9u
IHRoZSBVVUlEKSBkb2VzIG5vdCBvdXRwdXQgYW55dGhpbmcuIEFkZGl0aW9uYWxseSBJIHJlYWQg
KEkgZ3Vlc3Mgb24gYSByZWRkaXQgcG9zdCkgdGhhdCBpbiB0aGlzIGNhc2Ugb25lIGhhcyB0byBj
cmVhdGUgYSBzdWJ2b2x1bWUgZmlyc3QuIFRoYXQgbWlnaHQgaGF2ZSBiZWVuIHByb2JsZW1hdGlj
IGluZm9ybWF0aW9uLCB0aG91Z2guCj4gCj4KCk9rLCB5b3UgZ290IG1lIHRoZXJlLsKgIFRlY2hu
aWNhbGx5LCB0aGUgZmlsZSBzeXN0ZW0gcm9vdCBpcyBub3QgYQoqU3ViKnZvbHVtZSwgYmVjYXVz
ZSBpdCdzIG5vdCAqc3ViKiB0byBhbnl0aGluZy4uLiBidXQgeW91IGNhbiBzdGlsbAptYWtlIHNu
YXBzaG90cyBvZiBpdCwganVzdCBhcyBJIGRlc2NyaWJlZC4=
