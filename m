Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA5E4A8F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 19:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfFRR7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 13:59:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:45056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729349AbfFRR7Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 13:59:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43B2DAEBD
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 17:59:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 733C4DA871; Tue, 18 Jun 2019 20:00:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/6] btrfs: use common helpers for eb leak messages
Date:   Tue, 18 Jun 2019 20:00:03 +0200
Message-Id: <b074ebe0cbd8499350e44517ac2e402108be0c06.1560880630.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560880630.git.dsterba@suse.com>
References: <cover.1560880630.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extent buffer leak detector is a debugging feature, let's use the
existing helper that prints the information about the filesystem,
unlike pr_err.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 464e6b761a9c..8634eda07b7a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -67,7 +67,8 @@ void btrfs_leak_debug_check(void)
 
 	while (!list_empty(&states)) {
 		state = list_entry(states.next, struct extent_state, leak_list);
-		pr_err("BTRFS: state leak: start %llu end %llu state %u in tree %d refs %d\n",
+		btrfs_debug_rl(eb->fs_info,
+		"state leak: start %llu end %llu state %u in tree %d refs %d",
 		       state->start, state->end, state->state,
 		       extent_state_in_tree(state),
 		       refcount_read(&state->refs));
@@ -77,7 +78,8 @@ void btrfs_leak_debug_check(void)
 
 	while (!list_empty(&buffers)) {
 		eb = list_entry(buffers.next, struct extent_buffer, leak_list);
-		pr_err("BTRFS: buffer leak start %llu len %lu refs %d bflags %lu\n",
+		btrfs_debug_rl(eb->fs_info,
+		       "buffer leak start %llu len %lu refs %d bflags %lu",
 		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags);
 		list_del(&eb->leak_list);
 		kmem_cache_free(extent_buffer_cache, eb);
-- 
2.21.0

