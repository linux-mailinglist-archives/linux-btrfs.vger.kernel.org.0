Return-Path: <linux-btrfs+bounces-19374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97304C8D202
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 08:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DBA3B1634
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 07:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E78431C58A;
	Thu, 27 Nov 2025 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oU5gkr4w";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RtRYcTUS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69FE30CDBD
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228826; cv=none; b=m40e9LJcqHVFWINXk4iuiCncidnabGBTMR7E+H2CaGrt275n/63oZmIu1ZH5aWzrGLHZYJ+hcc91YYVPna6mzRcvBbLw081ICJjRe2L+YC4R8PWplhsOafWsBO2KRnjYVFrNKjFfrgu70UVJO27Y1jEi684Tt7qZ3DAJuXsBZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228826; c=relaxed/simple;
	bh=l4YMfDKYUttkJupbu97QZrLHmxRgqcxuaHueIKjEiB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAIUKXzkY6SYkNp6VNTzCSUET/KTzlX6q+Wc1sZW4iXiN4qFsqBXspdaN+TO/cMN4j8LK5RqZaEW0KlJH64+E2oAMQZqQPJrftV/068he9IUUVKbB0VCUbHiaSK1ve4fks7OM71ZaLPGQJndoxobt2jB7Ayutd82D6fpMZKk+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oU5gkr4w; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RtRYcTUS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5D2D33698
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764228817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94hh2R4KCyNcq16pJKoiI2PZwusT4+Pk2snUG71LrQQ=;
	b=oU5gkr4wOnqDr4vxzxV2L/wkevh23GEbMKL8QdzS8TnuKpgU1fFXGSNgXdTPXZbppgdfr4
	Hh2HtWCN+jBVpRYhJQb0lgmOKGA56ByB2iWlphqNLFxPKRNppvPGSCYjO9uvATQ6g7uSg7
	SaK8IqnCUK2+oDUKS8GJlBcr0xv1ehY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RtRYcTUS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764228816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94hh2R4KCyNcq16pJKoiI2PZwusT4+Pk2snUG71LrQQ=;
	b=RtRYcTUSAnyyUHzd+SRlTojcq2Mbggw0RbHTYqVMNERhAmp/cogTL65GgcKoMx4ehYMXXM
	64aYGYjydeN7zzXVlM0EHXQmMMzFyts5PVXTt6imRrEcSHzXmRXHtp6d0xkmc+xK9vu7Bs
	lo4LfvQSthFEXYHp7DiJwHrPjGyb1DM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21E033EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EBePNc/+J2nlcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs-progs: disable block-group-tree feature if dependency is missing
Date: Thu, 27 Nov 2025 18:03:15 +1030
Message-ID: <b484ae34c63a5334a3f3c0a62132b6bcfff0b55e.1764228560.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764228560.git.wqu@suse.com>
References: <cover.1764228560.git.wqu@suse.com>
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
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,btrfs.readthedocs.io:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[btrfs.readthedocs.io:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D5D2D33698
X-Rspamd-Action: no action
X-Spam-Flag: NO

Currently mkfs.btrfs will fail with the following features:

  # mkfs.btrfs -O block-group-tree,^no-holes $dev
  btrfs-progs v6.17.1
  See https://btrfs.readthedocs.io for more information.

  ERROR: block group tree requires no-holes and free-space-tree features

That's due to the artificial feature requirements from block-group-tree,
which requires no-holes and free-space-tree.

But such mandatory rejection will block our migration to the new default
block-group-tree tree features as a lot of no-holes test cases will cause
false alerts (and we do not have plan to deprecate explicit holes yet,
or do we?).

So to avoid the new default block-group-tree feature from causing tons of
false alerts, automatically disable block-group-tree feature if the end user
disables no-holes or free-space-tree features.

Now the above command will success, but with extra warnings and
block-group-tree disabled.

  # mkfs.btrfs -O block-group-tree,^no-holes $dev
  btrfs-progs v6.17.1
  See https://btrfs.readthedocs.io for more information.

  WARNING: disabling block-group-tree feature due to missing no-holes and free-space-tree features
  Label:              (null)
  UUID:               3c7adb81-c0c3-4980-8ef3-485019e5d8c4
  Node size:          16384
  Sector size:        4096	(CPU page size: 4096)
  Filesystem size:    1.00GiB
  Block group profiles:
    Data:             single            8.00MiB
    Metadata:         DUP              51.19MiB
    System:           DUP               8.00MiB
  SSD detected:       no
  Zoned device:       no
  Features:           extref, skinny-metadata, free-space-tree
  Checksum:           crc32c
  ...

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/mkfs.btrfs.rst |  5 +++++
 convert/main.c               |  4 ++--
 mkfs/main.c                  | 10 +++++++---
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index 7734354fd6da..100449675597 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -436,6 +436,11 @@ block-group-tree
         enabled at *mkfs* time is possible, see :doc:`btrfstune`. Online
         conversion is not possible.
 
+	.. note::
+		This feature requires ``no-holes`` and ``free-space-tree``
+		features, if those dependency features are disabled,
+		``block-group-tree`` feature will also be disabled automatically.
+
 .. _mkfs-feature-raid-stripe-tree:
 
 raid-stripe-tree
diff --git a/convert/main.c b/convert/main.c
index 190f38a11924..116867fc9eff 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1214,8 +1214,8 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	if ((features->compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE) &&
 	    (!(features->incompat_flags & BTRFS_FEATURE_INCOMPAT_NO_HOLES) ||
 	     !(features->compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE))) {
-		error("block group tree requires no-holes and free-space-tree features");
-		goto fail;
+		warning("disabling block-group-tree feature due to missing no-holes and free-space-tree features");
+		features->compat_ro_flags &= ~BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE;
 	}
 	fd = open(devname, O_RDWR);
 	if (fd < 0) {
diff --git a/mkfs/main.c b/mkfs/main.c
index f99e5486521d..cf77e192045b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1849,13 +1849,17 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
-	/* Block group tree feature requires no-holes and free-space-tree. */
+	/*
+	 * Block group tree feature requires no-holes and free-space-tree.
+	 * And if those dependency is disabled, also disable block-group-tree feature.
+	 */
 	if (features.compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE &&
 	    (!(features.incompat_flags & BTRFS_FEATURE_INCOMPAT_NO_HOLES) ||
 	     !(features.compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE))) {
-		error("block group tree requires no-holes and free-space-tree features");
-		exit(1);
+		warning("disabling block-group-tree feature due to missing no-holes and free-space-tree features");
+		features.compat_ro_flags &= ~BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE;
 	}
+
 	if (opt_zoned) {
 		const int blkid_version =  blkid_get_library_version(NULL, NULL);
 
-- 
2.52.0


