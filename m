Return-Path: <linux-btrfs+bounces-6217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4C9281C3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 08:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72E61F23705
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 06:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F86C13FD99;
	Fri,  5 Jul 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="arKUX4Pj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="arKUX4Pj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E055D52F
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160169; cv=none; b=I5zb3TubD6XnzPRkoEBoOO4K6LnFIVesnPBigHaTnceueFdWSEPBeUpCClmjka/EF/ODI7ALlC/58BAxxAEcPhuQWlXpvSvnlNeaAl3VMCd7TzgIhgaFPcS6fFiDyihT/73RjqZhStLXgFz6oscS94gu6iLZMyP2wQvLeEDYPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160169; c=relaxed/simple;
	bh=+a7MJ4gWaurTP93UlCY41PTrzMEC35mNBSmmuDkfWAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDMipsJzKNDLbrj+d7Z0rbJGt3/OZi9KMY3vKGcq/nYLRqvmgkvfVckUd2nO7olRragQ0XxZHu9iPJljy5INN2YDE6VM5siLryMYQukJy2SLrMFPZ63j9XthIPnZD82wKebYVShzc+h372A3cbf/GhKgL4eiksImwJozFD3w5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=arKUX4Pj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=arKUX4Pj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A731421A6E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720160164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79HRqgEp5pitJgEf2lCLIInuZ+GpS9hS/yD2fuOdtAQ=;
	b=arKUX4PjXDt2GPxDOX+oPGXGQVNMJftP+YpORGsGJVbNJ5oV0R0iWi6mAate5AZU7Edkb4
	xy81Fr4mGvgKcBOCWq2+aN60HtadjeWEc1CsCm7AwA+yVTC/gnn8PCEeCY3RQCpdG6D7dM
	LPJhOGjeVIbVxnduMt5GA/WLQC62HDo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720160164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79HRqgEp5pitJgEf2lCLIInuZ+GpS9hS/yD2fuOdtAQ=;
	b=arKUX4PjXDt2GPxDOX+oPGXGQVNMJftP+YpORGsGJVbNJ5oV0R0iWi6mAate5AZU7Edkb4
	xy81Fr4mGvgKcBOCWq2+aN60HtadjeWEc1CsCm7AwA+yVTC/gnn8PCEeCY3RQCpdG6D7dM
	LPJhOGjeVIbVxnduMt5GA/WLQC62HDo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C64AF1396E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oAx/H6OPh2YQFgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2024 06:16:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: do not use __GFP_NOFAIL flag for __alloc_extent_buffer()
Date: Fri,  5 Jul 2024 15:45:38 +0930
Message-ID: <d73d5cf4fe47728f885c8869d84794658ffe9cf4.1720159494.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720159494.git.wqu@suse.com>
References: <cover.1720159494.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

Although extent buffer is a critical infrastructure, I'm not convinced
that it really needs to go __GFP_NOFAIL.

As an experimental to reduce the __GFP_NOFAIL usage, for
CONFIG_BTRFS_DEBUG builds remove the __GFP_NOFAIL flag for
alloc_extent_buffer(), so we can test this change enough before pushing
it to end users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aa7f8148cd0d..d43a3a9fc650 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2672,9 +2672,13 @@ static struct extent_buffer *
 __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 		      unsigned long len)
 {
+	const bool debug = IS_ENABLED(CONFIG_BTRFS_DEBUG);
 	struct extent_buffer *eb = NULL;
 
-	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
+	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS |
+			       (!debug ? __GFP_NOFAIL : 0));
+	if (!eb)
+		return NULL;
 	eb->start = start;
 	eb->len = len;
 	eb->fs_info = fs_info;
-- 
2.45.2


