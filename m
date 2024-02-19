Return-Path: <linux-btrfs+bounces-2495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A985A1AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C18B22403
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3952C686;
	Mon, 19 Feb 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MFa1zipl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MFa1zipl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508642C191
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341218; cv=none; b=V2r4sUXnygcfYQYW3pvXaGYyj6zDS6eHWQPppAOAlXYcxhU76ANO7VlkJKugl5VLUKUjS5obYYbXBD1uAB5EwgQFzxVgxJzpgAGJm0XdgsAvoZd4JVw11bExNCQG5uLVn7DIKUPH66z7AwyIGEtAa2zCw++3phEoKMMY+HBRaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341218; c=relaxed/simple;
	bh=pVYu11PqIFUN9kbrSLNsRd21/C0V/a4QaIQl9ViMGxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReUWFR60A+Q3CQEFnylldLOz3N/GBIQAEjCNdvQ1A0PmgOubqwH4BUoiUtMuHt7svuYexDAegb7KQfUdEW5mcSK1ltTHWPPecUi+UN4U03OcU/ZZvXZB6occcnojpQYl2XZV6gAq8m4tB3RU4J3D3wQ4kclog8XCkd6drrtJuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MFa1zipl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MFa1zipl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D77B1F7F2;
	Mon, 19 Feb 2024 11:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7VT6qGXrkwydx+mRbNje6FUFQfWIMMnbiz92ev+uxc=;
	b=MFa1ziplanq+eV6IE5oRJpAuTAYAwTSGQVZ8ezLw1fJAJFbt0EGWsS/ObQakWnz/Q3HSMO
	8GwzIJ1NxYzuZ39GZ+6A/yBQWK5P8BHolWHhoC4V/rsc5++HySwbmOgIABUikbDkvGWUfm
	7GDpRogyIfkq6glBDwLWq9G3TwwVEBs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7VT6qGXrkwydx+mRbNje6FUFQfWIMMnbiz92ev+uxc=;
	b=MFa1ziplanq+eV6IE5oRJpAuTAYAwTSGQVZ8ezLw1fJAJFbt0EGWsS/ObQakWnz/Q3HSMO
	8GwzIJ1NxYzuZ39GZ+6A/yBQWK5P8BHolWHhoC4V/rsc5++HySwbmOgIABUikbDkvGWUfm
	7GDpRogyIfkq6glBDwLWq9G3TwwVEBs=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 86224139C6;
	Mon, 19 Feb 2024 11:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id amm9IN4302WPZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:34 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/10] btrfs: drop static inline specifiers from tree-mod-log.c
Date: Mon, 19 Feb 2024 12:12:59 +0100
Message-ID: <225864132018de6b29f90403b21bd74817313b36.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[27.12%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

Using static inline in a .c file should be justified, e.g. when
functions are on a hot path but none of the affected functions seem to
be. As it's all in one compilation unit let the compiler decide.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-mod-log.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 3df6153d5d5a..43b3accbed7a 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -44,7 +44,7 @@ struct tree_mod_elem {
 /*
  * Pull a new tree mod seq number for our operation.
  */
-static inline u64 btrfs_inc_tree_mod_seq(struct btrfs_fs_info *fs_info)
+static u64 btrfs_inc_tree_mod_seq(struct btrfs_fs_info *fs_info)
 {
 	return atomic64_inc_return(&fs_info->tree_mod_seq);
 }
@@ -170,8 +170,7 @@ static noinline int tree_mod_log_insert(struct btrfs_fs_info *fs_info,
  * this until all tree mod log insertions are recorded in the rb tree and then
  * write unlock fs_info::tree_mod_log_lock.
  */
-static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb)
+static bool tree_mod_dont_log(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 {
 	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
 		return true;
@@ -188,7 +187,7 @@ static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
 }
 
 /* Similar to tree_mod_dont_log, but doesn't acquire any locks. */
-static inline bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
+static bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb)
 {
 	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
@@ -367,9 +366,9 @@ int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 	return ret;
 }
 
-static inline int tree_mod_log_free_eb(struct btrfs_fs_info *fs_info,
-				       struct tree_mod_elem **tm_list,
-				       int nritems)
+static int tree_mod_log_free_eb(struct btrfs_fs_info *fs_info,
+				struct tree_mod_elem **tm_list,
+				int nritems)
 {
 	int i, j;
 	int ret;
-- 
2.42.1


