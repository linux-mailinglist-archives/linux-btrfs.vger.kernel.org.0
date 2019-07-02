Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B885CD7B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfGBKYZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:24:25 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:42682 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbfGBKYZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:24:25 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:24:17 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:47 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:47 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:46 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:46 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 10/14] btrfs-progs: image: Reduce memory requirement for
 decompression
Thread-Topic: [PATCH v2 10/14] btrfs-progs: image: Reduce memory requirement
 for decompression
Thread-Index: AQHVML3/tA3cOEV7tUWzhuBZfm0SoQ==
Date:   Tue, 2 Jul 2019 10:07:46 +0000
Message-ID: <20190702100650.2746-11-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: 7c43701c-68e9-49b8-a4f8-08d6fed5211e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB328434FD82A6F4687C4412C3D6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QeSIbKNrIo0n4y8csW3xH33j+J2cKFHQ6TmiV0HFe07z2v2khn03jjNJrTi688VJfXTIvxleS5acMPLrB4r29wtjyWWMtZYwwjTQ3sqGkBI1inBYuRU3JiwPgxoLZGwFqP9btz0K/HB3HNTsvhL9ABpjwU/I+MqVgLnE3q8OY9pCYO6iAET53Iyb1xyM+kwqso6Uvf6ca0aA7nwS7CYhTsz/WIi2rWWfPxzkoTEm9Np6JYwiGaRDFsKo5FYMRgZhLN1SKTFIjgTE55J5sGOXV/IIQUo7xIil6ZtU06++z+kbvV16t8J6oT91V5btz+3PQ5zdgK2OtJTdgbc9kOD9S76XX3yQrXEH9jL37aipzQiSEdzm9EuwvgM1+6yZ7WbIw/+da0vvJbCNl3vtOi3uRruXVXBhKiUxPJrs9rbd1OE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c43701c-68e9-49b8-a4f8-08d6fed5211e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:46.3075
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

With recent change to enlarge max_pending_size to 256M for data dump,
the decompress code requires quite a lot of memory space. (256M * 4).

The main reason behind it is, we're using wrapped uncompress() function
call, which needs the buffer to be large enough to contain the
decompressed data.

This patch will re-work the decompress work to use inflate() which can
resume it decompression so that we can use a much smaller buffer size.

This patch choose to use 512K buffer size.

Now the memory consumption for restore is reduced to
 Cluster data size + 512K * nr_running_threads

Instead of the original one:
 Cluster data size + 1G * nr_running_threads

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 220 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 145 insertions(+), 75 deletions(-)

diff --git a/image/main.c b/image/main.c
index fc5806e4e4bc..d6e21ed68b87 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1347,128 +1347,198 @@ static void write_backup_supers(int fd, u8 *buf)
 	}
 }
 
