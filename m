Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77C481ACD
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Dec 2021 09:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhL3Ipc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Dec 2021 03:45:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34390 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhL3Ipc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Dec 2021 03:45:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DE17210F4
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640853931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=By1nxW0bodE4u63NJyRJbI1PMcsD3Jl/2U7gi965/ew=;
        b=CbxaYgm3FDwMkc+f0b2DsewScUBc/LkiwEbBeLKvhYmOn5M9Cs3u3OZOjodOAwOI5L1A0Y
        Gpv2FdvbXEdlPONX2cSzcUE8XHBq3wHO5VFbr9th6XhFcqZiyYV+i0XJ5m/QbJrhYBuqGN
        LI5zAEePx5ixlmL6YmCBZgBqUcl7w+Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA07413BB1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 08:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0BOBIqpxzWFweQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 08:45:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: selftests: dump extent io tree if extent-io-tree test failed
Date:   Thu, 30 Dec 2021 16:45:13 +0800
Message-Id: <20211230084513.29292-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When code modifying extent-io-tree get modified and got that selftest
failed, it can take some time to pin down the cause.

To make it easier to expose the problem, dump the extent io tree if the
selftest failed.

This can save developers debug time, especially since the selftest we
can not use the trace events, thus have to manually add debug trace
points.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/extent-io-tests.c | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index c2e72e7a8ff0e..160480f6155e8 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -56,6 +56,54 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
 	return count;
 }
 
+#define STATE_FLAG_STR_LEN	256
+
+#define print_one_flag(state, dest, cur, name)				\
+({									\
+	if (state->state & EXTENT_##name)				\
+		cur += scnprintf(dest + cur, STATE_FLAG_STR_LEN - cur,	\
+				 "%s" #name, cur == 0 ? "" : "|");	\
+})
+
+static void extent_flag_to_str(struct extent_state *state, char *dest)
+{
+	int cur = 0;
+
+	dest[0] = '\0';
+	print_one_flag(state, dest, cur, DIRTY);
+	print_one_flag(state, dest, cur, UPTODATE);
+	print_one_flag(state, dest, cur, LOCKED);
+	print_one_flag(state, dest, cur, NEW);
+	print_one_flag(state, dest, cur, DELALLOC);
+	print_one_flag(state, dest, cur, DEFRAG);
+	print_one_flag(state, dest, cur, BOUNDARY);
+	print_one_flag(state, dest, cur, NODATASUM);
+	print_one_flag(state, dest, cur, CLEAR_META_RESV);
+	print_one_flag(state, dest, cur, NEED_WAIT);
+	print_one_flag(state, dest, cur, DAMAGED);
+	print_one_flag(state, dest, cur, NORESERVE);
+	print_one_flag(state, dest, cur, QGROUP_RESERVED);
+	print_one_flag(state, dest, cur, CLEAR_DATA_RESV);
+}
+
+static void dump_extent_io_tree(struct extent_io_tree *tree)
+{
+	struct rb_node *node;
+	char flags_str[STATE_FLAG_STR_LEN];
+
+	node = rb_first(&tree->state);
+	test_msg("io tree content:");
+	while (node) {
+		struct extent_state *state;
+
+		state = rb_entry(node, struct extent_state, rb_node);
+		extent_flag_to_str(state, flags_str);
+		test_msg("  start=%llu len=%llu flags=%s", state->start,
+			 state->end + 1 - state->start, flags_str);
+		node = rb_next(node);
+	}
+}
+
 static int test_find_delalloc(u32 sectorsize)
 {
 	struct inode *inode;
@@ -258,6 +306,8 @@ static int test_find_delalloc(u32 sectorsize)
 	}
 	ret = 0;
 out_bits:
+	if (ret)
+		dump_extent_io_tree(tmp);
 	clear_extent_bits(tmp, 0, total_dirty - 1, (unsigned)-1);
 out:
 	if (locked_page)
@@ -534,6 +584,8 @@ static int test_find_first_clear_extent_bit(void)
 
 	ret = 0;
 out:
+	if (ret)
+		dump_extent_io_tree(&tree);
 	clear_extent_bits(&tree, 0, (u64)-1, CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
 	return ret;
-- 
2.34.1

