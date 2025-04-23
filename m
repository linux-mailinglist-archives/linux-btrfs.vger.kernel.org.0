Return-Path: <linux-btrfs+bounces-13334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3F0A99488
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB50B465EF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150492857E4;
	Wed, 23 Apr 2025 15:58:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6649284692
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423925; cv=none; b=Yz+QSY7zfko7qy0xpYC7hWOTR9f0MuL503GZWiizWXfUJOPk9T6fBG+WWPcg9Zz2fbxnvy3CyW8UJMyWxaPC98Abj40ysG0a9nPCmJNynNqzNB2ohEIp8sRPtHBw3ILNkvsp9IFJS7nRlxTJMh+NG27bBJbX2KuJZf8Tlo25Nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423925; c=relaxed/simple;
	bh=zkjwpdS5cMmnsZ3N5kzMqhQWuVqWZwEDc352B4MsQVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEI9xhvY49+4wuzIcVuJglONkpW/TXQDcdJRyghhnhVg8eZuzMNkrZRBro/3gGgm4nkJU16BuRJEi5IA77TJorR+L88D1fnsXAsErIBIk9XRf1S9CqB6WV+emMbIMQwB26IZR9RuinPAkCeS+nfaoJMLctQmLJlRW5bC4/amZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24E282118F;
	Wed, 23 Apr 2025 15:58:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13BB313691;
	Wed, 23 Apr 2025 15:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aznPBDIOCWjhCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:58:42 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 12/12] btrfs: raid56: rename parameter err to status in endio helpers
Date: Wed, 23 Apr 2025 17:57:24 +0200
Message-ID: <c7550c1b801f3470d488a540bd258c0509168c43.1745422901.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745422901.git.dsterba@suse.com>
References: <cover.1745422901.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 24E282118F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Trivial renames to unify the naming of blk_status_t variables/parameters.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/raid56.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 5906fd44c15def..fd96b5040584f3 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -892,14 +892,14 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 		remove_rbio_from_cache(rbio);
 }
 
-static void rbio_endio_bio_list(struct bio *cur, blk_status_t err)
+static void rbio_endio_bio_list(struct bio *cur, blk_status_t status)
 {
 	struct bio *next;
 
 	while (cur) {
 		next = cur->bi_next;
 		cur->bi_next = NULL;
-		cur->bi_status = err;
+		cur->bi_status = status;
 		bio_endio(cur);
 		cur = next;
 	}
@@ -909,7 +909,7 @@ static void rbio_endio_bio_list(struct bio *cur, blk_status_t err)
  * this frees the rbio and runs through all the bios in the
  * bio_list and calls end_io on them
  */
-static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
+static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t status)
 {
 	struct bio *cur = bio_list_get(&rbio->bio_list);
 	struct bio *extra;
@@ -938,9 +938,9 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 	extra = bio_list_get(&rbio->bio_list);
 	free_raid_bio(rbio);
 
-	rbio_endio_bio_list(cur, err);
+	rbio_endio_bio_list(cur, status);
 	if (extra)
-		rbio_endio_bio_list(extra, err);
+		rbio_endio_bio_list(extra, status);
 }
 
 /*
-- 
2.49.0


