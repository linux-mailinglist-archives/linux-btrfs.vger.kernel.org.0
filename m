Return-Path: <linux-btrfs+bounces-19208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1089AC73185
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 10:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E77212FF53
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B352D0298;
	Thu, 20 Nov 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mpZCavp5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qL1Kq/P+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDC372AA2
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630233; cv=none; b=FMLNu+9NKqrbF/Ec3EL0DUI+N7qSDccaUFY68EnsUhwtSPAG3xTtsWj0dfakdzQNiMuFylRO/l4wUE+R74fCPwu/eFdG/sJRmxBPz1gndbshJs1RvhXYiZ3sabExj/ISnX3QqUdgWXWjt/0kGNbUdBVfp7GYG4STFE0x+H5USXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630233; c=relaxed/simple;
	bh=CZqOCYwS7ktE0W3/T+UFAwjnOhXo9lgxRUROQA8qBH0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jdZGCfPQtuPUciZExiksCi6Fjnc7Q4in9qq/gfG74vYVQBIGXu/hdsu2oqE68UPYz2rWL4FLP00u/eU5FFqzMBRdR65vkokYfeKvSAnK6lYLrVU2H68GyRqEUN10fZpcovNuWKE6at7/hL1mghKiXTOvLYefaeevLgS4fLt2SXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mpZCavp5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qL1Kq/P+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDF7421266
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763630228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=230disXH3T9XJTaKQJkfHwDmX8w/gsireaeAq1SsePQ=;
	b=mpZCavp5r0uBxPbYEguuNXbICQP6G3I5PoKYnjIAIeqksZFRy7uDZDGr7HJb3OyW3omUV0
	RES/Y6Axo6m/jeRHEAu4NShwORh1cg6E3ihka+6vsHoefe+NXTWgkwPsnNGdT3QbQ8V7vm
	DLYx73hvSyHtMIUZZrQyLjA+yRNwI6k=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="qL1Kq/P+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763630227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=230disXH3T9XJTaKQJkfHwDmX8w/gsireaeAq1SsePQ=;
	b=qL1Kq/P+voZ5KteL9LoC+hjG2vJ1ksJ4TdCspCr/BCXxFgkVL4+Ie4fjlgAwUgWg6ofwBV
	FRiKbmzj6W6sXGNx8/Kv26j6C9cGvYHxxUJ+tLwtX/5vEQ9x491auFfVONpt0J+rbNZFyW
	ZQhbRXu61sTQACEPVnq1BTjZn+XTg14=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C2523EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 09:17:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FSnGL5LcHmn9FQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 09:17:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/4] btrfs: reduce btrfs_get_extent() calls for buffered write path
Date: Thu, 20 Nov 2025 19:46:45 +1030
Message-ID: <cover.1763629982.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DDF7421266
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[CHANGELOG]
v3:
- Use @cur_len for btrfs_get_extent() in the last patch
  And remove the hole related comment.
  This should not cause any behavior change.

  The @len parameter for btrfs_get_extent() is only going to cause a
  difference when the range is completely a hole (e.g. beyond EOF).

  For our writeback routine, there should be an extent map for us thus
  it's no different passing @cur_len or sectorsize.

  I think this @len parameter of btrfs_get_extent() is causing
  unnecessary complexity, and want to remove it completely. But that
  will be a new series.

v2:
- Fix a potential bug where OEs beyond EOF are not truncated properly
  This replace the original patch to extract the code into a helper.

- Replace more for_each_set_bit() with for_each_set_bitrange()

- Fix several copy-n-pasted incorrect range inside submit_range()


Although btrfs has bs < ps support for a long time, and the larger data
folios support is also going to be graduate from experimental features
soon, the write path is still iterating each fs block and call
btrfs_get_extent() on each fs block.

What makes the situation worse is that, for the write path we do not
have any cached extent map, meaning even with large folios and we got a
continuous range that can be submitted in one go, we still call
btrfs_get_extent() many times and get the same range extent map again
and again.

This series will reduce the duplicated btrfs_get_extent() calls by only
call it once for each range, other than for each fs block.

The first one is a potential bug inspired by Boris' review.
Patch 2~3 are minor cleanups.
Patch 4 is the core of the optimization.

Although I don't expect there will be much difference in the real world though.


Qu Wenruo (4):
  btrfs: make sure all ordered extents beyond EOF is properly truncated
  btrfs: integrate the error handling of submit_one_sector()
  btrfs: replace for_each_set_bit() with for_each_set_bitmap()
  btrfs: reduce extent map lookup during writes

 fs/btrfs/extent_io.c    | 230 ++++++++++++++++++++--------------------
 fs/btrfs/ordered-data.c |  38 +++++++
 fs/btrfs/ordered-data.h |   2 +
 3 files changed, 156 insertions(+), 114 deletions(-)

-- 
2.52.0


