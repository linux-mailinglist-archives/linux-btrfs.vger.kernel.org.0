Return-Path: <linux-btrfs+bounces-7624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124D962C9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 17:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714461C21901
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABA1A38D6;
	Wed, 28 Aug 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dXMPw05Q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dXMPw05Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5D18DF8A
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859688; cv=none; b=ezQGsXYGAit5S5hjmXQjhxeq6nDylRbaknHYyNbOXqm2miIIiVTLkvThfeWZOTWFfXlk5wePqXth9YAARJ3hqqileG1bC3R052ILDt7/gYdHAr2AVCQHE4MNty2L9W2JIeJ7JvoXW8IkLCsawEUvCYzpCMxAF5BF8z1A50BIoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859688; c=relaxed/simple;
	bh=eH/27DLwJ/4OWwH0uQU1lGqzVF7zMCxZlf5EsX9m0sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfiGG+Y6TNyItDHo6r1da5NAwQbh4kfttvisDE1K+NvkFJhKovHOTiRhmZEQSSJ4+1U3PFBoBzD2v06xfdzeH5OMvgT2nvvjaPrGd070jSCssBVlMvUJs0z8NGgrmbp6vplFWjOkTcLXMkddTsGoFtQC3vz7EdQiI5GkcPQAlhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dXMPw05Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dXMPw05Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64E9E1FC86;
	Wed, 28 Aug 2024 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724859684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5exMKRrBoG+JRLEIaQ7fVo8MoKgFcRR48vtH6giU3Q=;
	b=dXMPw05QPq+iosYk2hvukreVbcJf52M7FC4aR0VGiFlEOY23J1OTIoFb4oemqv+5BRYEs6
	0IN8jEA19ajM3beLOQnG76S5UkOjaY3Yum3GLHoT1CBcSXJsuEklupURTEa4jcTfEftjca
	IzE9fAm/do47ZoSnTwfO8w5GU4suTmU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dXMPw05Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724859684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5exMKRrBoG+JRLEIaQ7fVo8MoKgFcRR48vtH6giU3Q=;
	b=dXMPw05QPq+iosYk2hvukreVbcJf52M7FC4aR0VGiFlEOY23J1OTIoFb4oemqv+5BRYEs6
	0IN8jEA19ajM3beLOQnG76S5UkOjaY3Yum3GLHoT1CBcSXJsuEklupURTEa4jcTfEftjca
	IzE9fAm/do47ZoSnTwfO8w5GU4suTmU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CD36138D2;
	Wed, 28 Aug 2024 15:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RjCpFiRFz2b/VAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 28 Aug 2024 15:41:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: rework BTRFS_I as macro to preserve parameter const
Date: Wed, 28 Aug 2024 17:41:24 +0200
Message-ID: <83d26045fb27f8f44a21eb9e11e26daa7da3a0bc.1724859620.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724859619.git.dsterba@suse.com>
References: <cover.1724859619.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64E9E1FC86
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

Currently BTRFS_I is a static inline function that takes a const inode
and returns btrfs inode, dropping the 'const' qualifier. This can break
assumptions of compiler though it seems there's no real case.

To make the parameter and return type consistent regardint const we can
use the container_of_const() that preserves it. However this would not
check the parameter type. To fix that use the same _Generic construct
but implement only the two expected types.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 2d7f8da54d8a..f2df8486419c 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -350,10 +350,12 @@ static inline void btrfs_set_first_dir_index_to_log(struct btrfs_inode *inode,
 	WRITE_ONCE(inode->first_dir_index_to_log, index);
 }
 
-static inline struct btrfs_inode *BTRFS_I(const struct inode *inode)
-{
-	return container_of(inode, struct btrfs_inode, vfs_inode);
-}
+/* Type checked and const-preserving VFS inode -> btrfs inode. */
+#define BTRFS_I(_inode)								\
+	_Generic(_inode,							\
+		 struct inode *: container_of(_inode, struct btrfs_inode, vfs_inode),	\
+		 const struct inode *: (const struct btrfs_inode *)container_of(	\
+					_inode, const struct btrfs_inode, vfs_inode))
 
 static inline unsigned long btrfs_inode_hash(u64 objectid,
 					     const struct btrfs_root *root)
-- 
2.45.0


