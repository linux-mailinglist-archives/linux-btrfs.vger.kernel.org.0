Return-Path: <linux-btrfs+bounces-7844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A496CC1E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 03:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75FDFB24198
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 01:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63BC8FE;
	Thu,  5 Sep 2024 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HOMDPfrG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HOMDPfrG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262338F6E
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498834; cv=none; b=lPUxwAKlMU9hvRcRUxhbIZ4/cX9XbSPq2Isgakmzfi7tGc80zS+WzqzTYjcr4zHJqxNX79RFLcgGzmtWr6QMacrNprtQXvjcQayukREl1GG/UhZPAk/30tLOhLkou35q97aWPBIrNN94o2+jkJWQ2UinSW+CYju3wsQEUGtNDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498834; c=relaxed/simple;
	bh=qtJ/u922NqpONB/LtGvgwSV7sEQiNKZVax6VGDIymOg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHJkM2sqgs44J3dU5btVpW/ygZp9EL2pZB+owDVSensVGQ/wc6HhJmxOCVkWPl5u43M2x/kMuwnPiWeezylxfO5gMLdcn702E9pUlMJUOciuTC2x0cPk+MO2RD/tE32aL4m9lIoZReiybYmcNlRbHciXTACy3BYJM+YvUCJB1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HOMDPfrG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HOMDPfrG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5964D219C9
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2rTnlrTr/V+hvZrCoacc6TtHjuHlRjKvliG4WqKZ+s=;
	b=HOMDPfrGjDHeanlr8NLISr5h8p8Vfo0fXFTBZs9jKmVY045TqTz7ESTS8SRDIexdxP97G3
	e8esl23rdSNkFYIAuKRBsEZpX+9s6mm5nw8R1mYKxRY+tEd7ZJyJrs5YVZ3B5PksL59WV2
	XhEMu5A3G6BgpbOqml+kjDt3o1nMb+M=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2rTnlrTr/V+hvZrCoacc6TtHjuHlRjKvliG4WqKZ+s=;
	b=HOMDPfrGjDHeanlr8NLISr5h8p8Vfo0fXFTBZs9jKmVY045TqTz7ESTS8SRDIexdxP97G3
	e8esl23rdSNkFYIAuKRBsEZpX+9s6mm5nw8R1mYKxRY+tEd7ZJyJrs5YVZ3B5PksL59WV2
	XhEMu5A3G6BgpbOqml+kjDt3o1nMb+M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9035E13508
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UPEhFcwF2WbMKQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2024 01:13:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs-progs: check/original: detect invalid file extent items for symbolic links
Date: Thu,  5 Sep 2024 10:43:22 +0930
Message-ID: <88fb398f778e76297ca27817eb44697392279b53.1725498618.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725498618.git.wqu@suse.com>
References: <cover.1725498618.git.wqu@suse.com>
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
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
There is a recent bug that btrfs/012 fails and kernel rejects to read a
symbolic link which is backed by a regular extent.

Furthremore in that case, "btrfs check" doesn't detect such problem at
all.

[CAUSE]
For symbolic links, we only allow inline file extents, and this means we
should only have a symbolic link target which is smaller than 4K.

But btrfs check doesn't handle symbolic link inodes any differently, thus
it doesn't check if the file extents are inlined or not, nor reporting
this problem as an error.

[FIX]
When processing data extents, if we find the owning inode is a symbolic
link, and the file extent is regular/preallocated, mark the inode with
I_ERR_FILE_EXTENT_TOO_LARGE error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/check/main.c b/check/main.c
index 599f22ec36ee..d4108b7315e0 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1745,6 +1745,13 @@ static int process_file_extent(struct btrfs_root *root,
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (disk_bytenr > 0)
 			rec->found_size += num_bytes;
+		/*
+		 * Symbolic links should only have inlined extents.
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


