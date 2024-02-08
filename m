Return-Path: <linux-btrfs+bounces-2224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841BC84DC2D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F251C22B82
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C187F6A8D2;
	Thu,  8 Feb 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aoL3VBnt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aoL3VBnt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CBB69E1E
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382804; cv=none; b=Kj7gNfHrZzhPjtfL0m8x9cmFI92++Paz4S/7YvnHVDlGLAzT8owfuSlN7sFpyr3TeQl8y6N4pBfFRXhL/gV3pa5xDumxAmDL0IEILyDMZLQzLMiZdLAmH54NieEL9pdWWY+BqXhclfMWlt2X/aFuhV5ZhcNA8m/rfHk5tVoLZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382804; c=relaxed/simple;
	bh=m9TbJr+RiKNN8O2weW0fGPaFYumTWcx+NmQp3MvI8tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeoU5ECtEPSXvXbjYnydSNYdAwC0/ric95rdy6aUW2tIbs1dKlszOATPdhxcboO88zM/z7fxRT1kuJYymVwHgMuthuBQq95qzuWtFabDaRFd1WDlLADa6UxwrBJhNnWvYAUwih3hY2VRy5gQ6Whodm9bJJuNWD+JIGhCWJ4ZrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aoL3VBnt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aoL3VBnt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E06021FD56;
	Thu,  8 Feb 2024 09:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KxfczBiWWo4lpYamVcrsXlfoi/5eMnTiyrhCQIe6ABQ=;
	b=aoL3VBntvYez0q1xNLwNKt/u0Q4PNWT/x+XBIRRA7zGIc5dyuLqZl4LDl0LPsCuAfy84GJ
	JVU0m1E4qtLZ8j50fk+2UIAD7xxaNUvoC7vo59XItUBFrpJ/o/2cqIb7DXnKS0qoQj7K/e
	VgmnV4NppM22F9foMkL03P4QAQNnNy4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KxfczBiWWo4lpYamVcrsXlfoi/5eMnTiyrhCQIe6ABQ=;
	b=aoL3VBntvYez0q1xNLwNKt/u0Q4PNWT/x+XBIRRA7zGIc5dyuLqZl4LDl0LPsCuAfy84GJ
	JVU0m1E4qtLZ8j50fk+2UIAD7xxaNUvoC7vo59XItUBFrpJ/o/2cqIb7DXnKS0qoQj7K/e
	VgmnV4NppM22F9foMkL03P4QAQNnNy4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D073F13984;
	Thu,  8 Feb 2024 09:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U1ndMhCYxGVODgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:00 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/14] More error handling and BUG_ON cleanups
Date: Thu,  8 Feb 2024 09:59:31 +0100
Message-ID: <cover.1707382595.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [4.90 / 50.00];
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
	 BAYES_HAM(-0.00)[44.31%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Continuation of https://lore.kernel.org/linux-btrfs/cover.1706130791.git.dsterba@suse.com/
BUG_ON converted to error handling, removed or moved.

David Sterba (14):
  btrfs: push errors up from add_async_extent()
  btrfs: update comment and drop assertion in extent item lookup in
    find_parent_nodes()
  btrfs: handle invalid extent item reference found in
    extent_from_logical()
  btrfs: handle invalid extent item reference found in
    find_first_extent_item()
  btrfs: handle invalid root reference found in may_destroy_subvol()
  btrfs: send: handle unexpected data in header buffer in begin_cmd()
  btrfs: send: handle unexpected inode in header process_recorded_refs()
  btrfs: send: handle path ref underflow in header iterate_inode_ref()
  btrfs: change BUG_ON to assertion in tree_move_down()
  btrfs: change BUG_ONs to assertions in btrfs_qgroup_trace_subtree()
  btrfs: delete pointless BUG_ON check on quota root in
    btrfs_qgroup_account_extent()
  btrfs: delete pointless BUG_ONs on extent item size
  btrfs: handle unexpected parent block offset in
    btrfs_alloc_tree_block()
  btrfs: delete BUG_ON in btrfs_init_locked_inode()

 fs/btrfs/backref.c     | 20 +++++++++++++++-----
 fs/btrfs/extent-tree.c | 12 ++++++++++--
 fs/btrfs/inode.c       | 23 ++++++++++++++++-------
 fs/btrfs/qgroup.c      |  6 ++----
 fs/btrfs/scrub.c       |  9 ++++++++-
 fs/btrfs/send.c        | 27 +++++++++++++++++++++++----
 6 files changed, 74 insertions(+), 23 deletions(-)

-- 
2.42.1


