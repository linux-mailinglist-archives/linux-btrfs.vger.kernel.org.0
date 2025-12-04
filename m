Return-Path: <linux-btrfs+bounces-19508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C2ACA24A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 05:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A7730671D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 04:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057042048;
	Thu,  4 Dec 2025 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rAMbKlG+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rAMbKlG+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24A1D6BB
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764821333; cv=none; b=o9wYhTwwUwCLUiQtq3wf8kjWChndOEKXHcHDMb13vbmgwAbHoJFl6t8HldK6LCPWlTQV+dZTQyygosoKNqv3EfPP/CagjuXqxowjztWAq/DA2fGOFajsLrYNOpsCvB0u+QD5fTeJpzBQn5U6XM89EkPzB7pJF/pLpXSD3X8rZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764821333; c=relaxed/simple;
	bh=IiB8a6HBX90FfOu68nA6+ewzPqpATcLdG3CQ1J1cuTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chVBVu90Vrc9+qFxtyMrZ53dA474Ttyi+imYRSoRsJUOqDkhnoxJhzyjhaDc1I9eFgGSAVAZQAs+cx1YQ6o173YRffHPDEEDcqv4AAH7vl6xZs0kDhAiJxZfaF5Vt9BTIZJZFtfdim7k6kbAWLt1s7MiTloBUUUHCdEZN96p83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rAMbKlG+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rAMbKlG+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0E815BD42;
	Thu,  4 Dec 2025 04:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764821325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W+v/RxXo27EKNz9ntRmrjUSg0ht+ac3LHuApjAGFcc4=;
	b=rAMbKlG+9bJZ7YSQcx26twIzVXOHMD4MeBBl1Se6+uVmhUwTeZVTdcBgkjQzh/aNAklOfq
	qvkiZDV1RV3oK4FBqAnLW/vpYwMF1PlcuM1vQvv+t2DfUgX9MEkEH//3CEHcLj8dufqONX
	5ljWtwdxrAg5bRchZsf6n+ii3ZhX8Rg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rAMbKlG+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764821325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W+v/RxXo27EKNz9ntRmrjUSg0ht+ac3LHuApjAGFcc4=;
	b=rAMbKlG+9bJZ7YSQcx26twIzVXOHMD4MeBBl1Se6+uVmhUwTeZVTdcBgkjQzh/aNAklOfq
	qvkiZDV1RV3oK4FBqAnLW/vpYwMF1PlcuM1vQvv+t2DfUgX9MEkEH//3CEHcLj8dufqONX
	5ljWtwdxrAg5bRchZsf6n+ii3ZhX8Rg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2C253EA63;
	Thu,  4 Dec 2025 04:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BIUEIUwJMWmMBQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 04 Dec 2025 04:08:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH] btrfs: qgroup: update all parent qgroups when doing quick inherit
Date: Thu,  4 Dec 2025 14:38:23 +1030
Message-ID: <44875ba8294669ec2125476a5c2f7256cb534de5.1764821238.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: C0E815BD42
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email,suse.com:mid,suse.com:dkim,suse.com:email];
	URIBL_BLOCKED(0.00)[bur.io:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

[BUG]
There is a bug that if a subvolume has multi-level parent qgroups, and
is able to do a quick inherit, only the direct parent qgroup got
updated:

 mkfs.btrfs  -f -O quota $dev
 mount $dev $mnt
 btrfs subv create $mnt/subv1
 btrfs qgroup create 1/100 $mnt
 btrfs qgroup create 2/100 $mnt
 btrfs qgroup assign 1/100 2/100 $mnt
 btrfs qgroup assign 0/256 1/100 $mnt
 btrfs qgroup show -p --sync $mnt

 Qgroupid    Referenced    Exclusive Parent     Path
 --------    ----------    --------- ------     ----
 0/5           16.00KiB     16.00KiB -          <toplevel>
 0/256         16.00KiB     16.00KiB 1/100      subv1
 1/100         16.00KiB     16.00KiB 2/100      2/100<1 member qgroup>
 2/100         16.00KiB     16.00KiB -          <0 member qgroups>

 btrfs subv snap -i 1/100 $mnt/subv1 $mnt/snap1
 btrfs qgroup show -p --sync $mnt

 Qgroupid    Referenced    Exclusive Parent     Path
 --------    ----------    --------- ------     ----
 0/5           16.00KiB     16.00KiB -          <toplevel>
 0/256         16.00KiB     16.00KiB 1/100      subv1
 0/257         16.00KiB     16.00KiB 1/100      snap1
 1/100         32.00KiB     32.00KiB 2/100      2/100<1 member qgroup>
 2/100         16.00KiB     16.00KiB -          <0 member qgroups>
 # Note that 2/100 is not updated, and qgroup numbers are inconsistent

 umount $mnt

[CAUSE]
If the snapshot source subvolume belongs to a parent qgroup, and the new
snapshot target is also added to the new same parent qgroup, we allow a
quick update without marking qgroup inconsistent.

But that quick update only update the parent qgroup, without checking if
there is any more parent qgroups.

[FIX]
Iterate through all parent qgroups during the quick inherit.

Reported-by: Boris Burkov <boris@bur.io>
Fixes: b20fe56cd285 ("btrfs: qgroup: allow quick inherit if snapshot is created and added to the same parent")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 58fb55644be5..7c23fa1c252b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3256,7 +3256,10 @@ static int qgroup_snapshot_quick_inherit(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_qgroup *src;
 	struct btrfs_qgroup *parent;
+	struct btrfs_qgroup *qgroup;
 	struct btrfs_qgroup_list *list;
+	LIST_HEAD(qgroup_list);
+	const u32 nodesize = fs_info->nodesize;
 	int nr_parents = 0;
 
 	src = find_qgroup_rb(fs_info, srcid);
@@ -3293,8 +3296,19 @@ static int qgroup_snapshot_quick_inherit(struct btrfs_fs_info *fs_info,
 	if (parent->excl != parent->rfer)
 		return 1;
 
-	parent->excl += fs_info->nodesize;
-	parent->rfer += fs_info->nodesize;
+	qgroup_iterator_add(&qgroup_list, parent);
+	list_for_each_entry(qgroup, &qgroup_list, iterator) {
+		qgroup->rfer += nodesize;
+		qgroup->rfer_cmpr += nodesize;
+		qgroup->excl += nodesize;
+		qgroup->excl_cmpr += nodesize;
+		qgroup_dirty(fs_info, qgroup);
+
+		/* Append parent qgroups to @qgroup_list. */
+		list_for_each_entry(list, &qgroup->groups, next_group)
+			qgroup_iterator_add(&qgroup_list, list->group);
+	}
+	qgroup_iterator_clean(&qgroup_list);
 	return 0;
 }
 
-- 
2.52.0


