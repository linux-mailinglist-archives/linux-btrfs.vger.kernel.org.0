Return-Path: <linux-btrfs+bounces-713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ABE80723F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 15:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E37281CC4
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B766D3EA60;
	Wed,  6 Dec 2023 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lSbz0iem"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876B9D4D
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 06:22:52 -0800 (PST)
Received: from ds.suse.cz (unknown [10.100.12.205])
	by smtp-out1.suse.de (Postfix) with ESMTP id A8AC52207B;
	Wed,  6 Dec 2023 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701872570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1XMy5oUkj27MX0cg1vN8k/TDlELlQEFp8/7ghkz9m6E=;
	b=lSbz0iem7h6NCAbpDMz8YvmSMKUB9TdJ9bSuYha+0mBerWnyvJ/R8vplCxJpI9A7u76U9t
	aD4IIYq9ibgZTHGT4WBB55/nMuFGd9I2+wkC/nBAmwHoEzmJI42evgLUOEQK10Zns/gUuW
	+BYySY8tL+VlMn2qLSV2NC8Qym9jX68=
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 7343DDA900; Wed,  6 Dec 2023 15:16:01 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/1 v2] Convert btrfs_root::delayed_nodes_tree to xarray
Date: Wed,  6 Dec 2023 15:16:01 +0100
Message-ID: <cover.1701871671.git.dsterba@suse.com>
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
X-Spam-Score: 5.10
X-Spamd-Result: default: False [5.10 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_COUNT_ZERO(0.00)[0];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-0.00)[21.44%]

v2:
- rework it so we can still use GFP_NOFS for allocation, emulating the
  preload mechanism with the xarray API, no changes to locking needed
- tested with error injections instead of xa_reserve()

v1:

This restarts the radix-tree to xarray conversion that we had to revert.
There are two more structures to convert, possibly with also spinlock to
mutex conversions needed (buffer_radix and fs_roots_radix), but for the
buffer radix I don't want to do now as we have the folio conversion
ongoing. The fs_roots will most likely need the lock conversion so
that's a change that I want to take the whole dev cycle, planned for 6.9.

David Sterba (1):
  btrfs: switch btrfs_root::delayed_nodes_tree to xarray from radix-tree

 fs/btrfs/ctree.h         |  6 ++--
 fs/btrfs/delayed-inode.c | 64 ++++++++++++++++++++++------------------
 fs/btrfs/disk-io.c       |  3 +-
 fs/btrfs/inode.c         |  2 +-
 4 files changed, 41 insertions(+), 34 deletions(-)

-- 
2.42.1


