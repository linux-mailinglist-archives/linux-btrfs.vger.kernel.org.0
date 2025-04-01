Return-Path: <linux-btrfs+bounces-12735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7742A7852A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 01:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B73D188FEF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0A2215178;
	Tue,  1 Apr 2025 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ThhXFwvu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ThhXFwvu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78811A5BB0
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549503; cv=none; b=Gdp+P2MFT2vYqNFNc03rIQfOzkxP/w7gjPEdcJ9SBftCXdBdX9UnCTytgVq62entnTYdn8h33miblpTAcAAJMsX/hcpeC6lrRAnrD7S8rx9SPEx5stA/7k8oe7XWj6RBch1NYqhutETjJuU5zxH6WBHqUg83YIIcW78Ov5jTBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549503; c=relaxed/simple;
	bh=KhICuuUpvYd9gcVjc2dMyVvmDVB9K+rEOYZhq7+3bU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pc7fSgfm04NdH5xua0zsmigm6HWyH73NGpeAKtfbUthRqC01j+pVWXSOCkvXDgY7Sw6zA7IVIv9ZPmIUhrHJizU/PMVSO7+qAz/7Z4lL4bqN56ByhywXC02sUoohs4oE2GHGWRwLnVscYliUqCkQtX8w/Eigkteswhd5Tx7Kze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ThhXFwvu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ThhXFwvu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDA4B1F38E;
	Tue,  1 Apr 2025 23:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743549499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fg7wq1U5T3k/CQx1U374mhHuLMaT14TLE5z4MaLYyEY=;
	b=ThhXFwvu+Tk814KOwdvWX10Izj7SeaPZS+J7auiJGDQBZXynyJVFn1YFv4Dcni6qhnIigR
	DQGvUiOFD9I0BR1+g3V+C8TF7USU8W74kmgRZqy5JPeBGUTMLyzdzimCkEiaGte94wKrc2
	g7JU/jvlpu8BvUh8QwhZuOUG7jo091Y=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743549499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fg7wq1U5T3k/CQx1U374mhHuLMaT14TLE5z4MaLYyEY=;
	b=ThhXFwvu+Tk814KOwdvWX10Izj7SeaPZS+J7auiJGDQBZXynyJVFn1YFv4Dcni6qhnIigR
	DQGvUiOFD9I0BR1+g3V+C8TF7USU8W74kmgRZqy5JPeBGUTMLyzdzimCkEiaGte94wKrc2
	g7JU/jvlpu8BvUh8QwhZuOUG7jo091Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B54EB13691;
	Tue,  1 Apr 2025 23:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tx9ELDt07GekewAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Apr 2025 23:18:19 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/7] More btrfs_path auto cleaning
Date: Wed,  2 Apr 2025 01:18:05 +0200
Message-ID: <cover.1743549291.git.dsterba@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

A few more conversions to automatic freeing of btrfs_path, same
separation as last time, first patch with the trivial ones and separated
when there are goto/return conversion.

David Sterba (7):
  btrfs: do more trivial BTRFS_PATH_AUTO_FREE conversions
  btrfs: use BTRFS_PATH_AUTO_FREE in may_destroy_subvol()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_set_inode_index_count()
  btrfs: use BTRFS_PATH_AUTO_FREE in can_nocow_extent()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_encoded_read_inline()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_del_inode_extref()
  btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_inode_extref()

 fs/btrfs/block-group.c      |   3 +-
 fs/btrfs/fiemap.c           |   3 +-
 fs/btrfs/file-item.c        |   3 +-
 fs/btrfs/file.c             |   3 +-
 fs/btrfs/free-space-cache.c |   3 +-
 fs/btrfs/inode-item.c       |  31 ++++-----
 fs/btrfs/inode.c            | 123 ++++++++++++++----------------------
 7 files changed, 65 insertions(+), 104 deletions(-)

-- 
2.48.1


