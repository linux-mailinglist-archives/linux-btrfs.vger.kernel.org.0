Return-Path: <linux-btrfs+bounces-14323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F5AC9350
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C11A22641
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816EC1A262A;
	Fri, 30 May 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cf5Pej8V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cf5Pej8V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195CD1494A8
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621858; cv=none; b=o4X0xsKEgpq44Szjt0/+r7JiN5WQyQT5M7qQbaqOvOSYx4QgPn8a6H7pVGPMX5GUosKzI7kC6JH8h8uirvfvkI3ixNt1jXTkcTEgzi+3qtLar0hUVtDF/GGZtVR7TDaKDe8ZpYDzI4Yqghwt3LkVZ/CudNWgmLEz+bdKeSgh/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621858; c=relaxed/simple;
	bh=Ft3XjsPwdbOmDfZZNYgAxOCZWd60Ckq0JjxgegIYlic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMwck2hn50kjO6lwCGAhAEbSCl7AqK7f/4rDL4Ls1eWPEbGX71mTBnJGoGoTI2f15lB9QZ/IJa142swDgfQl8zO+dErcnh3b8tuFXO9r8Ep15Es4ct0mh6SFHv/pFqKTewyVQq/YkXARUYgdt1yzAx83LlLwLU2GRTd5uzJAGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cf5Pej8V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cf5Pej8V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 452991F7F2;
	Fri, 30 May 2025 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg5JOgEOi+tp8Is2LmuJg+AzgjIbw9KzOlNhR0lUngE=;
	b=cf5Pej8VZYTQMi2TpWwD4tq80viRc/vIbLpXJX6y+d3IH2qsDEWtFFYzKiprQUyXXGjtpr
	Vtm7VoEsNEraMeJnPvot9EKoGxZ8YvJAvKhyh7Gs2wHHdl9SzHvwaKSGyJoHlgp+fHNjSg
	HeV3jx1D3IrRn6Q7C2absQV6z4b6HwY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg5JOgEOi+tp8Is2LmuJg+AzgjIbw9KzOlNhR0lUngE=;
	b=cf5Pej8VZYTQMi2TpWwD4tq80viRc/vIbLpXJX6y+d3IH2qsDEWtFFYzKiprQUyXXGjtpr
	Vtm7VoEsNEraMeJnPvot9EKoGxZ8YvJAvKhyh7Gs2wHHdl9SzHvwaKSGyJoHlgp+fHNjSg
	HeV3jx1D3IrRn6Q7C2absQV6z4b6HwY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ED6A13889;
	Fri, 30 May 2025 16:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 99BVDx/aOWiDZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/22] btrfs: rename err to ret2 in btrfs_search_old_slot()
Date: Fri, 30 May 2025 18:17:26 +0200
Message-ID: <6fab4d81e9c152118e749dbd06fd796c1d6187b6.1748621715.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Unify naming of return value to the preferred way, move the variable to
the closest scope.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ce4e9055153a..cd5797a465da 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2245,7 +2245,6 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 	struct extent_buffer *b;
 	int slot;
 	int ret;
-	int err;
 	int level;
 	int lowest_unlock = 1;
 	u8 lowest_level = 0;
@@ -2270,6 +2269,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 
 	while (b) {
 		int dec = 0;
+		int ret2;
 
 		level = btrfs_header_level(b);
 		p->nodes[level] = b;
@@ -2305,11 +2305,11 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 			goto done;
 		}
 
-		err = read_block_for_search(root, p, &b, slot, key);
-		if (err == -EAGAIN && !p->nowait)
+		ret2 = read_block_for_search(root, p, &b, slot, key);
+		if (ret2 == -EAGAIN && !p->nowait)
 			goto again;
-		if (err) {
-			ret = err;
+		if (ret2) {
+			ret = ret2;
 			goto done;
 		}
 
-- 
2.47.1


