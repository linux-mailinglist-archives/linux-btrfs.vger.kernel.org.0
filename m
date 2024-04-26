Return-Path: <linux-btrfs+bounces-4552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDF8B2F65
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 06:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28B0B22157
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 04:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89138249F;
	Fri, 26 Apr 2024 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fSmreUMF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fSmreUMF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8350EACD
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714105135; cv=none; b=BGzz863ucpGKF9A2BNGdnxiB2PybSHLfJhk4yZIUnnSw0LAAiorad8UF9//JSd31NGpA1frlSxRAxqvS0MuyO/qe5EKEaZPfU8AXXXwu+FxdihCnat0Xf1sHmpbK6BMfUrsA15Xw2NAxCg0pay+qc5EZ6p+OkdHDOLTiXatf6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714105135; c=relaxed/simple;
	bh=E0uTj6JFRJkLr+JoxOJtVx604GHUkcGyBrZjlg/LsIA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a80878+4SGYrBuK41zxGZC02ZThP/vvavqprliTHzcDe+xRB8QU68kpqeJRmWzeKs3+adfrUmPuxD4a+JVdjVdX8c5fUFIX1lTVAOOWnw9AIkB3BCliq+nYgy3BA3UfXqDn8TQr3YXVBGnDqNNbRhx6IzfX3HKyTguaR7tHHO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fSmreUMF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fSmreUMF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0205D348C6
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 04:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714105132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mvtI1a8L9FRY4Jqsc7NxWTMvgudC2hXvP8LQF8F6OUs=;
	b=fSmreUMF4/n3U6rgYx+Cq2rW/y0OtwQDPP6/R83i/SirrD+F+Mr+WI33Ur3Rn/WIE7FyZI
	xLzNunhdsZMa6Wsbha3GKjWPNkHMKxg14qox6/Nj39dwSQCI3uohxN3irf4YW9ecsh/e5L
	SnXIMxKrfbVO1iVaR+ViUPAtCIMcJDU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fSmreUMF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714105132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mvtI1a8L9FRY4Jqsc7NxWTMvgudC2hXvP8LQF8F6OUs=;
	b=fSmreUMF4/n3U6rgYx+Cq2rW/y0OtwQDPP6/R83i/SirrD+F+Mr+WI33Ur3Rn/WIE7FyZI
	xLzNunhdsZMa6Wsbha3GKjWPNkHMKxg14qox6/Nj39dwSQCI3uohxN3irf4YW9ecsh/e5L
	SnXIMxKrfbVO1iVaR+ViUPAtCIMcJDU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD98E1398B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 04:18:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tu4HGyorK2ZOUwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 04:18:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the recursive include of btrfs_inode.h from itself
Date: Fri, 26 Apr 2024 13:48:27 +0930
Message-ID: <6165f2c27b4d02fa4f94d8373cd3506e3028fc71.1714105096.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.15
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0205D348C6
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.15 / 50.00];
	BAYES_HAM(-1.14)[88.61%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]

Inside btrfs_inode.h we include itself, although it's not causing any
problem, it's still being reported by clangd, and is really unnecessary.

Just remove the recursive include.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 91c994b569f3..de918d89a582 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -19,7 +19,6 @@
 #include <uapi/linux/btrfs_tree.h>
 #include <trace/events/btrfs.h>
 #include "block-rsv.h"
-#include "btrfs_inode.h"
 #include "extent_map.h"
 #include "extent_io.h"
 #include "extent-io-tree.h"
-- 
2.44.0


