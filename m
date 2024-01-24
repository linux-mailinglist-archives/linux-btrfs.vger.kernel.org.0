Return-Path: <linux-btrfs+bounces-1756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67A83B3BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818211F2683D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51664135410;
	Wed, 24 Jan 2024 21:19:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6BA13540E
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131139; cv=none; b=tdpw4Jz25S6+bz9MTSi4nvz9U36nLJwbOIOgkBjTGxLeRq9lUFH9FR+YgfFof2CXoDYbvvuc6Ga98s7zNqtzMeSgT0sm9wPzLGKLRTKIH6UC9rsn6qV+cnyLkIdgmAGM4OdckkQPJ2PGFsIjz485MBL7EOa/UBVqyRsrgH0c0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131139; c=relaxed/simple;
	bh=zUgOPdm9kaBs1Ne2TxQm4ltuC6dCFd+Qd8ft5xoTxgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otHv/HJC0Bc5w6kAqIP7q9T6B0RhkSEQLn6X6OqFeVvhDPHskk7JeX6cLdDXlVXqD1v0jdxRWOjdjoPDWvfeCkgUrkRNsBUxrwS1ZKERT3/aMvz5NiBapp9rvfspTRyepM2Aj6rtBD4+fUVadxb00Mn4SqB9ftLgJW80v+iI9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB3E81FD8C;
	Wed, 24 Jan 2024 21:18:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99CE513786;
	Wed, 24 Jan 2024 21:18:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kLaKJcB+sWXjdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:56 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 14/20] btrfs: change BUG_ON to assertion when verifying lockdep class setup
Date: Wed, 24 Jan 2024 22:18:35 +0100
Message-ID: <f1919241ecdaef121a0553c28b7754b79bdaa779.1706130791.git.dsterba@suse.com>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: AB3E81FD8C
X-Spam-Flag: NO

The BUG_ON in btrfs_set_buffer_lockdep_class() is a sanity check of the
level which is verified in callers, e.g. when initializing an extent
buffer or reading from an eb header. Change it to an assertion as this
would not happen unless things are really bad and would fail elsewhere
too.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/locking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 74d8e2003f58..c1dad121099e 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -85,7 +85,7 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb, int
 {
 	struct btrfs_lockdep_keyset *ks;
 
-	BUG_ON(level >= ARRAY_SIZE(ks->keys));
+	ASSERT(level < ARRAY_SIZE(ks->keys));
 
 	/* Find the matching keyset, id 0 is the default entry */
 	for (ks = btrfs_lockdep_keysets; ks->id; ks++)
-- 
2.42.1


