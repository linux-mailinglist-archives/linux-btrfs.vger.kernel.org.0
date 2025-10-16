Return-Path: <linux-btrfs+bounces-17881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A03BE27A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 11:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF18F3E1C8D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945F3191BD;
	Thu, 16 Oct 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nCZ0txL1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nCZ0txL1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359273074BC
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607803; cv=none; b=HW6yHIZ8CbzXOeCiqbqU+a3RYXc6ek4GXu2DaBnrpWrlEyHiXfZ5Zm8cv9XWCejuNei/tsdtFAaiBobB5sg7AwVi8THQQM0G1aCRpdiC3QHOZGB49ZEY46gxs1I9p7QkQNHoTCxfLtN6rH6IsjGdhcDML/biCXnRR/RZ177ZcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607803; c=relaxed/simple;
	bh=sJo1LaCn4EAFzTZ1o6dsvMb+1r2rpVjlryg2XZSQ6f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw2xQJc74Ol9UcJrvk+GdJ71cytCHFa6yL5G/+KFd8dMhgvXobIvhQjkU2Ud7iUQXnHYKajGcBlJJRmIsnYejFXnqsEku2O03ma5zSfHAX9Z+pqlte6y1w/a1+heDhqlX4fWX/xJrfIMpuOmXcg/XCXIJdm3+hSkP8ypJgaryfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nCZ0txL1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nCZ0txL1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F25021DC5;
	Thu, 16 Oct 2025 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760607781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlWzxhbMrB6kjuvKK0Z1ENN4dMWT3B4B1BJt3om/etw=;
	b=nCZ0txL1TRfFQnYBtCR3qFK9IFg7zGB5jxS7PDZFK6wLQxml6+PFpQDoZIF1+HiHyrwQOg
	LILhD9/sj8BWumVA+PYk4QVifBGWZLB1TS9SoY3jj334TLsf70BdOnSbcREg4fwr4R5jcp
	8Yca9nnICUXPDpWR0RHT+GBQfWhIV+g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nCZ0txL1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760607781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlWzxhbMrB6kjuvKK0Z1ENN4dMWT3B4B1BJt3om/etw=;
	b=nCZ0txL1TRfFQnYBtCR3qFK9IFg7zGB5jxS7PDZFK6wLQxml6+PFpQDoZIF1+HiHyrwQOg
	LILhD9/sj8BWumVA+PYk4QVifBGWZLB1TS9SoY3jj334TLsf70BdOnSbcREg4fwr4R5jcp
	8Yca9nnICUXPDpWR0RHT+GBQfWhIV+g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 882BE1340C;
	Thu, 16 Oct 2025 09:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Ow3EiS+8GgjYQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 16 Oct 2025 09:43:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 3/3] btrfs: scrub: cancel the run if there is a pending signal
Date: Thu, 16 Oct 2025 20:12:38 +1030
Message-ID: <395c1ee665584f092c089d73895d3f316730c6e8.1760607566.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760607566.git.wqu@suse.com>
References: <cover.1760607566.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F25021DC5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Unlike relocation, scrub never checks pending signals, and even for
relocation is only explicitly checking for fatal signal (SIGKILL), not
for regular ones.

Thankfully relocation can still be interrupted by regular signals by
the usage of wait_on_bit(), which is interruptible by regular signals.

So add the proper signal pending checks for scrub, by checking all
pending signals, and if we hit one signal cancel the scrub run since the
signal handling can only be done in the user space.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 214285b216ec..eec76055d245 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2098,6 +2098,13 @@ static bool should_cancel_scrub(struct scrub_ctx *sctx)
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


