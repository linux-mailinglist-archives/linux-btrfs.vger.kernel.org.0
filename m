Return-Path: <linux-btrfs+bounces-7781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3370969571
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C50F1F219BC
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0631200111;
	Tue,  3 Sep 2024 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mhMbVABv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mhMbVABv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF71DAC75
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348571; cv=none; b=qoeZ052uSEQGx2XcT+vWxSRfUb3PUboxYI35yK6sWesfgCt9D82BvwoYJvnUePdAvlt7rb6WVgSyi6lanYtRVWD+ZhDb5y+1WdwBjObyipa0wNLTvtE1Rs+scyNgCFuwlDNnHmeaHr8+2jq+3DTHug/JRH9ODWR1Av6Kcp0/YQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348571; c=relaxed/simple;
	bh=Sg1sYL/NQjcQoSnyEqU3YuSPYWd/oqwWECSk2HqgJtQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPPBn6wJtmDuG/GmOkbOeqRBT48g2nQXysABGnRMFK1FKAhKBHVsC0CkHae4YJ6PWKCeB1R8LqOvnaBGprmDNZrw3QpClEvpdUelIw0kDk9vfNly/NzUZxBsCDQeDqEmX8OPMQ9UxWUnCxjXfH1r0/CFk5n9d5VvzwH9n96E80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mhMbVABv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mhMbVABv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB21621B82
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725348567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAd2/Ipad3Nx0DnLeNeJ4cndkfT0cQfKsRsaALyRJ2U=;
	b=mhMbVABvOQ6+ZLIA84sMBidy2h/KhO2t+N0rb76wIUTrs5q45Oy6WxQmkBOb5hCBODwknt
	DWmC/LGWysINIWGjjFZYeVQV3Gpuwv0KhIlpUz0Fqfgx7qidi5NPDmM7gJ+5GfAMSadZKv
	8uIL/V9FK/CXJ2nCQBqgucqqKH9EaHY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725348567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAd2/Ipad3Nx0DnLeNeJ4cndkfT0cQfKsRsaALyRJ2U=;
	b=mhMbVABvOQ6+ZLIA84sMBidy2h/KhO2t+N0rb76wIUTrs5q45Oy6WxQmkBOb5hCBODwknt
	DWmC/LGWysINIWGjjFZYeVQV3Gpuwv0KhIlpUz0Fqfgx7qidi5NPDmM7gJ+5GfAMSadZKv
	8uIL/V9FK/CXJ2nCQBqgucqqKH9EaHY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E95AB13A52
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8HKLKta61mY2TwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 07:29:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: check/original: detect invalid file extent items for symbol links
Date: Tue,  3 Sep 2024 16:59:00 +0930
Message-ID: <82d4efde3f7f4cf14767629f647fb01698e31312.1725348299.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725348299.git.wqu@suse.com>
References: <cover.1725348299.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
There is a recent bug that btrfs/012 fails and kernel rejects to read a
symbol link which is backed by a regular extent.

Furthremore in that case, "btrfs check" doesn't detect such problem at
all.

[CAUSE]
For symbol links, we only allow inline file extents, and this means we
should only have a symbol link target which is smaller than 4K.

But btrfs check doesn't handle symbol link inodes any differently, thus
it doesn't check if the file extents are inlined or not, nor reporting
this problem as an error.

[FIX]
When processing data extents, if we find the owning inode is a symbol
link, and the file extent is regular/preallocated, mark the inode with
I_ERR_FILE_EXTENT_TOO_LARGE error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/check/main.c b/check/main.c
index 205bbb4a3c73..93da49b70fc4 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1745,6 +1745,13 @@ static int process_file_extent(struct btrfs_root *root,
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (disk_bytenr > 0)
 			rec->found_size += num_bytes;
+		/*
+		 * Symbol link should only have inlined extent.
+		 * A regular extent means it's already too large to
+		 * be inlined.
+		 */
+		if (S_ISLNK(rec->imode))
+			rec->errors |= I_ERR_FILE_EXTENT_TOO_LARGE;
 	} else {
 		rec->errors |= I_ERR_BAD_FILE_EXTENT;
 	}
-- 
2.46.0


