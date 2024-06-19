Return-Path: <linux-btrfs+bounces-5828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89F990F4D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 19:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F6428225E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4B3155C96;
	Wed, 19 Jun 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JiIbHhNp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JiIbHhNp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BEA155738
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816968; cv=none; b=bSYpnH8YLvXKehWnlECyK1nzO1+sKIkJGE3jQpGUxl/VkFR8Rwrg4i2OpuWsxhgyacwMAdwUW2k8JUV/nI6AnDGF/O2vOTBN17hcHm+XVKl2QSXeMHaV7gtLNNqJXiXuhiIKBRRmclW7s7sA12slrgsYBmTenNhXBZT6irCpPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816968; c=relaxed/simple;
	bh=ginm0jt1MW7Q/dBDD2MwpIG/2untn3d2fIOCQMLPfMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nx4sNRl810FVG4A+v8ZjYErUfhPhJW6R5fNkdfcQQRORuyzw/MDeDoWG6hnewicAU94qR8gqeZlpREqZe/OKijs1crxwI54gku1voTi2vvHhkyB0qUTTu6BEoObeH+OkJMqAlKjHL5rYzoT8d9wpscZiIzfTqlMqcFQHbi6csrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JiIbHhNp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JiIbHhNp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8344F1F7C7;
	Wed, 19 Jun 2024 17:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718816964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnvIGaBpctrqUwXpspIDQZY1WeoPJJ0OB+ogcY0QUwY=;
	b=JiIbHhNp/3C5BXUPaiR1Xgy0cJCO03OSAILZ3tCjjkHlJKgKkDzMHM4oftg96L0fXRL1Ni
	izTMB/yFwFJ+YJXgYwwg2RGmnI3Vj2qtpeYaAgoY1DHf8o+Qm3i38yitCb4nGAl5paKBCa
	IHuZO4SrM4SWy0yx7zyiatlP22/cUk4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718816964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnvIGaBpctrqUwXpspIDQZY1WeoPJJ0OB+ogcY0QUwY=;
	b=JiIbHhNp/3C5BXUPaiR1Xgy0cJCO03OSAILZ3tCjjkHlJKgKkDzMHM4oftg96L0fXRL1Ni
	izTMB/yFwFJ+YJXgYwwg2RGmnI3Vj2qtpeYaAgoY1DHf8o+Qm3i38yitCb4nGAl5paKBCa
	IHuZO4SrM4SWy0yx7zyiatlP22/cUk4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DBD513668;
	Wed, 19 Jun 2024 17:09:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HqewHsQQc2aRQwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 19 Jun 2024 17:09:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: qgroup: warn about inconsistent qgroups when relation update fails
Date: Wed, 19 Jun 2024 19:09:20 +0200
Message-ID: <913ab94d58070b19dee7aa6760a111c31be473a1.1718816796.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1718816796.git.dsterba@suse.com>
References: <cover.1718816796.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Calling btrfs_handle_fs_error() after btrfs_run_qgroups() fails to
update the qgroup status is probably not necessary, this would turn the
filesystem to read-only. For the same reason aborting the transaction is
also not a good option.

The state is left inconsistent and can be fixed by rescan, printing a
warning should be sufficient. Return code reflects the status of
adding/deleting the relation and if the transaction was ended properly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 31c4aea8b93a..f893a6b711c6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3877,8 +3877,9 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 	err = btrfs_run_qgroups(trans);
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (err < 0)
-		btrfs_handle_fs_error(fs_info, err,
-				      "failed to update qgroup status and info");
+		btrfs_warn(fs_info,
+			   "qgroup status update failed after %s relation, marked as inconsistent",
+			   sa->assign ? "adding" : "deleting");
 	err = btrfs_end_transaction(trans);
 	if (err && !ret)
 		ret = err;
-- 
2.45.0


