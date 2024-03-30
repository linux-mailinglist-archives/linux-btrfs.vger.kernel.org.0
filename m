Return-Path: <linux-btrfs+bounces-3801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512FE892DA0
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Mar 2024 23:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17B5B21C0C
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Mar 2024 22:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F734F5FD;
	Sat, 30 Mar 2024 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tq2KoW+O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3E42061
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711837500; cv=none; b=SM5P04d/4ATgCfZkshcxAtEHpYugkvQQ4H9EZyzVyiCjM94Gcl2ffG3+d/iYyjgfqQICqi38O3h1tiLAYh7gEJ5EQKy063U4MxWTWwkgQ5DD5mfPsTfUBlEUfvCWuxGd1qDFl66hMjL5HF8Ty8SURseVjIeqG6DFw+fkoCxRwYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711837500; c=relaxed/simple;
	bh=UdW29bVSxalt82V3NySWZV8mbrEquKjYbOJYIl1AOBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7UveeA56aTbr6ST6+eHni1eddMSfxO02B+i/YuPyFpctEY+MgZ/MlkQxORhoyYsn+WJ/ffUkOmiWEkfjj11r6PH9mRSYm7SJy/5pqFMNjn3sSAhyJGztLuZv+hjdMh9I5y9CQPNBb1iymrgEeV+qjpNoZVA/k7wtV7aoZO2M5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tq2KoW+O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BCA737FA9
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711837488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yAv4KRvb5CTvGzIxoZkqZvIunqbnArIVdUHkQc7pJc=;
	b=Tq2KoW+OPOlzY6/7ePitMMruK8xN3ks49eZ2AwiFEUXrtUYmySXprVIAQSjD3MSzfMh/AD
	2gEpmDIMpzM9NY/KfcWtg1eGmrp5L87yZ1Q+BRC7Qq5/cHUtd8n0lwIdLfIxYOW4G7cJV3
	V/ZlY4Tp+i880WRv+KdDL35rhl6rznU=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4916413A9F
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uGhEOy6RCGb7QQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: library-test: header and BTRFS_FLAT_INCLUDES cleanups
Date: Sun, 31 Mar 2024 08:54:26 +1030
Message-ID: <daa6866b4b135c8befec9c2c30b7857a5e50392c.1711837050.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711837050.git.wqu@suse.com>
References: <cover.1711837050.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.79
X-Spamd-Result: default: False [0.79 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.11)[-0.557];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,libbtrfs.so:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO

Macro BTRFS_FLAT_INCLUDES is utilized to indicate if we should include
files directly from the source code headers, or libbtrfsutil headers.

Normally it should only be utlized by libbtrfsutil headers, for
programs they should either rely on the source code headers, or the
libbtrfsutil headers, not both.

The only exception is tests/library-test.c, which during tests we
would prepare a temporary directory and populate it with compiled
libbtrfsutil library and its headers, and compile library-test program
against the libbtrfsutil we built (not the system one).

So library-test is never utilizing any headers inside the source tree,
thus BTRFS_FLAT_INCLUDES is never set for it.

This can be verified by Makefile:

  library-test: tests/library-test.c libbtrfs.so
  	@echo "    [TEST PREP]  $@"$(eval TMPD=$(shell mktemp -d))
  	$(Q)mkdir -p $(TMPD)/include/btrfs && \
  	cp $(libbtrfs_headers) $(TMPD)/include/btrfs && \
  	cp libbtrfs.so.0.1 $(TMPD) && \
  	cd $(TMPD) && $(CC) -I$(TMPD)/include -o $@ $(addprefix $(ABSTOPDIR)/,$^) -Wl,-rpath=$(ABSTOPDIR)
  	@echo "    [TEST RUN]   $@"
  	$(Q)cd $(TMPD) && LD_PRELOAD=libbtrfs.so.0.1 ./$@
  	@echo "    [TEST CLEAN] $@"
  	$(Q)$(RM) -rf -- $(TMPD)

Note that, -DBTRFS_FLAT_INCLUDES is only defined in $CFLAGS, and we do
not pass $CFLAGS for the compiling of library-test at all.

So this patch would remove the BTRFS_FLAT_INCLUDES related checks,
replace it with a comment, then cleanup the unused headers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/library-test.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/tests/library-test.c b/tests/library-test.c
index 3a09044a7d85..87dbba9f219f 100644
--- a/tests/library-test.c
+++ b/tests/library-test.c
@@ -16,31 +16,15 @@
  * Boston, MA 021110-1307, USA.
  */
 
-#if BTRFS_FLAT_INCLUDES
-#include "libbtrfs/kerncompat.h"
-#include "libbtrfs/version.h"
-#include "libbtrfs/ioctl.h"
-#include "kernel-lib/rbtree.h"
-#include "kernel-lib/list.h"
-#include "kernel-shared/ctree.h"
-#include "kernel-shared/send.h"
-#include "common/send-stream.h"
-#include "common/send-utils.h"
-#else
 /*
- * This needs to include headers the same way as an external program but must
- * not use the existing system headers, so we use "...".
+ * This program is only linked to libbtrfsutil library, and only include
+ * headers from libbtrfsutil, so we do not use the filepath inside btrfs-progs
+ * source code.
  */
 #include "btrfs/kerncompat.h"
 #include "btrfs/version.h"
-#include "btrfs/rbtree.h"
-#include "btrfs/list.h"
-#include "btrfs/ctree.h"
-#include "btrfs/ioctl.h"
-#include "btrfs/send.h"
 #include "btrfs/send-stream.h"
 #include "btrfs/send-utils.h"
-#endif
 
 /*
  * Reduced code snippet from snapper.git/snapper/Btrfs.cc
-- 
2.44.0


