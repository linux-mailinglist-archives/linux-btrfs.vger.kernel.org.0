Return-Path: <linux-btrfs+bounces-19280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C8C7EF01
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 05:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 473734E0EE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 04:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736A2BCF6C;
	Mon, 24 Nov 2025 04:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mfCbWI6k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mfCbWI6k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CD1B4257
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763957762; cv=none; b=Uvzn7umu7t+RDXerz/+MPbtu5lPNJpLIa+KigBlEOXVTPQ+Kp0qIz03b2z0MuZheWfhfMeaxQ6bwT5VogNprs91EIpIdYWgdU92CleAJUSNsu//K2+aJrGf2Rx19zfmSnIoPnwM5NWupUtj6c2FiMElionZP5ikYmbHlXVJn778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763957762; c=relaxed/simple;
	bh=DLBXbR8A1kLaVEijdqj4oFNh2bul+gHU7BAW6I4UnY0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ5a4j2mxT7z18Em9eEcqAbO5KoMB2Z//htr4I6BL3REpRYndATP3yAf43Pk9AXa20V9A7yarM0qQ8yanCd/XSjOWk6iOEvzvkyERrCwHbkYdDLFE4rohYutEs12hH6RjDa3L3uAQ6Y7qAKGjGhEdc564DmS/TfhLngzo4f/OnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mfCbWI6k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mfCbWI6k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E9C95BD02
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763957751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aseOHUYJFqOAU9uBZ3uaBajaROfjM1vzN++yvxD4lVo=;
	b=mfCbWI6k5hTLlVVxVuBFhc1mgmXiiOC0ejwE9rIN7Se5NRrDUD+gRG++mdEWHN7roCRvjc
	/nMRF6xrLdZEnPN9jcRUFZazn868AYyIKf3iuXaja2/f8aCRZfeSbCOEsd+FaZMFXpwaOa
	yEmy46MF4qArFsLYd8Kzs2BHx20lS3Y=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763957751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aseOHUYJFqOAU9uBZ3uaBajaROfjM1vzN++yvxD4lVo=;
	b=mfCbWI6k5hTLlVVxVuBFhc1mgmXiiOC0ejwE9rIN7Se5NRrDUD+gRG++mdEWHN7roCRvjc
	/nMRF6xrLdZEnPN9jcRUFZazn868AYyIKf3iuXaja2/f8aCRZfeSbCOEsd+FaZMFXpwaOa
	yEmy46MF4qArFsLYd8Kzs2BHx20lS3Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68E883EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ELWCvbbI2kDRwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: do not dump leaf if the path is released inside __free_extent()
Date: Mon, 24 Nov 2025 14:45:26 +1030
Message-ID: <66d372db6d5a771edccf925a0fd88345ff1ba1cc.1763957608.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763957608.git.wqu@suse.com>
References: <cover.1763957608.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[BUG]
There is a bug report that btrfs-convert crashed during converting an
ext4 image which is almost full.

[CAUSE]
Just before the crash, btrfs-convert is committing the current
transaction but failed to locate the backref inside __free_extent().

Then it went through the error handling path, which prints an error
message and try to dump the leaf.

But in this particular case, the error code is not -ENOENT, thus the
path is already released, resuling path->nodes[0] to be NULL, and
btrfs_print_leaf() triggers a NULL pointer dereference.

[FIX]
The kernel version of btrfs_free_extent() is only dumping the tree for
-ENOENT error code. And patch "btrfs: refactor the error handling of
__btrfs_free_extent()" is submitted to make abort_and_dump() to only
dump the leaf if the path is not released.

So follow the same kernel patch, by only dumping the leaf if the path is
not released.

Issue: #1064
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 5800320f7bc5..9d0155502d5e 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2058,8 +2058,10 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 		       (unsigned long long)root_objectid,
 		       (unsigned long long)owner_objectid,
 		       (unsigned long long)owner_offset);
-		printf("path->slots[0]: %d path->nodes[0]:\n", path->slots[0]);
-		btrfs_print_leaf(path->nodes[0]);
+		if (path->nodes[0]) {
+			printf("path->slots[0]: %d path->nodes[0]:\n", path->slots[0]);
+			btrfs_print_leaf(path->nodes[0]);
+		}
 		ret = -EIO;
 		goto fail;
 	}
-- 
2.52.0


