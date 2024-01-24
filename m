Return-Path: <linux-btrfs+bounces-1742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CBF83B3B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD52B21FB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FEA1350F8;
	Wed, 24 Jan 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N0nPN1Dh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N0nPN1Dh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A27E760
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131090; cv=none; b=PPDWsGl4OM6qchczElmdqCFDX3MCUaoLK2bOlXsRBvGOUFuC4F1cMU4i4cdhn+h80pdlNw5nGZETUaWOmzSpyLv8jKlgWL70/WhHRYeoy4uhIyTuEQ3O7GBJCFpNtdP0NGb+VR6bwISWTrT5QuuWnqfsre0wbV9z/Pl2xNgMYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131090; c=relaxed/simple;
	bh=C+krvjIZcCyuQVr0nzGKMSxPbIN5/zB7kQxJoZKpDvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUhqkJeuv4tzwaHv0zXBtJVsTX2Ju3R5FEG/lxgGC0i8WyDRgaSLMaTkILEyIm6joKbkB3LVcfymYoEQS90Aar0bztULXwXwn3q2Ggthmld4FlDJCv/rJW520uTxioH0jHU5sIqefHMuuELqCrW/Ke4N/yW92iONfW/YrgyD+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N0nPN1Dh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N0nPN1Dh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C6DF1FD92;
	Wed, 24 Jan 2024 21:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3X7Kb4a0/i1k3W5u39oxFoH9YJIDhMn3Q4gh02w4Qbk=;
	b=N0nPN1DhbMCAoa13L0g5FGt9BP6M7T0WjjHt/Sq/3HUhFsyRPAdNYoWd1pnlBsnUk8cgpP
	oe1ULdX4MxNHLL0IrtZetqdzrmI/3qGvsr1gUAP5wW8ni14UDgw2Vu2fnREI6WwuqOXJEQ
	YVaOhfTzq6IRs9jPztAoGSFwtSMWB0g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3X7Kb4a0/i1k3W5u39oxFoH9YJIDhMn3Q4gh02w4Qbk=;
	b=N0nPN1DhbMCAoa13L0g5FGt9BP6M7T0WjjHt/Sq/3HUhFsyRPAdNYoWd1pnlBsnUk8cgpP
	oe1ULdX4MxNHLL0IrtZetqdzrmI/3qGvsr1gUAP5wW8ni14UDgw2Vu2fnREI6WwuqOXJEQ
	YVaOhfTzq6IRs9jPztAoGSFwtSMWB0g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0491A13786;
	Wed, 24 Jan 2024 21:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cs8ZAY9+sWWUdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:07 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/20] Error handling fixes
Date: Wed, 24 Jan 2024 22:17:35 +0100
Message-ID: <cover.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Get rid of some easy BUG_ONs, there are a few groups fixing the same
pattern. At the end there are three patches that move transaction abort
to the right place. I have tested it on my setups only, not the CI, but
given the type of fix we'd never hit any of them without special
instrumentation.

David Sterba (20):
  btrfs: handle directory and dentry mismatch in btrfs_may_delete()
  btrfs: handle invalid range and start in merge_extent_mapping()
  btrfs: handle block group lookup error when it's being removed
  btrfs: handle root deletion lookup error in btrfs_del_root()
  btrfs: handle invalid root reference found in btrfs_find_root()
  btrfs: handle invalid root reference found in btrfs_init_root_free_objectid()
  btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
  btrfs: handle invalid extent item reference found in check_committed_ref()
  btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
  btrfs: delayed-inode: drop pointless BUG_ON in __btrfs_remove_delayed_item()
  btrfs: change BUG_ON to assertion when checking for delayed_node root
  btrfs: defrag: change BUG_ON to assertion in btrfs_defrag_leaves()
  btrfs: change BUG_ON to assertion in btrfs_read_roots()
  btrfs: change BUG_ON to assertion when verifying lockdep class setup
  btrfs: change BUG_ON to assertion when verifying root in btrfs_alloc_reserved_file_extent()
  btrfs: change BUG_ON to assertion in reset_balance_state()
  btrfs: unify handling of return values of btrfs_insert_empty_items()
  btrfs: move transaction abort to the error site in btrfs_delete_free_space_tree()
  btrfs: move transaction abort to the error site in btrfs_create_free_space_tree()
  btrfs: move transaction abort to the error site btrfs_rebuild_free_space_tree()

 fs/btrfs/block-group.c     |  4 ++-
 fs/btrfs/ctree.c           |  4 +++
 fs/btrfs/defrag.c          |  2 +-
 fs/btrfs/delayed-inode.c   |  4 +--
 fs/btrfs/disk-io.c         | 11 ++++++--
 fs/btrfs/export.c          |  9 +++++-
 fs/btrfs/extent-tree.c     | 11 ++++++--
 fs/btrfs/extent_map.c      |  9 +++---
 fs/btrfs/file-item.c       |  3 --
 fs/btrfs/free-space-tree.c | 56 ++++++++++++++++++++++----------------
 fs/btrfs/ioctl.c           |  4 ++-
 fs/btrfs/locking.c         |  2 +-
 fs/btrfs/root-tree.c       | 16 +++++++++--
 fs/btrfs/uuid-tree.c       |  2 +-
 fs/btrfs/volumes.c         | 14 ++++++++--
 15 files changed, 102 insertions(+), 49 deletions(-)

-- 
2.42.1


