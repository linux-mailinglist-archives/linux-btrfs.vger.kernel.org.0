Return-Path: <linux-btrfs+bounces-7578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64663961989
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB10B21CC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E91D4143;
	Tue, 27 Aug 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fVpCmR+r";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fVpCmR+r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D4185B72
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795718; cv=none; b=bCOvXZXWqsIG0+64wgi9vh3bn8um8PRqzMaBm1jX1IhPZh04DLxsB2bed6Cuc10liOm1viJLY5Ph5IkBLY2SkqEneTrvwPnuggsXdFQVaffWAhKopMzpevoU0HHG7xqrjA+bunNtlj4SOgJbvoeYCQMG45+7tpApnoJ2SPqyQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795718; c=relaxed/simple;
	bh=/poGMT7Unfl6olCiD8rs7G/wNLs2Cxzj/TVV7zmSo+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCR19XCzY6dnWulAyzM/cahmDKjmk8PW5mjJKY5SNI9IrArqTPzkH04HuVA/SEvpgpQHGYysFuGZ9FQs/Lf7cNbuedr7N5wpcaJrhS46l4rveu7WmVQL2/6/P8mA6RV0mCljLTDB7TzSU9jnn7qZxuqJBOrZj72kHjr0R/ChN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fVpCmR+r; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fVpCmR+r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95F8F1FB85;
	Tue, 27 Aug 2024 21:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v/e9uQlNSSaM6+U8z1BLSRWqa7+FtInXRdzHNBLYFEo=;
	b=fVpCmR+r8J2ptogVTHh1Gpd5aMbLjj2DC7NXhjC/UxRWgFzzPNYrtrY+09+Yd303Mv9hL7
	VnTgOJsAqKZyCxjU3Zh+0HPkqY5cZDLEuqDP7PnlHKjgnrvpRKmu/ojpBnISLHouBSRd3a
	Fqx68OmTJBeP+HFfw9a/REd+ahBQlb8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fVpCmR+r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v/e9uQlNSSaM6+U8z1BLSRWqa7+FtInXRdzHNBLYFEo=;
	b=fVpCmR+r8J2ptogVTHh1Gpd5aMbLjj2DC7NXhjC/UxRWgFzzPNYrtrY+09+Yd303Mv9hL7
	VnTgOJsAqKZyCxjU3Zh+0HPkqY5cZDLEuqDP7PnlHKjgnrvpRKmu/ojpBnISLHouBSRd3a
	Fqx68OmTJBeP+HFfw9a/REd+ahBQlb8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F4C213A20;
	Tue, 27 Aug 2024 21:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DQf3IkFLzmZXGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/12] Renames and defrag cleanups
Date: Tue, 27 Aug 2024 23:55:10 +0200
Message-ID: <cover.1724795623.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 95F8F1FB85
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

A few simple cleanups, dropping underscores and improving some code in
defrag.

David Sterba (12):
  btrfs: rename btrfs_submit_bio() to btrfs_submit_bbio()
  btrfs: rename __btrfs_submit_bio() and drop double underscores
  btrfs: rename __extent_writepage() and drop double underscores
  btrfs: rename __compare_inode_defrag() and drop double underscores
  btrfs: constify arguments of compare_inode_defrag()
  btrfs: rename __need_auto_defrag() and drop double underscores
  btrfs: rename __btrfs_add_inode_defrag() and drop double underscores
  btrfs: rename __btrfs_run_defrag_inode() and drop double underscores
  btrfs: clear defragmented inodes using postorder in
    btrfs_cleanup_defrag_inodes()
  btrfs: return void from btrfs_add_inode_defrag()
  btrfs: drop transaction parameter from btrfs_add_inode_defrag()
  btrfs: always pass readahead state to defrag

 fs/btrfs/bio.c               |  20 +++----
 fs/btrfs/bio.h               |   6 +--
 fs/btrfs/compression.c       |   4 +-
 fs/btrfs/defrag.c            | 100 ++++++++++++++---------------------
 fs/btrfs/defrag.h            |   3 +-
 fs/btrfs/direct-io.c         |   2 +-
 fs/btrfs/extent_io.c         |  34 ++++++------
 fs/btrfs/inode.c             |   8 +--
 fs/btrfs/scrub.c             |  10 ++--
 fs/btrfs/subpage.c           |   4 +-
 include/trace/events/btrfs.h |   2 +-
 11 files changed, 86 insertions(+), 107 deletions(-)

-- 
2.45.0


