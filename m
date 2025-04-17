Return-Path: <linux-btrfs+bounces-13123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FBFA91850
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119631902C69
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D9F22A7FE;
	Thu, 17 Apr 2025 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dgqexjx7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="usVT6zTx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E03189B8C
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883416; cv=none; b=Tw7YG3J64Vw7BZAOuXagWNxDN9xqk+Lmf3DLlRX9+Ine1/M5F9FxGd+r11FeA6iGYpGwnl+9Z0GH6Z5/ree9VkbWNY27OvTwQuHhjUIN22/9EYdQNYB09sMqnNxkkuTiQzqaBq59wlojHmT1ivaT+Tq4xCtJ2qDq12TmWl0wb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883416; c=relaxed/simple;
	bh=8ZUxKLXf9vq9waQbjl+f4Y4qonVQkqHJNmtY+21wbqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BpqJRcQGFgD060M/DzjSf6Hp0Uci5ZCS73T8/H38h/NzNYMuGtyn2DmdbLLOmo1j8hZIDclKQZClVRXHcfANv/b85aEO0fixA3Ktgu3jLnUzPjnblV3mthlxIVAfGsA1ikT9Ebm3WgjwGFojtn/uTchGkdINzoNBaB1uBJQ/7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dgqexjx7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=usVT6zTx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF0E621175;
	Thu, 17 Apr 2025 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744883413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qfiQ6961dCOMHWEgtdCh51TFHLHOvYD1aDKH/ZVB6EQ=;
	b=Dgqexjx7F4p1y7vIUY2/G3UUl51EuhLLHJbmpORHHB4zAIszVMy1Fifp7qf4YOMyrrwI0X
	cm/NEXTmrdCldHsEe+JktI4REYg0IDei6pD3iuz78JcCta9F9dn20WoCIyxUVv8heP6EP2
	9Opqlm5yI05lwjt1EFUQMdxNq5x72lA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744883412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qfiQ6961dCOMHWEgtdCh51TFHLHOvYD1aDKH/ZVB6EQ=;
	b=usVT6zTx4R7T88BgkQ2hodjrbVwlrPNWqsIbfr5WwXxOnb7HipYLeIiScQ3DEnLaM9Kpok
	VgJFVBSn2mcTRZMG+sQ6ROH7MbTGTVM3J52PRftnFBWLmL2IFzYQeyMFDg/zq+OqR+DHYe
	nEJ5EO9TUjHrnIoidfe/oUCn7Y2P4/s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDC1F137CF;
	Thu, 17 Apr 2025 09:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ww0eNtTOAGhqfQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 17 Apr 2025 09:50:12 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.15-rc3
Date: Thu, 17 Apr 2025 11:49:55 +0200
Message-ID: <cover.1744883021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
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

please pull a few fixes, thanks.

- handle encoded read ioctl returning EAGAIN so it does not mistakenly
  free the work structure

- escape subvolume path in mount option list so it cannot be wrongly
  parsed when the path contains ","

- remove folio size assertions when writing super block to device with
  enabled large folios

----------------------------------------------------------------
The following changes since commit 35fec1089ebb5617f85884d3fa6a699ce6337a75:

  btrfs: zoned: fix zone finishing with missing devices (2025-03-18 20:35:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc2-tag

for you to fetch changes up to 65f2a3b2323edde7c5de3a44e67fec00873b4217:

  btrfs: remove folio order ASSERT()s in super block writeback path (2025-04-01 01:02:42 +0200)

----------------------------------------------------------------
Johannes Kimmel (1):
      btrfs: correctly escape subvol in btrfs_show_options()

Qu Wenruo (1):
      btrfs: remove folio order ASSERT()s in super block writeback path

Sidong Yang (1):
      btrfs: ioctl: don't free iov when btrfs_encoded_read() returns -EAGAIN

 fs/btrfs/disk-io.c | 2 --
 fs/btrfs/ioctl.c   | 2 ++
 fs/btrfs/super.c   | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

