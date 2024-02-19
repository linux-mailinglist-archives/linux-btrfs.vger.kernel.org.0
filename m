Return-Path: <linux-btrfs+bounces-2490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD3685A1AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320401C21395
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473BD2C1A4;
	Mon, 19 Feb 2024 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sjw5pGs3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sjw5pGs3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35FB2C19D
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341206; cv=none; b=dpwP0SIeWhb5DhwW7TDipxGIS315rAiZfAO5Cka3fFPzJ0Wqg0gSOyeAdqBOL1ubk18+Z+HVqQFiAfuY6v3xXvmbNfKvH36DLH/3SUq+CPvfzZDsCRCzARolHNcLkvFgmBoB1Q4A6UIp0wf/vmwtP0DIrs6PXw2E25q6co55dqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341206; c=relaxed/simple;
	bh=ZMBfShbYLNcpPOfIf2gie+FE2PJgxSaS716YmGaZ+hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlfNYlY2PeSbhMOemNQUMFOsWHW9t2I3KFuJABO8sQnR9EoV83sG1zYJRB7BD6kaY8RdGoSGDPcVa3tw1KF/3yq2hOx6bEEfI83Z8DqYP4ur3tH+PYLGb3AqqgtkfXetNAjoHhVmBPOC10NqhuzfffeQmh1LPGxy7p4AOO2eg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sjw5pGs3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sjw5pGs3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B152722301;
	Mon, 19 Feb 2024 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2mZLdAAQiVjfxi/YLZeDM0xYOqONzBJI3szgJwoiAQ=;
	b=sjw5pGs3PJ3IjTTBY6L+sLxkRk9nxDhmq/5ZRI4koOdl8eR8U8C5dy+r+4jCKjlholtFK/
	eWtlmDiAIhg1LJ2xgNwpjZr7nZ0YYuw6cPVX0C31jSwtm1s/uzSkFL4t9JEg4UCqiQAfOW
	Dv4Z+BbwFsX4CQPCTwgzsKQMh7Xo5hY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2mZLdAAQiVjfxi/YLZeDM0xYOqONzBJI3szgJwoiAQ=;
	b=sjw5pGs3PJ3IjTTBY6L+sLxkRk9nxDhmq/5ZRI4koOdl8eR8U8C5dy+r+4jCKjlholtFK/
	eWtlmDiAIhg1LJ2xgNwpjZr7nZ0YYuw6cPVX0C31jSwtm1s/uzSkFL4t9JEg4UCqiQAfOW
	Dv4Z+BbwFsX4CQPCTwgzsKQMh7Xo5hY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AACDE139C6;
	Mon, 19 Feb 2024 11:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id R4qxKdI302WAZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/10] btrfs: move balance args conversion helpers to volumes.c
Date: Mon, 19 Feb 2024 12:12:43 +0100
Message-ID: <36c3839c47e73f46103077c505e34e82554f0502.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

The from/to CPU/disk helpers for balance args are used only in volumes,
no need to define them in accessors.h.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.h | 39 ---------------------------------------
 fs/btrfs/volumes.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index fa099f61fc8c..6fce3e8d3dac 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -853,45 +853,6 @@ static inline void btrfs_set_balance_sys(struct extent_buffer *eb,
 	write_eb_member(eb, bi, struct btrfs_balance_item, sys, ba);
 }
 