-static void *restore_worker(void *data)
+/*
+ * Restore one item.
+ *
+ * For uncompressed data, it's just reading from work->buf then write to output.
+ * For compressed data, since we can have very large decompressed data
+ * (up to 256M), we need to consider memory usage. So here we will fill buffer
+ * then write the decompressed buffer to output.
+ */
+static int restore_one_work(struct mdrestore_struct *mdres,
+			    struct async_work *async, u8 *buffer, int bufsize)
 {
-	struct mdrestore_struct *mdres = (struct mdrestore_struct *)data;
-	struct async_work *async;
-	size_t size;
-	u8 *buffer;
-	u8 *outbuf;
-	int outfd;
+	z_stream strm;
+	int buf_offset = 0;	/* offset inside work->buffer */
+	int out_offset = 0;	/* offset for output */
+	int out_len;
+	int outfd = fileno(mdres->out);
+	int compress_method = mdres->compress_method;
 	int ret;
-	int compress_size = current_version->max_pending_size * 4;
 
-	outfd = fileno(mdres->out);
-	buffer = malloc(compress_size);
-	if (!buffer) {
-		error("not enough memory for restore worker buffer");
-		pthread_mutex_lock(&mdres->mutex);
-		if (!mdres->error)
-			mdres->error = -ENOMEM;
-		pthread_mutex_unlock(&mdres->mutex);
-		pthread_exit(NULL);
+	ASSERT(is_power_of_2(bufsize));
+
+	if (compress_method == COMPRESS_ZLIB) {
+		strm.zalloc = Z_NULL;
+		strm.zfree = Z_NULL;
+		strm.opaque = Z_NULL;
+		strm.avail_in = async->bufsize;
+		strm.next_in = async->buffer;
+		strm.avail_out = 0;
+		strm.next_out = Z_NULL;
+		ret = inflateInit(&strm);
+		if (ret != Z_OK) {
+			error("failed to initialize decompress parameters: %d",
+				ret);
+			return ret;
+		}
 	}
+	while (buf_offset < async->bufsize) {
+		bool compress_end = false;
+		int read_size = min_t(u64, async->bufsize - buf_offset,
+				      bufsize);
 
-	while (1) {
-		u64 bytenr, physical_dup;
-		off_t offset = 0;
-		int err = 0;
-
-		pthread_mutex_lock(&mdres->mutex);
-		while (!mdres->nodesize || list_empty(&mdres->list)) {
-			if (mdres->done) {
-				pthread_mutex_unlock(&mdres->mutex);
-				goto out;
+		/* Read part */
+		if (compress_method == COMPRESS_ZLIB) {
+			if (strm.avail_out == 0) {
+				strm.avail_out = bufsize;
+				strm.next_out = buffer;
 			}
-			pthread_cond_wait(&mdres->cond, &mdres->mutex);
-		}
-		async = list_entry(mdres->list.next, struct async_work, list);
-		list_del_init(&async->list);
-
-		if (mdres->compress_method == COMPRESS_ZLIB) {
-			size = compress_size;
 			pthread_mutex_unlock(&mdres->mutex);
-			ret = uncompress(buffer, (unsigned long *)&size,
-					 async->buffer, async->bufsize);
+			ret = inflate(&strm, Z_NO_FLUSH);
 			pthread_mutex_lock(&mdres->mutex);
-			if (ret != Z_OK) {
-				error("decompression failed with %d", ret);
-				err = -EIO;
+			switch (ret) {
+			case Z_NEED_DICT:
+				ret = Z_DATA_ERROR; /* fallthrough */
+				__attribute__ ((fallthrough));
+			case Z_DATA_ERROR:
+			case Z_MEM_ERROR:
+				goto out;
+			}
+			if (ret == Z_STREAM_END) {
+				ret = 0;
+				compress_end = true;
 			}
-			outbuf = buffer;
+			out_len = bufsize - strm.avail_out;
 		} else {
-			outbuf = async->buffer;
-			size = async->bufsize;
+			/* No compress, read as many data as possible */
+			memcpy(buffer, async->buffer + buf_offset, read_size);
+
+			buf_offset += read_size;
+			out_len = read_size;
 		}
 
+		/* Fixup part */
 		if (!mdres->multi_devices) {
 			if (async->start == BTRFS_SUPER_INFO_OFFSET) {
 				if (mdres->old_restore) {
-					update_super_old(outbuf);
+					update_super_old(buffer);
 				} else {
-					ret = update_super(mdres, outbuf);
-					if (ret)
-						err = ret;
+					ret = update_super(mdres, buffer);
+					if (ret < 0) 
+						goto out;
 				}
 			} else if (!mdres->old_restore) {
-				ret = fixup_chunk_tree_block(mdres, async, outbuf, size);
+				ret = fixup_chunk_tree_block(mdres, async,
+							     buffer, out_len);
 				if (ret)
-					err = ret;
+					goto out;
 			}
 		}
 
+		/* Write part */
 		if (!mdres->fixup_offset) {
+			int size = out_len;
+			off_t offset = 0;
+
 			while (size) {
+				u64 logical = async->start + out_offset + offset;
 				u64 chunk_size = size;
-				physical_dup = 0;
+				u64 physical_dup = 0;
+				u64 bytenr;
+
 				if (!mdres->multi_devices && !mdres->old_restore)
 					bytenr = logical_to_physical(mdres,
-						     async->start + offset,
-						     &chunk_size,
-						     &physical_dup);
+							logical, &chunk_size,
+							&physical_dup);
 				else
-					bytenr = async->start + offset;
+					bytenr = logical;
 
-				ret = pwrite64(outfd, outbuf+offset, chunk_size,
-					       bytenr);
+				ret = pwrite64(outfd, buffer + offset, chunk_size, bytenr);
 				if (ret != chunk_size)
-					goto error;
+					goto write_error;
 
 				if (physical_dup)
-					ret = pwrite64(outfd, outbuf+offset,
-						       chunk_size,
-						       physical_dup);
+					ret = pwrite64(outfd, buffer + offset,
+						       chunk_size, physical_dup);
 				if (ret != chunk_size)
-					goto error;
+					goto write_error;
 
 				size -= chunk_size;
 				offset += chunk_size;
 				continue;
-
-error:
-				if (ret < 0) {
-					error("unable to write to device: %m");
-					err = errno;
-				} else {
-					error("short write");
-					err = -EIO;
-				}
 			}
 		} else if (async->start != BTRFS_SUPER_INFO_OFFSET) {
-			ret = write_data_to_disk(mdres->info, outbuf, async->start, size, 0);
+			ret = write_data_to_disk(mdres->info, buffer,
+						 async->start, out_len, 0);
 			if (ret) {
 				error("failed to write data");
 				exit(1);
 			}
 		}
 
-
 		/* backup super blocks are already there at fixup_offset stage */
-		if (!mdres->multi_devices && async->start == BTRFS_SUPER_INFO_OFFSET)
-			write_backup_supers(outfd, outbuf);
+		if (async->start == BTRFS_SUPER_INFO_OFFSET &&
+		    !mdres->multi_devices)
+			write_backup_supers(outfd, buffer);
+		out_offset += out_len;
+		if (compress_end) {
+			inflateEnd(&strm);
+			break;
+		}
+	}
+	return ret;
+
+write_error:
+	if (ret < 0) {
+		error("unable to write to device: %m");
+		ret = -errno;
+	} else {
+		error("short write");
+		ret = -EIO;
+	}
+out:
+	if (compress_method == COMPRESS_ZLIB)
+		inflateEnd(&strm);
+	return ret;
+}
+
+static void *restore_worker(void *data)
+{
+	struct mdrestore_struct *mdres = (struct mdrestore_struct *)data;
+	struct async_work *async;
+	u8 *buffer;
+	int ret;
+	int buffer_size = SZ_512K;
+
+	buffer = malloc(buffer_size);
+	if (!buffer) {
+		error("not enough memory for restore worker buffer");
+		pthread_mutex_lock(&mdres->mutex);
+		if (!mdres->error)
+			mdres->error = -ENOMEM;
+		pthread_mutex_unlock(&mdres->mutex);
+		pthread_exit(NULL);
+	}
+
+	while (1) {
+		pthread_mutex_lock(&mdres->mutex);
+		while (!mdres->nodesize || list_empty(&mdres->list)) {
+			if (mdres->done) {
+				pthread_mutex_unlock(&mdres->mutex);
+				goto out;
+			}
+			pthread_cond_wait(&mdres->cond, &mdres->mutex);
+		}
+		async = list_entry(mdres->list.next, struct async_work, list);
+		list_del_init(&async->list);
 
-		if (err && !mdres->error)
-			mdres->error = err;
+		ret = restore_one_work(mdres, async, buffer, buffer_size);
+		if (ret < 0) {
+			mdres->error = ret;
+			pthread_mutex_unlock(&mdres->mutex);
+			goto out;
+		}
 		mdres->num_items--;
 		pthread_mutex_unlock(&mdres->mutex);
 
-- 
2.22.0

