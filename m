Return-Path: <linux-btrfs+bounces-12248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB8A5EA7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 05:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F6B3B4F25
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 04:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4263E13C81B;
	Thu, 13 Mar 2025 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u9QXvtsf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u9QXvtsf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74562B9A8
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839679; cv=none; b=VgZQpXltjuh5qXOCibwSIRg0QOJUs501ejWz2TfPEDG6Ph5e0wAFVbsg8TyXGgfeMnt1+SzxFJNx17F6eDv36fkLZQDBrhdWGCsWlLg+BouoW0gkRMh8WuSPDt3BTvWD95dUY0bRiJRYnQDcIMU7jaXrzkweOs5YMWjg+up81iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839679; c=relaxed/simple;
	bh=WRtsT7xbXvJcuhozplsrE//2lZmfudzPux+r5N82oUM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrUB6wGUIXSPEJSr3IkfeZCqkcwTezQMfd5aSh/x2umQ72I5VQ2CdlOApxpLgUYmkIXSdBu6I3Um9iCtU4c0GBjmBObLlzfk37B4ic5zw0AYcAVh3i9HClt3aHWO3I/1Rrmag6FKMRPRe1pFxC4JTKZZB4qfPcMSqF2WddKUY8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u9QXvtsf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u9QXvtsf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E78A92118F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoexVNuKJdevg89qearFpOJV+jILdlLudBwDcK1VE28=;
	b=u9QXvtsfHUZEv9YyuDwOIMYF0kXf+avCpzUJzGnE74JTH+ihRXVJ6i1FtoT2ufntPvl02s
	cXXy5/J56wYo6EGOENGYb1wOEyVPx1SJgCShTsK0nT9c8AkmwZ9l2pCFBpT8q2n4+uC5yx
	4J7IAdhzKP069gxmBeN658ZeyejCBoM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoexVNuKJdevg89qearFpOJV+jILdlLudBwDcK1VE28=;
	b=u9QXvtsfHUZEv9YyuDwOIMYF0kXf+avCpzUJzGnE74JTH+ihRXVJ6i1FtoT2ufntPvl02s
	cXXy5/J56wYo6EGOENGYb1wOEyVPx1SJgCShTsK0nT9c8AkmwZ9l2pCFBpT8q2n4+uC5yx
	4J7IAdhzKP069gxmBeN658ZeyejCBoM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2826113797
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sH08NjNd0mcrYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: send: remove the again label inside put_file_data()
Date: Thu, 13 Mar 2025 14:50:43 +1030
Message-ID: <ab9bc3e04e0344667b72edff9127e3fece6c4ab6.1741839616.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741839616.git.wqu@suse.com>
References: <cover.1741839616.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The again label is not really necessary and can be replaced by a simple
continue.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0c8c58c4f29b..43c29295f477 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5280,7 +5280,6 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 		unsigned cur_len = min_t(unsigned, len,
 					 PAGE_SIZE - pg_offset);
 
-again:
 		folio = filemap_lock_folio(mapping, index);
 		if (IS_ERR(folio)) {
 			page_cache_sync_readahead(mapping,
@@ -5316,7 +5315,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 			if (folio->mapping != mapping) {
 				folio_unlock(folio);
 				folio_put(folio);
-				goto again;
+				continue;
 			}
 		}
 
-- 
2.48.1


