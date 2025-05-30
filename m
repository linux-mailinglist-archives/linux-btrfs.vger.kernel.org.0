Return-Path: <linux-btrfs+bounces-14334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E428DAC935F
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB961C2030C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68791ACECE;
	Fri, 30 May 2025 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MzEGZ/xy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MzEGZ/xy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653C1A23B5
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621939; cv=none; b=DySyjbUjtFvnCE5b8lCTq5nTcwBZXGy0tRtEx+yFfrhvG2aZn2RPoIwT8ImgaWS5xQ1j2K6hFl7CGu9takCa3MOdyE7cdPCnZ1fr2NQuRsZpnvn8Jnqj3eCeza+zb7CnVdH8UM96Jg6xPn3HWKtEpgqTLWFOElZLqecZZ0Z3khY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621939; c=relaxed/simple;
	bh=7UAmyR3Hrpy5rvIP8ArrU4x2+25iUtWS8wqdKbYqMFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uu9Fz3+Qbyu2mTEoW9nQs7T8nm1HnU1as3P/piHkzziFL8XsDBS35L13noKnY4swX+yyBajSZ6YuHOhqeXEfFLllXFgSd/ahSePD3r/Xyx0mifsCVBwfBWDZqz3FmxDs7zTA9lvrIHtSURt+EWtw+fxcYefsIX49unYsWzfsPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MzEGZ/xy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MzEGZ/xy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A4531FC04;
	Fri, 30 May 2025 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zteQwlS77wAEKPmQYcfdRDhPj48MxTcWPvI7JZzVFos=;
	b=MzEGZ/xyZUN4Bb9KOkj8BOIn8vmgC92906M8WBeuBIZ5Ek2GoTLYupsuZklfoR12GdgVyC
	vj8BFey0MT0/ao7WfkY00EM+YYFTI0zxWTTLxGQtu0yV6kSmwr+5l4aXyFnpBBMtAj5wKE
	3OfP4CFqrtsnl9cpcHpqv7yGmYiFY9U=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zteQwlS77wAEKPmQYcfdRDhPj48MxTcWPvI7JZzVFos=;
	b=MzEGZ/xyZUN4Bb9KOkj8BOIn8vmgC92906M8WBeuBIZ5Ek2GoTLYupsuZklfoR12GdgVyC
	vj8BFey0MT0/ao7WfkY00EM+YYFTI0zxWTTLxGQtu0yV6kSmwr+5l4aXyFnpBBMtAj5wKE
	3OfP4CFqrtsnl9cpcHpqv7yGmYiFY9U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8063013996;
	Fri, 30 May 2025 16:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5FFRH2/aOWgOaAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:18:55 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 19/22] btrfs: rename err to ret in btrfs_wait_extents()
Date: Fri, 30 May 2025 18:18:55 +0200
Message-ID: <2a028866cb9d689d369126b666f5ca85415fb521.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/transaction.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b518a6c3517b..3ca57bb8dc64 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1211,15 +1211,15 @@ static int btrfs_wait_extents(struct btrfs_fs_info *fs_info,
 		       struct extent_io_tree *dirty_pages)
 {
 	bool errors = false;
-	int err;
+	int ret;
 
-	err = __btrfs_wait_marked_extents(fs_info, dirty_pages);
+	ret = __btrfs_wait_marked_extents(fs_info, dirty_pages);
 	if (test_and_clear_bit(BTRFS_FS_BTREE_ERR, &fs_info->flags))
 		errors = true;
 
-	if (errors && !err)
-		err = -EIO;
-	return err;
+	if (errors && !ret)
+		ret = -EIO;
+	return ret;
 }
 
 int btrfs_wait_tree_log_extents(struct btrfs_root *log_root, int mark)
-- 
2.47.1


