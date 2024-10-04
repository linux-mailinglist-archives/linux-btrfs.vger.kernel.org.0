Return-Path: <linux-btrfs+bounces-8551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2529900DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 12:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8461C21034
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 10:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F1E14BF92;
	Fri,  4 Oct 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JHhr6vae";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JHhr6vae"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58714B946
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037347; cv=none; b=tP7Ow2U20n1ClcYTh552L3YQZCmlyn0naO4vdQfoQOL00x0S5kklA2mXSLi8JKEfej7QEjdEb0q6umHHlcHzQEl8xCvsZstxwOjeh/vQgbTt5175SyXbDLonHFRuvfkupEeBd1IG2nouexMpkrBkEcS6La8YcJF08YrK8dZxUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037347; c=relaxed/simple;
	bh=pBE0LF5Ru6MnAonhHyOS2TDfnfstcX8w9i391QnLKdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IO3GqQGRwbmj9dYKIaAuYZkFk12PQ5l08gNAe09e/RR8sWMfHcwYyCa4A7suSozwOaykuKibmoKjSc8RTs17diDXERIQ1AyKHdf/M3Yw5S7lJtbsV7QYpW1A+qgg/3SEWkHCC41rIGoqBMzu/i97W3RAfIRJRG6brpIcEzhHGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JHhr6vae; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JHhr6vae; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 672FF1FF13;
	Fri,  4 Oct 2024 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728037343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5QgXrwV3/mZV/ItqX1sDcWfeApnH9zPICd6kutSY07I=;
	b=JHhr6vaeKEk1F2eliKgPwaw8mYUDU4PuhOjVybUKUaZXt3Wzx59oPpzcPOLek7BrjikVU7
	0hjZf6KhWf2s+n+Mkd/Z69wwgfYCflYHYveVu60H7SwGhWR0lcdz+LM1JRBAeIpDWlkqc9
	m+hn5gSoIVZn2Vr6Vyny5iYYfETwctU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JHhr6vae
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728037343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5QgXrwV3/mZV/ItqX1sDcWfeApnH9zPICd6kutSY07I=;
	b=JHhr6vaeKEk1F2eliKgPwaw8mYUDU4PuhOjVybUKUaZXt3Wzx59oPpzcPOLek7BrjikVU7
	0hjZf6KhWf2s+n+Mkd/Z69wwgfYCflYHYveVu60H7SwGhWR0lcdz+LM1JRBAeIpDWlkqc9
	m+hn5gSoIVZn2Vr6Vyny5iYYfETwctU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6100313A6E;
	Fri,  4 Oct 2024 10:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hyq9CN7B/2bHGwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 04 Oct 2024 10:22:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCH] btrfs: fix the sleep inside RCU lock bug of is_same_device()
Date: Fri,  4 Oct 2024 19:52:00 +0930
Message-ID: <0acb0e85c483ea5ee6d761583fcaa6efa3e92f01.1728037316.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 672FF1FF13
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Previous fix of the RCU lock is causing another bug, that kern_path()
can sleep and cause the sleep inside RCU bug.

This time fix the bug by pre-allocating a string buffer, and copy the
rcu string into that buffer to solve the problem.

Unfortunately this means every time a device scan will trigger a page
allocation and free.

This will be folded into the offending patch "btrfs: avoid unnecessary
device path update for the same device" again.

Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 93704e11e611..5f5748ab6f9d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -800,17 +800,24 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
 {
 	struct path old = { .mnt = NULL, .dentry = NULL };
 	struct path new = { .mnt = NULL, .dentry = NULL };
-	char *old_path;
+	char *old_path = NULL;
 	bool is_same = false;
 	int ret;
 
 	if (!device->name)
 		goto out;
 
+	old_path = kzalloc(PATH_MAX, GFP_NOFS);
+	if (!old_path)
+		goto out;
+
 	rcu_read_lock();
-	old_path = rcu_str_deref(device->name);
-	ret = kern_path(old_path, LOOKUP_FOLLOW, &old);
+	ret = strscpy(old_path, rcu_str_deref(device->name), PATH_MAX);
 	rcu_read_unlock();
+	if (ret < 0)
+		goto out;
+
+	ret = kern_path(old_path, LOOKUP_FOLLOW, &old);
 	if (ret)
 		goto out;
 	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
@@ -819,6 +826,7 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
 	if (path_equal(&old, &new))
 		is_same = true;
 out:
+	kfree(old_path);
 	path_put(&old);
 	path_put(&new);
 	return is_same;
-- 
2.46.2


