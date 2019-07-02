Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB425CD77
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGBKYL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:24:11 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:38247 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbfGBKYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:24:11 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:24:09 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:32 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:32 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:31 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:31 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 06/14] btrfs-progs: image: Introduce -d option to dump data
Thread-Topic: [PATCH v2 06/14] btrfs-progs: image: Introduce -d option to dump
 data
Thread-Index: AQHVML32HvEstM/0o0KjFdzvImdrVw==
Date:   Tue, 2 Jul 2019 10:07:31 +0000
Message-ID: <20190702100650.2746-7-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: 1243d9e1-c60e-4400-afba-08d6fed5187b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB32848B99FC71268633DBA5F8D6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ciQpV1VaxQyN4kXHTgmfCSUzV3p+4Hr4zZGm0TpJsGhKGCeE/KKreKEFkC5yjUn1we5W0oSDEA8Q1iOe1iDijS5h4cZItWq2OfJIJcmfXjlk4ohBVMBjXnEK+Gc9AC9iC2y49/rKrAr8ocnIsMf9IEPT+Ob9duSPv8NqVdbr5Svi7QygTZFca5YLYWGopyBIaA3624/CHlMbBzxLWlHJRiWCFIpk7YwNhX62z0CGaYt5VFHScQkqAoMhA2XgdFW3f2/pyV62itZAdOxQhVoDJ+R8rREy9nvR2dF4f4aMwFXeZWQqfuHe/jGxNgjrpy2cn6Xvcrg3ITAz3SVBGbaCCnSkezlTrsgUsn4zFI3ydTjYfy4fQYClJYSWny8fLq8bA3tRsz9bzj7ehIGzQCVRiVWL0HE41JRoEOdo3JSLOTk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1243d9e1-c60e-4400-afba-08d6fed5187b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:31.8088
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

This new data dump feature will dump the whole image, not long the
existing tree blocks but also all its data extents(*).

This feature will rely on the new dump format (_DUmP_v1), as it needs
extra large extent size limit, and older btrfs-image dump can't handle
such large item/cluster size.

Since we're dumping all extents including data extents, for the restored
image there is no need to use any extra super block flags to inform
kernel.
Kernel should just treat the restored image as any ordinary btrfs.

*: The data extents will be dumped as is, that's to say, even for
preallocated extent, its (meaningless) data will be read out and
dumpped.
This behavior will cause extra space usage for the image, but we can
skip all the complex partially shared preallocated extent check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c     | 53 +++++++++++++++++++++++++++++++++++++-----------
 image/metadump.h |  2 +-
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/image/main.c b/image/main.c
index 26c72e85f656..04d914d14a66 100644
--- a/image/main.c
+++ b/image/main.c
@@ -49,7 +49,15 @@ const struct dump_version dump_versions[NR_DUMP_VERSIONS] = {
 	{ .version = 0,
 	  .max_pending_size = SZ_256K,
 	  .magic_cpu = 0xbd5c25e27295668bULL,
-	  .extra_sb_flags = 1 }
+	  .extra_sb_flags = 1 },
+	/*
+	 * The newer format, with much larger item size to contain
+	 * any data extent.
+	 */
+	{ .version = 1,
+	  .max_pending_size = SZ_256M,
+	  .magic_cpu = 0x31765f506d55445fULL, /* ascii _DUmP_v1, no null */
+	  .extra_sb_flags = 0 },
 };
 
 const struct dump_version *current_version = &dump_versions[0];
