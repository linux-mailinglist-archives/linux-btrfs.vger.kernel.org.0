Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA95CD7C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGBKYg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:24:36 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:43391 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbfGBKYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:24:35 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:24:24 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:51 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:50 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:49 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:49 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 11/14] btrfs-progs: image: Don't waste memory when we're
 just extracting super block
Thread-Topic: [PATCH v2 11/14] btrfs-progs: image: Don't waste memory when
 we're just extracting super block
Thread-Index: AQHVML4BRqRBurFzRkOpEEPDBjreCw==
Date:   Tue, 2 Jul 2019 10:07:49 +0000
Message-ID: <20190702100650.2746-12-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: 2914451f-8ef1-46f4-c99f-08d6fed52333
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB3284E265E4DB143101E46DE1D6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(4744005)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2fovFJ3p2nSNfJzPKdfaKr5iJ1eLPmiSfQ7umXhT2YnlVBI37+yrNWrQ90mxZmIt0uGoxjttII1jui5Fcaz6j26MXdchb5fmdqGigmXMLIDzBNWeJwJVmWHda8SvajTxFhs+e8jIb9ze0c3MGLM5vwOK4jxj5FcOicwn5htB64wrhnaFRzt4PO/O5eF3dWIcQV2/XclO4MV9taoK1UdMUXQnDLxhcc7gs6h6briOC+FgKKbYR44IX9kVTu0Yu2bvnOxiNDFMfslpxhRJtE33qpCzAv8Lwjxyol77MQAARWzeMB6BBAWtq3PdjpYo7YB/8U2uRP4MeNQZw1a3M6A7fSV71Gj2/Tx240nadSEusWYkSfTHcN6KobZBXuedtilBvkGkQ95aANCiOFWNbdDAG1iQu9Roo2u9lgdvp16hZMg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2914451f-8ef1-46f4-c99f-08d6fed52333
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:49.7855
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

There is no need to allocate 2 * max_pending_size (which can be 256M) if
we're just extracting super block.

We only need to prepare BTRFS_SUPER_INFO_SIZE as buffer size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/image/main.c b/image/main.c
index d6e21ed68b87..7ca207de3c3a 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1670,9 +1670,14 @@ static int fill_mdres_info(struct mdrestore_struct *mdres,
 		return 0;
 
 	if (mdres->compress_method == COMPRESS_ZLIB) {
-		size_t size = current_version->max_pending_size * 2;
+		/*
+		 * We know this item is superblock, its should only be 4K.
+		 * Don't need to waste memory following max_pending_size as it
+		 * can be as large as 256M.
+		 */
+		size_t size = BTRFS_SUPER_INFO_SIZE;
 
-		buffer = malloc(current_version->max_pending_size * 2);
+		buffer = malloc(size);
 		if (!buffer)
 			return -ENOMEM;
 		ret = uncompress(buffer, (unsigned long *)&size,
-- 
2.22.0

