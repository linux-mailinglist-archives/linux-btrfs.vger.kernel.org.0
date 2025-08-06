Return-Path: <linux-btrfs+bounces-15882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D609B1BFB2
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D8462521A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 04:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E961F4706;
	Wed,  6 Aug 2025 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hgRKAUgP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hgRKAUgP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE91E521B
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455765; cv=none; b=FB/y4zdW9aFXwZIyvckWoyV3Rujg4e/URNvoAwZ9VyVoEZpIkyxkMcIENNVEAZCyhlIyEy3rXIFgNYAkyUXfUkRLE36ehgyWYmK/Py9RfUWKoYfJY/eIT3+JiD/QSZcIIj184Waxz6gGdRHVaHLJN6nO5Pa8GsHO2TXePAPoG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455765; c=relaxed/simple;
	bh=uOX4rqC3M8A8ZO6g0TWIDnNlRd/WPPc2XMvMi3ep8/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdIc/i2BGJc6fr4VsIpeP/7jkaJCX2LpxKtnko9Mkd6CglhndQJ/0/465vGVBMooWShkRIJITmlKB+BWnZmrfvQUlsOhSNSetCrdCHYwjzNbGq7ibqkCRuaLeB0bMH10xW7je3KebNMaYwz6uZG9CuCfSPXOR4MrH/DTIPDiQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hgRKAUgP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hgRKAUgP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 379181F393
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXgyIhGfK2C4K7G/Tr7Hp5xGpfLhDIYxpsa44JJXi9U=;
	b=hgRKAUgPuohuel2/kOlv2QgTrdtY2laZg9VWjbSulxb8N/8mj1OwC8oDANJFHpETSsJo8W
	wne0AT/+HnvoLtl797ci0BX7QaznegGPOGizQjhS0KgbiWUSjiDfBSiwErV6Exw/0yI2p9
	i1oER+vKVqP+qetBSwIo3Ym8soyALJs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hgRKAUgP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXgyIhGfK2C4K7G/Tr7Hp5xGpfLhDIYxpsa44JJXi9U=;
	b=hgRKAUgPuohuel2/kOlv2QgTrdtY2laZg9VWjbSulxb8N/8mj1OwC8oDANJFHpETSsJo8W
	wne0AT/+HnvoLtl797ci0BX7QaznegGPOGizQjhS0KgbiWUSjiDfBSiwErV6Exw/0yI2p9
	i1oER+vKVqP+qetBSwIo3Ym8soyALJs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7393813AA8
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Hi7DcvekmjFRwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 06 Aug 2025 04:49:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/6] btrfs-progs: remove the unnecessary device_get_partition_size() call
Date: Wed,  6 Aug 2025 14:18:51 +0930
Message-ID: <a9638cec2d84c7142a5f3f884c29b8aba1be8552.1754455239.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754455239.git.wqu@suse.com>
References: <cover.1754455239.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 379181F393
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Inside function _cmd_filesystem_usage_tabular(), there is a call of
device_get_partition_size() to calculate @unused.

However immediately after that call, @unused is updated using
devinfo->size, so that the previous call of device_get_partition_size()
is completely useless.

Just remove the unnecessary call.

And since we're here, also remove a dead newline in that loop at
variable declaration.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/filesystem-usage.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 473479a1d72d..f812af13482e 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -959,7 +959,6 @@ static void _cmd_filesystem_usage_tabular(unsigned unit_mode,
 		int k;
 		const char *p;
 		const struct device_info *devinfo = devinfos->data[i];
-
 		u64  total_allocated = 0, unused;
 
 		p = strrchr(devinfo->path, '/');
@@ -1000,7 +999,6 @@ static void _cmd_filesystem_usage_tabular(unsigned unit_mode,
 			col++;
 		}
 
-		unused = device_get_partition_size(devinfo->path) - total_allocated;
 		unused = devinfo->size - total_allocated;
 
 		table_printf(matrix, unallocated_col, vhdr_skip + i, ">%s",
-- 
2.50.1


