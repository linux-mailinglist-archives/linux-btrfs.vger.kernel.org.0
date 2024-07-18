Return-Path: <linux-btrfs+bounces-6558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF7D9370AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387C41F21458
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22F214658B;
	Thu, 18 Jul 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aT2oA29X";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aT2oA29X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9375B1FB
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342026; cv=none; b=Li2jZ5YPkaQUwsyK0ZsShWsZjmwkwEdPjjs3+XektryxpQEjmmYKtZlEUgSiJf6yXC9wiiQ+VSSsIpPLl9NzYBvTZHejkR+yJUv6xc5YNxQJPVB+kgu4e8I9Eq6DHB6XpgQMWLrK0rPCzzRBFt6nDP/Rb07+PwRYfEDrDA0yOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342026; c=relaxed/simple;
	bh=EUTJhkApZfVP/eJtwyywYiuDBbBOvOQknwUwbmMMffE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHwiObpuuGIPDfrv+YXSopVkDrge0WSlrPpOsxYm8j5hG6AGP3derrf1ascir4oJZfaY2KV+oui+ScKKBWtSPD9P5/PHqt+rokVCiJwAYtgP+4xzWyQ/S3wLsLgLunDs2kGaUkZNDwxLKM6FQtxoAGGTkwHmNpm/wby86WJ+KRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aT2oA29X; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aT2oA29X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52DDF21AFE
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721342023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pTI/l9OWQiKIw7HozO9vAFEHdgqG/zUerkgBTP/X7o=;
	b=aT2oA29Xz/mWc01ok7IQXisiEBbQJpONmCiSyxU7C74RFjYpEfj5YQx3jH0bNeI7fCpJuX
	H7nAih38Zn042Y43FbOD7xBNgseiMNgVzt89AHhn+G8jGo7GjhL6tySeXVq8rCYazNlhIS
	EuSec3XAxKl4zGX8wg4WZmHlzATL/90=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aT2oA29X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721342023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pTI/l9OWQiKIw7HozO9vAFEHdgqG/zUerkgBTP/X7o=;
	b=aT2oA29Xz/mWc01ok7IQXisiEBbQJpONmCiSyxU7C74RFjYpEfj5YQx3jH0bNeI7fCpJuX
	H7nAih38Zn042Y43FbOD7xBNgseiMNgVzt89AHhn+G8jGo7GjhL6tySeXVq8rCYazNlhIS
	EuSec3XAxKl4zGX8wg4WZmHlzATL/90=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75AE21379D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UCMmDEaYmWb9HAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs-progs: add warning for -s option of btrfs-image
Date: Fri, 19 Jul 2024 08:03:19 +0930
Message-ID: <f34cdcf0832181b35edaa40ac65d05a3f3feb4a9.1721341885.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721341885.git.wqu@suse.com>
References: <cover.1721341885.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 52DDF21AFE

The filename sanitization is not recommended as it introduces mismatches
between DIR_ITEM and INODE_REF.

Even hash confliction mode (double "-s" option) is not ensured to always
find a conflict, and when failed to find a conflict, a mismatch would
happen.

And when a mismatch happens, the kernel will not resolve the path
correctly since kernel uses the hash from DIR_ITEM to lookup the child
inode.

So add a warning into the "-s" option of btrfs-image.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-image.rst | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/btrfs-image.rst b/Documentation/btrfs-image.rst
index a63b0da273c5..ae6145f79c06 100644
--- a/Documentation/btrfs-image.rst
+++ b/Documentation/btrfs-image.rst
@@ -37,13 +37,18 @@ OPTIONS
         file system will not be able to be mounted.
 
 -s
-        Sanitize the file names when generating the image. One -s means just
-        generate random garbage, which means that the directory indexes won't match up
-        since the hashes won't match with the garbage filenames. Using *-s* will
-        calculate a collision for the filename so that the hashes match, and if it
-        can't calculate a collision then it will just generate garbage.  The collision
-        calculator is very time and CPU intensive so only use it if you are having
-        problems with your file system tree and need to have it mostly working.
+	Sanitize the file names when generating the image.
+	Not recommended as this would introduce new file name hash mismatches,
+	thus if your problem involves subvolume tress, it can even mask existing problems.
+	Furthermore kernels can not do proper path resolution due to the introduced
+	hash mismatches.
+
+	One *-s* means just generate random garbage, which means that the
+	directory hash won't match its file names.
+	Using two *-s* will calculate a collision for the file name so that the
+	hashes match, and if it can't calculate a collision then it will just
+	generate garbage.  The collision calculator is very time and CPU
+	intensive.
 
 -w
         Walk all the trees manually and copy any blocks that are referenced. Use this
-- 
2.45.2


