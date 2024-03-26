Return-Path: <linux-btrfs+bounces-3579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD1B88B5F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 01:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096C11F3BD07
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB4617F8;
	Tue, 26 Mar 2024 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GhSUpv84";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GhSUpv84"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65F37E
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412595; cv=none; b=lLFBP2AZhSlfWu+OXT/aoxpHcgiqkuOchxdHlDrphqCRlHsS8HKCZJ06TXiwRrktGXJ0BIVkqHkcDe914jEebnKzG2yhQfjaLO60f64mO7hqHDVVr+efwUMk0QNkbf/9ez8uYNVGixoLRuL1Y/+nfEAqK7u/QUMa/x+TZd3vBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412595; c=relaxed/simple;
	bh=P2weWB78Qzf2kBfY3TfFoxIJL/HR5ukJLalrHuq6Lis=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS9MJBEf5D4Zl+1litzFZrXu5a03eQKrXc3MPuWn1o1q6VDxLNR0IXlQF/HVv8l3Nkb5+Km+O3mQlpY8lYBZkAdwl+JsQW9W7Je/LJybmIYL6r4wpCts+iwBXN2F2kmED66pVvnhY371FNf7SXAm3Xzpvb/5trB+g+vRbg0/wlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GhSUpv84; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GhSUpv84; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 960805CE27
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJMxwXQPFbn9M5CBU9oGyRi9pdtjUjKZLxozyqXrwM0=;
	b=GhSUpv842bMydHtFJG4O+bIPRPKSsZ9DYlcZ6YsNunnVr1bYVZrZ9L3LpXlCrawa4MUF1p
	6M/zr25x2QEkFfxqzandNSIxco+7PwHh6b9WeuR6hgQKsuV6+lloaXsXtDIhkYMA55VpDS
	LoH6MYM1sPz4qgQMsLI9RA44ChqdLKI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJMxwXQPFbn9M5CBU9oGyRi9pdtjUjKZLxozyqXrwM0=;
	b=GhSUpv842bMydHtFJG4O+bIPRPKSsZ9DYlcZ6YsNunnVr1bYVZrZ9L3LpXlCrawa4MUF1p
	6M/zr25x2QEkFfxqzandNSIxco+7PwHh6b9WeuR6hgQKsuV6+lloaXsXtDIhkYMA55VpDS
	LoH6MYM1sPz4qgQMsLI9RA44ChqdLKI=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A47B413586
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yBvoFW4VAmbOJAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs-progs: remove unused header for tune/main.c
Date: Tue, 26 Mar 2024 10:52:41 +1030
Message-ID: <a7224b1e785d51d74c6bd369ee0c0f586cbdf616.1711412540.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711412540.git.wqu@suse.com>
References: <cover.1711412540.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.83
X-Spamd-Result: default: False [3.83 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.07)[-0.369];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[32.43%]
X-Spam-Level: ***
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

My clangd LSP server reports warning that "common/parse-utils.h" is not
utilized at all.

Just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tune/main.c b/tune/main.c
index 0fbf37dd4800..aa9f39d987ec 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -33,7 +33,6 @@
 #include "common/open-utils.h"
 #include "common/device-scan.h"
 #include "common/messages.h"
-#include "common/parse-utils.h"
 #include "common/string-utils.h"
 #include "common/help.h"
 #include "common/box.h"
-- 
2.44.0


