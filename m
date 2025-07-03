Return-Path: <linux-btrfs+bounces-15227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A247AF8159
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E933BEF28
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F482F5493;
	Thu,  3 Jul 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ca9+/5Bf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GevgGAV0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648F2F2736
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570978; cv=none; b=HuMX7T8/hGP3tXwqBbOaUB1UvIrPQ8FGSPhd2avAhU95zHBReknIxfYPBvyZ7selx7nz/pPalKhCXMsdend72IcpCkRKwYGrfm7xdbzoBdAwz5URcci/ovRFIpgpeE1K0NfKAXllIgeLrcs36zb4FE0KoNsaa27u9tDRIKuP9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570978; c=relaxed/simple;
	bh=CnJJn+MBhMRbk/qCHnFJEq3nhBL1fATJfmVPRhO+GtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNiCFqKEcsCxIovCV+b9bBzTlsORLXjTOm5MgA83eS8vAFAJPVV0Nk0E3VgXcaQhbXPl+g5KR+OHLJxoLYGUcdDddDEK3LgH0LnUCC4Vv8r7+ElSCL4CUunKVK2E0IWWkE/2N8+WwOHtuS/Y5k2MHEEcCFEEVyJM3nGrDZx+d30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ca9+/5Bf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GevgGAV0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D21611F387;
	Thu,  3 Jul 2025 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751570973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=p6OPTcT77LxACJK3g6G9aNPqhjTF+SGH5Xoofm93IyA=;
	b=Ca9+/5BfSGkXdDJZb1PArnPfdiAP7tlrBpQokbivRDf29p4aMkOZcPHC61tzY/XtnzBG8T
	T9obhYVnqIWGnqiyv5nZdccVq0GnASNm98AjkxFsIpg+v7pvnqyLrDYg5b8sAPeS2wQBuk
	o5GZ8mEXuLepd2qZPEMmPKSbZ5zV1mA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GevgGAV0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751570972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=p6OPTcT77LxACJK3g6G9aNPqhjTF+SGH5Xoofm93IyA=;
	b=GevgGAV07SwiPSnYr7+I3DmVGJI8dLthFJwAcvgxnQ0sAQIvB8GrW0jaeqm/WJjfbiE+aQ
	unW0h3Y6lf0ACViYRBo4YrC9JVF5x3bcpQm7ArzkR0jsYPHzkL1V8tdbtO+la6BPUUg8Hs
	8aGdUyiJq6c7LpDA3jWJx8e30xTxSrk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF7FB13721;
	Thu,  3 Jul 2025 19:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K3y4LhzaZmgqPwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 03 Jul 2025 19:29:32 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.16-rc5
Date: Thu,  3 Jul 2025 21:29:28 +0200
Message-ID: <cover.1751564436.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D21611F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Hi,

please pull a few more fixes. There are mostly tree-log fixes and a free
space tree rebuild fix.

Thanks.

- tree-log fixes
  - fixes of log tracking of directories and subvolumes
  - fix iteration and error handling of inode references during log
    replay

- fix free space tree rebuild (reported by syzbot)

----------------------------------------------------------------
The following changes since commit c0d90a79e8e65b89037508276b2b31f41a1b3783:

  btrfs: zoned: fix alloc_offset calculation for partly conventional block groups (2025-06-19 15:21:15 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-rc4-tag

for you to fetch changes up to 157501b0469969fc1ba53add5049575aadd79d80:

  btrfs: use btrfs_record_snapshot_destroy() during rmdir (2025-06-27 19:58:12 +0200)

----------------------------------------------------------------
Filipe Manana (7):
      btrfs: fix failure to rebuild free space tree using multiple transactions
      btrfs: fix missing error handling when searching for inode refs during log replay
      btrfs: fix iteration of extrefs during log replay
      btrfs: fix inode lookup error handling during log replay
      btrfs: record new subvolume in parent dir earlier to avoid dir logging races
      btrfs: propagate last_unlink_trans earlier when doing a rmdir
      btrfs: use btrfs_record_snapshot_destroy() during rmdir

 fs/btrfs/block-group.h     |   2 +
 fs/btrfs/free-space-tree.c |  40 +++++++++++++
 fs/btrfs/inode.c           |  36 ++++++------
 fs/btrfs/ioctl.c           |   4 +-
 fs/btrfs/tree-log.c        | 137 +++++++++++++++++++++++----------------------
 5 files changed, 131 insertions(+), 88 deletions(-)

