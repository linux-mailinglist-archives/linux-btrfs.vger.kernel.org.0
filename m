Return-Path: <linux-btrfs+bounces-6219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08219281C5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 08:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9A81F23565
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 06:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02AE14388D;
	Fri,  5 Jul 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nmj4VsOo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nmj4VsOo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6E33C7
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160171; cv=none; b=Hi4ifCrNrxuSkFxu7prdZyaO7+/A9ExhjGtePgPp67tMJF6VnqaNX+PwbhFYna0CwQmxzpBZlfnbhwX7f7TRotMAumm/Jjg+xd9IOCWxoc2Zr+wnpw6tKRtIAbleRkmMYoYfq9qVmuf4lKsDNtY63zTsuWpgXP3qkhr1zX36hAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160171; c=relaxed/simple;
	bh=Yzp9btGfihkzwR0iH8P8r8blHaOab0Zmiqeb63bw1C4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5sAPNYxzQBO87zReeIEWHS+1LKMktlkwXGmkPCbToUbOWMX+TcjyUbZq7VCnEyPvrV1sCkiZIK1nG2ifkIH4C2m/KCoDlHmImam77rdkGoO7a/JY0wM3NyoK5IqLqlrEWUBJViUgUhBBFVv25mt3qzh8T+g759LwLhOI6nRhQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nmj4VsOo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nmj4VsOo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 807FA21AB1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720160167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4/Qm9roayGD289nzKUC5BwVOPzbIhE/IfmpoTKCHhA=;
	b=nmj4VsOoG+hGDJODBXXBhrL6QKXCHlbZ1pEA/g0Bmgi8mgkNj9fFOzre30VsIPc7zlsPFt
	62J0rYXj9mpqZEp1oafoDwQLaj/zvD/UTw0PKTqQlfC6rlPpdGOxJW/d19X6DygLuVQhol
	fIIE9vKt9SJCtcCIuXCGdBs82i0uokQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nmj4VsOo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720160167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4/Qm9roayGD289nzKUC5BwVOPzbIhE/IfmpoTKCHhA=;
	b=nmj4VsOoG+hGDJODBXXBhrL6QKXCHlbZ1pEA/g0Bmgi8mgkNj9fFOzre30VsIPc7zlsPFt
	62J0rYXj9mpqZEp1oafoDwQLaj/zvD/UTw0PKTqQlfC6rlPpdGOxJW/d19X6DygLuVQhol
	fIIE9vKt9SJCtcCIuXCGdBs82i0uokQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F5F21396E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qCsCFqaPh2YQFgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2024 06:16:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: do not use __GFP_NOFAIL flag for btrfs_alloc_folio_array()
Date: Fri,  5 Jul 2024 15:45:40 +0930
Message-ID: <a7dd241092b862c9c7c297181dd4f13525af8dbe.1720159494.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-3.97 / 50.00];
	BAYES_HAM(-2.96)[99.84%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 807FA21AB1
X-Spam-Flag: NO
X-Spam-Score: -3.97
X-Spam-Level: 

Since all callers of this function is already properly handling the
allocation error, and for the worst case we're just going to abort the
current transaction, I do no believe we need __GFP_NOFAIL here.

So to enable more testing and hopefully to provide a smooth transaction,
for CONFIG_BTRFS_DEBUG builds do not use __GFP_NOFAIL flag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 97c3f272fcaa..dadf0da171bf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -695,7 +695,8 @@ int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array)
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 			   bool nofail)
 {
-	const gfp_t gfp = nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;
+	const bool debug = IS_ENABLED(CONFIG_BTRFS_DEBUG);
+	const gfp_t gfp = GFP_NOFS | ((!debug && nofail) ? __GFP_NOFAIL : 0);
 	unsigned int allocated;
 
 	for (allocated = 0; allocated < nr_pages;) {
-- 
2.45.2


