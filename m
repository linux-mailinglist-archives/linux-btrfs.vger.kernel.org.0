Return-Path: <linux-btrfs+bounces-1754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C31583B3BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7B01F2650D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F09E135407;
	Wed, 24 Jan 2024 21:18:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403521353FF
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131134; cv=none; b=NGdy2u7sFI2NBO6FfCYhg4L1qwEbnDLdxSlwSplrLIjx4c8UWMSg3MKkICQbwu5swnfp0Su6iRJtlSJnt6QbCdCtKYZsVuzUqAM3+I7mC1VTf3iLfpsTcjfBcufYwN3VCwWirJv8fn5OjUIn1mcp0wVTK92xVU+8OIRCJcSxqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131134; c=relaxed/simple;
	bh=QIRm78MNuRZfYRuiiMjJCCTVPYo0x1kIJ2QcYAxvKVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwZ3uWJVirPfVDQ6zkXtKLOSPoTPOgW0HYz7XN7tOYgrN4JqH798EE9hJ7DFVv39qLkRoD8Ppxg/Pua9EMVgd1/PAC5PgHb0BRCRYSd2AZEAkGEf/p8o8XXfcWxquORCd/l3rj9MGC9WfZXOQ4sVxt1ig0tz2hBAVC1NDawo2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E23CA1FD8C;
	Wed, 24 Jan 2024 21:18:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC3F813786;
	Wed, 24 Jan 2024 21:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LYjDNbt+sWXZdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:51 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 12/20] btrfs: defrag: change BUG_ON to assertion in btrfs_defrag_leaves()
Date: Wed, 24 Jan 2024 22:18:30 +0100
Message-ID: <9a4896d0d0486ebd0859498e030ac8c26bb78066.1706130791.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: E23CA1FD8C
X-Spam-Flag: NO

The BUG_ON verifies a condition that should be guaranteed by the correct
use of the path search (with keep_locks and lowest_level set), an
assertion is the suitable check.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index dd1b5a060366..77695811f596 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -521,7 +521,7 @@ static int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 	 * keep_locks set and lowest_level is 1, regardless of the value of
 	 * path->slots[1].
 	 */
-	BUG_ON(path->locks[1] == 0);
+	ASSERT(path->locks[1] != 0);
 	ret = btrfs_realloc_node(trans, root,
 				 path->nodes[1], 0,
 				 &last_ret,
-- 
2.42.1


