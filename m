Return-Path: <linux-btrfs+bounces-12804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A027DA7C32F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 20:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789163B8C40
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 18:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DD3219A70;
	Fri,  4 Apr 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IneQ5lbl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IneQ5lbl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337791DD0D6
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790789; cv=none; b=LL3V77jkSyXsZ8Dcirajozb3u0YhwB3vLrLS3+TLqB1Bq0P7UHL0aiuimaodZ4Tr0Y7aNEUYt0CuFB87nUzY+Zqp0R1XTD/y65+kxogV7hdpUzwxS/2H7q6K+pKsWxLhiXv0e702RT5maVfBewupuG4r7olr/m9/f8O0CrPYmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790789; c=relaxed/simple;
	bh=RVq/NgnAbo5tqcbTDDgFzcgjOQoERaMEckz7cC/q2Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuFnMPLdoxuhlsH9HOQ9zlNbDd+PFsic5s7VNn3/of5ScZUSgUg08myVyfiYpR+3L0uR5XLRIuWyXeP1T2REf9kkQFlsy4t2ulcdxsiyptuOonYRi4ddiMm+xe5yuKmI0iZRj/2R5CF/3ABMCAWbY6b1VxycgyDoQQ9RQb3YlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IneQ5lbl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IneQ5lbl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A81F21169;
	Fri,  4 Apr 2025 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743790785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+Oym2/Z+3wt4LHd8+HohCgvoO9FszrIQvYIQAbgbGM=;
	b=IneQ5lblOGyf1Vi6yrLeqR66yUUBaEXzVCPcH3SP/DeqK7bL2UsyFBUE5D7XTX5OKxsbdm
	X0BFYynDc67dVam8J00GadK3lMsodqlZzqkI/rL6CDrg/iwNOYKMS6OIjURwWz6TZmOv6U
	VfTVuPNNgSmQKkWBOT5uNA0ysuDCiDI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743790785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+Oym2/Z+3wt4LHd8+HohCgvoO9FszrIQvYIQAbgbGM=;
	b=IneQ5lblOGyf1Vi6yrLeqR66yUUBaEXzVCPcH3SP/DeqK7bL2UsyFBUE5D7XTX5OKxsbdm
	X0BFYynDc67dVam8J00GadK3lMsodqlZzqkI/rL6CDrg/iwNOYKMS6OIjURwWz6TZmOv6U
	VfTVuPNNgSmQKkWBOT5uNA0ysuDCiDI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E8191364F;
	Fri,  4 Apr 2025 18:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5haGEsEi8Ge1LwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 04 Apr 2025 18:19:45 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: tree-checker: adjust error code for header level check
Date: Fri,  4 Apr 2025 20:19:41 +0200
Message-ID: <bed2a527314305ad67b662f0a485ae2dddba3edd.1743790644.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1743790644.git.dsterba@suse.com>
References: <cover.1743790644.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The whole tree checker returns EUCLEAN, except the one check in
btrfs_verify_level_key(). This was inherited from the function that was
moved from disk-io.c in 2cac5af16537 ("btrfs: move
btrfs_verify_level_key into tree-checker.c") but this should be unified
with the rest.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 732e0ca8f447..5cd98776a612 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -2235,7 +2235,7 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
 		btrfs_err(fs_info,
 "tree level mismatch detected, bytenr=%llu level expected=%u has=%u",
 			  eb->start, check->level, found_level);
-		return -EIO;
+		return -EUCLEAN;
 	}
 
 	if (!check->has_first_key)
-- 
2.47.1


