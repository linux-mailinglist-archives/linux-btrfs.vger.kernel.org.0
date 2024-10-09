Return-Path: <linux-btrfs+bounces-8714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C2996DF8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D324E1F22DF4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC41A00C9;
	Wed,  9 Oct 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kIJIF4ih";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XdVMbNYj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801B1990DD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484326; cv=none; b=o8OSMSeAm319iRiHM+QoZv8udVZESJ2fsxIQZHDD418SxA2OOHJYB3ga1lq790MrxnGrEGoS4NaPefPw89WvDfrsOR50ckttDgTkQuSzUmx9WkyB4kli10iOk2P5WoP6zRjUMO6L+uF8DjW9WDon/07cuSIRLSdSeYdbKHH6xuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484326; c=relaxed/simple;
	bh=Ujqd2G9vfAzWYlAWBAMvmvCloN260rtrQkc8m4g1KRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdsJ5bcvWkUstUa92XTckW9huXuB36aPgEIVsfMGIh3sSG2rA49q17g0KUc24LWf8n1np32JAuoSAfN6FGApBCDTIZ/4HEgSFPjTfazEW72nGxdTuil9quOa4zFKk7uXrI442tLLz5tMw8v0cgBqfaQji8juygP/xVdtjluAJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kIJIF4ih; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XdVMbNYj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECEA21F7C8;
	Wed,  9 Oct 2024 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAIEagDUyNXT99xAcLYT64S/bTIouHc6H1kbQ8hoDAM=;
	b=kIJIF4ihSpKLaHJQsb31BlE0cAg3R1Gws0YpVg57DxtMmCAg5QR8eCGStAn9HkyvejUIX5
	O/8ZkVuALODKfiAAiitMsxAGcZxHvLEpv669mrMLvjp8ESym3li6wmCeAM1cBtfCXvE8SU
	YTJlVU6o552qY5M2ghPagy+gB6I7JgQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAIEagDUyNXT99xAcLYT64S/bTIouHc6H1kbQ8hoDAM=;
	b=XdVMbNYj2AS3GspdqNe80ApjrVGYX4f9//V34ZnPrdctDFvqR7o02JgK4vrj3Qp+EKklgS
	kNhPcGACdmdmkA7O8czfSHZX7qfIQdZ7u+uanx9NK1BsiD7GR/v94e2xhcIwtxOY+P+UNn
	IFkHoSy1Q9+a8VJHyoVRTLydl6Uk7Ng=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E44EA136BA;
	Wed,  9 Oct 2024 14:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8By9N+KTBmdqRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:32:02 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 19/25] btrfs: drop unused parameter mask from try_release_extent_state()
Date: Wed,  9 Oct 2024 16:31:58 +0200
Message-ID: <ae37a46650b3dda22029e71736bb73588c9af5f1.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The mask parameter used for allocations got unified to GFP_NOFS and
removed from relevant functions in 1d1268004430 ("btrfs: drop gfp from
parameter extent state helpers").

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9fbc83c76b94..59c47cb8e538 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2381,7 +2381,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
  * to drop the page.
  */
 static bool try_release_extent_state(struct extent_io_tree *tree,
-				    struct folio *folio, gfp_t mask)
+				     struct folio *folio)
 {
 	u64 start = folio_pos(folio);
 	u64 end = start + PAGE_SIZE - 1;
@@ -2492,7 +2492,7 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 			cond_resched();
 		}
 	}
-	return try_release_extent_state(io_tree, folio, mask);
+	return try_release_extent_state(io_tree, folio);
 }
 
 static void __free_extent_buffer(struct extent_buffer *eb)
-- 
2.45.0


