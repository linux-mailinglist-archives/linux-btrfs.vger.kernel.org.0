Return-Path: <linux-btrfs+bounces-11979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE3A4C3E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886051894AC9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920D5213E60;
	Mon,  3 Mar 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ew4E1bcz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ew4E1bcz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AFD1F3BA3
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013717; cv=none; b=WubWn7ZaApIiTYkh/Y0izkzIA9ignN8kMrvigP75MM5ydvxoho4ozdL9V4qp40X2TT31d+ulhgY9rh5Q04/0t4ped3V4E7dwN/l26YCh4mWtU+dlRkdwb3Bf4htCi6mwqdfEY3nCQnqZU7pkJsJdwWpKdKeeHz80S17TH8w/zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013717; c=relaxed/simple;
	bh=gMUk1pN8FazRgnNRZKkUmnqFOVaxJOeGQT2mEO77xeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l7Cx49zjoU8jdaJk1XGC8ZsVc/qlyUah0wcFTrhtlvYuXi4lhWTUEOpgT07RG/VEmoBf32WPTOdxQqxvXJvUM/Ar85cLSTbcjfE4/dwFp6Y6FlES6HnNZW5+PzBFb9ey0k7rvX65y94Erw9AxXqIIvQIu3bhIj+brgqXCN8M78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ew4E1bcz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ew4E1bcz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02FF221182;
	Mon,  3 Mar 2025 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FtdpKDWWY7/Mzc/yp+3QS2yNyvP5xMM2rR9J4CTdzBQ=;
	b=ew4E1bczkT6rscKOInUSfjlV9NTDwTH6UK/XNJVNd0zj17JrL36weMjH5jsLalopKGwUId
	ubpdTOqzIAir+kkR1Tq/Q/wz0i5Dz2wALSz6hKcfamxcVczNziJjY+OgMO8WKwIEQN4JEv
	Bni6lkj0whPwt+PDnehzIiFmxgtjSbM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ew4E1bcz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FtdpKDWWY7/Mzc/yp+3QS2yNyvP5xMM2rR9J4CTdzBQ=;
	b=ew4E1bczkT6rscKOInUSfjlV9NTDwTH6UK/XNJVNd0zj17JrL36weMjH5jsLalopKGwUId
	ubpdTOqzIAir+kkR1Tq/Q/wz0i5Dz2wALSz6hKcfamxcVczNziJjY+OgMO8WKwIEQN4JEv
	Bni6lkj0whPwt+PDnehzIiFmxgtjSbM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F06A913939;
	Mon,  3 Mar 2025 14:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tMmrOtDCxWcjAwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 03 Mar 2025 14:55:12 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/7] More parameter cleanups
Date: Mon,  3 Mar 2025 15:55:10 +0100
Message-ID: <cover.1741012265.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02FF221182
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

More const, renames and type switches.

David Sterba (7):
  btrfs: parameter constification in ioctl.c
  btrfs: pass btrfs_root pointers to send ioctl parameters
  btrfs: pass root pointers to search tree ioctl helpers
  btrfs: pass struct btrfs_inode to btrfs_sync_inode_flags_to_i_flags()
  btrfs: simplify local variables in btrfs_ioctl_resize()
  btrfs: pass struct to btrfs_ioctl_subvol_getflags()
  btrfs: unify inode variable naming

 fs/btrfs/inode.c  |  32 ++++----
 fs/btrfs/ioctl.c  | 188 +++++++++++++++++++++++-----------------------
 fs/btrfs/ioctl.h  |   4 +-
 fs/btrfs/send.c   |   3 +-
 fs/btrfs/send.h   |   4 +-
 fs/btrfs/verity.c |   4 +-
 6 files changed, 115 insertions(+), 120 deletions(-)

-- 
2.47.1


