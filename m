Return-Path: <linux-btrfs+bounces-14329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32784AC935B
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D447C1C06554
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B31BCA0E;
	Fri, 30 May 2025 16:18:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89E1A262A
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621902; cv=none; b=SvuicGKlEWx7AZEFOVXlrmd5BsL2N+PptYYNg+BQ6T4KNMU5Gz5nloSFfnXkobdFKP8Pk27PG6Tjp1S4GIAIX3xrvI+AXL/OY24DnUCFvVKHW+2dvZGZ8/+tHzKlVVgiQHtcj/buQEHMrEl7sooiuHwJSSl7mmXHy25U/CwtZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621902; c=relaxed/simple;
	bh=Ovx6T5s8ZC1P2ewDLBMqTtKnm0HvNLhQtcSSPgM+61I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1OTUoXTOwsxwUYe90/+xkCmGVle+hM6atjxsXsPzvAp5nNyZWGUHS0GtoPLEQu5MGrcQ8nD9IprqXejUEiJaW9YJ8c9YNgrvghx4dz5SiCpHliPD7jAbJx+xGFuKim/9qdiPLJVMAiF05FmeWzQZD9kA1YKADtc8rvkaDCmm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 892E721D9F;
	Fri, 30 May 2025 16:18:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8277713889;
	Fri, 30 May 2025 16:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RY3ZH0jaOWi9ZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:18:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/22] btrfs: rename err to ret in btrfs_alloc_from_bitmap()
Date: Fri, 30 May 2025 18:18:01 +0200
Message-ID: <19e400fe0a017da0f69d9e094b388869987098ee.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 892E721D9F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 4b34ea1f01c2..efd21a28570c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3192,7 +3192,7 @@ static u64 btrfs_alloc_from_bitmap(struct btrfs_block_group *block_group,
 				   u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
-	int err;
+	int ret2;
 	u64 search_start = cluster->window_start;
 	u64 search_bytes = bytes;
 	u64 ret = 0;
@@ -3200,8 +3200,8 @@ static u64 btrfs_alloc_from_bitmap(struct btrfs_block_group *block_group,
 	search_start = min_start;
 	search_bytes = bytes;
 
-	err = search_bitmap(ctl, entry, &search_start, &search_bytes, true);
-	if (err) {
+	ret2 = search_bitmap(ctl, entry, &search_start, &search_bytes, true);
+	if (ret2) {
 		*max_extent_size = max(get_max_extent_size(entry),
 				       *max_extent_size);
 		return 0;
-- 
2.47.1


