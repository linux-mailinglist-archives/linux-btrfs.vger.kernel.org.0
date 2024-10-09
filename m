Return-Path: <linux-btrfs+bounces-8709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018BA996DE1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3AF1F23E48
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD76198833;
	Wed,  9 Oct 2024 14:31:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB418EAD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484298; cv=none; b=R9D1mS76bgf9fWTsMn/ipDTzK9vIiCTjz2jx+3btc0gdIXrpi6oH6MKam6sgKf9nAoYRVmteXhgAXq754FgYWSNRy9OaAPh08xkPXmq6mXHhFEl8FK4AvdserFhfX7gmomaxfLSRlh2dGoNd4diG5B8HMuPLlWzPY+j7ESFi62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484298; c=relaxed/simple;
	bh=Rpr7LeS0amEW+UJHHDhnPeb4laqqbPUYRHsnuolG91c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWpeVYq6eMXYu/dsKg+fSd2AbTREXoICFNB5dfmrNkaicyPkkr0Wj/J6nqgzRsEudEllzlW11qRYmVMtuTF9KT1yqNNvA4JOYnvt/WCfokvHTP96mylMxyMdJ8PPmW7kXDXPJQ1gLjMIIp6n26RDJmbHKMXaK1hpGywssifC2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEE221F80B;
	Wed,  9 Oct 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACF59136BA;
	Wed,  9 Oct 2024 14:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 85A1KsaTBmc3RQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:34 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 14/25] btrfs: drop unused parameter inode from read_inline_extent()
Date: Wed,  9 Oct 2024 16:31:34 +0200
Message-ID: <9ebe28d8e869f3f5de9fbaa41d92489e6c7061cd.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BEE221F80B
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

We don't need the inode pointer to read inline extent, it's all
accessible from the path pointer.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b0ad46b734c3..1941939f3e48 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6737,8 +6737,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	return ret;
 }
 
-static int read_inline_extent(struct btrfs_inode *inode, struct btrfs_path *path,
-			      struct folio *folio)
+static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 {
 	struct btrfs_file_extent_item *fi;
 	void *kaddr;
@@ -6936,7 +6935,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		ASSERT(em->disk_bytenr == EXTENT_MAP_INLINE);
 		ASSERT(em->len == fs_info->sectorsize);
 
-		ret = read_inline_extent(inode, path, folio);
+		ret = read_inline_extent(path, folio);
 		if (ret < 0)
 			goto out;
 		goto insert;
-- 
2.45.0


