Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48B6BF0E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfIZLNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 07:13:35 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:45541 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbfIZLNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 07:13:35 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY m4a0041g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu, 26 Sep 2019 11:11:37 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 26 Sep 2019 11:12:45 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 26 Sep 2019 11:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3LWVrg2b5lh4r4LkB5gzaizg/ZCl5DtdZmBQcYGYc8ri74Y3Txghd1QSgC0gLEEgehYh3ptfn20c+0NLviRvRVyhGf/b8w06FqCzm5za4CKsHXy2MCP9UKJoou+xKSNcSo+lSK8TFT7WiBKD+sYS+Q5V2FiUFIKOTVx28RVLH73bfw2Nkw+slFdadkLO3us2v30nxRJ+kbZuQAcioWMyoHXkmw1ZLFpoiC2V3ZV9Zj0bgMkPHsZnGFslf9DcY9sm8m2lhU2g5w7jlLqhb72+DwRfhA7FLyC4KjMSsJEMIhiBP8eCm+0D8aU7v51PtXzjuNLcZxpZLacaQRBXJZWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZQvoXN8U78ceDFWTHpyZpPdvyACDRBOGC/RpXfXlmI=;
 b=BZaA/G7vELwaqT58hoskB1KBtJ99h1hS3uNLHMz7c0cY+JgtX0O1CozbxCPvJfGRq929UW8CuH0/Z1JVvWAa9n5PVQMnbB/Z30RHv5Wls3FK5lWLJoCzZ1Dbl+vEnmFiMo0xgq2VUK+fKk/ulxabDgCsoGTWUTL8NoK2nAEsNsVmXCwHSf2cNX2sUn5ACE5TbQSkK9kGdWvF73lkPbVNWYWpLMFrVK2f1+hPQGWLs3eMmTqyuqJrqBXEzS3qivtKyl3Lwf7UeLpWh9t/d7KEUjarAV/HDVNH4BFQQIYW0b8BA5Ldz0QWjjPvdhVvYjVg387xh406dQaRTy1cfdy4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DM5PR18MB1290.namprd18.prod.outlook.com (10.173.209.136) by
 DM5PR18MB2277.namprd18.prod.outlook.com (52.132.143.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Thu, 26 Sep 2019 11:12:44 +0000
Received: from DM5PR18MB1290.namprd18.prod.outlook.com
 ([fe80::4c1d:a9d6:e170:5ac9]) by DM5PR18MB1290.namprd18.prod.outlook.com
 ([fe80::4c1d:a9d6:e170:5ac9%6]) with mapi id 15.20.2305.017; Thu, 26 Sep 2019
 11:12:43 +0000
From:   Long An <lan@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: [PATCH] btrfs-progs: add clean-test.sh to testsuite-files
Thread-Topic: [PATCH] btrfs-progs: add clean-test.sh to testsuite-files
Thread-Index: AQHVdFtRp0XfIUjtDEimTyC0s0AsoA==
Date:   Thu, 26 Sep 2019 11:12:43 +0000
Message-ID: <1569496362.4199.11.camel@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lan@suse.com; 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c033f46-ff26-4752-fc32-08d742727435
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR18MB2277;
x-ms-traffictypediagnostic: DM5PR18MB2277:
x-microsoft-antispam-prvs: <DM5PR18MB227703377764471CDAFAFEB9C6860@DM5PR18MB2277.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(199004)(189003)(25786009)(26005)(102836004)(64756008)(316002)(99286004)(66446008)(7736002)(76116006)(71200400001)(91956017)(66476007)(2616005)(6506007)(476003)(66066001)(486006)(186003)(305945005)(6916009)(36756003)(2906002)(256004)(86362001)(3846002)(66946007)(71190400001)(8936002)(6486002)(2501003)(103116003)(6512007)(66556008)(8676002)(81166006)(81156014)(2351001)(14454004)(5660300002)(4744005)(6116002)(478600001)(5640700003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR18MB2277;H:DM5PR18MB1290.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ey1t/9tU4GrxV76QMAoV3jcf7vB5fc2vuMGcOm4nf+5JYiKh48mBgqDORUHwdMeuGhqoPqltFoi9YFR6nlbItBH/cK8tMqb19LCskNGut8Q3d3oVxsyJsp/n/M1qFv6NDuTWU/WU9P3CRt+szNJYxsc1qG5QyaAu1W0wLLFEEpmNT7yowp4Q/ruATGgUWQvC9u3Syz2mAWRn1sbvCpUJ4Gekx+IFA/94h6lw84cad9wG4kNEQ/xvE0xn3NIxR0dkOJAul/FypSdhHzLCUlX05/fa3W53g+JDzjIKx+I/1O+8Aa8Zm8xMFh94JzVZO/wJ7rGN+czvCN4oPwo+OPZYlLraiC0P5CHv2IEAytfPebT5MRndjZPOUqnM9UHCsVzC1oQe6lyOlRXnTTA7B2h95UYnw6gvWqJBz/BA2Om2rVI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E8B68072B06B147BE60503BFCE600CD@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c033f46-ff26-4752-fc32-08d742727435
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 11:12:43.7135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 039sDbGCV4/C5F6maTZMEh25mwfvRBwSt3YENOpn4ARDYi19mNiyNu7wiaRkGTPL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2277
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ICAgIGJ0cmZzLXByb2dzOiBhZGQgY2xlYW4tdGVzdC5zaCB0byB0ZXN0c3VpdGUtZmlsZXMNCiAg
ICANCiAgICBJZiBnZW5lcmF0ZSB0ZXN0c3VpdGUgdGFyYmFsbCBieSAnbWFrZSB0ZXN0c3VpdGUn
LCB0aGVyZSBpcyBubw0KICAgIGNsZWFuLXRlc3Quc2ggaW4gaXQuIEJ1dCBzb21lIHRlc3RzIG5l
ZWQgY2xlYW51cCBpZiBhIHRlc3RjYXNlDQpmYWlsZWQuDQoNClNpZ25lZC1vZmYtYnk6IEFuIExv
bmcgPGxhbkBzdXNlLmNvbT4NCi0tLQ0KIHRlc3RzL3Rlc3RzdWl0ZS1maWxlcyB8IDEgKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQoNCmRpZmYgLS1naXQgYS90ZXN0cy90ZXN0
c3VpdGUtZmlsZXMgYi90ZXN0cy90ZXN0c3VpdGUtZmlsZXMNCmluZGV4IGQ3NWUyMzU2Li4wOWRm
NjI5OCAxMDA2NDQNCi0tLSBhL3Rlc3RzL3Rlc3RzdWl0ZS1maWxlcw0KKysrIGIvdGVzdHMvdGVz
dHN1aXRlLWZpbGVzDQpAQCAtMjAsMyArMjAsNCBAQCBHIHRlc3RzL21rZnMtdGVzdHMvDQogRiBt
a2ZzLXRlc3RzLnNoDQogRiBzY2FuLXJlc3VsdHMuc2gNCiBGIHRlc3QtY29uc29sZS5zaA0KK0Yg
Y2xlYW4tdGVzdHMuc2gNCg0K
