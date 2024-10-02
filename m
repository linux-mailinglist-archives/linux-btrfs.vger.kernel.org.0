Return-Path: <linux-btrfs+bounces-8477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562EB98E54F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 23:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9EB287962
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67A21B449;
	Wed,  2 Oct 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UQGSRPpa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UQGSRPpa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081B21B444
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904592; cv=none; b=pyfey8BDDDbgN7N4Yv8rU8EqDagX+3rWYnIKFjukUJ8+8uu40/l4KBg4oOvahtqWjqW1Zj8/GcC5Bo1hiVLd5uoXZ4nTwnKe/LdHvIEmfCF5t1BWf8DmtKsGdUI3OGVeC2j4AMf7nSqMnWb8pqI2AM8ZJFyd5jfifB0hzrJojj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904592; c=relaxed/simple;
	bh=r2vfjPeZKruLsC60vIGHcu1eQ5cWX0/EdZY4u9aoZhg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xnwt827opk+dWaMylHOt6UCpM4imnyaVQN+JYa6nqkuWzdRSdEOLnN0mI5VXF9bFtKVL6+A9ZWp0TfkelZAyRZfRzgsKgBuEcZiuPJ4HyQj85DPCsP82+S/4FqtiF/9ucw78ERGYR6Os3BCwVAQQpTWb1UrzsvRrZW3xQ88vQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UQGSRPpa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UQGSRPpa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A0E821C81
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 21:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727904588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bwZ4Fo3pqtiQvovs36OodhAdBJ0ivwsY27/wLqo08CQ=;
	b=UQGSRPpaE/ghlL+zWrWJHJqpFEBJhupXCfdSq24yuNq8U3+6uMLX19epJCUFCYXYtHqCc8
	EcQ5HblqOydntd+JtOU15ue2X5gPxnOwQEUYDgVcpkUxPg/6onTGvth0vchF7eYZXNhmIm
	qAt8hzwkn29Cvt3YDuC6qBlNbRus90I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727904588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bwZ4Fo3pqtiQvovs36OodhAdBJ0ivwsY27/wLqo08CQ=;
	b=UQGSRPpaE/ghlL+zWrWJHJqpFEBJhupXCfdSq24yuNq8U3+6uMLX19epJCUFCYXYtHqCc8
	EcQ5HblqOydntd+JtOU15ue2X5gPxnOwQEUYDgVcpkUxPg/6onTGvth0vchF7eYZXNhmIm
	qAt8hzwkn29Cvt3YDuC6qBlNbRus90I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6608013A6E
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 21:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TJIjCku7/WbAKwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 21:29:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix the wrong rcu_str_deref() usage
Date: Thu,  3 Oct 2024 06:59:29 +0930
Message-ID: <a4a0faeba1d195f2eb71fcaae388f5976f822dc2.1727904561.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

For rcu_str_deref(), it should be called with rcu read lock hold.
But inside the function is_same_device(), the rcu string is accessed
without holding the rcu read lock, causing rcu warnings.

Fix it by holding the rcu read lock during the path resolution of the
existing device.

This will be folded into the offending patch "btrfs: avoid unnecessary
device path update for the same device"

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 35c4d151b5b0..3867d3c18be5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -807,8 +807,10 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
 	if (!device->name)
 		goto out;
 
+	rcu_read_lock();
 	old_path = rcu_str_deref(device->name);
 	ret = kern_path(old_path, LOOKUP_FOLLOW, &old);
+	rcu_read_unlock();
 	if (ret)
 		goto out;
 	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
-- 
2.46.2


