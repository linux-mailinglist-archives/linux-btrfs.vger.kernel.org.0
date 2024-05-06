Return-Path: <linux-btrfs+bounces-4784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B58BD5B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 21:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BB71F21271
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16F115B0F6;
	Mon,  6 May 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tfEyuOZN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tfEyuOZN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6682158873;
	Mon,  6 May 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024687; cv=none; b=DYKUEhNv1D05kt5+qDwYAq6g5ccqznCSm8OEKK/69afZJS2s2PeyZ4xJqgGURlaKb94C6+XEEIWg8+ENnfRURQjlnXkXTVFz5aqCGyAF6htNqsGKVLGskkdSjJXuWoJA6TaoRQ7iGKfRYweiTgOgq4YlydgA2j7g0IHDfxdxz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024687; c=relaxed/simple;
	bh=EVmC+rmzDtM9pKjBXpq4pyX1W8rcfyGKY83muBzllg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjDljR628XDtkc3DKLXzmftq+sef7VHo/Bi6J0z0e2XuoZB21CRbCPbkI4OCCLVMQVQckPUX6FIvWCuXo6g1sMoP0ZVjE1t6xgRuylHtywpTu09cEzWFaC4Cw3+MTRuXxkCqkBc7wRoKidRujG/BLUGrvIiA4a55mzr0keGgvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tfEyuOZN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tfEyuOZN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E19EC2267A;
	Mon,  6 May 2024 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715024683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=17FC+eGvffbugsO1K4XwJPTQVMXeDcHrp3IBonOSLXc=;
	b=tfEyuOZNwwLOwkcnsDhsTTbiehj/H0hvoMPWn+xQA+KtnKG54C67mtYsbvAKmPlvNE56aW
	7gYYmrFG6ooa7siI99kUG0IzGJUDssQyQVWyq0C/p0q9RchGMGfhWkMj6cL7NxGcOLxfj7
	JLf6O5KOxgFUsoTf+ShxFljSmS7WPBw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715024683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=17FC+eGvffbugsO1K4XwJPTQVMXeDcHrp3IBonOSLXc=;
	b=tfEyuOZNwwLOwkcnsDhsTTbiehj/H0hvoMPWn+xQA+KtnKG54C67mtYsbvAKmPlvNE56aW
	7gYYmrFG6ooa7siI99kUG0IzGJUDssQyQVWyq0C/p0q9RchGMGfhWkMj6cL7NxGcOLxfj7
	JLf6O5KOxgFUsoTf+ShxFljSmS7WPBw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAF2513A25;
	Mon,  6 May 2024 19:44:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nx1rNSszOWYaVwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 06 May 2024 19:44:43 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.9-rc8
Date: Mon,  6 May 2024 21:44:39 +0200
Message-ID: <cover.1715024051.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

Hi,

please pull two more fixes, both have some visible effects on user
space.

- add check if quotas are enabled when passing qgroup inheritance info,
  this affects snapper that could fail to create a snapshot

- do check for leaf/node flag WRITTEN earlier so that nodes are
  completely validated before access, this used to be done by integrity
  checker but it's been removed and left an unhandled case

----------------------------------------------------------------
The following changes since commit 63a6ce5a1a6261e4c70bad2b55c4e0de8da4762e:

  btrfs: set correct ram_bytes when splitting ordered extent (2024-04-30 12:03:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc7-tag

for you to fetch changes up to e03418abde871314e1a3a550f4c8afb7b89cb273:

  btrfs: make sure that WRITTEN is set on all metadata blocks (2024-05-02 22:11:13 +0200)

----------------------------------------------------------------
Josef Bacik (1):
      btrfs: make sure that WRITTEN is set on all metadata blocks

Qu Wenruo (1):
      btrfs: qgroup: do not check qgroup inherit if qgroup is disabled

 fs/btrfs/qgroup.c       |  2 ++
 fs/btrfs/tree-checker.c | 30 +++++++++++++++---------------
 fs/btrfs/tree-checker.h |  1 +
 3 files changed, 18 insertions(+), 15 deletions(-)

