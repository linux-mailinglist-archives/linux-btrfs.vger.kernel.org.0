Return-Path: <linux-btrfs+bounces-2379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8B85445A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 09:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FE91F2A663
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C9C2C6;
	Wed, 14 Feb 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gsmEeDvU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gsmEeDvU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311779DC;
	Wed, 14 Feb 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900777; cv=none; b=Dgi9XAcrJ7PnU5D0Z2uodEecAsaHRC5Pk2dcJK2ti006HFZlQyUFLLly3xOOtYH8o3WrXubax+hrzRrV3RY08ZMgrfGH7wx8SDy1+b/6vBxdsczDKq4D/e3J7u6wZd3ur1SFZYAvFJ4f4s8m2CkqMGf6zdFDDwSpwTfdYApRFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900777; c=relaxed/simple;
	bh=ZPwTvzWqlx9OchF3dRxEloHfDxUOdPKkuSspueE//3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n69/XG5wGAQYsHAuaqzVU0XB7M/U+ji/d4sNPBfOwE+YyvgPlFfRkWd4e4vBagl3ynLVNsRxZSmy5pVKLweG4ITpXHdxKFeRl3tvW65i3B6D44FIaMfb3ageFdJsd0cqu5gGIEFsS/SOyACLgKFhfG4fmLIDMlmdzfEbvXvMQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gsmEeDvU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gsmEeDvU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9824A21CA8;
	Wed, 14 Feb 2024 08:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707900773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UOx70PD5yft0dm9BWWOGLZJRxlYjfx2O3KH0qlJiMP4=;
	b=gsmEeDvUy129QcVQX50fOQYWCdIkI3/pHGH1RR9+ug0sV2n1Pd2If2C03PGh1/8u1YAAVT
	M2thyEFwqysHX4FXCyYiwsRiyHgcBlyJBIGwUgx9BntIXLTz1pI62s6BA7GnZq79OKvYli
	2aptoB8s2GJ5d+TkR5Mbn4x7TPA6PBo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707900773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UOx70PD5yft0dm9BWWOGLZJRxlYjfx2O3KH0qlJiMP4=;
	b=gsmEeDvUy129QcVQX50fOQYWCdIkI3/pHGH1RR9+ug0sV2n1Pd2If2C03PGh1/8u1YAAVT
	M2thyEFwqysHX4FXCyYiwsRiyHgcBlyJBIGwUgx9BntIXLTz1pI62s6BA7GnZq79OKvYli
	2aptoB8s2GJ5d+TkR5Mbn4x7TPA6PBo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 90BD213A0B;
	Wed, 14 Feb 2024 08:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JNhQI2V/zGUMPwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 14 Feb 2024 08:52:53 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.8-rc5
Date: Wed, 14 Feb 2024 09:52:16 +0100
Message-ID: <cover.1707900530.git.dsterba@suse.com>
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
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Hi,

a few regular fixes and one fix for space reservation regression since
6.7 that users have been reporting.

Please pull, thanks.

- fix over-reservation of metadata chunks due to not keeping proper balance
  between global block reserve and delayed refs reserve;
  in practice this leaves behind empty metadata block groups, the workaround
  is to reclaim them by using the '-musage=1' balance filter

- other space reservation fixes:
  - do not delete unused block group if it may be used soon
  - do not reserve space for checksums for NOCOW files

- fix extent map assertion failure when writing out free space inode

- reject encoded write if inode has nodatasum flag set

- fix chunk map leak when loading block group zone info

----------------------------------------------------------------
The following changes since commit e03ee2fe873eb68c1f9ba5112fee70303ebf9dfb:

  btrfs: do not ASSERT() if the newly created subvolume already got read (2024-01-31 08:42:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc4-tag

for you to fetch changes up to 2f6397e448e689adf57e6788c90f913abd7e1af8:

  btrfs: don't refill whole delayed refs block reserve when starting transaction (2024-02-13 18:39:09 +0100)

----------------------------------------------------------------
Filipe Manana (7):
      btrfs: add and use helper to check if block group is used
      btrfs: do not delete unused block group if it may be used soon
      btrfs: add new unused block groups to the list of unused block groups
      btrfs: don't reserve space for checksums when writing to nocow files
      btrfs: reject encoded write if inode has nodatasum flag set
      btrfs: zoned: fix chunk map leak when loading block group zone info
      btrfs: don't refill whole delayed refs block reserve when starting transaction

Josef Bacik (1):
      btrfs: don't drop extent_map for free space inode on write error

 fs/btrfs/block-group.c    | 80 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/block-group.h    |  7 +++++
 fs/btrfs/delalloc-space.c | 29 +++++++++++------
 fs/btrfs/inode.c          | 26 +++++++++++++--
 fs/btrfs/transaction.c    | 38 ++--------------------
 fs/btrfs/zoned.c          |  1 +
 6 files changed, 131 insertions(+), 50 deletions(-)

