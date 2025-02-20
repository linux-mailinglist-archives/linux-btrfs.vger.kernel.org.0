Return-Path: <linux-btrfs+bounces-11612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EACA3D5D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED9D7AA055
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18AD1F151B;
	Thu, 20 Feb 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RMweishZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RMweishZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3D61F150F
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045640; cv=none; b=cPFwjsAsLdE5vECCQzdb13VMxpohSZQuJmfdeVcluQ2Jw3zX2GzDmQenwMu0gbPj406arwntLPzTH8pKY6RVqoCpGtX5C6mV904FRHdt2xyoK2cVrGEEjkzV8YtTudMxeQlorkg9VDKTyAP1xNC1CS7PBSMM44Mq0quDjbMGNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045640; c=relaxed/simple;
	bh=Bq8qX9Soh4/DdNBeTw+NnRMQm7hldpvsDKIBSmrZ30I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkR+O5Hhdl+o49DdwTTeJM8KN4+MDFilWPlxosNaAYLR2ztNXyDfYEpovGlmwJ41Yraf798jtIL5NdgZr9Xuv58yP88cb4NGMncQG6HtUdXQ1HOXbEzNxnZpVnx3TjzxxwPVFFx3rBhdmnNBjmBLJfx2gT5qKEzyjwQ+SgVYBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RMweishZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RMweishZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3783A1F387;
	Thu, 20 Feb 2025 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G6ng/sOxDpfPzsshlDtUyfx7omp2BbEn1FIbQogzLcQ=;
	b=RMweishZ3ymsDz03Hx+wyF+KbPb3a2BnAtK0pDTJXXYtZ2a9P5GExdUcJgNQ4OJIhpDDR4
	ie9sTjBQhkJkNKD14CVtgAjddMlur9K8M7AWMedqVBpxli0pIinyNc/6IAVDf4dIadMIfr
	GP//eSok5vPPlg82qMtYKg6WSi1EMUA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RMweishZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G6ng/sOxDpfPzsshlDtUyfx7omp2BbEn1FIbQogzLcQ=;
	b=RMweishZ3ymsDz03Hx+wyF+KbPb3a2BnAtK0pDTJXXYtZ2a9P5GExdUcJgNQ4OJIhpDDR4
	ie9sTjBQhkJkNKD14CVtgAjddMlur9K8M7AWMedqVBpxli0pIinyNc/6IAVDf4dIadMIfr
	GP//eSok5vPPlg82qMtYKg6WSi1EMUA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25E5D13301;
	Thu, 20 Feb 2025 10:00:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w8Y+CUT9tmcnfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:00:36 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/22] More inode type cleanups
Date: Thu, 20 Feb 2025 11:00:35 +0100
Message-ID: <cover.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3783A1F387
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Continued work to convert struct inode to struct btrfs_inode in the
internal interfaces. No functional changes.

David Sterba (22):
  btrfs: pass struct btrfs_inode to can_nocow_extent()
  btrfs: pass struct btrfs_inode to extent_range_clear_dirty_for_io()
  btrfs: pass struct btrfs_inode to btrfs_read_locked_inode()
  btrfs: pass struct btrfs_inode to btrfs_iget_locked()
  btrfs: pass struct btrfs_inode to new_simple_dir()
  btrfs: pass struct btrfs_inode to btrfs_inode_type()
  btrfs: pass struct btrfs_inode to btrfs_defrag_file()
  btrfs: use struct btrfs_inode inside create_pending_snapshot()
  btrfs: pass struct btrfs_inode to fill_stack_inode_item()
  btrfs: pass struct btrfs_inode to btrfs_fill_inode()
  btrfs: pass struct btrfs_inode to btrfs_load_inode_props()
  btrfs: pass struct btrfs_inode to btrfs_inode_inherit_props()
  btrfs: props: switch prop_handler::apply to struct btrfs_inode
  btrfs: props: switch prop_handler::extract to struct btrfs_inode
  btrfs: pass struct btrfs_inode to clone_copy_inline_extent()
  btrfs: pass struct btrfs_inode to btrfs_double_mmap_lock()
  btrfs: pass struct btrfs_inode to btrfs_double_mmap_unlock()
  btrfs: pass struct btrfs_inode to btrfs_extent_same_range()
  btrfs: use struct btrfs_inode inside btrfs_remap_file_range()
  btrfs: use struct btrfs_inode inside btrfs_remap_file_range_prep()
  btrfs: use struct btrfs_inode inside btrfs_get_parent()
  btrfs: use struct btrfs_inode inside btrfs_get_name()

 fs/btrfs/btrfs_inode.h   |   2 +-
 fs/btrfs/defrag.c        |  44 ++++----
 fs/btrfs/defrag.h        |   4 +-
 fs/btrfs/delayed-inode.c |  95 ++++++++--------
 fs/btrfs/delayed-inode.h |   2 +-
 fs/btrfs/direct-io.c     |   3 +-
 fs/btrfs/export.c        |  26 ++---
 fs/btrfs/file.c          |   3 +-
 fs/btrfs/inode.c         | 232 ++++++++++++++++++++-------------------
 fs/btrfs/ioctl.c         |   2 +-
 fs/btrfs/props.c         |  66 +++++------
 fs/btrfs/props.h         |   7 +-
 fs/btrfs/reflink.c       | 100 ++++++++---------
 fs/btrfs/transaction.c   |  24 ++--
 14 files changed, 309 insertions(+), 301 deletions(-)

-- 
2.47.1


