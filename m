Return-Path: <linux-btrfs+bounces-13886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DDAAB3935
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0E3461103
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8A72951D9;
	Mon, 12 May 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Yy/eFFYI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Yy/eFFYI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7F293472
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056557; cv=none; b=Ywsc3U057dsg4cNvxy6ReuueCJRszbbZg8g8Ec+yW/jRTolAiZdOTChNETPV16KlD+q0rFh3JsW+teR30uExCKrSHKRwC92/aQ78XJfDGo1xBqxixx0bQssbmBss7tjWKwxuMkIcEkCvkmFQaa5fv7xBwWY2IM/2G3WJwyxnbB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056557; c=relaxed/simple;
	bh=KkGJkhTEjWRLrEvPALmkc5ri2FNi2N7B+Lrrp6BmMUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rx0fOoaVeTH/KsYS8DS4igLae2l+7HJhKvvGGMOueuJj/z5jqlqrP7R1iP3PBN8HIagGxJeG1wQUXTqKDO1Ck3OwYZE48x7u95HQnggrGTHUiIduVU2kugrBodKwFnalRyajo+xa4XqzQwBVQFsydZckkDzT5rq4hQbAdtgkrRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Yy/eFFYI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Yy/eFFYI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 508F71F38A;
	Mon, 12 May 2025 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747056553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Qxdi0xzJdec2u5Wk101JweQExeG0qRnP5bYE8rHHtvU=;
	b=Yy/eFFYIa3vS0oous7GpUMBhk7pniVBgARKCcMPvsQBbO4Y4BlgzMPFXcQR8I+uN8BnRhR
	x3YeTjcvXO+iPT7kGsEwPXDN6QVqBbH84n79OmeJL44NNFCoh7ro/hJW6ydLW+1B4Ffe9r
	Jxy4RN930nehrjvvYLNWdH5VJCDl850=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Yy/eFFYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747056553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Qxdi0xzJdec2u5Wk101JweQExeG0qRnP5bYE8rHHtvU=;
	b=Yy/eFFYIa3vS0oous7GpUMBhk7pniVBgARKCcMPvsQBbO4Y4BlgzMPFXcQR8I+uN8BnRhR
	x3YeTjcvXO+iPT7kGsEwPXDN6QVqBbH84n79OmeJL44NNFCoh7ro/hJW6ydLW+1B4Ffe9r
	Jxy4RN930nehrjvvYLNWdH5VJCDl850=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E278137D2;
	Mon, 12 May 2025 13:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HOm8Cqn3IWhoKAAAD6G6ig
	(envelope-from <neelx@suse.com>); Mon, 12 May 2025 13:29:13 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: correct the assert for subpage case
Date: Mon, 12 May 2025 15:28:50 +0200
Message-ID: <20250512132850.2973032-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 508F71F38A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim]
X-Spam-Score: -3.01

The assert is only true in !subpage case. We can either fix it this way
or completely remove it.

This fixes and should be folded into:
	btrfs: fix broken drop_caches on extent buffer folios

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 80a8563a25add..3b3f73894ffe2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3411,7 +3411,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 
-		ASSERT(!folio_test_private(folio));
+		ASSERT(!btrfs_meta_is_subpage(fs_info) && !folio_test_private(folio));
 		folio_put(folio);
 		eb->folios[i] = NULL;
 	}
-- 
2.47.2


