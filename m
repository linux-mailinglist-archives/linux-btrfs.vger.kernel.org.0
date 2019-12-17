Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5FF12250F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 07:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLQGzJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 01:55:09 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:37128 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfLQGzI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 01:55:08 -0500
X-Greylist: delayed 993 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2019 01:55:07 EST
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue, 17 Dec 2019 06:53:53 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 17 Dec 2019 06:36:53 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 17 Dec 2019 06:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhOIEeWQoXQYeFHrrYwPpKLyRAkvbTnczP3jYy1Dn+ltBRopmKJeE5DBGSXdiBGeMbghPu5lOJrWsKsKR8ET0267e/5bedA4XpgZLQWLUk5/46Bmpxqe2q7Hwo86oTdY/zzzA5uGYxD30oWie52u8kQ3pjvngpq6XnhvLbkMmo2kpI0YHqKBN+zFafHl2ifZKoktMtOr7U5PDMEIeqpH4DZXKCt9FiWp9ZIkaI9GIFT67HYCRDq9pie9HiWJSdcWG/sTz0HS8n1SoHkXDRkxghMOLF6GpUjIQY46dQPVUDe0B5ZdW5raKe5Nk0cv8qPwzImGdZpthqZwTrtbSIgOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY851qANzem1IftVWSU0DRm+zROlUCkpTbjl2ti8ZSA=;
 b=OZAG6wubTfTRqEyhhluqjHC8MYMyuaqfbTwE2zlZCPkA+H11W+oSofFKSOzQH5cad5YuQ4Q5eZmDXZS7pVWBS5t4vIGQNrHq6OpV8vzRTm8Go1PgWFJR2Mfmn+l84Mcrg+hLyQWdxbOWE7PdjOhgEsqQpFGr4aW2i/Cs7pWCieaKnVBXVXh8g9w0+tAsQ6sVChV9p0uUCx/11rLpeAasVk+NDHRwVqH1GNrQrXQcyl6v6YMQ5GNfKAFbj6BXz0jUHWH41YTxXacFqnKptaL192/Dk43xtxm3nbFYtxThoBaVLGf8bLrIDla6t2KmOj7f3vegPWOUlz1QZ8rAhy1BBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MN2PR18MB2685.namprd18.prod.outlook.com (20.179.82.223) by
 MN2PR18MB3056.namprd18.prod.outlook.com (20.179.21.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Tue, 17 Dec 2019 06:36:52 +0000
Received: from MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::b47f:8d41:b41f:5308]) by MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::b47f:8d41:b41f:5308%6]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 06:36:52 +0000
From:   Long An <lan@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: [PATCH] btrfs-progs: tests: mkfs/011: Fix path for rootdir
Thread-Topic: [PATCH] btrfs-progs: tests: mkfs/011: Fix path for rootdir
Thread-Index: AQHVtKRdRTt2O7u7lEKBDUilJ/XjMQ==
Date:   Tue, 17 Dec 2019 06:36:51 +0000
Message-ID: <1576564610.3899.20.camel@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lan@suse.com; 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb8e4c58-fc90-43ea-c601-08d782bb8075
x-ms-traffictypediagnostic: MN2PR18MB3056:
x-microsoft-antispam-prvs: <MN2PR18MB3056C6A07ECE94B67EFA3647C6500@MN2PR18MB3056.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(189003)(199004)(478600001)(8936002)(26005)(6916009)(66476007)(66446008)(2616005)(6512007)(103116003)(64756008)(316002)(71200400001)(66556008)(2906002)(8676002)(6486002)(81166006)(81156014)(186003)(86362001)(36756003)(76116006)(91956017)(6506007)(66946007)(4744005)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB3056;H:MN2PR18MB2685.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9WJDg8PPTIU8mcekImWMZO/ZaSThmWeRi31i0AXt73BFtFnzd2b3l1vuf7IfKdySNneQ5swqxal5Upmpnceng61UhB2BaOTYUSLs1HkShk5aFluNNZMv3dHZULfiuffBsxf4qMXmRaRBOM1aVP8g9zSUnYhPUfbSTo8Xr6Y+sHgtRdIfgioRoR7nX+JAIVUwwm9QlLm59kJYAoZCaYzpTD2KJLi9PNN+hQn/YtV/NmbDYlofLHx4BzoYFE6RC5D9MNmLafalGqi3hGj4WFesjUayIou0Vo2Mkm53xRNgIJbcSw+/NJq7GOlzwOIZRmF3NlV/lBMYK66gx6141mD71CthRxfwPvMaIbGzTAm/6ktMz6YnA2/UZF9d3LQ0tet0ZQmkeNi6OGy+vXH8eDYYTYZ8O+hU5g1skO6UQ6Stq3DkGyZ99WzYCQ9tZ5HxjY/B
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B1D8BD7CA657740BB7D3581EDB68D69@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8e4c58-fc90-43ea-c601-08d782bb8075
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 06:36:51.9802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7STWHKnhkhc/6Ph+BXYfv5kPI8Ae1Xoe9mRj3MXrGXCWUeWMu9UKSdXcksnZCHw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3056
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

