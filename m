Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE05CD86
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfGBK0U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:26:20 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:41627 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbfGBK0U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:26:20 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.190) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:25:44 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:08:01 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:08:01 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:08:00 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:08:00 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 14/14] btrfs-progs: image: Fix error output to show correct
 return value
Thread-Topic: [PATCH v2 14/14] btrfs-progs: image: Fix error output to show
 correct return value
Thread-Index: AQHVML4HxW4IBy9vgEGUd2ecEFvxrw==
Date:   Tue, 2 Jul 2019 10:08:00 +0000
Message-ID: <20190702100650.2746-15-wqu@suse.com>
References: <20190702100650.2746-1-wqu@suse.com>
In-Reply-To: <20190702100650.2746-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [240e:3a1:c40:c630::a40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 858afc33-436b-4182-978d-08d6fed5296b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB328431852E549F03E467A5BCD6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:323;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(4744005)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X7rI6LNwlYPkcHFzrWb4kuo9a0vmOtmx82odWmf4L38kQaN9nLsuYI/+Iah7v3wuaX5iACd9xp1prlszqRK5WvUGUFV5Sw9wg6YmnSli44Njs+myddQH1RJ26w1+j/RYQiRTqslIn9lPsRWx8nhbBpks0bkPKKybe7GsXWguxKlBB6pV5Bm/OibXs2CRLDLsfYB9wcMmXUGfv0g6R+U2Jdxp6RcyzdZQPYYD2p9R/QYZUyVLu9P7P4CIscw1QdILSbe7UI6Z5GVt5mFeVo/0J5RjKkCIFSgcTF3HrPRCLGLypzLJIOT/zN7aAC2nIoHCM+udJBH1YlDJnC7yAGNz3xp+xTiC+ocjq40/uBDlbuRl6ZaBAVZPUGjzQ73kBIVvwh8tz/nXxxM2SfBuVgWb6pwBKiYKvtjmKYwbpAvZAJ0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 858afc33-436b-4182-978d-08d6fed5296b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:08:00.2206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqu@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3284
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can easily get confusing error message like:
  ERROR: restore failed: Success

This is caused by wrong "%m" usage, as we normally use ret to indicate
error, without populating errno.

This patch will fix it by output the return value directly as normally
we have extra error message to show more meaning message than the return
value.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/image/main.c b/image/main.c
index 0be3b45569ed..2bf3cfe395ec 100644
--- a/image/main.c
+++ b/image/main.c
@@ -3150,7 +3150,7 @@ int main(int argc, char *argv[])
 				       0, target, multi_devices);
 	}
 	if (ret) {
-		error("%s failed: %m", (create) ? "create" : "restore");
+		error("%s failed: %d", (create) ? "create" : "restore", ret);
 		goto out;
 	}
 
-- 
2.22.0

