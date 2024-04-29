Return-Path: <linux-btrfs+bounces-4636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF08B65A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5937283924
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F282D90;
	Mon, 29 Apr 2024 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P6gWDzPp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P6gWDzPp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9763194C61
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429413; cv=none; b=V2YWYM9q+qRGfrjQZMulKcj9EDZpic7xa8tD7FqP5HXkmcDnT6YCM/efq17lVkEDlDGAmBEYKuksejxlT5SsesAYOfWbvPzKQQggcX0DibbcbIXzupGJZ4d7rqbn/rV39GC7eRMzfcMKgheefpltuNryUknsYLSIljm4XYAxYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429413; c=relaxed/simple;
	bh=E0uTj6JFRJkLr+JoxOJtVx604GHUkcGyBrZjlg/LsIA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jlj9PIZ5+fkZOrI2audq7jtK4vLiAq0bmImZyKuNuLy/p4/Kp/pS0BGXgCKl3KV2mDSnkYU70AHTv7Du610Vhe4uJupGG9R76ElCOtlFgw9ZVoxaHvlnnQ+JZlRKROPmO6uVvzc9WZJ2NuoSDyahWC+1siqGt2TsXMwbNq30bOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P6gWDzPp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P6gWDzPp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8F431F785
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvtI1a8L9FRY4Jqsc7NxWTMvgudC2hXvP8LQF8F6OUs=;
	b=P6gWDzPphy/R7xxhBwGwLgz82LtHCxxFXLuairpvoo2LMXschNiF+Q4S53nr3p176blEOa
	YPvz/JhBYMpDtHbFyOxEh2wkCuBZCcXmxxFwb0z208NywamIBrYlLRrVcDIiVjmxALi58t
	Rfpe4gnyQIgvP4SjRVfnn6yQAyf7kbU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=P6gWDzPp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvtI1a8L9FRY4Jqsc7NxWTMvgudC2hXvP8LQF8F6OUs=;
	b=P6gWDzPphy/R7xxhBwGwLgz82LtHCxxFXLuairpvoo2LMXschNiF+Q4S53nr3p176blEOa
	YPvz/JhBYMpDtHbFyOxEh2wkCuBZCcXmxxFwb0z208NywamIBrYlLRrVcDIiVjmxALi58t
	Rfpe4gnyQIgvP4SjRVfnn6yQAyf7kbU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3933139DE
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YD6TD+AdMGb2GQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs: remove the recursive include of btrfs_inode.h from itself
Date: Tue, 30 Apr 2024 07:52:59 +0930
Message-ID: <6165f2c27b4d02fa4f94d8373cd3506e3028fc71.1714428940.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714428940.git.wqu@suse.com>
References: <cover.1714428940.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.35 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	BAYES_HAM(-1.34)[90.38%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C8F431F785
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.35

Inside btrfs_inode.h we include itself, although it's not causing any
problem, it's still being reported by clangd, and is really unnecessary.

Just remove the recursive include.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 91c994b569f3..de918d89a582 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -19,7 +19,6 @@
 #include <uapi/linux/btrfs_tree.h>
 #include <trace/events/btrfs.h>
 #include "block-rsv.h"
-#include "btrfs_inode.h"
 #include "extent_map.h"
 #include "extent_io.h"
 #include "extent-io-tree.h"
-- 
2.44.0


