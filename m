Return-Path: <linux-btrfs+bounces-20313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94765D06FFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 04:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F44430213F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 03:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0C4347C6;
	Fri,  9 Jan 2026 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kakx2yuV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kakx2yuV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D350094D
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929500; cv=none; b=f9+8fvQhrdrF1MKpzv5sl3PeWbUE+YKeAjexKxH6V7d+mcKrWcMGr42nwqMHVm/xZvEWLbIrDSJSRIzr1Sg3+fb2rgEk0NGshMZSDSgtEmQa8zuZ3y04fDxGpfRkFHBLY3Hay6ELeZd924uJD7uqEFiVuZkKNfxtmDniN+l3oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929500; c=relaxed/simple;
	bh=G8vfoNEx3NxH1ILNUn7/8hwmd7ACr+eSdlszXGO8eKE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EjOI3O43Cl7IOrcuhBKwKiPnC210fdKnzb8So6VJXasU3GhFVTkktJSxHTa8SaZrDbfGcOeJuz8bIL3bygqHtqmmUb5od3FANO18oAJqpUJaXIFvM28FtxKuqQd2M8SO9+Nhbe2qT2K1KcXsfx8GxmZJOIGUm09alCcBMgcTyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kakx2yuV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kakx2yuV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C895333952
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 03:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767929496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fslRaYaMZ+zQFEefS0CSAq8597fBZiVS2hO3UcZSCmU=;
	b=kakx2yuVVCagl74PWygyX5vjCtZHu9PcYoN8FwFBz40+n0ThkLONs8qfJhTGayWebe7svB
	Aq4Fz7SYXpYdE1NOsKg0lL+k7u9SmzzWJp7S4ZxbBTg4UxlFPztmym/DefL5gtIEqskBxd
	OViMrUcnsZYPSKMAsB/DdKoerNfJOfo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kakx2yuV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767929496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fslRaYaMZ+zQFEefS0CSAq8597fBZiVS2hO3UcZSCmU=;
	b=kakx2yuVVCagl74PWygyX5vjCtZHu9PcYoN8FwFBz40+n0ThkLONs8qfJhTGayWebe7svB
	Aq4Fz7SYXpYdE1NOsKg0lL+k7u9SmzzWJp7S4ZxbBTg4UxlFPztmym/DefL5gtIEqskBxd
	OViMrUcnsZYPSKMAsB/DdKoerNfJOfo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B5143EA63
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 03:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S+BOL5d2YGk1MgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 03:31:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update the Kconfig string for CONFIG_BTRFS_EXPERIMENTAL
Date: Fri,  9 Jan 2026 14:01:14 +1030
Message-ID: <0dcb589d5f20e70bca6f95c7c6919efa0bedd663.1767929472.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C895333952
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

The following new features are missing:

- Async checksum

- Shutdown ioctl and auto-degradation

- Larger block size support
  Which is dependent on larger folios.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 127e12284b05..423122786a93 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -110,6 +110,10 @@ config BTRFS_EXPERIMENTAL
 
 	  - extent tree v2 - complex rework of extent tracking
 
-	  - large folio support
+	  - large folio and block size (> page size) support
+
+	  - shutdown ioctl and auto-degradation support
+
+	  - asynchronous checksum generation for data writes
 
 	  If unsure, say N.
-- 
2.52.0


