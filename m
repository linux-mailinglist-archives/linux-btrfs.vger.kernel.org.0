Return-Path: <linux-btrfs+bounces-14771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63EADE9FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56F9189D812
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1AF285056;
	Wed, 18 Jun 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="edh9HAkJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="edh9HAkJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B212BEC41
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246211; cv=none; b=RIv78bKeuzkrLwT40mOrpdzYZgfX8mz8OODMGSKuSA1K+4BRU9M0hj+OaV3cuSLAM/Xsp1TAKNlrvgR5KzGPXs1uuQbRVSZDZNgYtZGRzI093AKJUwDGUr/Z0MkYoKbLTBqhOW7CHiZMhG8WkXw3+B0dNsyXI+omww94+vKcsr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246211; c=relaxed/simple;
	bh=fZTTzNal36zz9qidO0OGOpea9D2Bo1lF4Dx+6S3CiO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXHKoQxksP/Td2Zr9PSljQwJi2Nbskbin9gsBKIqD6PkjvxuUjFQkCpdIKSK4IdCkYoFZzssgodWWxYVVwo7C0/EEGwfi702PwCf/5m/SBRhQQmI4ufEI2towu0wnjee7EbcCP/0dvXfjmmyEo4e7oi2Z7RXemo/p4DUNYcm5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=edh9HAkJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=edh9HAkJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F5C321223;
	Wed, 18 Jun 2025 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94GB0I8T1CCrQ+babod5vriq541veYSEnM5h+QqBTnk=;
	b=edh9HAkJJYTJzTlqZHSqpFTqa8m0yTOmqxGgSzpS66gmUAv4kKPdBjs2y72vlrEjwhrTyV
	Wq+gy91NJlwFj9KepgS8QC8VIPhOqndLZsgHZIdoTIUA1O24Q3oPOwFXKtdKKp6yqFkvfg
	Rc8I/YoVj/9a6c2MTPdU+C9FoOXlVqc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=edh9HAkJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94GB0I8T1CCrQ+babod5vriq541veYSEnM5h+QqBTnk=;
	b=edh9HAkJJYTJzTlqZHSqpFTqa8m0yTOmqxGgSzpS66gmUAv4kKPdBjs2y72vlrEjwhrTyV
	Wq+gy91NJlwFj9KepgS8QC8VIPhOqndLZsgHZIdoTIUA1O24Q3oPOwFXKtdKKp6yqFkvfg
	Rc8I/YoVj/9a6c2MTPdU+C9FoOXlVqc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8814A13A3F;
	Wed, 18 Jun 2025 11:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V6QzITujUmjLPwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Jun 2025 11:30:03 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: rename error to ret in btrfs_sysfs_add_mounted()
Date: Wed, 18 Jun 2025 13:29:30 +0200
Message-ID: <f525d3bf5fb5120b9703f7b446d9247029d78d44.1750246061.git.dsterba@suse.com>
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8F5C321223
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index db3495481fe684..6471fb53ca2af3 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -2324,71 +2324,70 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 
 int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 {
-	int error;
+	int ret;
 	struct btrfs_fs_devices *fs_devs = fs_info->fs_devices;
 	struct kobject *fsid_kobj = &fs_devs->fsid_kobj;
 
-	error = btrfs_sysfs_add_fs_devices(fs_devs);
-	if (error)
-		return error;
+	ret = btrfs_sysfs_add_fs_devices(fs_devs);
+	if (ret)
+		return ret;
 
-	error = sysfs_create_files(fsid_kobj, btrfs_attrs);
-	if (error) {
+	ret = sysfs_create_files(fsid_kobj, btrfs_attrs);
+	if (ret) {
 		btrfs_sysfs_remove_fs_devices(fs_devs);
-		return error;
+		return ret;
 	}
 
-	error = sysfs_create_group(fsid_kobj,
-				   &btrfs_feature_attr_group);
-	if (error)
+	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
+	if (ret)
 		goto failure;
 
 #ifdef CONFIG_BTRFS_DEBUG
 	fs_info->debug_kobj = kobject_create_and_add("debug", fsid_kobj);
 	if (!fs_info->debug_kobj) {
-		error = -ENOMEM;
+		ret = -ENOMEM;
 		goto failure;
 	}
 
-	error = sysfs_create_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
-	if (error)
+	ret = sysfs_create_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
+	if (ret)
 		goto failure;
 #endif
 
 	/* Discard directory */
 	fs_info->discard_kobj = kobject_create_and_add("discard", fsid_kobj);
 	if (!fs_info->discard_kobj) {
-		error = -ENOMEM;
+		ret = -ENOMEM;
 		goto failure;
 	}
 
-	error = sysfs_create_files(fs_info->discard_kobj, discard_attrs);
-	if (error)
+	ret = sysfs_create_files(fs_info->discard_kobj, discard_attrs);
+	if (ret)
 		goto failure;
 
-	error = addrm_unknown_feature_attrs(fs_info, true);
-	if (error)
+	ret = addrm_unknown_feature_attrs(fs_info, true);
+	if (ret)
 		goto failure;
 
-	error = sysfs_create_link(fsid_kobj, &fs_info->sb->s_bdi->dev->kobj, "bdi");
-	if (error)
+	ret = sysfs_create_link(fsid_kobj, &fs_info->sb->s_bdi->dev->kobj, "bdi");
+	if (ret)
 		goto failure;
 
 	fs_info->space_info_kobj = kobject_create_and_add("allocation",
 						  fsid_kobj);
 	if (!fs_info->space_info_kobj) {
-		error = -ENOMEM;
+		ret = -ENOMEM;
 		goto failure;
 	}
 
-	error = sysfs_create_files(fs_info->space_info_kobj, allocation_attrs);
-	if (error)
+	ret = sysfs_create_files(fs_info->space_info_kobj, allocation_attrs);
+	if (ret)
 		goto failure;
 
 	return 0;
 failure:
 	btrfs_sysfs_remove_mounted(fs_info);
-	return error;
+	return ret;
 }
 
 static ssize_t qgroup_enabled_show(struct kobject *qgroups_kobj,
-- 
2.49.0


