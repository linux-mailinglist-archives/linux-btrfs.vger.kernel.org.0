Return-Path: <linux-btrfs+bounces-1748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2856183B3B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2191C2300E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2681C13340C;
	Wed, 24 Jan 2024 21:18:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C131350F7
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131116; cv=none; b=fv1xFPikL6Bo66QmOnjUgIKto/nIsE3Ye9RF4VSLLf+1e2gE3UaJo3ROSahonlMVVDKXj7l62k4lZ9UBKwSf84Emv2O36kxs89/SHBuLPM6rZk82Sq8qoXfD69790oFC6JqXVqesz5jiKT6YHWE9gsRnRAq+CvwxtCGOFJ8vBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131116; c=relaxed/simple;
	bh=lVGp1crVIc/yp52TckTQ+5X8LhftULKkMhlSo1z44qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkW1+hzw1FHIDPJTBNeca93DwFwZzww2z79GjcxDdrKKuO3Iyem3zI3j26aKqYjCTUOpmkogfQ2JjaFg3HyEAn41eH0wVHDehdYWcSwGIEbv4lidC5+8v/9q5zgdfr8EbARiS7IFott1jWEod5i5IuwTFJ/YW/nPiDfPylA3aYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 70AEE21F9B;
	Wed, 24 Jan 2024 21:18:33 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DD9F13786;
	Wed, 24 Jan 2024 21:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G6DvFql+sWW5dwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:33 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/20] btrfs: handle invalid root reference found in btrfs_init_root_free_objectid()
Date: Wed, 24 Jan 2024 22:18:12 +0100
Message-ID: <aeb9fec3b34c662de4a9771f44e7d0b839de13f6.1706130791.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 70AEE21F9B
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The btrfs_init_root_free_objectid() looks up a root by a key, allowing
to do an inexact search when key->offset is -1.  It's never expected to
find such item, as it would break the allowed range of a root id.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 274a3e1faeab..3f7291a48a4d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4928,7 +4928,14 @@ int btrfs_init_root_free_objectid(struct btrfs_root *root)
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	if (ret < 0)
 		goto error;
-	BUG_ON(ret == 0); /* Corruption */
+	if (ret == 0) {
+		/*
+		 * Key with offset -1 found, there would have to exist a root
+		 * with such id, but this is out of valid range.
+		 */
+		ret = -EUCLEAN;
+		goto error;
+	}
 	if (path->slots[0] > 0) {
 		slot = path->slots[0] - 1;
 		l = path->nodes[0];
-- 
2.42.1


