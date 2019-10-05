Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05DFCC825
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2019 07:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfJEFdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 01:33:45 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21554 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbfJEFdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 5 Oct 2019 01:33:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570252688; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=p0E5kHJEP+jqUDuo6tPyptfqmyyFtXCBdAK3lhYR+bvCzZYpGptNRs+M7H6lRB8aOO2LvrNiRQIFd8UNxuwP8UkDNlCIhv5J8HIvj+C3XqHbCnx2b6TSmwQ4kgXRz2zS6pgmZyp67uCdQAwvhybDCNyqkYOID+sEULfYJcH80XM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570252688; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=cuCj8lkW5ZTQMOaX87sqd1zA7ygX45opu+Zre1DkD74=; 
        b=hFSkpJQtZFch6eEo614NYHZ+qxN4cVu8KTly2f3p05VcWQrJki3QbLiQmRdkec5ukIwDWCunzV/DiBcOqcmPoOaBEP2QAKiD+fQYcdx+vXR80eho/zQIhNgSCUFCU4PDrC6NXY/G6Ux1LEPtBaogezf8GfGtEkjrRfxcqoAb+Q8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570252688;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1664; bh=cuCj8lkW5ZTQMOaX87sqd1zA7ygX45opu+Zre1DkD74=;
        b=VAiAMPQMrk5vGgxyMA6mV2vHRSXkM58PjTDN1ruQo66Yemw5jYvt/8bucPetlJ2i
        cT3okPyObu0umh+3hIFU89a7QT3Xm89He3Alsv6Y/qyyu0wZJvbdnZd3BCQJCGj33bW
        hUC+OD2yEcv6B52axw1nmAYIhly42C+Wv/sLTieQ=
Received: from localhost.localdomain (116.30.195.234 [116.30.195.234]) by mx.zoho.com.cn
        with SMTPS id 1570252686586852.6704752914676; Sat, 5 Oct 2019 13:18:06 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191005051736.29857-3-cgxu519@mykernel.net>
Subject: [PATCH 3/3] btrfs: using enum to replace macro
Date:   Sat,  5 Oct 2019 13:17:36 +0800
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

using enum to replace macro definition for extent
types.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/btrfs/tree-checker.c         |  4 ++--
 include/uapi/linux/btrfs_tree.h | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 2d91c34bbf63..9b0c5fdbe04e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -156,11 +156,11 @@ static int check_extent_data_item(struct extent_buffe=
r *leaf,
=20
 =09fi =3D btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
=20
-=09if (btrfs_file_extent_type(leaf, fi) > BTRFS_FILE_EXTENT_TYPES) {
+=09if (btrfs_file_extent_type(leaf, fi) >=3D BTRFS_FILE_EXTENT_TYPES) {
 =09=09file_extent_err(leaf, slot,
 =09=09"invalid type for file extent, have %u expect range [0, %u]",
 =09=09=09btrfs_file_extent_type(leaf, fi),
-=09=09=09BTRFS_FILE_EXTENT_TYPES);
+=09=09=09BTRFS_FILE_EXTENT_TYPES - 1);
 =09=09return -EUCLEAN;
 =09}
=20
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tre=
e.h
index b65c7ee75bc7..34bd09ffc71d 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -737,10 +737,12 @@ struct btrfs_balance_item {
 =09__le64 unused[4];
 } __attribute__ ((__packed__));
=20
-#define BTRFS_FILE_EXTENT_INLINE 0
-#define BTRFS_FILE_EXTENT_REG 1
-#define BTRFS_FILE_EXTENT_PREALLOC 2
-#define BTRFS_FILE_EXTENT_TYPES=092
+enum {
+=09BTRFS_FILE_EXTENT_INLINE,
+=09BTRFS_FILE_EXTENT_REG,
+=09BTRFS_FILE_EXTENT_PREALLOC,
+=09BTRFS_FILE_EXTENT_TYPES
+};
=20
 struct btrfs_file_extent_item {
 =09/*
--=20
2.21.0



