Return-Path: <linux-btrfs+bounces-17866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A27BE16E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 06:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EA324E3EE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 04:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321D71FF1B4;
	Thu, 16 Oct 2025 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sp95Ye1X";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sp95Ye1X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603DC18872A
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589192; cv=none; b=s/JCBZ8dA1iIdvvAUcZtg0PI4uctReaGUSm9XUHJRiQ709zcVH26/AZmfCi8Tp97G4HUnhAbKrq3BQg/VSakqRMmEbRA/NR8jUgSf8hA/p9nW3LlF9hzfbRl5pp3VKlLkjt66xw5rlz6gwJ9w+i6ycRjm4/l3Hb+z6/mEBTuv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589192; c=relaxed/simple;
	bh=7/XrBfmfr+Z2brICnUApcAoV1Za4eGUXt+FoLZCW/ys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxfFtTNj34PSAthX6jgOWOV2p26B6YLq9KwJcir6ynWAuBK4ZjXHJ0l+OlzAklNM0g3xiPviUxBkPb3plM3CSh4xca1RqJDr/XjoA8cQQkdeuILQSNUNmv5pL54Guzx2ShNucW5/AQ+mCmHanjiGzsQ6i1YON0CgHCdgvaK4jQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sp95Ye1X; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sp95Ye1X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1DBE91F7BA
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760589174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l52G0rudst2Ap3ESijdBr/sjs8/vLHP1mi5xMEhfzPo=;
	b=sp95Ye1XOepZ0zAF/u9lSD4069MCA/6+LaTzojFR6rK5LGJhD0KWKZ33BmUZaI1Gr1p+++
	9QGWrGb+WLe2OQCaMTBkW65lGxmsTNVXed1HiaajZJVq4KhsnPXDOtSgDwtepWrzAKAzkA
	VWLfz46vXTuO1B7hZLUitj2Hq2r6nkE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760589174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l52G0rudst2Ap3ESijdBr/sjs8/vLHP1mi5xMEhfzPo=;
	b=sp95Ye1XOepZ0zAF/u9lSD4069MCA/6+LaTzojFR6rK5LGJhD0KWKZ33BmUZaI1Gr1p+++
	9QGWrGb+WLe2OQCaMTBkW65lGxmsTNVXed1HiaajZJVq4KhsnPXDOtSgDwtepWrzAKAzkA
	VWLfz46vXTuO1B7hZLUitj2Hq2r6nkE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54CFC1376E
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iGqPBXV18GiqNQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: scrub: cancel the run if there is a pending signal
Date: Thu, 16 Oct 2025 15:02:31 +1030
Message-ID: <33c132d328ad7020d68724b1c6918846382438a8.1760588662.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760588662.git.wqu@suse.com>
References: <cover.1760588662.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Unlike relocation, scrub never checks pending signals, and even for
relocation is only explicitly checking for fatal signal (SIGKILL), not
for regular ones.

Thankfully relocation can still be interrupted by regular signals by
the usage of wait_on_bit(), which is interruptible by regular signals.

So add the proper signal pending checks for scrub, by checking all
pending signals, and if we hit one signal cancel the scrub run since the
signal handling can only be done in the user space.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 728d4e666054..f3dfb7023499 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2080,6 +2080,13 @@ static bool should_cancel_scrub(struct btrfs_fs_info *fs_info)
 	if (fs_info->sb->s_writers.frozen > SB_UNFROZEN ||
 	    freezing(current))
 		return true;
+	/*
+	 * Signal handling is also done in user space, so we have to return
+	 * to user space by canceling the run when there is a pending signal.
+	 * (including non-fatal ones like SIGINT)
+	 */
+	if (signal_pending(current))
+		return true;
 	return false;
 }
 
-- 
2.51.0


