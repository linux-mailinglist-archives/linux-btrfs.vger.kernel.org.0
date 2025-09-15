Return-Path: <linux-btrfs+bounces-16831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08448B58245
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB114C1834
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C43E285C91;
	Mon, 15 Sep 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5MVURYk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72627B336
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954243; cv=none; b=g+imbciiNWCBax9+5WnK9uK61qLMznl5SV7mQNBS5zt1GRV7TZ+qSHW1SAo4VkRT/FfIfe/rxQ+S0ZR4i2jwzyg6CgqzQq/fETiJgTuR4lyjGtTGDp0ILOQm1h9TcBx21hJilJ5EpGLsPSrQr12X/6My+u03CvlCVVE7wLKb284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954243; c=relaxed/simple;
	bh=Wpy3lCkGlQMP7NYU5Almqe240zX0mgX1BmXBVmRgGd4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5RDHRP/j9Dr0AKtMbgo7u0eL/If4hmGMXmuoegCif3rUZ1Cu0wYlHCzJHIYriJAGcgToPGuWKsBxaGOXiCpW2Ng5Gq8CI+VHFBN5g89iUkAiiG0pgjukPZ9zM6mSh5tq55PIaj8PCYjfPrsSndVQ9vnkYSAOzZAoaoKE1SEeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5MVURYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF16C4CEF7
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954243;
	bh=Wpy3lCkGlQMP7NYU5Almqe240zX0mgX1BmXBVmRgGd4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u5MVURYkMYF43gEIBYZeJkJRtEZ4pVSfkoAivirDrnyorqa+/XajKUw+35hD6/Few
	 76zCp2L9DHX/0HOS4Fvhs2Thff3yuHHQ1hzpWe54F0/G9W/gVeifUSTqp6HhaxAGS9
	 2UgWmXzYeKFAMYw+4eAlmZ1zxxPssUAo3u0dK0XKxiPiOTgIi9Vcmoc9fWOgtS5cWQ
	 NGGKeaCVdTWbbJjMC72V5NRgHQlBrUWPk572nxV+pO1WaGdBZEzE/irrWW4lJIgxJq
	 Avuejuv+/mBOqPJ5lbsIFM4aHDz7k97KMCY0qQ8mxN2cp8mpfTAyJtp4OenzPkT/Jb
	 6+zbQCVvciLmQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/11] btrfs: print-tree: print information about dir log items
Date: Mon, 15 Sep 2025 17:37:08 +0100
Message-ID: <86e5ba78dd310a8980330b455e2d68cd2eef11bb.1757952682.git.fdmanana@suse.com>
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

We currently don't print information about dir log items (other than the
key, item offset and item size), which is useful to look at when debugging
problems with a log tree. So print their specific information (currently
they only have an end index number) in a format similar to btrfs-progs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 0a2a6e82a3bf..a66aced1d29c 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -317,6 +317,14 @@ static void print_inode_extref_item(const struct extent_buffer *eb, int i)
 	}
 }
 
+static void print_dir_log_index_item(const struct extent_buffer *eb, int i)
+{
+	struct btrfs_dir_log_item *dlog;
+
+	dlog = btrfs_item_ptr(eb, i, struct btrfs_dir_log_item);
+	pr_info("\t\tdir log end %llu\n", btrfs_dir_log_end(eb, dlog));
+}
+
 void btrfs_print_leaf(const struct extent_buffer *l)
 {
 	struct btrfs_fs_info *fs_info;
@@ -362,6 +370,9 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 		case BTRFS_XATTR_ITEM_KEY:
 			print_dir_item(l, i);
 			break;
+		case BTRFS_DIR_LOG_INDEX_KEY:
+			print_dir_log_index_item(l, i);
+			break;
 		case BTRFS_ROOT_ITEM_KEY:
 			ri = btrfs_item_ptr(l, i, struct btrfs_root_item);
 			pr_info("\t\troot data bytenr %llu refs %u\n",
-- 
2.47.2


