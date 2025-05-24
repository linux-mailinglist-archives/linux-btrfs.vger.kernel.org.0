Return-Path: <linux-btrfs+bounces-14199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC239AC2D04
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466B04E194C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9DB197A8E;
	Sat, 24 May 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fgZFcFbY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fgZFcFbY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC30190679
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052525; cv=none; b=GJtBTQGkfnDrm2ItTpVo9rZAh4EDhxfKSBibgCzeS9bjuxGSEmIP3SnYkYDXwQfQYE2I5NB5pOPA3B/rId21ZTUryr4JDUGAwb7DOAa1cvXzX6JKNr7PlNLfmV5YxMNKXPQNHpHyrLz6Lf3C/9fbe+f4V0tee1R8zAtZvS9kkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052525; c=relaxed/simple;
	bh=+vgYGyUnMG+8aofvhlVuz7OnDfcN+wwTog87wX7r3Cg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWcZTGhCW6xYzricjqUoBGlPCFB/sMT9MIW5/wM43XLbGzyR/7x/XZrcbiyX/2eME+khXeJ+hladKZ/V31QCtA1j/h6EcYoL8sKJmYCRO7JPRKv7Hls6JCdEWDAfz0GNTZe1EUMOis/z2f6zxkERja6vCSyBvENbTEazi4BaRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fgZFcFbY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fgZFcFbY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0625221C9E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV49MsdnKqodMZes0o8Q6FfIf/G8N/5o8xhiLHqgkI4=;
	b=fgZFcFbYhIzm1G6cE/WOHNIQbSZSDKYOGhkldv5m9SvbBp5Xo3psa+BXAGZ9fjKCyVum5z
	XesOYJR1OQ8EWGHZYzjI8WtmQvEQuAvtkhycytF2ZrtQZcAC6j/i5kht4pYh6PTXw83bGg
	AijWue/NnBu9F91wf/9MKJ93ThJCF6M=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV49MsdnKqodMZes0o8Q6FfIf/G8N/5o8xhiLHqgkI4=;
	b=fgZFcFbYhIzm1G6cE/WOHNIQbSZSDKYOGhkldv5m9SvbBp5Xo3psa+BXAGZ9fjKCyVum5z
	XesOYJR1OQ8EWGHZYzjI8WtmQvEQuAvtkhycytF2ZrtQZcAC6j/i5kht4pYh6PTXw83bGg
	AijWue/NnBu9F91wf/9MKJ93ThJCF6M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47E451373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YLVfAyIqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs-progs: convert: add feature dependency checks for bgt
Date: Sat, 24 May 2025 11:38:06 +0930
Message-ID: <f85108f211ce51ce3dc0cce12ea4124002dd9b0b.1748049973.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748049973.git.wqu@suse.com>
References: <cover.1748049973.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Block group tree requires no_holes and free-space-tree features, add
such check just like mkfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/convert/main.c b/convert/main.c
index 0dc75c9eb1c6..264ee1dc89e0 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1212,6 +1212,12 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 
 	if (btrfs_check_nodesize(nodesize, blocksize, features))
 		goto fail;
+	if (features->compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE &&
+	    (!(features->incompat_flags & BTRFS_FEATURE_INCOMPAT_NO_HOLES) ||
+	     !(features->compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE))) {
+		error("block group tree requires no-holes and free-space-tree features");
+		goto fail;
+	}
 	fd = open(devname, O_RDWR);
 	if (fd < 0) {
 		error("unable to open %s: %m", devname);
-- 
2.49.0


