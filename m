Return-Path: <linux-btrfs+bounces-11608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1836EA3D494
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594A57A9A30
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3881EF0B4;
	Thu, 20 Feb 2025 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HVhOQgqI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HVhOQgqI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E341EDA09
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043376; cv=none; b=n6prRMgQC9M+EUFbKqsqpcHbh6yT+0tfAZGqa5zD2JfhWINPa0vo7wD2Ut5FdtzQE6MS8PzprIH6+099VOLxs9NdNKnQj6ihHMlPPBe70LxG6ybMbbEC5PhOowtM9O62eRq+rVr87LCcP3U1ALlTwrlfdFLUFD/wby3RLs4lovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043376; c=relaxed/simple;
	bh=z8+frb2AdOI6EGPDHI9JXg48sskiwdwZGDZ/lKkXDJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0kAuyt0+5k1CJNG1DdVQeIG9OUHobtkkFss8/jijkli3ALOOlyMl1uTIjYMzghJGHTlVVmmHnd4boVIPDo7d6z7lFCJEsMOw0ZVX5joOeHGbTmS2Y2I5EjgI+jNOOURkHRLHcwAMmQQw6CEHsjMefHGMf/kGWNyOXA23E65JGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HVhOQgqI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HVhOQgqI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F59C210EF
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jIhdp3Fg3W14B09jb5nGVWNEYSFHjoUycfi+pihNms=;
	b=HVhOQgqIGwZAKMhP5ozEu9ChBcC47Ya5Shol8rTUzndFkrMUmk2m25GcDGZypjW1a8FUeb
	H+HeL9J7aMfxaBrRQNZGz71/qHWoRblVcromuAPFMFi0bTzrJAtXgVE4r9uVcb50Xi2iMq
	LzpLlAIerFNk3LApjB+PfaZR+d9Lg+I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jIhdp3Fg3W14B09jb5nGVWNEYSFHjoUycfi+pihNms=;
	b=HVhOQgqIGwZAKMhP5ozEu9ChBcC47Ya5Shol8rTUzndFkrMUmk2m25GcDGZypjW1a8FUeb
	H+HeL9J7aMfxaBrRQNZGz71/qHWoRblVcromuAPFMFi0bTzrJAtXgVE4r9uVcb50Xi2iMq
	LzpLlAIerFNk3LApjB+PfaZR+d9Lg+I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 193E613A69
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uAdALWn0tmfBcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: prepare btrfs_launcher_folio() for larger folios support
Date: Thu, 20 Feb 2025 19:52:24 +1030
Message-ID: <799e9c2e9ae466a1a52a83b6afd12cb4449086a3.1740043233.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740043233.git.wqu@suse.com>
References: <cover.1740043233.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

That function is only calling btrfs_qgroup_free_data(), which doesn't
care the size of the folio.

Just replace the fixed PAGE_SIZE with folio_size().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d9ca92d1b927..c88aa961af51 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7270,7 +7270,7 @@ static void wait_subpage_spinlock(struct folio *folio)
 static int btrfs_launder_folio(struct folio *folio)
 {
 	return btrfs_qgroup_free_data(folio_to_inode(folio), NULL, folio_pos(folio),
-				      PAGE_SIZE, NULL);
+				      folio_size(folio), NULL);
 }
 
 static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
-- 
2.48.1


