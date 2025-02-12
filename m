Return-Path: <linux-btrfs+bounces-11415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32553A330A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 21:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D943A636F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144CF201253;
	Wed, 12 Feb 2025 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LLacWD52";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JaMAfPH4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE420103D
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391713; cv=none; b=jXOrMfg2wxoUuAZX91nEwFJbh0EV/rauA7AMKopsNvPBW2bvBJXMoEBc0qKK4CXV8oglgDl/jO5tHu9mm8gxHP/Ze9j2qHE7ttoJPsG3Z1PKBtoDZ2I6GBL/YLRJx40YrVsNC3AC9SiR25JJSGx1wRmzeFqPrRvp+t9fbIGEwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391713; c=relaxed/simple;
	bh=9WA+FLaYu0BsuBQByxmQGsrado3mAboTRzvAUi2133I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2ZaizqdCoHOwRkO6/yIvxw0G9nRZpLrEzf8NWAt5jj1o6sjjIBkCE4jt17j7U0SffjLtgPT9uOZsV8o3TfhxmTGnVQTriqu2Z8e/dD7Dzjl0kjCTl4re+m/P19DkPnUH9+J1jzuR1FX+VcY7zbp1qE88MU+fInT7Z7e2FN/nDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LLacWD52; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JaMAfPH4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E459337B7;
	Wed, 12 Feb 2025 20:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YBBipIogAOa1AlF4qDyFHQWktzPcsEPFR+J+NM9Tdew=;
	b=LLacWD52ELajdycE8G2DgoXaH3U9apPBp+853Nx2gt4IZdZZMU0SMPZkGrUpts0cH0p/uv
	o4f8OcUFCvcEx5u/W01h8lRlo2+dZCaqAFt5pJ88Iki42mcJCkP7FnT1zgbA+RFBX3Y9E0
	UkYRH1TsniwOkdLSiYoczbKqQK7TJGo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YBBipIogAOa1AlF4qDyFHQWktzPcsEPFR+J+NM9Tdew=;
	b=JaMAfPH4jVROTEc2WAupngPpAMwzAgacFDDQmdxCM2gpgIMUoxweCnEAGQgmTdcQCRPoHA
	XP86n8iVWBJEVlpWkxIy3s4Y5Kar8MctUk16RVSozM+wdxeznkmkFp9arvioKra4xF59D7
	uvhpFv/hykE9Icu0FzT3bKYoOTeWq8I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02D5D13AEF;
	Wed, 12 Feb 2025 20:21:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2p5qANwCrWeEJgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Feb 2025 20:21:48 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/7] Cleanups for 6.15
Date: Wed, 12 Feb 2025 21:21:41 +0100
Message-ID: <cover.1739391605.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

David Sterba (7):
  btrfs: add __cold attribute to extent_io_tree_panic()
  btrfs: async-thread: switch local variables need_order bool
  btrfs: zstd: move zstd_parameters to the workspace
  btrfs: zstd: remove local variable for storing page offsets
  btrfs: unify ordering of btrfs_key initializations
  btrfs: simplify returns and labels in btrfs_init_fs_root()
  btrfs: update include and forward declarations in headers

 fs/btrfs/accessors.h        |  1 +
 fs/btrfs/acl.h              |  2 ++
 fs/btrfs/async-thread.c     | 11 +++++------
 fs/btrfs/backref.c          |  4 ++--
 fs/btrfs/block-group.c      |  6 +++---
 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/delayed-ref.h      |  2 ++
 fs/btrfs/dir-item.h         |  1 +
 fs/btrfs/direct-io.h        |  2 ++
 fs/btrfs/discard.h          |  1 +
 fs/btrfs/disk-io.c          | 11 +++++------
 fs/btrfs/export.c           |  2 +-
 fs/btrfs/extent-io-tree.c   |  8 ++++----
 fs/btrfs/extent-tree.c      |  8 ++++----
 fs/btrfs/extent-tree.h      |  1 -
 fs/btrfs/file-item.c        | 13 +++++++------
 fs/btrfs/file-item.h        |  2 ++
 fs/btrfs/file.h             |  2 ++
 fs/btrfs/free-space-cache.c |  8 ++++----
 fs/btrfs/fs.c               |  1 -
 fs/btrfs/inode-item.c       |  6 +++---
 fs/btrfs/inode.c            |  8 ++++----
 fs/btrfs/ioctl.c            |  4 ++--
 fs/btrfs/ioctl.h            |  2 ++
 fs/btrfs/locking.c          |  1 -
 fs/btrfs/ordered-data.h     |  1 +
 fs/btrfs/print-tree.h       |  2 ++
 fs/btrfs/props.h            |  1 +
 fs/btrfs/qgroup.c           |  2 +-
 fs/btrfs/qgroup.h           |  3 +++
 fs/btrfs/raid-stripe-tree.h |  1 +
 fs/btrfs/scrub.c            |  4 ++--
 fs/btrfs/send.c             |  1 -
 fs/btrfs/space-info.c       |  2 +-
 fs/btrfs/subpage.c          |  1 -
 fs/btrfs/sysfs.h            |  1 +
 fs/btrfs/transaction.c      |  2 +-
 fs/btrfs/tree-log.c         |  6 +++---
 fs/btrfs/volumes.c          | 16 ++++++++--------
 fs/btrfs/volumes.h          |  4 ++++
 fs/btrfs/xattr.h            |  2 ++
 fs/btrfs/zstd.c             | 14 ++++++--------
 42 files changed, 97 insertions(+), 75 deletions(-)

-- 
2.47.1


