Return-Path: <linux-btrfs+bounces-10831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00430A07325
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F583A8DCF
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32843216E2B;
	Thu,  9 Jan 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kMNGIgxy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z3ckXkL6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E90216395
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418284; cv=none; b=uKiG0HoDMNEbQYtHCmLasiFVC8p7Qx01rqfzDL+In2E9qLNU9sKg6G37wA43dohEaF8M7OybhJUTm9FfeX7NElwdOQr74XvkS9ybKzf3SwLhuZkLO+5lf2wINpOTYXFmZgAXKMeYRX0Sh6NYlyqWfL02ZEp20yhMW/fNLQWXpPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418284; c=relaxed/simple;
	bh=I2d0sxBsw6+RvAh2D4i9Npg9KXC7fO0ST+OXWG0GCXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLo9VVZX+RM75gBhf1/XxU9ghV04TNENYRyO1Apexf/0sl2wWjpZK2pXrEcEjrQOr+SO1Ffb+l+kFaaXHpNhDFg90AKfORfT/mtf/n1RODfRjTRqnOOjEF2DLT/55iZKcY5a2c0magevYmUw7q/ZSaozZY+BgNPwMHMHKJars7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kMNGIgxy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z3ckXkL6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E91DB1F385;
	Thu,  9 Jan 2025 10:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bg8EcMlrMqg+yIeIGMmuJk8odOzJKW30r9NQAvuOihs=;
	b=kMNGIgxyhnHTXaSNNs3feO4GU5odfkp8priOsXx7I+XjI0kQQgcxDxaxJH8b7zZ21sZD+V
	QBF9uv9Ly0KTxkkPbSnfRXRpz+Y6I/L8SVnhrZ5oF3J0mokk1/iGn4WwAD3jrKgXoLgvsi
	JCllAj80hbnEANEEUQn1ia8BO36mBDU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Z3ckXkL6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bg8EcMlrMqg+yIeIGMmuJk8odOzJKW30r9NQAvuOihs=;
	b=Z3ckXkL6G2aDFQuLz21PRl0IGL/Wa1jLu+ConCjNxV7MQ4v2JSEPp/p+gpVtntChIlZYaK
	uPBtkHNDeTIy920kX3Clv7gSPxfutTOF2u3QGGd2nya7+aZHBIIa4AVut0vOQm7II2+SwT
	IFZ0p0IcXSTXKDFvL6qACQ6HIxn6Mko=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D56139AB;
	Thu,  9 Jan 2025 10:24:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zO8gN+ijf2doEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:40 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 15/18] btrfs: remove unused define WAIT_PAGE_LOCK for extent io
Date: Thu,  9 Jan 2025 11:24:40 +0100
Message-ID: <392fdf4c9d4c0bbe6d95688f5e904b0630bf93cc.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E91DB1F385
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Last use was in the readahead code that got removed by f26c9238602856
("btrfs: remove reada infrastructure").

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 986f15022fef..ca09fc31e2de 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -263,7 +263,6 @@ void free_extent_buffer(struct extent_buffer *eb);
 void free_extent_buffer_stale(struct extent_buffer *eb);
 #define WAIT_NONE	0
 #define WAIT_COMPLETE	1
-#define WAIT_PAGE_LOCK	2
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 			     const struct btrfs_tree_parent_check *parent_check);
 static inline void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
-- 
2.47.1


