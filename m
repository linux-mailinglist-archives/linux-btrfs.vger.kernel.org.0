Return-Path: <linux-btrfs+bounces-14023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6577AB7AA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 02:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155A0867732
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 00:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310BF25776;
	Thu, 15 May 2025 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JLKQt/Rk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JLKQt/Rk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275898F66
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747269423; cv=none; b=QixoC55my3TnT9oix2qqP+0RLrO4NNnuX5ryFEBuWfiFZfhN3msp1pk3hqH5N0l6dTBNQwcelHXFvraaL1y+XLOHvPb0iJDQAA/mFlsqHGA7GDY08YxZWRR4LLfE3lAm+Cj+KP5N8toLSV0Az29iODUSnnEb61dl4y7l1AB7ItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747269423; c=relaxed/simple;
	bh=R/KTtLcVCLq4HotDTprznhI9mZetxBKlV8FYMYXcYaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlODPjonGCOdn6feayO7jP8NaJYUgDs3h5rFfZobemYYiKfN1tr7l0EcXkL2s3xZgAShLmzBvf+ndi9RKqY1Gx909EzZ/x+zf/RwsrYDJvrXTcDk4uzv0pjLzPX2Ah/lSaYu7VLQh/AiemXhFHuc3I+hP7SzdAt5hY20HO3TUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JLKQt/Rk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JLKQt/Rk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F40151F7B7;
	Thu, 15 May 2025 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747269419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/3KFUj+OwqPHSSKglOH74QOPDn6c2feGMbVTaZP1XrI=;
	b=JLKQt/RkPXk5DkWKTBvN7bbBwTuSXKTMofQKAXMAgBUPC5RczX1Fq3y3Ec+Yebse3btwPf
	ymqNJbGxkN/ZecI1PrqGarnLiU2/SgJrZM/4SK5mhgx+W+/OIHqzU3ZekbEXrJfUrQGL2s
	CwWpbezbTSbO6/420L4ciss/4X80PF0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="JLKQt/Rk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747269419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/3KFUj+OwqPHSSKglOH74QOPDn6c2feGMbVTaZP1XrI=;
	b=JLKQt/RkPXk5DkWKTBvN7bbBwTuSXKTMofQKAXMAgBUPC5RczX1Fq3y3Ec+Yebse3btwPf
	ymqNJbGxkN/ZecI1PrqGarnLiU2/SgJrZM/4SK5mhgx+W+/OIHqzU3ZekbEXrJfUrQGL2s
	CwWpbezbTSbO6/420L4ciss/4X80PF0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8E8C136E0;
	Thu, 15 May 2025 00:36:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TWWUOCo3JWhBPAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 15 May 2025 00:36:58 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.15-rc7
Date: Thu, 15 May 2025 02:36:50 +0200
Message-ID: <cover.1747268650.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F40151F7B7
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action

Hi,

please pull a few more fixes, thanks.

- fix potential endless loop when discarding a block group when
  disabling discard

- reinstate message when setting a large value of mount option 'commit'

- fix a folio leak when async extent submission fails

----------------------------------------------------------------
The following changes since commit 38e541051e1d19e8b1479a6af587a7884653e041:

  btrfs: open code folio_index() in btree_clear_folio_dirty_tag() (2025-05-02 13:20:56 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc6-tag

for you to fetch changes up to 4ce2affc6ef9f84b4aebbf18bd5c57397b6024eb:

  btrfs: add back warning for mount option commit values exceeding 300 (2025-05-12 21:39:34 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix folio leak in submit_one_async_extent()

Filipe Manana (1):
      btrfs: fix discard worker infinite loop after disabling discard

Kyoji Ogasawara (1):
      btrfs: add back warning for mount option commit values exceeding 300

 fs/btrfs/discard.c | 17 +++++++++++++++--
 fs/btrfs/fs.h      |  1 +
 fs/btrfs/inode.c   |  7 +++++++
 fs/btrfs/super.c   |  4 ++++
 4 files changed, 27 insertions(+), 2 deletions(-)

