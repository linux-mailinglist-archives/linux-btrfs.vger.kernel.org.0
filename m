Return-Path: <linux-btrfs+bounces-2226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5D484DC2F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3B02881A4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7846BB31;
	Thu,  8 Feb 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AxtCsVJF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AxtCsVJF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD186A8C0
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382809; cv=none; b=Q5xcf3eIDv+rL6W3qQSFHo3b82mGvYDm0rCpdaR22Xvuje6L2r031Gz0eNixwY7aWXWsgRTZR2wjlvgHZAbok/72OEkcgZhQRm+HDtRz3zeJYqO7dVaD+0lIxoeksHXdW/T6eJRzZQ/zICSAJMw1IytfCymtA9E+Q60fCtrHPaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382809; c=relaxed/simple;
	bh=koup2D07MAt5RqoPap6r7IN9VMaIWPK2R2uFjiDRSXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOJx0n1UAYL8WPeU9tmFkNmp/JCc2ITfzL0gDpQUZUyE5FOpy4xXZHNxOfeQkUUgp3hvn9Y2P3cy5wryZ39iueHI4FAmkOKcxi/YHyhJEHjyBIu4ocWDHnmE7+ldOioUCE6AvS9up2zSwvoT221B96GUp4/vaR0JjjEBbgX7jBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AxtCsVJF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AxtCsVJF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3D641FD56;
	Thu,  8 Feb 2024 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmKfYjV5uvFZd9t0pe9vnHNet20o12JHwXs3puMGv74=;
	b=AxtCsVJFfXtZ827Qawz2LwpZRzbl9zI8e3bOkUPj2C+cHvR+LhtDtvB0h3gQp/rOkOEKrB
	K8vZugMHPpZmurShJ9mNR0uranQmpj55y4auk3aOOY5jNfDybthLRHeoy7C/OhCmKJkt8p
	Ii/vit3VKlvzlkwI9dA8HZ2+rN0pc54=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmKfYjV5uvFZd9t0pe9vnHNet20o12JHwXs3puMGv74=;
	b=AxtCsVJFfXtZ827Qawz2LwpZRzbl9zI8e3bOkUPj2C+cHvR+LhtDtvB0h3gQp/rOkOEKrB
	K8vZugMHPpZmurShJ9mNR0uranQmpj55y4auk3aOOY5jNfDybthLRHeoy7C/OhCmKJkt8p
	Ii/vit3VKlvzlkwI9dA8HZ2+rN0pc54=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 930E713984;
	Thu,  8 Feb 2024 09:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h8blIxWYxGVxDgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/14] btrfs: update comment and drop assertion in extent item lookup in find_parent_nodes()
Date: Thu,  8 Feb 2024 09:59:36 +0100
Message-ID: <58769dbf1265749659b64af427acc19487c3ae60.1707382595.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
References: <cover.1707382595.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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

Same comment was added to this type of error, unify that and drop the
assertion as we'd find out quickly that something is wrong after
returning -EUCLEAN.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index beed7e459dab..0fa27ed802f6 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1435,8 +1435,10 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 	if (ret < 0)
 		goto out;
 	if (ret == 0) {
-		/* This shouldn't happen, indicates a bug or fs corruption. */
-		ASSERT(ret != 0);
+		/*
+		 * Key with offset -1 found, there would have to exist an extent
+		 * item with such offset, but this is out of the valid range.
+		 */
 		ret = -EUCLEAN;
 		goto out;
 	}
-- 
2.42.1


