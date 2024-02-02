Return-Path: <linux-btrfs+bounces-2050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75884652D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 01:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E45B1C23B04
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 00:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300EE63B7;
	Fri,  2 Feb 2024 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sep6tdsH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sep6tdsH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8AC5392
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835584; cv=none; b=ZqDhA8XJOJFSNJHM2qDnb53x0/5axdjkrNF+vWIA+BsHRYIQnzM/PEHiat91Qq6wFTOj4od7dUcQnvEk7dLM3wiBWUVY8EOxzHAVL4BkVHtoYBKkbbe9GAQcHsnXj/PYP9Fsyk0Lcm6AyANgo9qYLmMca9hYrE2Bz9uEj/UGFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835584; c=relaxed/simple;
	bh=7F524GntK/5Q/uxWentBB4IHrdwEEdjahzDLkjUOKkw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsRykOR/ZYLZmILIhMsJJpc9C9RCeIG//6VVbScFB4hD0j/Y1xNaw75HOKXh5GFcs0Iusb9oaKFSeX4BZckhLWb4A/y8RMlJWpCUhGQ3+BsAWGcW4Ro0+zmOi/tEPGa5D6fOXD2aChnBHpzIRIYlC5qTM+SsZlpPOO8MA+uGbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sep6tdsH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sep6tdsH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3BBB22131
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706835580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXKEUkzpI+RW0+wXEKTP5GQvF634lJAibaHYEcCXF0M=;
	b=sep6tdsHrmJ8NVyLiUrOQI3K1mN7uOi9HfKn0NLaTTV5Hz+8JSYtrQRQpX6qNN7bLNPA3i
	a2FD2/X1cB7PWOGrFDmNQYr1fOKNtFJfp9Tk0bXmqV9iI8ehUrv84vbwi2oGtZpR3iATSu
	ATZrm351SRHFUZZWb3XKhKKvSPf7w8g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706835580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXKEUkzpI+RW0+wXEKTP5GQvF634lJAibaHYEcCXF0M=;
	b=sep6tdsHrmJ8NVyLiUrOQI3K1mN7uOi9HfKn0NLaTTV5Hz+8JSYtrQRQpX6qNN7bLNPA3i
	a2FD2/X1cB7PWOGrFDmNQYr1fOKNtFJfp9Tk0bXmqV9iI8ehUrv84vbwi2oGtZpR3iATSu
	ATZrm351SRHFUZZWb3XKhKKvSPf7w8g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8779139AB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QACVKns+vGXABgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 00:59:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: rescue: properly close the fs for clear-ino-cache
Date: Fri,  2 Feb 2024 11:29:19 +1030
Message-ID: <c413bdf50d585364d867192889a761d8785a0ed5.1706827356.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706827356.git.wqu@suse.com>
References: <cover.1706827356.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sep6tdsH
X-Spamd-Result: default: False [3.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.67%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.65
X-Rspamd-Queue-Id: B3BBB22131
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

[BUG]
In cmd_rescue_clear_ino_cache(), we opened the fs, but without
closing it using close_ctree().

[CAUSE]
All my bad, I forgot it, as the original code is inside btrfs check, and
had a "goto out_close;" to properly close the fs.

[FIX]
Manually call close_ctree() on the fs_info->tree_root.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/rescue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index 621e243b2073..6d7d526df145 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -451,6 +451,7 @@ static int cmd_rescue_clear_ino_cache(const struct cmd_struct *cmd,
 	} else {
 		pr_verbose(LOG_DEFAULT, "Successfully cleared ino cache");
 	}
+	close_ctree(fs_info->tree_root);
 out:
 	return !!ret;
 }
-- 
2.43.0


