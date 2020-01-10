Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851D5136A86
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 11:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgAJKHb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 05:07:31 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:44655 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgAJKHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 05:07:30 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Fri, 10 Jan 2020 10:06:18 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 10 Jan 2020 09:49:14 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 10 Jan 2020 09:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7Rw/3V9hpO/5+zWMA+Kkam+sGLAdv5ES3wKk/E014akPFJE9z5Xjzln85lVEwwohLfVwam/UlkjogBKft+M5F7Qz8CDTsDYBwJWOnc2c08rMEcek7aNr6ELiQx1tBCQ7O3ZU+C4fv5g+OeZ7YR/6JnsPClYjiizhhWiGR6QEVGiy33ST41OXAqDVFAPYXf5tTkDcJKRRsG3peqit8D/BdF64eqeuP3C0g2+Rv3TUAqPDqBerx53jeYNlVeFQKC73RGkci7i3g2wXLsTzvilG5IklRgrdvkvuBNAnr26xXH+x9oYs2YUnkncumbJJ17ljCjmQ5G2NNskWFtoUpoJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG6idBJgUpY70DSZKqtiGN8qB/0RSt8xQ65CldmE3hk=;
 b=MM/Fx0BY8tdweNaW0P6FSccoyYVXUrelgBy+6ha2pXiKH1NpGleiM0pFSPf7oyz1HqYtGRmWRhNlO+UXhFjpn29yKU9RveUHFlCKDn9t6wyHKW3t+qcsxvOD3vo6FtVhm5kd8a2va40nEQsx5g+BPPbadk/tKR/bolNfixDbomYnueUIx9qdNXBqLgvqYtdfcysrhWssVvwX/xz9Apow94lpPNU5GYsjDktSJiuA6sssUnUnYbFDdycI0Pnsm9Exihb38OYMcX6zfcs5AiPNtJBRhiod00uXkt2F19axYmNeNhg8NAxDPdcXf7zd4kVudQOdTRApUskPB0UXtMpHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MN2PR18MB2685.namprd18.prod.outlook.com (20.179.82.223) by
 MN2PR18MB2543.namprd18.prod.outlook.com (20.179.81.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 09:49:13 +0000
Received: from MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::898e:fc64:f921:63b1]) by MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::898e:fc64:f921:63b1%6]) with mapi id 15.20.2602.018; Fri, 10 Jan 2020
 09:49:13 +0000
From:   Long An <lan@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: [PATCH] btrfs-progs: fix path for btrfs-corrupt-block
Thread-Topic: [PATCH] btrfs-progs: fix path for btrfs-corrupt-block
Thread-Index: AQHVx5s3/eI01S0gcUu32NL/HjZObg==
Date:   Fri, 10 Jan 2020 09:49:13 +0000
Message-ID: <1578649752.3609.6.camel@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lan@suse.com; 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac2daa9a-e213-47d7-d05a-08d795b259b9
x-ms-traffictypediagnostic: MN2PR18MB2543:
x-microsoft-antispam-prvs: <MN2PR18MB2543FC353FBF39CDDFD22CADC6380@MN2PR18MB2543.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(86362001)(316002)(103116003)(81156014)(81166006)(26005)(6506007)(36756003)(478600001)(8676002)(8936002)(186003)(5660300002)(2616005)(66446008)(64756008)(66556008)(66476007)(66946007)(6512007)(2906002)(91956017)(71200400001)(6486002)(76116006)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB2543;H:MN2PR18MB2685.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H76SWQ4mKpp5RZ0a5d3aAOrDH700VuIW7L0u/0W6ixaacBn9Zx0f3PSmkD3FvpC6CTdDBC+6mcB4swgf+lt+tRl12XxaRtGsb1K1e/uUJulV8qPnx9ScwXPcU3RUxLLvH0+ikjol1Ie6PBOcIE9qiQA9SqzQswc6YjJ2ydKWl2pPsKfaSkAjeVGBctzRlpYlt3SnfNiF8zDtDHnImvKP8gaxjGX0Oh75i7VOtwrOGozXpzt/ntcKld8lCSmcrmI/DuuATWvoccWziR8cco0eP5CQObZiVWGN4MlVvs2CgA0Dmtn8IMmo0mkQJhNYWEhvewXJqah0SnYctxkPefoGiiqU92Rrpo0U0bFq1dqBSjJdJQKieyJ2go80lILrdQ0EyOO2TCk23V8jlroDde4imEnSGhANxiPgtg1sHzdtdrUvkfqyde8xVXcFlg6CWhUc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C031F83FAC12E41A6538A02F1F48AC8@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2daa9a-e213-47d7-d05a-08d795b259b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 09:49:13.6872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XH7+hG81DPi2ccpniOd1iMfP4P2AWIEpb/Eo2kHTxvvjOAZbah3vEQwrGU6e3UGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2543
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

