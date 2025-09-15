Return-Path: <linux-btrfs+bounces-16827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD60B58241
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE8F2A0F74
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DB03B1AB;
	Mon, 15 Sep 2025 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sozu7jQa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6528151E
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954240; cv=none; b=BCFIIpRIkrF/XKYR5nBErtY4PGB8VQbCw/fJDyZ9vnL2J7ctI4UvHjSS69G8CXsAKztoSygLx7o6+h5frMM1XaaTKZ561B94bZAEkl6oUhMRdGI2611qd7A9xZrdeDdrMSkyaOhOXYeEs8FU1030jKbwCoKFSHT3Lcn+r5e++eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954240; c=relaxed/simple;
	bh=VZOLP9+Oey2WDJqXEBh9NjcNUIiMXTVmXab/W6XnJw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtiN43K0zqp73il4ahhZcj80l11q6FyaH/dDXLU5BSA7ylN2s2ubOXDWpoySDZtEWel3Q5gNAUOIKqPazmW6si3IKfLW+45I0xHExg4U5rW6dZq5bhXUYiwlI5QYP/9stiqScvIhDgqqDJJwy5h2RzDANY8D/yovzP4kRJmgF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sozu7jQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D423FC4CEFB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954239;
	bh=VZOLP9+Oey2WDJqXEBh9NjcNUIiMXTVmXab/W6XnJw4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Sozu7jQaUES7yo9BL33jOTAe82e7WABa2ZPykzse1ABl7WiRB7wHeXJupAbx1+/oV
	 XML+7UyvC/qSgyGeC7HaLgW2VyXXFKdlarc+fgCt+SoM317uFz3yyp6LaluejQTVo2
	 DNglE8AsatjLMe1dSGOldbRi8stmJjBlGC+k+rJvi5hOX49ofAG4kj2OMShwZC0nSo
	 JGpvp9QRTCsQais0PtOI4NYDLOK0YCkXJYpSLhvpH3efJCDkJb81l47bgBLplOBwfm
	 DCOM7eTSuQD4qjm9djV8Hqf7+q80dLIlaUwZT1jv08/Y9t6/chStYUxaSZxREaBN9W
	 TamDafuQLndVA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/11] btrfs: print-tree: print more information about dir items
Date: Mon, 15 Sep 2025 17:37:04 +0100
Message-ID: <2a2afe7a48b90a26ea7651d6969ea2551bceaed0.1757952682.git.fdmanana@suse.com>
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

Currently we only print the object id component of the location key from a
dir item and the flags. We are missing the whole key, transid and the name
and data lengths. We are also ignoring the fact that we can have multiple
dir item objects encoded in a single item for a BTRFS_DIR_ITEM_KEY key, so
what we print is only for the first item.

Improve on this by iterating on all dir items and print the missing
information. This is done with the same format as in btrfs-progs, what
we miss is printing the names and data since not only that would require
some processing and escaping like in btrfs-progs, but it would also reveal
information that may be sensitive and users may not want to share that in
case that get a leaf dumped in dmesg.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index ce89974f8fd4..df7fe10061ab 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -257,20 +257,41 @@ static void print_inode_item(const struct extent_buffer *eb, int i)
 	print_timespec(eb, &ii->otime, "\t\totime ", "\n");
 }
 
+static void print_dir_item(const struct extent_buffer *eb, int i)
+{
+	const u32 size = btrfs_item_size(eb, i);
+	struct btrfs_dir_item *di = btrfs_item_ptr(eb, i, struct btrfs_dir_item);
+	u32 cur = 0;
+
+	while (cur < size) {
+		const u32 name_len = btrfs_dir_name_len(eb, di);
+		const u32 data_len = btrfs_dir_data_len(eb, di);
+		const u32 len = sizeof(*di) + name_len + data_len;
+		struct btrfs_key location;
+
+		btrfs_dir_item_key_to_cpu(eb, di, &location);
+		pr_info("\t\tlocation key (%llu %u %llu) type %d\n",
+			location.objectid, location.type, location.offset,
+			btrfs_dir_ftype(eb, di));
+		pr_info("\t\ttransid %llu data_len %u name_len %u\n",
+			btrfs_dir_transid(eb, di), data_len, name_len);
+		di = (struct btrfs_dir_item *)((char *)di + len);
+		cur += len;
+	}
+}
+
 void btrfs_print_leaf(const struct extent_buffer *l)
 {
 	struct btrfs_fs_info *fs_info;
 	int i;
 	u32 type, nr;
 	struct btrfs_root_item *ri;
-	struct btrfs_dir_item *di;
 	struct btrfs_block_group_item *bi;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_extent_data_ref *dref;
 	struct btrfs_shared_data_ref *sref;
 	struct btrfs_dev_extent *dev_extent;
 	struct btrfs_key key;
-	struct btrfs_key found_key;
 
 	if (!l)
 		return;
@@ -294,11 +315,7 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			print_inode_item(l, i);
 			break;
 		case BTRFS_DIR_ITEM_KEY:
-			di = btrfs_item_ptr(l, i, struct btrfs_dir_item);
-			btrfs_dir_item_key_to_cpu(l, di, &found_key);
-			pr_info("\t\tdir oid %llu flags %u\n",
-				found_key.objectid,
-				btrfs_dir_flags(l, di));
+			print_dir_item(l, i);
 			break;
 		case BTRFS_ROOT_ITEM_KEY:
 			ri = btrfs_item_ptr(l, i, struct btrfs_root_item);
-- 
2.47.2


