Return-Path: <linux-btrfs+bounces-4866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EB38C0D49
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F64283617
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 09:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C686214A4E7;
	Thu,  9 May 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D0Hmuc2b";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D0Hmuc2b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3814A4F5
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245983; cv=none; b=FjiMMhOi7/Hyn15mVnqcS4AI5T1HVPm/mmMAKfPBep6eCA+6of2WHFkhUDp7MlRh3Y+JZ9Hx/L1TD0gG0yFGSklnbVwpBlOBPuwxEL8CXTYvbjlkg8EdmvBE/nPsGW4VtGgkLkKqYRvjrQZbV/6y/Cl+ba6/iHfbYlhWNpc64aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245983; c=relaxed/simple;
	bh=jPmC8oR1buiRxiLZBGlhmUIpRe7peg8sWHHkQ8LjVQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW4Tx/RKgafuFVl7Ao1hby3OGjjYKOfS+9/85bCedIKWch2m/T1I0+f3ktqeiH4C5PBArLG0xgVYmFkOQtj9eDZhMCQIq0VORkSwSXxyx2FzhowI1epmSsS/DqOfjeYiwL+BMmg20JK+2TVF0tHaR5KOCgF3lHrHVRbR/tMV0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D0Hmuc2b; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D0Hmuc2b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 614B43816E
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMwLpIs6cELiIfTA/xPCUi1vQIGX2VGbdA9o5p2puzE=;
	b=D0Hmuc2bSA1qhSeC/vD3FK3/yipEtjDlNEFl7kBV1eG20WiHO0or9qV3ZriLunexUzAnJ0
	6ssfVcGtPre4NinmF0RvgC3VYhY+Cj3aAXre45gVa6ZYKiGJLl2YRgRCv3aM1BdqZ6c6po
	YrVoZ6WSrcl52yLqkVSPUz6cmLKAKJM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMwLpIs6cELiIfTA/xPCUi1vQIGX2VGbdA9o5p2puzE=;
	b=D0Hmuc2bSA1qhSeC/vD3FK3/yipEtjDlNEFl7kBV1eG20WiHO0or9qV3ZriLunexUzAnJ0
	6ssfVcGtPre4NinmF0RvgC3VYhY+Cj3aAXre45gVa6ZYKiGJLl2YRgRCv3aM1BdqZ6c6po
	YrVoZ6WSrcl52yLqkVSPUz6cmLKAKJM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B9D113A24
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0C0FDJWTPGZ6KgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 09:12:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: cmds/qgroup: sync the fs before doing qgroup search
Date: Thu,  9 May 2024 18:42:30 +0930
Message-ID: <50d13a90a4dd1146fe6d755ec3a7e69ff9fba325.1715245781.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715245781.git.wqu@suse.com>
References: <cover.1715245781.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.16
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 50.00];
	BAYES_HAM(-1.36)[90.58%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Since qgroup numbers are only updated at transaction commit time, it's
better to do the a sync before reading the quota tree, to reduce the
chance of uncommitted qgroup changes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/qgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 6e88db5803a5..09eac0d2b36e 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -2135,6 +2135,7 @@ static const char * const cmd_qgroup_clear_stale_usage[] = {
 
 static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char **argv)
 {
+	enum btrfs_util_error err;
 	int ret = 0;
 	int fd;
 	char *path = NULL;
@@ -2151,6 +2152,11 @@ static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char *
 	if (fd < 0)
 		return 1;
 
+	/* Sync the fs so that the qgroup numbers are uptodate. */
+	err = btrfs_util_sync_fd(fd);
+	if (err)
+		warning("sync ioctl failed on '%s': %m", path);
+
 	ret = qgroups_search_all(fd, &qgroup_lookup);
 	if (ret == -ENOTTY) {
 		error("can't list qgroups: quotas not enabled");
-- 
2.45.0


