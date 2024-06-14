Return-Path: <linux-btrfs+bounces-5732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A36E9082E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 06:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E271F21C4D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 04:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72DA146D43;
	Fri, 14 Jun 2024 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jsWn9y08";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jsWn9y08"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E7E12DD95
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338966; cv=none; b=AHANmNE2WvU/mHZmEmBg4WgEgGj4UMShg6G0ROVL/zgj+z3WqljoLz1bLJbceF/NN5wTU6YTuZ7OOkZrjOPiJTavku9zEKNl3qkbJulY4sQKhmpd74J3C15eZZ/lDQUN8cbynZ30mWng7uxE1cMZYpP3ka1t09+U/J4hLm8OM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338966; c=relaxed/simple;
	bh=a5oBqkfLI6vlzbhqEsvb3t9Mu0F2sv+6BGReWeZmbGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdJ5oqsYVOcYh5tlR4QNpq2UjCWXGPbhGS4p7ANM5EvkpvqY2dJdHYwrUIm3uJeMV/ydNz6culq+7f1WknlUqmHBAK1eXXcDA6fChvSIE5qtCWLjlI5AaSrVJgOv7bQ/5hYIRRCj6PoYg2ct+GlXBEJemtEF7sgT3HcUV6ay5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jsWn9y08; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jsWn9y08; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5C27227FA;
	Fri, 14 Jun 2024 04:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8XftkD9WQd+vlL+oAZHA8VNbpkM8555JMehu5vbSbc=;
	b=jsWn9y08nYAN4C/mB7SVpNp5fh6l7aDFl+Lp+sbS+UXn0qdFnPwI7cjXhCHscQ/uv1Romj
	1qzQh5t23FGSfZsSbEiN/KcgpsHxlmv+xUZhxY39NapoIwOreWDxFTP5OsDhlCKzdN/tWl
	r8+fkikDFQLiWO2BWxs9njRa5blB7tE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8XftkD9WQd+vlL+oAZHA8VNbpkM8555JMehu5vbSbc=;
	b=jsWn9y08nYAN4C/mB7SVpNp5fh6l7aDFl+Lp+sbS+UXn0qdFnPwI7cjXhCHscQ/uv1Romj
	1qzQh5t23FGSfZsSbEiN/KcgpsHxlmv+xUZhxY39NapoIwOreWDxFTP5OsDhlCKzdN/tWl
	r8+fkikDFQLiWO2BWxs9njRa5blB7tE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86AA213AAD;
	Fri, 14 Jun 2024 04:22:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CDB8D5DFa2YBJQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 14 Jun 2024 04:22:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 1/4] btrfs: remove unused Opt enums
Date: Fri, 14 Jun 2024 13:52:28 +0930
Message-ID: <dc052d6d806025eaa8d2801211f22d14a923905a.1718338860.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718338860.git.wqu@suse.com>
References: <cover.1718338860.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.77 / 50.00];
	BAYES_HAM(-2.97)[99.87%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.77
X-Spam-Level: 

The following three Opt_* enums are not utilized at all:

- Opt_ignorebadroots
- Opt_ignoredatacsums
- Opt_rescue_all

All those enums are from the old day where we have dedicated mount
options, meanwhile nowadays they are all moved to "rescue=" mount option
groups, and no more global token for them.

So we can safely remove them now.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 549ad700e49e..902423f2839c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -125,9 +125,6 @@ enum {
 	Opt_rescue,
 	Opt_usebackuproot,
 	Opt_nologreplay,
-	Opt_ignorebadroots,
-	Opt_ignoredatacsums,
-	Opt_rescue_all,
 
 	/* Debugging options */
 	Opt_enospc_debug,
-- 
2.45.2


