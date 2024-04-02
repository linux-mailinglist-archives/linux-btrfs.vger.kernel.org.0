Return-Path: <linux-btrfs+bounces-3837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF83895F59
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93B22857B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB6F15ECDA;
	Tue,  2 Apr 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I+DBJU48"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3015ECC5
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095694; cv=none; b=X8g3T3nbx8wONMv9ZUtCyiBkEtbxGARtW9Zmkr8A9gZEr56lzTjONA5hzIw3mSzkbl5w2aek+kNkW2m9y4bCsrdqPYzE1JuYzNABwcA9j+PZk9hkks7U2FQUv7bhlfJ9lXQvMbyUrVDIJHXW3ZGSJuX4bQEbjB9nazttouS8dcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095694; c=relaxed/simple;
	bh=MlpIsCa5jFcKIuYVY7LL8bDrWcMJbFMIZEPxJs92X7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXsqGYnu9STI2pDsOxaXtQDOIRMGTYA+vNVbVgHu17YNMNrcEVketWO6OZ9Pgmh690crta5SR+xQWu39M14nmEPWQLdALZ2dbhPjdFI8GjEEeayXlairX+/6PMM2octvkl4VhD8m2b3syD/BGtDWz9UrxznXJ2dDRWUtRYtcO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I+DBJU48; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A47855C3FB
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712095690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnQpUzP5gvjlC5TorASiHrgBpUrmdj1oNN2dAjhatTY=;
	b=I+DBJU48KAL/jihCtGekHAqrnfhu4zAqZLt/fa1MEo2xZKQ0eM26o4+FfElOZxHGMvTqVf
	QW3sRh+FcL5wyVWvOqFLIxUfpDCJ0PwsxSmshd/w2Qi48n17PqOj5u+YG194swx+YicSXa
	6TbKq0wJ+JAt9YQqPaefOdbydB2at+8=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C373A13A90
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8AItIcmBDGYIdwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 22:08:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs-progs: mkfs: use proper zoned compatible write for bgt feature
Date: Wed,  3 Apr 2024 08:37:37 +1030
Message-ID: <69d093d141f7e3ad02f4353d69458805fa8883bc.1712095635.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712095635.git.wqu@suse.com>
References: <cover.1712095635.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

[BUG]
There is a bug report that mkfs.btrfs can not specify block-group-tree
feature along with zoned devices:

  # mkfs.btrfs /dev/nullb0 -O block-group-tree,zoned
  btrfs-progs v6.7.1
  See https://btrfs.readthedocs.io for more information.

  Resetting device zones /dev/nullb0 (40 zones) ...
  NOTE: several default settings have changed in version 5.15, please make sure
        this does not affect your deployments:
        - DUP for metadata (-m dup)
        - enabled no-holes (-O no-holes)
        - enabled free-space-tree (-R free-space-tree)

  ERROR: error during mkfs: Invalid argument

[CAUSE]
During mkfs, we need to write all the 7 or 8 tree blocks into the
metadata zone, and since it's zoned device, we need to fulfill all the
requirement for zoned writes, including:

- All writes must be in sequential bytenr
- Buffer must be aligned to sector size

The sequential bytenr requirement is already met by the mkfs design, but
the second requirement on memory alignment is never met for metadata, as
we put the contents of a leaf in extent_buffer::data[], which is after a
lot of small members.

Thus metadata IO buffer would never be aligned to sector size (normally
4K).
And we require btrfs_pwrite() and btrfs_pread() to handle the memory
alignment for us.

However in create_block_group_tree() we didn't use btrfs_pwrite(), but
plain pwrite() call directly, which would lead to -EINVAL error due to
memory alignment problem.

[FIX]
Just call btrfs_pwrite() instead of the plain pwrite() in
create_block_group_tree().

Issue: #765
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 5e56b33dda6d..3c48a6c120e7 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -249,8 +249,8 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_header_nritems(buf, 1);
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize,
-		     cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
+	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize,
+			   cfg->blocks[MKFS_BLOCK_GROUP_TREE], cfg->zone_size);
 	if (ret != cfg->nodesize)
 		return ret < 0 ? -errno : -EIO;
 	return 0;
-- 
2.44.0


