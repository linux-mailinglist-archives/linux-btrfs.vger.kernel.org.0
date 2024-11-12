Return-Path: <linux-btrfs+bounces-9497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13119C4F55
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 08:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10548B215D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30C320ADDD;
	Tue, 12 Nov 2024 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ioJydX/y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ioJydX/y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B47B1F7092
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396244; cv=none; b=fKOjiV4dvyBsYFLhJ3eojniWNUejno6ecjd9Ruv0FDAgbjW0boci0LUyJ8UBDUQEQhXVGBnaD54D2+hqUKf0n6O9WfJUEw1OkUN5iNmuTXW5UHEuhbR88nh8vPIFfqvC/QLI1bqC3mqpGeM6vnN4AbrQkSK/JKGcCw6Sh6Enih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396244; c=relaxed/simple;
	bh=KXPw8DkqPyvnTvIecLlg8QPzlDIwfNu6l1mdbZr5+sA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbaN4TnB+Djt97zAo7/yoP31Xcb8H3Dm/rNeJn4lVsg0+7tviGK5oM+9JzKxbJ7RZWNtwJQWkrap3ZEXtmTUeyvTBSPbb1F87zTosUh05I9L/daka519X0gqaiCsfB2ljILVWfmtUazIq8gL+TrPp2bXiDSp33qFkPjYYjFd7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ioJydX/y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ioJydX/y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 720BD1F396
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731396241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZheIagjjsafrSNsAQKTmgKKHpvtDqO9+tjO6BiTaofg=;
	b=ioJydX/yEGBht5dtp19fkK+PSPtX0PIUU8FGbyaIr1zSIAzj72PTVQK8o/2hitzx6vhSMR
	c9aEuQhb65M1fu0MDdvp8Cum6GUqavY18G+nqfu3uQ2Sf6RLNfzR36cjnDhZfEXM2lz+0S
	mJbdN7Hrm+wlVtPOkF7gTAwpjB/VUto=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731396241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZheIagjjsafrSNsAQKTmgKKHpvtDqO9+tjO6BiTaofg=;
	b=ioJydX/yEGBht5dtp19fkK+PSPtX0PIUU8FGbyaIr1zSIAzj72PTVQK8o/2hitzx6vhSMR
	c9aEuQhb65M1fu0MDdvp8Cum6GUqavY18G+nqfu3uQ2Sf6RLNfzR36cjnDhZfEXM2lz+0S
	mJbdN7Hrm+wlVtPOkF7gTAwpjB/VUto=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D92213721
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2EJfF5ACM2esdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: make buffered write to respect fatal signals
Date: Tue, 12 Nov 2024 17:53:35 +1030
Message-ID: <f99ababba49b98b258254fe09a505d4613faa60f.1731396107.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731396107.git.wqu@suse.com>
References: <cover.1731396107.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This is to follow the behavior of iomap_write_iter() which calls
iomap_write_begin() to check the fatal signals.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 10d51c8dd360..a0fa8c36a224 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1142,6 +1142,10 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			ret = -EFAULT;
 			break;
 		}
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 
 		only_release_metadata = false;
 		sector_offset = pos & (fs_info->sectorsize - 1);
-- 
2.47.0


