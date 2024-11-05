Return-Path: <linux-btrfs+bounces-9333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F1F9BC5F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 07:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615401F22E70
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 06:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2651FCC77;
	Tue,  5 Nov 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FMauqFPf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iNP4Z6M5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D66186284
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789322; cv=none; b=YUqgHXtWvM+9CrsgWP6DtSyBUAZfCf109J6Hq8s7HgVvptsva9XLuA+EawQN7oRg6IuF15riqMv/13GD/V8HHuZiFpOCvNB8uZd1F1j+ZUX05p8UbShyzEObjKHU+g3hO6tQjULlYm/Qnckls1b95oikMub1cqM7lKxJnRcFmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789322; c=relaxed/simple;
	bh=fqaYjrRiNF8ncYBmVVMjt7CSfjE+Zyb9B7RiPIcZIhc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KoAyoOvaz6cskQgtMe9eO5XuW0k7aq6RlXHq2brry4V6VBs8GkY6AXVVP98FmFTo9ciANG1yv/Gb05aI6z949iuDVCyijgcez5DHSIoK2nq9juQjXtSeBitR71l76TB94HGsCQ2KV6v5XBEWqt4zd0YWTFmybm172mXw5o8qvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FMauqFPf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iNP4Z6M5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E78AA1FE5A
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 06:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730789313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2GoerFyfsgzOE2aoZBJgEnrIu+RNNfM5dWZLB5U0Zls=;
	b=FMauqFPfHY3wMI4RHWy67uiSkXoo2j4S9USZU877SNorn3QgHyeImMJmJ8Sh7Ddl4GYRry
	HbteSebln27XWc5ZVYKbK6d9tJcPSfUzPIXajsC+ASczfAp5b5q5OvUksKDddz5yo0+x4e
	zCUbqc7Qktqak50fLhcoPbr8J4mnS3U=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730789312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2GoerFyfsgzOE2aoZBJgEnrIu+RNNfM5dWZLB5U0Zls=;
	b=iNP4Z6M5UmsVoz0xupls0fvjaAQX/GZ1a91qs56g0G5m9PdiM00hF7Q046Mh1AyX0eJbxP
	t95liEe9WcC1roIoc7gNnwmigJgt2S8FWpPWyTvhJP7haQ3ydxPkzHkk18jccf1o3nKMIG
	dkz5Mf/Z1m49F7b/nV6pT/2YaOGHVJU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3328013964
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 06:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GezAOb+/KWeUDgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Nov 2024 06:48:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: refactor around btrfs_insert_file_extent()
Date: Tue,  5 Nov 2024 17:18:12 +1030
Message-ID: <cover.1730788965.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Although btrfs_insert_file_extent() is a btrfs-progs specific function,
it's pretty close (although not yet similiar enough to cross-port) to
insert_reserved_file_extent() from kernel.

That kernel function uses an on-stack btrfs_file_extent_item to pass all
the needed parameters, supporting both compressed and uncompressed data
extents.

That is way more flex than btrfs_insert_file_extent() from btrfs-progs,
which can not support:

- Non-zero offset
- Ram_bytes larger than num_bytes
- Compressed extents

To prepare for the incoming support of compressed data extents
generation for mkfs --rootdir, we need a more generic way to insert file
extents.

This patch improve the situation by:

- Move btrfs_record_file_extent() to be a convert specific function
  The extra handling are all for converted btrfs, and can split extents
  where regular btrfs doesn't want.

  For mkfs/rootdir.c, the only caller out of convert, introduce a
  helper, insert_reserved_file_extent() to handle the case.

- Make btrfs_insert_file_extent() to accept an on-stack btrfs_file_extent_item
  Just like insert_reserved_file_extent() from kernel.

  Allowing us to customize ever member of the btrfs_file_extent_item.
  Now this makes btrfs_insert_file_extent() flex enough for converted
  fs, and the incoming compressed file extents.

Qu Wenruo (2):
  btrfs-progs: do not call btrfs_record_file_extent() out of
    btrfs-convert
  btrfs-progs: make btrfs_insert_file_extent() to accept an on-stack
    file extent item

 common/extent-tree-utils.c | 240 -------------------------------------
 common/extent-tree-utils.h |   5 -
 convert/common.c           | 237 +++++++++++++++++++++++++++++++++++-
 convert/common.h           |   6 +
 convert/main.c             |  10 +-
 convert/source-fs.c        |   4 +-
 convert/source-reiserfs.c  |   2 +-
 kernel-shared/file-item.c  |  44 ++-----
 kernel-shared/file-item.h  |   4 +-
 kernel-shared/file.c       |   6 +-
 mkfs/rootdir.c             | 104 +++++++++++++++-
 11 files changed, 369 insertions(+), 293 deletions(-)

--
2.47.0


