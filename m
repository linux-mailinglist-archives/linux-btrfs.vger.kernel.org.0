Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10DE29EE3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgJ2O3e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgJ2O3d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gk5pyXP7+g4qgTlvYWvhrQrhgwhHnDp6UOPh1WoiQ08=;
        b=aBYrANS8Hdwcbvjvgi8EQH3c5r6vOomiOhZ6flBUxaNWSsZK7iQEkq6/7UHR8DUrzwHZYL
        MgnG7KT9u8jbs2C/B5NdTmsPGy0lfZZ8EGafOvfVxIpJz6mCxt9AI8YB0NLmp/83OZfsto
        vFlBEEYN5Q7FEtVxNxwVQqin2k9g5ac=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69C3BACA3;
        Thu, 29 Oct 2020 14:29:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7DC2CDA7CE; Thu, 29 Oct 2020 15:27:56 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 09/10] btrfs: check integrity: remove local copy of csum_size
Date:   Thu, 29 Oct 2020 15:27:56 +0100
Message-Id: <8005d5d4ec27e0a966e2c2dc9af73713b78ea8ca.1603981453.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603981452.git.dsterba@suse.com>
References: <cover.1603981452.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The state structure unnecessarily stores copy of the checksum size, that
can be now easily obtained from fs_info.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/check-integrity.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 2905fe5974e6..d9d95d4a3f12 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -233,7 +233,6 @@ struct btrfsic_stack_frame {
 struct btrfsic_state {
 	u32 print_mask;
 	int include_extent_data;
-	int csum_size;
 	struct list_head all_blocks_list;
 	struct btrfsic_block_hashtable block_hashtable;
 	struct btrfsic_block_link_hashtable block_link_hashtable;
@@ -660,8 +659,6 @@ static int btrfsic_process_superblock(struct btrfsic_state *state,
 		return -1;
 	}
 
-	state->csum_size = state->fs_info->csum_size;
-
 	for (pass = 0; pass < 3; pass++) {
 		int num_copies;
 		int mirror_num;
@@ -1723,7 +1720,7 @@ static noinline_for_stack int btrfsic_test_for_metadata(
 		crypto_shash_update(shash, data, sublen);
 	}
 	crypto_shash_final(shash, csum);
-	if (memcmp(csum, h->csum, state->csum_size))
+	if (memcmp(csum, h->csum, fs_info->csum_size))
 		return 1;
 
 	return 0; /* is metadata */
@@ -2797,7 +2794,6 @@ int btrfsic_mount(struct btrfs_fs_info *fs_info,
 	state->fs_info = fs_info;
 	state->print_mask = print_mask;
 	state->include_extent_data = including_extent_data;
-	state->csum_size = 0;
 	state->metablock_size = fs_info->nodesize;
 	state->datablock_size = fs_info->sectorsize;
 	INIT_LIST_HEAD(&state->all_blocks_list);
-- 
2.25.0

