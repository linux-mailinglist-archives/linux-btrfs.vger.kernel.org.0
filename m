Return-Path: <linux-btrfs+bounces-19171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF1C717E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 01:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C4ABA28ABB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2458E555;
	Thu, 20 Nov 2025 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ju2n74T6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ju2n74T6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F4AD4B
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597105; cv=none; b=g/C9yOaEekEQ/HdXbTCXyhbCvedsgScaMd9+PETNOeSu0uugT6mK4kVeEIGZRDEkO2tzLy2R2S6tdB75Mu1xC9zeJktYz1qHtuCZ9HQWR1l+4o6O38XblSFSiYzmBBNyrFR1ZiLM/rnfF9m9ZqW4ascSLkFQsLQjBf8mzNNLHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597105; c=relaxed/simple;
	bh=2mE1NlyXAdmYT4DTtnTYKy5wPkAFqkA+YdIWwZagFqQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXfGU8H8d9STAfF+IO20uTxwi75KKonvHzmFFjlBbDxDcubxxcf9msWaWuPREKSyU1oEXVPRb6EF2TOcUdaAQ10eOk8+O8Va7jNGLwpEjr3ZNFodC9OxXEE/QeNdN7sGYiLGKeU84UWM6hzZbxypZoDCWxDZrIAW5w/Wlw61yUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ju2n74T6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ju2n74T6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DBD92198E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763597094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBL3mlKWgy7EgJ0Ui4ym4zBk12DwCT0xHFVQrneYSWY=;
	b=Ju2n74T6F8+xgAMb52hNKUBn3Ag8Jrhge2TfAJYbqms7p5fwaZn+8XLP0MKp7UCD6Cia+p
	0glk4tZ7YChemoSbh0Eo8SUu7hhJ8Cd57EXvX4HwoVMrpucSCTzJhQQVqmtVVFLkZ58JJY
	wkZUDij1F1hjvc+9cPoXV+uSEyHKMXw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763597094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBL3mlKWgy7EgJ0Ui4ym4zBk12DwCT0xHFVQrneYSWY=;
	b=Ju2n74T6F8+xgAMb52hNKUBn3Ag8Jrhge2TfAJYbqms7p5fwaZn+8XLP0MKp7UCD6Cia+p
	0glk4tZ7YChemoSbh0Eo8SUu7hhJ8Cd57EXvX4HwoVMrpucSCTzJhQQVqmtVVFLkZ58JJY
	wkZUDij1F1hjvc+9cPoXV+uSEyHKMXw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79DF43EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6MxADyVbHmkwFgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: use bitmap_set() to replace set_bit() in a loop
Date: Thu, 20 Nov 2025 10:34:31 +1030
Message-ID: <3b1e2dbf5398b9ba7b55c09e891b2a78dd119b15.1763596717.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763596717.git.wqu@suse.com>
References: <cover.1763596717.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.24 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.84)[0.945];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.24
X-Spam-Level: 

Inside extent_writepage_io(), we use the specified range to calculate
@range_bitmap, which is later to determine which blocks are going to be
submitted.

However we're calling set_bit() in a loop like the following:

	for (cur = start; cur < end; cur += fs_info->sectorsize)
		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);

Which is not optimal, as we know all bits for the range [start, start +
len) can be set to 1 in one go.

Replace the set_bit() in a loop with a proper bitmap_set() call.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1dfc0902bfc..4fc3b3d776ee 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1728,8 +1728,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		return ret;
 	}
 
-	for (cur = start; cur < end; cur += fs_info->sectorsize)
-		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
+	bitmap_set(&range_bitmap, (start - folio_pos(folio)) >> fs_info->sectorsize_bits,
+		   len >> fs_info->sectorsize_bits);
 	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
 		   blocks_per_folio);
 
-- 
2.52.0


