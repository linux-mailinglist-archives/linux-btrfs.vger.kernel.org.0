Return-Path: <linux-btrfs+bounces-12297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D3A62353
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 01:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8813BE524
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC637D26D;
	Sat, 15 Mar 2025 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M2ijLi1L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M2ijLi1L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48917578
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999377; cv=none; b=bdsIOeHsRNaFmeZaUEtTzbz+xHYaVT5yb7MnPVesAny7LZDvnp/P4UsCnXn7uwiRYMbRE5smGnq3RJE8mpMW3rsWhX7l566u5KTFXM/o/F+2cPRJV8ojfjt2Qr0FAZof+QjkUrIYko9CLyK0J1dIIPdh7KUHTqJResQmvxinjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999377; c=relaxed/simple;
	bh=mp7Hg6NTG1kBcAShqejDWAvWrektxAdwNKEVLqfJgn0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqAnXNWRseQdyPc9AKm0YfjJKpxpTQLixmVxV0u5Vf2Z+Vkc8csslmR6pz2y07j1JEvgxnJ5iKKomOcWwMSyOOEp46Bccso1VkS9rGuLu5Acuwlh92ioE2YarKJN8XxYsdipALjQOPs9BEYJxU9AmXerYILgcs86Ceo3gGXtsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M2ijLi1L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M2ijLi1L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F5251F388
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Awe5QSBb8KdrfiIW4nThvXS249QD03t8AlI5GqNY4I4=;
	b=M2ijLi1LtwfbblzM+vnzwJ+GcRSisOxvVtsQUKS81ZQtw3P4CFbldASuPBskSLLwcSa70k
	574xHlWQKCRRxyEkl37qoMW2uvPhRjGpJRQxZmW3f/LIgd9DeuP2gmgo5zGZXbkoXSjRlS
	rINaObdLpPThe1zwmkxUO9GCEmwkq/s=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=M2ijLi1L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Awe5QSBb8KdrfiIW4nThvXS249QD03t8AlI5GqNY4I4=;
	b=M2ijLi1LtwfbblzM+vnzwJ+GcRSisOxvVtsQUKS81ZQtw3P4CFbldASuPBskSLLwcSa70k
	574xHlWQKCRRxyEkl37qoMW2uvPhRjGpJRQxZmW3f/LIgd9DeuP2gmgo5zGZXbkoXSjRlS
	rINaObdLpPThe1zwmkxUO9GCEmwkq/s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBE6913797
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kKajJQXN1GegXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/7] btrfs: prepare end_bbio_data_write() for larger data folios
Date: Sat, 15 Mar 2025 11:12:16 +1030
Message-ID: <776e2f7fa1fc03afb2e6785ea8436a23e21b9ea8.1741999217.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741999217.git.wqu@suse.com>
References: <cover.1741999217.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F5251F388
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function is doing an ASSERT() checking the folio order,  but all
later functions are handling larger folios properly, thus we can safely
remove that ASSERT().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7db74a173b77..d5d4f9b06309 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -462,9 +462,6 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		u64 start = folio_pos(folio) + fi.offset;
 		u32 len = fi.length;
 
-		/* Only order 0 (single page) folios are allowed for data. */
-		ASSERT(folio_order(folio) == 0);
-
 		/* Our read/write should always be sector aligned. */
 		if (!IS_ALIGNED(fi.offset, sectorsize))
 			btrfs_err(fs_info,
-- 
2.48.1


