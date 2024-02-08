Return-Path: <linux-btrfs+bounces-2227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2184DC31
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9521F2119A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA446BB2C;
	Thu,  8 Feb 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N0exfZB2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N0exfZB2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BF6BB27
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382811; cv=none; b=kPNweiaS1jaadvwwM940gw+xFzKRlvQF9YUZPz4q6mRJhBUF35XFHIO0CE/H6vBhiJUU/M4lzgk/cBLCY9Y8Sjr1QAlM9wTFV1ECNXyF4bDx2gTkHUeKLBRIbQMBCiNFe7hr5KE0tyjcxbx7OR99fmDagAZH2amAKdIXfAjLIag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382811; c=relaxed/simple;
	bh=/8a3K7ZvnboP1/cxfZanwULsuOfhMySOiV+rMn0Vp/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsXAL6pxkiMjkzKgQtdaH4E4hYrgvY9YpuSMHt7cB6UUlNWQMjvItMjaJiXGgntbamfJh61YylA7sqmahQAoiUtzQekHLh1ezViZb4qSU3pZJrXdfLHLrfu5Rs8Mg4xznGmuimjQrcbko/Bottk1coq5fazUbEs32IGkQg9gaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N0exfZB2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N0exfZB2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02E8221E6F;
	Thu,  8 Feb 2024 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFusZnWuO50spH/oKtAyoeyHJHEufW1YH11UEl9ALYE=;
	b=N0exfZB2gahlpU3XedqWs/tOR+YsYxBsaW2VoamUdwoZ5cDcY3fmegG5pM39AW7HBmC+KF
	97M10PQ4CjBjVBipyhoKgspLtG79fhX2Te0Xp/1g2fGgZzCaB3wo4zIjnYT4EBgXwV8Va3
	idwOjY6lYg9kvy7ssK7qLs7p9Ids4rM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFusZnWuO50spH/oKtAyoeyHJHEufW1YH11UEl9ALYE=;
	b=N0exfZB2gahlpU3XedqWs/tOR+YsYxBsaW2VoamUdwoZ5cDcY3fmegG5pM39AW7HBmC+KF
	97M10PQ4CjBjVBipyhoKgspLtG79fhX2Te0Xp/1g2fGgZzCaB3wo4zIjnYT4EBgXwV8Va3
	idwOjY6lYg9kvy7ssK7qLs7p9Ids4rM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFCEC13984;
	Thu,  8 Feb 2024 09:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jJeKOheYxGV0DgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:07 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/14] btrfs: handle invalid extent item reference found in extent_from_logical()
Date: Thu,  8 Feb 2024 09:59:38 +0100
Message-ID: <6cf0eee9ded5ba3c67265e6b497bf297092bcc0b.1707382595.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
References: <cover.1707382595.git.dsterba@suse.com>
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

The extent_from_logical() helper looks up an extent item by a key,
allowing to do an inexact search when key->offset is -1.  It's never
expected to find such item, as it would break the allowed range of a
extent item offset.

The same error is already handled in btrfs_backref_iter_start() so add a
comment for consistency.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 0fa27ed802f6..6ba743ddfe21 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2227,6 +2227,13 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
+	if (ret == 0) {
+		/*
+		 * Key with offset -1 found, there would have to exist an extent
+		 * item with such offset, but this is out of the valid range.
+		 */
+		return -EUCLEAN;
+	}
 
 	ret = btrfs_previous_extent_item(extent_root, path, 0);
 	if (ret) {
@@ -2870,6 +2877,10 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 	if (ret < 0)
 		return ret;
 	if (ret == 0) {
+		/*
+		 * Key with offset -1 found, there would have to exist an extent
+		 * item with such offset, but this is out of the valid range.
+		 */
 		ret = -EUCLEAN;
 		goto release;
 	}
-- 
2.42.1


