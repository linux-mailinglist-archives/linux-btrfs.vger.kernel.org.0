Return-Path: <linux-btrfs+bounces-14538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA5AAD0A6E
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 01:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11E517728C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 23:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855FD23F413;
	Fri,  6 Jun 2025 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bviYki49";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bviYki49"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB223AE87
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253746; cv=none; b=Iz7sgRfhDiKIp5cwV7c61dzR6k+jrMNPfqoJcC5EZ42ZP9axohQKUOVnQ0ICyUQ/6OBQC+AyHmR1842QwOJK4bLgQBq4zfweVk/yALHyhA9zpZapg434E44peXDxC5yNIP35b83D8i1J2IQdI0KYia9Q2eytno+kcF/yIyTKFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253746; c=relaxed/simple;
	bh=pRbaWLlIaKgrU3UTU8W5HHUKyJfIK6e8kPBCGa0J+ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUlrwkzfKUy8jLNBplQBSHyIeplCYE8wdSNL44YZNizDAP/3To3aG4iePnzxa/BvZpRpjqAN7Lid6t53bkURychBGQGexa7aDb9DGnpsfvL3fwznn9XMg/F03zhq/SDzWEw4LDb7htgxCDqbiq3e4LEk8LbRCEFQUrfO5lhSzAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bviYki49; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bviYki49; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67B46226FC;
	Fri,  6 Jun 2025 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749253742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cqflJGd0SFN/SlDathCtRDOs6CrxfsPn/NLXYJZTt6s=;
	b=bviYki49QWqUIr1W17Ub8wBLNEv5JCs8hWPclJRBtcZ2LNS3f+Eu7Na/+sRa7j9udghVfF
	KDdwVMjYCAvguIzRxfrBFlMgODaPcCXCI374cx8MK540+rQqpPwUL3C+BOqcevfdyIa2Ee
	ki27iqgtrapPuf003YVwh61CxHmyQG0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bviYki49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749253742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cqflJGd0SFN/SlDathCtRDOs6CrxfsPn/NLXYJZTt6s=;
	b=bviYki49QWqUIr1W17Ub8wBLNEv5JCs8hWPclJRBtcZ2LNS3f+Eu7Na/+sRa7j9udghVfF
	KDdwVMjYCAvguIzRxfrBFlMgODaPcCXCI374cx8MK540+rQqpPwUL3C+BOqcevfdyIa2Ee
	ki27iqgtrapPuf003YVwh61CxHmyQG0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27C7A1336F;
	Fri,  6 Jun 2025 23:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3iE5Nmx+Q2g1NQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 06 Jun 2025 23:49:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Zhiyu Zhang <zhiyuzhang999@gmail.com>,
	Longxing Li <coregee2000@gmail.com>
Subject: [PATCH] btrfs: handle csum tree error with rescue=ibadroots correctly
Date: Sat,  7 Jun 2025 09:18:43 +0930
Message-ID: <54f393590b28e5f827f2f195000208845928ea7d.1749253719.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
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
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 67B46226FC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

[BUG]
There is syzbot based reproducer that can crash the kernel, with the
following call trace: (With some debug output added)

 DEBUG: rescue=ibadroots parsed
 BTRFS: device fsid 14d642db-7b15-43e4-81e6-4b8fac6a25f8 devid 1 transid 8 /dev/loop0 (7:0) scanned by repro (1010)
 BTRFS info (device loop0): first mount of filesystem 14d642db-7b15-43e4-81e6-4b8fac6a25f8
 BTRFS info (device loop0): using blake2b (blake2b-256-generic) checksum algorithm
 BTRFS info (device loop0): using free-space-tree
 BTRFS warning (device loop0): checksum verify failed on logical 5312512 mirror 1 wanted 0xb043382657aede36608fd3386d6b001692ff406164733d94e2d9a180412c6003 found 0x810ceb2bacb7f0f9eb2bf3b2b15c02af867cb35ad450898169f3b1f0bd818651 level 0
 DEBUG: read tree root path failed for tree csum, ret=-5
 BTRFS warning (device loop0): checksum verify failed on logical 5328896 mirror 1 wanted 0x51be4e8b303da58e6340226815b70e3a93592dac3f30dd510c7517454de8567a found 0x51be4e8b303da58e634022a315b70e3a93592dac3f30dd510c7517454de8567a level 0
 BTRFS warning (device loop0): checksum verify failed on logical 5292032 mirror 1 wanted 0x1924ccd683be9efc2fa98582ef58760e3848e9043db8649ee382681e220cdee4 found 0x0cb6184f6e8799d9f8cb335dccd1d1832da1071d12290dab3b85b587ecacca6e level 0
 process 'repro' launched './file2' with NULL argv: empty string added
 DEBUG: no csum root, idatacsums=0 ibadroots=134217728
 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
 CPU: 5 UID: 0 PID: 1010 Comm: repro Tainted: G           OE       6.15.0-custom+ #249 PREEMPT(full)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
 RIP: 0010:btrfs_lookup_csum+0x93/0x3d0 [btrfs]
 Call Trace:
  <TASK>
  btrfs_lookup_bio_sums+0x47a/0xdf0 [btrfs]
  btrfs_submit_bbio+0x43e/0x1a80 [btrfs]
  submit_one_bio+0xde/0x160 [btrfs]
  btrfs_readahead+0x498/0x6a0 [btrfs]
  read_pages+0x1c3/0xb20
  page_cache_ra_order+0x4b5/0xc20
  filemap_get_pages+0x2d3/0x19e0
  filemap_read+0x314/0xde0
  __kernel_read+0x35b/0x900
  bprm_execve+0x62e/0x1140
  do_execveat_common.isra.0+0x3fc/0x520
  __x64_sys_execveat+0xdc/0x130
  do_syscall_64+0x54/0x1d0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ---[ end trace 0000000000000000 ]---

[CAUSE]
Firstly the fs has a corrupted csum tree root, thus to mount the fs we
have to go "ro,rescue=ibadroots" mount option.

Normally with that mount option, a bad csum tree root should set
BTRFS_FS_STATE_NO_DATA_CSUMS flag, so that any future data read will
ignore csum search.

But in this particular case, we have the following call trace that
caused NULL csum root, but not setting BTRFS_FS_STATE_NO_DATA_CSUMS:

load_global_roots_objectid():

		ret = btrfs_search_slot();
		/* Succeeded */
		btrfs_item_key_to_cpu()
		found = true;
		/* We found the root item for csum tree. */
		root = read_tree_root_path();
		if (IS_ERR(root)) {
			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
			/*
			 * Since we have rescue=ibadroots mount option,
			 * @ret is still 0.
			 */
			break;
	if (!found || ret) {
		/* @found is true, @ret is 0, error handling for csum
		 * tree is skipped.
		 */
	}

This means we completely skipped to set BTRFS_FS_STATE_NO_DATA_CSUMS if
the csum tree is corrupted, which results unexpected later csum lookup.

[FIX]
If read_tree_root_path() failed, always populate @ret to the error
number.

As at the end of the function, we need @ret to determine if we need to
do the extra error handling for csum tree.

Fixes: abed4aaae4f7 ("btrfs: track the csum, extent, and free space trees in a rb tree")
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Reported-by: Longxing Li <coregee2000@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f48f9d924a62..0d6ad7512f21 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2158,8 +2158,7 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 		found = true;
 		root = read_tree_root_path(tree_root, path, &key);
 		if (IS_ERR(root)) {
-			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
-				ret = PTR_ERR(root);
+			ret = PTR_ERR(root);
 			break;
 		}
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-- 
2.49.0


