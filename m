Return-Path: <linux-btrfs+bounces-11125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B08A2183C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 08:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8FE3A336A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9121991D2;
	Wed, 29 Jan 2025 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ioqhKs5B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="acoYrX2P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F71993A3
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136274; cv=none; b=HN5XUZdThHaDHNOZtiB8XBHC2LBj4q/mS3LVXu3YqYbIokCN3TG70LGKfF8/+vmj3ldiTawNNU2GPSLcRxfepfTAtjA6PeMSQFsegvR1/kaHTYIQ2QsQEggSKGhtDlDLVmEmXYae54w/kWbjB2igKWVFE2No+g2REjP02kguf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136274; c=relaxed/simple;
	bh=8dud5SLNQPMWdgb3o2NkcjOA8V7lTLRlBTMYvualFbo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IcLCH0KuGi9aEYVGzTsV/fTgYohT6v9tzW+8diQNA6V0PR4YIuBjCQwpPWhKKgaxltRekhk9M4D56POVpbGogi8yDYJcXl6zQRBCLD3IWJ0QCQFtoXTfwwF/wTu+ig0ARESIZ0TJ9qekN7XPY6Q9AcbJYmHX+bRmMG9GlNMlwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ioqhKs5B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=acoYrX2P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCD7B210F3
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CiPnnSATyVJFcL/ckZPu796sO8Yrkg3SAB00MUrJa+4=;
	b=ioqhKs5BcowIkEn+8m4ILibh+leYXH1BxlzHUIh9Wg85PgO8ilYAJkfgHRN0CLLu3gdxk5
	YD6lmchppLVQB0FxCEqZoJ5XAOP1ycPZ2Uvi/3rROZnMqFIDBte9Jjn4Ew8kpXzdAjMpiX
	Jitl7KgC60G4HfFEb/W2hwcfdM7NpME=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=acoYrX2P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CiPnnSATyVJFcL/ckZPu796sO8Yrkg3SAB00MUrJa+4=;
	b=acoYrX2PZUUBgWsH2e7lz5Q4Plx49zLorWdt4Gd2LfBvwhT4H60lY7OolbEPOueucqBA3m
	IiCJCTPTw+9TSLlFcBjLFp6X43Np6MlpVQrKeglPD/Yqc5truUk2FM1KMhQ1Fq70T4kZBy
	xPTnr0TRUZU4vAfWHTielQfU6xjtbBY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 139E8137DB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J4Z4MMzamWdBKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: separate/simplify/unify subpage handling
Date: Wed, 29 Jan 2025 18:07:15 +1030
Message-ID: <cover.1738127135.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DCD7B210F3
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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
 fs/btrfs/extent_io.c | 193 +++++++++++++++----------------------------
 fs/btrfs/fs.h        |   7 +-
 fs/btrfs/subpage.c   | 173 ++++++++++++++++++++++----------------
 fs/btrfs/subpage.h   |  50 +++++++++--
 5 files changed, 222 insertions(+), 206 deletions(-)

-- 
2.48.1


