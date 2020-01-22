Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A341458FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 16:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgAVPsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 10:48:54 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27895 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVPsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 10:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579708135; x=1611244135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VSwX3uVy26PfHTjysYew4h/zqDGcXsXXZfYWNKe7lcQ=;
  b=GQFlCn4dz3Z8EGAOoqoIALPg4hCyNwEUizGSgrEtuNKY4Ke18gHAZxEM
   KEWjUou/o5cpEMkK2MSv3159rXQCA3hCddubQs6ZIwokGSnUceqbAKszF
   6d5J+yyjUQcfxct+JbFIWY4ojGap8nVXa62JQGnw8Wvn3o4WlBTyzvMo4
   e/HqyGn+Chuzk4dMyOgMXHF8rWzC60nwaO8BVGzUd5IYugSklxBBLpFec
   wSlkO8dQLRydtaive0ky1v6/gmHsayhz4Gdg+mP42gSJ6G3cFP1c38loi
   n13p4eE3qQ5LkTFsyS3Ot1B8PUwj8zmLFDx2DRUYaiZ3r2/OdamPOcFWB
   w==;
IronPort-SDR: E1Rtt9tKG0BT0mUxX2BCKlUpbd0TuqAsG4E4fQyZjMs/+exWNZHlxUU9Fdvi5t4QfA6IZWVdGt
 T3RV0k2itkUNbCgDnsc61JwooGbFvnYABym6QLhqyJzNfOqKql7YG3ONIGJ70SckXLtIA3EFO2
 sEMsr/rRuJJOh1QJZSf5cQhiXqM3DwB6BrspGrvZDFExdtIl6IO1fsS2Gzv5t0JzHRIukA/npW
 vNF6jCE57JkTpNssCugNEzdPW3GkL+8B9oidEWyZXJwpEKWe6P1rN6MmygLpI5PDJXIltsdxUr
 UYU=
X-IronPort-AV: E=Sophos;i="5.70,350,1574092800"; 
   d="scan'208";a="128773275"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2020 23:48:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvdbdcyngfblC5KztvPcBcCJ9Ulr5TENC/P/2UjLe/x7P+Sq0NPY47QC1v1cOtU9BSgmnnBswxsNIWQKgEH7FDNmC8kT6U6XIzn/XZ7mjazUEy8H/XTfZtrbmM0TTDI47BFAwBvCKFUnge0ZZne0uJrNCItnvHL5U2CQkE4DRTPDmI6NXVkrvfOEVS+V4w7nz+Axg66cTA13M7lCZOE5w03S+cf6QJH8p0/wDOigyKTmm7CkBfe3Aojpfn9SSpO4B1AXF+qAIzN3R14WSMN016PgVE6VIyYTz2okl7eB0l5AUKfbtp8mE5veB1g0ol3IhDdp6QHkH0S+1F0OuB98Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSwX3uVy26PfHTjysYew4h/zqDGcXsXXZfYWNKe7lcQ=;
 b=iOCGnPLtoWGRgpc0qnezWcsRB62BZYlwzt3LblYq6AzqZLsZkpFelO+bO9hkCL1bC07W1RimliO8gQ2/FKGtrpnqaUA0FD7VRo+Fy+hRDpTCBrpxMzViK+luW8S14qTrSBEUuI0UiZJoiXp4VgWiXuieQPjyCEwhwQZ7VhPeC3/9+WgyxBliaBu0ycZElyu1G+nLBUgv/yMvjQ+OYpZ/nWQrUdi67JIMZnRB3R/ENDh2v1+gIycAFEp8P0jkw3TAwwkW3AOfeUlJRhoFjvlo8kdy+i+0ezp1TcnNZVPTODL1VehhKN3IfQJ0/OEM3eVyPI/T3V+4DbzRFtU85h7ZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSwX3uVy26PfHTjysYew4h/zqDGcXsXXZfYWNKe7lcQ=;
 b=R3sxcpdbEcwnq6Nz/K+GM/NIKsVM5oMx+BoAlqiI1wrWKHcWYs8jmuj/BHNVvJS4c1Ci3fqnZh0gBhYzAdgX87iY0DcXCtxvaxtb7R5dJGGJg5IP8kUExOfRw3SxNDopT5wrH3oGKtXEDqRSc+KR5mLokxArIOyhRqnqT0ZN4eM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3552.namprd04.prod.outlook.com (10.167.139.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Wed, 22 Jan 2020 15:48:51 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 15:48:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] btrfs: remove use of buffer_heads from superblock
 writeout
