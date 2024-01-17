Return-Path: <linux-btrfs+bounces-1525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BD3830BB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EB62824F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C52261D;
	Wed, 17 Jan 2024 17:10:42 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEA225D9
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511441; cv=none; b=C+ZHfCXjlnq6jcPYXjSGDwkMhwuRUgjbCq3qV1JsEaW8pBvXckR4IUtc3NktAHDp9r7qMzkxyNHgy/379T2SAiwq82DYYbkbkjGc3pIKAjdxVo59x3GEjRefDP8upXM+mtvgbETG9fRHtajJc0w2Dk4LEradFCB60VKycT74Zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511441; c=relaxed/simple;
	bh=iQLFaABsydZP3txZrXDDRhbpGCqbNid/aGXHcmxU2iw=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=n8XfLatkUZ4L78ALirRlpMG/RjBxThvAS1lxEh18he5woP7y1W+K2pgxPkLBidEJuTRZbTMxA36It2KSIBGLgE/eGglokd7r5dOAymWQV87+7H0+0o/f812SR1OM4LKcSs9eDo2E0yS03LxdhS0+IJhpE1vdbHkr9TOpLG/DgzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DED322011;
	Wed, 17 Jan 2024 17:10:37 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 676B913482;
	Wed, 17 Jan 2024 17:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2tY8GQ0KqGVMUwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 17 Jan 2024 17:10:37 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: replace i_blocksize by fs_info::sectorsize
Date: Wed, 17 Jan 2024 18:10:19 +0100
Message-ID: <f1aa45af286b1a85edc76ecf5b884b53accb1bb5.1705511340.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1705511340.git.dsterba@suse.com>
References: <cover.1705511340.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6DED322011
X-Spam-Flag: NO

The block size calculated by i_blocksize from inode is the same as what
we have in fs_info, initalized in inode_init_always(). Unify that to use
the fs_info value everywhere.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f8e1a7ce3d39..bd8d13740f41 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3004,7 +3004,7 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 		ret = btrfs_prealloc_file_range(inode, mode, alloc_start,
 						alloc_end - alloc_start,
-						i_blocksize(inode),
+						fs_info->sectorsize,
 						offset + len, &alloc_hint);
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			      &cached_state);
@@ -3176,7 +3176,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 		if (!ret) {
 			ret = btrfs_prealloc_file_range(inode, mode,
 					range->start,
-					range->len, i_blocksize(inode),
+					range->len, blocksize,
 					offset + len, &alloc_hint);
 			/*
 			 * btrfs_prealloc_file_range() releases space even
-- 
2.42.1


