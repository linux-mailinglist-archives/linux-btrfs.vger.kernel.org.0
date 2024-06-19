Return-Path: <linux-btrfs+bounces-5826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92B90F4D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 19:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD14D281FF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555B615573F;
	Wed, 19 Jun 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iaZwpV+c";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iaZwpV+c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931951C3E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816959; cv=none; b=pT33s6a+3wTQI4Qbfh6rqAlfLNxY/915y5dQTk26CmbNiQuoNWT6MqyQDKdlSCwRRIy3LP3njQnC5pPWGm4yRr7d4jhkK9GV5XggZemSOlvwt0KBMkGV9jldrPz2cgRjDkXgLuXX2qHHGlukxwb2VRttQOvNum4ZiHkN5cfkpw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816959; c=relaxed/simple;
	bh=p6bnLSkroMIWL78MVN0Wnai/Rfu9VC+wbFEGw55Ieg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMMpno1UzoMbpurhR26JwhgOtGf249osUxgM9fxruchRsUR3kfO3gwu88G4lr4Kr+RLFThrd8p10A2gzxVhuicGE+Vyy1Ecji9poHxEbiwHMTmI3NZXemZpuQHeCeJuegECg/ts6BZzkppZ30Lp94DkF2JCBIqxjlR7ow9d7tWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iaZwpV+c; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iaZwpV+c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5CD81F7C7;
	Wed, 19 Jun 2024 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718816955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOL4Dwhc+ckbqKs5XpzCYkBSzLrHAK+CFL/arMaZHOU=;
	b=iaZwpV+cIDJHz/6o9AwNmKOppkNBAM+4a5Wne4Uf4iWqeFvzShQ1rQAQDP9yQu6mPF1G+L
	BvcQq6EVDE4JJBSYVsQTkuL6xPlcd4v3OgaNNo5aappsugX5pc3JjDIJlqn4H7FOr7J+5G
	e2ffrkvDcer0exE9ZAJwUR+LVmtsxYY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718816955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOL4Dwhc+ckbqKs5XpzCYkBSzLrHAK+CFL/arMaZHOU=;
	b=iaZwpV+cIDJHz/6o9AwNmKOppkNBAM+4a5Wne4Uf4iWqeFvzShQ1rQAQDP9yQu6mPF1G+L
	BvcQq6EVDE4JJBSYVsQTkuL6xPlcd4v3OgaNNo5aappsugX5pc3JjDIJlqn4H7FOr7J+5G
	e2ffrkvDcer0exE9ZAJwUR+LVmtsxYY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF9A213668;
	Wed, 19 Jun 2024 17:09:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9b7ELrsQc2aIQwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 19 Jun 2024 17:09:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: abort transaction on errors in btrfs_free_chunk()
Date: Wed, 19 Jun 2024 19:09:11 +0200
Message-ID: <72fac19a7ad1c8fe469a05a721c6bf1b55130c19.1718816796.git.dsterba@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
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

The errors during removing a chunk item are fatal, we expect to have a
matching item in the chunk map from which the chunk_offset is taken.
Handle that by transaction abort.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ac6056072ee8..fcedc43ef291 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2989,16 +2989,19 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	if (ret < 0)
 		goto out;
 	else if (ret > 0) { /* Logic error or corruption */
-		btrfs_handle_fs_error(fs_info, -ENOENT,
-				      "Failed lookup while freeing chunk.");
-		ret = -ENOENT;
+		btrfs_err(fs_info, "failed to lookup chunk %llu when freeing",
+			  chunk_offset);
+		btrfs_abort_transaction(trans, -ENOENT);
+		ret = -EUCLEAN;
 		goto out;
 	}
 
 	ret = btrfs_del_item(trans, root, path);
-	if (ret < 0)
-		btrfs_handle_fs_error(fs_info, ret,
-				      "Failed to delete chunk item.");
+	if (ret < 0) {
+		btrfs_err(fs_info, "failed to delete chunk %llu item", chunk_offset);
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
 out:
 	btrfs_free_path(path);
 	return ret;
-- 
2.45.0


