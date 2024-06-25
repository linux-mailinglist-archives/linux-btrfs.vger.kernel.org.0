Return-Path: <linux-btrfs+bounces-5947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0CE915DEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 07:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4834D1F22CEA
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 05:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2B0143C6A;
	Tue, 25 Jun 2024 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ti9n1wgb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ti9n1wgb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1413C9B8
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292077; cv=none; b=p2xUw20WUvEWcPI95IUvL63oaLDLumk80ObuFOZl9D2IUdMnXDawgQz09J4CyGQ4t2S0T/JgicMLwp8zxD9KIqb/GC/FOV0eDMAPC9utIzQHQGEkt0hd1p71nyn/VNKGo3cs36Up4DJEC4pii0cohyOoDzkrp3m1ua2wGBGlhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292077; c=relaxed/simple;
	bh=Ud8uz3LaVyamRrU+baHuy0R7di8umxwcbICDdEb0rEI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q0+mYXpYTBELT2wCUUrgBzfK3eX+tbckGAmi1A8AoQ65LMDB+QnzCYOvlC5BlTlzQojMuWd9BRCyOLcPpbsPM66wHjLcxKbDHcBIv8VeKCzVY6R+L90LBNKrk8q3KsiofPklbpNKtOcuvwOshDquzgrGEDP+iKvIPmkNrW+OxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ti9n1wgb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ti9n1wgb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C26431F834
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t9aP3pmW09KP2P0GJjMc0utIXUloYNcjt+3Bnuvwuv8=;
	b=Ti9n1wgb3DS0VlpivFDF06VMjMHUDfstC520Pu6GE3QOb3W2O3lX3L047A0mWNV5KD34f/
	Bfp2d6kGI26QHbj6T9CnlqvZoRi0DMJ+WTcqI6NBX1avP19TW1EEqDPVjYXL2lc2GQpoV+
	zZoAziD1756DPdr9RBo7NjNWGIKnN+A=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ti9n1wgb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t9aP3pmW09KP2P0GJjMc0utIXUloYNcjt+3Bnuvwuv8=;
	b=Ti9n1wgb3DS0VlpivFDF06VMjMHUDfstC520Pu6GE3QOb3W2O3lX3L047A0mWNV5KD34f/
	Bfp2d6kGI26QHbj6T9CnlqvZoRi0DMJ+WTcqI6NBX1avP19TW1EEqDPVjYXL2lc2GQpoV+
	zZoAziD1756DPdr9RBo7NjNWGIKnN+A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC7831384C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JSaGJKhQembqdgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: detect and fix the ram_bytes mismatch
Date: Tue, 25 Jun 2024 14:37:26 +0930
Message-ID: <cover.1719291793.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C26431F834
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

There is a long existing mismatch between ram_bytes and disk_num_bytes
for regular non-compressed data extents.

It turns out to be caused by truncated ordered extents, which modified
ram_bytes unnecessarily.

Thankfully this is not going to cause any data corruption or whatever,
kernel can handle it correctly without any extra problem.
It's only a small violation on the on-disk format.

This series would fix by:

- Cleanup the @bytenr usage inside btrfs_extent_item_to_extent_map()
- Override the ram_bytes when reading file extent items from disk
  So that we always get correct extent maps even if the on-disk one is
  incorrect.
- Add the proper fix for the ram_bytes mismatch
- Add a tree-checker for the ram_bytes mismatch
  Since we can have on-disk ram_bytes incorrect already, this check is
  only for DEBUG and ASSERT builds, and it won't report error but only
  does a kernel warning for us to catch.

Qu Wenruo (4):
  btrfs: cleanup the bytenr usage inside
    btrfs_extent_item_to_extent_map()
  btrfs: make validate_extent_map() to catch ram_bytes mismatch
  btrfs: fix the ram_bytes assignment for truncated ordered extents
  btrfs: tree-checker: add extra ram_bytes and disk_num_bytes check

 fs/btrfs/extent_map.c   |  5 +++++
 fs/btrfs/file-item.c    |  9 ++++-----
 fs/btrfs/inode.c        |  4 +---
 fs/btrfs/tree-checker.c | 19 +++++++++++++++++++
 4 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.45.2


