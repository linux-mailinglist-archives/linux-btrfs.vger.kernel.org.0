Return-Path: <linux-btrfs+bounces-7818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F0396C60C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 20:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CDE281B52
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156431E1A35;
	Wed,  4 Sep 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tv6hhtLb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tv6hhtLb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E626E619;
	Wed,  4 Sep 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473500; cv=none; b=MsLtQwyyaHpUHyF4ueuPVDUg81LEo4L447rcX42aLvTHI9ZktUNKUXedDOUyBLPud4vqnyapHytLKH26k6qMq8yH/Hu+rEAL82ZHuuMLNA4ULPtKl1K8ctw5oDWu8RktO7KLSLSLehfatkUl7SSnpnbXUGLbIydQeqvntglvTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473500; c=relaxed/simple;
	bh=nfUy2Wxe84PA7ufpiT2wCYxsTM5QNPPZxmcLlBCxhTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3tQA9Q0phk3WVmQS8EafRaYK2zzdOX7o4vhElOBSX/05v8J31JPMDrjDedZwrN2QROjC2540Scdgf6ZjbwypP/xzga7cG3sxCazSLdgdJ7rDxW265qwPnQ8QkSr4uHu512rJhrW2RE/yg0+1gStIEkW0NYEavLgnAoLSg9CQpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tv6hhtLb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tv6hhtLb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F09C1F7DC;
	Wed,  4 Sep 2024 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725473496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oCstBy4A5D8dt7m2uE2Jb+DRjWVlSOdd35uCt42/X3w=;
	b=Tv6hhtLb/BdiLnVRHQpwzAGfZV4yiEO+9CrkqxOm+JyQWZlFTS3QjxlZsveHqYnPdCncvk
	RMiqk4Ud4Uuyby2QeT/GRpdxGs2OuKon+maO+taUbtsoN440jz7ActauxppXNStGAKPWj+
	jjXlLdfDaqUp5koBulzCmRP3ipBRNOk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725473496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oCstBy4A5D8dt7m2uE2Jb+DRjWVlSOdd35uCt42/X3w=;
	b=Tv6hhtLb/BdiLnVRHQpwzAGfZV4yiEO+9CrkqxOm+JyQWZlFTS3QjxlZsveHqYnPdCncvk
	RMiqk4Ud4Uuyby2QeT/GRpdxGs2OuKon+maO+taUbtsoN440jz7ActauxppXNStGAKPWj+
	jjXlLdfDaqUp5koBulzCmRP3ipBRNOk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 581E1139D2;
	Wed,  4 Sep 2024 18:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sh2AFdii2GYvOQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 04 Sep 2024 18:11:36 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.11-rc7
Date: Wed,  4 Sep 2024 20:11:04 +0200
Message-ID: <cover.1725472780.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi,

a few more fixes, for stable trees.  Please pull, thanks.

- followup fix for direct io and fsync under some conditions, reported
  by QEMU users

- fix a potential leak when disabling quotas while some extent tracking
  work can still happen

- in zoned mode handle unexpected change of zone write pointer in
  RAID1-like block groups, turn the zones to read-only

----------------------------------------------------------------
The following changes since commit ecb54277cb63c273e8d74272e5b9bfd80c2185d9:

  btrfs: fix uninitialized return value from btrfs_reclaim_sweep() (2024-08-27 16:42:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc6-tag

for you to fetch changes up to cd9253c23aedd61eb5ff11f37a36247cd46faf86:

  btrfs: fix race between direct IO write and fsync when using same fd (2024-09-03 20:29:55 +0200)

----------------------------------------------------------------
Fedor Pchelkin (1):
      btrfs: qgroup: don't use extent changeset when not needed

Filipe Manana (1):
      btrfs: fix race between direct IO write and fsync when using same fd

Naohiro Aota (1):
      btrfs: zoned: handle broken write pointer on zones

 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/direct-io.c   | 16 +++-------------
 fs/btrfs/file.c        |  9 +++++++--
 fs/btrfs/qgroup.c      |  3 +--
 fs/btrfs/transaction.h |  6 ++++++
 fs/btrfs/zoned.c       | 30 +++++++++++++++++++++++++-----
 6 files changed, 42 insertions(+), 23 deletions(-)

