Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5125DED4
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGCHZE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 3 Jul 2019 03:25:04 -0400
Received: from m4a0040g.houston.softwaregrp.com ([15.124.2.86]:42028 "EHLO
        m4a0040g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfGCHZE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 03:25:04 -0400
Received: FROM m4a0040g.houston.softwaregrp.com (15.120.17.147) BY m4a0040g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed,  3 Jul 2019 07:24:43 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 3 Jul 2019 07:24:43 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 3 Jul 2019 07:24:43 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3153.namprd18.prod.outlook.com (10.255.136.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 07:24:42 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Wed, 3 Jul 2019
 07:24:42 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: [PATCH] btrfs-progs: Kill ASSERT() for damaged filesystem
Thread-Topic: [PATCH] btrfs-progs: Kill ASSERT() for damaged filesystem
Thread-Index: AQHVMXBh96lruwo4ck6v6YtYvg6Jiw==
Date:   Wed, 3 Jul 2019 07:24:42 +0000
Message-ID: <20190703072428.13759-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0027.apcprd03.prod.outlook.com
 (2603:1096:203:2f::15) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [222.95.105.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 571ea439-6816-4c04-ce95-08d6ff8783fd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3153;
x-ms-traffictypediagnostic: BY5PR18MB3153:
x-microsoft-antispam-prvs: <BY5PR18MB3153DC27A8634A4DF27F4DCBD6FB0@BY5PR18MB3153.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(102836004)(26005)(386003)(66066001)(486006)(476003)(2616005)(186003)(6916009)(99286004)(6506007)(5660300002)(36756003)(478600001)(256004)(1076003)(2351001)(66446008)(73956011)(64756008)(66476007)(66556008)(66946007)(25786009)(14444005)(53936002)(14454004)(6436002)(8676002)(8936002)(7736002)(5640700003)(50226002)(305945005)(6116002)(81166006)(81156014)(6512007)(3846002)(52116002)(2906002)(6486002)(71200400001)(71190400001)(86362001)(316002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3153;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qFdYHYpofR06EwlzIyHukmnwcF7HbcE5THVBugSvFzmVNcTbb5fYHFRWtzTwUWsfiPNLLFvmw0B018quf+t8zVI+ILJxTpBtQjpyKJNhEi/lT1zrd6NYnipLuWz/12VMP+6Ih0E3l4RzYXB2LP3LZlNQG397mbGqyYUtEaTQZllVjXF+BCSeGBs2nRiWYoE///IwAjVeSKlkSPVWBUAeWd8rBI06aFpVhy2GgarVKlfEKQC35t+mFUcvUJA/sXulBNlhqu+IMprxRo7LPIp5JUajcj90t3H1JWuGV76O3jT5yiVuvNWAfkQ/z/bi3moF8jpn0Rj/78Kt3ugIDenSAElmQr9ymKlvex0N7r9NBUELm0D5S38kO9DXCKu6iUP6OhhBquB0gGZ07ypyoFGsCETVx6mb3sFWdx7kBgi0WyY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 571ea439-6816-4c04-ce95-08d6ff8783fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 07:24:42.3638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqu@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3153
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For damaged filesystem like 'bko-155621-bad-block-group-offset.raw' from
fuzzed tests, there may be no valid METADATA blocks at all.

Thus we could hit the following ASSERT():
  extent-tree.c:2484: alloc_tree_block: Assertion `sinfo` failed, value 0
  btrfs(+0x20ef8)[0x555adf5b2ef8]
  btrfs(+0x2107b)[0x555adf5b307b]
  btrfs(+0x27e7e)[0x555adf5b9e7e]
  btrfs(btrfs_alloc_free_block+0x67)[0x555adf5ba097]
  btrfs(+0x61188)[0x555adf5f3188]
  btrfs(+0x70921)[0x555adf602921]
  btrfs(main+0x94)[0x555adf5a7168]
  /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7fbd4c658ee3]
  btrfs(_start+0x2e)[0x555adf5a6cee]

The ASSERT() expects that every filesystem has one METADATA block
groups, but btrfs-check can accept any damaged filesystem.

So kill the ASSERT(), and return -EUCLEAN with one error message.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
To David:
Please fold this tiny modification to the following patch:
a970af98a1eb ("btrfs-progs: Fix false ENOSPC alert by tracking used space
correctly").

Sorry for the inconvience.
---
 extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/extent-tree.c b/extent-tree.c
index 1ebdf71f..932af2c6 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2481,7 +2481,10 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
-	ASSERT(sinfo);
+	if (!sinfo) {
+		error("Corrupted fs, no valid METADATA block group found");
+		return -EUCLEAN;
+	}
 	ret = btrfs_reserve_extent(trans, root, num_bytes, empty_size,
 				   hint_byte, search_end, ins, 0);
 	if (ret < 0)
-- 
2.22.0

