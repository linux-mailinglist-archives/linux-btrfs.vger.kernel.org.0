Return-Path: <linux-btrfs+bounces-10818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51ADA07309
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D44F188B39F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1777218AC1;
	Thu,  9 Jan 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GvWLCKiY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GvWLCKiY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57002153FF
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418251; cv=none; b=jSmbAuAfSNAptoHSY+fvoX7YFYfd9MAUYgfsD4ORs+N4SEr5FuOGwL0bRsYfAkt4HJYJpcVUCgYUGOw33SAefDUjGyMXs5qSjwigVoJ+4Y5922XQdvP1rnaMqa22p7Pdm579ehCmh5x4TDMclqHH6GIPAjSIVwwyjNPtZYz8Cwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418251; c=relaxed/simple;
	bh=wCd+PxRpTRpVqB/xXQuah4hbjt+05HzNk3pJl7HYEP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFd039sVRB+tvJ8djlUIPcpCn9Hdeh21SaqRodcWzQByxDiex2Cx0p93IIVIJphreEDpLQ1VnQN7URaINA/R7d17s8V+7TLq+899u7BOxqlK39fYIUHM//XwvVKirokwR+hvceI5DJ1lSHEYHagHV/fOlYzFL2n5qtKHeYi8yJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GvWLCKiY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GvWLCKiY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCD871F385;
	Thu,  9 Jan 2025 10:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KC22XQXXoYoyQV6iwi6dgd0u6nreinhP3oep7+uv04=;
	b=GvWLCKiYxGVDnLgzh5wMHO3vYhjH/DZ0RrQAaj0Uo5f+g3Ogs2nb8TBPSH3ZCFszVAYDti
	I5sBMfV875Y3fYY4myWsoQxt/54Bc14aqzr6KS8m6xG3w/xKgon8smEziq2cvAjuutJ0Wl
	qJnp/oekYfP/xjZ0YFqlS6pj4khxklY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GvWLCKiY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KC22XQXXoYoyQV6iwi6dgd0u6nreinhP3oep7+uv04=;
	b=GvWLCKiYxGVDnLgzh5wMHO3vYhjH/DZ0RrQAaj0Uo5f+g3Ogs2nb8TBPSH3ZCFszVAYDti
	I5sBMfV875Y3fYY4myWsoQxt/54Bc14aqzr6KS8m6xG3w/xKgon8smEziq2cvAjuutJ0Wl
	qJnp/oekYfP/xjZ0YFqlS6pj4khxklY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5FDC139AB;
	Thu,  9 Jan 2025 10:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G2U7NMWjf2cfEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/18] btrfs: remove stray comment about SRCU
Date: Thu,  9 Jan 2025 11:24:01 +0100
Message-ID: <94f6c64568a10ae8470b1477f6ce1f1b452a7117.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DCD871F385
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The subvol_sruce was removed in c75e839414d361 ("btrfs: kill the
subvol_srcu") years ago.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a7051e2570c1..587842991b24 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -96,9 +96,6 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 /*
  * This function is used to grab the root, and avoid it is freed when we
  * access it. But it doesn't ensure that the tree is not dropped.
- *
- * If you want to ensure the whole tree is safe, you should use
- * 	fs_info->subvol_srcu
  */
 static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 {
-- 
2.47.1


