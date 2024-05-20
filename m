Return-Path: <linux-btrfs+bounces-5097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0348C9846
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 05:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420981F223E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 03:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC88FC18;
	Mon, 20 May 2024 03:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tzcZikLj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tzcZikLj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EEDDDD4
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175856; cv=none; b=D60eTuSnULMuEtyzF95fVGNgTk9JmF6CBLfn+YVq9kHsVSVht8d8p/FBSL/l2AQzd/PVAPLx0JET28Crb91bV+IfxQ6PzHqmcIO1L7cNVzvxjQUv8FHQPYu9ShXP55NfbdxeuDLEHL8JcPEmINWb7nIcR8zQG/B/awrmYg8aHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175856; c=relaxed/simple;
	bh=sAOgb8zmYVBj9gSByGPR9X/8WmCITHeTztttUVv1F6k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DKkBcNbOhwgKNQ5KQsdUncLd6aH1w9DdwzqrsEnFBXO0/hwj/lqB8886/jr1BhvXpKZkVQ1ZXkCHevcMf2ubpnC43og0hbFfjKbIsl4q86FHAL8eCXHJ+H1lN81ps1KEaDdEf2WnlcQiOQH+apqPvwG+8+TEI1wiT2mxVFo3GwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tzcZikLj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tzcZikLj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5842C22D72
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 03:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716175852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CYcv+5QUkSh1zXfmw4igwSFDloRHcMQ4halZ2ce9csk=;
	b=tzcZikLjFfUEBbYj4A9elJsqGj6DWMTPtozhyVoQO+uj1oC3JtLNhhlKq1kjOhfkHRzAjx
	uUNgtziND3bZaNEVopBPEPuBJ+GykC/6U5CQVI277X1AJPdAwegy0T+syWQvLn95jRjNXW
	9FSySr/5E3xi9eBrsD+4aKjb3AZlO7w=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tzcZikLj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716175852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CYcv+5QUkSh1zXfmw4igwSFDloRHcMQ4halZ2ce9csk=;
	b=tzcZikLjFfUEBbYj4A9elJsqGj6DWMTPtozhyVoQO+uj1oC3JtLNhhlKq1kjOhfkHRzAjx
	uUNgtziND3bZaNEVopBPEPuBJ+GykC/6U5CQVI277X1AJPdAwegy0T+syWQvLn95jRjNXW
	9FSySr/5E3xi9eBrsD+4aKjb3AZlO7w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 644FE1378C
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 03:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QPT3B+vDSmbSZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 03:30:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not clear page dirty at extent_write_cache_pages()
Date: Mon, 20 May 2024 13:00:29 +0930
Message-ID: <868d6dec9ccac2f7cb320668b5bf4d53887a4eb6.1716175411.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.81
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5842C22D72
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-2.80)[99.16%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+]

[PROBLEM]
Currently we call folio_clear_dirty_for_io() for the locked dirty folio
inside extent_write_cache_pages().

However this call is not really subpage aware, it's from the older days
where one page can only have one sector.

But with nowadays subpage support, we can have multiple sectors inside
one page, thus if we clear the whole page dirty flag, it would make the
subpage and page dirty flags desynchronize.

Thankfully this is not a big deal as our current subpage routine always
call __extent_writepage_io() for all the subpage dirty ranges, thus it
would ensure there is no subpage range dirty left.

[FIX]
So here we just drop the folio_clear_dirty_for_io() call, and let
__extent_writepage_io() and extent_clear_unlock_delalloc() (which is for
compression path) to handle the dirty page and subapge clearing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This patch is independent from the subpage zoned fixes, thus it can be
applied either before or after the subpage zoned fixes.
---
 fs/btrfs/extent_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7275bd919a3e..a8fc0fcfa69f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2231,8 +2231,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				folio_wait_writeback(folio);
 			}
 
-			if (folio_test_writeback(folio) ||
-			    !folio_clear_dirty_for_io(folio)) {
+			if (folio_test_writeback(folio)) {
 				folio_unlock(folio);
 				continue;
 			}
-- 
2.45.1


