Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3CD2233
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 10:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfJJIAn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 04:00:43 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21333 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbfJJIAm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 04:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570694425; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ZOFTf/VXApeKc/LngtyGBbElGjtD4ACU6/LdWobPKU8DxI+jfcHyAs81Kwg2PgqwmJKuw5j7YULBGIuzU8YyyQWmvjzZ4gnIiIYPc6rjmsJkEHk2PptOEPGgrlFUUuKIc1JyQ2vW6LERMMwexU1SCh5Lbl3E9Fb1d6Lf5KJ7qWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570694425; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=B2gk+gbgA5p59sO0B2woiPzlhK3eCFz+24yOHSZILPc=; 
        b=NPlolf41I+IXgM9pXQhbtYaCK2ivsvHKszxTdQnTY8vwsoTQ6yI7AqGl9VP5CcTiIjAdrE5ItEZkQ95VjphWRPoNtO7qhXqmPShOEP8bF1NqzV4/rmj8QrP4DkVbVXLbY33uVj5by/mXW3PfAvbaxbdAkAV0cN/PtDOJHQnWd+c=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570694425;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=3160; bh=B2gk+gbgA5p59sO0B2woiPzlhK3eCFz+24yOHSZILPc=;
        b=SptonRIdNaqBg7zX76ePiCH7sjEtv4AphvGuMXno1hdJTNjjE1fHtJ4RB+WLqJ4y
        J7X22RQHLbG7m6s73OTwDOAr2mr5CZ/XvqfeRtLuXfLYWhXrUPo88LIKnohGGElvUfg
        Jb4hjsDJZrv/UKv2qAgNkeSYRhOCgMA7Z/Jp9i9I=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1570694424731756.061669011618; Thu, 10 Oct 2019 16:00:24 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191010075958.28346-2-cgxu519@mykernel.net>
Subject: [PATCH v2 2/3] btrfs: code cleanup for compression type
Date:   Thu, 10 Oct 2019 15:59:57 +0800
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191010075958.28346-1-cgxu519@mykernel.net>
References: <20191010075958.28346-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In order to keep coding style consistency,
set BTRFS_NR_COMPRESS_TYPES to the total number
of cmpressoin type and fix related calling places.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
v1->v2:
- Modify change log.
- Explicitly specify value for enum.
- Change the BTRFS_COMPRESS_TYPES to BTRFS_NR_COMPRESS_TYPES.

 fs/btrfs/compression.c  | 2 ++
 fs/btrfs/compression.h  | 4 ++--
 fs/btrfs/ioctl.c        | 2 +-
 fs/btrfs/tree-checker.c | 5 +++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b05b361e2062..45d49f207989 100644
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
index 4cb8be9ff88b..e64336b98358 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -104,7 +104,7 @@ enum btrfs_compression_type {
 =09BTRFS_COMPRESS_ZLIB  =3D 1,
 =09BTRFS_COMPRESS_LZO   =3D 2,
 =09BTRFS_COMPRESS_ZSTD  =3D 3,
-=09BTRFS_COMPRESS_TYPES =3D 3,
+=09BTRFS_NR_COMPRESS_TYPES =3D 4,
 };
=20
 struct workspace_manager {
@@ -162,7 +162,7 @@ struct btrfs_compress_op {
 };
=20
 /* The heuristic workspaces are managed via the 0th workspace manager */
-#define BTRFS_NR_WORKSPACE_MANAGERS=09(BTRFS_COMPRESS_TYPES + 1)
+#define BTRFS_NR_WORKSPACE_MANAGERS=09BTRFS_NR_COMPRESS_TYPES
=20
 extern const struct btrfs_compress_op btrfs_heuristic_compress;
 extern const struct btrfs_compress_op btrfs_zlib_compress;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index de730e56d3f5..cea3bc6a23ce 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1411,7 +1411,7 @@ int btrfs_defrag_file(struct inode *inode, struct fil=
e *file,
 =09=09return -EINVAL;
=20
 =09if (do_compress) {
-=09=09if (range->compress_type > BTRFS_COMPRESS_TYPES)
+=09=09if (range->compress_type >=3D BTRFS_NR_COMPRESS_TYPES)
 =09=09=09return -EINVAL;
 =09=09if (range->compress_type)
 =09=09=09compress_type =3D range->compress_type;
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 43e488f5d063..92bde1d5b5d7 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -155,11 +155,12 @@ static int check_extent_data_item(struct extent_buffe=
r *leaf,
 =09 * Support for new compression/encryption must introduce incompat flag,
 =09 * and must be caught in open_ctree().
 =09 */
-=09if (btrfs_file_extent_compression(leaf, fi) > BTRFS_COMPRESS_TYPES) {
+=09if (btrfs_file_extent_compression(leaf, fi) >=3D
+=09=09=09=09=09=09BTRFS_NR_COMPRESS_TYPES) {
 =09=09file_extent_err(leaf, slot,
 =09"invalid compression for file extent, have %u expect range [0, %u]",
 =09=09=09btrfs_file_extent_compression(leaf, fi),
-=09=09=09BTRFS_COMPRESS_TYPES);
+=09=09=09BTRFS_NR_COMPRESS_TYPES - 1);
 =09=09return -EUCLEAN;
 =09}
 =09if (btrfs_file_extent_encryption(leaf, fi)) {
--=20
2.20.1



