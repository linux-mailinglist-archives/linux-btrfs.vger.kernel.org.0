Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5F5CD7D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfGBKYm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:24:42 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:59289 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbfGBKYl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:24:41 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:24:35 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:54 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:54 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:53 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:53 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 12/14] btrfs-progs: image: Reduce memory usage for chunk
 tree search
Thread-Topic: [PATCH v2 12/14] btrfs-progs: image: Reduce memory usage for
 chunk tree search
Thread-Index: AQHVML4Dc/yUg+P5E0eKrCOsqvS+NQ==
Date:   Tue, 2 Jul 2019 10:07:53 +0000
Message-ID: <20190702100650.2746-13-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: 6e39a322-286e-4f97-40d2-08d6fed52547
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB3284E34410533D2A682136BDD6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0hnkSppgt5hW5fdoOJQvxfIcQc+RYBpxTFGWyZC8Gzy+6vczN/DoDbXjGcjXYFGf/6ptECVEvuFmhhhJ3QjP1OfJS3/29tKWBgrfQ/z5oYzdOiuhpOT8hnNRkQ8Z43kvEWs49KNilPLDndCp7XlF3JQ6uslDDHtOFoHZLLqctkiOmbfF0uPuc5NcpmQL5J1VtLOxHSYp5cJ3lKV+05M6jBmMdBJ7V26kvc15EFlj6AkoWul+hfy5UWh/KJqGDFEVjwFW6jgMplhfy9AQlcxfdTbvFrVA0/TJ/HtrvFA/dXqKrSXI0NEc9MQFF0pVnFzsughFS854oL7cpCV7Qh723U3vMhwwFYvOT4Nmu7UPl9pcIbN7/s1K4DZelXFdMZC7rP+QIHUAOYUBjhMqFIwiisDfghkhEGQYCqeTWEUGzeM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e39a322-286e-4f97-40d2-08d6fed52547
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:53.2616
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

Just like original restore_worker, search_for_chunk_blocks() will also
use a lot of memory for restoring large uncompressed extent or
compressed extent with data dump.

Reduce the memory usage by:
- Use fixed buffer size for uncompressed extent
  Now we will use fixed 512K as buffer size for reading uncompressed
  extent.

  Now chunk tree search will read out 512K data at most, then search
  chunk trees in the buffer.

  Reduce the memory usage from as large as item size, to fixed 512K.

- Use inflate() for compressed extent
  For compressed extent, we need two buffers, one for compressed data,
  and one for uncompressed data.
  For compressed data, we will use the item size as buffer size, since
  compressed extent should be small enough.
  For uncompressed data, we use 512K as buffer size.

  Now chunk tree search will fill the first 512K, then search chunk
  trees blocks in the uncompressed 512K buffer, then loop until the
  compressed data is exhausted.

  Reduce the memory usage from as large as 256M * 2 to 512K + compressed
  extent size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 159 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 126 insertions(+), 33 deletions(-)

diff --git a/image/main.c b/image/main.c
index 7ca207de3c3a..2256138df079 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1957,6 +1957,126 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 	return ret;
 }
 
