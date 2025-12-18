Return-Path: <linux-btrfs+bounces-19851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED962CCA43F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 05:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC59130164CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 04:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0C24466D;
	Thu, 18 Dec 2025 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X0Kpl15u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X0Kpl15u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAFD15CD7E
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766033160; cv=none; b=kYofxPOYztULqy210bJj48QVyb06645QZlz9UnYFi9rcZa+613pRL9cABwggh6dVY2+WDC8IU4hL2ACApospxsfej3MQS+g8ZfO+3AaEfexWI1VVtX3rzJFzRbkyFUy01wlxcgseLVfisqTFIExZmjh6/DLB9OrZhq/k0K1e5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766033160; c=relaxed/simple;
	bh=VdRzKoBzUuKF6erUVmzmGrWoSIn5dNCQcV2VdjDE9BY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU/43N++bb+yIwg/ntmW5DWDwd/soRKF5Xmb0t+ftakOWAX9YkhvnIuDWX4Gmjbk59fCPLCTmcP0BEG6lW9XzybhQy9JD7e6/V0LDrsL0xTiDeayDSn3F6EaDxUnh5xqxjvG2YOsjDMPF2Y/Gdw4sDNvRvIbvCD0CU2z/Ps28E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X0Kpl15u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X0Kpl15u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BAD65BD18
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766033150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEIeIlntgZrrIRQRuWggc+bCostlYPWh9+aJs6jLIAk=;
	b=X0Kpl15ufqoomjZHV/xvIueqgs9qpP4o/HERX2BMD6/6L0a5h85L/slMOsrbvJdhjsdN7/
	Spb2dgy4OKttiKI75Y8vyvYQRO8Qv0sdCZ5EFJ8ejK0RaHUSxsQQUsUKhceVvgpuNg3Fsn
	pyDUMY1kn75IenSN3237GETiG0Ns52Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766033150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEIeIlntgZrrIRQRuWggc+bCostlYPWh9+aJs6jLIAk=;
	b=X0Kpl15ufqoomjZHV/xvIueqgs9qpP4o/HERX2BMD6/6L0a5h85L/slMOsrbvJdhjsdN7/
	Spb2dgy4OKttiKI75Y8vyvYQRO8Qv0sdCZ5EFJ8ejK0RaHUSxsQQUsUKhceVvgpuNg3Fsn
	pyDUMY1kn75IenSN3237GETiG0Ns52Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78B223EA65
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OFcMD/2GQ2kYBgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: forcing free space tree for bs > ps cases
Date: Thu, 18 Dec 2025 15:15:29 +1030
Message-ID: <fb830b3267a5f50ce98e2ba48f07cbf7e32f05bc.1766032843.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766032843.git.wqu@suse.com>
References: <cover.1766032843.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.68
X-Spam-Level: 
X-Spamd-Result: default: False [-2.68 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.415];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

[BUG]
Currently we only enforcing free space tree for bs < ps cases, but with
the recently added bs > ps support, we lack the free space tree
enforcing, causing explicit v1 cache mount option to fail on bs > ps
cases:

 # mount -o space_cache=v1 /dev/test/scratch1  /mnt/btrfs/
 mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
        dmesg(1) may have more information after failed mount system call.

 # dmesg -t | tail -n7
 BTRFS: device fsid ac14a6fa-4ec9-449e-aec9-7d1777bfdc06 devid 1 transid 11 /dev/mapper/test-scratch1 (253:3) scanned by mount (2849)
 BTRFS info (device dm-3): first mount of filesystem ac14a6fa-4ec9-449e-aec9-7d1777bfdc06
 BTRFS info (device dm-3): using crc32c checksum algorithm
 BTRFS warning (device dm-3): support for block size 8192 with page size 4096 is experimental, some features may be missing
 BTRFS warning (device dm-3): space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2
 BTRFS warning (device dm-3): v1 space cache is not supported for page size 4096 with sectorsize 8192
 BTRFS error (device dm-3): open_ctree failed: -22

[FIX]
Just enable the same free space tree for bs > ps cases, aligning the
behavior to bs < ps cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 09c38becf20b..0a931555e6dc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -736,7 +736,7 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
  */
 void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 {
-	if (fs_info->sectorsize < PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_CACHE)) {
+	if (fs_info->sectorsize != PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_CACHE)) {
 		btrfs_info(fs_info,
 			   "forcing free space tree for sector size %u with page size %lu",
 			   fs_info->sectorsize, PAGE_SIZE);
-- 
2.52.0


