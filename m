Return-Path: <linux-btrfs+bounces-10833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E2A07316
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1FF168EAC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CB5216397;
	Thu,  9 Jan 2025 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RVEUkeVl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RVEUkeVl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD93215F53
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418293; cv=none; b=geVrugSib/u3cgQOTa0W58UR0+SxsJoiD4fsDpjrlNqToAZhhBZuy4LaOf9xZ3EL0DEiD+e0Mbbc4DDFFPFmZZ5scrv2QFCr9DoW8vhHAb9+uEsApY0TTvdSRs91PmMW1y24FYGBZtA3ilE21Mpru1h9XIRspqq2emYlNUcA2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418293; c=relaxed/simple;
	bh=PKUPNUZ2RV6HsV0xRs7B0yHoY4zdkIpdet15NZfRcGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqQ+8kEoUCt9I/hDkrRb0rwJbma0p223umz3maPaYs9Hv7+pDlK4C/hi7w7WHTVNe9pYla7q+yfpg4D1gQAeFa0H18BFKhgkNZPoJBGAhvv5iL22sA3+XFcpLalIyxNZjNmV0ERTqKF5cbhdQMzpVl4jDkD9dGAxXvkoBSrZVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RVEUkeVl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RVEUkeVl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D41B521102;
	Thu,  9 Jan 2025 10:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKILP94GG+tbtZbtT5qm9zMCRhI47cKqPm+w5w5nfgM=;
	b=RVEUkeVlI3e1ZhOhBvgYCTpP94RIHVwjSLfgK7qLObUrpNf/LgDmL+eYRoO76mKASO7ZQd
	nEAfpALpuk+0zzNhcPkQqDT/8fbR/KBVQCWA8NrrqUpuVMjkvVRHQIGPa6EBv6lh9/wg2T
	ZPXU+UwNg+Rd4l9h37AZJ+SlPz9Amk4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RVEUkeVl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKILP94GG+tbtZbtT5qm9zMCRhI47cKqPm+w5w5nfgM=;
	b=RVEUkeVlI3e1ZhOhBvgYCTpP94RIHVwjSLfgK7qLObUrpNf/LgDmL+eYRoO76mKASO7ZQd
	nEAfpALpuk+0zzNhcPkQqDT/8fbR/KBVQCWA8NrrqUpuVMjkvVRHQIGPa6EBv6lh9/wg2T
	ZPXU+UwNg+Rd4l9h37AZJ+SlPz9Amk4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C02DB139AB;
	Thu,  9 Jan 2025 10:24:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lRjlLvGjf2d0EQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 17/18] btrfs: remove redundant variables from __process_folios_contig() and lock_delalloc_folios()
Date: Thu,  9 Jan 2025 11:24:45 +0100
Message-ID: <9c748689754aafdb3b42289a73a4d8897749d7a2.1736418116.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: D41B521102
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
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

Same pattern in both functions, we really only use index, start_index is
redundant.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 37f0ad389022..0faa9e2f772a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -198,9 +198,8 @@ static void __process_folios_contig(struct address_space *mapping,
 				    u64 end, unsigned long page_ops)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(mapping->host);
-	pgoff_t start_index = start >> PAGE_SHIFT;
+	pgoff_t index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
-	pgoff_t index = start_index;
 	struct folio_batch fbatch;
 	int i;
 
@@ -242,9 +241,8 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct address_space *mapping = inode->i_mapping;
-	pgoff_t start_index = start >> PAGE_SHIFT;
+	pgoff_t index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
-	pgoff_t index = start_index;
 	u64 processed_end = start;
 	struct folio_batch fbatch;
 
-- 
2.47.1


