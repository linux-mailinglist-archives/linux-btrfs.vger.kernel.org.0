Return-Path: <linux-btrfs+bounces-20344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28173D0B93C
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 18:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67AFB3024A53
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E935B132;
	Fri,  9 Jan 2026 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IIBOH6As";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IIBOH6As"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96F200110
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979075; cv=none; b=fXzOEVCXnZf9ApyiWM7qYFhOxVJ5H4SrT8+Z3QHlp3j+o4mKTNcB1+k01QLbJzKm4WVa2vhZAaElEE6PSgPOGjsvmM8XlNkJkA4Lf/BnI8LKDk8WYtpbRgs69Xj8FVTSYGjsPoYLBfJz2Tuui6VvOHc0xZTz9/si0KTwxGK1NSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979075; c=relaxed/simple;
	bh=hqmHr1joFgDfCS7U/HVfTDYa2OMvV34mjHzhIEpyev4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOd2SelXHqxbXavMeDBnkOuMBadYmDYcnBAlMVM8goLhkhU8hL6KgSjE9y4aLRabFG25LdUwVqDxAOMMaPjBO8sjBBovAj0uG4Jml6BdwWyajnrKJ9iZTOa7EYkBlEUpnw7oUvd1rXhmTTkakT7Echu7RAUa4mKK3ZgXZUYE6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IIBOH6As; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IIBOH6As; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F9BB5BFA7;
	Fri,  9 Jan 2026 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8jzt0Y6O366ZmdWp5DgBIPChnvu6UUkeJfunHMwsrc=;
	b=IIBOH6AsTAHXESCouKSCGs14hDvvCnMjJZZFgWmaPNeJBiTfmAzmoE/J9o+CpvPrFqAk0y
	Wms/rSQr4PuupTEyb5m/Z9IcvcZl57A7pjk6RkF6MIJDFKwl7EDx3hUpmwgT2ZBuFUXUbg
	4a1k4/rKKQXv9x7XSo+Wmj40p6hPUmY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IIBOH6As
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8jzt0Y6O366ZmdWp5DgBIPChnvu6UUkeJfunHMwsrc=;
	b=IIBOH6AsTAHXESCouKSCGs14hDvvCnMjJZZFgWmaPNeJBiTfmAzmoE/J9o+CpvPrFqAk0y
	Wms/rSQr4PuupTEyb5m/Z9IcvcZl57A7pjk6RkF6MIJDFKwl7EDx3hUpmwgT2ZBuFUXUbg
	4a1k4/rKKQXv9x7XSo+Wmj40p6hPUmY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5948F3EA63;
	Fri,  9 Jan 2026 17:17:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GzfKFUA4YWkiVAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 09 Jan 2026 17:17:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: reorder members in btrfs_delayed_root for better packing
Date: Fri,  9 Jan 2026 18:17:41 +0100
Message-ID: <4ffb0817d978715cb34cef429c797f211a993551.1767979013.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767979013.git.dsterba@suse.com>
References: <cover.1767979013.git.dsterba@suse.com>
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
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 5F9BB5BFA7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

There are two unnecessary 4B holes in btrfs_delayed_root;

struct btrfs_delayed_root {
        spinlock_t                 lock;                 /*     0     4 */

        /* XXX 4 bytes hole, try to pack */

        struct list_head           node_list;            /*     8    16 */
        struct list_head           prepare_list;         /*    24    16 */
        atomic_t                   items;                /*    40     4 */
        atomic_t                   items_seq;            /*    44     4 */
        int                        nodes;                /*    48     4 */

        /* XXX 4 bytes hole, try to pack */

        wait_queue_head_t          wait;                 /*    56    24 */

        /* size: 80, cachelines: 2, members: 7 */
        /* sum members: 72, holes: 2, sum holes: 8 */
        /* last cacheline: 16 bytes */
};

Reordering 'nodes' after 'lock' reduces size by 8B, to 72 on release
config.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index dd4944f9a98553..4d721fbd390c55 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -456,6 +456,7 @@ struct btrfs_commit_stats {
 
 struct btrfs_delayed_root {
 	spinlock_t lock;
+	int nodes;		/* for delayed nodes */
 	struct list_head node_list;
 	/*
 	 * Used for delayed nodes which is waiting to be dealt with by the
@@ -465,7 +466,6 @@ struct btrfs_delayed_root {
 	struct list_head prepare_list;
 	atomic_t items;		/* for delayed items */
 	atomic_t items_seq;	/* for delayed items */
-	int nodes;		/* for delayed nodes */
 	wait_queue_head_t wait;
 };
 
-- 
2.51.1


