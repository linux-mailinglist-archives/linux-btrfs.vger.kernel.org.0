Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22085CD76
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGBKYK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:24:10 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:40839 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbfGBKYK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:24:10 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:24:03 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:29 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:29 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:28 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:28 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 05/14] btrfs-progs: image: Introduce framework for more
 dump versions
Thread-Topic: [PATCH v2 05/14] btrfs-progs: image: Introduce framework for
 more dump versions
Thread-Index: AQHVML30aFI+EDaGdkCJ/BGF15Gdcg==
Date:   Tue, 2 Jul 2019 10:07:28 +0000
Message-ID: <20190702100650.2746-6-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: 972a0d3e-8f35-40d3-bb17-08d6fed51662
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB3284D8AEADB1560554BD1404D6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k9xgWyTI7O7sTwBM4a+sva7D6aO/X+ceOKAPhG0OBI7XQgM21tqnMqTK0PD3eUAeWtsAuIASb1BoVS6/2Fcfc7NhSBQw5ZRNRJWUVQbpoVc4aLnO7QGTLTK2HouxuF60k0rz7X00rEbCK9fzjX+yyHD2TbaKTM7mzErQjYavTqpKctqYhXSRy1cEt+XiFBdOm7L/SqLiNDMy32+q28FLbaYry9GveOnNY5967tR4wD2DxR75UjmW4SbwWRRMnnKP6dFgopizuRPifgDiSkLW2eWkIZQwYm50sAk4h+/oJlY7toGg/wFwzcLuhuXxP+ttYafp936ZTTzJSTvEdGG6v/ER8nlWLHKWFhStBZgQ4fO2x17vHQwsbdMxHj8v+oIm3QXcW4GRCaV3AAzNdm6xFha7YPFD6I0OX4NBLwaqGP8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 972a0d3e-8f35-40d3-bb17-08d6fed51662
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:28.2918
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

The original dump format only contains a @magic member to verify the
format, this means if we want to introduce new on-disk format or change
certain size limit, we can only introduce new magic as kind of version.

This patch will introduce the framework to allow multiple magic to
co-exist for further functions.

This patch will introduce the following members for each dump version.

- max_pending_size
  The threshold size for an cluster. It's not a hard limit but a soft
  one. One cluster can go larger than max_pending_size for one item, but
  next item would go to next cluster.

- magic_cpu
  The magic number in CPU endian.

- extra_sb_flags
  If the super block of this restore needs extra super block flags like
  BTRFS_SUPER_FLAG_METADUMP_V2.
  For incoming data dump feature, we don't need any extra super block
  flags.

This change also implies that all image dumps will use the same magic
for all clusters. No mixing is allowed, as we will use the first cluster
to determine the dump version.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c     | 80 ++++++++++++++++++++++++++++++++++++++++--------
 image/metadump.h | 13 ++++++--
 2 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/image/main.c b/image/main.c
index f155794cfc19..26c72e85f656 100644
--- a/image/main.c
+++ b/image/main.c
@@ -41,6 +41,19 @@
 
 #define MAX_WORKER_THREADS	(32)
 
