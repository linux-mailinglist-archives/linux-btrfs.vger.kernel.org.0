Return-Path: <linux-btrfs+bounces-15802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA40B18AF5
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 08:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6DB1AA3FEC
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 06:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F31DEFE6;
	Sat,  2 Aug 2025 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lHVBtTRP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lHVBtTRP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3E2E36E8
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117796; cv=none; b=IbXK9tnQwH+o1xSZLt7oSSSr4MFd6kADFEABHJmpT4ptm2SBDDibuaIRZM4EUKLZqU6Osjl4U5TL3FhZEXk6eI2z5lki7Jv9ZO3qbytrWhzAGaj/MJc5b/KzguqHmp6kJ3J+0Q2m/vVc2H8i3ntu0o+ezczJInCOKePYpJuaD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117796; c=relaxed/simple;
	bh=v8N0qS5g4nIDU87GIAN+BnXR/zmWDtW5DARGGbJKsZU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlEaOHTmGvRF3WQ/Pzjwa3jcNFwahzPOUwbo7h9C+AhUSwH+py42a4kp3aqInEAq2cYaBuKZoO56eHmZknUn+9NXKAEr8i6Rjxq/bMdmydXLGDl3guACwadvnt3abdUjm3WWLn4gbzBQnOlwJFp7x8D5RFqg54GWhq6vBUir4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lHVBtTRP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lHVBtTRP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A2D21F45B
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJkgOWx+nZxxtA9l6YIfjlLkyqDhzZwh7n6xPMNTD0M=;
	b=lHVBtTRPimW4h8XbRLqLBesUr91oGBvGY6+SGZXD/ngQG4MOFlsqpArDLGJI3G/wWq2ces
	fPOd+2u24IkpByf1h3g2XJpw1MdC/wB2+JuFaTGwQzg1iAxauRLmD2Zt5fjPz1UoHkXDpB
	vAh0KdeRg1ly0ImFDMWGXgRzAzOQ3zU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lHVBtTRP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJkgOWx+nZxxtA9l6YIfjlLkyqDhzZwh7n6xPMNTD0M=;
	b=lHVBtTRPimW4h8XbRLqLBesUr91oGBvGY6+SGZXD/ngQG4MOFlsqpArDLGJI3G/wWq2ces
	fPOd+2u24IkpByf1h3g2XJpw1MdC/wB2+JuFaTGwQzg1iAxauRLmD2Zt5fjPz1UoHkXDpB
	vAh0KdeRg1ly0ImFDMWGXgRzAzOQ3zU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFBC5133D1
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wGjQH462jWhhHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 06:56:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs-progs: remove device_get_partition_size_fd()
Date: Sat,  2 Aug 2025 16:25:50 +0930
Message-ID: <d5cc0e8abe2ceb35d8b89aa758713544362ae2ac.1754116463.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8A2D21F45B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
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
index 2912375a4d21..b52fbf33a539 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -333,19 +333,6 @@ int device_get_partition_size_fd_stat(int fd, const struct stat *st, u64 *result
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
 static int device_get_partition_size_sysfs(const char *dev, u64 *result_ret)
 {
 	int ret;
diff --git a/common/device-utils.h b/common/device-utils.h
index c55b6944693a..28932aba2859 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -43,7 +43,6 @@ enum {
 int device_discard_blocks(int fd, u64 start, u64 len);
 int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
 int device_get_partition_size(const char *dev, u64 *result_ret);
-u64 device_get_partition_size_fd(int fd);
 int device_get_partition_size_fd_stat(int fd, const struct stat *st, u64 *result_ret);
 int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
 u64 device_get_zone_unusable(int fd, u64 flags);
-- 
2.50.1


