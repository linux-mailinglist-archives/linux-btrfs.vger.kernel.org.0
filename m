Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC853190B8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 11:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCXKxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 06:53:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgCXKxZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 06:53:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A7CA6AF39
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 10:53:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs-progs: check/original: Fix uninitialized memory for newly allocated data_backref
Date:   Tue, 24 Mar 2020 18:53:12 +0800
Message-Id: <20200324105315.136569-4-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324105315.136569-1-wqu@suse.com>
References: <20200324105315.136569-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Valgrind reports the following error for fsck/002 (which only supports
original mode):
  ==97088== Conditional jump or move depends on uninitialised value(s)
  ==97088==    at 0x15BFF6: add_data_backref (main.c:4884)
  ==97088==    by 0x16025C: run_next_block (main.c:6452)
  ==97088==    by 0x165539: deal_root_from_list (main.c:8471)
  ==97088==    by 0x166040: check_chunks_and_extents (main.c:8753)
  ==97088==    by 0x166441: do_check_chunks_and_extents (main.c:8842)
  ==97088==    by 0x169D13: cmd_check (main.c:10324)
  ==97088==    by 0x11CDC6: cmd_execute (commands.h:125)
  ==97088==    by 0x11D712: main (btrfs.c:386)

[CAUSE]
In alloc_data_backref(), only ref->node is set to 0.
While ref->disk_bytenr is not initialized at all.

And then in add_data_backref(), if @back is a newly allocated data
backref, we use the garbage from back->disk_bytenr to determine if we
should reset them.

[FIX]
Fix it by initialize the whole data_backref structure in
alloc_data_backref().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index d8181249e394..37c5b35a36bd 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4516,7 +4516,7 @@ static struct data_backref *alloc_data_backref(struct extent_record *rec,
 
 	if (!ref)
 		return NULL;
-	memset(&ref->node, 0, sizeof(ref->node));
+	memset(ref, 0, sizeof(*ref));
 	ref->node.is_data = 1;
 
 	if (parent > 0) {
-- 
2.25.2

