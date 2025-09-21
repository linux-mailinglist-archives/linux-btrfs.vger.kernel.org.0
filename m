Return-Path: <linux-btrfs+bounces-17009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A0B8D4CD
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 06:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3007F442DA6
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 04:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F6E26CE3C;
	Sun, 21 Sep 2025 04:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EGnAuNTR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mk5N1zBy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B03168BD
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 04:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758429357; cv=none; b=ioFsBuSBGMJwL0qJpaXeCDxPK/NI8I2qWLIjc7L3ETvl8pvLFtxKIOyayjVZph4TROZn165ILbEPZRAVsm0j0xJ48ArZFToOk+fIhOJDIhcC2EJM8DCqVe2uGLPbeLIJwbFcRD0yDpc3yiBZQst1XbrgsARJPAjY4+Tj4U3EwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758429357; c=relaxed/simple;
	bh=oIv6wHSn7V4JmAvenZPPZzrglZXw6GvbZrpVrijhDEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkLQdtr6mqyyrUENmLUYZKagI3LHx38iSN7fRPrNIwtHFuUfWWZgaa6V8iS9ST8PA6TNoQcxadvvmsx2dT4uMdEjiapDyfuZXecaoeCfwL/9yWC5rXS1GPZwmtTPO8l8SYnoh2OZb9gGerTNGqvK23AF8H0GjYBEa/eTeRjcv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EGnAuNTR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mk5N1zBy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA2F5225D8;
	Sun, 21 Sep 2025 04:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758429353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aYHpIMISwtaRLh3AGTe+kmBdS1A6+gfnLqQ7xihAbkE=;
	b=EGnAuNTRrtxowsujvCyH/JeEXkjN83mYnlzOSsT02M/K6uyPYcLCQgzaxFi801E2hsIMQg
	YK3bfEMie8IS6dLkmWvhfnl6OFMA5+LdkfRrZ15tTvkqmo09ULKJckrGwbvZebdl5abwD0
	xdGLBbedvQBSrxiTjVBR6i4vw3MmuyQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Mk5N1zBy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758429352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aYHpIMISwtaRLh3AGTe+kmBdS1A6+gfnLqQ7xihAbkE=;
	b=Mk5N1zBy/MXrUIVTXUYBfDy8hSnpHZtaiFsjrA4XExBvzs5vu4aTTPVaQ5kP4YpG0i1l6p
	f+GyRrOJ82NPyRD6BtpDf4GbZ3lC9StlAOPYI7vrEdvDgjJ5n6RflqjPLuAzopearH3P/Q
	RyT2mBgeLY4uiBZVrTw2tk0iCy4mJUM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE5B913A78;
	Sun, 21 Sep 2025 04:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1W79NaiAz2g9cQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Sun, 21 Sep 2025 04:35:52 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.17-rc7, part 2
Date: Sun, 21 Sep 2025 06:35:41 +0200
Message-ID: <cover.1758428886.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: EA2F5225D8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Hi,

please pull a few short fixes for btrfs. Thanks.

- in tree-checker, fix wrong size of check for inode ref item

- in ref-verify, handle combination of mount options that allow
  partially damaged extent tree (reported by syzbot)

- additional validation of compression mount option to catch invalid
  string as level

----------------------------------------------------------------
The following changes since commit 80eb65ccf6f72dc37b972583fe71cd8a50ff7e51:

  btrfs: annotate block group access with data_race() when sorting for reclaim (2025-09-15 05:25:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc6-tag

for you to fetch changes up to b98b208300573f4ab29507f81194a6030b208444:

  btrfs: reject invalid compression level (2025-09-18 13:18:49 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: ref-verify: handle damaged extent root tree

Qu Wenruo (2):
      btrfs: tree-checker: fix the incorrect inode ref size check
      btrfs: reject invalid compression level

 fs/btrfs/compression.c  | 22 +++++++++++++---------
 fs/btrfs/compression.h  |  2 +-
 fs/btrfs/ref-verify.c   |  9 ++++++++-
 fs/btrfs/super.c        | 27 +++++++++++++++++++--------
 fs/btrfs/tree-checker.c |  4 ++--
 5 files changed, 43 insertions(+), 21 deletions(-)

