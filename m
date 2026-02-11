Return-Path: <linux-btrfs+bounces-21624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMNeB+Lzi2mpdwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21624-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 04:13:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B43120E17
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 04:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D48E3056171
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 03:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B14B34251E;
	Wed, 11 Feb 2026 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nin/gVDi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nin/gVDi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4B287265
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770779606; cv=none; b=oOdHfdj7bh0VL5weT/xYy9cWn1L7YjLfQrEf96SGnrsCX2Hd0BumTfXbuKkvCIU2itAoW2pyI7bPT3znq083q+DWWdLfcKb+5b9YXcxm5ofkzeUbk/nuf1P1eAW0QAVfzYl/XOIYqLel4ezIOO7Gj25+A15QJwGaUp5liHLnvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770779606; c=relaxed/simple;
	bh=azLI3+M2T6GNczOiAV/j8YRgVc1kh1QmiyHcP8eT5XU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dDlYwY36iplxvMN05YZKHh64hfoFaRkLjzhzizsvMAaYAdgTHTKWkftDYpgjWeSk/BxuOFLVF6iDOzzJmR7Hh5Zz90qlDTNl/zC3baIeAXxg/9iZ/fIi+YaYJwMOATIdED93H8yXF/D16+SXJh4DBV9Lgizx+Vtp56tkM7QQjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nin/gVDi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nin/gVDi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A4323E723
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 03:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770779603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8Yw7o0t+0fnBN1/3gtnZ/Xcz0nCe2LEnJBq8FUb7c4g=;
	b=Nin/gVDit7yjKkburuPwI+QjXtKsXXrs+dS4uEcAtuPoFsG0zmtXsLI2+5byv+6RwETd9i
	PMXs9lQ26qmqiFAjyP+smKxtq1obKJqdQFgzkXNna1yxM+RXhqgCHevwUe7WvMpESbxcqE
	wl3XKS1pVakH3EVb9L6tw4Td1SCu5m0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770779603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8Yw7o0t+0fnBN1/3gtnZ/Xcz0nCe2LEnJBq8FUb7c4g=;
	b=Nin/gVDit7yjKkburuPwI+QjXtKsXXrs+dS4uEcAtuPoFsG0zmtXsLI2+5byv+6RwETd9i
	PMXs9lQ26qmqiFAjyP+smKxtq1obKJqdQFgzkXNna1yxM+RXhqgCHevwUe7WvMpESbxcqE
	wl3XKS1pVakH3EVb9L6tw4Td1SCu5m0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A5A13EA62
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 03:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hg8DCtLzi2mTNwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 03:13:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove out-of-date comments in btree_writepages()
Date: Wed, 11 Feb 2026 13:42:59 +1030
Message-ID: <f1694e9264f14706a274009aca35504f128c1df1.1770779554.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21624-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77B43120E17
X-Rspamd-Action: no action

There is a lengthy comment introduced in commit b3ff8f1d380e ("btrfs:
Don't submit any btree write bio if the fs has errors"), explaining why
we don't want to submit the metadata write bio when the fs has something
wrong.

However it's no longer uptodate by the following reasons:

- We have better checks nowadays
  Commit 2618849f31e7 ("btrfs: ensure no dirty metadata is written back
  for an fs with errors") has introduced better checks, that if the
  fs is in an error state, all metadata write will not result any bio
  but finished immediately.

  That covers all metadata writes better.

- Mentioning functions no longer there
  It mentions the function submit_extent_folio(), but the correct
  function is submit_eb_subpage(), which can return the number of ebs
  submitted for a page.

  And later commit 5e121ae687b8 ("btrfs: use buffer xarray for extent
  buffer writeback operations") completely reworks this, and now we
  always call write_one_eb() to submit an extent buffer, which has no
  return value.

Just remove the lengthy comment, and replace the "if (ret > 0)" check
with an ASSERT(), since only btrfs_check_meta_write_pointer() can modify
@ret and it returns 0 or errors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3df399dc8856..9999c3f4afa4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2386,38 +2386,12 @@ int btree_writepages(struct address_space *mapping, struct writeback_control *wb
 		index = 0;
 		goto retry;
 	}
+
 	/*
-	 * If something went wrong, don't allow any metadata write bio to be
-	 * submitted.
-	 *
-	 * This would prevent use-after-free if we had dirty pages not
-	 * cleaned up, which can still happen by fuzzed images.
-	 *
-	 * - Bad extent tree
-	 *   Allowing existing tree block to be allocated for other trees.
-	 *
-	 * - Log tree operations
-	 *   Exiting tree blocks get allocated to log tree, bumps its
-	 *   generation, then get cleaned in tree re-balance.
-	 *   Such tree block will not be written back, since it's clean,
-	 *   thus no WRITTEN flag set.
-	 *   And after log writes back, this tree block is not traced by
-	 *   any dirty extent_io_tree.
-	 *
-	 * - Offending tree block gets re-dirtied from its original owner
-	 *   Since it has bumped generation, no WRITTEN flag, it can be
-	 *   reused without COWing. This tree block will not be traced
-	 *   by btrfs_transaction::dirty_pages.
-	 *
-	 *   Now such dirty tree block will not be cleaned by any dirty
-	 *   extent io tree. Thus we don't want to submit such wild eb
-	 *   if the fs already has error.
-	 *
-	 * We can get ret > 0 from submit_extent_folio() indicating how many ebs
-	 * were submitted. Reset it to 0 to avoid false alerts for the caller.
+	 * Only btrfs_check_meta_write_pointer() can update @ret,
+	 * and it only returns 0 or errors.
 	 */
-	if (ret > 0)
-		ret = 0;
+	ASSERT(ret <= 0);
 	if (!ret && BTRFS_FS_ERROR(fs_info))
 		ret = -EROFS;
 
-- 
2.52.0


