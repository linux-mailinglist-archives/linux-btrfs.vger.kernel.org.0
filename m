Return-Path: <linux-btrfs+bounces-5980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE349175DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 03:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2999D1F20595
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 01:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4EF1C2AF;
	Wed, 26 Jun 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rm0j4OTT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bJdFVCWk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653214AAD
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366478; cv=none; b=hSwpM/Pct5j20e2UEI3C18IasYYiokzbu6zQUxL6ocR0YifS6KcneY4jEkdq4bnBnDnTFFEj+Hqt7l2DBrKuc732amtJY6zTKdvZuCYSD218jVYFks8Xi1izDYrWyAU0B65LKEJS46VTaL3UJrzKu6lpy1z5V9vwYbHLQBGCG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366478; c=relaxed/simple;
	bh=xpGgIXL3g30g87MKw3gWymYK7/AiKannBmidewVmuLo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gpnRBPVaDkHKI+2Vfiw7+JlYKhM+N3ZzYOpMQgj4CFbHasVyGQRggSKFkwvR7XkjN5p7CMcgg8e+TOT1qPkikyKNAWpMKEjD+jfQfPUo844LbHhQ/mGgToX7snqAD9KiT6+X1RfBla2lw/cpRwfKn/0c7ZVqwfTizl3nzZ47Twg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rm0j4OTT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bJdFVCWk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C13D91F8C2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=a9wff9x1ZyeYmbg8BwBE16AmyMMCy9ycWXslea5XaP0=;
	b=rm0j4OTTCjtyhPc+NNCmdPCe73SKYnHNP41uV5YEpKd2YEkJkFgP4be5S36CyINnslJO7i
	vLOgARoadiH5kkwDVzOFa5zuiWim0Yff5br0FAS1Vo7K/rmQ8wGH6HWQ6rX32wDfdhHtEn
	EsTUF/EFWLGJLU/z7GyXA/WKcerpluk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bJdFVCWk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=a9wff9x1ZyeYmbg8BwBE16AmyMMCy9ycWXslea5XaP0=;
	b=bJdFVCWkPdC9DI4KIixYAHTi+XYCajjNY9fzeagyzhCcdIa4og2P+mPHLqpukXrPG3+45/
	YdW7QFgee/j/PPva1LhWf2A4/TVR8wK6fTuusnLLlgev3eBtCSojy1viYgh6mLPibVFIHO
	RAhidExX/DRR0mGTZHMeSo3ZhiRMSYI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D580F139C2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mkQeIkdze2ZtbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: detect and fix the ram_bytes mismatch
Date: Wed, 26 Jun 2024 11:17:28 +0930
Message-ID: <cover.1719366258.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C13D91F8C2
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Spam-Level: 

[CHANGELOG]
v2:
- Add the missing patch fixing ram_bytes
  Now the 2nd patch would ignore the incorrect value and use a correct
  one from btrfs_file_extent_item::disk_num_bytes.

- Update the commit messages to fix my usual "would" and other grammar
  errors

There is a long existing mismatch between ram_bytes and disk_num_bytes
for regular non-compressed data extents.

It turns out to be caused by truncated ordered extents, which modified
ram_bytes unnecessarily.

Thankfully this is not going to cause any data corruption or whatever,
kernel can handle it correctly without any extra problem.
It's only a small violation on the on-disk format.

This series would fix by:

- Cleanup the @bytenr usage inside btrfs_extent_item_to_extent_map()
- Override the ram_bytes when reading file extent items from disk
  So that we always get correct extent maps even if the on-disk one is
  incorrect.
- Add an extra check on extent_map members
- Add the proper fix for the ram_bytes mismatch
- Add a tree-checker for the ram_bytes mismatch
  Since we can have on-disk ram_bytes incorrect already, this check is
  only for DEBUG and ASSERT builds, and it won't report error but only
  does a kernel warning for us to catch.

Qu Wenruo (5):
  btrfs: cleanup the bytenr usage inside
    btrfs_extent_item_to_extent_map()
  btrfs: ignore incorrect btrfs_file_extent_item::ram_bytes
  btrfs: make validate_extent_map() to catch ram_bytes mismatch
  btrfs: fix the ram_bytes assignment for truncated ordered extents
  btrfs: tree-checker: add extra ram_bytes and disk_num_bytes check

 fs/btrfs/extent_map.c   |  5 +++++
 fs/btrfs/file-item.c    | 16 +++++++++++-----
 fs/btrfs/inode.c        |  4 +---
 fs/btrfs/tree-checker.c | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.45.2


