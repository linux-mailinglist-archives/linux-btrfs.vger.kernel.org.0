Return-Path: <linux-btrfs+bounces-15944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F99CB1F21F
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Aug 2025 06:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3028B56312B
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Aug 2025 04:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD221BD035;
	Sat,  9 Aug 2025 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iMFK83g0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iMFK83g0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684B11E4BE
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Aug 2025 04:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754714979; cv=none; b=sMGZkClIJ9+Vba1XpyFQu4shgge1s1W42p2OSsGiRvuaDJk0xoTc/mXusJ8S0XgP899trA3JflqN3PnBuMUiea50/L7VhJiZSX97z6Pn49q7BO7SJwvCiWEdneP8IRQP4YFitNgxeJxEHRK3OwGd9R4Sa+AHlm7uW8rkMKlYg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754714979; c=relaxed/simple;
	bh=z15Y37gLoFpYqlRs9Gx82xOfkhtri2Hp1fa/ArdCsWc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=huI/QGMg7oZMvwoQeq2KEHp1gThBB9AWlQYsocvDMgZuPzxdLv7nMbM6fj+PxxinQDqQErEhA9J65Gp4GzvEkcrmtvBG5v2H/SreltjWCBumqmHIfvsoAhoGJP90nNc8m7wNzfL/s5KGV9k7dIFFzlasPOf7xDwQ+mGBEw2hd/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iMFK83g0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iMFK83g0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AFB15BDEF
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Aug 2025 04:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754714975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VzuyJ7i4vPayxk2WTY8QP4GvS2oVZxTqr1Qozk96Ysw=;
	b=iMFK83g0zwfKmwcuksF7bm7hIlpi3wQmTjqmxNWhz0AtUwh4UC8bZgEmbcBm21RBRrJT5g
	8RDgMo3RmDt0Q9P/2Muyq7T2K7c+6CtfQW2MSW01c1jVxRbnPrH7sqGSjn9oaW4VP7mLER
	FfkCWSg4N78RvCe30WRdi//IsRRdP8s=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754714975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VzuyJ7i4vPayxk2WTY8QP4GvS2oVZxTqr1Qozk96Ysw=;
	b=iMFK83g0zwfKmwcuksF7bm7hIlpi3wQmTjqmxNWhz0AtUwh4UC8bZgEmbcBm21RBRrJT5g
	8RDgMo3RmDt0Q9P/2Muyq7T2K7c+6CtfQW2MSW01c1jVxRbnPrH7sqGSjn9oaW4VP7mLER
	FfkCWSg4N78RvCe30WRdi//IsRRdP8s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3BF713A7E
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Aug 2025 04:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xOPLHF7Tlmi+CgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Aug 2025 04:49:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: support all block sizes which is no larger than page size
Date: Sat,  9 Aug 2025 14:19:16 +0930
Message-ID: <01f36a806d3b431efcc87284507247b493c415f5.1754714506.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

Currently if block size < page size, btrfs only supports one single
config, 4K.

This is mostly to reduce the test configurations, as 4K is going to be
the default block size for all architectures.

However all other major filesystems have no artificial limits on the
support block size, and some are already supporting block size > page
sizes.

Since the btrfs subpage block support has been there for a long time,
it's time for us to enable all block size <= page size support.

So here enable all block sizes support as long as it's no larger than
page size for experimental builds.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This relies on this patch as a dependency:
https://lore.kernel.org/linux-btrfs/e21172a455354a71172de72b9af4d844fc6ea9d4.1754714176.git.wqu@suse.com/

Reason for RFC:

Although this support is much easier compared to bs > ps, there are
still problems I'm hitting during 16K block size runs on my aarch64 64K
page size system:

- Convert related failures
  Btrfs/136 will hang at ext3 file operations way before entering btrfs.

- Some known failure caused by larger block size
  And IBM guys are already working on it.

- Random failures related to balance
  The most common one is btrfs/061, where we can hit errors from
  get_new_location(), either -EINVAL meaning the file extent size
  mismatch in data reloc inode, or -ENOENT that file extent doesn't even
  exist in data reloc inode.

  Unfortunately this can even be reproduced on x86_64, so at least it's
  not some new larger block size specific problem.

So we're definitely putting this new larger block size support behind
experimental flags.

Despite those problems, the full fstests runs problem less overall, and
I believe it's time to remove the artificial 4K block size limits on
systems with much larger page size.
---
 fs/btrfs/fs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 64948934ec51..63622b788522 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -77,6 +77,13 @@ bool btrfs_supported_blocksize(u32 blocksize)
 
 	if (blocksize == PAGE_SIZE || blocksize == SZ_4K || blocksize == BTRFS_MIN_BLOCKSIZE)
 		return true;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (blocksize <= PAGE_SIZE)
+		return true;
+#else
+	if (blocksize == PAGE_SIZE || blocksize == SZ_4K || blocksize == BTRFS_MIN_BLOCKSIZE)
+		return true;
+#endif
 	return false;
 }
 
-- 
2.50.1


