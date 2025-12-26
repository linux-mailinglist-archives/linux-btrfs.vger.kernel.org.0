Return-Path: <linux-btrfs+bounces-20011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F49CDE567
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 06:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71395300B985
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 05:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558A241CA2;
	Fri, 26 Dec 2025 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kw5XV9et";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kw5XV9et"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8E23FC41
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766726001; cv=none; b=I1djiZH5vP1EkCaFKnSfHh2b6z8YATIogBOWquxHdskFKp+nkAreK/y0Eu28MDuWdeO8Dtgl9AmtUfJj618HLp9MlD4q9GNhU40dQkLi/4BD+TYR/dMGT6tBUXJsGBGWcZ00bYCjmEc6YdBWjm1o9uNrDEjLiNRdM0Eg+Gt0dmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766726001; c=relaxed/simple;
	bh=KBmGjKsKshfKpwNq6j3lx47pysNQtcXnKl8f1D11+WU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ux7rXIgg/lfe1PFmvYFjxEQ+JQexXLrQHrGSSQ0RV5kvFX/0gBVjqJwLDnY8NDzpTPgttssY/c/BrQ4wd4Gt6N6I6rIoHgojdWx8hjUcZjoiZzhp5/IfgI7G1scq3+aAk37f8Ph3fuBovCI4K6G3r+4ACvQMvrkpW88KRJpBFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kw5XV9et; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kw5XV9et; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 555805BCCB
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766725996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Dcd+PYtXXDAL8Ffio3K5cfLAotzO+1wOSJKRTPTQBfA=;
	b=Kw5XV9etBE5nz0rUqJnMK0Gu0vDyNUv0HEitzU2i5oH4A4AxPaCuRfnQzw/EqqEuTspx8z
	q1Ynt/dtd9ZtJwgANSI2QJGixrjyiDl+68emK/lVW0hG6DRXqSI3Zh0J7DVRfWyru9W54x
	4AJoZURQpnKoW9xOKvtiS+/mQm7bpDQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766725996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Dcd+PYtXXDAL8Ffio3K5cfLAotzO+1wOSJKRTPTQBfA=;
	b=Kw5XV9etBE5nz0rUqJnMK0Gu0vDyNUv0HEitzU2i5oH4A4AxPaCuRfnQzw/EqqEuTspx8z
	q1Ynt/dtd9ZtJwgANSI2QJGixrjyiDl+68emK/lVW0hG6DRXqSI3Zh0J7DVRfWyru9W54x
	4AJoZURQpnKoW9xOKvtiS+/mQm7bpDQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 886DC3EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v/DQEmsZTmn1DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: introduce seperate structure to avoid
Date: Fri, 26 Dec 2025 15:42:46 +1030
Message-ID: <cover.1766725912.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.71
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.11)[-0.529];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

The structure btrfs_file_extent_item is defined that if one file extent
is inlined, the data starts after btrfs_file_extent_item::type, aka,
overlapping with btrfs_file_extent_item::disk_bytenr and other members.

This makes it harder to understand btrfs on-disk format.

This also requires every user of btrfs_file_extent_item::disk_bytenr and
other non-inline members to check btrfs_file_extent_item::type first.

But not all callers are strictly following that, and when
access-beyond-boundary happens, we have no built-in checks to catch
them.

This series address the problem by:

- Introduce btrfs_file_header structure to define the shared part
  Initially I'm planning to use ms-extension to define an unnamed
  structure inside btrfs_file_extent_item, to avoid duplicated
  definition, but it doesn't work for arm64.

  So have to do duplicated definition.

- Introduce btrfs_file_header_*() helpers for the shared members

- Introduce btrfs_file_header_disk_bytenr() for btrfs_file_extent_item
  This allows using the same btrfs_file_header pointer to access the
  btrfs_file_extent_item exclusive members, with built-in ASSERT() to
  catch incorrect types.

- Convert existing btrfs_file_extent_item pointer users to
  btrfs_file_header
  This also reduce the lifespan of those pointers to minimal,
  e.g. only define them in the minimal scope, even if it means to define
  such pointer again and again in different scopes.

  There are some exceptions:

  * On-stack ones are still using btrfs_file_extent_item

  * Certain write paths are still using btrfs_file_extent_item pointer
    Those sites are known to handling non-inlined extents, thus
    can still use the old pointer, but not recommended anymore.

Qu Wenruo (7):
  btrfs: introduce btrfs_file_header structure
  btrfs: use btrfs_file_header structure for tree-checker
  btrfs: use btrfs_file_header structure for trace events
  btrfs: use btrfs_file_header structure for inode.c
  btrfs: use btrfs_file_header structure for simple usages
  btrfs: use btrfs_file_header structure for file.c
  btrfs: use btrfs_file_header structure for send.c and tree-log.c

 fs/btrfs/accessors.h            |  79 +++++++++++++
 fs/btrfs/backref.c              |  36 +++---
 fs/btrfs/ctree.c                |  33 +++---
 fs/btrfs/defrag.c               |   8 +-
 fs/btrfs/extent-tree.c          |  26 ++--
 fs/btrfs/fiemap.c               |  30 ++---
 fs/btrfs/file-item.c            |  26 ++--
 fs/btrfs/file-item.h            |  23 ++--
 fs/btrfs/file.c                 | 204 ++++++++++++++++----------------
 fs/btrfs/inode-item.c           |  47 ++++----
 fs/btrfs/inode.c                | 151 ++++++++++++-----------
 fs/btrfs/print-tree.c           |  28 ++---
 fs/btrfs/qgroup.c               |  11 +-
 fs/btrfs/reflink.c              |  34 +++---
 fs/btrfs/relocation.c           |  42 +++----
 fs/btrfs/send.c                 | 145 +++++++++++------------
 fs/btrfs/tree-checker.c         |  82 ++++++-------
 fs/btrfs/tree-log.c             |  70 +++++------
 include/trace/events/btrfs.h    |  58 ++++-----
 include/uapi/linux/btrfs_tree.h |  61 ++++++----
 20 files changed, 643 insertions(+), 551 deletions(-)

-- 
2.52.0


