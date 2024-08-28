Return-Path: <linux-btrfs+bounces-7610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6980C9625F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 13:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C63828437C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C016D338;
	Wed, 28 Aug 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FDvBAyr3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FDvBAyr3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787B3FEC;
	Wed, 28 Aug 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844210; cv=none; b=Wd0JrVcx3tR/8AlS6i+oE8xqjNS0zbiueRUrlfqCLlyl1Jxy/iYD6wKVAGMkXhN1+7h+QVFqn5iYEYh50mm8/dJkNeL2o9OXGjtCQOU4FABLh37dn0y9S7su1u+Rgngq7vhMSguTt20F3H2DsPUfm38V+n1fjxQM8DS6ROkf+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844210; c=relaxed/simple;
	bh=7hmI27LYRGcUl3eqxgBgH/2vQ5T5AstN6jak9otAwHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ivn79xNE82cDyxEZIUt7zx2sv39b4HTAbeG8Rf0Q6CRi3BUqL92i8IQEl18EnIH1pp69yqMs6lKIf6XjGhSn7JL/LeRWjnYjNe7UrUcOWXm2PTlplpicsliIF3HhpV2tlpuz44F48lkFs7CF64T5XeBofJ3C2Zp/IoThAG7zG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FDvBAyr3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FDvBAyr3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FEFE1FC06;
	Wed, 28 Aug 2024 11:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724844206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4Mlg8l5RfTgnHNNLcdxJRkOXt1F27S0joKyFAkovpCw=;
	b=FDvBAyr3iR352zv2dPE3uQuqnxP6ZpcEjtfzUlmB2yH6JnuM74uyK1gjDrdXj1JAeebMMs
	Z2Lq0geGH0QfOjmUQVx9Oa5BV7ct/7HpNqE2GHkXW38s6LmoUo68iorLfoW7xaAH0Up/GA
	Ai/kiXyzhk4gIGoUKcRLGpSEmLvQ/Ds=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724844206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4Mlg8l5RfTgnHNNLcdxJRkOXt1F27S0joKyFAkovpCw=;
	b=FDvBAyr3iR352zv2dPE3uQuqnxP6ZpcEjtfzUlmB2yH6JnuM74uyK1gjDrdXj1JAeebMMs
	Z2Lq0geGH0QfOjmUQVx9Oa5BV7ct/7HpNqE2GHkXW38s6LmoUo68iorLfoW7xaAH0Up/GA
	Ai/kiXyzhk4gIGoUKcRLGpSEmLvQ/Ds=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49707138D2;
	Wed, 28 Aug 2024 11:23:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BG/lEa4Iz2Y5fAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 28 Aug 2024 11:23:26 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.11-rc6
Date: Wed, 28 Aug 2024 13:23:12 +0200
Message-ID: <cover.1724844084.git.dsterba@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi,

a few more misc fixes. Please pull, thanks.

- fix use-after-free when submitting bios for read, after an error and
  partially submitted bio the original one is freed while it can be still be
  accessed again

- fix fstests case btrfs/301, with enabled quotas wait for delayed iputs when
  flushing delalloc

- fix regression in periodic block group reclaim, an unitialized value can be
  returned if there are no block groups to reclaim

- fix build warning (-Wmaybe-uninitialized)

----------------------------------------------------------------
The following changes since commit 534f7eff9239c1b0af852fc33f5af2b62c00eddf:

  btrfs: only enable extent map shrinker for DEBUG builds (2024-08-16 21:22:39 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc5-tag

for you to fetch changes up to ecb54277cb63c273e8d74272e5b9bfd80c2185d9:

  btrfs: fix uninitialized return value from btrfs_reclaim_sweep() (2024-08-27 16:42:09 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: initialize last_extent_end to fix -Wmaybe-uninitialized warning in extent_fiemap()

Filipe Manana (1):
      btrfs: fix uninitialized return value from btrfs_reclaim_sweep()

Josef Bacik (1):
      btrfs: run delayed iputs when flushing delalloc

Qu Wenruo (1):
      btrfs: fix a use-after-free when hitting errors inside btrfs_submit_chunk()

 fs/btrfs/bio.c        | 26 ++++++++++++++++++--------
 fs/btrfs/fiemap.c     |  2 +-
 fs/btrfs/qgroup.c     |  2 ++
 fs/btrfs/space-info.c | 17 +++++------------
 fs/btrfs/space-info.h |  2 +-
 5 files changed, 27 insertions(+), 22 deletions(-)

