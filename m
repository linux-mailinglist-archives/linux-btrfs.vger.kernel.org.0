Return-Path: <linux-btrfs+bounces-2051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A360984652E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 02:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DC21C23BB9
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 00:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656D748E;
	Fri,  2 Feb 2024 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LFnVTY/l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LFnVTY/l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0853A1
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835585; cv=none; b=qTJW6VLi5wCn2FRhbC6s60eMfBjPzBzwFM5jM/vkUdTPSzFCHWQ/h5Db5t/QunbaNkXqYOID5gAT0YLFifKGqYp66ERafXAX34Cit4ZeOqdb1+h8iGTixuyKWW1GcPH1WF2yBVTOeQRZQYltYhb/T6ktga/H7L6xmVeRsYdCVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835585; c=relaxed/simple;
	bh=eLVVPXk0CELlOvRijhT3B8lfMfION57EEuwKNZArT2Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SA+uoPtX2Y4aZ7iuTbTmp0JGDXh6yNj/Z8IYCHKh9xkT5Ll1htFXLER3vOZiDnnLkjdadeMQ2/ynbQvjZuJEIi+YL71t3vbEqGXhuK1Y4X8b4Ancm7+3mBvgLGB9y1MAdcplAKI9bQxloWXeqb7q80x7HjOoxV40GhhstDets5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LFnVTY/l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LFnVTY/l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01B3221FDB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706835582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTUNq4guKMfeboG2vO7DsILXO79hyHzcmEAUEgUQWsE=;
	b=LFnVTY/lXmsRxd25wfAKaflfyOLWD7nYfl/hPUqP82AoeLMsdkHZmul76QpeNC8sWdOr+Z
	DOZy0a9/uwuOXJwCHn1n4KsxgS4c8XDmg56V1PFxifJITmxMMeDt/7ozrKaYhJbiKgDa0t
	npm6nZIuzGasXWSb4xCojommIsV3+Mw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706835582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTUNq4guKMfeboG2vO7DsILXO79hyHzcmEAUEgUQWsE=;
	b=LFnVTY/lXmsRxd25wfAKaflfyOLWD7nYfl/hPUqP82AoeLMsdkHZmul76QpeNC8sWdOr+Z
	DOZy0a9/uwuOXJwCHn1n4KsxgS4c8XDmg56V1PFxifJITmxMMeDt/7ozrKaYhJbiKgDa0t
	npm6nZIuzGasXWSb4xCojommIsV3+Mw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DAA4139AB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 00:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8A6bOHw+vGXABgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 00:59:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: tune: fix the missing close()
Date: Fri,  2 Feb 2024 11:29:20 +1030
Message-ID: <aa82c7345596ca6109abc756fc1875a070639723.1706827356.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706827356.git.wqu@suse.com>
References: <cover.1706827356.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="LFnVTY/l"
X-Spamd-Result: default: False [3.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[11.47%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.69
X-Rspamd-Queue-Id: 01B3221FDB
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

[BUG]
In "btrfs tune" subcomammand, we're using open_ctree_fd(), which
requires passing a valid fd, and the caller is responsible to properly
handling the lifespan of the fd.

But we just call close_ctree() and btrfs_close_all_devices(), without
closing the fd.

[FIX]
Just manually close the fd.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tune/main.c b/tune/main.c
index 9dcb55952b59..0fbf37dd4800 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -535,6 +535,7 @@ out:
 	}
 	close_ctree(root);
 	btrfs_close_all_devices();
+	close(fd);
 
 free_out:
 	return ret;
-- 
2.43.0


