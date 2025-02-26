Return-Path: <linux-btrfs+bounces-11864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47E6A45ACA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5918166840
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096BC27128E;
	Wed, 26 Feb 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cSmbsDYX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cSmbsDYX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6225C6E9
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563538; cv=none; b=avlrNzcdZB6AchqH0YM4lObYMxs93dWuxrK+5wBNdARAZ0mOy6Sctni/937hbZOv8pB4ao/fCCNvohfietP1EfLzR6Aqi2GMdTes2yC3sZGxdIT61rdL1PFEc4B5Vae0N3/EMhxOLpeKQWFtYBmbl/eZCzQbt559R/fO54QpZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563538; c=relaxed/simple;
	bh=IsTxLZe7kgwvkoTKOuYEzsekEHT69DJgYk69HaGBvY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwy0vzRF5QvOnyaxYcBJpWJt7NoSSaWwKaWk0w6fZWj0mHF3YWeRLeIlJpeGRio57I4qfxrjNE0+zhawCiWk4q4xYWNdO2aZI3aR/diWdbDuW7hrsLpq1nBT1FZeADXBYQJ8JLJd28BAiXhvR5R129AxLcIukLYwZOEC9ZQ1hD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cSmbsDYX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cSmbsDYX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96E8C1F38D;
	Wed, 26 Feb 2025 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ruc9UWKcAf5otOkDKMH7TnxfOvZFQYGVPyllRuVdZ8=;
	b=cSmbsDYXDYAXzcFc1oT+ABbKz1TWbcOu3tzRklEc1IJqibaXDvRftbKcNb0EGq00nr43NN
	rW95+IQ/zRO9td5jECzPEDa92wldW5dXBBy0Zc5yytsh6hK7g09DqloEsv3YdaF+soe26Q
	jMDldGwPl+oI0ve3FRkvUmWyN9Rmh84=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cSmbsDYX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ruc9UWKcAf5otOkDKMH7TnxfOvZFQYGVPyllRuVdZ8=;
	b=cSmbsDYXDYAXzcFc1oT+ABbKz1TWbcOu3tzRklEc1IJqibaXDvRftbKcNb0EGq00nr43NN
	rW95+IQ/zRO9td5jECzPEDa92wldW5dXBBy0Zc5yytsh6hK7g09DqloEsv3YdaF+soe26Q
	jMDldGwPl+oI0ve3FRkvUmWyN9Rmh84=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F0BA13A53;
	Wed, 26 Feb 2025 09:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FPqIiLkvmdLYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:30 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 19/27] btrfs: use BTRFS_PATH_AUTO_FREE in check_ref_exists()
Date: Wed, 26 Feb 2025 10:51:30 +0100
Message-ID: <a2e4a2578333f7435019f47bf8fc2970b74b279b.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 96E8C1F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f4ddef135851..122d575c016b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5459,7 +5459,7 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_head *head;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_extent_inline_ref *iref;
 	int ret;
 	bool exists = false;
@@ -5476,7 +5476,6 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 		 * If we get 0 then we found our reference, return 1, else
 		 * return the error if it's not -ENOENT;
 		 */
-		btrfs_free_path(path);
 		return (ret < 0 ) ? ret : 1;
 	}
 
@@ -5511,7 +5510,6 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 	mutex_unlock(&head->mutex);
 out:
 	spin_unlock(&delayed_refs->lock);
-	btrfs_free_path(path);
 	return exists ? 1 : 0;
 }
 
-- 
2.47.1


