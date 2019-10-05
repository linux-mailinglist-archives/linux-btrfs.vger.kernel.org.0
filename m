Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98704CC824
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2019 07:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJEFdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 01:33:44 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21573 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbfJEFdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 5 Oct 2019 01:33:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570252686; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=l2GRt2oltuT8Js8gkaOq4/cmWZP648Xa075DakNnbJ8Q7n3d6JFhbmYznD7nMKfqotR25qaZh9S5BINxXHTcDOBjWOqg1lOv0g9oCex3privv7FJYaQnM505i4zHlkjpCf9xlv2gTt8ouEg/9Jw3kUzTv4ZYouNXwTca1wUhw3M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570252686; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=KAmWT9ZgEK3+5bjAXL2HNblCb43PqqG5xVDTsKJZsNA=; 
        b=VNZdz4rjyZZp5TchRILaaatEC8fRIZvVSPYg1IesP4lCOBkj6SgSxEpn84sKu5f+fz+VmBR4bNUaesGctQrzTjzSYBmbVLPBJihOo+OWwBDGBl3OMN0VN1CY2zI3+ugm0oS0sA5blbOzZKXIpnCZLjrbTxJy6ISxi4mGbB8acRY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570252686;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=3333; bh=KAmWT9ZgEK3+5bjAXL2HNblCb43PqqG5xVDTsKJZsNA=;
        b=TFPkn7lh3MHe7R19i+MnquDfSPlf5IULC35j4rfUvBFuDAc4UO1qqn4VZfAyMjNG
        rMRgaCw8K5h2z7CLTwXYAdARPg+YfGlYhI41nOEqGoXqQ7yoxI6sf249UmVLUU6vXmR
        5iqj2yyJJ+F0g0Q6UzhhatzcMdp/0LF2N0ZUwm+4=
Received: from localhost.localdomain (116.30.195.234 [116.30.195.234]) by mx.zoho.com.cn
        with SMTPS id 15702526847841015.7426628721475; Sat, 5 Oct 2019 13:18:04 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191005051736.29857-2-cgxu519@mykernel.net>
Subject: [PATCH 2/3] btrfs: code cleanup for compression type
Date:   Sat,  5 Oct 2019 13:17:35 +0800
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191005051736.29857-1-cgxu519@mykernel.net>
References: <20191005051736.29857-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Let BTRFS_COMPRESS_TYPES represents the total number
of cmpressoin types and fix related calling places.
It will be more safe when adding new compression type
in the future.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/btrfs/compression.c  |  2 ++
 fs/btrfs/compression.h  | 12 ++++++------
 fs/btrfs/ioctl.c        |  2 +-
 fs/btrfs/tree-checker.c |  4 ++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d70c46407420..93deaf0cc2b8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -39,6 +39,8 @@ const char* btrfs_compress_type2str(enum btrfs_compressio=
n_type type)
 =09case BTRFS_COMPRESS_ZSTD:
 =09case BTRFS_COMPRESS_NONE:
 =09=09return btrfs_compress_types[type];
+=09default:
+=09=09break;
 =09}
=20
 =09return NULL;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index dd392278ab3f..091ff3f986e5 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -101,11 +101,11 @@ blk_status_t btrfs_submit_compressed_read(struct inod=
e *inode, struct bio *bio,
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
=20
 enum btrfs_compression_type {
-=09BTRFS_COMPRESS_NONE  =3D 0,
-=09BTRFS_COMPRESS_ZLIB  =3D 1,
-=09BTRFS_COMPRESS_LZO   =3D 2,
-=09BTRFS_COMPRESS_ZSTD  =3D 3,
-=09BTRFS_COMPRESS_TYPES =3D 3,
+=09BTRFS_COMPRESS_NONE,
+=09BTRFS_COMPRESS_ZLIB,
+=09BTRFS_COMPRESS_LZO,
+=09BTRFS_COMPRESS_ZSTD,
+=09BTRFS_COMPRESS_TYPES
 };
=20
 struct workspace_manager {
@@ -163,7 +163,7 @@ struct btrfs_compress_op {
 };
=20
 /* The heuristic workspaces are managed via the 0th workspace manager */
-#define BTRFS_NR_WORKSPACE_MANAGERS=09(BTRFS_COMPRESS_TYPES + 1)
+#define BTRFS_NR_WORKSPACE_MANAGERS=09BTRFS_COMPRESS_TYPES
=20
 extern const struct btrfs_compress_op btrfs_heuristic_compress;
 extern const struct btrfs_compress_op btrfs_zlib_compress;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index de730e56d3f5..8c7196ed7ae0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1411,7 +1411,7 @@ int btrfs_defrag_file(struct inode *inode, struct fil=
e *file,
 =09=09return -EINVAL;
=20
 =09if (do_compress) {
-=09=09if (range->compress_type > BTRFS_COMPRESS_TYPES)
+=09=09if (range->compress_type >=3D BTRFS_COMPRESS_TYPES)
 =09=09=09return -EINVAL;
 =09=09if (range->compress_type)
 =09=09=09compress_type =3D range->compress_type;
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index f28f9725cef1..2d91c34bbf63 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -168,11 +168,11 @@ static int check_extent_data_item(struct extent_buffe=
r *leaf,
 =09 * Support for new compression/encryption must introduce incompat flag,
 =09 * and must be caught in open_ctree().
 =09 */
-=09if (btrfs_file_extent_compression(leaf, fi) > BTRFS_COMPRESS_TYPES) {
+=09if (btrfs_file_extent_compression(leaf, fi) >=3D BTRFS_COMPRESS_TYPES) =
{
 =09=09file_extent_err(leaf, slot,
 =09"invalid compression for file extent, have %u expect range [0, %u]",
 =09=09=09btrfs_file_extent_compression(leaf, fi),
-=09=09=09BTRFS_COMPRESS_TYPES);
+=09=09=09BTRFS_COMPRESS_TYPES - 1);
 =09=09return -EUCLEAN;
 =09}
 =09if (btrfs_file_extent_encryption(leaf, fi)) {
--=20
2.21.0



