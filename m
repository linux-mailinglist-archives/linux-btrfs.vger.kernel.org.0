Return-Path: <linux-btrfs+bounces-12315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E28A64301
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1D0169364
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF1A21ABCE;
	Mon, 17 Mar 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H9UClDys";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H9UClDys"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2178A1C6FF3
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195497; cv=none; b=ZKg2NTEKq/uWObQ4zLExGw8C99+Dy7sk6Yndtt6USgPN7uQuaSbJPf+0HGg4cl74L/rGPoU39kZRrpx/TYUlT3EYKUFC0C3Gg/2DIG1PgrwVPdeADIM6vMNB1gBT+RPAA0v/DPq5BU5AAY72M7GZ7yFpzuXoz7HmY0ldNKwOjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195497; c=relaxed/simple;
	bh=AMo0teFZQPOplYGmrfNa7zZ761A95Mtq+7ue7N0AHMA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLjWJ+dl/KKYMf7cImW/U4YjY2VrfP2QIcSOiXb7hkSMz0hGo+jfJnds4nMGl8uFsoD3jBIwjLXgpYgHtTgKR6K/QF61hwSPArvhyX5KB3Vd2gAnv7b5mMuqp4qBAZPP2L+ii4jebbxxbSY7JFDIQlsFF/HB62sYbPuWcnaFNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H9UClDys; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H9UClDys; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E248220D4
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJGybrNsRbJ4jjB1ezrpKDXfpOKpkjP/4VV4kQqCIMk=;
	b=H9UClDysB3umigBSFHvDyKuqSZY+YK7EpvOAx0hi6J3GHPj0C8qMKs0KBelYt7H46Ou9Ba
	+uWwAQJeB9JUOtwnpeYTKLAF47tf9ATeZQUflzX+LY2kELCbTkxR8HPvsVsW1ifyNCiXEQ
	SvBpJKwdf26eAT11L/0/pTREqjyEK/M=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJGybrNsRbJ4jjB1ezrpKDXfpOKpkjP/4VV4kQqCIMk=;
	b=H9UClDysB3umigBSFHvDyKuqSZY+YK7EpvOAx0hi6J3GHPj0C8qMKs0KBelYt7H46Ou9Ba
	+uWwAQJeB9JUOtwnpeYTKLAF47tf9ATeZQUflzX+LY2kELCbTkxR8HPvsVsW1ifyNCiXEQ
	SvBpJKwdf26eAT11L/0/pTREqjyEK/M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54D6313A31
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IJIkBhnL12e1YwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/9] btrfs: send: remove the again label inside put_file_data()
Date: Mon, 17 Mar 2025 17:40:46 +1030
Message-ID: <99ff0e4021e59bee11dedba4b614d10ac40ca8f5.1742195085.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742195085.git.wqu@suse.com>
References: <cover.1742195085.git.wqu@suse.com>
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
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The again label is here to retry to get the folio for the current index.
When triggering that label, there is no increasement on the iterator.

So it can be replaced by a simple "continue" and remove the again label.

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


