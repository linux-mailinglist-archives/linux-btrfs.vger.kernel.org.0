Return-Path: <linux-btrfs+bounces-14335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C281AAC9369
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014273A55DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A1319ABC2;
	Fri, 30 May 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pfD/aP9h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pfD/aP9h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794061494A8
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621940; cv=none; b=D5mMQv1bMSTDRpQIJAEccsjvpDP5Y06YKXjR5HJDgOZnr/WLvvuk8Ub2V+Y7CA9Rh12UJFBIQmz6/91VAX0/HAYKMXUKu3elD+SSt9RFmL/DpBYlnbTzs4oe3xTNx7T1ggOHQXSEa5IPpIMc1yNLPXN1SwpTa8b/OnYaAcxBLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621940; c=relaxed/simple;
	bh=BfaisxVW5jyMz1utzPxg6shKgKJFmMpS6bhKAo2sWmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2Zz9K3dlZ730uNJVFk2RlUBaXuTmmoGwBdgDGl/3qap1cwzO1eOZYt5DNa0QTHDfi4s2CxtJ6X4AsO3aWIZ4L4SwhkV5aAcnK7LQtvDt5xgPwzh1kWL4WKB06VRJDVuBRKFuLfh8oTdOZ66Lzz2Le9N6pvb2rELmv3B3onsHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pfD/aP9h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pfD/aP9h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D77221AF3;
	Fri, 30 May 2025 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDQpfQiU5VUyHWZJOfs+niB7Vvq0Q9Z1d7uZAVc4Vac=;
	b=pfD/aP9hbkqXZ7U0BLjAHnAJ0MwiPHK0JPpqd2lu2qn9KQftImeCzyBdltciUrT9G3BEWl
	9SbsbHPT9BNizZf3WG6OQnQ9Cjr8uOfHl5bcuoDyI3jz+c6UoqXD6x/454zdv5PWi6u02D
	Q0ysnJc/CiOA5+VsEiUrVmL0Tmpf0K4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDQpfQiU5VUyHWZJOfs+niB7Vvq0Q9Z1d7uZAVc4Vac=;
	b=pfD/aP9hbkqXZ7U0BLjAHnAJ0MwiPHK0JPpqd2lu2qn9KQftImeCzyBdltciUrT9G3BEWl
	9SbsbHPT9BNizZf3WG6OQnQ9Cjr8uOfHl5bcuoDyI3jz+c6UoqXD6x/454zdv5PWi6u02D
	Q0ysnJc/CiOA5+VsEiUrVmL0Tmpf0K4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6006013889;
	Fri, 30 May 2025 16:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6ctvF2TaOWj5ZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:18:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 16/22] btrfs: rename err to ret in calc_pct_ratio()
Date: Fri, 30 May 2025 18:18:40 +0200
Message-ID: <906aad7a5dfd73ce071cbf2d57ca75b34b4c4849.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/space-info.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 23685d6e8cbc..517916004f21 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1973,13 +1973,13 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 
 static u64 calc_pct_ratio(u64 x, u64 y)
 {
-	int err;
+	int ret;
 
 	if (!y)
 		return 0;
 again:
-	err = check_mul_overflow(100, x, &x);
-	if (err)
+	ret = check_mul_overflow(100, x, &x);
+	if (ret)
 		goto lose_precision;
 	return div64_u64(x, y);
 lose_precision:
-- 
2.47.1


