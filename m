Return-Path: <linux-btrfs+bounces-18093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410D9BF4EC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 09:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB6D18A3ECB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 07:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472A27B335;
	Tue, 21 Oct 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jytr1mYi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wy35Km9b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53102620C3
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031311; cv=none; b=ErGfkBhF2MZuWsxd3TDVJfAb0jE+ICm6RuknYdUPpSNB45OpibwlmQmcYiWTGM/tn/CMoQGLIs0pPyfqYXz84P/avdCqQqHjfLUugonDWIDe9MM0Ec4LwAwC1cup3HWlNiBxM1RsnGEKP3FRtRM8hhVrsljOo6p5Vlp8nlMvGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031311; c=relaxed/simple;
	bh=Pd3N2PveaVXZP1B0d6pIT0nQ7r1mNogpeg11+wXcPKo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdCB8r6L/Znii5ViKECHM1fFZdXWwYOfcjuoSv5l3AftGkj6GTbDAOh4FDVKjDorlfDZaR1Yz5n3rFymSEgP5k2J+tQiemoEjsaopaTkkAFudfTx+DbNGgwW86Jc6x7Qat63vzFWB9fbltx2gifj/uk79JOBKQ/r3GXFxS7xokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jytr1mYi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wy35Km9b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79A25211F8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761031303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+X6Y+FDZhrNTst5VcWdHZhcaV4D/MLJeQ3OIqRoXKs=;
	b=jytr1mYinIvniGbYRdjiEH5LzWA/PaJ+eyU/Mn5sVzL1krklfAL3SITtk9oJLA9+jGacr+
	CnGWTP14yGFG9BIoA7X6UPRydaMbcfPq5L4K4JDYK6/mi6ZbRg2c4GtgEqx3aYb5glLmfH
	7Zo2UrN8Q5twZPrNucrJy3GyF9xNuNQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Wy35Km9b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761031299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+X6Y+FDZhrNTst5VcWdHZhcaV4D/MLJeQ3OIqRoXKs=;
	b=Wy35Km9bVVaiIcsKB6zlYXYudB+1WUWo1u0LasxmxdEwd7TnZsRFlOS610oD1s+h9JeocU
	h44ebccWcMB6WISFcaUZNev8mBTxW/AMZ/mPC7sI0U4llo+gbQEpjClIgisTfjYgEnh5Ws
	Xr1+0Z1hMFxakiz6FChwvojEn3kWmhk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1AA8139D8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +PArHYI092hpSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: force stable writes for all inodes
Date: Tue, 21 Oct 2025 17:51:14 +1030
Message-ID: <b3eed2f27d71df53951ecac436b94e98e1dcd82d.1761030762.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761030762.git.wqu@suse.com>
References: <cover.1761030762.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 79A25211F8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Previously we only set stable writes for inodes with data checksum, but
this can still cause problems for RAID1* and RAID56 profiles.

As both raid profiles are doing zero-copy writes, if buffered write is
allowed for folios that are still under writeback, it can lead to
content mismatch on different mirrors.

So to plug the hole for different raid profiles, always set STABLE_WRITE
flags for all btrfs inodes, so that we will only allow buffered write
when the writeback of a folio is finished.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index af373d50a901..a37127460e3d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -524,10 +524,7 @@ static inline void btrfs_assert_inode_locked(struct btrfs_inode *inode)
 
 static inline void btrfs_update_inode_mapping_flags(struct btrfs_inode *inode)
 {
-	if (inode->flags & BTRFS_INODE_NODATASUM)
-		mapping_clear_stable_writes(inode->vfs_inode.i_mapping);
-	else
-		mapping_set_stable_writes(inode->vfs_inode.i_mapping);
+	mapping_set_stable_writes(inode->vfs_inode.i_mapping);
 }
 
 static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
-- 
2.51.0


