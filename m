Return-Path: <linux-btrfs+bounces-11507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D3A37EF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 10:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C133AD6CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE72163AA;
	Mon, 17 Feb 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BiIw/ogB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BiIw/ogB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC529215F67
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785968; cv=none; b=liRTHKsUPRD/UvRVS7DPG0KBM4wijIxEiKorewxhlKouRJ1LV70bQwfLI6jPFwxdW+SmFWyZF1a3BRh08pr/q28aAISHM4v3uaHHrBQ/AC1aexB8xzWhfO9PDvUOdLuI9KUzrstqersZJdivMiVRrwHu0WODP6QikS1JUQgsyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785968; c=relaxed/simple;
	bh=WzJZAp+CFdNosO0dg32WMIiVfBZn/WZcu2PasGyfkAA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Sjk10GlaufEl0HXzUVEgI3LZ9NRrJ9McXlzK83d6uvq5tlGF6m1jP8dtc+/SufLFe8slfVKlG2JUr/ip6JkkM3BOcvoarJWcaThN7BLsFcnxHqnavT7Ltcoh/u4lq7Em5XHrNr5D2npxRYYIziof8mQlQkkj8XdgUjIk2G/uiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BiIw/ogB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BiIw/ogB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E99E21119
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 09:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739785965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4y9fN4zHiOzY0AdbRQ75FoPhyPQMEbkGMhuAJ2KB8GE=;
	b=BiIw/ogB0ayGRYR+/2AMcJspWxlNXiL/Csm/7rvMpuHpbJUZxBJusza5bxl0NrEoOjXCOL
	Qe3vH/01mrTUjdNDEByheP7t5nnabjT7Co0msqcoBSLFIr2iaNit0RcdCDlQ7FlX/rQqIY
	LT2zwIbGbfK8udmsc+fXI4FvltkyMVk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="BiIw/ogB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739785965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4y9fN4zHiOzY0AdbRQ75FoPhyPQMEbkGMhuAJ2KB8GE=;
	b=BiIw/ogB0ayGRYR+/2AMcJspWxlNXiL/Csm/7rvMpuHpbJUZxBJusza5bxl0NrEoOjXCOL
	Qe3vH/01mrTUjdNDEByheP7t5nnabjT7Co0msqcoBSLFIr2iaNit0RcdCDlQ7FlX/rQqIY
	LT2zwIbGbfK8udmsc+fXI4FvltkyMVk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FDA5133F9
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 09:52:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SYACAewGs2fpRQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 09:52:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: output an error message if btrfs failed to find the seed fsid
Date: Mon, 17 Feb 2025 20:22:26 +1030
Message-ID: <c34c50a035111a83b3cb5c735f9a86a7d47a66c7.1739785941.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E99E21119
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
If btrfs failed to locate the seed device for whatever reason, mounting
the sprouted device will fail without any meaning error message:

 # mkfs.btrfs -f /dev/test/scratch1
 # btrfstune -S1 /dev/test/scratch1
 # mount /dev/test/scratch1 /mnt/btrfs
 # btrfs dev add -f /dev/test/scratch2 /mnt/btrfs
 # umount /mnt/btrfs
 # btrfs dev scan -u
 # btrfs mount /dev/test/scratch2 /mnt/btrfs
 mount: /mnt/btrfs: fsconfig system call failed: No such file or directory.
       dmesg(1) may have more information after failed mount system call.
 # dmesg | tail -n6
 [ 1626.369520] BTRFS info (device dm-5): first mount of filesystem 64252ded-5953-4868-b962-cea48f7ac4ea
 [ 1626.370348] BTRFS info (device dm-5): using crc32c (crc32c-generic) checksum algorithm
 [ 1626.371099] BTRFS info (device dm-5): using free-space-tree
 [ 1626.373051] BTRFS error (device dm-5): failed to read chunk tree: -2
 [ 1626.373929] BTRFS error (device dm-5): open_ctree failed: -2

[CAUSE]
The failure to mount is pretty straight forward, just unable to find the
seed device and its fsid, caused by `btrfs dev scan -u`.

But the lack of any useful info is a problem.

[FIX]
Just add an extra error message in open_seed_devices() to indicate the
error.

Now the error message would look like this:

 [ 1926.837729] BTRFS info (device dm-5): first mount of filesystem 64252ded-5953-4868-b962-cea48f7ac4ea
 [ 1926.838829] BTRFS info (device dm-5): using crc32c (crc32c-generic) checksum algorithm
 [ 1926.839563] BTRFS info (device dm-5): using free-space-tree
 [ 1926.840797] BTRFS error (device dm-5): failed to find fsid 1980efd3-616e-4815-bd5e-aa0d7c3586e3
 [ 1926.841632] BTRFS error (device dm-5): failed to read chunk tree: -2
 [ 1926.842563] BTRFS error (device dm-5): open_ctree failed: -2

Link: https://github.com/kdave/btrfs-progs/issues/959
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0a0776489055..7642fce50c12 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7200,8 +7200,10 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 
 	fs_devices = find_fsid(fsid, NULL);
 	if (!fs_devices) {
-		if (!btrfs_test_opt(fs_info, DEGRADED))
+		if (!btrfs_test_opt(fs_info, DEGRADED)) {
+			btrfs_err(fs_info, "failed to find fsid %pU", fsid);
 			return ERR_PTR(-ENOENT);
+		}
 
 		fs_devices = alloc_fs_devices(fsid);
 		if (IS_ERR(fs_devices))
-- 
2.48.1


