Return-Path: <linux-btrfs+bounces-16832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E0B58248
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4AC4C2129
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E26286415;
	Mon, 15 Sep 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7haG0i3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23B285CA4
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954244; cv=none; b=E6/3ApB+6DC+Q24CFd6Jmtq1i8iqkn0ZHddVlcgQLvVajYEX6cbF46jWjV1iLwDTRvNm2cRRetEWJhvNxCSKmi7ytjJKgAPL6u5FFUmisfonqpcq9/wvKxi9xZve3uamwwD0T8HI2IuMrj0FlJO5rE1COlAgZDYScY3RDgRVYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954244; c=relaxed/simple;
	bh=D/k0w8Fcop3NBXqHMWmz+Ew6aBErzBLzTTDKMlYP8UU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTxdYhpG+feth4rWFabTbANGywHJ53aHgRHJS52YBz4Xs5QMo0WDY6PDOLstCbvgFTAfSUOfZNSeJTrnplDyzdPSFJ0OVZCp0+vgUDkm/ddrPq/tj9zSWoCvjxtep1OPNwVxqwV5YDCHTZcJ698CU8B3PBMeUeoni+aSbOQmMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7haG0i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD5BC4CEFA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954244;
	bh=D/k0w8Fcop3NBXqHMWmz+Ew6aBErzBLzTTDKMlYP8UU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A7haG0i31/Zyw06/no8Op6qKxA/FPvtJpDAHhXURNlZXhoiJGmUUVyRLb71Qq4KVm
	 rz50qzRBfdRLN0QAhEk6ReemyqCDn9JdgwKjdTT7JwSN234AWKMWBNJ4dR7fQnhBq3
	 JCn7LrSoPDQ8W5i7lP1qTIGRwPWVO5p41ioJUp13nmmf7lm79phepSUXJa7D3HJQrG
	 Sa1UVSXqLVdciPV2K9g4OnMOSTI6c7nSlyowIWVrvj+EphlcOp1qqhLYosxC9GBmCs
	 ivevHcru4JGi+sULFgI7+z2qTNF/f+odAE4NiMxB3ornArJkScy//lpUhGDi+T/JrF
	 BiEwXodqY+lzg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs: print-tree: print range information for extent csum items
Date: Mon, 15 Sep 2025 17:37:09 +0100
Message-ID: <26ccc482137d071868f64bafb52beb2527510e42.1757952682.git.fdmanana@suse.com>
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

Currently we don't print anything for extent csum items other than the
generic line with the key, item offset and item size. While one can still
determine the range the extent csum covers by doing a few simple
computations, it makes it more time consuming to analyse a leaf dump.
So add a line that prints information about the range covered by the
checksum using the same format as btrfs-progs. This is useful when
debugging log tree issues since we log extent csum items for new extents.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index a66aced1d29c..c2898fa6d4ba 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -325,6 +325,18 @@ static void print_dir_log_index_item(const struct extent_buffer *eb, int i)
 	pr_info("\t\tdir log end %llu\n", btrfs_dir_log_end(eb, dlog));
 }
 
+static void print_extent_csum(const struct extent_buffer *eb, int i)
+{
+	const struct btrfs_fs_info *fs_info = eb->fs_info;
+	const u32 size = btrfs_item_size(eb, i);
+	const u32 csum_bytes = (size / fs_info->csum_size) * fs_info->sectorsize;
+	struct btrfs_key key;
+
+	btrfs_item_key_to_cpu(eb, &key, i);
+	pr_info("\t\trange start %llu end %llu length %u\n",
+		key.offset, key.offset + csum_bytes, csum_bytes);
+}
+
 void btrfs_print_leaf(const struct extent_buffer *l)
 {
 	struct btrfs_fs_info *fs_info;
@@ -373,6 +385,9 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 		case BTRFS_DIR_LOG_INDEX_KEY:
 			print_dir_log_index_item(l, i);
 			break;
+		case BTRFS_EXTENT_CSUM_KEY:
+			print_extent_csum(l, i);
+			break;
 		case BTRFS_ROOT_ITEM_KEY:
 			ri = btrfs_item_ptr(l, i, struct btrfs_root_item);
 			pr_info("\t\troot data bytenr %llu refs %u\n",
-- 
2.47.2


