Return-Path: <linux-btrfs+bounces-547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB09B802A6B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 03:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1741F21020
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310FE1844;
	Mon,  4 Dec 2023 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lKaAcPZm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51456D7
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 18:48:28 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36FBB21F2A
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 02:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701658106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tY3DtLXV2Gye5scPgI0lko6BO+IAOHPc+jdiv76vGaI=;
	b=lKaAcPZmQ9tR/5OeZWWxZ8usl9z8bqctQj6ALAcSGXA4lPhed9A8MSg+4jnwuITLMmDNs+
	Y+6tBx6fVZLkJbx94hZX0phux0XZ5T3Q1AozyU+M2f4TI+4GSuKtpjY4Z/y9mW2xBXe7V8
	knHOdv2f0wLQGbz6xamlr108rcGW4JE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 32299138E6
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 02:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id k/DLM/g9bWXfWgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 02:48:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Documentation: update the man page for btrfs check lowmem mode
Date: Mon,  4 Dec 2023 13:18:06 +1030
Message-ID: <d28d747954ec9967f6e01dcc2185229f1667b7db.1701658076.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.71
X-Spamd-Result: default: False [3.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.19)[-0.971];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

Lowmem mode has improved quite a lot since its introduction, for
read-only check it's definitely fine.

For repair mode, both lowmem and original mode are considered dangerous
especially for complex corruptions.

For now lowmem mode is only bad at fixing fundamentally corrupted cases,
like bad shift offsets or transid, which in real world it's not an easy
repair for the original mode either.

This patch would move the --mode option out of the dangerous section and
update the notes for the lowmem mode on its limitation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-check.rst | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/Documentation/btrfs-check.rst b/Documentation/btrfs-check.rst
index 046aec52923a..41ab39fab317 100644
--- a/Documentation/btrfs-check.rst
+++ b/Documentation/btrfs-check.rst
@@ -57,6 +57,20 @@ SAFE OR ADVISORY OPTIONS
 -E|--subvol-extents <subvolid>
         show extent state for the given subvolume
 
+--mode <MODE>
+        select mode of operation regarding memory and IO
+
+        The *MODE* can be one of:
+
+        original
+                The metadata are read into memory and verified, thus the requirements are high
+                on large filesystems and can even lead to out-of-memory conditions.  The
+                possible workaround is to export the block device over network to a machine
+                with enough memory.
+        lowmem
+                This mode is supposed to address the high memory consumption at the cost of
+                increased IO when it needs to re-read blocks.  This may increase run time.
+
 -p|--progress
         indicate progress at various checking phases
 
@@ -117,24 +131,6 @@ DANGEROUS OPTIONS
         .. warning::
                 Do not use unless you know what you're doing.
 
---mode <MODE>
-        select mode of operation regarding memory and IO
-
-        The *MODE* can be one of:
-
-        original
-                The metadata are read into memory and verified, thus the requirements are high
-                on large filesystems and can even lead to out-of-memory conditions.  The
-                possible workaround is to export the block device over network to a machine
-                with enough memory.
-        lowmem
-                This mode is supposed to address the high memory consumption at the cost of
-                increased IO when it needs to re-read blocks.  This may increase run time.
-
-        .. note::
-                *lowmem* mode does not work with *--repair* yet, and is still considered
-                experimental.
-
 .. _man-check-option-force:
 
 --force
-- 
2.43.0


