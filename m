Return-Path: <linux-btrfs+bounces-14772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755BFADE9FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C980B179557
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529901A4E9D;
	Wed, 18 Jun 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qqjy4AZb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DWtH1Qm5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1832BEC32
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246213; cv=none; b=HIraJWPwcIdSOU2uHVXT2ad4hGrvm6Om0d8tVw9WZhyW1dOQosIu4bqY30+N/peCBjI/yNClmi+RyLgFpCzg9qyDZ3XaHNfjZSXNO88CD+aauqDHPNlEX6FV1xJ5iwGGbLvVeWfaraOhCJ4jPTh5b5C0YgtB36D94ZGj7FNaZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246213; c=relaxed/simple;
	bh=1fzHCDjqLcl/tdU5UbPAuUsiI5cKA6+6VyZuPFNH4hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8Jum4tNc+iBao9WNQ7xIzBSpfG7mm/zyUIpHrQ8cQftwS2YZpnWliUTJpwvQc1BEvQSFgunDAczs+gZYunJbNM94XdDPdfXjbDHVnmZA+/SXlGy0i7E2HaAPaaVEu3ssRa4+K8d354TumqpGZrLLNspJDfPA7BubnbY9M3xips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qqjy4AZb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DWtH1Qm5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E94F41F7C3;
	Wed, 18 Jun 2025 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zM2w49SCFLmxwzvWrCHqbNWpsQOqh3XlcqdvT2joeK0=;
	b=qqjy4AZbhAcANG84I2ApMg/lO9g59HkNuFJcm373SmRZLqSa/jcnQJOWSNLVPmdebiI0Yk
	7lONAwNCm4KH8pPujj9xyWRQ7oHjNmn0t3qZgFHDvC0c7w+BlJjTH1lOvwSG8ezXtBctQp
	pCc3aewftvsP9S4TzFA/8N1VJIxG7fI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DWtH1Qm5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zM2w49SCFLmxwzvWrCHqbNWpsQOqh3XlcqdvT2joeK0=;
	b=DWtH1Qm57h3AhAUZ8XjcJLaimkQpFSK7OyywMfs2U9Bx9l6pXxu6lfmZFvYZAwOj+Tzbvt
	dz3aTNdYQI7Y09TwGrp3tWudl4je7wM9lEmE2PrV+5ChaW91LesiMK6opoE15GphVaLmOE
	sXblayC5t+/9399eY4Wto9O2qiYK+Qo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D86BF13A3F;
	Wed, 18 Jun 2025 11:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DXvUNEGjUmjfPwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Jun 2025 11:30:09 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: rename error to ret in device_list_add()
Date: Wed, 18 Jun 2025 13:29:31 +0200
Message-ID: <afe8134601493f516ae19725d00251133153be3f.1750246061.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750246061.git.dsterba@suse.com>
References: <cover.1750246061.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E94F41F7C3
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Score: -3.01
X-Spam-Level: 

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 134b7754347ef3..8c598a04b4a3f0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -787,7 +787,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	u64 found_transid = btrfs_super_generation(disk_super);
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
 	dev_t path_devt;
-	int error;
+	int ret;
 	bool same_fsid_diff_dev = false;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
@@ -799,11 +799,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		return ERR_PTR(-EAGAIN);
 	}
 
-	error = lookup_bdev(path, &path_devt);
-	if (error) {
+	ret = lookup_bdev(path, &path_devt);
+	if (ret) {
 		btrfs_err(NULL, "failed to lookup block device for path %s: %d",
-			  path, error);
-		return ERR_PTR(error);
+			  path, ret);
+		return ERR_PTR(ret);
 	}
 
 	fs_devices = find_fsid_by_device(disk_super, path_devt, &same_fsid_diff_dev);
-- 
2.49.0


