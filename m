Return-Path: <linux-btrfs+bounces-2049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A984652C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 01:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE814B2104C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506945C97;
	Fri,  2 Feb 2024 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="APSPdkdP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="APSPdkdP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604965380
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835583; cv=none; b=qOHMg0xFOd5xMLt3Pif2oyLzSieK9mBFBYkRHx4ZetIJMK53kMOx7h3FNI4JGIjx5uQs3AcnHle1Au1LaZS6zFv0WBi9vzQ3wGdCM7lvebgu9IGJI8Qeky6ki1s7qWf28p0xUbBpOnxDqeYI/OGPO05o7vhhZUvgaBOOdSScTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835583; c=relaxed/simple;
	bh=cEWNJXiGYXJQz24kMUAUVY5LQvlNV6guFRvPh/sBnEg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bKnxop1+4KKMSzXGmJAstE4tkt96nKygEZ1iL5YTY/HnbIzg0PqKcs7gJTwG6XNP0PwqgORLq7Dx0kFUkobzGMg5LX+cw7nwdM5Ektn3Fgm+WtlnFHiGZKCRw4VnkEohYjl1aFDiNz00RpGYSrqW64hTjPkGkGr3Mkk514hEDWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=APSPdkdP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=APSPdkdP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8467622087
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706835579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qxqJWTr4Ir72jifq/UCl1Jp8dGak62W3DVV8tb7Zpjo=;
	b=APSPdkdPoxJsDMZUNRdZOX/4/xzgiAius+ta4pP8lTQAa6nL3qqtxdYcRMAil+AozJncm3
	KhSVbSvDthg9PnKDuPrwosQ5Zy+cCqP8WNKmEEfCwGEFTE9TfF+ESLAkOAtJAOdEvUejKk
	wD2zjHqM/TVgfJn2Km43/jZXIMbdB1Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706835579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qxqJWTr4Ir72jifq/UCl1Jp8dGak62W3DVV8tb7Zpjo=;
	b=APSPdkdPoxJsDMZUNRdZOX/4/xzgiAius+ta4pP8lTQAa6nL3qqtxdYcRMAil+AozJncm3
	KhSVbSvDthg9PnKDuPrwosQ5Zy+cCqP8WNKmEEfCwGEFTE9TfF+ESLAkOAtJAOdEvUejKk
	wD2zjHqM/TVgfJn2Km43/jZXIMbdB1Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B873C139AB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WzmJHno+vGXABgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 00:59:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: hunt down the stray fd close causing race with udev scan
Date: Fri,  2 Feb 2024 11:29:18 +1030
Message-ID: <cover.1706827356.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=APSPdkdP
X-Spamd-Result: default: False [3.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.87%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.69
X-Rspamd-Queue-Id: 8467622087
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

Although my previous flock() based solution is preventing udev scan to
get pre-mature super blocks, it in fact masks the root problem:

  There is a stray close() on writeable fd.

Commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptors open
during whole time") tries to solve the problem by extending the lifespan
of writeable fds, so that when the fds are closed, the fs is ensured to
be properly populated.

The problem is, that patch is not covering all cases, there is a stray
fd close just under our noses: open_ctree_fs_info().

The function would open the initial device, then use that initial fd to
open the btrfs, then we immediately close the initial fd, as later IO
would all go with the device fd.

That close() call is causing problem, especially for mkfs, as at that
stage the fs is still using a temporary super block, not using the valid
btrfs super magic number.

Thus udev scan would race with mkfs, and if udev wins the race, it would
get the temporary super block, making libblk not to detect the new
btrfs.

This patchset would address the problem by:

- Make sure open_ctree*() calls all have corresponding close_ctree()
  The first patch, as later we will only close the initial fd caused by
  open_ctree_fs_info() during close_ctree().

- Save the initial fd into btrfs_fs_info for open_ctree_fs_info()
  And later close the initial fd during close_ctree().

- Make sure open_ctree_fd() callers to properly close the fd
  Just an extra cleanup.

This patchset would work even without the usage of flock() to block udev
scan, and since without flock() calls, the procedure is much simpler.

Qu Wenruo (3):
  btrfs-progs: rescue: properly close the fs for clear-ino-cache
  btrfs-progs: tune: fix the missing close()
  btrfs-progs: fix the stray fd close in open_ctree_fs_info()

 cmds/rescue.c           | 1 +
 kernel-shared/ctree.h   | 9 +++++++++
 kernel-shared/disk-io.c | 8 +++++++-
 tune/main.c             | 1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

--
2.43.0


