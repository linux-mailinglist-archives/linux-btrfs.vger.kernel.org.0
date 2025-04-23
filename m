Return-Path: <linux-btrfs+bounces-13332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC233A994A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB58B16AF7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40122853FC;
	Wed, 23 Apr 2025 15:58:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216E1FECBD
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423917; cv=none; b=OLH7GWvhFijap019ppwK/piqUE3r4l9PrbFwSCCrT4gj1pW16A8Nt55L67QVN7XDexDDIsbLGKmRkEgWA1IKx8/C87JIi9K1bBXhYtS2xSyWARiJxnhkk6lLVqcZAdN0DOOhiaE42G16jDGs/b6N4961e/onuj4Iiynjs/E0x/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423917; c=relaxed/simple;
	bh=SDHnfqcBw0jWx0kkWa7Dr/NdzyYH8RIsVV6Mg9hbJhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQhI5fGyznRQV4Pu5jYoba+yX0CxbpCuWnyP6pWGnpKO7qL/lgVVVhkiO6XBiZLUyxhSnAmDSJsK9i/uxLTlkM5bhCTQPhAXX+F0ABSUaw5vz1J0kW6vhpZ1J6NrrfbUjepHYQW1I6I48uiTYHRiar1Y0Dq+wPbdI657ShTCpbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1B7E2118F;
	Wed, 23 Apr 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A89E13691;
	Wed, 23 Apr 2025 15:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hau3JSkOCWjGCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:58:33 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/12] btrfs: rename ret2 to ret in btrfs_submit_compressed_read()
Date: Wed, 23 Apr 2025 17:57:22 +0200
Message-ID: <c02252c5555581b5aeb04b0a8f739ab5f80cb31d.1745422901.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: A1B7E2118F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

We can now rename 'ret2' to 'ret' and use it for generic errors.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a2cf97ca975f81..7c5ed1466caf83 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -577,7 +577,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	unsigned long pflags;
 	int memstall = 0;
 	blk_status_t status;
-	int ret2;
+	int ret;
 
 	/* we need the actual starting offset of this extent in the file */
 	read_lock(&em_tree->lock);
@@ -612,8 +612,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 		goto out_free_bio;
 	}
 
-	ret2 = btrfs_alloc_folio_array(cb->nr_folios, cb->compressed_folios);
-	if (ret2) {
+	ret = btrfs_alloc_folio_array(cb->nr_folios, cb->compressed_folios);
+	if (ret) {
 		status = BLK_STS_RESOURCE;
 		goto out_free_compressed_pages;
 	}
-- 
2.49.0