+const struct dump_version dump_versions[NR_DUMP_VERSIONS] = {
+	/*
+	 * The original format, which only supports tree blocks and
+	 * free space cache dump.
+	 */
+	{ .version = 0,
+	  .max_pending_size = SZ_256K,
+	  .magic_cpu = 0xbd5c25e27295668bULL,
+	  .extra_sb_flags = 1 }
+};
+
+const struct dump_version *current_version = &dump_versions[0];
+
 struct async_work {
 	struct list_head list;
 	struct list_head ordered;
@@ -395,7 +408,7 @@ static void meta_cluster_init(struct metadump_struct *md, u64 start)
 	md->num_items = 0;
 	md->num_ready = 0;
 	header = &md->cluster.header;
-	header->magic = cpu_to_le64(HEADER_MAGIC);
+	header->magic = cpu_to_le64(current_version->magic_cpu);
 	header->bytenr = cpu_to_le64(start);
 	header->nritems = cpu_to_le32(0);
 	header->compress = md->compress_level > 0 ?
@@ -707,7 +720,7 @@ static int add_extent(u64 start, u64 size, struct metadump_struct *md,
 {
 	int ret;
 	if (md->data != data ||
-	    md->pending_size + size > MAX_PENDING_SIZE ||
+	    md->pending_size + size > current_version->max_pending_size ||
 	    md->pending_start + md->pending_size != start) {
 		ret = flush_pending(md, 0);
 		if (ret)
@@ -1036,7 +1049,8 @@ static void update_super_old(u8 *buffer)
 	u32 sectorsize = btrfs_super_sectorsize(super);
 	u64 flags = btrfs_super_flags(super);
 
-	flags |= BTRFS_SUPER_FLAG_METADUMP;
+	if (current_version->extra_sb_flags)
+		flags |= BTRFS_SUPER_FLAG_METADUMP;
 	btrfs_set_super_flags(super, flags);
 
 	key = (struct btrfs_disk_key *)(super->sys_chunk_array);
@@ -1129,7 +1143,8 @@ static int update_super(struct mdrestore_struct *mdres, u8 *buffer)
 	if (mdres->clear_space_cache)
 		btrfs_set_super_cache_generation(super, 0);
 
-	flags |= BTRFS_SUPER_FLAG_METADUMP_V2;
+	if (current_version->extra_sb_flags)
+		flags |= BTRFS_SUPER_FLAG_METADUMP_V2;
 	btrfs_set_super_flags(super, flags);
 	btrfs_set_super_sys_array_size(super, new_array_size);
 	btrfs_set_super_num_devices(super, 1);
@@ -1317,7 +1332,7 @@ static void *restore_worker(void *data)
 	u8 *outbuf;
 	int outfd;
 	int ret;
-	int compress_size = MAX_PENDING_SIZE * 4;
+	int compress_size = current_version->max_pending_size * 4;
 
 	outfd = fileno(mdres->out);
 	buffer = malloc(compress_size);
@@ -1466,6 +1481,42 @@ static void mdrestore_destroy(struct mdrestore_struct *mdres, int num_threads)
 	pthread_mutex_destroy(&mdres->mutex);
 }
 
+static int detect_version(FILE *in)
+{
+	struct meta_cluster *cluster;
+	u8 buf[BLOCK_SIZE];
+	bool found = false;
+	int i;
+	int ret;
+
+	if (fseek(in, 0, SEEK_SET) < 0) {
+		error("seek failed: %m");
+		return -errno;
+	}
+	ret = fread(buf, BLOCK_SIZE, 1, in);
+	if (!ret) {
+		error("failed to read header");
+		return -EIO;
+	}
+
+	fseek(in, 0, SEEK_SET);
+	cluster = (struct meta_cluster *)buf;
+	for (i = 0; i < NR_DUMP_VERSIONS; i++) {
+		if (le64_to_cpu(cluster->header.magic) ==
+		    dump_versions[i].magic_cpu) {
+			found = true;
+			current_version = &dump_versions[i];
+			break;
+		}
+	}
+
+	if (!found) {
+		error("unrecognized header format");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int mdrestore_init(struct mdrestore_struct *mdres,
 			  FILE *in, FILE *out, int old_restore,
 			  int num_threads, int fixup_offset,
@@ -1473,6 +1524,9 @@ static int mdrestore_init(struct mdrestore_struct *mdres,
 {
 	int i, ret = 0;
 
+	ret = detect_version(in);
+	if (ret < 0)
+		return ret;
 	memset(mdres, 0, sizeof(*mdres));
 	pthread_cond_init(&mdres->cond, NULL);
 	pthread_mutex_init(&mdres->mutex, NULL);
@@ -1520,9 +1574,9 @@ static int fill_mdres_info(struct mdrestore_struct *mdres,
 		return 0;
 
 	if (mdres->compress_method == COMPRESS_ZLIB) {
-		size_t size = MAX_PENDING_SIZE * 2;
+		size_t size = current_version->max_pending_size * 2;
 
-		buffer = malloc(MAX_PENDING_SIZE * 2);
+		buffer = malloc(current_version->max_pending_size * 2);
 		if (!buffer)
 			return -ENOMEM;
 		ret = uncompress(buffer, (unsigned long *)&size,
@@ -1761,7 +1815,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 	u64 current_cluster = cluster_bytenr, bytenr;
 	u64 item_bytenr;
 	u32 bufsize, nritems, i;
-	u32 max_size = MAX_PENDING_SIZE * 2;
+	u32 max_size = current_version->max_pending_size * 2;
 	u8 *buffer, *tmp = NULL;
 	int ret = 0;
 
@@ -1817,7 +1871,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 		ret = 0;
 
 		header = &cluster->header;
-		if (le64_to_cpu(header->magic) != HEADER_MAGIC ||
+		if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 		    le64_to_cpu(header->bytenr) != current_cluster) {
 			error("bad header in metadump image");
 			ret = -EIO;
@@ -1920,7 +1974,7 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	ret = 0;
 
 	header = &cluster->header;
-	if (le64_to_cpu(header->magic) != HEADER_MAGIC ||
+	if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 	    le64_to_cpu(header->bytenr) != 0) {
 		error("bad header in metadump image");
 		return -EIO;
@@ -1961,10 +2015,10 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	}
 
 	if (mdres->compress_method == COMPRESS_ZLIB) {
-		size_t size = MAX_PENDING_SIZE * 2;
+		size_t size = current_version->max_pending_size * 2;
 		u8 *tmp;
 
-		tmp = malloc(MAX_PENDING_SIZE * 2);
+		tmp = malloc(current_version->max_pending_size * 2);
 		if (!tmp) {
 			free(buffer);
 			return -ENOMEM;
@@ -2421,7 +2475,7 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 			break;
 
 		header = &cluster->header;
-		if (le64_to_cpu(header->magic) != HEADER_MAGIC ||
+		if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 		    le64_to_cpu(header->bytenr) != bytenr) {
 			error("bad header in metadump image");
 			ret = -EIO;
diff --git a/image/metadump.h b/image/metadump.h
index f85c9bcfb813..941d4b827a24 100644
--- a/image/metadump.h
+++ b/image/metadump.h
@@ -22,8 +22,6 @@
 #include "kernel-lib/list.h"
 #include "ctree.h"
 
-#define HEADER_MAGIC		0xbd5c25e27295668bULL
-#define MAX_PENDING_SIZE	SZ_256K
 #define BLOCK_SIZE		SZ_1K
 #define BLOCK_MASK		(BLOCK_SIZE - 1)
 
@@ -33,6 +31,17 @@
 #define COMPRESS_NONE		0
 #define COMPRESS_ZLIB		1
 
+struct dump_version {
+	u64 magic_cpu;
+	int version;
+	int max_pending_size;
+	unsigned int extra_sb_flags:1;
+};
+
+#define NR_DUMP_VERSIONS	1
+extern const struct dump_version dump_versions[NR_DUMP_VERSIONS];
+const extern struct dump_version *current_version;
+
 struct meta_cluster_item {
 	__le64 bytenr;
 	__le32 size;
-- 
2.22.0