-static inline void btrfs_disk_balance_args_to_cpu(struct btrfs_balance_args *cpu,
-			       const struct btrfs_disk_balance_args *disk)
-{
-	memset(cpu, 0, sizeof(*cpu));
-
-	cpu->profiles = le64_to_cpu(disk->profiles);
-	cpu->usage = le64_to_cpu(disk->usage);
-	cpu->devid = le64_to_cpu(disk->devid);
-	cpu->pstart = le64_to_cpu(disk->pstart);
-	cpu->pend = le64_to_cpu(disk->pend);
-	cpu->vstart = le64_to_cpu(disk->vstart);
-	cpu->vend = le64_to_cpu(disk->vend);
-	cpu->target = le64_to_cpu(disk->target);
-	cpu->flags = le64_to_cpu(disk->flags);
-	cpu->limit = le64_to_cpu(disk->limit);
-	cpu->stripes_min = le32_to_cpu(disk->stripes_min);
-	cpu->stripes_max = le32_to_cpu(disk->stripes_max);
-}
-
-static inline void btrfs_cpu_balance_args_to_disk(
-				struct btrfs_disk_balance_args *disk,
-				const struct btrfs_balance_args *cpu)
-{
-	memset(disk, 0, sizeof(*disk));
-
-	disk->profiles = cpu_to_le64(cpu->profiles);
-	disk->usage = cpu_to_le64(cpu->usage);
-	disk->devid = cpu_to_le64(cpu->devid);
-	disk->pstart = cpu_to_le64(cpu->pstart);
-	disk->pend = cpu_to_le64(cpu->pend);
-	disk->vstart = cpu_to_le64(cpu->vstart);
-	disk->vend = cpu_to_le64(cpu->vend);
-	disk->target = cpu_to_le64(cpu->target);
-	disk->flags = cpu_to_le64(cpu->flags);
-	disk->limit = cpu_to_le64(cpu->limit);
-	disk->stripes_min = cpu_to_le32(cpu->stripes_min);
-	disk->stripes_max = cpu_to_le32(cpu->stripes_max);
-}
-
 /* struct btrfs_super_block */
 BTRFS_SETGET_STACK_FUNCS(super_bytenr, struct btrfs_super_block, bytenr, 64);
 BTRFS_SETGET_STACK_FUNCS(super_flags, struct btrfs_super_block, flags, 64);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bfe54745eae3..752144a31d79 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3512,6 +3512,44 @@ static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static void btrfs_disk_balance_args_to_cpu(struct btrfs_balance_args *cpu,
+					   const struct btrfs_disk_balance_args *disk)
+{
+	memset(cpu, 0, sizeof(*cpu));
+
+	cpu->profiles = le64_to_cpu(disk->profiles);
+	cpu->usage = le64_to_cpu(disk->usage);
+	cpu->devid = le64_to_cpu(disk->devid);
+	cpu->pstart = le64_to_cpu(disk->pstart);
+	cpu->pend = le64_to_cpu(disk->pend);
+	cpu->vstart = le64_to_cpu(disk->vstart);
+	cpu->vend = le64_to_cpu(disk->vend);
+	cpu->target = le64_to_cpu(disk->target);
+	cpu->flags = le64_to_cpu(disk->flags);
+	cpu->limit = le64_to_cpu(disk->limit);
+	cpu->stripes_min = le32_to_cpu(disk->stripes_min);
+	cpu->stripes_max = le32_to_cpu(disk->stripes_max);
+}
+
+static void btrfs_cpu_balance_args_to_disk(struct btrfs_disk_balance_args *disk,
+					   const struct btrfs_balance_args *cpu)
+{
+	memset(disk, 0, sizeof(*disk));
+
+	disk->profiles = cpu_to_le64(cpu->profiles);
+	disk->usage = cpu_to_le64(cpu->usage);
+	disk->devid = cpu_to_le64(cpu->devid);
+	disk->pstart = cpu_to_le64(cpu->pstart);
+	disk->pend = cpu_to_le64(cpu->pend);
+	disk->vstart = cpu_to_le64(cpu->vstart);
+	disk->vend = cpu_to_le64(cpu->vend);
+	disk->target = cpu_to_le64(cpu->target);
+	disk->flags = cpu_to_le64(cpu->flags);
+	disk->limit = cpu_to_le64(cpu->limit);
+	disk->stripes_min = cpu_to_le32(cpu->stripes_min);
+	disk->stripes_max = cpu_to_le32(cpu->stripes_max);
+}
+
 static int insert_balance_item(struct btrfs_fs_info *fs_info,
 			       struct btrfs_balance_control *bctl)
 {
-- 
2.42.1


