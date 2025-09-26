Return-Path: <linux-btrfs+bounces-17224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F159ABA3EA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A95C1C0246A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244AB2F60D8;
	Fri, 26 Sep 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EikCTLBV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ecSrf+MH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9F2AD3E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893738; cv=none; b=fuzxCrbkTXWj/FO8KPmxM7JIhPK4vixL36nYTLsQpI5tS/zuS19G5zu6xCapmpSXCg0XcJbKoF1gG8iBTEwu+xCPSGkKwtET+MLHwNpr5wMcdNCSt5bXoZ1urzhJTCftshKD/Naj7l+jnhaw4x2F1jYh4HyMyvfkufvIyFxU0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893738; c=relaxed/simple;
	bh=7RoNy1+lg+B+WtpawF5jBpnjJ7WfaySIRDjOtHoLk0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mvr1mJe0P+W4NrxC0OekFq15WPsOdXLr11o8YIKqle+I/sDQbGLjbJMYX5VmLTpSQ8vMdUgubtxajNRjEM+z1/MyrCO8679g5DmS/sjApMwOAt7ExmKfe1b89c7R/B3RQf2cu7YomAoZ/mP2fPUVq80mCdFCAvVPNKe8QBkNLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EikCTLBV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ecSrf+MH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C13B04E6F5;
	Fri, 26 Sep 2025 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758893733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7dMhkow+ea+dv2pyvud9Xpb6vdn/9fw0cWO3jxvDZMQ=;
	b=EikCTLBV5C66pSfQJsv33yEIXL11jW8wlNXF6DZnoQ6kr2Z02q5uzpD43Mafa1/pCoEhzU
	j4NybYuQiKfwZr3FIFQGX8PhMwJSE+tixwzyFt9oFUn0DJM8YQXa6yrhX+VSh7xjeHjwZw
	/+NWRd/uoobNXlHT4NiYboxR4rD3DAQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ecSrf+MH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758893732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7dMhkow+ea+dv2pyvud9Xpb6vdn/9fw0cWO3jxvDZMQ=;
	b=ecSrf+MHQeWcyC+JqTpEUTKhXcuUbfYWI0cisd6RtPg6FGKWw/J7ZH/1JLR9mUj5DLNutC
	86PJzvZ5GwrRyXRy4cCySlP7iW0+OujWU1+59FhvGKHjsVqIvaqCQixwyPDCLLutYeUSMe
	Qvax/g4Jlh5PrhyGY2whehXBUQR9EWs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAA961373E;
	Fri, 26 Sep 2025 13:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xZmMLaSW1mhKWwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 26 Sep 2025 13:35:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: print-tree: use string format for key names
Date: Fri, 26 Sep 2025 15:35:26 +0200
Message-ID: <20250926133526.15345-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C13B04E6F5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

There's a warning when -Wformat=2 is used:

fs/btrfs/print-tree.c: In function ‘key_type_string’:
fs/btrfs/print-tree.c:424:17: warning: format not a string literal and no format arguments [-Wformat-nonliteral]
  424 |                 scnprintf(buf, buf_size, key_to_str[key->type]);

We're printing fixed strings from a table so there's no problem but
let's fix the warning so we could enable the warning in fs/btrfs/.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/print-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 62b993fae54f..d16f2960d55d 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -421,7 +421,7 @@ static void key_type_string(const struct btrfs_key *key, char *buf, int buf_size
 	if (key->type == 0 && key->objectid == BTRFS_FREE_SPACE_OBJECTID)
 		scnprintf(buf, buf_size, "UNTYPED");
 	else if (key_to_str[key->type])
-		scnprintf(buf, buf_size, key_to_str[key->type]);
+		scnprintf(buf, buf_size, "%s", key_to_str[key->type]);
 	else
 		scnprintf(buf, buf_size, "UNKNOWN.%d", key->type);
 }
-- 
2.51.0


