Return-Path: <linux-btrfs+bounces-18908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF47C5442F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640D13B74EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2534F261;
	Wed, 12 Nov 2025 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oW/iBKuF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oW/iBKuF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741A34CFD7
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976204; cv=none; b=SPGIttI0HWtQs82bpm6c2Sv8mILrGf7XX1CI63k0gE3aIvWO5MN5piHyCCRbuPGqFFyZ4fYWek5dlnTZnjm9s8cgEXsl+E+tfccQvJlW0YJDg4/eeSU8duvisfGOCmPuuYQHiRj4c1PSZl05FU1LY8kZZoXYQc/Jd2NmBwiAGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976204; c=relaxed/simple;
	bh=l7oyzcEX44cRo2M+qv3VzZOT8MFAZV6c7My6vj4Uucc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9VVcglaJl8ryZAGOOGcLX1gZ+R3E7+JqanC5Gq9Eme9zchnR5Nc5Hf7aZRY6am146B6MSy68wh/e7AXgBvWVdr3vcEUiXOEJLn+CsagZG13DMhSD2XI8Mdx+p8WpU3uEmeA9PuZBkXDu2j3ih2FHiJ8o78ZBhRN41xae0mv+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oW/iBKuF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oW/iBKuF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B27AA21B04;
	Wed, 12 Nov 2025 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762976200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SFk2ToHFrxW+zH55JOOcszH+KxLRNyXEtoCclgwSTlY=;
	b=oW/iBKuFbXBPwxbBAWXeod/IReviSISBnm8VD+nciaU/ZuMzQ9M0gJi7Fa3XLdLA7rDSjh
	55JtHz05oJdQc2sOc6+eQe8UJ1kJROOhdw3aEfJ8AdVGYgBH0QW441qWPFos34QDDLTEQe
	eDz0ncfsQjsmtDmcx0L3eqR4fFozaZc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762976200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SFk2ToHFrxW+zH55JOOcszH+KxLRNyXEtoCclgwSTlY=;
	b=oW/iBKuFbXBPwxbBAWXeod/IReviSISBnm8VD+nciaU/ZuMzQ9M0gJi7Fa3XLdLA7rDSjh
	55JtHz05oJdQc2sOc6+eQe8UJ1kJROOhdw3aEfJ8AdVGYgBH0QW441qWPFos34QDDLTEQe
	eDz0ncfsQjsmtDmcx0L3eqR4fFozaZc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C9C83EA61;
	Wed, 12 Nov 2025 19:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Esm6JcjhFGm+YgAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 12 Nov 2025 19:36:40 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] btrfs: add fscrypt support, PART 1
Date: Wed, 12 Nov 2025 20:36:00 +0100
Message-ID: <20251112193611.2536093-1-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

This is a revive of former work [1] of Omar, Sweet Tea and Josef to bring
native encryption support to btrfs.

It will come in more parts. The first part this time is splitting the simple
and isolated stuff out first to reduce the size of the final patchset.

Changes since v5 [1] are mostly rebase to the latest for-next and cleaning
up the conflicts.

The remaining part needs further cleanup and a bit of redesign and it will
follow later.

[1] https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/

Josef Bacik (6):
  btrfs: add a bio argument to btrfs_csum_one_bio
  btrfs: add orig_logical to btrfs_bio
  btrfs: don't rewrite ret from inode_permission
  btrfs: move inode_to_path higher in backref.c
  btrfs: don't search back for dir inode item in INO_LOOKUP_USER
  btrfs: set the appropriate free space settings in reconfigure

Omar Sandoval (1):
  btrfs: disable various operations on encrypted inodes

Sweet Tea Dorminy (1):
  btrfs: disable verity on encrypted inodes

 fs/btrfs/backref.c   | 68 +++++++++++++++++++++-----------------------
 fs/btrfs/bio.c       | 14 +++++++--
 fs/btrfs/bio.h       |  3 ++
 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/file-item.c | 19 ++++++-------
 fs/btrfs/file-item.h |  2 +-
 fs/btrfs/inode.c     |  4 +++
 fs/btrfs/ioctl.c     | 27 +++---------------
 fs/btrfs/reflink.c   |  7 +++++
 fs/btrfs/super.c     | 28 +++++++++---------
 fs/btrfs/super.h     |  3 +-
 fs/btrfs/verity.c    |  3 ++
 12 files changed, 93 insertions(+), 87 deletions(-)

-- 
2.51.0


