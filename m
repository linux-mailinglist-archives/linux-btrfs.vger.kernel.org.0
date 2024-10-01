Return-Path: <linux-btrfs+bounces-8406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AEE98C965
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 01:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D40B2209E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 23:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0D21CEE83;
	Tue,  1 Oct 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hy3nRde5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hy3nRde5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D01A08B2
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824697; cv=none; b=gmZofZ9QgskTOVeODoXpokIPItouTWZJKrO+D/tGTo/IznyoN5Rgr9wJCi1fzlZ23AoiBIyEU8xLDVc985xH/EdJj/TnyX2oYL/y7yWjqJU71aRurFFaLGRr19Ey1QUeCcmtF5NUeJh5hN2H8E9p40pG+WSrC9D0Uueu5CfTKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824697; c=relaxed/simple;
	bh=46aiK6Z4K/tgbO++3LDY2wnFFbf875SebsTLPkiVBMc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U7CDt+++SJUrkIB+0m6/hnYFlsQvzWsSf9LxbENuUWpGGhuqOnc0uOgrtX1AsD+Dx9GwtBuIgCqtzkVFUkYaFUN9PVrx28dKPDpCtvWC1Uru+8pSpDjkaXfH4VmMOH6bKEPQQ+mXEDWJ2NVlZfrLO44SoF1JKq9XhuJ3k6idIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hy3nRde5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hy3nRde5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CD8B1FCFC
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 23:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727824692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WSmN/yF1czG7Pdrq5kGZLl3FqcQY4QqmP2ISXvqRbfE=;
	b=Hy3nRde5avuvcEVg0k5wvK1zEBwXs47/lZTZ9/D/MjZNbf4WEEq9j3GdRfV3Z/aX+vpKy4
	gbAWwllc4bXbJsXkoY+2aB2MRwJ2UpdI/umfYRhkfjqEyUSiTyN58CDj4GlUs4WyXcPTER
	L5CRe3u0uaFDy83u1XAUQ9Om2u7kf4s=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Hy3nRde5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727824692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WSmN/yF1czG7Pdrq5kGZLl3FqcQY4QqmP2ISXvqRbfE=;
	b=Hy3nRde5avuvcEVg0k5wvK1zEBwXs47/lZTZ9/D/MjZNbf4WEEq9j3GdRfV3Z/aX+vpKy4
	gbAWwllc4bXbJsXkoY+2aB2MRwJ2UpdI/umfYRhkfjqEyUSiTyN58CDj4GlUs4WyXcPTER
	L5CRe3u0uaFDy83u1XAUQ9Om2u7kf4s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AA4E13A6E
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 23:18:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yu8DFzOD/GbILgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 23:18:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: small cleanups to buffered write path
Date: Wed,  2 Oct 2024 08:47:47 +0930
Message-ID: <cover.1727824586.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5CD8B1FCFC
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[CHANGELOG]
v3:
- Remove the read: tag of the second patch
  By merging the alignment and force_uptodate checks into one check.

v2:
- Utilize folio APIs instead of the old page APIs for the 2nd patch

These two are small cleanups to the buffered write path, inspired by the
btrfs test failure of generic/563 with 4K sector size and 64K page size.

The root cause of that failure is, btrfs can't avoid full page read when
the dirty range covers sectors, but not yet the full page.

This is only the preparation part, we can not yet switch to the skip the
full page read, or it will still lead to incorrect data.

The full fix needs extra co-operation between the subpage read and
write, until then prepare_uptodate_page() still needs to read the full
page.

Qu Wenruo (2):
  btrfs: remove the dirty_page local variable
  btrfs: simplify the page uptodate preparation for prepare_pages()

 fs/btrfs/file.c             | 84 ++++++++++++++++++-------------------
 fs/btrfs/file.h             |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 3 files changed, 43 insertions(+), 45 deletions(-)

-- 
2.46.2


