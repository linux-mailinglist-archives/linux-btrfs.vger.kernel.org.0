Return-Path: <linux-btrfs+bounces-10039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EC9E27F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 17:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C11728A0DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F471F9EAD;
	Tue,  3 Dec 2024 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ABmffcZ+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ABmffcZ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F713B2B8;
	Tue,  3 Dec 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244292; cv=none; b=REsVC11SMmbyVPkXzSaOtAaGW8/4GJ/Pfbo3nUfyre15kNz982elYclPtfrzJQs7z+h8MJXJ6yaTcZmYE5Sz0UKppoo+myYXd07e3jRLH7dj4eC18ptzB6HZFABAr4gVx+Begy2NCnu01UNJXnlRPUPmge79R+cciBt67S5x9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244292; c=relaxed/simple;
	bh=X1k/huevY/l/ywsScMa166s7HjirUAOLJI63f0ykHiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRV5Z3XJ9QPeoQZEgrgSNwOuZpuA1QW6cDTafxyzrEidrYdiRjqfReDwZxrHfdjhYr1wZp5vwuYCMGYOZmknW29hUP0DiBy6cT/aCA8t9zMrrBQSqg1sIIrsJH9QDqUzi0nrzTcgZR2pOzfyCsX/b95BA+4mrLwjCpp8y1VsoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ABmffcZ+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ABmffcZ+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1B81F44F;
	Tue,  3 Dec 2024 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733244287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TK7/Rstg1ISjshRPuAcqrN5niIwGEbGqudTRbgXZfwo=;
	b=ABmffcZ+fijBx8NUdFjo6bctKlO/iQso9gstrVn+xW9jJuyHDtkJsTIAUcggMzw2aCVLOL
	5WPTzvTExAkuIg20auctBbl3G6BSQj2JHz3Mh+iUkVD7Vqm3HF9UZ4tGDcOPr/zZLaYbUd
	jibD8YwbLGaTwcXoMjpXSzfAO2B/NpY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733244287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TK7/Rstg1ISjshRPuAcqrN5niIwGEbGqudTRbgXZfwo=;
	b=ABmffcZ+fijBx8NUdFjo6bctKlO/iQso9gstrVn+xW9jJuyHDtkJsTIAUcggMzw2aCVLOL
	5WPTzvTExAkuIg20auctBbl3G6BSQj2JHz3Mh+iUkVD7Vqm3HF9UZ4tGDcOPr/zZLaYbUd
	jibD8YwbLGaTwcXoMjpXSzfAO2B/NpY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44748139C2;
	Tue,  3 Dec 2024 16:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hl+wEH81T2f9YAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 03 Dec 2024 16:44:47 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.13-rc2
Date: Tue,  3 Dec 2024 17:44:40 +0100
Message-ID: <cover.1733243359.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

first batch of regression and regular fixes. Please pull, thanks.

- add lockdep annotations for io_uring/encoded read integration, inode
  lock is held when returning to userspace

- properly reflect experimental config option to sysfs

- handle NULL root in case the rescue mode accepts invalid/damaged tree
  roots (rescue=ibadroot)

- regression fix of a deadlock between transaction and extent locks

- fix pending bio accounting bug in encoded read ioctl

- fix NOWAIT mode when checking references for NOCOW files

- fix use-after-free in a rb-tree cleanup in ref-verify debugging tool

----------------------------------------------------------------
The following changes since commit e82c936293aafb4f33b153c684c37291b3eed377:

  btrfs: send: check for read-only send root under critical section (2024-11-11 14:34:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc1-tag

for you to fetch changes up to 22d2e48e318564f8c9b09faf03ecb4f03fb44dd5:

  btrfs: fix lockdep warnings on io_uring encoded reads (2024-11-29 16:56:38 +0100)

----------------------------------------------------------------
Filipe Manana (4):
      btrfs: fix deadlock between transaction commits and extent locks
      btrfs: sysfs: advertise experimental features only if CONFIG_BTRFS_EXPERIMENTAL=y
      btrfs: don't loop for nowait writes when checking for cross references
      btrfs: ref-verify: fix use-after-free after invalid ref action

Johannes Thumshirn (1):
      btrfs: fix use-after-free in btrfs_encoded_read_endio()

Lizhi Xu (1):
      btrfs: add a sanity check for btrfs root in btrfs_search_slot()

Mark Harmstone (1):
      btrfs: fix lockdep warnings on io_uring encoded reads

 fs/btrfs/ctree.c       |  6 +++++-
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/inode.c       | 18 ++++++++++++++----
 fs/btrfs/ioctl.c       | 10 ++++++++++
 fs/btrfs/locking.h     | 10 ++++++++++
 fs/btrfs/ref-verify.c  |  1 +
 fs/btrfs/sysfs.c       |  4 ++--
 7 files changed, 43 insertions(+), 8 deletions(-)

