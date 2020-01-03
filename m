Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2912F407
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 06:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgACFL6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 00:11:58 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:54631 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgACFL6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 00:11:58 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Fri,  3 Jan 2020 05:10:55 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 3 Jan 2020 05:11:39 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 3 Jan 2020 05:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmGiW9+EH2CoMnTCdaF0AW2q7OjsFdUNIEqESGRmYlVMZ1BRsx6yfleoW9ZMud5hGe7qul+F+wDwrmwx7nb+rEPyzc5yJ+zAib4mYrt691zURzrgJcHc/inDXvVvpMuq0obhulWoje30p1RRT/5zQITamab8IZP+NGdNsIsydO7kE3SrGfhblpoG8xCtEb4kcZfHaXJEujmFZnqvh4PzpweyDu5Y4WwHp7HOwG39o4S/YXfpmq90+gimVhGuoAyOyM7FpR6FI7oJ+Thw5DTsVloPjIxgdVSOsr5vbxyhvCcaAdFSshXRRUdHdtReCDpzoRU9OwYJvDqg2GaxARLSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QjzjxBJSC6Anr25fFFnh4skNqvbeFh9emoJX5lP74c=;
 b=W3WZxnOkFJt2OPAUDDDQ9Ayes0n7lNymRZqKNf0wF99f4Q+b7hgRMdoZNP8oUiPqNCD1ePvaNrUdXQz8A0u77KASI5sTmzEK4pyiwh3p9C84QYoQJlhT+dWcVWkrfKHBDWd/a5UC6iNk4o2CZbJ0O/Bu+Nt6QHCJA3w76cD7lKRNjYMA2oktwiF8lw8Oqq+Zr6v4chdbAiPDYLterp9cYkWdEQIOiOguuG/1P5BJkBkCjj/GsiYmeLwKhNAkEJgBsXlGOEneUUUDASZ42TBOYFAN0hxTOlJpCn9YBkPc67h/byqe7XQqogJ8rmPAJ81Kjt91U8/Dgac+KkEI7rJZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3362.namprd18.prod.outlook.com (10.255.154.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 05:11:36 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 05:11:36 +0000
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0064.namprd07.prod.outlook.com (2603:10b6:a03:60::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Fri, 3 Jan 2020 05:11:34 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
CC:     David Sterba <DSterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [btrfs-progs PATCHv3 1/3] tests: common: Add
 check_dm_target_support helper
Thread-Topic: [btrfs-progs PATCHv3 1/3] tests: common: Add
 check_dm_target_support helper
Thread-Index: AQHVwdrhRUBNrBaswk+pPLETQKvJ3afYZNAA
Date:   Fri, 3 Jan 2020 05:11:35 +0000
Message-ID: <dffcf953-a4bd-c6ba-59a0-c94c53063636@suse.com>
References: <20200103021215.30147-1-marcos.souza.org@gmail.com>
 <20200103021215.30147-2-marcos.souza.org@gmail.com>
In-Reply-To: <20200103021215.30147-2-marcos.souza.org@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:a03:60::41) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fde8905-e9cb-49f9-8e21-08d7900b67ca
x-ms-traffictypediagnostic: BY5PR18MB3362:
x-ld-processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB33623A8CEF517AD5AEA6D278D6230@BY5PR18MB3362.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(189003)(199004)(16526019)(26005)(2616005)(2906002)(956004)(6706004)(478600001)(6916009)(4326008)(31696002)(186003)(52116002)(8676002)(81156014)(81166006)(8936002)(107886003)(5660300002)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(6486002)(16576012)(4744005)(31686004)(36756003)(86362001)(316002)(54906003)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3362;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cL5vPamzP2lk8Pu13O3msfzZiqEyN9PRk697FRm2rMGLNq4LMqJwFtkuYs1DJSMDB8Yl60cI8CwKw9zS8WhKr+RcrWrD3Rr87FbgkYrPb7gULa/5mYYjQsOpCCHAtzdf7rCajJNzC0w0FqBChiqEAc6yN8uuUlWbxLSYHco/w1lqYbfEkEyBAFzOKFMwRTdgtEEkKTkA86H+3X0grLDo5tRYOrbBiyr07YAlgrBZKpmDM5+J9kwlYA8UXRWwjWeB0IfiKE9A+uXTBzGPMZGGlqDsIAyqFc+wfnMztfv6OZMZQ1w7FxvFjnJGxRTJ2l+t/gnAzkLkGbvBqxNiS8qtkrjhNmsxCnZO3xzJCYQlUkuJSTGyNxgLu1bae3KYmJdYO2vSIIGUOuEcL9y7iWi2BvcGEi+E99l6JGERVmgIfT67RKrRD3x0ods5KWz7nsg/pm0ae1q0xMtkZUUwENq/tPaAgRMmjF3MVLMAN14PEaMexk4475DNIv5kkgsXiPk
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A16129134EF724B9E8A69F4D24346E1@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fde8905-e9cb-49f9-8e21-08d7900b67ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 05:11:35.9310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efJ3qfXga7b8MFlfikhdrdXrFmHj472OVq5PgdLlWYWbyaWQlYRjgdi/nIC11gjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3362
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjAvMS8zIOS4iuWNiDEwOjEyLCBNYXJjb3MgUGF1bG8gZGUgU291emEgd3JvdGU6
DQo+IEZyb206IE1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPg0KPiAN
Cj4gVGhpcyBmdW5jdGlvbiB3aWxsIGJlIHVzZWQgbGF0ZXIgdG8gdGVzdCBpZiBkbS10aGluIGlz
IHN1cHBvcnRlZC4NCj4gSW5zcGlyZWQgYnkgZnN0ZXN0cy4NCj4gDQo+IFN1Z2dlc3RlZC1ieTog
UXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvcyBQYXVsbyBk
ZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPg0KDQpSZXZpZXdlZC1ieTogUXUgV2VucnVvIDx3
cXVAc3VzZS5jb20+DQoNClRoYW5rcywNClF1DQoNCj4gLS0tDQo+ICB0ZXN0cy9jb21tb24gfCAx
NSArKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvY29tbW9uIGIvdGVzdHMvY29tbW9uDQo+IGluZGV4IGNh
MDk4NDQ0Li4zZWE4YzI2MCAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvY29tbW9uDQo+ICsrKyBiL3Rl
c3RzL2NvbW1vbg0KPiBAQCAtMzIyLDYgKzMyMiwyMSBAQCBjaGVja19nbG9iYWxfcHJlcmVxKCkN
Cj4gIAlmaQ0KPiAgfQ0KPiAgDQo+ICsjIGNoZWNrIGlmIHRoZSB0YXJnZXRzIHBhc3NlZCBhcyBh
cmd1bWVudHMgYXJlIGF2YWlsYWJsZSwgYW5kIGlmIG5vdCBqdXN0IHNraXANCj4gKyMgdGhlIHRl
c3QNCj4gK2NoZWNrX2RtX3RhcmdldF9zdXBwb3J0KCkNCj4gK3sNCj4gKwlzZXR1cF9yb290X2hl
bHBlcg0KPiArDQo+ICsJZm9yIHRhcmdldCBpbiAiJEAiOyBkbw0KPiArCQkkU1VET19IRUxQRVIg
bW9kcHJvYmUgZG0tJHRhcmdldCA+L2Rldi9udWxsIDI+JjENCj4gKwkJJFNVRE9fSEVMUEVSIGRt
c2V0dXAgdGFyZ2V0cyAyPiYxIHwgZ3JlcCAtcSBeJHRhcmdldA0KPiArCQlpZiBbICQ/IC1uZSAw
IF07IHRoZW4NCj4gKwkJCV9ub3RfcnVuICJUaGlzIHRlc3QgcmVxdWlyZXMgZG0gJHRhcmdldCBz
dXBwb3J0LiINCj4gKwkJZmkNCj4gKwlkb25lDQo+ICt9DQo+ICsNCj4gIGNoZWNrX2ltYWdlKCkN
Cj4gIHsNCj4gIAlsb2NhbCBpbWFnZQ0KPiANCg==
