Return-Path: <linux-btrfs+bounces-1757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E482283B3C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D04B2830E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A41350FB;
	Wed, 24 Jan 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sy0N7Xlh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sy0N7Xlh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6C1353F9
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131142; cv=none; b=hkpBA2JczNeqexYCsMpNdV0oif9CzyFunc/GTCGZqKvQa0p3rXfkQ5axgE0JElxaqCqpa0dRWgP5ehBoq91aMj3gr/oxrHrHa94pkDD3UwA6l8MmlxKJxSPIkYP9MqDISejqpsQpVkT1FVxRI7dY14v3HcvXTiCBHo+6QuOZAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131142; c=relaxed/simple;
	bh=DBo56Cp9sZWtS9i2SYGfsZlQ7dIMPtBnb95eMJfACeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSkIQvHy0NBGuOM9opGlOhUAQkR+vdrCuqcSMkWlNUR6N58YN2iFiqsUFAP4e529VhBhV/n0ggnMFyhsa31vNwd50LH04utLveAlrXPoJwXkHKWjYPups8PpMT3/jr8bKaVnDYxeyjh6cmowHMG4KqNAORZRpPi4FUeTVBRPuO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sy0N7Xlh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sy0N7Xlh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08EEB21F87;
	Wed, 24 Jan 2024 21:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZV/Tez7Zvb4PO5ZiacXlpryOPFPny2uUtUxYSE9+ENw=;
	b=sy0N7XlhO6VFiwFPONuNjgVYsbDrgUfWlihWe0MHGA808z61ZClhzh51uSFcXOLNGr6YNW
	SXTp8yGfPzVcctotrPkdYBGj8a7HJvMffQJLFl5xOtYak1nJjeAml6bvFsb6yiOs5KWh63
	PCPASPaw/dta0DQ3p4J+8kTwbWvFOIc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZV/Tez7Zvb4PO5ZiacXlpryOPFPny2uUtUxYSE9+ENw=;
	b=sy0N7XlhO6VFiwFPONuNjgVYsbDrgUfWlihWe0MHGA808z61ZClhzh51uSFcXOLNGr6YNW
	SXTp8yGfPzVcctotrPkdYBGj8a7HJvMffQJLFl5xOtYak1nJjeAml6bvFsb6yiOs5KWh63
	PCPASPaw/dta0DQ3p4J+8kTwbWvFOIc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0289113786;
	Wed, 24 Jan 2024 21:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ffWbAMN+sWXndwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 15/20] btrfs: change BUG_ON to assertion when verifying root in btrfs_alloc_reserved_file_extent()
Date: Wed, 24 Jan 2024 22:18:37 +0100
Message-ID: <d58d17b4a176adfb23191dc4da9d5f89e9833d9e.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

The file extents are normally reserved in subvolume roots but could be
also in the data reloc tree. Change the BUG_ON to assertions as this
verifies the usage assumptions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ba47f5996c84..2a04c2083759 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4964,7 +4964,7 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	u64 root_objectid = root->root_key.objectid;
 	u64 owning_root = root_objectid;
 
-	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
+	ASSERT(root_objectid != BTRFS_TREE_LOG_OBJECTID);
 
 	if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_src_root))
 		owning_root = root->relocation_src_root;
-- 
2.42.1


