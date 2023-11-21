Return-Path: <linux-btrfs+bounces-235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0967F2E46
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12D7B21C81
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D956B51C3F;
	Tue, 21 Nov 2023 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o/CENp/T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25CD50
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 05:27:29 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id D18AC1F8B8;
	Tue, 21 Nov 2023 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700573247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31cylOYxqpa2piky0Y9Mn//SRE6LG5lwlKLTzIeeEsk=;
	b=o/CENp/Tn1TiFkvBqrYX6EygIl1cH2H7MjHiDQKSsCnFhZmu5wXCFQSOeJFKM9BoG55LkK
	8jAW9P5GzlKpu//a6xrt2E4suwpq0RT2pljxjIPg0pRCfbCLK9HfelMaovkeKIIWLZlJ9J
	9HIMnmHNZjYv2ccFsWymueeim41rvh8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id D2FF72C146;
	Tue, 21 Nov 2023 13:27:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id D8038DA86C; Tue, 21 Nov 2023 14:20:19 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: constify fs_info parameter in __btrfs_panic()
Date: Tue, 21 Nov 2023 14:20:19 +0100
Message-ID: <cdf55da7c72d2d7f8367621ab9a82228ae423194.1700572232.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700572232.git.dsterba@suse.com>
References: <cover.1700572232.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [25.00 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz]
X-Spam-Score: 25.00
X-Rspamd-Queue-Id: D18AC1F8B8

The printk helpers take const fs_info if it's used just for the
identifier in the messages, __btrfs_panic() lacks that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.c | 2 +-
 fs/btrfs/messages.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index b8f9c9e56c8c..cdada4865837 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -287,7 +287,7 @@ void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
  * panic or BUGs, depending on mount options.
  */
 __cold
-void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
+void __btrfs_panic(const struct btrfs_fs_info *fs_info, const char *function,
 		   unsigned int line, int error, const char *fmt, ...)
 {
 	char *s_id = "<unknown>";
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 4d04c1fa5899..08a9272399d2 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -194,7 +194,7 @@ const char * __attribute_const__ btrfs_decode_error(int error);
 
 __printf(5, 6)
 __cold
-void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
+void __btrfs_panic(const struct btrfs_fs_info *fs_info, const char *function,
 		   unsigned int line, int error, const char *fmt, ...);
 /*
  * If BTRFS_MOUNT_PANIC_ON_FATAL_ERROR is in mount_opt, __btrfs_panic
-- 
2.42.1


