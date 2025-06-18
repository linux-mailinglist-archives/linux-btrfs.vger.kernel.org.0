Return-Path: <linux-btrfs+bounces-14766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AA8ADE9A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B351748B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919528C5C6;
	Wed, 18 Jun 2025 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fokjSyz9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fokjSyz9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8B28C024
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245008; cv=none; b=uEE2St/8zFnVX4ZhTJ2tsH0Fl/DzBBOLhK5nmG1q9TSKEElYis3qivgclG9W6/iNjfEvcJkg6SuxuUTtJn62dUERhia+JdmUgE5QPhdfgccve00IaK1PStuMun6W8VwuUENou4vRhMFvxkybvhk1JB70VTCf7fSxeEj9Z7D0G+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245008; c=relaxed/simple;
	bh=UkpCwbYIY1z2zItqAC/xGZ7sshVPjMG41Snsa7V4cqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5y4z2T1WYmRI+omU5gX++v0CkSl33CwaQwCRx3mzu2wRY5rEjEvbDiWh9i5Q+gCP3VYKpZx1vNClEgiRFsoEA2E/Gx06Cel8BXfE01orhzTqf7lvqMrLHu84BPfIAietVfGgpkEoPZwKK8u5QrFBAenyJoz2OY9YsrhwqHb4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fokjSyz9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fokjSyz9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D0502121C;
	Wed, 18 Jun 2025 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750244998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZRwG/nLZNDfLN1xuS8TyaB0RO72F1t8uH6dEfPqbII=;
	b=fokjSyz9h1j92OiVmxoRczQYQ9ufrImIwqBWghjRi4hhHVno8cE5edbDivlLVC3HpXUUcg
	xV9S5Sz6tVEHP+HczqDoQp9Q8eWNw3YPQZyws/fiLUbLDmjsQdAWzXAp5I0h1Dl0/dFXb8
	zKG3V0wy2Xmzh4Jhb6T/x0M8iZQB76M=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fokjSyz9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750244998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZRwG/nLZNDfLN1xuS8TyaB0RO72F1t8uH6dEfPqbII=;
	b=fokjSyz9h1j92OiVmxoRczQYQ9ufrImIwqBWghjRi4hhHVno8cE5edbDivlLVC3HpXUUcg
	xV9S5Sz6tVEHP+HczqDoQp9Q8eWNw3YPQZyws/fiLUbLDmjsQdAWzXAp5I0h1Dl0/dFXb8
	zKG3V0wy2Xmzh4Jhb6T/x0M8iZQB76M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 952F313A3F;
	Wed, 18 Jun 2025 11:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c3pqJIaeUmgROQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Jun 2025 11:09:58 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: remove struct rcu_string
Date: Wed, 18 Jun 2025 13:09:58 +0200
Message-ID: <98df9dbde4e403185f2e91a00aefe758c06cd16e.1750244832.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1750244832.git.dsterba@suse.com>
References: <cover.1750244832.git.dsterba@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9D0502121C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

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
index 002a215176ca..8cfd731f05ef 100644
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
index cc270787d0ce..16aaa25155dc 100644
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
2.47.1


