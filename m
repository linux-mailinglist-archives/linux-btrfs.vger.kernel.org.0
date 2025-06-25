Return-Path: <linux-btrfs+bounces-14954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA0AE84E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 15:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23EE161C85
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CEB261573;
	Wed, 25 Jun 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="duMb6bLD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="duMb6bLD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F48525B315
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858650; cv=none; b=MrzfsJiDratinY1PnrxhYDmbGWx/g/Kqt98VG8qV7F4jbWarAWB4OPWfCgmv7E1lUxcaW9ECc/Sq3PqB8kUzLdkssB7Oxvq3ehsMjaIkZKb0amU8C5c2Au7YYFdlotZg7RE34mfr4gDjGqiZ8TnTMCZst/0zUp+vQQSMweJm/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858650; c=relaxed/simple;
	bh=LH/Zbj1ofxzSHJNHfY/WlbDCTURPApz1kupFFM7VoTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7AwZILY5QEne2mYjH9eVak9bsNBUB9Jm0EC1Y0k0FgKvf0jfyIhN1g0lGzulWjlT7QXWFmsf3FNL1Eo6D1OVm3pt1oZ9HcouxBbvRsyIUXGEpoiKHrBsjrmwDIQFxq4NqQ1TBstiajosVgXhcvwyeBheKKjffnn2NM8QCrdZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=duMb6bLD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=duMb6bLD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 866751F46E;
	Wed, 25 Jun 2025 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750858646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCQug226dpAzgYTEo+nIOYKpRATiQ9k3s0EwxLjO8wI=;
	b=duMb6bLD9UqTY2yUCfzpK8f6ZXU3NxcCYyCI7L1XGthoGLh7z8iygvdG8zj0Y28wh/ykAZ
	fCTopOW5P6AuNLk1Db1bI6CYWWVoaq9qSsY+QBxp+Oo3qCHP9MqVRjx5HKs2fVeCn+fNyF
	jXrp603WnjXNwn5NyX9AgYSS45UWw7I=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750858646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCQug226dpAzgYTEo+nIOYKpRATiQ9k3s0EwxLjO8wI=;
	b=duMb6bLD9UqTY2yUCfzpK8f6ZXU3NxcCYyCI7L1XGthoGLh7z8iygvdG8zj0Y28wh/ykAZ
	fCTopOW5P6AuNLk1Db1bI6CYWWVoaq9qSsY+QBxp+Oo3qCHP9MqVRjx5HKs2fVeCn+fNyF
	jXrp603WnjXNwn5NyX9AgYSS45UWw7I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80EEA13485;
	Wed, 25 Jun 2025 13:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JnN4H5b7W2hrBQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 25 Jun 2025 13:37:26 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/2] btrfs: remove struct rcu_string
Date: Wed, 25 Jun 2025 15:37:26 +0200
Message-ID: <c1216a15b29caa878ca2d2842a5d38c906e55540.1750858539.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750858539.git.dsterba@suse.com>
References: <cover.1750858539.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

The only use for device name has been removed so we can kill the RCU
string API.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/rcu-string.h | 40 ----------------------------------------
 fs/btrfs/volumes.c    |  1 -
 fs/btrfs/volumes.h    |  1 -
 fs/btrfs/zoned.c      |  1 -
 4 files changed, 43 deletions(-)
 delete mode 100644 fs/btrfs/rcu-string.h

diff --git a/fs/btrfs/rcu-string.h b/fs/btrfs/rcu-string.h
deleted file mode 100644
index 70b1e19b50e6..000000000000
--- a/fs/btrfs/rcu-string.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2012 Red Hat.  All rights reserved.
- */
-
-#ifndef BTRFS_RCU_STRING_H
-#define BTRFS_RCU_STRING_H
-
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/rcupdate.h>
-#include <linux/printk.h>
-
-struct rcu_string {
-	struct rcu_head rcu;
-	char str[];
-};
-
-static inline struct rcu_string *rcu_string_strdup(const char *src, gfp_t mask)
-{
-	size_t len = strlen(src) + 1;
-	struct rcu_string *ret = kzalloc(sizeof(struct rcu_string) +
-					 (len * sizeof(char)), mask);
-	if (!ret)
-		return ret;
-	/* Warn if the source got unexpectedly truncated. */
-	if (WARN_ON(strscpy(ret->str, src, len) < 0)) {
-		kfree(ret);
-		return NULL;
-	}
-	return ret;
-}
-
-#define rcu_str_deref(rcu_str) ({				\
-	struct rcu_string *__str = rcu_dereference(rcu_str);	\
-	__str->str;						\
-})
-
-#endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9ab2ed7cce8d..535c7bd1d076 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -18,7 +18,6 @@
 #include "transaction.h"
 #include "volumes.h"
 #include "raid56.h"
-#include "rcu-string.h"
 #include "dev-replace.h"
 #include "sysfs.h"
 #include "tree-checker.h"
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 149434e42f7a..945b562c1644 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -21,7 +21,6 @@
 #include <uapi/linux/btrfs.h>
 #include <uapi/linux/btrfs_tree.h>
 #include "messages.h"
-#include "rcu-string.h"
 #include "extent-io-tree.h"
 
 struct block_device;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 27264db4b7ca..245e813ecd78 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -9,7 +9,6 @@
 #include "ctree.h"
 #include "volumes.h"
 #include "zoned.h"
-#include "rcu-string.h"
 #include "disk-io.h"
 #include "block-group.h"
 #include "dev-replace.h"
-- 
2.49.0


