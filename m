Return-Path: <linux-btrfs+bounces-11438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A70A336F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 05:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9AC3A7F88
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 04:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239E82063E2;
	Thu, 13 Feb 2025 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u5kGsEyr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u5kGsEyr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380292063DA
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420980; cv=none; b=WPB8ggXJbezEH0m0YIp70WiHILWesc5RCMUVALXy8rq+q5q88Kk2BCYUCzNx77Zy2ACsZsDl5FZDq43jJNBhxMaoEvTHwDM8VxEzw4mq5K39XLev4ZKoJIpvxL1ElBF5C/U/OtP/GxJWJUObBnL3nWLVXH6xKMQi9Ld/FmKxP7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420980; c=relaxed/simple;
	bh=XfCnduDE+WV2B88Zu5OuClTXRnHNpBMIlFzARSSv53I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a04hcTN611n2OfZ+TVx7mjFTmSyXuEadt/Km19sydrkiUSZb4WHNDPSZHDKwiMRC7SNBfyOExpv2yTd3SSusF2le0XQOpsRotoDvfV9AEbAUGfyn8cIjmI3P3hsirIflgji0y/g8kC4A6hGF04xRVTVsyxJ9tb8prp5q3/Qi4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u5kGsEyr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u5kGsEyr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3667E1FB63
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 04:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739420976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T0UPDDpXKRcy/VlkfkOAL1BZZkTNDhPjqTSZpYCnouk=;
	b=u5kGsEyra+4UGtcLOyuxZFJUSrW9tlpqLuNUkPDdRmFIfpS8yO36yd2AnLOLLDUi86kJ7c
	kYK2LUOS9IHjMWWI8wj4buk6SVrOZAdr+HII616XhfRIpqma4ijQvD8mfN3E78moqvVeIN
	W8HwRbds01hK/MOQZAoEAczu7P3ocYo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=u5kGsEyr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739420976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T0UPDDpXKRcy/VlkfkOAL1BZZkTNDhPjqTSZpYCnouk=;
	b=u5kGsEyra+4UGtcLOyuxZFJUSrW9tlpqLuNUkPDdRmFIfpS8yO36yd2AnLOLLDUi86kJ7c
	kYK2LUOS9IHjMWWI8wj4buk6SVrOZAdr+HII616XhfRIpqma4ijQvD8mfN3E78moqvVeIN
	W8HwRbds01hK/MOQZAoEAczu7P3ocYo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6284B13AAB
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 04:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZewzCC91rWcwKwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 04:29:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: cmds/qgroup: use sysfs to detect inconsistent status early
Date: Thu, 13 Feb 2025 14:59:17 +1030
Message-ID: <7171b8a518e70a5b2e8e791dd078d7cc4f643b83.1739420945.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3667E1FB63
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:url,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Currently if "btrfs qgroup show" detects the qgroup is in an inconsistent,
it will output a warning:

  WARNING: qgroup data inconsistent, rescan recommended

But the detection is based on the tree search ioctl, and qgroup tree is
only updated at transaction commit time.

This means if qgroup is marked inconsistent, and the transaction is not
commit, there can be a huge window as long as 30s before "btrfs qgroup
show" to give a proper warning about inconsistent qgroup numbers.

To address this window, use the
'/sys/fs/btrfs/<fsid>/qgroup/inconsistent' file to do extra check.

That file is updated at real time, thus there is no delay, and can give
an early warning about inconsistent qgroup numbers.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1235765
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/qgroup.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index a612130c94b8..45439953be14 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -36,6 +36,7 @@
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/ctree.h"
 #include "common/open-utils.h"
+#include "common/sysfs-utils.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/units.h"
@@ -1610,6 +1611,33 @@ static void print_all_qgroups_json(struct qgroup_lookup *qgroup_lookup)
 	fmt_end(&fctx);
 }
 
+/*
+ * Tree search based inconsistent flag is only updated at transaction commit
+ * time.
+ * Thus even if the qgroup_status flag shows consistent, the qgroup may already
+ * be in an inconsistent status.
+ */
+static void check_qgroup_sysfs_inconsistent(int fd,
+		const struct qgroup_lookup *qgroup_lookup)
+{
+	u64 value;
+	int sysfs_fd;
+	int ret;
+
+	if (qgroup_lookup->flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
+		return;
+	sysfs_fd = sysfs_open_fsid_file(fd, "qgroups/inconsistent");
+	if (fd < 0)
+		return;
+	ret = sysfs_read_fsid_file_u64(fd, "qgroups/inconsistent", &value);
+	if (ret < 0)
+		goto out;
+	if (value)
+		warning("qgroup data inconsistent, rescan recommended");
+out:
+	close(sysfs_fd);
+}
+
 static int show_qgroups(int fd,
 		       struct btrfs_qgroup_filter_set *filter_set,
 		       struct btrfs_qgroup_comparer_set *comp_set)
@@ -1622,6 +1650,8 @@ static int show_qgroups(int fd,
 	ret = qgroups_search_all(fd, &qgroup_lookup);
 	if (ret)
 		return ret;
+
+	check_qgroup_sysfs_inconsistent(fd, &qgroup_lookup);
 	__filter_and_sort_qgroups(&qgroup_lookup, &sort_tree,
 				  filter_set, comp_set);
 	if (bconf.output_format == CMD_FORMAT_JSON)
-- 
2.48.1


