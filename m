Return-Path: <linux-btrfs+bounces-14770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855AADE9F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050533AF24F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191D2BE7D1;
	Wed, 18 Jun 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HR24goa3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HR24goa3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BE2BF01B
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246204; cv=none; b=kzDgALH9tGjMxHx0e+tpkRbhZ0izA5QrMlLVm8KBRAYxPXa+BzZ/tV04WOMQUaCFHUMt2bxxVdZPHdMmVyEA/WZnwCvXHw7XxhcaiH1c7uYbqqXH/UL4HIY4wBd6pe0UbMLRmQUi7Sqp4IaZvzoBaOL12RkGWGrsvdLDnh4SRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246204; c=relaxed/simple;
	bh=VJJz5FBcbXCLWt6u+44+UAQWrckqY4sa78oVeh48kRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqsH7Um4KsFY2WSpgwrWbL5iHEWtouOlwmaxx1v1KjvhrGnGbwzOuOFguv8KpPDP+S2Ytr67IEHB4S0eQnYcOSycEEc/9Ufxvd9QXIBZmc0vvF0gSiJWjj1ujyacFBaeJMBzJE7YEFdQUtNMIxtGmhB88SaTMQSRsLqCCRUF15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HR24goa3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HR24goa3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5620B21222;
	Wed, 18 Jun 2025 11:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Uw8tRbed/NW1L4TDuqaFr3tqZtM/Fj/sHEcEkX9qw4=;
	b=HR24goa3WLQtvqiwdY2dpoRNIwRhG6Ay6kUcjqfJ8en/GXdKbBXHKL6EvHJ/W/MAEWy5Xn
	UGDtebbxTm+O3KHcXrhYZPHpAMqHZUBzMc9R8WyV7rwfo4RFFhZ4YtmSvo9ON7G0Bh/IRw
	CtLzrqClMhQm4c3N5NelUNTJUz1aYxg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Uw8tRbed/NW1L4TDuqaFr3tqZtM/Fj/sHEcEkX9qw4=;
	b=HR24goa3WLQtvqiwdY2dpoRNIwRhG6Ay6kUcjqfJ8en/GXdKbBXHKL6EvHJ/W/MAEWy5Xn
	UGDtebbxTm+O3KHcXrhYZPHpAMqHZUBzMc9R8WyV7rwfo4RFFhZ4YtmSvo9ON7G0Bh/IRw
	CtLzrqClMhQm4c3N5NelUNTJUz1aYxg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FBFA13A3F;
	Wed, 18 Jun 2025 11:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xbp1EzWjUmisPwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Jun 2025 11:29:57 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: rename error to ret in btrfs_sysfs_add_fsid()
Date: Wed, 18 Jun 2025 13:29:29 +0200
Message-ID: <1a9d9a6c6ee763a29fd9ec7fa3317233d344eb63.1750246061.git.dsterba@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Level: 

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b860470cffc4c8..db3495481fe684 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -2290,15 +2290,15 @@ static struct kset *btrfs_kset;
  */
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 {
-	int error;
+	int ret;
 
 	init_completion(&fs_devs->kobj_unregister);
 	fs_devs->fsid_kobj.kset = btrfs_kset;
-	error = kobject_init_and_add(&fs_devs->fsid_kobj, &btrfs_ktype, NULL,
-				     "%pU", fs_devs->fsid);
-	if (error) {
+	ret = kobject_init_and_add(&fs_devs->fsid_kobj, &btrfs_ktype, NULL,
+				   "%pU", fs_devs->fsid);
+	if (ret) {
 		kobject_put(&fs_devs->fsid_kobj);
-		return error;
+		return ret;
 	}
 
 	fs_devs->devices_kobj = kobject_create_and_add("devices",
-- 
2.49.0