@@ -444,10 +452,14 @@ static void metadump_destroy(struct metadump_struct *md, int num_threads)
 
 static int metadump_init(struct metadump_struct *md, struct btrfs_root *root,
 			 FILE *out, int num_threads, int compress_level,
-			 enum sanitize_mode sanitize_names)
+			 bool dump_data, enum sanitize_mode sanitize_names)
 {
 	int i, ret = 0;
 
+	/* We need larger item/cluster limit for data extents */
+	if (dump_data)
+		current_version = &dump_versions[1];
+
 	memset(md, 0, sizeof(*md));
 	INIT_LIST_HEAD(&md->list);
 	INIT_LIST_HEAD(&md->ordered);
@@ -875,7 +887,7 @@ static int copy_space_cache(struct btrfs_root *root,
 }
 
 static int copy_from_extent_tree(struct metadump_struct *metadump,
-				 struct btrfs_path *path)
+				 struct btrfs_path *path, bool dump_data)
 {
 	struct btrfs_root *extent_root;
 	struct extent_buffer *leaf;
@@ -940,9 +952,15 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
 			if (btrfs_extent_flags(leaf, ei) &
-			    BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+			    BTRFS_EXTENT_FLAG_TREE_BLOCK ||
+			    btrfs_extent_flags(leaf, ei) &
+			    BTRFS_EXTENT_FLAG_DATA) {
+				bool is_data;
+
+				is_data = btrfs_extent_flags(leaf, ei) &
+					  BTRFS_EXTENT_FLAG_DATA;
 				ret = add_extent(bytenr, num_bytes, metadump,
-						 0);
+						 is_data);
 				if (ret) {
 					error("unable to add block %llu: %d",
 						(unsigned long long)bytenr, ret);
@@ -965,7 +983,7 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 
 static int create_metadump(const char *input, FILE *out, int num_threads,
 			   int compress_level, enum sanitize_mode sanitize,
-			   int walk_trees)
+			   int walk_trees, bool dump_data)
 {
 	struct btrfs_root *root;
 	struct btrfs_path path;
@@ -980,7 +998,7 @@ static int create_metadump(const char *input, FILE *out, int num_threads,
 	}
 
 	ret = metadump_init(&metadump, root, out, num_threads,
-			    compress_level, sanitize);
+			    compress_level, dump_data, sanitize);
 	if (ret) {
 		error("failed to initialize metadump: %d", ret);
 		close_ctree(root);
@@ -1012,7 +1030,7 @@ static int create_metadump(const char *input, FILE *out, int num_threads,
 			goto out;
 		}
 	} else {
-		ret = copy_from_extent_tree(&metadump, &path);
+		ret = copy_from_extent_tree(&metadump, &path, dump_data);
 		if (ret) {
 			err = ret;
 			goto out;
@@ -2637,6 +2655,7 @@ static void print_usage(int ret)
 	printf("\t-s      \tsanitize file names, use once to just use garbage, use twice if you want crc collisions\n");
 	printf("\t-w      \twalk all trees instead of using extent tree, do this if your extent tree is broken\n");
 	printf("\t-m	   \trestore for multiple devices\n");
+	printf("\t-d	   \talso dump data, conflicts with -w\n");
 	printf("\n");
 	printf("\tIn the dump mode, source is the btrfs device and target is the output file (use '-' for stdout).\n");
 	printf("\tIn the restore mode, source is the dumped image and target is the btrfs device/file.\n");
@@ -2656,6 +2675,7 @@ int main(int argc, char *argv[])
 	int ret;
 	enum sanitize_mode sanitize = SANITIZE_NONE;
 	int dev_cnt = 0;
+	bool dump_data = false;
 	int usage_error = 0;
 	FILE *out;
 
@@ -2664,7 +2684,7 @@ int main(int argc, char *argv[])
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "rc:t:oswm", long_options, NULL);
+		int c = getopt_long(argc, argv, "rc:t:oswmd", long_options, NULL);
 		if (c < 0)
 			break;
 		switch (c) {
@@ -2704,6 +2724,9 @@ int main(int argc, char *argv[])
 			create = 0;
 			multi_devices = 1;
 			break;
+		case 'd':
+			dump_data = true;
+			break;
 		case GETOPT_VAL_HELP:
 		default:
 			print_usage(c != GETOPT_VAL_HELP);
@@ -2722,10 +2745,15 @@ int main(int argc, char *argv[])
 			"create and restore cannot be used at the same time");
 			usage_error++;
 		}
+		if (dump_data && walk_trees) {
+			error("-d conflicts with -f option");
+			usage_error++;
+		}
 	} else {
-		if (walk_trees || sanitize != SANITIZE_NONE || compress_level) {
+		if (walk_trees || sanitize != SANITIZE_NONE || compress_level ||
+		    dump_data) {
 			error(
-			"using -w, -s, -c options for restore makes no sense");
+		"using -w, -s, -c, -d options for restore makes no sense");
 			usage_error++;
 		}
 		if (multi_devices && dev_cnt < 2) {
@@ -2778,7 +2806,8 @@ int main(int argc, char *argv[])
 		}
 
 		ret = create_metadump(source, out, num_threads,
-				      compress_level, sanitize, walk_trees);
+				      compress_level, sanitize, walk_trees,
+				      dump_data);
 	} else {
 		ret = restore_metadump(source, out, old_restore, num_threads,
 				       0, target, multi_devices);
diff --git a/image/metadump.h b/image/metadump.h
index 941d4b827a24..a04f63a910d6 100644
--- a/image/metadump.h
+++ b/image/metadump.h
@@ -38,7 +38,7 @@ struct dump_version {
 	unsigned int extra_sb_flags:1;
 };
 
-#define NR_DUMP_VERSIONS	1
+#define NR_DUMP_VERSIONS	2
 extern const struct dump_version dump_versions[NR_DUMP_VERSIONS];
 const extern struct dump_version *current_version;
 
-- 
2.22.0

