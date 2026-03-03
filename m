Return-Path: <linux-btrfs+bounces-22177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LLqJDb2pmmgawAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22177-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 15:54:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9161F1D7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C49D308C56A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4DB47DFA6;
	Tue,  3 Mar 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TJgviTHu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TJgviTHu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60747DD6C
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549593; cv=none; b=ELd1i4UhWyDHZgEIUrpMSOowfEo5HVyMZfWJOu9q2fEANcABusLbw1nBwGbwP/QvMG21OI67L92e74s3z8YaVJ1R0aZazIabQScNORR+Rg/3zATauS9Z7bgI/5ujX5sRseD3gSVTLoYWLoWgiD6RtqGDMVf6GtADAlQyMk27RiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549593; c=relaxed/simple;
	bh=MUFJqJnSGzne40SLMLpwFkq/L3tHoDO2iG5U4N0+lTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AZJmxHdsvwSLSUq91oh5+qW6ofT8p0P0wg954rltARjpNB+8TPYU1Eka9TuTBU5GFJHIfof3bJrqi1xc0TC59Kya0TMpSAjLSUUaWIPcZ9hJNBcBX3Q66UmSHGGq+QCnvX8zlVFc4EbiHjkfa3FVzrtPd/ujPuW65exZ96Y4G9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TJgviTHu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TJgviTHu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AF6C3F915;
	Tue,  3 Mar 2026 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qAV5wkv8YIpiQHa/dKOAxo4USIMHz3BOFHLJXcOtIOI=;
	b=TJgviTHuL48bYydisRAXJ31pDPyKgsxd2r+Cl/Yz2mTSe60YlkR62Fk/s+LHLXJGksqPHM
	bUhaXlfN0sXGWHUmb6EDAVVCUYtUHghLYk/ftaMIqhEbIfxpU33CUZDVgtK7Rrofbw4frW
	4ot4R157uoYRsyEfGxLII9Hz5kC0PmY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TJgviTHu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qAV5wkv8YIpiQHa/dKOAxo4USIMHz3BOFHLJXcOtIOI=;
	b=TJgviTHuL48bYydisRAXJ31pDPyKgsxd2r+Cl/Yz2mTSe60YlkR62Fk/s+LHLXJGksqPHM
	bUhaXlfN0sXGWHUmb6EDAVVCUYtUHghLYk/ftaMIqhEbIfxpU33CUZDVgtK7Rrofbw4frW
	4ot4R157uoYRsyEfGxLII9Hz5kC0PmY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 942D23EA69;
	Tue,  3 Mar 2026 14:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8qwlJNb1pmmyKQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 03 Mar 2026 14:53:10 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 7.0-rc3
Date: Tue,  3 Mar 2026 15:53:08 +0100
Message-ID: <cover.1772547600.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 1A9161F1D7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22177-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:mid]
X-Rspamd-Action: no action

Hi,

please pull the following btrfs fixes. There are one-liners or short
fixes of minor/moderate problems reported recently. Thanks.

- fixes or level adjustments of error messages

- fix leaked transaction handles after aborted transactions, when using
  the remap tree feature

- fix a few leaked chunk maps after errors

- fix leaked page array in io_uring encoded read if an error occurs and
  the 'finished' is not called

- fix double release of reserved extents when doing a range COW

- don't commit super block when the filesystem is in shutdown state

- fix squota accounting condition when checking members vs parent usage

- other error handling fixes

----------------------------------------------------------------
The following changes since commit ecb7c2484cfc83a93658907580035a8adf1e0a92:

  btrfs: fix invalid leaf access in btrfs_quota_enable() if ref key not found (2026-02-18 15:25:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-7.0-rc2-tag

for you to fetch changes up to f8db8009ea65297dba7786668d4561f6dbd99678:

  btrfs: check block group lookup in remove_range_from_remap_tree() (2026-02-26 15:03:29 +0100)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix referenced/exclusive check in squota_check_parent_usage()

Filipe Manana (5):
      btrfs: change warning messages to error level in open_ctree()
      btrfs: remove redundant warning message in btrfs_check_uuid_tree()
      btrfs: remove btrfs_handle_fs_error() after failure to recover log trees
      btrfs: convert log messages to error level in btrfs_replay_log()
      btrfs: remove pointless WARN_ON() in cache_save_setup()

Jingkai Tan (1):
      btrfs: handle discard errors in in btrfs_finish_extent_commit()

Mark Harmstone (10):
      btrfs: fix error message order of parameters in btrfs_delete_delayed_dir_index()
      btrfs: fix incorrect key offset in error message in check_dev_extent_item()
      btrfs: fix objectid value in error message in check_extent_data_ref()
      btrfs: fix warning in scrub_verify_one_metadata()
      btrfs: print correct subvol num if active swapfile prevents deletion
      btrfs: fix compat mask in error messages in btrfs_check_features()
      btrfs: fix chunk map leak in btrfs_map_block() after btrfs_chunk_map_num_copies()
      btrfs: fix chunk map leak in btrfs_map_block() after btrfs_translate_remap()
      btrfs: fix transaction handle leaks in btrfs_last_identity_remap_gone()
      btrfs: check block group lookup in remove_range_from_remap_tree()

Miquel Sabaté Solà (2):
      btrfs: free pages on error in btrfs_uring_read_extent()
      btrfs: don't commit the super block when unmounting a shutdown filesystem

Qu Wenruo (1):
      btrfs: fix a double release on reserved extents in cow_one_range()

 fs/btrfs/block-group.c   |  1 -
 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/disk-io.c       | 36 +++++++++++++++++++++---------------
 fs/btrfs/extent-tree.c   |  8 +++++++-
 fs/btrfs/inode.c         | 19 +++++++++++++++++--
 fs/btrfs/ioctl.c         |  7 ++++++-
 fs/btrfs/qgroup.c        |  2 +-
 fs/btrfs/relocation.c    |  6 ++++++
 fs/btrfs/scrub.c         |  2 +-
 fs/btrfs/tree-checker.c  |  4 ++--
 fs/btrfs/volumes.c       |  8 +++++---
 11 files changed, 67 insertions(+), 28 deletions(-)

