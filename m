Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6555CD75
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGBKYE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:24:04 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:51607 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbfGBKYE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:24:04 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 06:23:57 EDT
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:23:56 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:26 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:26 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:25 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:24 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 04/14] btrfs-progs: image: Verify the superblock before
 restore
Thread-Topic: [PATCH v2 04/14] btrfs-progs: image: Verify the superblock
 before restore
Thread-Index: AQHVML3yrLf2Sha6FkuzzqVa5vtpbQ==
Date:   Tue, 2 Jul 2019 10:07:24 +0000
Message-ID: <20190702100650.2746-5-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: d42fd7e0-64bd-438b-6aef-08d6fed5144f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB32848BB17B7FC10611AE5F9DD6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(15650500001)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t7XJRwWaxndU93CQfWdPwp7KdcoH32X8M8WE0iWWepKTBBiWLZflsoSCZ/sz5vpNFUn1dtyR55z49WWNJrYFfjvbdjbj2/UCSQgiMEwY/JtfV0CXEqQ1sKTkuIAIgwgBbiP/gIrrWPwEhmThvUKqCoAejY3AQwnYJF2OYyjs82L22xitdeonFUJo1txgFMeHlAcaXIC15dsbviZ9IdoetvdXfBde1o2sIOV2Ok5ba33roc7AJ6cSMSz2sZM7sz6a5h72cmkzqfRAHNciQLjT6+HOgtwO/GfZ8xIy7xFnkzhKy2Boi3vUPgXd3FAhxBw/VYaZgfyC1eDKkOTefihlHUA10adn4uq4y3uu84p8p4iOz8LAaqFi+JdC54gCZFm4LmF2DUZ63EaqBZrZTG3U48sCn6FRowNShCde2lzL16U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d42fd7e0-64bd-438b-6aef-08d6fed5144f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:24.8018
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

This patch will export disk-io.c::check_super() as btrfs_check_super()
and use it in btrfs-image for extra verification.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 disk-io.c    | 6 +++---
 disk-io.h    | 1 +
 image/main.c | 5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/disk-io.c b/disk-io.c
index 151eb3b5a278..ffe4a8c58060 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1347,7 +1347,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
  * - number of devices   - something sane
  * - sys array size      - maximum
  */
-static int check_super(struct btrfs_super_block *sb, unsigned sbflags)
+int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 {
 	u8 result[BTRFS_CSUM_SIZE];
 	u32 crc;
@@ -1547,7 +1547,7 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 		if (btrfs_super_bytenr(buf) != sb_bytenr)
 			return -EIO;
 
-		ret = check_super(buf, sbflags);
+		ret = btrfs_check_super(buf, sbflags);
 		if (ret < 0)
 			return ret;
 		memcpy(sb, buf, BTRFS_SUPER_INFO_SIZE);
@@ -1572,7 +1572,7 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 		/* if magic is NULL, the device was removed */
 		if (btrfs_super_magic(buf) == 0 && i == 0)
 			break;
-		if (check_super(buf, sbflags))
+		if (btrfs_check_super(buf, sbflags))
 			continue;
 
 		if (!fsid_is_initialized) {
diff --git a/disk-io.h b/disk-io.h
index ddf3a3803ed5..c97aa2344ac9 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -171,6 +171,7 @@ static inline int close_ctree(struct btrfs_root *root)
 
 int write_all_supers(struct btrfs_fs_info *fs_info);
 int write_ctree_super(struct btrfs_trans_handle *trans);
+int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags);
 int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 		unsigned sbflags);
 int btrfs_map_bh_to_logical(struct btrfs_root *root, struct extent_buffer *bh,
diff --git a/image/main.c b/image/main.c
index c45d506812b2..f155794cfc19 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1983,6 +1983,11 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 
 	pthread_mutex_lock(&mdres->mutex);
 	super = (struct btrfs_super_block *)buffer;
+	ret = btrfs_check_super(super, 0);
+	if (ret < 0) {
+		error("invalid superblock");
+		return ret;
+	}
 	chunk_root_bytenr = btrfs_super_chunk_root(super);
 	mdres->nodesize = btrfs_super_nodesize(super);
 	if (btrfs_super_incompat_flags(super) &
-- 
2.22.0

