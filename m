Return-Path: <linux-btrfs+bounces-11334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03769A2BA34
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 05:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8E43A58DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 04:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40AF23237C;
	Fri,  7 Feb 2025 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C00Wxqml";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PldyGKnb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F88233134
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902391; cv=none; b=VPB7wAds/FP0oYalhpp8sXYP9sFmaoVrcQDkyEJUSSf29+4b6c/Onxy55ZnvvzOH0lS3mVG0ntnXau7w6rj2Qa0CjQ6fz8ydQ4/FxY9IIk7YuazpH8h1h24u3oprSjxm5JV7hHI9xVpF4gwitoWN3T6/+67RFT0oZ2cdTMSry0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902391; c=relaxed/simple;
	bh=BwWgj8vAXumnOMFMgDmcvlJuJPEI/24wA2fp6n0XMt0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qLK2SvZkqu2KXEE3Gwda0d3/HIMoWZLu1SALUeiYzwnqVRndjo3AriZnySHyA4szgkNBY0PvjI8pxEbBtCh8JcF48WxVFNniz/Kn2oBX6SRollps4J7wZzcWMq9d983CCvXhqhf6DWHu8h+PWo81WzGcisBQQcZVC0YvSLLIIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C00Wxqml; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PldyGKnb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC0AC1F38D
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vb2GBdYVOceK7ab8eHg/DYWcYsooe5jCac+akns8+K0=;
	b=C00WxqmlwTAOHhNkHFbJN0hOfTcSxviEerhHQKvDMZmTD6Kq5W+frqa4DoPj0DwUt0iLbc
	TRVL5ONKO5DTezzXS2eYVbacpyTa8gGiF3F8e3Ceg8bGg9EM8eEq0Q/WBloeWvjutv32/L
	fCMi52b338kiSxP6BQBDLohyfbssG6c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PldyGKnb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vb2GBdYVOceK7ab8eHg/DYWcYsooe5jCac+akns8+K0=;
	b=PldyGKnbtEHIAFLZBJF/ySAVOvNvmPoP9ViqMKTEos95NsFMIXv6CfQplMux7uz7x4Ysg4
	1P//V89zOxItyBA/C3XeUV8aphue8O21EebGMJuaLyWTCtwfhOYGAg8S7U2poQzlm2+4uE
	GKZ1D+41e61GtQTHrEQm2WHO8N0O4c4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2D3A13806
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2QDmJnGLpWezCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2025 04:26:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/8] btrfs: separate/simplify/unify subpage handling
Date: Fri,  7 Feb 2025 14:55:59 +1030
Message-ID: <cover.1738902149.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC0AC1F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Fix a crash in 4K page sized system caused by
  btrfs_clear_buffer_dirty()
  It looks like using btrfs_meta_folio_set_writeback() and
  btrfs_meta_folio_clear_writeback() is screwing up the btree inode map.
  
  Fix it by reverting to the old manually clearing of
  PAGECACHE_DIRTY_TAG.

[METADATA SUBPAGE CHECKS]
Currently we only have one btrfs_is_subpage() check, utilized by data
and metadata.

But the truth is, btrfs_is_subpage() can return incorrect result if the
target folio belongs to a dummy extent buffer.

This means we have quite some metadata call sites doing their own
metadata specific subpage check.

[SUBPAGE SPECIFIC HANDLINGS]
There are several functions that split the metadata subpage handling
into a dedicated path.

But the truth is, a lot of such paths only have minor differences
compared to the regular routine.

[THIS SERIES]
This series address the above problems and prepare for the incoming data
larger folio support by:

- Remove btrfs_fs_info::sectors_per_page
  This is mostly a preparation for the future data larger folio support.

- Introduce a dedicated metadata specific subpage check

- Unify/simplify metadata subpage handling
  So that we have a single unified path for metadata

Qu Wenruo (8):
  btrfs: remove btrfs_fs_info::sectors_per_page
  btrfs: extract metadata subpage detection into a dedicated helper
  btrfs: make subpage attach and detach to handle metadata properly
  btrfs: use metadata specific helpers to simplify extent buffer helpers
  btrfs: simplify btrfs_clear_buffer_dirty()
  btrfs: simplify write_one_eb()
  btrfs: simplify read_extent_buffer_pages_nowait()
  btrfs: require strict data/metadata split for subpage check

 fs/btrfs/disk-io.c   |   5 +-
 fs/btrfs/extent_io.c | 184 +++++++++++++++-------------------------
 fs/btrfs/fs.h        |   7 +-
 fs/btrfs/subpage.c   | 196 +++++++++++++++++++++++++++----------------
 fs/btrfs/subpage.h   |  52 ++++++++++--
 5 files changed, 247 insertions(+), 197 deletions(-)

-- 
2.48.1


