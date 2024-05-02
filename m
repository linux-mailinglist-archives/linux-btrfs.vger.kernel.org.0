Return-Path: <linux-btrfs+bounces-4678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B048BA1B9
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 22:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3171F21DBF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 20:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E173180A95;
	Thu,  2 May 2024 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fpzd1MgO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fpzd1MgO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5B1E86E
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683203; cv=none; b=eJJzpRUDOCBF1ySBYkD/suzSFLAJO3Pb74x/3fgoQtpki7RxUIfC9S0oF2U/MqvIq5DhINHICut1YZJUCLv5tShYuBQh4qNJpPHzJm46sPGvNW8UmYx3plgUgyrDfut7DDM2d2lZgbWTIx/Wnl7Sj41dnnJJiKn8ppZhbLpurVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683203; c=relaxed/simple;
	bh=2QqjL/F/h2NHAtLNiM/a3tQczbwpMtpyMD2miPtzrz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+8rfko6PLzbZLUx6gBcvJwyHuGi0Gp0oYqODjr60Y/2Nd5m4ykHtOH+tTI6nUXHw0zlSJN8PCsv60+jxrzoPaZ+QC6pitb67ej0lJb+vT/iTI2wvgNeAHw6vcS9vQ9UFEzY7a5TTOLM794Vc6zXphpVU0O1oWrj8tj6l7lr/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fpzd1MgO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fpzd1MgO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EBE81FD2A;
	Thu,  2 May 2024 20:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714683200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2OHQsO5ZZpXOje3rTuOsSGfk11GTl2iGj7TppHepGGE=;
	b=Fpzd1MgOc7HY6cEgKZIpYMziFRIzGuj2YwBIbmyQm9WUi2DfV5RhPrVRjD42SgZiREN2FC
	3EjqQZlV0YTCFxhqlZwJhBNeivGCpZn4aIL4NAOZ7KkYp+5a9YsJjE1t7zjo8WP6xPwEEd
	xJzsICKPoPszfmAiCIrNA/NwKgPq0r8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714683200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2OHQsO5ZZpXOje3rTuOsSGfk11GTl2iGj7TppHepGGE=;
	b=Fpzd1MgOc7HY6cEgKZIpYMziFRIzGuj2YwBIbmyQm9WUi2DfV5RhPrVRjD42SgZiREN2FC
	3EjqQZlV0YTCFxhqlZwJhBNeivGCpZn4aIL4NAOZ7KkYp+5a9YsJjE1t7zjo8WP6xPwEEd
	xJzsICKPoPszfmAiCIrNA/NwKgPq0r8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 258951386E;
	Thu,  2 May 2024 20:53:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XrHaCED9M2ZZWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 02 May 2024 20:53:20 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: qgroup: update rescan message levels and error codes
Date: Thu,  2 May 2024 22:45:58 +0200
Message-ID: <20240502204558.16824-1-dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.39
X-Spam-Level: 
X-Spamd-Result: default: False [-1.39 / 50.00];
	BAYES_HAM(-1.59)[92.39%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_ALL(0.00)[]

On filesystems without enabled quotas there's still a warning message in
the logs when rescan is called. In that case it's not a problem that
should be reported, rescan can be called unconditionally and leads.
Change the error code to ENOTCONN which is used for 'quotas not enabled'
elsewhere.

Remove message (also a warning) when rescan is called during an ongoing
rescan, this brings no useful information and the error code is
sufficient.

Change message levels to debug for now, they can be removed eventually.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1768fc6f232f..4714644daa78 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3820,14 +3820,14 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		/* we're resuming qgroup rescan at mount time */
 		if (!(fs_info->qgroup_flags &
 		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
-			btrfs_warn(fs_info,
+			btrfs_debug(fs_info,
 			"qgroup rescan init failed, qgroup rescan is not queued");
 			ret = -EINVAL;
 		} else if (!(fs_info->qgroup_flags &
 			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
-			btrfs_warn(fs_info,
+			btrfs_debug(fs_info,
 			"qgroup rescan init failed, qgroup is not enabled");
-			ret = -EINVAL;
+			ret = -ENOTCONN;
 		}
 
 		if (ret)
@@ -3838,14 +3838,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 
 	if (init_flags) {
 		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
-			btrfs_warn(fs_info,
-				   "qgroup rescan is already in progress");
 			ret = -EINPROGRESS;
 		} else if (!(fs_info->qgroup_flags &
 			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
-			btrfs_warn(fs_info,
+			btrfs_debug(fs_info,
 			"qgroup rescan init failed, qgroup is not enabled");
-			ret = -EINVAL;
+			ret = -ENOTCONN;
 		} else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
 			/* Quota disable is in progress */
 			ret = -EBUSY;
-- 
2.44.0


