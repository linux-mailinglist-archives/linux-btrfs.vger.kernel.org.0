Return-Path: <linux-btrfs+bounces-13338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B72FA995CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8DC3A7129
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5D28935A;
	Wed, 23 Apr 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m4Umciqu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m4Umciqu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236C288CA0
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427253; cv=none; b=SpUOMXdZ5lvKBSFD12w0Tg5SH4Ru80H4PG3zh156uAHvwnebZu5uEvsOVtzpmv7IAEcgiF4sXvpn+r2mtN0C91cBPvN68vNd5EVgUQUwkO/2lpH0jE+R1kj+NyEuN1TWgPKh3/ZQSpmCDF4ZyjL8POVWVHZLZNYlYXhcZAYC6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427253; c=relaxed/simple;
	bh=+nKOFjZgwRGs0i06I9IpQIKfotFbCe6Ob08ji9dO2gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1V7h3jfllawcP5Grk5kTetSWurcgeFB2dIw7xMCyRp+HbY2fpizINjTD/sxkocpi/vpQm9XJ5eURCsNrC4WHkg5eQDop84unoQKmRqc2WxOOgj++/NlOOG76zmet6j3e6tI0NYroYz2YX/YwZX7EJ8r1gH9VYNc9qD2bG+J/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m4Umciqu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m4Umciqu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 124C41F449;
	Wed, 23 Apr 2025 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745427249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i4ajzk7HUAZUeZX7n8+i7IZcuw20XDYxnqibv37YBAI=;
	b=m4UmciquXBjSkovyldEpotBFeF9A5zpeTEOYYbN9eueTRxdg8DscR0kE7EtwTmVFlLkVxq
	4JqFCK6/w+1dfYlJdPPstf1iFfrUDW3rEFzlfFcWyDHP0Tm3p0aYrCOKpOf5DI03D+MIic
	3HSvcimrC5BKZWgswGEnv7HMvVeYkX0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=m4Umciqu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745427249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i4ajzk7HUAZUeZX7n8+i7IZcuw20XDYxnqibv37YBAI=;
	b=m4UmciquXBjSkovyldEpotBFeF9A5zpeTEOYYbN9eueTRxdg8DscR0kE7EtwTmVFlLkVxq
	4JqFCK6/w+1dfYlJdPPstf1iFfrUDW3rEFzlfFcWyDHP0Tm3p0aYrCOKpOf5DI03D+MIic
	3HSvcimrC5BKZWgswGEnv7HMvVeYkX0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 081EA13A3D;
	Wed, 23 Apr 2025 16:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1KyxATEbCWg5GQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 16:54:09 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Bool return cleanups
Date: Wed, 23 Apr 2025 18:53:56 +0200
Message-ID: <cover.1745426584.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 124C41F449
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

We have old code that uses int in place of bool, unify it to bool.  The
rest are collateral fixups.

David Sterba (3):
  btrfs: trivial conversion to return bool instead of int
  btrfs: switch int dev_replace_is_ongoing variables/parameters to bool
  btrfs: reformat comments in acls_after_inode_item()

 fs/btrfs/block-group.c   |  12 ++---
 fs/btrfs/defrag.c        |   8 +--
 fs/btrfs/delayed-inode.c |   8 +--
 fs/btrfs/dev-replace.c   |   8 +--
 fs/btrfs/dev-replace.h   |   2 +-
 fs/btrfs/extent-tree.c   |  10 ++--
 fs/btrfs/file.c          |  33 ++++++-------
 fs/btrfs/inode.c         |  51 +++++++++++--------
 fs/btrfs/ioctl.c         |  10 ++--
 fs/btrfs/locking.c       |   8 +--
 fs/btrfs/locking.h       |   2 +-
 fs/btrfs/super.c         |   6 +--
 fs/btrfs/transaction.c   |   8 +--
 fs/btrfs/volumes.c       | 104 ++++++++++++++++++---------------------
 14 files changed, 136 insertions(+), 134 deletions(-)

-- 
2.49.0