Thread-Topic: [PATCH 2/5] btrfs: remove use of buffer_heads from superblock
 writeout
Thread-Index: AQHVzTTQB94QXZ7D8kKe2eneqCicmafu85uAgAf5oAA=
Date:   Wed, 22 Jan 2020 15:48:51 +0000
Message-ID: <251DEF36-9630-4A9F-A26A-D52D01ECF873@wdc.com>
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
 <20200117125105.20989-3-johannes.thumshirn@wdc.com>
 <6bdb46de-db12-27da-016d-773c362de254@suse.com>
In-Reply-To: <6bdb46de-db12-27da-016d-773c362de254@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0830be8-0f86-4ca5-8008-08d79f52941a
x-ms-traffictypediagnostic: SN4PR0401MB3552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3552C568004803A8285676C99B0C0@SN4PR0401MB3552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(6486002)(91956017)(76116006)(66476007)(66556008)(66446008)(64756008)(110136005)(316002)(66946007)(33656002)(478600001)(36756003)(5660300002)(6512007)(81156014)(81166006)(2906002)(26005)(8676002)(186003)(2616005)(6506007)(71200400001)(4326008)(8936002)(86362001)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3552;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eIBAEToYOmO9S2Mqx6d2EPlpF0aVDh1V1zFdcMGIiTWU2A1uIZm/0kUsz0tlM2uO8Q1pCaTJi/Z7hadYMTkihpgQ4jB6IUtaZJZZRZ9qdaMLO5jC7w2Hg4MB8IxUIDWrD/Uqs914oBMSaPzKNPkpdF2oDyfXjRgLmplr3ns9dWPNVqnCsL0p0wFXmyi9BNPp+pqraeizKHpzAab01r6pw7tz+wWtEYFkWRLHTMHNX81ERDoXt6csEUV7AL52aix33M6REv7smnbbm8n3bAqTJfjyn2YMRduAMYig56sYTyVuxe5ZTzEcyUQNIFAIlEsF2ZwtFBxx05bD3gO/BXE6o0pFhz16fe9Kr+gx1DwzxnYGuh1k6C0J8HE1mH4vVIrBToAXg2By6D2rgq8mlJP8a6XV/wI1TxdDOIPPqxNai0eNr9UtkFG75WLQ7J3PDTWL
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F19992E57816D4997F57284509E5948@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0830be8-0f86-4ca5-8008-08d79f52941a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 15:48:51.5254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMcRfk41pRPzVCSp9zUJhhjKOoBu1XgGs80UW0W+A1l5qLpvnFXPUuAol6nggnk2SjtScvdeVYhkE97sWRjR/JNJ1Sj39qPoPRd+6A6NNro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3552
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTcvMDEvMjAyMCwgMTY6MDEsICJsaW51eC1idHJmcy1vd25lckB2Z2VyLmtlcm5lbC5vcmcg
b24gYmVoYWxmIG9mIE5pa29sYXkgQm9yaXNvdiIgPGxpbnV4LWJ0cmZzLW93bmVyQHZnZXIua2Vy
bmVsLm9yZyBvbiBiZWhhbGYgb2YgbmJvcmlzb3ZAc3VzZS5jb20+IHdyb3RlOiANCiAgICANCiAg
ICBPbiAxNy4wMS4yMCDQsy4gMTQ6NTEg0YcuLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQog
ICAgPiBTaW1pbGFyIHRvIHRoZSBzdXBlcmJsb2NrIHJlYWQgcGF0aCwgY2hhbmdlIHRoZSB3cml0
ZSBwYXRoIHRvIHVzaW5nIEJJT3MNCiAgICA+IGFuZCBwYWdlcyBpbnN0ZWFkIG9mIGJ1ZmZlcl9o
ZWFkcy4NCiAgICA+DQogICAgPiBUaGlzIGlzIGJhc2VkIG9uIGEgcGF0Y2ggb3JpZ2luYWxseSBh
dXRob3JlZCBieSBOaWtvbGF5IEJvcmlzb3YuDQogICAgPg0KICAgID4gQ28tZGV2ZWxvcGVkLWJ5
OiBOaWtvbGF5IEJvcmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPg0KICAgID4gU2lnbmVkLW9mZi1i
eTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCiAgICA+
IC0tLQ0KICAgID4gIGZzL2J0cmZzL2Rpc2staW8uYyB8IDEwNyArKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICA+ICAxIGZpbGUgY2hhbmdlZCwgNjEgaW5z
ZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25zKC0pDQogICAgPg0KICAgID4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL2Rpc2staW8uYyBiL2ZzL2J0cmZzL2Rpc2staW8uYw0KICAgID4gaW5kZXggNTBjOTNm
ZmU4ZDAzLi41MWU3YjgzMmM4ZmQgMTAwNjQ0DQogICAgPiAtLS0gYS9mcy9idHJmcy9kaXNrLWlv
LmMNCiAgICA+ICsrKyBiL2ZzL2J0cmZzL2Rpc2staW8uYw0KICAgID4gQEAgLTMzNTMsMjUgKzMz
NTMsMzMgQEAgaW50IF9fY29sZCBvcGVuX2N0cmVlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQog
ICAgPiAgfQ0KICAgID4gIEFMTE9XX0VSUk9SX0lOSkVDVElPTihvcGVuX2N0cmVlLCBFUlJOTyk7
DQogICAgPg0KICAgID4gLXN0YXRpYyB2b2lkIGJ0cmZzX2VuZF9idWZmZXJfd3JpdGVfc3luYyhz
dHJ1Y3QgYnVmZmVyX2hlYWQgKmJoLCBpbnQgdXB0b2RhdGUpDQogICAgPiArc3RhdGljIHZvaWQg
YnRyZnNfZW5kX3N1cGVyX3dyaXRlKHN0cnVjdCBiaW8gKmJpbykNCiAgICA+ICB7DQogICAgPiAt
ICAgICBpZiAodXB0b2RhdGUpIHsNCiAgICA+IC0gICAgICAgICAgICAgc2V0X2J1ZmZlcl91cHRv
ZGF0ZShiaCk7DQogICAgPiAtICAgICB9IGVsc2Ugew0KICAgID4gLSAgICAgICAgICAgICBzdHJ1
Y3QgYnRyZnNfZGV2aWNlICpkZXZpY2UgPSAoc3RydWN0IGJ0cmZzX2RldmljZSAqKQ0KICAgID4g
LSAgICAgICAgICAgICAgICAgICAgIGJoLT5iX3ByaXZhdGU7DQogICAgPiAtDQogICAgPiAtICAg
ICAgICAgICAgIGJ0cmZzX3dhcm5fcmxfaW5fcmN1KGRldmljZS0+ZnNfaW5mbywNCiAgICA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJsb3N0IHBhZ2Ugd3JpdGUgZHVlIHRvIElPIGVy
cm9yIG9uICVzIiwNCiAgICA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByY3Vfc3RyX2RlcmVmKGRldmljZS0+bmFtZSkpOw0KICAgID4gLSAgICAgICAgICAgICAvKiBu
b3RlLCB3ZSBkb24ndCBzZXRfYnVmZmVyX3dyaXRlX2lvX2Vycm9yIGJlY2F1c2Ugd2UgaGF2ZQ0K
ICAgID4gLSAgICAgICAgICAgICAgKiBvdXIgb3duIHdheXMgb2YgZGVhbGluZyB3aXRoIHRoZSBJ
TyBlcnJvcnMNCiAgICA+IC0gICAgICAgICAgICAgICovDQogICAgPiAtICAgICAgICAgICAgIGNs
ZWFyX2J1ZmZlcl91cHRvZGF0ZShiaCk7DQogICAgPiAtICAgICAgICAgICAgIGJ0cmZzX2Rldl9z
dGF0X2luY19hbmRfcHJpbnQoZGV2aWNlLCBCVFJGU19ERVZfU1RBVF9XUklURV9FUlJTKTsNCiAg
ICA+ICsgICAgIHN0cnVjdCBidHJmc19kZXZpY2UgKmRldmljZSA9IGJpby0+YmlfcHJpdmF0ZTsN
CiAgICA+ICsgICAgIHN0cnVjdCBiaW9fdmVjICpidmVjOw0KICAgID4gKyAgICAgc3RydWN0IGJ2
ZWNfaXRlcl9hbGwgaXRlcl9hbGw7DQogICAgPiArICAgICBzdHJ1Y3QgcGFnZSAqcGFnZTsNCiAg
ICA+ICsNCiAgICA+ICsgICAgIGJpb19mb3JfZWFjaF9zZWdtZW50X2FsbChidmVjLCBiaW8sIGl0
ZXJfYWxsKSB7DQogICAgPiArICAgICAgICAgICAgIHBhZ2UgPSBidmVjLT5idl9wYWdlOw0KICAg
ID4gKw0KICAgID4gKyAgICAgICAgICAgICBpZiAoYmxrX3N0YXR1c190b19lcnJubyhiaW8tPmJp
X3N0YXR1cykpIHsNCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICBidHJmc193YXJuX3JsX2lu
X3JjdShkZXZpY2UtPmZzX2luZm8sDQogICAgPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgImxvc3QgcGFnZSB3cml0ZSBkdWUgdG8gSU8gZXJyb3Igb24gJXMiLA0K
ICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJjdV9zdHJf
ZGVyZWYoZGV2aWNlLT5uYW1lKSk7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAgQ2xlYXJQ
YWdlVXB0b2RhdGUocGFnZSk7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAgU2V0UGFnZUVy
cm9yKHBhZ2UpOw0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgIGJ0cmZzX2Rldl9zdGF0X2lu
Y19hbmRfcHJpbnQoZGV2aWNlLA0KICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQlRSRlNfREVWX1NUQVRfV1JJVEVfRVJSUyk7DQogICAgPiAr
ICAgICAgICAgICAgIH0gZWxzZSB7DQogICAgPiArICAgICAgICAgICAgICAgICAgICAgU2V0UGFn
ZVVwdG9kYXRlKHBhZ2UpOw0KICAgID4gKyAgICAgICAgICAgICB9DQogICAgPiArDQogICAgPiAr
ICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOw0KICAgIA0KICAgIElzbid0IHRoaXMgZXh0cmEg
cHV0IHBhZ2U/IFBlcmhhaHBzIGl0J3Mgbm90IGJlY2F1c2UgdGhhdCB3b3VsZCBiZSB0aGUNCiAg
ICByZWZlcmVuY2UgZnJvbSBmaW5kX29yX2NyZWF0ZV9wYWdlIGluIHdyaXRlX2Rldl9zdXBlcnMu
IEluIGFueSBjYXNlIEknZA0KICAgIHJhdGhlciBoYXZlIGl0IGluIHRoYXQgZnVuY3Rpb24uDQoN
Ck5vIHdlIGNhbid0IGRvIHRoZSBwdXRfcGFnZSgpIGluIGluIHdyaXRlX2Rldl9zdXBlcnMoKSBh
cyBidHJmc19lbmRfc3VwZXJfd3JpdGUoKQ0KaXMgdGhlIGJpbyBlbmRpbyBob29rIGFuZCBpdCdz
IGNhbGxlZCB1cG9uIGNvbXBsZXRpb24gb2YgdGhlIGJpby4gVGhpcyBoYXBwZW5zDQphc3luY2hy
b25vdXMgdG8gd3JpdGVfZGV2X3N1cGVycygpLg0KDQoNCg==
