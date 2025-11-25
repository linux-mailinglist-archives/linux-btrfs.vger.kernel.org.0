Return-Path: <linux-btrfs+bounces-19352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C1C8743B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 22:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B934B320
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 21:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A802F6578;
	Tue, 25 Nov 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kl8dxp6p";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kl8dxp6p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8C21D596
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107444; cv=none; b=ZuduIiE0tjsbnXN3ws/+bvkfNCuHdviEs2NCDvVmi3vylBjPASY+4m8GIMPuP/F5mYR5GqZMb3GcCVaEvI7uvyf4/9R/w/1EOTdXVm7QyWRyyrcn0lOKcrcwzkX/m+62f3zVLb1jYnJIeHykTfZRqN4LvlNIN1YriOXIAy4GInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107444; c=relaxed/simple;
	bh=YemQMjiQjUaXngCz2fr6scBoksPdCwyvaMvLpcQB8lY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fzyn17Ny00mGb+CC7Gt1LokxCNGs9hYenSFuvUnEPa+mnKEtEQCEDEQXEy3CDIBTOSc7UacIcZnfKbT4HJ9OJUw88kEpX15xRnqf2gwLL0URe3cae4YQjD/Fj4G9wQRDb2JifPzx3rJWT7OTnC8t/fGKo2jfr31NcXuEnA7pgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kl8dxp6p; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kl8dxp6p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02FA95BD11
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764107441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LurPeMVgHHlr45q/Nk7TyIY8tHs0ttk3smaTnI6Cl/I=;
	b=kl8dxp6po734Mgqy/D5YwSKonagN5UHs0H6A0HzWA5PZ6LjqpM4DH2Ifw1xHd93jcG//5V
	OYrkK0lXiEIcSbXPTfwqdw/K4XvKeXBt0e93k9zopj45Awh9MeGkiJjrZV+HI825Kr3qJy
	H/fQm5fbkanMxtHnGoD9KMGoXi856rg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kl8dxp6p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764107441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LurPeMVgHHlr45q/Nk7TyIY8tHs0ttk3smaTnI6Cl/I=;
	b=kl8dxp6po734Mgqy/D5YwSKonagN5UHs0H6A0HzWA5PZ6LjqpM4DH2Ifw1xHd93jcG//5V
	OYrkK0lXiEIcSbXPTfwqdw/K4XvKeXBt0e93k9zopj45Awh9MeGkiJjrZV+HI825Kr3qJy
	H/fQm5fbkanMxtHnGoD9KMGoXi856rg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 415DC3EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wO+yAbAkJmkoDgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: fix a potential path leak in print_data_reloc_error()
Date: Wed, 26 Nov 2025 08:20:20 +1030
Message-ID: <09073d95570fd8947ef62f7dfcf866be67e55dff.1764106678.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764106678.git.wqu@suse.com>
References: <cover.1764106678.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02FA95BD11
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Inside print_data_reloc_error(), if extent_from_logical() failed we
return immediately.

However there are the following cases where extent_from_logical() can
return error but still holds a path:

- btrfs_search_slot() returned 0

- No backref item found in extent tree

- No @flags_ret provided
  This is not possible in this call site though.

So for the above two cases, we can return without releasing the path,
causing extent buffer leaks.

Fixes: b9a9a85059cd ("btrfs: output affected files when relocation fails")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3cf30abcdb08..46b5d29f7e29 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -255,6 +255,7 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
 	if (ret < 0) {
 		btrfs_err_rl(fs_info, "failed to lookup extent item for logical %llu: %d",
 			     logical, ret);
+		btrfs_release_path(&path);
 		return;
 	}
 	eb = path.nodes[0];
-- 
2.52.0


