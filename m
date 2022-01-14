Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802B748E1C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 01:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiANAvo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 19:51:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50798 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiANAvo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 19:51:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9A9F21905
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642121502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lvBr+pnf9BjsRHPYT2VtP1szJT7WTVh5UMGl31NIFI=;
        b=nKFyQY6F5WUS02CC77Q8EeplEJuP+ANbHXVDyPJOoxTIMZlcg5iUBsAmfe6v+HX8nEJgaw
        xzInZ7HmMp/tbOnyTLO1hc3zqGy3Nm8VOIpcj0fE/EiY14rA7oQ2KVfePPpxuSa4iGYWRh
        9eAZk2cJp9cmSLw7aVVEOuwu17Fzjrk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A0A61344A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ION5AB7J4GFWZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs-progs: backref: properly queue indirect refs
Date:   Fri, 14 Jan 2022 08:51:19 +0800
Message-Id: <20220114005123.19426-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114005123.19426-1-wqu@suse.com>
References: <20220114005123.19426-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When calling iterate_extent_inodes() on data extents with indirect ref
(with inline or keyed EXTENT_DATA_REF_KEY), it will fail to execute the
call back function at all.

[CAUSE]
In function find_parent_nodes(), we only add the target tree block if a
backref has @parent populated.

For indirect backref like EXTENT_DATA_REF_KEY, we rely on
__resolve_indirect_ref() to get the parent leaves.

However __resolve_indirect_ref() only grabs backrefs from
&prefstate->pending_indirect_refs.

Meaning callers should queue any indrect backref to
pending_indirect_refs.

But unfortunately in __add_prelim_ref() and __add_missing_keys(), none
of them properly queue the indirect backrefs to pending_indirect_refs,
but directly to pending.

Making all indirect backrefs never got resolved, thus no callback
function executed

[FIX]
Fix __add_prelim_ref() and __add_missing_keys() to properly queue
indirect backrefs to the correct list.

Currently there is no such direct user in btrfs-progs, but later csum
tree re-initialization code will rely this to do proper csum
re-calculate (to avoid preallocated/nodatasum extents).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/backref.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index 42832c481cae..f1a638ededa8 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -192,7 +192,10 @@ static int __add_prelim_ref(struct pref_state *prefstate, u64 root_id,
 	ref->root_id = root_id;
 	if (key) {
 		ref->key_for_search = *key;
-		head = &prefstate->pending;
+		if (parent)
+			head = &prefstate->pending;
+		else
+			head = &prefstate->pending_indirect_refs;
 	} else if (parent) {
 		memset(&ref->key_for_search, 0, sizeof(ref->key_for_search));
 		head = &prefstate->pending;
@@ -467,7 +470,10 @@ static int __add_missing_keys(struct btrfs_fs_info *fs_info,
 		else
 			btrfs_node_key_to_cpu(eb, &ref->key_for_search, 0);
 		free_extent_buffer(eb);
-		list_move(&ref->list, &prefstate->pending);
+		if (ref->parent)
+			list_move(&ref->list, &prefstate->pending);
+		else
+			list_move(&ref->list, &prefstate->pending_indirect_refs);
 	}
 	return 0;
 }
-- 
2.34.1

