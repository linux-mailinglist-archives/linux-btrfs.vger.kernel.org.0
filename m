Return-Path: <linux-btrfs+bounces-17557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA57BC7615
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 06:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD2EF4E8F7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 04:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1B25A341;
	Thu,  9 Oct 2025 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BLPwcwWt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OHh+uk5K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C42594BE
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759984829; cv=none; b=q0tTM8hHwjqNSgNPa0wE0Xwgix/MQP2OLkGzL/OgruLQJVzaDqb3KsGNgF7XLOyx2b+kXWxhbhTKXGpi5YzkT3oC+dF0zAz1yghyTDNUz8gleeTBLlqBNocmVHBBwSlwG1hkzoHVlj5FSe1zU48YmstlbQhywfVxfPbe3gShvTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759984829; c=relaxed/simple;
	bh=aHybIHSXrjr0nAT8fzpdNUoHisqaNw/q3VkfFgE8h6E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sYbTnGXkVzYrAAlPH5VWbbX7gmiW1DY7rPDq40PO4nIZqi7VzTzY8MhiniW8SmxF98kBgSRwBPRE4OtSbmC8w0uWTkLkYwjhc7INGV8yuG1PRhIbR4X2AU8aRDlEqhj/G4BT+aihLjtj7MOVX2rqF35Mv9u6gSTPlg3sTNZqQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BLPwcwWt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OHh+uk5K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B72921DA5
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759984824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6s0s7bJIRUpPdI+j8Q3rzQdlG0MUXcXcB4OylTVdCy4=;
	b=BLPwcwWtpJAuP6ME1IdZ/g202QESRD2DLEHT77BLPfflBSTwvzyWrwv37MpjFW0r3XiPMk
	ZnwVFdiXAr2ODA2anDZgRfrFsVZQsITU6/LVzg5krduvxbcT1wno75zD7mghjoShvCHc73
	o7SeLSYCt++94zbPjZYOWcZJIqhn6sY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OHh+uk5K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759984823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6s0s7bJIRUpPdI+j8Q3rzQdlG0MUXcXcB4OylTVdCy4=;
	b=OHh+uk5KRQhqQuy70F7ZRsPkr73+31zQiNZ0q9mOgV1abOQrOb+/rMfGFukZerd2CA7Bz1
	erZ43RXJFdthNlIUL1AwgcGKmi8qKY+4d/1TETfq2Assd0kBUdoNvvWmjNTCm/rpdsre0x
	hHo8OsK9HgXA1jjIw5Qc/xwC4LAk1ag=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C73FE139D2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PkQIrY852geVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 04:40:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: reduce memory usage for btrfs_raid_bio structure
Date: Thu,  9 Oct 2025 15:09:58 +1030
Message-ID: <cover.1759984060.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8B72921DA5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid]
X-Spam-Score: -3.01

This series replace the following members of btrfs_raid_bio:

	struct sector_ptr bio_sectors[nr_sectors]
	struct sector_ptr stripe_sectors[nr_sectors]

To the following ones:

	phys_addr_t bio_sectors[nr_sectors]
	phys_addr_t stripe_sectors[nr_sectors]
	unsigned long uptodate_bitmap[nr_sectors]

For x86_64 (4K page size) with the fixed 64K stripe size and 3 disks, the
memory usage of those members (not the full structure) will be reduced from:

	8 * 2 + 48 * 16 * 2 = 1552

To
	8 * 3 + 48 * 8 * 2 + 8 * 2 = 808

Almost halved the memory usage.

The memory saving comes from:

- Compat sector_ptr::uptodate bit into a bitmap
  This not only saves space, but also allow us to call bitmap_*()
  helpers when we need to set multiple bits in one go (mostly for
  subpage cases)

- Remove sector_ptr::uptodate flag
  We can use a special paddr (not NULL though) to indicate if the paddr
  is valid or not.

- Get rid of sector_ptr
  That structure has extra bits that take a full byte for each flag.
  This is the biggest space saving.

Qu Wenruo (3):
  btrfs: raid56: remove sector_ptr::has_paddr member
  btrfs: raid56: move sector_ptr::uptodate into a dedicated bitmap
  btrfs: raid56: remove sector_ptr structure

 fs/btrfs/raid56.c | 347 ++++++++++++++++++++++------------------------
 fs/btrfs/raid56.h |  17 +--
 2 files changed, 168 insertions(+), 196 deletions(-)

-- 
2.50.1


