Return-Path: <linux-btrfs+bounces-5457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7528FC014
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 01:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D0C1F24B8F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 23:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116FC14E2CA;
	Tue,  4 Jun 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SrSq+97f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SrSq+97f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364114D2BF
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544657; cv=none; b=R5JtSc7DckzSqvYradGvZ5TwiiSjUOS2LaNZTtLX1a6lUsQwGnquri35yvxARuviJ2vftfrgEh7BjSwMkUPqSwFm/ci05WTb1c551yCgsyjW/KQ5oNijqB/NIQkJb6LzUf+QV7ydK5UL4bCQlstLE/j1dV9duGdGqhxwPKSxp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544657; c=relaxed/simple;
	bh=B2JZhXVX82KqO2IC4D3ehd5lWfbo5WqzaTS53eSfTO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkWnpiNo5eMskWuupnf7cJi7LCfAjBYvK9f/T2Q0UGCrkhnNkBOobFGZ9hi7FTZt4JF5M5OTZvvIv/j1N3D3/PvxMBXyfXp6HghP+Ly+lwvwGWOv106wXcU4zs8h2Hb6bq0/DcrmmaMA7wp2qeOYCeGbYvzlO9gMSmc3Yhcdu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SrSq+97f; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SrSq+97f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9A661F45A;
	Tue,  4 Jun 2024 23:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCgerXgamrnjEOuVzLLCP2y9jzWZfqiJhZiQOjxjWWw=;
	b=SrSq+97f4Li6LHIDSaAV0PgooGzfwo7ZyYtqOP+r1FrCg5Q4l6ffvk3GJLgaG0gXLtfLm4
	FQilsuBOOY0qGf0R7tU3LCOs+9mn8igdoW9Z0/SFIqnuM16lgViHANd38AvHM7qAX82zjj
	LzmQQfycbbm0oRUQC0RYDsyrsGTxbx4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCgerXgamrnjEOuVzLLCP2y9jzWZfqiJhZiQOjxjWWw=;
	b=SrSq+97f4Li6LHIDSaAV0PgooGzfwo7ZyYtqOP+r1FrCg5Q4l6ffvk3GJLgaG0gXLtfLm4
	FQilsuBOOY0qGf0R7tU3LCOs+9mn8igdoW9Z0/SFIqnuM16lgViHANd38AvHM7qAX82zjj
	LzmQQfycbbm0oRUQC0RYDsyrsGTxbx4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D22813A93;
	Tue,  4 Jun 2024 23:44:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sPQbEsumX2bcJwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 04 Jun 2024 23:44:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 3/4] btrfs-progs: error out immediately if an unknown backref type is hit
Date: Wed,  5 Jun 2024 09:13:43 +0930
Message-ID: <d5c1a2d6eaec18c818df3f0c9ba568761aa993d8.1717544015.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1717544015.git.wqu@suse.com>
References: <cover.1717544015.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.90
X-Spam-Level: 
X-Spamd-Result: default: False [-1.90 / 50.00];
	BAYES_HAM(-2.10)[95.61%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[]

There is a bug report that for fuzzed image
bko-155621-bad-block-group-offset.raw, "btrfs check --mode=lowmem
--repair" would lead to a deadloop.

Unlike original mode, lowmem mode relies on the backref walk to properly
go through each root, but unfortunately inside __add_inline_refs() we
doesn't handle unknown backref types correctly, causing it never moving
forward thus deadloop.

Fix it by erroring out to prevent deadloop.

Issue: #788
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/backref.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index 89ccf073fca7..f46f3267e144 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -650,7 +650,8 @@ static int __add_inline_refs(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		default:
-			WARN_ON(1);
+			error("invalid backref type: %u", type);
+			ret = -EUCLEAN;
 		}
 		if (ret)
 			return ret;
-- 
2.45.2