YnRyZnMtY29ycnVwdC1ibG9jayBwYXRoIGlzIHdyb25nIG9uIGV4cG9ydGVkIHRlc3RzdXRpZS4g
Rml4IHRoaXMgaXNzdWUNCmZvciBiZWxvdyB0ZXN0czoNCmZzY2stdGVzdHMvMDM3LWZyZWVzcGFj
ZXRyZWUtcmVwYWlyDQptaXNjLXRlc3RzLzAzOC1iYWNrdXAtcm9vdC1jb3JydXB0aW9uDQoNClNp
Z25lZC1vZmYtYnk6IEFuIExvbmcgPGxhbkBzdXNlLmNvbT4NCi0tLQ0KIHRlc3RzL2ZzY2stdGVz
dHMvMDM3LWZyZWVzcGFjZXRyZWUtcmVwYWlyL3Rlc3Quc2ggICB8IDIgKy0NCiB0ZXN0cy9taXNj
LXRlc3RzLzAzOC1iYWNrdXAtcm9vdC1jb3JydXB0aW9uL3Rlc3Quc2ggfCAyICstDQogMiBmaWxl
cyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS90ZXN0cy9mc2NrLXRlc3RzLzAzNy1mcmVlc3BhY2V0cmVlLXJlcGFpci90ZXN0LnNoDQpiL3Rl
c3RzL2ZzY2stdGVzdHMvMDM3LWZyZWVzcGFjZXRyZWUtcmVwYWlyL3Rlc3Quc2gNCmluZGV4IGQ3
ZWUwZjIxLi40OTE2NWZjZCAxMDA3NTUNCi0tLSBhL3Rlc3RzL2ZzY2stdGVzdHMvMDM3LWZyZWVz
cGFjZXRyZWUtcmVwYWlyL3Rlc3Quc2gNCisrKyBiL3Rlc3RzL2ZzY2stdGVzdHMvMDM3LWZyZWVz
cGFjZXRyZWUtcmVwYWlyL3Rlc3Quc2gNCkBAIC00Niw3ICs0Niw3IEBAIGNvcnJ1cHRfZnN0X2l0
ZW0oKQ0KICAgICAgICAgICAgICAgIF9mYWlsICJVbmtub3duIGl0ZW0gdHlwZSBmb3IgY29ycnVw
dGlvbiINCiAgICAgICAgZmkNCg0KLSAgICAgICBydW5fY2hlY2sgIiRUT1AvYnRyZnMtY29ycnVw
dC1ibG9jayIgLXIgMTAgLUsNCiIkb2JqZWN0aWQsJHR5cGUsJG9mZnNldCIgXA0KKyAgICAgICBy
dW5fY2hlY2sgIiRJTlRFUk5BTF9CSU4vYnRyZnMtY29ycnVwdC1ibG9jayIgLXIgMTAgLUsNCiIk
b2JqZWN0aWQsJHR5cGUsJG9mZnNldCIgXA0KICAgICAgICAgICAgICAgIC1mIG9mZnNldCAiJFRF
U1RfREVWIg0KIH0NCg0KZGlmZiAtLWdpdCBhL3Rlc3RzL21pc2MtdGVzdHMvMDM4LWJhY2t1cC1y
b290LWNvcnJ1cHRpb24vdGVzdC5zaA0KYi90ZXN0cy9taXNjLXRlc3RzLzAzOC1iYWNrdXAtcm9v
dC1jb3JydXB0aW9uL3Rlc3Quc2gNCmluZGV4IGYxNWQwYmJhLi5hOTcwNjkxYiAxMDA3NTUNCi0t
LSBhL3Rlc3RzL21pc2MtdGVzdHMvMDM4LWJhY2t1cC1yb290LWNvcnJ1cHRpb24vdGVzdC5zaA0K
KysrIGIvdGVzdHMvbWlzYy10ZXN0cy8wMzgtYmFja3VwLXJvb3QtY29ycnVwdGlvbi90ZXN0LnNo
DQpAQCAtMjcsNyArMjcsNyBAQCBtYWluX3Jvb3RfcHRyPSQoZHVtcF9zdXBlciB8IGdyZXAgcm9v
dCB8IGhlYWQgLW4xIHwNCmF3ayAne3ByaW50ICQyfScpDQoNCiBbICIkYmFja3VwMl9yb290X3B0
ciIgLWVxICIkbWFpbl9yb290X3B0ciIgXSB8fCBfZmFpbCAiQmFja3VwIHNsb3QgMg0KaXMgbm90
IGluIHVzZSINCg0KLXJ1bl9jaGVjayAiJFRPUC9idHJmcy1jb3JydXB0LWJsb2NrIiAtbSAkbWFp
bl9yb290X3B0ciAtZiBnZW5lcmF0aW9uDQoiJFRFU1RfREVWIg0KK3J1bl9jaGVjayAiJElOVEVS
TkFMX0JJTi9idHJmcy1jb3JydXB0LWJsb2NrIiAtbSAkbWFpbl9yb290X3B0ciAtZg0KZ2VuZXJh
dGlvbiAiJFRFU1RfREVWIg0KDQogIyBTaG91bGQgZmFpbCBiZWNhdXNlIHRoZSByb290IGlzIGNv
cnJ1cHRlZA0KIHJ1bl9tdXN0ZmFpbCAiVW5leHBlY3RlZCBzdWNjZXNzZnVsIG1vdW50IiBcDQot
LQ0KMi4xNi40DQo=
