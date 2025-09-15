Return-Path: <linux-btrfs+bounces-16833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E26AB58243
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE6C1B20D21
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BAF27B50F;
	Mon, 15 Sep 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR7ON5QM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D4286433
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954245; cv=none; b=nO42Qr049YqYrzUa8L5G/UTafTVm7RPxxZcGzeMGAPPMAp0ol0XvQ5eaXSdd63CbqIAlvY+SNAnQ16Nu7emVMM10/RBB8Ut6TFTvfc0GxKoTj96Y/NTVnHZnmSnJwkOltISpA+8qZGY2wYTmc33ISjA+jbSzFrFoQmY2ZSAac18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954245; c=relaxed/simple;
	bh=NFiTrl84+kvOF8IRYc5IF/x6siuRiHAHiGjMoOyHPnA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bhhyx2Tf/blh4SH8/aIDib/OFqi1FA3QscuZyIKVSunbhH7SAwMYZR1y6AOY4iCdbvmwxPdAgpYGHUhCWQSBbv+IWLZT4gdCzsMUA54b9+RExbE4n0P0wljpAp9eCVG8969O4d/zgrpANEC7I9I/86uzoZuNce6cEW+iUkmbxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR7ON5QM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC3DC4CEF7
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954245;
	bh=NFiTrl84+kvOF8IRYc5IF/x6siuRiHAHiGjMoOyHPnA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HR7ON5QMxdmoV9Cjsfsd5en0YJIgrlgiS7y+B8g3P2KsQ2BCchXzUOggv/XlBrIuW
	 UIUIW1t71l4RK5pbOhFNWgKc+yoRf5EDdOmyqm9FyUxaviTnTMjhaOUAW0hn/SjRIt
	 ECz5Dr8lFwV5jdQuCj72/UK9b+wfy0SU0f5tiq2Rxx89pswbOgPEwr/cwo8YrMs2jR
	 pI4Ihu67hpbNQbxs2OAR+uyCbZCn4jI5aVuBf4JYf9iNJ8Ca352bUSir+W0KuV+bJ3
	 17X/GBkIjLz2EOzbzqW5G+dU16Tc4vC03DbRdE9Z4ZGkBQzACipce8Bm64GjcpP0pU
	 w9ajPujTR05tg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: print-tree: print correct inline extent data size
Date: Mon, 15 Sep 2025 17:37:10 +0100
Message-ID: <856c0c08f6104d5404abb6d85a97b685e501d9a6.1757952682.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757952682.git.fdmanana@suse.com>
References: <cover.1757952682.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are advertising the ram_bytes of an inline extent as its data size, but
that is not true for compressed extents. The ram_bytes corresponds to the
uncompressed data size while the data size (compressed data) is given by
btrfs_file_extent_inline_item_len(). So fix this and print both values in
the same format as in btrfs-progs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index c2898fa6d4ba..835b41874a7a 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -6,6 +6,7 @@
 #include "messages.h"
 #include "ctree.h"
 #include "disk-io.h"
+#include "file-item.h"
 #include "print-tree.h"
 #include "accessors.h"
 #include "tree-checker.h"
@@ -423,8 +424,9 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 				btrfs_file_extent_type(l, fi));
 			if (btrfs_file_extent_type(l, fi) ==
 			    BTRFS_FILE_EXTENT_INLINE) {
-				pr_info("\t\tinline extent data size %llu\n",
-				       btrfs_file_extent_ram_bytes(l, fi));
+				pr_info("\t\tinline extent data size %u ram_bytes %llu\n",
+					btrfs_file_extent_inline_item_len(l, i),
+					btrfs_file_extent_ram_bytes(l, fi));
 				break;
 			}
 			pr_info("\t\textent data disk bytenr %llu nr %llu\n",
-- 
2.47.2


