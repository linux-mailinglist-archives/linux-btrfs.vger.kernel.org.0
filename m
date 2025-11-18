Return-Path: <linux-btrfs+bounces-19104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA82C6A837
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 803DA28E52
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2436CE0D;
	Tue, 18 Nov 2025 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ra6lQnWY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ra6lQnWY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DD35BDBF
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482143; cv=none; b=ow3V4j/7Qi1E2d3jB/2SBrDEH1JjnU/m92tSlPdicYt8QzdZ/O3t3ZGavmFP3pGT6hJGrNNfivFRabMHmyeGnUN6pv5IGJ0pEMVXINodfJMLRVHu1FYoZcaNMdOEu6fEoc4ucVDBSdynqedx+EELsCkQsiqHQ4n2HC220tBm/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482143; c=relaxed/simple;
	bh=lYbAgki+AHw1EkZ3Vrf/4jsw/2G6zfphnrCQRXzU8qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j63VzpzWmRzlmxI3P1oGZppwe0cEbGOJmAcAWVy8nyY2b2JPt6pCHlszXn0LK73n8qmhL2teX0oY6AKTNK4s6lK+bjEXL8lTCQuyXJ+OQn28b7nb/T34ZIIS8+2h85MA57YBOXCysDEEF2pogvX2Di+GN7MoVrKYN+ZS0Uae5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ra6lQnWY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ra6lQnWY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 384771FF8A;
	Tue, 18 Nov 2025 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMdqlW5MqclqolugCJ1CKZKHU2hFqToPTNe/MUSR8Wg=;
	b=Ra6lQnWYB8oPs2JrgEyEDIajBJJAOHg5wPowSkk1hYzdeRWeuYSfYUqOkyXuWYbZSW40M4
	my1Hpc5XJwlAYlvILx3WW8QNeZIW3nQY/R/JmtE8s/w+jH2L2nRo1WjVpdGNDTXFN7+aCL
	y1VDx3IgrpQK0ySQifpAev8fC5cmpJU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMdqlW5MqclqolugCJ1CKZKHU2hFqToPTNe/MUSR8Wg=;
	b=Ra6lQnWYB8oPs2JrgEyEDIajBJJAOHg5wPowSkk1hYzdeRWeuYSfYUqOkyXuWYbZSW40M4
	my1Hpc5XJwlAYlvILx3WW8QNeZIW3nQY/R/JmtE8s/w+jH2L2nRo1WjVpdGNDTXFN7+aCL
	y1VDx3IgrpQK0ySQifpAev8fC5cmpJU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E1E53EA61;
	Tue, 18 Nov 2025 16:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WCfUBhWaHGlnYQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 18 Nov 2025 16:08:53 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v7 2/6] btrfs: disable verity on encrypted inodes
Date: Tue, 18 Nov 2025 17:08:39 +0100
Message-ID: <20251118160845.3006733-3-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118160845.3006733-1-neelx@suse.com>
References: <20251118160845.3006733-1-neelx@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Right now there isn't a way to encrypt things that aren't either
filenames in directories or data on blocks on disk with extent
encryption, so for now, disable verity usage with encryption on btrfs.

fscrypt with fsverity should be possible and it can be implemented
in the future.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/verity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 16f5580cba55..06dfcb461f53 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -578,6 +578,9 @@ static int btrfs_begin_enable_verity(struct file *filp)
 
 	btrfs_assert_inode_locked(inode);
 
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return -EOPNOTSUPP;
+
 	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
 		return -EBUSY;
 
-- 
2.51.0


