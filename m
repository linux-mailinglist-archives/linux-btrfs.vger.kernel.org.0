Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB74BD2235
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 10:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbfJJIAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 04:00:54 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21340 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732980AbfJJIAx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 04:00:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570694428; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ZyCRR6iwDW50qqU+Lcwq4uKxR+cuW7ZfCN8cWRtSwBRoScEyP1YEU3JKvzFjh4GEzBxozRsQaSxescGM7kotvsrNZu0/pnp6uESqf3NKzAAAaua2hw1lHv+rZY8oFAqybQVwAygs61zSuh0FVHGcZSBA7dbSGz7J3pWfC9LTlz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570694428; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=9pEL0fnUunjkqlpT09iTlLP2vgxeH9ACAgKskBsx378=; 
        b=m8CZ9yqoojaZVju9lv9e/WDfru82boLzXR/tzPZxSxJi2lNMsT7ATDtxOMJRdX0MjQa6dbkRbSKcurWTwjdKk1iEiuTeWPNHYHgiQVG0MrckPphk7RItPJwKpXpYyUb2D5hv/cowbVs9pj0Si7y2RfWwOPViZzgO1sgXihdHwvo=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570694428;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1819; bh=9pEL0fnUunjkqlpT09iTlLP2vgxeH9ACAgKskBsx378=;
        b=RXY3/6aA+JKHb+JbRMhauyWJtj9Q50gpcGg/KfIJQ7D/Wdwwm6PXpIPtuKEhysKH
        JKSTkLh9dXfL7u3iNsBJKiseaGgQHLE6nGAb3USCbIhNTlLgBgAXyFSYAfBiygrAuH1
        ucRHbMUn33YFR2yHTf/tRjvIxf1AA1/S5pODOeC0=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1570694426276335.8035463421512; Thu, 10 Oct 2019 16:00:26 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191010075958.28346-3-cgxu519@mykernel.net>
Subject: [PATCH v2 3/3] btrfs: using enum to replace macro
Date:   Thu, 10 Oct 2019 15:59:58 +0800
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

Using enum to replace macro definition
of extent types.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
v1->v2:
- Explicitly specify value for enum.
- Change the name BTRFS_FILE_EXTENT_TYPES to BTRFS_NR_FILE_EXTENT_TYPES.

 fs/btrfs/tree-checker.c         |  4 ++--
 include/uapi/linux/btrfs_tree.h | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 92bde1d5b5d7..0e71085c008a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -143,11 +143,11 @@ static int check_extent_data_item(struct extent_buffe=
r *leaf,
=20
 =09fi =3D btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
=20
-=09if (btrfs_file_extent_type(leaf, fi) > BTRFS_FILE_EXTENT_TYPES) {
+=09if (btrfs_file_extent_type(leaf, fi) >=3D BTRFS_NR_FILE_EXTENT_TYPES) {
 =09=09file_extent_err(leaf, slot,
 =09=09"invalid type for file extent, have %u expect range [0, %u]",
 =09=09=09btrfs_file_extent_type(leaf, fi),
-=09=09=09BTRFS_FILE_EXTENT_TYPES);
+=09=09=09BTRFS_NR_FILE_EXTENT_TYPES - 1);
 =09=09return -EUCLEAN;
 =09}
=20
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tre=
e.h
index b65c7ee75bc7..4c8f9ea73191 100644
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
+=09BTRFS_FILE_EXTENT_INLINE =3D 0,
+=09BTRFS_FILE_EXTENT_REG =3D 1,
+=09BTRFS_FILE_EXTENT_PREALLOC =3D 2,
+=09BTRFS_NR_FILE_EXTENT_TYPES =3D 3
+};
=20
 struct btrfs_file_extent_item {
 =09/*
--=20
2.20.1



