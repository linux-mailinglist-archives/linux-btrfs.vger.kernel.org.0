Return-Path: <linux-btrfs+bounces-20167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5CBCF9521
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F00030591E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A44B330B20;
	Tue,  6 Jan 2026 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Slg5rfHn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Slg5rfHn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB23128BE
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716472; cv=none; b=ZnGmlzLvrGRcgNgVj+RVBODMY5uFA0zze3EDEE/XdRduHXSveLe/VKlRD1QQh84O/am17QStK9oqMsgSWKCBky5oXuC2f1GmNQHiCK2e7i52bsd/axjglKe7nocOlNFKa0+Jrm228nqa0jC3NyJ52kdXVTBrAOxXZw7z7SSLucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716472; c=relaxed/simple;
	bh=4Ga5QADH+ZIIdICRwZQjrV0xEQV55QTLSqbNhJU96sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEty4QqzVgFD5ZRctfDSyFqnJMYPclBiw8uBkykC3xnnmGXjoB1f/AyQmAKMLQjUk0QFM2foTr3aIn5kn5S7rn4ZFQsePE3WMgp0++Gl209BIhtHBFXFtn8UIhiMGUToK8oP1uRA1tF5awHebiv1F9PdCAe9KPR+nZ8lKOYW7IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Slg5rfHn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Slg5rfHn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CF5F33690;
	Tue,  6 Jan 2026 16:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkTblaIl33dizAeUuXfxtu7jnHW0yeaihrs7rpGx/u4=;
	b=Slg5rfHnZEPeiRU/heu7k1eyNPvu2QUz442l4tTa1SgVeRPvHDWJUr2yywETUzOZr6NhYj
	vYJbZl5GgMRqmVuceK5ztY56fsIZyzFtqMmBEmy2PeIL73wRGXRKFLAIXyUb/nVxh+VdVl
	iiRr7fnf/XKh9wumWDdWauy6jqgO7u4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkTblaIl33dizAeUuXfxtu7jnHW0yeaihrs7rpGx/u4=;
	b=Slg5rfHnZEPeiRU/heu7k1eyNPvu2QUz442l4tTa1SgVeRPvHDWJUr2yywETUzOZr6NhYj
	vYJbZl5GgMRqmVuceK5ztY56fsIZyzFtqMmBEmy2PeIL73wRGXRKFLAIXyUb/nVxh+VdVl
	iiRr7fnf/XKh9wumWDdWauy6jqgO7u4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67ACA3EA63;
	Tue,  6 Jan 2026 16:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 641NGWo2XWmwWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:20:58 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/12] btrfs: use common eb range validation in read_extent_buffer_to_user_nofault()
Date: Tue,  6 Jan 2026 17:20:28 +0100
Message-ID: <1a00041c9fec994ea70ba05edad7fd53a1630bc2.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.976];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

The extent buffer access is checked in other helpers by
check_eb_range(), which validates the requested start, length against
the extent buffer. While this almost never fails we should still handle
it as an error and not just warn.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 97cf1ad91e5780..897ea52167c612 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4003,8 +4003,8 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	unsigned long i;
 	int ret = 0;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	if (check_eb_range(eb, start, len))
+		return -EINVAL;
 
 	if (eb->addr) {
 		if (copy_to_user_nofault(dstv, eb->addr + start, len))
-- 
2.51.1


