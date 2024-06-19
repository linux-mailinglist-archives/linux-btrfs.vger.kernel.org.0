Return-Path: <linux-btrfs+bounces-5803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D407B90E296
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 07:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F82B20C4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 05:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A25466B;
	Wed, 19 Jun 2024 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bi9lO9V2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u6piKDfn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93736AFE
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774204; cv=none; b=cAjaJdnhHI0Nk7Z5PRxm8Z9n1t45GSve5nJhAP7xSpbVhRcLqKwL+6gARmTTTWH2LaNG8nNeYPOWMACdmP43FNKb4ZDwqEhgt99J/D97Q/1NbR8IrWEpHBSbmdSotNiZJWukTtbm9rBOgXwnWqVo7epzFJGtvtvzN2OkPYpiikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774204; c=relaxed/simple;
	bh=yjH1O/UcGJnIlQi888Ei3kbwQ54AmCQdP/3WPorQOF8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AC9NlU6E3KltigVtnnvABQGRC/5+axAXBES3GRBwekT33ZTV3FK2eRw69E+IyWE688kRNvcPjV4M0WiZItWLHGv6KhDRzlK4qpjIzQoI+dpvWbZuELJQJDZD7bMRQa3bq2REtNLuhY+z5LDyt8ap1g3H89t6IMDxLHHf7nYYlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bi9lO9V2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u6piKDfn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CEFA21A1C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718774200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Heu9/a2zzTAiZw8XNdv7OBG0hxTEEut8Vuqs6RkQ8g=;
	b=bi9lO9V2cN92Cr4EDTghMHtxaLSSqyb3AU37OhvQbENJNJkOw2v45x4Bf3IBHaePXAv7to
	2NbVezyJJ5HAoz0bOOjtN2OP0aEfvxFf/LUPs6ixXnj/2as7jmVptMcpJwFUzrBrJptHVH
	HAgQivKegskccYFUIuuGHszKxU2wQ48=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=u6piKDfn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718774199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Heu9/a2zzTAiZw8XNdv7OBG0hxTEEut8Vuqs6RkQ8g=;
	b=u6piKDfnEqJSWmOnbH7T4vzC8GRUNkeaCezCqwCQgrRLvA4gySk54hHR73q3u81DFlI5ri
	MdSXslvcWHnknsFfp4T+g1gXEOHl83fuvTJrImP97R/dyNSgKA3238zOtuLhXQ5Z0RDUgv
	jHW7hzfdzWHcOUtg+2MQCPYOXsxNrBg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B99513AAF
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FpqiNrVpcma+ZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:16:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: update the rescue mount options
Date: Wed, 19 Jun 2024 14:46:15 +0930
Message-ID: <159585b6c0089cc35237e14b2f56089c9114fdf8.1718774167.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.96 / 50.00];
	BAYES_HAM(-2.95)[99.80%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2CEFA21A1C
X-Spam-Flag: NO
X-Spam-Score: -2.96
X-Spam-Level: 

Enhance the rescue mount option group by:

- Add a simple explanation on each rescue option

- Add the new 'ignoremetacsums' option

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/ch-mount-options.rst | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-mount-options.rst
index 2961837e9e71..1d968f37c14a 100644
--- a/Documentation/ch-mount-options.rst
+++ b/Documentation/ch-mount-options.rst
@@ -335,14 +335,35 @@ rescan_uuid_tree
 rescue
         (since: 5.9)
 
-        Modes allowing mount with damaged filesystem structures.
+        Modes allowing mount with damaged filesystem structures, all requires
+	the filesystem to be mounted read-only and doesn't allow remount to read-write.
+
+        * *usebackuproot* (since 5.9)
+
+	  Try to use backup root slots inside super block.
+	  Replaces standalone option *usebackuproot*
+
+        * *nologreplay* (since 5.9)
+
+	  Do not replay any dirty logs.
+	  Replaces standalone option *nologreplay*
 
-        * *usebackuproot* (since: 5.9, replaces standalone option *usebackuproot*)
-        * *nologreplay* (since: 5.9, replaces standalone option *nologreplay*)
         * *ignorebadroots*, *ibadroots* (since: 5.11)
+
+	  Ignore bad tree roots, greatly improve the chance for data salvage.
+
         * *ignoredatacsums*, *idatacsums* (since: 5.11)
+
+	  Ignore data checksum verification.
+
+	* *ignoremetacsums*, *imetacsums* (since 6.12)
+
+	  Ignore metadata checksum verification, useful for interrupted checksum conversion.
+
         * *all* (since: 5.9)
 
+	  Enable all supported rescue options.
+
 skip_balance
         (since: 3.3, default: off)
 
-- 
2.45.2


