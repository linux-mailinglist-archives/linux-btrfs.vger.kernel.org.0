Return-Path: <linux-btrfs+bounces-19101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB81DC6A8CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C6054F2C70
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237D36B057;
	Tue, 18 Nov 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VNW82bH7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VNW82bH7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890B31A810
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482135; cv=none; b=u2gLxhgR15Q1xqbICzZcVkGnnhzoqOFX/7WBfCUnjHrfIDk97DoQzbL4YLO3mlekCLSU1VgzPCo4vwi+3llSfYp9H5l3gPmkjatfEvi2Q2P0lFGvXUaxE3GFOZBZ/l3qFIO/D6rUR9h8XobR34QvbwJWhlsxm0gAfUhPSuA5c6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482135; c=relaxed/simple;
	bh=qQNxbrPJgckfxl5XEzf9AC+vQWWpW1+4JFGp7mTmgRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGoG363JlK1XpENGNg1nFKi7mlvPgcS/nzYq6YmNhgInTaCPXFeyGeP+QjoXnFPwRTHwzyas90Djjqd7jWxb6sMtNv0b0n9VSNcvHt/zFBkwICRtsuumqlpUflqXZWOAiTvyCs08Yv4X/b4w/z28wdGryFi81fd/rDRihCxrLgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VNW82bH7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VNW82bH7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 558251FF89;
	Tue, 18 Nov 2025 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZN8hz8qH0kyaqIpHFb2FDOim+tbb3QcWxi70pd8Ptz8=;
	b=VNW82bH7ei1p6dvCeqczcQNOj43VcsL6024u4tRD/STn59//wiMejx/xZavh8HsRKlI9pB
	qnfp7qY37ZuZgx9HJQESg48ml7psf8RjSCHT9tkuB41Yrq0E7OBze5PwO7sYtxChUwlcY9
	wQMbCJ3Z1F74CUK80Onx5ON1jy2pjHU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZN8hz8qH0kyaqIpHFb2FDOim+tbb3QcWxi70pd8Ptz8=;
	b=VNW82bH7ei1p6dvCeqczcQNOj43VcsL6024u4tRD/STn59//wiMejx/xZavh8HsRKlI9pB
	qnfp7qY37ZuZgx9HJQESg48ml7psf8RjSCHT9tkuB41Yrq0E7OBze5PwO7sYtxChUwlcY9
	wQMbCJ3Z1F74CUK80Onx5ON1jy2pjHU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C4143EA61;
	Tue, 18 Nov 2025 16:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MrIoDhSaHGlnYQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 18 Nov 2025 16:08:52 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/6] btrfs: add fscrypt support, PART 1
Date: Tue, 18 Nov 2025 17:08:37 +0100
Message-ID: <20251118160845.3006733-1-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

This is a revive of former work [1] of Omar, Sweet Tea and Josef to bring
native encryption support to btrfs.

It will come in more parts. The first part this time is splitting the simple
and isolated stuff out first to reduce the size of the final patchset.

Changes:
 * v8 - Clean my mistakenly added Signed-off-by:
 * v7 - Drop the checksum patch for now. It will make more sense later.
      - Drop the btrfs/330 fix. It seems no longer needed after the years.
 * v6 vs v5 [1] is mostly rebase to the latest for-next and cleaning up the
   conflicts.

The remaining part needs further cleanup and a bit of redesign and it will
follow later.

[1] https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/

Josef Bacik (4):
  btrfs: add orig_logical to btrfs_bio
  btrfs: don't rewrite ret from inode_permission
  btrfs: move inode_to_path higher in backref.c
  btrfs: don't search back for dir inode item in INO_LOOKUP_USER

Omar Sandoval (1):
  btrfs: disable various operations on encrypted inodes

Sweet Tea Dorminy (1):
  btrfs: disable verity on encrypted inodes

 fs/btrfs/backref.c   | 68 +++++++++++++++++++++-----------------------
 fs/btrfs/bio.c       | 10 +++++++
 fs/btrfs/bio.h       |  2 ++
 fs/btrfs/file-item.c |  2 +-
 fs/btrfs/inode.c     |  4 +++
 fs/btrfs/ioctl.c     | 27 +++---------------
 fs/btrfs/reflink.c   |  7 +++++
 fs/btrfs/verity.c    |  3 ++
 8 files changed, 63 insertions(+), 60 deletions(-)

-- 
2.51.0


