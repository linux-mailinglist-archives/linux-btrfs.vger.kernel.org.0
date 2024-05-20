Return-Path: <linux-btrfs+bounces-5124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896288CA2F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 21:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC2D1C218AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 19:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09B139599;
	Mon, 20 May 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RkmePXS9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RkmePXS9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C913958F
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234752; cv=none; b=fNAo2rRD3ldk1clTLndbx0v057Ob81rR8cw3bAyfwJEFmdWR7RMCjdJz5X4R1Kwg9IdE1Putfu4OnzbMtK8ynFsVlSRKr0EFRjhxRJHkedMC9px2DrvQ8uHqNlaMXNczSDDhs4ZI4xZI9t5zfGngkqSPfPo6haZECEn4dvUdi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234752; c=relaxed/simple;
	bh=4mIkFhlGjr0eDOLoO9Y/6pfBBHCcWrbxC9Xnak/iDic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRuk7kMEo0dnHEGtXvmG+/i0PqnwV65S62NKh4jmaYW5qVyPylrT4+yLhe09O33MDAi0OJBHyKG3pWIt9VaZLoT8JV8jHDjc2vRxzkCXXr0f1tDkd+ao8/dc5Nh48c05Ff6mu5RrXf6JuYhoJ3Qn+lScpeQ33+ahtbzZm3B0yQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RkmePXS9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RkmePXS9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6760820F86;
	Mon, 20 May 2024 19:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkJjkedrf5thifiiox1KiC40+kSw6KFhFqnnBne0pqc=;
	b=RkmePXS9VnQNYE7lZ2V/1wMcJqjD6BltJY3+BT+5253+ysuCnERnu5/K0mrM7RFWyIfnSr
	ksB+U9JzKZ2WFi+3ucXM2BsC6UxKdvmwcASNxZwKzPm8skc0pVYzIFdKI/SqINsez46Pps
	Fr+mkVnjLF9WQn09h+Mm8aj8SP1sgtU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RkmePXS9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkJjkedrf5thifiiox1KiC40+kSw6KFhFqnnBne0pqc=;
	b=RkmePXS9VnQNYE7lZ2V/1wMcJqjD6BltJY3+BT+5253+ysuCnERnu5/K0mrM7RFWyIfnSr
	ksB+U9JzKZ2WFi+3ucXM2BsC6UxKdvmwcASNxZwKzPm8skc0pVYzIFdKI/SqINsez46Pps
	Fr+mkVnjLF9WQn09h+Mm8aj8SP1sgtU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6159E13A6B;
	Mon, 20 May 2024 19:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RWHCF/2pS2amRgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 20 May 2024 19:52:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/6] btrfs: remove unused define EXTENT_SIZE_PER_ITEM
Date: Mon, 20 May 2024 21:52:29 +0200
Message-ID: <041c312ba5103100a7052be7e6aee21300656940.1716234472.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716234472.git.dsterba@suse.com>
References: <cover.1716234472.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.95 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.94)[86.48%];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
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
X-Rspamd-Queue-Id: 6760820F86
X-Spam-Flag: NO
X-Spam-Score: -0.95
X-Spamd-Bar: /

This was added  in c61a16a701a126 ("Btrfs: fix the confusion between
delalloc bytes and metadata bytes") and removed in 03fe78cc2942c5
("btrfs: use delalloc_bytes to determine flush amount for
shrink_delalloc") where the calculation was reworked to use a
non-constant numbers. This was found by 'make W=2'.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/space-info.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d620323d08ea..411b95601f18 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -587,8 +587,6 @@ static inline u64 calc_reclaim_items_nr(const struct btrfs_fs_info *fs_info,
 	return nr;
 }
 
-#define EXTENT_SIZE_PER_ITEM	SZ_256K
-
 /*
  * shrink metadata reservation for delalloc
  */
-- 
2.45.0


