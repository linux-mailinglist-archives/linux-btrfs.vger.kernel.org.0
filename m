Return-Path: <linux-btrfs+bounces-1749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248FA83B3B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F671C235A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B191353F5;
	Wed, 24 Jan 2024 21:18:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2421353F0
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131118; cv=none; b=PeL4IXmyOz3vjsdOSh5iC2662WMmi7DzBYE4D0aXqrUtKuZ/cGMPIJSwDCV8R+pJsudEevUseBBOFLEjRL/98fCJ8/CmwmnK46X/PfyeHP3W2fWzQ0CH6npYQ+kyU8yM/GLn3qXlgmbhYC8UNcJgzYTnT5Ax51+sjuW61R364qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131118; c=relaxed/simple;
	bh=N7100yr/tlCLsWlB0lry2sEkim5HCbKbRsHP+WlLyxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eodDkTfnz9WYAbBmgZQNzSiQENZzgrMa9pLQk+QPYpgg6QI1QVI/9FiEsRvvgBAY6rHdIuOR7ppe57gyWo4hv03D4KMmv5ZEI1qHm0PvJTB19vO+BVbUqlGv2BcevAjPJ57atzgNRX4avzZqhYEshRESdRk3xGrvE16TxAVyqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF93721FC7;
	Wed, 24 Jan 2024 21:18:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C909813786;
	Wed, 24 Jan 2024 21:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HPMSMat+sWW/dwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/20] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Wed, 24 Jan 2024 22:18:14 +0100
Message-ID: <ae9556ccc1c06b17ea40f2e05b60cc4d8dcac0a7.1706130791.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: CF93721FC7
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The unhandled case in btrfs_relocate_sys_chunks() loop is a corruption,
as it could be caused only by two impossible conditions:

- at first the search key is set up to look for a chunk tree item, with
  offset -1, this is an inexact search and the key->offset will contain
  the correct offset upon a successful search, a valid chunk tree item
  cannot have an offset -1

- after first successful search, the found_key corresponds to a chunk
  item, the offset is decremented by 1 before the next loop, it's
  impossible to find a chunk item there due to alignment and size
  constraints

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d67785be2c77..6aae92e4b424 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3393,7 +3393,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
-		BUG_ON(ret == 0); /* Corruption */
+		if (ret == 0) {
+			/*
+			 * On the first search we would find chunk tree with
+			 * offset -1, which is not possible. On subsequent
+			 * loops this would find an existing item on an invalid
+			 * offset (one less than the previous one, wrong
+			 * alignment and size).
+			 */
+			ret = -EUCLEAN;
+			goto error;
+		}
 
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
 					  key.type);
-- 
2.42.1


