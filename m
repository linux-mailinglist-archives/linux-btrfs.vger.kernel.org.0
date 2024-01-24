Return-Path: <linux-btrfs+bounces-1750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8670A83B3B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2451F25F3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F161353F8;
	Wed, 24 Jan 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fk5K0ZFm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fk5K0ZFm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C24132C36
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131121; cv=none; b=KehU4VcUYVo43JxSgBcllVVNK5NFdjgoARMyl5iK1dPo43UQ0JTWRXvsld6oJ4erX6hDGXAKtZI1XtmhzK4PAXWLqFP1S/m6loiWjiQ8XPanDXNrWDkM9HEyocyk6YxrJrmZlFJBhatuwpTKdHSOOzlafhWzt/a9l0TDXncd+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131121; c=relaxed/simple;
	bh=LMBbXnLnc5pPrVYC858NA5l95/5X7/uphMKcnMVsVio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX+xq21Zk/y2YzG3ibdAu7kqh0T49pVdpG5aiet3iQTGopaRX4vfX5q+d49nZCsg8zZqiSH3y6TAZqz04mt5QAT3GzOza1OttmSI7GFbm5CwBWLcxWms9DicyVrnbhuIwkyoEblmiZx7pQBxWuF2PMU/tx9DAN7xdXtx4e5RsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fk5K0ZFm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fk5K0ZFm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B96C21F87;
	Wed, 24 Jan 2024 21:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcvrW3u2sfy/VCPdEmk98+B3rvDlKBeSKEtd/YGYpPg=;
	b=fk5K0ZFmqO5SjcLeYchYUtXtN3+3AuX2B9PukPeiq4WDVBbVDdpNrPaESmVxoC3r87TEZ8
	NgYYSI4EZLNhlbI2HmRQl0uxee7zIcW3sQPjrwAfjH4zz20vnkqMaadsAyNknx+BE7rq3L
	3i44g6a4CaOHfICcWZ+IeLKrr/UtqNg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcvrW3u2sfy/VCPdEmk98+B3rvDlKBeSKEtd/YGYpPg=;
	b=fk5K0ZFmqO5SjcLeYchYUtXtN3+3AuX2B9PukPeiq4WDVBbVDdpNrPaESmVxoC3r87TEZ8
	NgYYSI4EZLNhlbI2HmRQl0uxee7zIcW3sQPjrwAfjH4zz20vnkqMaadsAyNknx+BE7rq3L
	3i44g6a4CaOHfICcWZ+IeLKrr/UtqNg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4359413786;
	Wed, 24 Jan 2024 21:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sjpwEK5+sWXDdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:38 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/20] btrfs: handle invalid extent item reference found in check_committed_ref()
Date: Wed, 24 Jan 2024 22:18:16 +0100
Message-ID: <139f98f6906bcd774f867e1ef4020fa948ebef93.1706130791.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

The check_committed_ref() helper looks up an extent item by a key,
allowing to do an inexact search when key->offset is -1.  It's never
expected to find such item, as it would break the allowed range of a
extent item offset.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4283e3025ab0..ba47f5996c84 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2399,7 +2399,14 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
-	BUG_ON(ret == 0); /* Corruption */
+	if (ret == 0) {
+		/*
+		 * Key with offset -1 found, there would have to exist an extent
+		 * item with such offset, but this is out of the valid range.
+		 */
+		ret = -EUCLEAN;
+		goto out;
+	}
 
 	ret = -ENOENT;
 	if (path->slots[0] == 0)
-- 
2.42.1


