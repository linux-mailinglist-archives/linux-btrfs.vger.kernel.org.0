Return-Path: <linux-btrfs+bounces-1744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5383B3B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F91C23541
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048FA1353E8;
	Wed, 24 Jan 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMKyK2TU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMKyK2TU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62E1353E3
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131099; cv=none; b=hAU5XMdZ78Xt7MXMVhJJJAiE12fNLFS9GZ8WjYrTQqiNrBjCChvON6qCb8FPjoJfGYu1pWARZOD0fVcrWsy1+UJRbXUljcLVuXUPWdsZsnUZYpIpBnHVzu2YxrIDneOqH2OSpAkIhZCYRVrgWd++ThsfuuXxt/AMJ99PQ8/XlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131099; c=relaxed/simple;
	bh=BqKpxQdgaSpmKy/sN+JhkpTTyHzCdKK8sZN0x+JRcUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoWMRjsdDYObp7p/FIIGT8GdfDpbMINPw1ndFomE0GWrs3K8VkroGSMQ7U7mgJvK/DYY+GaGQcmdvIvPR0BTIzTVjJBE6qf5DkLvfX0Il63dyPmcmoUAev+4+EchgMr1PTbT41BpgASyyCr9uKPmXXnTLmSi1f9IUdSQF0liW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oMKyK2TU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oMKyK2TU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6C661FD8C;
	Wed, 24 Jan 2024 21:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcwYBEo3SuQA6HqcLIQmclOFp7JBHypfA5QvKaCkrc4=;
	b=oMKyK2TU4dnBROBx65Scs2U7ce+ToKmNp7HDUA1W+bV9b9qPOOP9QukkPTuduVcInEBl5d
	m6w48ohJC1gFBrj7EL9JUYBEnXJU1buWjV8alRN+jmy8z/vYdmzl8pzrT7nRY6yHWFcT77
	qn5g/mihCHsZXRc6mTCCnUOjKCGy3n4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcwYBEo3SuQA6HqcLIQmclOFp7JBHypfA5QvKaCkrc4=;
	b=oMKyK2TU4dnBROBx65Scs2U7ce+ToKmNp7HDUA1W+bV9b9qPOOP9QukkPTuduVcInEBl5d
	m6w48ohJC1gFBrj7EL9JUYBEnXJU1buWjV8alRN+jmy8z/vYdmzl8pzrT7nRY6yHWFcT77
	qn5g/mihCHsZXRc6mTCCnUOjKCGy3n4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD70913786;
	Wed, 24 Jan 2024 21:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Th0kMpd+sWWjdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/20] btrfs: handle invalid range and start in merge_extent_mapping()
Date: Wed, 24 Jan 2024 22:17:54 +0100
Message-ID: <6cd106844e522bbdd21f15572d81d4c9186725cc.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

Turn a BUG_ON to a properly handled error and update the error message
in the caller.  It is expected that @em_in and @start passed to
btrfs_add_extent_mapping() overlap. Besides tests, the only caller
btrfs_get_extent() makes sure this is true.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_map.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index f170e7122e74..ac5e366d57b2 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -539,7 +539,8 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 	u64 end;
 	u64 start_diff;
 
-	BUG_ON(map_start < em->start || map_start >= extent_map_end(em));
+	if (map_start < em->start || map_start >= extent_map_end(em))
+		return -EINVAL;
 
 	if (existing->start > map_start) {
 		next = existing;
@@ -634,9 +635,9 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 				free_extent_map(em);
 				*em_in = NULL;
 				WARN_ONCE(ret,
-"unexpected error %d: merge existing(start %llu len %llu) with em(start %llu len %llu)\n",
-					  ret, existing->start, existing->len,
-					  orig_start, orig_len);
+"extent map merge error existing [%llu, %llu) with em [%llu, %llu) start %llu\n",
+					  existing->start, existing->len,
+					  orig_start, orig_len, start);
 			}
 			free_extent_map(existing);
 		}
-- 
2.42.1


