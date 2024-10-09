Return-Path: <linux-btrfs+bounces-8705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8E996DDD
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301A8B21672
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3319F495;
	Wed,  9 Oct 2024 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MESlW/pi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MESlW/pi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734D19DF48
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484284; cv=none; b=kychwr6cXfwWE4nKf94ATejP3wS8AxiTVOD7uhnez02M4ahmVPZiOnyzp4T+9O/P/f+glwUDtqqx+lroaiksqF4XoDYVAOoUZYBy9MdJoUEJUtAxcHklmIPmLroGkb5+0T04zSglk03P2/0Sg29Zif0MMJC8vEAk8tTlqRxACao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484284; c=relaxed/simple;
	bh=PWIwupP2EM10mehF1un3+6DX6XnRk8fr73jjtduods4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qn0+5XWAgvawx4GYloqrFE0S5t+c3vltgWca1TJNF0LEd2oVrFJ68/IY/tmI9OtQbRPu9TT1s2GYRwP9m6h5kWRtlY4tSYChcVyV+QT23o0iXKFbJfZxJpDW9dl/24gXeeUB6bCxR9JeNIkRyLMY7cm2tvjsEainpILpn+Ak9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MESlW/pi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MESlW/pi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0729721F7F;
	Wed,  9 Oct 2024 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8/fun+C3XpeWXhtdG84XaBW7YwWD6CLVMbblWMdMVs=;
	b=MESlW/piUVEYO/z/YLvtVCh4XpExZ4+YPLjKjw4TzVIp6M83rYZ5rAslJ7sRO5Wx7kcPWT
	pmZbZ7HERQbVxroO2Ner7a9gTWOEF6CaX099x1DNOllcN1PgRgVFNwEz4GW/nVI+QutLmh
	o/RrMCEIcqxt3z67ZpRiOonGZQm2Xhs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8/fun+C3XpeWXhtdG84XaBW7YwWD6CLVMbblWMdMVs=;
	b=MESlW/piUVEYO/z/YLvtVCh4XpExZ4+YPLjKjw4TzVIp6M83rYZ5rAslJ7sRO5Wx7kcPWT
	pmZbZ7HERQbVxroO2Ner7a9gTWOEF6CaX099x1DNOllcN1PgRgVFNwEz4GW/nVI+QutLmh
	o/RrMCEIcqxt3z67ZpRiOonGZQm2Xhs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0095F136BA;
	Wed,  9 Oct 2024 14:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WZAkALmTBmccRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:21 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/25] btrfs: qgroup: drop unused parameter fs_info from __del_qgroup_rb()
Date: Wed,  9 Oct 2024 16:31:20 +0200
Message-ID: <f48c99ff0ccb55eb8dae62576dd80fa8e4803c71.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

We don't need fs_info here, everything is reachable from qgroup.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 716f29717d5a..b2d421b4cd5a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -226,8 +226,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	return qgroup;
 }
 
-static void __del_qgroup_rb(struct btrfs_fs_info *fs_info,
-			    struct btrfs_qgroup *qgroup)
+static void __del_qgroup_rb(struct btrfs_qgroup *qgroup)
 {
 	struct btrfs_qgroup_list *list;
 
@@ -258,7 +257,7 @@ static int del_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
 		return -ENOENT;
 
 	rb_erase(&qgroup->node, &fs_info->qgroup_tree);
-	__del_qgroup_rb(fs_info, qgroup);
+	__del_qgroup_rb(qgroup);
 	return 0;
 }
 
@@ -643,7 +642,7 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 	while ((n = rb_first(&fs_info->qgroup_tree))) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
 		rb_erase(n, &fs_info->qgroup_tree);
-		__del_qgroup_rb(fs_info, qgroup);
+		__del_qgroup_rb(qgroup);
 		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
 		kfree(qgroup);
 	}
-- 
2.45.0


