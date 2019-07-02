Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2A5CD84
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfGBKZx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:25:53 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:52519 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfGBKZw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:25:52 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.190) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:25:31 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:15 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:15 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:14 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:14 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 01/14] btrfs-progs: image: Use SZ_* to replace intermediate
 size
Thread-Topic: [PATCH v2 01/14] btrfs-progs: image: Use SZ_* to replace
 intermediate size
Thread-Index: AQHVML3r9pskepmeWUWZiUYvBQX99Q==
Date:   Tue, 2 Jul 2019 10:07:14 +0000
Message-ID: <20190702100650.2746-2-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: 45967bce-d065-40c4-721a-08d6fed50e10
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB32843DE3BBAEFC55699EFE36D6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(4744005)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 53YokBJ5Qv147h+p5VXIvS/gbVrHgq/8QNQu2kKEq7CN5TQlw7U5oHekLCLJcNJeq4nSBSA9Y5tSioYhPjmgfRCvOhTpEpVwtjKxVmH87PG2qZHiZzCTYUgNYRCLpBHaRxhRb1moP/Ju0aVOwM9iKO/nluEqb+088T03ariZEa8AjStImLU33XCS/j4gQzvSIks1MPjN07svk+saj/5YW4QqjtVyhIJbGgkftpMt1mIo15/RinLFYgjOUlbTjRxwAACjHGRIQr840N7pTDbuKl0iehUcgrnhrcYzHCHzdXNXB5tt8cWPBNo3a1oTBrz0Ekom1snRHsb8QnbwpPmLq8rB2gkwauqJ7Wobrod+nC4B3ZS/LAPcfm3pAVfzlBbVbgWqRLb18Wuvm88x5mV3hsOieoPvwLGKBW0Mm54SsaA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45967bce-d065-40c4-721a-08d6fed50e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:14.3468
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/metadump.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/image/metadump.h b/image/metadump.h
index 8ace60f503d0..f85c9bcfb813 100644
--- a/image/metadump.h
+++ b/image/metadump.h
@@ -23,8 +23,8 @@
 #include "ctree.h"
 
 #define HEADER_MAGIC		0xbd5c25e27295668bULL
-#define MAX_PENDING_SIZE	(256 * 1024)
-#define BLOCK_SIZE		1024
+#define MAX_PENDING_SIZE	SZ_256K
+#define BLOCK_SIZE		SZ_1K
 #define BLOCK_MASK		(BLOCK_SIZE - 1)
 
 #define ITEMS_PER_CLUSTER ((BLOCK_SIZE - sizeof(struct meta_cluster)) / \
-- 
2.22.0

