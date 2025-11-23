Return-Path: <linux-btrfs+bounces-19275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938C2C7E9BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 00:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D92B3A3953
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Nov 2025 23:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2DD21D3F2;
	Sun, 23 Nov 2025 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c6CGNpex";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c6CGNpex"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30815E8B
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940782; cv=none; b=carkx9mB5b7ROWaGpD74JsJBN+6h5Jy+wrPClT+8FBCkHcDwM575Egf1OP5C2NykIJ+eGigK+Odcacj0+NxEQm/Dcq8liqIX6fV8h38b0tkbtkLTzIeYrVoYrgmjDOHq5pI80n7EiZr4Z4G8thKPVro7cygR1gu6FtZuGSPfz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940782; c=relaxed/simple;
	bh=jeou3HDt/DCEYrnnZtnIfveAZ0bLW1JS/UCIfx7VmfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNCrOQ8yndENZN/1d9onauJx5pw49U/Tt4Wf1QCGkmSawy9mw5ua+QxXQ4lCSK3j39Olophck+wZht1eK92dmWsX1owJ59cZBpS1w/L+661Q8zgkEWGqRHXVcMRh+d1cKhiWMTZFvjbTpN3kO6yHW1ryqP0saU5ayxKN2SzgC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c6CGNpex; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c6CGNpex; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5ADA021D99
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763940767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LxzOk0n8Sw/nYIB3G3BJkTEcahpcPlGHIFC+diOQZk=;
	b=c6CGNpexVJPcJ3Gyl5SCMUkO8bdJ77xqJ+4WDaafNMME/7NqYxBy8GeD3qOJHe2zVEctEf
	WUT9lI0qWIkqp6d4tGj2Rg+8/yakvswAbir4inORAkSbU6rbit7H2GhL4iyOb8mvGkeHtR
	jcGd8bJzGmQycn/P/NycxT9YAVzdtHk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=c6CGNpex
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763940767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LxzOk0n8Sw/nYIB3G3BJkTEcahpcPlGHIFC+diOQZk=;
	b=c6CGNpexVJPcJ3Gyl5SCMUkO8bdJ77xqJ+4WDaafNMME/7NqYxBy8GeD3qOJHe2zVEctEf
	WUT9lI0qWIkqp6d4tGj2Rg+8/yakvswAbir4inORAkSbU6rbit7H2GhL4iyOb8mvGkeHtR
	jcGd8bJzGmQycn/P/NycxT9YAVzdtHk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 980943EA61
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4ADRFp6ZI2kGRQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: refactor hole cases of btrfs_get_extent()
Date: Mon, 24 Nov 2025 10:02:25 +1030
Message-ID: <5fce18c489e28ba9eade27f9acc79a31b1591cc6.1763939785.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763939785.git.wqu@suse.com>
References: <cover.1763939785.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5ADA021D99
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

There are several cases in btrfs_get_extent() we're returning a hole.

- A special corner case where path.slot[0] == 0 and no exact match
  This is the special case where we are the lowest key of the whole
  tree.
  This means there is not even an inode item.

  But for btrfs_get_extent() it just means the whole inode range should
  be a hole.

- EOF cases
  Those are where no more items or no more file extent items for the
  same inode.

  Thus the range must be a hole.

- Hole without a hole file extent item
  This is the NO-HOLES feature, thus the range between the previous file
  extent and the current file extent should be a hole.

Furthermore there is a very weird code block inside that function:

 	btrfs_extent_item_to_extent_map(...);
	if (...)
		goto insert;
	else if (...) {
		/* Do something. */
		goto insert;
	}
not_found:
	/* Do something */
insert:
	/* The remaining logic */

This makes the whole code flow after btrfs_extent_item_to_extent_map()
to be hard to follow.

Refactor the function btrfs_get_extent() by:

- Add comments about the above hole cases

- Introduce a helper, set_hole_em(), to set the hole extent map

- Remove not_found: tag

- Remove unnecessary "goto insert;" calls
  The "goto insert;" calls after we got a regular extent map is just to
  skip setting the extent map to a hole.
  Since now every explicit hole case is calling set_hole_em() then
  insert the hole, there is no need to explicitly call "goto insert;".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 49 +++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3a76cea1d43d..2e0dc82c4f17 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7045,6 +7045,13 @@ static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 	return 0;
 }
 
+static void set_hole_em(struct extent_map *em, u64 start, u64 len)
+{
+	em->start = start;
+	em->len = len;
+	em->disk_bytenr = EXTENT_MAP_HOLE;
+}
+
 /*
  * Lookup the first extent overlapping a range in a file.
  *
@@ -7123,8 +7130,16 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	if (ret < 0) {
 		goto out;
 	} else if (ret > 0) {
-		if (path->slots[0] == 0)
-			goto not_found;
+		if (path->slots[0] == 0) {
+			/*
+			 * The rare case where we're already the first key
+			 * of the whole tree.
+			 * This means even no inode item for the inode.
+			 * Thus the whole range should be a hole.
+			 */
+			set_hole_em(em, start, len);
+			goto insert;
+		}
 		path->slots[0]--;
 		ret = 0;
 	}
@@ -7172,31 +7187,32 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
 				goto out;
-			else if (ret > 0)
-				goto not_found;
+			if (ret > 0) {
+				/* EOF, thus a hole. */
+				set_hole_em(em, start, len);
+				goto insert;
+			}
 
 			leaf = path->nodes[0];
 		}
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		if (found_key.objectid != objectid ||
-		    found_key.type != BTRFS_EXTENT_DATA_KEY)
-			goto not_found;
+		    found_key.type != BTRFS_EXTENT_DATA_KEY) {
+			/* EOF, thus a hole. */
+			set_hole_em(em, start, len);
+			goto insert;
+		}
 		if (start > found_key.offset)
 			goto next;
 
-		/* New extent overlaps with existing one */
-		em->start = start;
-		em->len = found_key.offset - start;
-		em->disk_bytenr = EXTENT_MAP_HOLE;
+		/* The range [start, found_key.offset) is a hole. */
+		set_hole_em(em, start, found_key.offset - start);
 		goto insert;
 	}
 
 	btrfs_extent_item_to_extent_map(inode, path, item, em);
 
-	if (extent_type == BTRFS_FILE_EXTENT_REG ||
-	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
-		goto insert;
-	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
+	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		/*
 		 * Inline extent can only exist at file offset 0. This is
 		 * ensured by tree-checker and inline extent creation path.
@@ -7217,12 +7233,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		ret = read_inline_extent(path, folio);
 		if (ret < 0)
 			goto out;
-		goto insert;
 	}
-not_found:
-	em->start = start;
-	em->len = len;
-	em->disk_bytenr = EXTENT_MAP_HOLE;
 insert:
 	ret = 0;
 	btrfs_release_path(path);
-- 
2.52.0


