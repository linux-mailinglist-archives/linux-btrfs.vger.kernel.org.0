Return-Path: <linux-btrfs+bounces-14232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B241EAC3860
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 06:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B2716FAF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 04:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7A17B4EC;
	Mon, 26 May 2025 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HXZzmrJu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HXZzmrJu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69844136E
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748232198; cv=none; b=I8WY0L4FPCzx3jiMV1qgAcZoKkhlrHxkYsur14fztNnsNoAPOVvMipwAhOtBcJKdHageDPp+vck9vzqP+JtLonsLqxiwibhm34m2HRhj/+o77x/vCbOe24DeUmGxUfRsO2a8LEi0XnoERr6UudhFTZv1DiqLrMB0eMP0d9RDr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748232198; c=relaxed/simple;
	bh=P0f00O8sJsUZeyhkF8Thd2tgxhrqm/1yzWFUep358oc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tor85uCwSNCjKDhTxreA6SZox9hS/tflpdfw4Gu84s6clwooflZfI1VKZQ+ghGumAyeYOwZuK3Mz0MpuWYo6uq29cTr0USvdTvh92aqENs/y9Ws16rcAlLqXD7mdSgUyDoIy4dEnBYmrMgj96TESLNpJy5hCYIxdY6KTz04UWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HXZzmrJu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HXZzmrJu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24D421FE32
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748232178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFByjaRnx7USRRsBPbZiIDX7t87ooVzHnlBDn4y1XD8=;
	b=HXZzmrJuCyyEzLHnJZo/bPazkMzj9hsBxqhJVgil85tVLLGakVBcxLbmvq+vXeS25LMfh9
	9j5bnF92zcuytoykTGAB24nTE3Cltx+gmlMbHFFHVEem5fRcjumP+plerNGzO3gcr5uQ5w
	ayB9dAE+4J0ha4+kWWckPIWy/U3Hl2k=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HXZzmrJu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748232178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFByjaRnx7USRRsBPbZiIDX7t87ooVzHnlBDn4y1XD8=;
	b=HXZzmrJuCyyEzLHnJZo/bPazkMzj9hsBxqhJVgil85tVLLGakVBcxLbmvq+vXeS25LMfh9
	9j5bnF92zcuytoykTGAB24nTE3Cltx+gmlMbHFFHVEem5fRcjumP+plerNGzO3gcr5uQ5w
	ayB9dAE+4J0ha4+kWWckPIWy/U3Hl2k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FAC613770
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iC2cCPHnM2g3ewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: mkfs: do not use extent buffer to writeback super block
Date: Mon, 26 May 2025 13:32:36 +0930
Message-ID: <853af7ac6dba2152696857403c568ffe7e8451b6.1748232037.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748232037.git.wqu@suse.com>
References: <cover.1748232037.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 24D421FE32
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

There is a long history that we used extent_buffer helpers to modify a
superblock, but we're moving out of that behavior, and migrate to use
the on stack helpers to modify super blocks.

In the function make_btrfs() we use a dummy extent buffer just to
calculate the checksum for the super block.
We do not need such workaround, and can manually call btrfs_csum_data()
on @super, and pass @super directly to sbwrite(), completely avoid the
need of a dummy extent buffer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/common.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index bb5a2ad46f4f..f785d8962a06 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -754,12 +754,9 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	}
 
 	/* and write out the super block */
-	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
-	memcpy(buf->data, &super, sizeof(super));
-	buf->len = BTRFS_SUPER_INFO_SIZE;
-	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
-			     cfg->csum_type);
-	ret = sbwrite(fd, buf->data, BTRFS_SUPER_INFO_OFFSET);
+	btrfs_csum_data(cfg->csum_type, (u8 *)&super + BTRFS_CSUM_SIZE,
+			super.csum, sizeof(super) - BTRFS_CSUM_SIZE);
+	ret = sbwrite(fd, &super, BTRFS_SUPER_INFO_OFFSET);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		ret = (ret < 0 ? -errno : -EIO);
 		goto out;
-- 
2.49.0


