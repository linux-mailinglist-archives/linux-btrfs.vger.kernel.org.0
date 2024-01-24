Return-Path: <linux-btrfs+bounces-1755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB06983B3BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C0B2216B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ECD13540B;
	Wed, 24 Jan 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mj/grlCW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mj/grlCW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20321353E4
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131137; cv=none; b=p24D2AFc5FXpVUgdVtGNVTW/rtXfRK+JTtivQ4ShCYrL64uN6irVQFvR0kNBq4NbnmQn+HdW6N7slVCDTjHsK3EuvsY22qh18yoPuPIHQkGhJv8izyfs80Ox8GX0HtnKTRbcKiK7pyL8hi8x0hqLrSMbkmiK43rqqiOvZc/Q8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131137; c=relaxed/simple;
	bh=ZvfWhIugZ6X5oX8ORXGybDak3JYbTJMUgZeP9CNxBMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiIY6NhlrgdYpL975rxKRm5zcMHvT2zFQla6baNWx+k9evthtAVI7RSAacTzh5ejz7MPbLyH+y/Tn+age8K10VBwo014uQhluyF5gEqLOZLDZ38KWASzGu6NnXzx5IH9irfLsOXDg7QPgXq27nsrg/h7vdt8ZDAyTXC7yVAeqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mj/grlCW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mj/grlCW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47E6E1FD85;
	Wed, 24 Jan 2024 21:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPOah4YGx5RHov5nytQ1LH7B2l90VKkCPnlSDQcQobA=;
	b=Mj/grlCWl4DD5eOa7cfXodIQ/uGKqZcxrKhKqC2lhJYMYYpoSiNrcdvtu47mmRECqk+WLa
	y9IUpuJNW6Ap93kEJLZYP/NNBjKNuCvL307M5vNbbpT3yXGjV9kS4c3caid8IGK9lUJBCn
	F7oZq6BRvod0CMwiS3+GXzBxeQ5zNRg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPOah4YGx5RHov5nytQ1LH7B2l90VKkCPnlSDQcQobA=;
	b=Mj/grlCWl4DD5eOa7cfXodIQ/uGKqZcxrKhKqC2lhJYMYYpoSiNrcdvtu47mmRECqk+WLa
	y9IUpuJNW6Ap93kEJLZYP/NNBjKNuCvL307M5vNbbpT3yXGjV9kS4c3caid8IGK9lUJBCn
	F7oZq6BRvod0CMwiS3+GXzBxeQ5zNRg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41D3F13786;
	Wed, 24 Jan 2024 21:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QQEPEL5+sWXhdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:54 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 13/20] btrfs: change BUG_ON to assertion in btrfs_read_roots()
Date: Wed, 24 Jan 2024 22:18:32 +0100
Message-ID: <bab7832b49ed95eb091256633506f0fb21da4888.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[10.43%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

There's one caller of btrfs_read_roots() and that already uses the
tree_root pointer, it's pointless to BUG_ON on it. As it's an assumption
of the initialization helpers make it an assert instead.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3f7291a48a4d..1477748626ef 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2240,7 +2240,7 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	struct btrfs_key location;
 	int ret;
 
-	BUG_ON(!fs_info->tree_root);
+	ASSERT(fs_info->tree_root);
 
 	ret = load_global_roots(tree_root);
 	if (ret)
-- 
2.42.1


