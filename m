Return-Path: <linux-btrfs+bounces-15799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8259AB18AF2
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 08:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA4B623F3D
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 06:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8B1DF26A;
	Sat,  2 Aug 2025 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QznfS5ow";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QznfS5ow"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DD1DD543
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117783; cv=none; b=iwRedtReRiNb9cAYHlgs78LeGhKtQ5e24YBHSQ3khAqdUhjBWy+dkc71jtW0VB7y9mfiqmdpNmF6oGZc7jEcpbKTPMlDdWf2gCAXAm0teLVTbt1Zr/H/cNpXI6crYleicbXg7QZ5LNW/1Ciw1n7AL4KQ/G9tpjLzz9dEUrtsmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117783; c=relaxed/simple;
	bh=uOX4rqC3M8A8ZO6g0TWIDnNlRd/WPPc2XMvMi3ep8/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X89RyDw6wWzjHWG4ugbc7Iq6gmn4/aKVSaM8/nRJ/mYV0NiUKKTTNAY30bXZbe+KJASb73qW2hWasmyQ+y9lzWVJpRB9V7SwSwHezWIHDtjKhQaUfm4VPSBPUKvTbjOnqAT23eqJbYA5lqEba2eP7O0tYE/TG/IOpzcG2h8gtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QznfS5ow; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QznfS5ow; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C026B1F452
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXgyIhGfK2C4K7G/Tr7Hp5xGpfLhDIYxpsa44JJXi9U=;
	b=QznfS5owAqSdVJ/W2q6QosGg2FSTlK2hoHYEAp2mu1+NHl7s/vWpmaVnlTTb1HhiRBxuWO
	27q1bC0obVqM1mGwar4Y/ikM75ApuJzJ2M47dSSFJURAziBfCu68zNBC//jCX0CCk/fJYJ
	BT7Qg6vWbUkUHki7WLaBfmqqJRDCDss=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QznfS5ow
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXgyIhGfK2C4K7G/Tr7Hp5xGpfLhDIYxpsa44JJXi9U=;
	b=QznfS5owAqSdVJ/W2q6QosGg2FSTlK2hoHYEAp2mu1+NHl7s/vWpmaVnlTTb1HhiRBxuWO
	27q1bC0obVqM1mGwar4Y/ikM75ApuJzJ2M47dSSFJURAziBfCu68zNBC//jCX0CCk/fJYJ
	BT7Qg6vWbUkUHki7WLaBfmqqJRDCDss=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F146813A84
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QJ3dK4q2jWhhHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 06:56:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs-progs: remove the unnecessary device_get_partition_size() call
Date: Sat,  2 Aug 2025 16:25:47 +0930
Message-ID: <4aae6d638040f3c39464e8e92cf19de70a7d93eb.1754116463.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754116463.git.wqu@suse.com>
References: <cover.1754116463.git.wqu@suse.com>
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
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C026B1F452
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


