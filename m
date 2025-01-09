Return-Path: <linux-btrfs+bounces-10819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678EFA07314
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543EE3A17B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96C216607;
	Thu,  9 Jan 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QSZiFkoH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QSZiFkoH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDDE2165EE
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418252; cv=none; b=mLh0j38WUgwRcqX5XssnYP+cTMwGTcy2ku3tYRZbbzaUTRXmMZIo4lk90p+v+866AKL0xJJcvnUa0aRvniSf5yJzIiqTmCGh3FUJX4+7JK8Ej+JDXswjl39bp+sCoAkVE8kb+WT0XyqLZMD+vx5DeIhdafINz5PymqbJgt3oc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418252; c=relaxed/simple;
	bh=s7rCtYt9qqJTBhbZyGyofSSPpG+59YaUsTat08waxbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3NgJDyE3zdYwrSAPZ7BIWB2EwansGCVFmD35TgpJXG9y3CtJeoVL+EUVYsLOurZQDsSJFmR0jFIgv5g1aV+pIAUTkc7Na4f9sp/oruEO1/XUtHxl7b4HF7V6OqG2eDhC589KFfQu3s5zH0PVrUYGBiakQGkR1bJ0vjbiN/TmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QSZiFkoH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QSZiFkoH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F8CF1F393;
	Thu,  9 Jan 2025 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZD0aFM2wUNQ2J5ZEVXfhTGyprvwlby9yBbdsxWxPpE=;
	b=QSZiFkoHwzSVJHEXFdO61xoDCrS5rK1rCxoHCCWkY19NXyh83BoOqfTe9xngkweAuVKqpC
	6V1XhnpT8z2plYdOWscfnb0vaisNVFpIBWj6YXC6vHynSJ7ynH0E0n340opQvjsenyGt+w
	LeYvMIJ9O+GEmDBsaveYH/A4+3sS2Dk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QSZiFkoH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZD0aFM2wUNQ2J5ZEVXfhTGyprvwlby9yBbdsxWxPpE=;
	b=QSZiFkoHwzSVJHEXFdO61xoDCrS5rK1rCxoHCCWkY19NXyh83BoOqfTe9xngkweAuVKqpC
	6V1XhnpT8z2plYdOWscfnb0vaisNVFpIBWj6YXC6vHynSJ7ynH0E0n340opQvjsenyGt+w
	LeYvMIJ9O+GEmDBsaveYH/A4+3sS2Dk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47515139AB;
	Thu,  9 Jan 2025 10:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AYpgEcijf2clEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:08 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/18] btrfs: use SECTOR_SIZE defines in btrfs_issue_discard()
Date: Thu,  9 Jan 2025 11:24:07 +0100
Message-ID: <65d2dc893f64333160c5726d63304cc063c2b0b0.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F8CF1F393
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Use the existing define for single sector size.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1cb1bd45f7ec..3014a1a23efd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1256,12 +1256,12 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 {
 	int j, ret = 0;
 	u64 bytes_left, end;
-	u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
+	u64 aligned_start = ALIGN(start, SECTOR_SIZE);
 
 	/* Adjust the range to be aligned to 512B sectors if necessary. */
 	if (start != aligned_start) {
 		len -= aligned_start - start;
-		len = round_down(len, 1 << SECTOR_SHIFT);
+		len = round_down(len, SECTOR_SIZE);
 		start = aligned_start;
 	}
 
-- 
2.47.1


