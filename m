Return-Path: <linux-btrfs+bounces-5984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9C9175E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 03:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3458B1F21B54
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 01:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD4438396;
	Wed, 26 Jun 2024 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="be/GiQEb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="be/GiQEb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52256219EB
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366484; cv=none; b=jzNpQXQqFhvzSMufiUeH0E2toU5dXEJcgYZML1GfTazjd4ISBAyV6vPtqvkg7MOYtg6WODI+ulN7MXt6I0O7vecDAtcKTVyi/bKjUwF6eobcGE/FdDI45vBcwd7qjPfR8JHtRhFwuhv52wQfNWk/B6w2nRIQTO1yZu37sC6ZGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366484; c=relaxed/simple;
	bh=HfTMifXRMfjWjDH2tvvXFeP0YeSK86QJc4qJcR5sWjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvOuErqtKDitvXtGz75cFnh8TxgduQ9X2e7q8Y0FdxbX69ouv+w9g1EDxNzTmDhBm7bKk2Jm94MpekrV1CNlOzbnljjAQTZEztZLel635s0IP4yegPSfLIhetpkAmJJ2b2NyqFtz9k8idLAqAWjJRWyhb6l4uXtzN3xKWTQBEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=be/GiQEb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=be/GiQEb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B9D81F8C2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytYFjTnQDwHraxuB4xALoTniLbxLYCcZeOvD12vxdCA=;
	b=be/GiQEbBwxhkqyvdzlmD6MweAn/BT0E29nJQ1ArsbP9qPE4+Oz+Mr5ba7W/3T5CZvFJ7a
	+IqtwzBjtKjEHKce9+0W+QU0+pQB5rz8PVyx9Hrz/l1UN4rV2jmUvpn82kHYs8Afd9DA0Y
	o6sQbrk6OB92mI/mOBzJ3PidvG24xl0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytYFjTnQDwHraxuB4xALoTniLbxLYCcZeOvD12vxdCA=;
	b=be/GiQEbBwxhkqyvdzlmD6MweAn/BT0E29nJQ1ArsbP9qPE4+Oz+Mr5ba7W/3T5CZvFJ7a
	+IqtwzBjtKjEHKce9+0W+QU0+pQB5rz8PVyx9Hrz/l1UN4rV2jmUvpn82kHYs8Afd9DA0Y
	o6sQbrk6OB92mI/mOBzJ3PidvG24xl0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83532139C2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MB2LDk9ze2ZtbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs: tree-checker: add extra ram_bytes and disk_num_bytes check
Date: Wed, 26 Jun 2024 11:17:33 +0930
Message-ID: <b740c909d82fecff295ad38f175f371b2e020fb9.1719366258.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719366258.git.wqu@suse.com>
References: <cover.1719366258.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

This is to ensure non-compressed file extents (both regular and
prealloc) should have matching ram_bytes and disk_num_bytes.

This is only for CONFIG_BTRFS_DEBUG and CONFIG_BTRFS_ASSERT case,
furthermore this will not return error, but just a kernel warning to
inform developers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a2c3651a3d8f..32ca692d9e20 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -340,6 +340,24 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		}
 	}
 
+	/*
+	 * For non-compressed data extents, ram_bytes should match its
+	 * disk_num_bytes.
+	 * However we do not really utilize ram_bytes in this case, so this check
+	 * is only optional for DEBUG builds for developers to catch the
+	 * unexpected behaviors.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG) &&
+	    btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE &&
+	    btrfs_file_extent_disk_bytenr(leaf, fi)) {
+		if (WARN_ON(btrfs_file_extent_ram_bytes(leaf, fi) !=
+			    btrfs_file_extent_disk_num_bytes(leaf, fi)))
+			file_extent_err(leaf, slot,
+"mismatch ram_bytes (%llu) and disk_num_bytes (%llu) for non-compressed extent",
+					btrfs_file_extent_ram_bytes(leaf, fi),
+					btrfs_file_extent_disk_num_bytes(leaf, fi));
+	}
+
 	return 0;
 }
 
-- 
2.45.2


