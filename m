Return-Path: <linux-btrfs+bounces-4862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C788C0D45
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 11:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789121C20F50
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2168114A4EE;
	Thu,  9 May 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pppTNo6Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pppTNo6Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2B13C9B6
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245979; cv=none; b=tx/upG/I88I4+wph4lb74OtpwvguVIv0+kwVaSMf4kSLzr9/5R3UaVhVE1Zuw3DMTSVFxJ5soenCvJ9w7g6heKQJeRTVClIEfz1mm4Ij9VWKZjvmL/uR/yFwTuOk0pzSjpfFfjya8gZNwWz8Mhl8PLVmnXbPmhsBCKQconNV8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245979; c=relaxed/simple;
	bh=vc39rJyAcCIKJgZixZ9AoHHDoMlC18Wgn16qGlJGTvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XObeYIF7Wz07HdMsxJumr71oE4LaaK0Virm3TczyM1j5EAgXtz42ka7S9D+CQSn3BE3VSehNa1H8aEq1rkBHLhZNXa+o8fSus8zCKfxeXRfXLJ4QqSswxqdTWojp3uA/5FS4vdlNEdXNKyEGH0KDOOzCNYGW0bq2WswB/njzt/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pppTNo6Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pppTNo6Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC4535FB79
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpk7qKBoSTCAT8jziOYN38RkbBLjS4HQjVw9B3XGUpw=;
	b=pppTNo6Y/iqHSMk/jBE6EyrrjNdfAEHPXrjG+htOHLGboKMcaYB7h7d+4LDUy4ksaBdYzq
	xbxhA3hVink5snZlWZOMT2ERgXo+NIs/iMpwhq++r9F/4gK4PT2LXi8qk7iuQeX/pp111q
	5JZogiTaNxCTBd5HWLZjQZGo2Ud0HPU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pppTNo6Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpk7qKBoSTCAT8jziOYN38RkbBLjS4HQjVw9B3XGUpw=;
	b=pppTNo6Y/iqHSMk/jBE6EyrrjNdfAEHPXrjG+htOHLGboKMcaYB7h7d+4LDUy4ksaBdYzq
	xbxhA3hVink5snZlWZOMT2ERgXo+NIs/iMpwhq++r9F/4gK4PT2LXi8qk7iuQeX/pp111q
	5JZogiTaNxCTBd5HWLZjQZGo2Ud0HPU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1F8F13A24
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0GPXJpaTPGZ6KgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 09:12:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: cmds/qgroup: add qgroup_lookup::flags member
Date: Thu,  9 May 2024 18:42:31 +0930
Message-ID: <4be206be0c707e60526f5de9edfa8ec9c435338b.1715245781.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-2.19)[96.16%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BC4535FB79
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.20

This allows the users to identify if the running qgroup mode and whether
the numebrs are already inconsistent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/qgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 09eac0d2b36e..a023f0948180 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -65,6 +65,8 @@ struct btrfs_qgroup_list {
 };
 
 struct qgroup_lookup {
+	/* This matches btrfs_qgroup_status_item::flags. */
+	u64 flags;
 	struct rb_root root;
 };
 
@@ -1313,6 +1315,7 @@ static int __qgroups_search(int fd, struct btrfs_tree_search_args *args,
 			case BTRFS_QGROUP_STATUS_KEY:
 				si = btrfs_tree_search_data(args, off);
 				flags = btrfs_stack_qgroup_status_flags(si);
+				qgroup_lookup->flags = flags;
 
 				print_status_flag_warning(flags);
 				break;
-- 
2.45.0


