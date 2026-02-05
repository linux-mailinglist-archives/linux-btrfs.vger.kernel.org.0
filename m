Return-Path: <linux-btrfs+bounces-21399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILyGMw4vhWn49gMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21399-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 01:00:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F19F879F
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 01:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B75233022914
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Feb 2026 00:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B732E72C;
	Fri,  6 Feb 2026 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kNi/D4V8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kNi/D4V8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4B328B5D
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336009; cv=none; b=EQzdlaUsPr7fhKSW+oLQVELQwYN7TGR4iPHGAVlWkGv5T3mQuG3K7GMW7cllqhVUhRydCkqu61K468/1AeVNZcKylyG0rQUNXX7aK7p1cecTyEG7KWClXPIE5CRu7UpqgH5epyH24f8zfN6xDMcsuMD4zMnem0dYT1JN1rjX7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336009; c=relaxed/simple;
	bh=ED2Xu5zeC412GxjVsvl9XP6/19UFvMxOja1TEYgNmEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aG6ME1XE0xXBvfwLszhzOoGYDlPx4GlYsqEahDXb+yIb2msNbzp6KtK24/rsOkaWrQa0s128hl4ct5UayigwQlMrk+s9b4qtXxLpsClj4Y9Ne6wWVAUf2YguSObIEaOKzqeSMtdwGXC09OQw4nrLLW7MIWybQDVYEOWSue2mNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kNi/D4V8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kNi/D4V8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45A653E6D5
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770336003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKv70NqE56QdChz057p1LWa2r8LVbw5ciFXTF4AKFSc=;
	b=kNi/D4V8qYgZu8xJ8mfUUYTRV/UCHe1m7fSweRuLBqgWIn87Od4m2G3w+Eg08v5IVXgkb9
	NzYnJmdD0oun2pBWh7JN/9fSxQxXgIKhY2tzi+4aw/u+4C3PPc0gIJtArYJ90g3vaX0mUq
	DMG4Yk2q1HmG3RrYo9xe9XphAaYUHas=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="kNi/D4V8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770336003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKv70NqE56QdChz057p1LWa2r8LVbw5ciFXTF4AKFSc=;
	b=kNi/D4V8qYgZu8xJ8mfUUYTRV/UCHe1m7fSweRuLBqgWIn87Od4m2G3w+Eg08v5IVXgkb9
	NzYnJmdD0oun2pBWh7JN/9fSxQxXgIKhY2tzi+4aw/u+4C3PPc0gIJtArYJ90g3vaX0mUq
	DMG4Yk2q1HmG3RrYo9xe9XphAaYUHas=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7631A3EA63
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IHBNDgIvhWlzOQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Feb 2026 00:00:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check: report all orphan free space info keys
Date: Fri,  6 Feb 2026 10:29:41 +1030
Message-ID: <40f042e256041a18f092766404575f692bccda55.1770335913.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770335913.git.wqu@suse.com>
References: <cover.1770335913.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21399-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48F19F879F
X-Rspamd-Action: no action

And also output the logical and length for the orphan space info key.

Now the new reports will looks like this:

 [4/8] checking free space tree
 Space key logical 1048576 length 4194304 has no corresponding block group
 Space key logical 5242880 length 8388608 has no corresponding block group

This shouldn't affect end users that much, but provide much better debug
info for developers who want to fix those bad free space tree entries.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/clear-cache.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/clear-cache.c b/common/clear-cache.c
index 75cd8d50d25a..47d5751ff2c9 100644
--- a/common/clear-cache.c
+++ b/common/clear-cache.c
@@ -138,6 +138,7 @@ static int check_free_space_tree(struct btrfs_root *root)
 	struct btrfs_key key = { 0 };
 	struct btrfs_path path = { 0 };
 	int ret = 0;
+	bool found_orphan = false;
 
 	while (1) {
 		struct btrfs_block_group *bg;
@@ -167,16 +168,19 @@ static int check_free_space_tree(struct btrfs_root *root)
 		bg = btrfs_lookup_block_group(fs_info, key.objectid);
 		if (!bg) {
 			fprintf(stderr,
-		"We have a space info key for a block group that doesn't exist\n");
-			ret = -EINVAL;
-			goto out;
+"Space key logical %llu length %llu has no corresponding block group\n",
+				key.objectid, key.offset);
+			found_orphan = true;
 		}
 
 		btrfs_release_path(&path);
 		key.objectid += key.offset;
 		key.offset = 0;
 	}
-	ret = 0;
+	if (found_orphan)
+		ret = -EINVAL;
+	else
+		ret = 0;
 out:
 	btrfs_release_path(&path);
 	return ret;
-- 
2.52.0


