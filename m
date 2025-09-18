Return-Path: <linux-btrfs+bounces-16951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC295B874D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 00:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBB1565E31
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 22:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E331329C;
	Thu, 18 Sep 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C7BgHuZC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C7BgHuZC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441130DEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236351; cv=none; b=fIcIKOBpxNZjMNE357/X+XCENkJsBJCPqaR2UOyUjSBxiv3DgTOsoAyoRxo/9/EdUC1654T1hXyT5XrdJeWaHDX1GW9mN9NA+E98vfz4aoxiMeLlUjKVNTedR7x/Off4sVaTRmmpQdI/LZVYQ1c4yi4hc4qcxOgfLJFAAUkZIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236351; c=relaxed/simple;
	bh=cni6Mc0/HZYteY8uqh7T5oDKyDZi/Ge8I/dthMkji4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUv0ShHX/HxTYrAeM8jHOuCbtEx7ukEbP17UIU1EX8lhmLS2f8Duz1JqM03AAlfoiDk15LGgMS61xDc4hcDYOf0aibz+ITzfiaCzItO1CJXetmxJlLcmtnRpV84mTje6Mq+ZVnnk6EcHDNPZO3+RoLwh0PL8ki9Bs45id12hWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C7BgHuZC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C7BgHuZC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAE2F1F443
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758236344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFtCzVovxb985LFcZXUQRfEC/kA8kpOGTXigPJlLmMg=;
	b=C7BgHuZCBwn5s0m31RxZz+qD1hyhvPKIge8SB70XHT9AxRR2OOvR6/s39RstG5AiIN3ex2
	7BPpCJAFFrMDWXl+ERGqQ9PCtGR86t9VZyLQBVMfdELGn+2mY/fVmiQjoe7h/JXCiDMqAz
	icjExSVMetIfABE1fyWanU6ODSAHK/w=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=C7BgHuZC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758236344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFtCzVovxb985LFcZXUQRfEC/kA8kpOGTXigPJlLmMg=;
	b=C7BgHuZCBwn5s0m31RxZz+qD1hyhvPKIge8SB70XHT9AxRR2OOvR6/s39RstG5AiIN3ex2
	7BPpCJAFFrMDWXl+ERGqQ9PCtGR86t9VZyLQBVMfdELGn+2mY/fVmiQjoe7h/JXCiDMqAz
	icjExSVMetIfABE1fyWanU6ODSAHK/w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2053E13A39
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cHXWNLeOzGjiYAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:59:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: fix symbolic link reading when bs > ps
Date: Fri, 19 Sep 2025 08:28:36 +0930
Message-ID: <b96b27199851815eb30e4d793ddd88c181b2071e.1758236028.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758236028.git.wqu@suse.com>
References: <cover.1758236028.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: DAE2F1F443
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[BUG DURING BS > PS TEST]
When running the following script on a btrfs whose block size is larger
than page size, e.g. 8K block size and 4K page size, it will trigger a
kernel BUG:

 # mkfs.btrfs -s 8k $dev
 # mount $dev $mnt
 # mkdir $mnt/dir
 # ln -s dir $mnt/link
 # ls $mnt/link

The call trace looks like this:

 BTRFS warning (device dm-2): support for block size 8192 with page size 4096 is experimental, some features may be missing
 BTRFS info (device dm-2): checking UUID tree
 BTRFS info (device dm-2): enabling ssd optimizations
 BTRFS info (device dm-2): enabling free space tree
 NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030
 ------------[ cut here ]------------
 kernel BUG at /home/adam/linux/include/linux/highmem.h:275!
 Oops: invalid opcode: 0000 [#1] SMP
 CPU: 8 UID: 0 PID: 667 Comm: ls Tainted: G           OE       6.17.0-rc4-custom+ #283 PREEMPT(full)
 Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
 RIP: 0010:zero_user_segments.constprop.0+0xdc/0xe0 [btrfs]
 Call Trace:
  <TASK>
  btrfs_get_extent.cold+0x85/0x101 [btrfs 7453c70c03e631c8d8bfdd4264fa62d3e238da6f]
  btrfs_do_readpage+0x244/0x750 [btrfs 7453c70c03e631c8d8bfdd4264fa62d3e238da6f]
  btrfs_read_folio+0x9c/0x100 [btrfs 7453c70c03e631c8d8bfdd4264fa62d3e238da6f]
  filemap_read_folio+0x37/0xe0
  do_read_cache_folio+0x94/0x3e0
  __page_get_link.isra.0+0x20/0x90
  page_get_link+0x16/0x40
  step_into+0x69b/0x830
  path_lookupat+0xa7/0x170
  filename_lookup+0xf7/0x200
  ? set_ptes.isra.0+0x36/0x70
  vfs_statx+0x7a/0x160
  do_statx+0x63/0xa0
  __x64_sys_statx+0x90/0xe0
  do_syscall_64+0x82/0xae0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
  </TASK>

Please note bs > ps support is still under development and the
enablement patch is not even in btrfs development branch.

[CAUSE]
Btrfs reuses its data folio read path to handle symbolic links, as the
symbolic link target is stored as an inline data extent.

But for newly created inodes, btrfs only set the minimal order if the
target inode is a regular file.

Thus for above newly created symbolic link, it doesn't properly respect
the minimal folio order, and triggered the above crash.

[FIX]
Call btrfs_set_inode_mapping_order() unconditionally inside
btrfs_create_new_inode().

For symbolic links this will fix the crash as now the folio will meet
the minimal order.

For regular files this brings no change.

For directory/bdev/char and all the other types of inodes, they won't
go through the data read path, thus no effect either.

Fixes: cc38d178ff33 ("btrfs: enable large data folio support under CONFIG_BTRFS_EXPERIMENTAL")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6b52ab164f45..601a20396171 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6506,6 +6506,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	if (!args->subvol)
 		btrfs_inherit_iflags(BTRFS_I(inode), BTRFS_I(dir));
 
+	btrfs_set_inode_mapping_order(BTRFS_I(inode));
 	if (S_ISREG(inode->i_mode)) {
 		if (btrfs_test_opt(fs_info, NODATASUM))
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
@@ -6513,7 +6514,6 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
 				BTRFS_INODE_NODATASUM;
 		btrfs_update_inode_mapping_flags(BTRFS_I(inode));
-		btrfs_set_inode_mapping_order(BTRFS_I(inode));
 	}
 
 	ret = btrfs_insert_inode_locked(inode);
-- 
2.50.1


