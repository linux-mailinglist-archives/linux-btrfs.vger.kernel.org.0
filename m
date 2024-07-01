Return-Path: <linux-btrfs+bounces-6110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB691E6C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 19:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB56B24A5B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC416EB71;
	Mon,  1 Jul 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fKxLvXOi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fKxLvXOi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7C16D4E5;
	Mon,  1 Jul 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855438; cv=none; b=Ht7AvWpdLmfEbQuzZheMvjD/yrDTUpXe6FRrw4yTo5sCZbgF418BRxp/K9eMOZ5/1ghowhreFu4X09VrLZilGNOx+jvsiqwhmrtbcDbUOenlUY0ZHGvOCwX9+HlGfaWwG+GDh6IejNzOGLuqDTCRZy1vSMuD1KbfDgFiiqIoyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855438; c=relaxed/simple;
	bh=hN6oSSRWYToPIMwG16+WPYiqy2arnc7nun29w+3bd4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbShyu6p4QhwSAJVFS7DKXmcb5EyVZ0uBwD2wgb1A58BB3/I2s/366jDG/95HOnO6b7Qc0gkVUs6VHjup3KzFnRzO94/6azYtF1nHWZZjCOCuGV0bizXA77+lsjMjhD2xJ23OPnZL/+jXjxgb6hJ5/4MvHGhKM++hOJSMlVVtoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fKxLvXOi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fKxLvXOi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8764621BFC;
	Mon,  1 Jul 2024 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719855433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XPfeObkmiABo3u/9oEUp18A+HOCjxx8ouUmmjFX6AXM=;
	b=fKxLvXOiK4uiUV9uPUEwnWFbqBbhwZYHSKiNdLS3b6wF1/IOxJ6yH9iMEeoS/0i5iBtDy3
	KhWbYHpEXAQlouAKHq4cI8gbP79hX/hajS2JD5VcnHP2pS4wO6T0WoqkCU9fQ6EUerJM/c
	qs9LmmOiOx5s82FbhLbJlqoqF62QyI8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fKxLvXOi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719855433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XPfeObkmiABo3u/9oEUp18A+HOCjxx8ouUmmjFX6AXM=;
	b=fKxLvXOiK4uiUV9uPUEwnWFbqBbhwZYHSKiNdLS3b6wF1/IOxJ6yH9iMEeoS/0i5iBtDy3
	KhWbYHpEXAQlouAKHq4cI8gbP79hX/hajS2JD5VcnHP2pS4wO6T0WoqkCU9fQ6EUerJM/c
	qs9LmmOiOx5s82FbhLbJlqoqF62QyI8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80AE213800;
	Mon,  1 Jul 2024 17:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LVtiH0npgmaUKQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 01 Jul 2024 17:37:13 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.10-rc7
Date: Mon,  1 Jul 2024 19:36:54 +0200
Message-ID: <cover.1719854274.git.dsterba@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8764621BFC
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Hi,

please pull the following branch. It contains a fixup for a recent fix
that prevents an infinite loop during block group reclaim.
Unfortunately it introduced an unsafe way of updating block group list
and could race with relocation.  This could be hit on fast devices when
relocation/balance does not have enough space.

Thanks.

----------------------------------------------------------------
The following changes since commit a7e4c6a3031c74078dba7fa36239d0f4fe476c53:

  btrfs: qgroup: fix quota root leak after quota disable failure (2024-06-25 00:35:50 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc6-tag

for you to fetch changes up to 48f091fd50b2eb33ae5eaea9ed3c4f81603acf38:

  btrfs: fix adding block group to a reclaim list and the unused list during reclaim (2024-07-01 17:33:15 +0200)

----------------------------------------------------------------
Naohiro Aota (1):
      btrfs: fix adding block group to a reclaim list and the unused list during reclaim

 fs/btrfs/block-group.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

