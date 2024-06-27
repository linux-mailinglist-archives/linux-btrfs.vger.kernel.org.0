Return-Path: <linux-btrfs+bounces-6021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A991AB41
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 17:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C0A1C24E3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 15:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BD6199256;
	Thu, 27 Jun 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kxbrtNzK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kxbrtNzK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF5197A61;
	Thu, 27 Jun 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502119; cv=none; b=gJVOLsXlXB0hsVuJk/QMRCqJ3Dpg4Y2OQ4sgUqj0SuCmryLgHIOdq+mLJL1K6dcZSIo4ZYMEhpD/ufS+lK8GHn3Vg8ob6Ko7bs2Vs6YpTvMgX/IrswxhhJsns+IysCJ49+hmQw7s5B6goGZjmPHdMy0d6JBZWexBn9FBLflpCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502119; c=relaxed/simple;
	bh=2wOiX3DY2j15B+2U+HEYz10Atc+DEaitmDjLjIz69N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6lHTkB8Vyg2RjWJFb3hoKcJO3aYq7NzMrKQIxxWup0bNlJfOUIAUpgfTaxNBDaKh7w8nxgeX6/OoZM0w1EX0i8TBO9GEZBBncXU7ZkY1qb2nUO2KtwZ9lk8pYvUaNAf+H/kRW25+EqU4tD/J/1i6vU+ehiQvutHrgOdl2qtlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kxbrtNzK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kxbrtNzK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 463B51FBF8;
	Thu, 27 Jun 2024 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719502114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2L0Wc0d0vkMttim/ROeJD8PFWvVjLq8YrxbvyRm6rGQ=;
	b=kxbrtNzKSr8tqVMk/cbYMs5KfLKTaZEOViKjfrZGwEY0xkh08rgrWBX7vT1f8bWbp4gwNa
	Za3kTFFmw1NnJJZhwOV0N0qgGG9L1JZcaT5SZw9t62G/s+9k+vBaAgWZO7SmthnhyBFEZe
	HGhq+bQXSj7MqqWuxUnTFMO5WvkepJg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kxbrtNzK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719502114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2L0Wc0d0vkMttim/ROeJD8PFWvVjLq8YrxbvyRm6rGQ=;
	b=kxbrtNzKSr8tqVMk/cbYMs5KfLKTaZEOViKjfrZGwEY0xkh08rgrWBX7vT1f8bWbp4gwNa
	Za3kTFFmw1NnJJZhwOV0N0qgGG9L1JZcaT5SZw9t62G/s+9k+vBaAgWZO7SmthnhyBFEZe
	HGhq+bQXSj7MqqWuxUnTFMO5WvkepJg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EE291384C;
	Thu, 27 Jun 2024 15:28:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ex5WDyKFfWZyCAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 27 Jun 2024 15:28:34 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.10-rc6
Date: Thu, 27 Jun 2024 17:28:32 +0200
Message-ID: <cover.1719501798.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 463B51FBF8
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Hi,

a few more fixes. Please pull, thanks.

- fix quota root leak after quota disable failure

- fix condition when checking if a zone can be added as free

- allocate inode in NOFS context during logging or tree-log replay

- handle raid-stripe-tree lookup correctly during scrub

----------------------------------------------------------------
The following changes since commit cebae292e0c32a228e8f2219c270a7237be24a6a:

  btrfs: zoned: allocate dummy checksums for zoned NODATASUM writes (2024-06-13 20:43:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc5-tag

for you to fetch changes up to a7e4c6a3031c74078dba7fa36239d0f4fe476c53:

  btrfs: qgroup: fix quota root leak after quota disable failure (2024-06-25 00:35:50 +0200)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: use NOFS context when getting inodes during logging and log replay
      btrfs: qgroup: fix quota root leak after quota disable failure

Naohiro Aota (1):
      btrfs: zoned: fix initial free space detection

Qu Wenruo (1):
      btrfs: scrub: handle RST lookup error correctly

 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/qgroup.c           |  4 ++--
 fs/btrfs/scrub.c            | 26 +++++++++++++++-----------
 fs/btrfs/tree-log.c         | 43 ++++++++++++++++++++++++++++---------------
 4 files changed, 46 insertions(+), 29 deletions(-)

