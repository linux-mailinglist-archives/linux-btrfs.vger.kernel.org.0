Return-Path: <linux-btrfs+bounces-2024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46250845EC2
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF82A28A6A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 17:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7267427E;
	Thu,  1 Feb 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N0iChrFj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N0iChrFj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31977426B
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809282; cv=none; b=ESiWeAlZVT2Puvxv372O5ttVXVZQ4zm11TMVP7bMWQjzovd67P2ZZRl1+tW1IhUTI4A631I1hYICOseQKhArcQPYDot5DJtYfAF5O7Ge3ccrt/fs4rIJ0u1MwBeY9NYQd3ZfI6A547M5RC5mW+5SynntaoSacYzksnf4kQ3XF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809282; c=relaxed/simple;
	bh=x4dWBgeZCqS0IX17aaEySl00wMSOM33sp0m9sAkFiPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDit1ewcEw1nSAv01qhF/7D32dLL/jyD6XYhFkFiTPPa+f+xPYoxQv1obs0NBtoC6Br1vMx4oJpDo6XdUcFg3UTIB1bDDMg5+z1E1solElwJrfyEBoFFXw3O2hfIlBm9Qx53EG45PQWjUgLyZnYX5oeT4LNzfkKiQbVe2EWXBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N0iChrFj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N0iChrFj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2EA2621EB6;
	Thu,  1 Feb 2024 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706809279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruCfxNxQw74qOUqQ40Y3VPN8tRjbg9jPqjT4m3/TtuE=;
	b=N0iChrFj4lP9jdZk+GhaeYSEDGI5uMfiIE30tHI+Ni6Plr8vhQQdLGQObNNEpOd89nOhET
	4oEHnBUxibuPcTI8BKlO6JtCUw1n2F3r+pwIIih2DrP4ifcoA/JCamv8jsYvXVLii8CUAf
	HcD4pU+diisVUXlW5x/4F6LOMIFkmM8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706809279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ruCfxNxQw74qOUqQ40Y3VPN8tRjbg9jPqjT4m3/TtuE=;
	b=N0iChrFj4lP9jdZk+GhaeYSEDGI5uMfiIE30tHI+Ni6Plr8vhQQdLGQObNNEpOd89nOhET
	4oEHnBUxibuPcTI8BKlO6JtCUw1n2F3r+pwIIih2DrP4ifcoA/JCamv8jsYvXVLii8CUAf
	HcD4pU+diisVUXlW5x/4F6LOMIFkmM8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 235CB13594;
	Thu,  1 Feb 2024 17:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9D42CL/Xu2WOSwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 17:41:19 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Include updates and cleanups
Date: Thu,  1 Feb 2024 18:40:51 +0100
Message-ID: <cover.1706808903.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Another step to do the header files properly so we can possibly remove
dependencies, not pull headers unless needed.

The changes are grouped to be roughly the same size, I went through the
files from smallest to largest and did a full build test at some point.

David Sterba (3):
  btrfs: add forward declarations and headers, part 1
  btrfs: add forward declarations and headers, part 2
  btrfs: add forward declarations and headers, part 3

 fs/btrfs/accessors.h        | 11 +++++++++-
 fs/btrfs/acl.h              | 11 ++++++++++
 fs/btrfs/async-thread.h     |  3 +++
 fs/btrfs/backref.h          | 16 ++++++++++++--
 fs/btrfs/bio.h              |  2 ++
 fs/btrfs/block-group.h      | 13 ++++++++++++
 fs/btrfs/block-rsv.h        |  7 +++++++
 fs/btrfs/btrfs_inode.h      | 19 +++++++++++++++++
 fs/btrfs/compression.h      | 10 +++++++--
 fs/btrfs/ctree.h            | 25 +++++++++++-----------
 fs/btrfs/defrag.h           | 10 +++++++++
 fs/btrfs/delalloc-space.h   |  4 ++++
 fs/btrfs/delayed-inode.h    |  8 +++++++
 fs/btrfs/delayed-ref.h      | 10 +++++++++
 fs/btrfs/dev-replace.h      |  4 ++++
 fs/btrfs/dir-item.h         |  6 ++++++
 fs/btrfs/disk-io.h          | 20 ++++++++++++++----
 fs/btrfs/export.h           |  4 ++++
 fs/btrfs/extent-io-tree.h   |  7 +++++++
 fs/btrfs/extent-tree.h      | 10 +++++++++
 fs/btrfs/extent_io.h        | 25 +++++++++++++++++-----
 fs/btrfs/extent_map.h       |  8 +++++++
 fs/btrfs/file-item.h        | 11 ++++++++++
 fs/btrfs/file.h             | 15 +++++++++++++
 fs/btrfs/free-space-cache.h | 13 ++++++++++++
 fs/btrfs/free-space-tree.h  |  6 ++++++
 fs/btrfs/fs.h               | 42 +++++++++++++++++++++++++++++++++++--
 fs/btrfs/inode-item.h       |  5 +++--
 fs/btrfs/ioctl.h            |  9 ++++++++
 fs/btrfs/locking.h          |  8 +++++--
 fs/btrfs/lru_cache.h        |  2 ++
 fs/btrfs/misc.h             |  2 ++
 fs/btrfs/ordered-data.h     | 15 +++++++++++++
 fs/btrfs/orphan.h           |  5 +++++
 fs/btrfs/print-tree.h       |  3 +++
 fs/btrfs/props.c            |  1 +
 fs/btrfs/props.h            |  7 ++++++-
 fs/btrfs/qgroup.h           | 17 +++++++++++----
 fs/btrfs/raid-stripe-tree.h |  5 +++++
 fs/btrfs/raid56.h           |  9 ++++++++
 fs/btrfs/rcu-string.h       |  6 ++++++
 fs/btrfs/ref-verify.h       |  9 ++++++++
 fs/btrfs/reflink.h          |  4 +++-
 fs/btrfs/relocation.h       |  9 ++++++++
 fs/btrfs/root-tree.h        | 10 +++++++++
 fs/btrfs/scrub.h            |  6 ++++++
 fs/btrfs/send.h             |  8 ++++---
 fs/btrfs/space-info.h       |  9 ++++++++
 fs/btrfs/subpage.h          |  5 +++++
 fs/btrfs/super.h            |  7 +++++++
 fs/btrfs/sysfs.h            |  9 ++++++++
 fs/btrfs/transaction.h      | 17 ++++++++++++++-
 fs/btrfs/tree-checker.h     |  2 ++
 fs/btrfs/tree-log.h         |  8 +++++++
 fs/btrfs/tree-mod-log.h     |  8 ++++++-
 fs/btrfs/ulist.h            |  1 +
 fs/btrfs/uuid-tree.h        |  5 +++++
 fs/btrfs/verity.h           |  7 +++++++
 fs/btrfs/volumes.h          | 25 ++++++++++++++++------
 fs/btrfs/xattr.h            |  6 +++++-
 fs/btrfs/zoned.h            | 15 +++++++++++++
 61 files changed, 533 insertions(+), 51 deletions(-)

-- 
2.42.1


