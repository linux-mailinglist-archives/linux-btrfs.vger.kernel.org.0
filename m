Return-Path: <linux-btrfs+bounces-17838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF2BDE694
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 14:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 763285013F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD96326D55;
	Wed, 15 Oct 2025 12:12:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6A324B38
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530333; cv=none; b=So2SsF4Ty4wT6fhObzyVN5XpmVG89Ve2/BXdB0oK++9fpjlypuJKvAFODj1RlJLdT92QpFbnMMhXjpbhUPa5we+C/FyFzGl/yVgiiqOIJ2wy6fyB2LZOIn0C68iuUQEJUbfV9zcvixFFCEWA7esOdGtvdX9GphtPQe6/dcYpMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530333; c=relaxed/simple;
	bh=0mP+zZqQVeuctBQlG6T8HGup6/su5wTvKxLrmReI1QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGfwCABZcfxlQSMQTydv65kXtxTrH3JGpQ3qgRQfuHkzYp9SVPHHqBBZ4fnEhLhe9WpT4kbBAC1GWTTpZjl3nTCwmcEV3/WTxfYasOs3IGkxvFhE/rLnS8E0CwRTSQJ6Zn+cEsSU51PbQbdWjMt8hrYKermDktRuygIL6jLNN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4E8E33857;
	Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F4CF13AE4;
	Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aIWLIpKP72i2fAAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 15 Oct 2025 12:12:02 +0000
From: Daniel Vacek <neelx@suse.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 1/8] btrfs-progs: check: fix max inline extent size
Date: Wed, 15 Oct 2025 14:11:49 +0200
Message-ID: <20251015121157.1348124-2-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015121157.1348124-1-neelx@suse.com>
References: <20251015121157.1348124-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: A4E8E33857
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

From: Josef Bacik <josef@toxicpanda.com>

Fscrypt will use our entire inline extent range for symlinks, which
uncovered a bug in btrfs check where we set the maximum inline extent
size to

min(sectorsize - 1, BTRFS_MAX_INLINE_DATA_SIZE)

which isn't correct, we have always allowed sectorsize sized inline
extents, so fix check to use the correct maximum inline extent size.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 91ce6d74..054a22d3 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1719,7 +1719,7 @@ static int process_file_extent(struct btrfs_root *root,
 	u64 disk_bytenr = 0;
 	u64 extent_offset = 0;
 	u64 mask = gfs_info->sectorsize - 1;
-	u32 max_inline_size = min_t(u32, mask,
+	u32 max_inline_size = min_t(u32, gfs_info->sectorsize,
 				BTRFS_MAX_INLINE_DATA_SIZE(gfs_info));
 	u8 compression;
 	int extent_type;
-- 
2.51.0


