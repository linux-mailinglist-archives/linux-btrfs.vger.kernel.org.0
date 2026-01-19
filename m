Return-Path: <linux-btrfs+bounces-20668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49DD39E0C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 06:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B80AA3002147
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45B248881;
	Mon, 19 Jan 2026 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cKpGFPvu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cKpGFPvu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E82561A7
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768802073; cv=none; b=mnA2uH1hGDHxxyblS88bZ+KGUeOdum9jt/FPhFHHGByxp4SMLlYtIZNKKPj3X21ES2enF/Hw+y2HTZiG7TjJUh16awEjqFvY5UuSTJcng5XOjMcCglxxlxX1nCVXDRp3aqYW7/eE7QMHtQNOrQVKc1cqpvijUydCxGigCPdJZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768802073; c=relaxed/simple;
	bh=3VV52t8sgV8LTcGA9iRJbO5xM9d8ABVjdIFZdQlAwK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOf9Aox5pVmOW6h3WIJanE5PXJ4gjM+Jq2/PI3+B2AjBbD/H7ZQR11UyneKyFHtWPjMdb2ny5bFvKK8t8XukeKBXZ/PabBKy+XFFezVavWlied6Z/lPBDTQdSwGZjlcOA60EK8ZfTVolbc1HPJ3BCzkDDBbEMN2B63xqd9yCY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cKpGFPvu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cKpGFPvu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69CA53369F;
	Mon, 19 Jan 2026 05:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768802064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F8nIjxox4Z6AfR83XDdgrQM5L7d8c6Czka+AU3WT6b4=;
	b=cKpGFPvuq9j793BqSS6dm/J0GkPVPg7sy5n/VGezAl2GakYx5uVnOKX8YcyfS4jOGtDj9w
	4nY4mv8SjuDwHnO4UTL1B1eWoipimSHT/ZSU9b1pkwCEkvGerIMmgiOeEFwpJXGbDRuxRG
	hwMziIKht4QOwRJNDCAkVck8ABw8SYE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768802064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F8nIjxox4Z6AfR83XDdgrQM5L7d8c6Czka+AU3WT6b4=;
	b=cKpGFPvuq9j793BqSS6dm/J0GkPVPg7sy5n/VGezAl2GakYx5uVnOKX8YcyfS4jOGtDj9w
	4nY4mv8SjuDwHnO4UTL1B1eWoipimSHT/ZSU9b1pkwCEkvGerIMmgiOeEFwpJXGbDRuxRG
	hwMziIKht4QOwRJNDCAkVck8ABw8SYE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B5CD3EA63;
	Mon, 19 Jan 2026 05:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ij1/Lg7HbWl9YQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 19 Jan 2026 05:54:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-s390@vger.kernel.orgaa60fe12b4f49f49fc73e5023f8675e2df1f7805
Subject: [PATCH] btrfs: fix the folio leak on S390 hardware acceleration
Date: Mon, 19 Jan 2026 16:24:04 +1030
Message-ID: <bcf36edfb7ac3caf3373174e741bb29c0feb268b.1768802004.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[BUG]
After commit aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration
buffer preparation"), we no longer release the folio of the page cache
of folio returned by btrfs_compress_filemap_get_folio() for S390
hardware accerlation path.

[CAUSE]
Before that commit, we call kumap_local() and folio_put() after handling
each folio.

Although the timing is not ideal (it release previous folio at the
beginning of the loop, and rely on some extra cleanup out of the loop),
it at least handles the folio release correctly.

Meanwhile the refactored code is easier to read, it lacks the call to
release the filemap folio.

[FIX]
Add the missing folio_put() for copy_data_into_buffer().

Cc: linux-s390@vger.kernel.orgaa60fe12b4f49f49fc73e5023f8675e2df1f7805
Fixes: aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration buffer preparation")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zlib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 6caba8be7c84..10ed48d4a846 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -139,6 +139,7 @@ static int copy_data_into_buffer(struct address_space *mapping,
 		data_in = kmap_local_folio(folio, offset);
 		memcpy(workspace->buf + cur - filepos, data_in, copy_length);
 		kunmap_local(data_in);
+		folio_put(folio);
 		cur += copy_length;
 	}
 	return 0;
-- 
2.52.0