RG9jdW1lbnRhdGlvbiBmb2xkZXIgcGF0aCBpcyB3cm9uZyBvbiBleHBvcnRlZCB0ZXN0c3V0aWUu
IEZpeCB0aGlzIGJ5DQpyZXBsYWNlIFRPUCB3aXRoIElOVEVSTkFMX0JJTi4NCg0KU2lnbmVkLW9m
Zi1ieTogQW4gTG9uZyA8bGFuQHN1c2UuY29tPg0KLS0tDQogdGVzdHMvbWtmcy10ZXN0cy8wMTEt
cm9vdGRpci1jcmVhdGUtZmlsZS90ZXN0LnNoIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvdGVzdHMvbWtmcy10ZXN0
cy8wMTEtcm9vdGRpci1jcmVhdGUtZmlsZS90ZXN0LnNoIGIvdGVzdHMvbWtmcy10ZXN0cy8wMTEt
cm9vdGRpci1jcmVhdGUtZmlsZS90ZXN0LnNoDQppbmRleCAyMGY3YzRjZS4uYTIxYzYyNDUgMTAw
NzU1DQotLS0gYS90ZXN0cy9ta2ZzLXRlc3RzLzAxMS1yb290ZGlyLWNyZWF0ZS1maWxlL3Rlc3Qu
c2gNCisrKyBiL3Rlc3RzL21rZnMtdGVzdHMvMDExLXJvb3RkaXItY3JlYXRlLWZpbGUvdGVzdC5z
aA0KQEAgLTEwLDYgKzEwLDYgQEAgY2hlY2tfcHJlcmVxIG1rZnMuYnRyZnMNCiB0bXA9JChta3Rl
bXAgLWQgLS10bXBkaXIgYnRyZnMtcHJvZ3MtbWtmcy5yb290ZGlyWFhYWFhYWCkNCiAjIHdlIGNh
bid0IHVzZSBURVNUX0RFViwgYSBmaWxlIGlzIG5lZWRlZA0KIGltZz0kKG1rdGVtcCBidHJmcy1w
cm9ncy1ta2ZzLnJvb3RkaXJYWFhYWFhYKQ0KLXJ1bl9jaGVjayAiJFRPUC9ta2ZzLmJ0cmZzIiAt
ZiAtLXJvb3RkaXIgIiRUT1AvRG9jdW1lbnRhdGlvbi8iICIkaW1nIg0KK3J1bl9jaGVjayAiJFRP
UC9ta2ZzLmJ0cmZzIiAtZiAtLXJvb3RkaXIgIiRJTlRFUk5BTF9CSU4vRG9jdW1lbnRhdGlvbi8i
ICIkaW1nIg0KIA0KIHJtIC1yZiAtLSAiJGltZyINCi0tIA==
