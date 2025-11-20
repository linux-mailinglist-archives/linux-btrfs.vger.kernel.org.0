Return-Path: <linux-btrfs+bounces-19168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3ADC717E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 01:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3643829756
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 00:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B93C2F;
	Thu, 20 Nov 2025 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KSjBMKu7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KSjBMKu7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309C186A
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597096; cv=none; b=cwUpSg0O2REK61C7oFPvxj2h45pieihO9nys/Sx0V96/B6butRlHboHc3Hvr7vMKXrijIOJsITdE/sZX9Lja4dhrmq7B9zHdHQXTigPWB9CCSnC6VmYfm2A65GFXJkcUlvADHCydys3FrcWkjoPLzB4e6VNxReWSHHYLk2vwDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597096; c=relaxed/simple;
	bh=ekH7F3zJN/hK5k35pTy6Q+U57Oh8WLEhbd5YlusejSw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EJBCS9Bvuqsr26+bcScJwby8RGXa9frigc2UEjdhtEo54vWLUPUaJQ8xk5zql6IxHVCFGTbMMsVFP3MKm1PkNKg/72k4KYQKAgkrG9ZyqD0+A3IRE/wAk/cyLNFWjpZnLQtqyb6+mdvCNa2/DO3xEZwECStZL4p+fDCjyf5v580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KSjBMKu7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KSjBMKu7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF54F20732
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763597091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNFx1aGArvYOWrOA3BkfWw14ka5tdelkRAueLs4nPOA=;
	b=KSjBMKu7y5+r4KZ1irQLXKBctVEFPNc6jUbUHL0T2MRwh1NyGHQ5QOpR6tDNl7Ztr8hMHS
	s8xO0y7HOrITthiD4G0M16SW67qVY0Y/t76RwhicvlhObXcV+55ATklH6cVv7OcJmSrNAm
	OFjqMeetxkkkPTlzc091/DNUG5dPTNU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763597091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNFx1aGArvYOWrOA3BkfWw14ka5tdelkRAueLs4nPOA=;
	b=KSjBMKu7y5+r4KZ1irQLXKBctVEFPNc6jUbUHL0T2MRwh1NyGHQ5QOpR6tDNl7Ztr8hMHS
	s8xO0y7HOrITthiD4G0M16SW67qVY0Y/t76RwhicvlhObXcV+55ATklH6cVv7OcJmSrNAm
	OFjqMeetxkkkPTlzc091/DNUG5dPTNU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 081323EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fbcDLyJbHmkwFgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: reduce btrfs_get_extent() calls for buffered write path
Date: Thu, 20 Nov 2025 10:34:29 +1030
Message-ID: <cover.1763596717.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.22 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_SPAM_SHORT(2.82)[0.939];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.22
X-Spam-Level: 

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

The first 3 patches are just minor cleanups/refactors, the last patch
is the real optimization.

I don't expect there will be much difference in the real world though.

Qu Wenruo (4):
  btrfs: integrate the error handling of submit_one_sector()
  btrfs: use bitmap_set() to replace set_bit() in a loop
  btrfs: extract the io finishing code into a helper
  btrfs: reduce extent map lookup during writes

 fs/btrfs/extent_io.c | 243 ++++++++++++++++++++++++-------------------
 1 file changed, 134 insertions(+), 109 deletions(-)

-- 
2.52.0


