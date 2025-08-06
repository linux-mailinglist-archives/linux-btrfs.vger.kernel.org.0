Return-Path: <linux-btrfs+bounces-15881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7590CB1BFB1
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23147A6C70
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 04:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D3E1F462D;
	Wed,  6 Aug 2025 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JKAws+5E";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JKAws+5E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69461DB54C
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455765; cv=none; b=PV/EecETgMt/hQZyIcrV27hISOmoxRdtv/gmeInGV645I9aUwqrdEY8fIdtStPPCEC2uYNZ/dTHnl2rymz1pkPuRKBMhlLhsHv52ZWN9iESzzOnluK/kIxSEp7KYQoycQuE/ceLek4w8KHIq9b9iSNqIduIVvu7/ukFKOqCvULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455765; c=relaxed/simple;
	bh=RQuVly+c9XoAgI5H5/+f4T72F7BhaMQyq3eG+yHSuzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHupyWoIaLMv3JlSO8w+l/FRrzUD/DYc03df/sAw9mAHDHEIOmrCvFrpXxN6kdbLdj1U/BDZu3SsIPBK0D2S9aRTjBcYHVOwJjWQTo1D/nFwCnhXHdMTt1mVeSFiWlIdZArFyfmiiROOjdDLaku9szn0fFX+AJ136phF6oUCuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JKAws+5E; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JKAws+5E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B60021275
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oL5bEd0ohcsp47OmskJfao+76Ef2Ol86I8MQWr+0xPE=;
	b=JKAws+5ELCXl7aOabknqryWmmfcZ9zwKnnuToZuA9UhS55qnKDFiw+sGC6idR7H6DhDqMA
	kFyxubxBgQSTZTK6uZCqG1fUQ+N76cgj4XtfIhf/bsfI3WDm65Gg0IHBXX8Z3EmCXZeODa
	a07WS0t7kj5TRm1zHcdpRA2JpikRp6A=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JKAws+5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oL5bEd0ohcsp47OmskJfao+76Ef2Ol86I8MQWr+0xPE=;
	b=JKAws+5ELCXl7aOabknqryWmmfcZ9zwKnnuToZuA9UhS55qnKDFiw+sGC6idR7H6DhDqMA
	kFyxubxBgQSTZTK6uZCqG1fUQ+N76cgj4XtfIhf/bsfI3WDm65Gg0IHBXX8Z3EmCXZeODa
	a07WS0t7kj5TRm1zHcdpRA2JpikRp6A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8A4A13AA8
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GJmsGszekmjFRwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 06 Aug 2025 04:49:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/6] btrfs-progs: remove device_get_partition_size_fd()
Date: Wed,  6 Aug 2025 14:18:52 +0930
Message-ID: <85b30aea3031129419ec507afdaf0f0912477487.1754455239.git.wqu@suse.com>
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
	BAYES_HAM(-3.00)[100.00%];
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
X-Rspamd-Queue-Id: 6B60021275
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

The last user of the helper is removed in commit 585ac14d1af2
("btrfs-progs: use btrfs_device_size() instead of
device_get_partition_size_fd()"), and that helper is not generic enough
to handle regular files.

So let's just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/device-utils.c | 13 -------------
 common/device-utils.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index bca392568d1b..b32bd2cec1f1 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -329,19 +329,6 @@ u64 device_get_partition_size_fd_stat(int fd, const struct stat *st)
 	return 0;
 }
 
-/*
- * Read partition size using the low-level ioctl
- */
-u64 device_get_partition_size_fd(int fd)
-{
-	u64 result;
-
-	if (ioctl(fd, BLKGETSIZE64, &result) < 0)
-		return 0;
-
-	return result;
-}
-
 static u64 device_get_partition_size_sysfs(const char *dev)
 {
 	int ret;
diff --git a/common/device-utils.h b/common/device-utils.h
index cef9405f3a9a..82e6ba547585 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -43,7 +43,6 @@ enum {
 int device_discard_blocks(int fd, u64 start, u64 len);
 int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
 u64 device_get_partition_size(const char *dev);
-u64 device_get_partition_size_fd(int fd);
 u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
 int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
 u64 device_get_zone_unusable(int fd, u64 flags);
-- 
2.50.1


