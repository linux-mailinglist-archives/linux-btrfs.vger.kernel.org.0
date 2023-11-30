Return-Path: <linux-btrfs+bounces-458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923417FFEC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FA31C20B56
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D102F61FA9;
	Thu, 30 Nov 2023 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hGduInEU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC8CA
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 14:56:21 -0800 (PST)
Received: from ds.suse.cz (unknown [10.100.12.205])
	by smtp-out1.suse.de (Postfix) with ESMTP id 410D921BA7;
	Thu, 30 Nov 2023 22:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701384979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bauoNWAI5Fm5pyFrB5Bsvt5Cuy2Na7yE5OOICgnmWH8=;
	b=hGduInEUd0E/1WDYVFC+RkfAbtDfJCzyhGulYKh8nv4CiaTlVVsq4AZENFtMCsRlwqSj7i
	6OJlXU4UJPSGQewydnIO+k0KofOfXnpe5l3ZkcUksjQ2LL4xIb03b5iJNyYzUDfpwPVOH3
	UuZV0kdevpEM0usG5TwD2rQH8sFY508=
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 6A414DA86C; Thu, 30 Nov 2023 23:49:06 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Convert btrfs_root::delayed_nodes_tree to xarray
Date: Thu, 30 Nov 2023 23:49:06 +0100
Message-ID: <cover.1701384168.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 8.63
X-Spamd-Result: default: False [8.63 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_SPAM_LONG(3.33)[0.952];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_COUNT_ZERO(0.00)[0];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-0.00)[27.10%]

This restarts the radix-tree to xarray conversion that we had to revert.
There are two more structures to convert, possibly with also spinlock to
mutex conversions needed (buffer_radix and fs_roots_radix), but for the
buffer radix I don't want to do now as we have the folio conversion
ongoing. The fs_roots will most likely need the lock conversion so
that's a change that I want to take the whole dev cycle, planned for 6.9.

David Sterba (2):
  btrfs: drop radix-tree preload from btrfs_get_or_create_delayed_node()
  btrfs: use xarray for btrfs_root::delayed_nodes_tree instead of
    radix-tree

 fs/btrfs/ctree.h         |  6 +--
 fs/btrfs/delayed-inode.c | 86 +++++++++++++++++++---------------------
 fs/btrfs/disk-io.c       |  3 +-
 fs/btrfs/inode.c         |  2 +-
 4 files changed, 47 insertions(+), 50 deletions(-)

-- 
2.42.1


