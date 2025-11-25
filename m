Return-Path: <linux-btrfs+bounces-19331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E94C83F3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 09:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 892124E369D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31192D7DF2;
	Tue, 25 Nov 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z576VWbz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z576VWbz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678D2D7813
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058828; cv=none; b=ffs2G8Bxi4gEjAkSNyxmrixOarUuRLxySSYh4oqNHPtuF1WSZYAD31JkDnZ1KD5ihZDKTim7TNJltKCvDNQgIRKQ1FYVJSzLKJqo81bLJoTuBb5vD7DvIQwZGnGlG8oi+jDhpaFDVW/9EtKZ/icffBeeB8VZ3SF+WBMEajjW8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058828; c=relaxed/simple;
	bh=YemQMjiQjUaXngCz2fr6scBoksPdCwyvaMvLpcQB8lY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua/shtEkyQT9Art/EtKUcCVoQ/vnEeQHkHMIuxASA6f0UfPOj1SmYB1QHz1mWRneDdAiILHQYeMFiyAxRqhoZfnK1Y65l+q5CXuCASwEOVKmU91EtIH9NoNdGW4OGUQyN8gvhsZAPbCNbiJaQct4EVxsyjS578ygkIOlFpoDK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z576VWbz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z576VWbz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82FDB5BCE8
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764058817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LurPeMVgHHlr45q/Nk7TyIY8tHs0ttk3smaTnI6Cl/I=;
	b=Z576VWbzr72BGoe8lt8ye64PjNlXTnRVxEekTCGLTyIqgJ3URXqKkUstiNh2qrVfVvjb1A
	Vo9Ya796l2V8bczv7KMTiXWRFsSIhBdn8Oxgi3uIeyrLIMzf1WRuqSdL0/6Lsnso1UBMyG
	nFkmdyJ9fOrXNzgow32u4AYJ6FHavcQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764058817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LurPeMVgHHlr45q/Nk7TyIY8tHs0ttk3smaTnI6Cl/I=;
	b=Z576VWbzr72BGoe8lt8ye64PjNlXTnRVxEekTCGLTyIqgJ3URXqKkUstiNh2qrVfVvjb1A
	Vo9Ya796l2V8bczv7KMTiXWRFsSIhBdn8Oxgi3uIeyrLIMzf1WRuqSdL0/6Lsnso1UBMyG
	nFkmdyJ9fOrXNzgow32u4AYJ6FHavcQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7D113EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kN6aHsBmJWlRfwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix a potential path leak in print_data_reloc_error()
Date: Tue, 25 Nov 2025 18:49:56 +1030
Message-ID: <96c04602ed664de5aceeb9fb16b4b33a2215f8a7.1764058736.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764058736.git.wqu@suse.com>
References: <cover.1764058736.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

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


