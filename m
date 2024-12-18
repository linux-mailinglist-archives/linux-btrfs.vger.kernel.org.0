Return-Path: <linux-btrfs+bounces-10542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E255D9F6200
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C8E188C35B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FE19CD0B;
	Wed, 18 Dec 2024 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oTF9sAbx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oTF9sAbx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EB19CC11
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514938; cv=none; b=TY+KqYGDqN/X9mQmDXLW2bP+leZ1yskPvtmhfndYbQgTiXRlLxUK3thkHJfWB0GngAUffH+g26ZUYGZ2kEzJahbDMRF73zBwwJyDu7Uke6w8MSKvYjtSMNNasaL7i49uo7l5tL9W60nZufqYjxMqZa2OyEnRX9Hp0JdYjcDOjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514938; c=relaxed/simple;
	bh=Kt9u1UQTsFxDNrS4MRfc9WYvr475Hslrg8Ebpp+PGWs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2ewYeSOfDdP5rhlBn9ncIHiK21rae0BjDvb+6vvJ1OF/rcaYSMtn7hzG2UvXVp0PVI/w9/r/CxnuFPs9ezdvuYmh7WLE51NcvzsXvcO/IP7yhsT2gQDsbIq23Se01etjpeWolsEpVRIRMCkcDZRU4QvOgZ5fquzZYjPDi4T3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oTF9sAbx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oTF9sAbx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B94041F399
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NiJM9+OzFsvylLhXTGHi3PDa+huKiLOPSkMT1a68sE=;
	b=oTF9sAbxykwARUscJro+sYVFZY+kDaBRI8CVLy6Z3ix7NomainyjFqDUBBf3WebHfEaHa1
	WOt5goGUvVlbCjySgbigD3s4oXwk3GjZu0BzZ/hu0ckrL8p5S8iUepquO0U1HijL0R6rAu
	pyWWNVavChXQoPfK7zH+Zm/+0895s8I=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oTF9sAbx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NiJM9+OzFsvylLhXTGHi3PDa+huKiLOPSkMT1a68sE=;
	b=oTF9sAbxykwARUscJro+sYVFZY+kDaBRI8CVLy6Z3ix7NomainyjFqDUBBf3WebHfEaHa1
	WOt5goGUvVlbCjySgbigD3s4oXwk3GjZu0BzZ/hu0ckrL8p5S8iUepquO0U1HijL0R6rAu
	pyWWNVavChXQoPfK7zH+Zm/+0895s8I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5DD1132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SDJTKPWYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/18] btrfs: finish the rename of btrfs_fs_info::sectorsize
Date: Wed, 18 Dec 2024 20:11:32 +1030
Message-ID: <11e2dc8b9f5745bec215d5c0fc38e35b00d65a74.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B94041F399
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Now every user of btrfs_fs_info::sectorsize is migrated to use
btrfs_fs_info::blocksize, we can finish the rename by removing the
@sectorsize/@sectorsize_bits/@sectors_per_page aliases now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 9f8324ae3800..e2aafdc50498 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -797,15 +797,9 @@ struct btrfs_fs_info {
 
 	/* Cached block sizes */
 	u32 nodesize;
-	union {
-		u32 sectorsize;
-		u32 blocksize;
-	};
+	u32 blocksize;
 	/* ilog2 of blocksize, use to avoid 64bit division */
-	union {
-		u32 sectorsize_bits;
-		u32 blocksize_bits;
-	};
+	u32 blocksize_bits;
 	u32 csum_size;
 	u32 csums_per_leaf;
 	u32 stripesize;
-- 
2.47.1


