Return-Path: <linux-btrfs+bounces-2805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CF0867C9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C68C1F2C318
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550B12CD83;
	Mon, 26 Feb 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jzVIbQ+Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jzVIbQ+Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92012C522;
	Mon, 26 Feb 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966236; cv=none; b=ETNbZqpz5XpyLIhepbdIlOrptW19JddyiJz67d34OzqPQY467fO1Ejh+DWYJlRanrfLXGOdWqcdeF87OqX2fEJosXcbmHCOMZnRelUn9y/dVSWgrjVQjUHX1I5hb8Q4AxXjidOUUPlSeLMbo6JhGECaFEiqv9fwnBZe5ejzRTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966236; c=relaxed/simple;
	bh=zFDIMUC+lqSpZcHbyK06xZsz4qOXYCnZ94ay5MgE1fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xf8B36xMXLZJdP/VeDx5aBN0tWTtRmzjpd0s6lgADEVUOZyJnIdDxo4CKyszfbLmXXI7eI2kSMyKJE5syHh2oU6QXANpyDEMBwKtgsvkEdOYHCj26jlAd1iDz+IbTSnoUnPMQOL3R0VB3wbGLgDlQEUygWkE0KFhCyvdqYxbcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jzVIbQ+Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jzVIbQ+Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEA1F22234;
	Mon, 26 Feb 2024 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708966231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vSafhwLE+1aCEASRiDt9ClUCXjXwFnHWlE/OOquVbwU=;
	b=jzVIbQ+YuBJxiqK/9P59wPFCUqphbhgCNjuzwAG3PwzG4LqztEIPytAIUKvJxMtJ357Zfc
	3AJ1CFGm39C8eOc0MrbiBQW9noo6kRWAyBOswvblE37y4sc34ufmMXHlbge8q+1+KwOTtN
	Uc7k5uWGzBveLcuA7EI3dGBF2F3QIcU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708966231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vSafhwLE+1aCEASRiDt9ClUCXjXwFnHWlE/OOquVbwU=;
	b=jzVIbQ+YuBJxiqK/9P59wPFCUqphbhgCNjuzwAG3PwzG4LqztEIPytAIUKvJxMtJ357Zfc
	3AJ1CFGm39C8eOc0MrbiBQW9noo6kRWAyBOswvblE37y4sc34ufmMXHlbge8q+1+KwOTtN
	Uc7k5uWGzBveLcuA7EI3dGBF2F3QIcU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A48CD1329E;
	Mon, 26 Feb 2024 16:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oD7kJ1fB3GUVAwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 26 Feb 2024 16:50:31 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.8-rc7
Date: Mon, 26 Feb 2024 17:49:20 +0100
Message-ID: <cover.1708962398.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jzVIbQ+Y
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: AEA1F22234
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Hi,

a few more fixes for recently reported or discovered problems. Please
pull, thanks.

- fix corner case of send that would generate potentially large stream
  of zeros if there's a hole at the end of the file

- fix chunk validation in zoned mode on conventional zones, it was
  possible to create chunks that would not be allowed on sequential
  zones

- fix validation of dev-replace ioctl filenames

- fix KCSAN warnings about access to block reserve struct members

----------------------------------------------------------------
The following changes since commit b0ad381fa7690244802aed119b478b4bdafc31dd:

  btrfs: fix deadlock with fiemap and extent locking (2024-02-19 11:20:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc6-tag

for you to fetch changes up to c7bb26b847e5b97814f522686068c5628e2b3646:

  btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve (2024-02-22 12:15:12 +0100)

----------------------------------------------------------------
David Sterba (1):
      btrfs: dev-replace: properly validate device names

Filipe Manana (3):
      btrfs: send: don't issue unnecessary zero writes for trailing hole
      btrfs: fix data races when accessing the reserved amount of block reserves
      btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve

Johannes Thumshirn (1):
      btrfs: zoned: don't skip block group profile checks on conventional zones

 fs/btrfs/block-rsv.c   |  2 +-
 fs/btrfs/block-rsv.h   | 32 ++++++++++++++++++++++++++++++++
 fs/btrfs/dev-replace.c | 24 ++++++++++++++++++++----
 fs/btrfs/send.c        | 17 +++++++++++++----
 fs/btrfs/space-info.c  | 26 +++++++++++++-------------
 fs/btrfs/zoned.c       |  9 +++++++++
 6 files changed, 88 insertions(+), 22 deletions(-)