+static int search_chunk_uncompressed(struct mdrestore_struct *mdres,
+				     struct meta_cluster_item *item,
+				     u64 current_cluster)
+{
+	u32 item_size = le32_to_cpu(item->size);
+	u64 item_bytenr = le64_to_cpu(item->bytenr);
+	int bufsize = SZ_512K;
+	int read_size;
+	u32 offset = 0;
+	u8 *buffer;
+	int ret;
+
+	ASSERT(mdres->compress_method == COMPRESS_NONE);
+	buffer = malloc(bufsize);
+	if (!buffer)
+		return -ENOMEM;
+
+	while (offset < item_size) {
+		read_size = min_t(u32, bufsize, item_size - offset);
+		ret = fread(buffer, read_size, 1, mdres->in);
+		if (ret != 1) {
+			error("read error: %m");
+			ret = -EIO;
+			goto out;
+		}
+		ret = read_chunk_block(mdres, buffer, item_bytenr, read_size,
+					current_cluster);
+		if (ret < 0) {
+			error(
+	"failed to search tree blocks in item bytenr %llu size %u",
+				item_bytenr, item_size);
+			goto out;
+		}
+		offset += read_size;
+	}
+out:
+	free(buffer);
+	return ret;
+}
+
+static int search_chunk_compressed(struct mdrestore_struct *mdres,
+				   struct meta_cluster_item *item,
+				   u64 current_cluster)
+{
+	z_stream strm;
+	u32 item_size = le32_to_cpu(item->size);
+	u64 item_bytenr = le64_to_cpu(item->bytenr);
+	int bufsize = SZ_512K;
+	int read_size;
+	u8 *out_buf = NULL;	/* uncompressed data */
+	u8 *in_buf = NULL;	/* compressed data */
+	bool end = false;
+	int ret;
+
+	ASSERT(mdres->compress_method != COMPRESS_NONE);
+	strm.zalloc = Z_NULL;
+	strm.zfree = Z_NULL;
+	strm.opaque = Z_NULL;
+	strm.avail_in = 0;
+	strm.next_in = Z_NULL;
+	strm.avail_out = 0;
+	strm.next_out = Z_NULL;
+	ret = inflateInit(&strm);
+	if (ret != Z_OK) {
+		error("failed to initialize decompress parameters: %d", ret);
+		return ret;
+	}
+
+	out_buf = malloc(bufsize);
+	in_buf = malloc(item_size);
+	if (!in_buf || !out_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = fread(in_buf, item_size, 1, mdres->in);
+	if (ret != 1) {
+		error("read error: %m");
+		ret = -EIO;
+		goto out;
+	}
+	strm.avail_in = item_size;
+	strm.next_in = in_buf;
+	while (!end) {
+		if (strm.avail_out == 0) {
+			strm.avail_out = bufsize;
+			strm.next_out = out_buf;
+		}
+		ret = inflate(&strm, Z_NO_FLUSH);
+		switch (ret) {
+		case Z_NEED_DICT:
+			ret = Z_DATA_ERROR; /* fallthrough */
+			__attribute__ ((fallthrough));
+		case Z_DATA_ERROR:
+		case Z_MEM_ERROR:
+			goto out;
+		}
+		if (ret == Z_STREAM_END) {
+			ret = 0;
+			end = true;
+		}
+		read_size = bufsize - strm.avail_out;
+
+		ret = read_chunk_block(mdres, out_buf, item_bytenr, read_size,
+					current_cluster);
+		if (ret < 0) {
+			error(
+	"failed to search tree blocks in item bytenr %llu size %u",
+				item_bytenr, item_size);
+			goto out;
+		}
+	}
+
+out:
+	free(in_buf);
+	free(out_buf);
+	inflateEnd(&strm);
+	return ret;
+}
+
 /*
  * This function will try to find all chunk items in the dump image.
  *
@@ -2042,8 +2162,6 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 
 		/* Search items for tree blocks in sys chunks */
 		for (i = 0; i < nritems; i++) {
-			size_t size;
-
 			item = &cluster->items[i];
 			bufsize = le32_to_cpu(item->size);
 			item_bytenr = le64_to_cpu(item->bytenr);
@@ -2068,41 +2186,16 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 			}
 
 			if (mdres->compress_method == COMPRESS_ZLIB) {
-				ret = fread(tmp, bufsize, 1, mdres->in);
-				if (ret != 1) {
-					error("read error: %m");
-					ret = -EIO;
-					goto out;
-				}
-
-				size = max_size;
-				ret = uncompress(buffer,
-						 (unsigned long *)&size, tmp,
-						 bufsize);
-				if (ret != Z_OK) {
-					error("decompression failed with %d",
-							ret);
-					ret = -EIO;
-					goto out;
-				}
+				ret = search_chunk_compressed(mdres, item,
+						current_cluster);
 			} else {
-				ret = fread(buffer, bufsize, 1, mdres->in);
-				if (ret != 1) {
-					error("read error: %m");
-					ret = -EIO;
-					goto out;
-				}
-				size = bufsize;
+				ret = search_chunk_uncompressed(mdres, item,
+						current_cluster);
 			}
-			ret = 0;
-
-			ret = read_chunk_block(mdres, buffer,
-					       item_bytenr, size,
-					       current_cluster);
 			if (ret < 0) {
 				error(
-	"failed to search tree blocks in item bytenr %llu size %lu",
-					item_bytenr, size);
+	"failed to search tree blocks in item bytenr %llu size %u",
+					item_bytenr, bufsize);
 				goto out;
 			}
 			bytenr += bufsize;
-- 
2.22.0

