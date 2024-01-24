Return-Path: <linux-btrfs+bounces-1747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD783B3B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771DC1C22F6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F01353E9;
	Wed, 24 Jan 2024 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gJy0neSw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gJy0neSw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1D1350DE
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131114; cv=none; b=UlVJooQbd3yLJxLM4KSc0EVj4pnnlKikdLD8BrxyOeMOI8DzdGHtFQ/Jh9XNxE0wqjtn7JTCczNKtHoXv1mSndzZ5iKTDZNpsIKrzxMrxqm9v7uOo6/Kr03yeBYi6cU79wiFFq3DXL8YOMG2YJA+blqPrT6SGexrlcYstZfWgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131114; c=relaxed/simple;
	bh=gmL2ME5nNWR1xRCvwnTj33r549Kk52zaVFGA0CQGvOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDOOJgl76UqBXT0nt9aGHk/Yyt1XYEBbYbq3GGjJHcKnTVhNp5eTVXbgQxwdozTlYAX0AP2sGw7QOh4CnsHjkuSYLtBEHdRDk/RB8boz2/ic8CA0Fw3nBWVQvC+dbt7XhiAu0v+KQAlTwfiJ68b56ZJYtrzd36R42O4h+kgfymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gJy0neSw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gJy0neSw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C51321F87;
	Wed, 24 Jan 2024 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi7c4ietyVMjAbR6sFWto1fUtxFnWirtUlveHlFuSp4=;
	b=gJy0neSwpnhdb64jGj8tmjQU2E5Z2mayIAfR0hXTkZSb9UY5yL7ELG6nROwDg9o31AUo4s
	c1IKpgLrO1O3IbZqINvlNAUKmqi5AjaovlyuaGgVqS8CyHOM9VtJlE5KqijyDrB8XMniA9
	DXv1kLqmwSqWoekJE/MZLprl+3/Vf9w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi7c4ietyVMjAbR6sFWto1fUtxFnWirtUlveHlFuSp4=;
	b=gJy0neSwpnhdb64jGj8tmjQU2E5Z2mayIAfR0hXTkZSb9UY5yL7ELG6nROwDg9o31AUo4s
	c1IKpgLrO1O3IbZqINvlNAUKmqi5AjaovlyuaGgVqS8CyHOM9VtJlE5KqijyDrB8XMniA9
	DXv1kLqmwSqWoekJE/MZLprl+3/Vf9w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0585A13786;
	Wed, 24 Jan 2024 21:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SFFWAad+sWWydwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/20] btrfs: handle invalid root reference found in btrfs_find_root()
Date: Wed, 24 Jan 2024 22:18:09 +0100
Message-ID: <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

The btrfs_find_root() looks up a root by a key, allowing to do an
inexact search when key->offset is -1.  It's never expected to find such
item, as it would break allowed the range of a root id.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/root-tree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index ba7e2181ff4e..326cd0d03287 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -82,7 +82,14 @@ int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
 		if (ret > 0)
 			goto out;
 	} else {
-		BUG_ON(ret == 0);		/* Logical error */
+		/*
+		 * Key with offset -1 found, there would have to exist a root
+		 * with such id, but this is out of the valid range.
+		 */
+		if (ret == 0) {
+			ret = -EUCLEAN;
+			goto out;
+		}
 		if (path->slots[0] == 0)
 			goto out;
 		path->slots[0]--;
-- 
2.42.1


