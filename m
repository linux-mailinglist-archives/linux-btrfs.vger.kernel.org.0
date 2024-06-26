Return-Path: <linux-btrfs+bounces-5982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6109175E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 03:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EFD2827FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 01:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA65D1D699;
	Wed, 26 Jun 2024 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B+dlU7HP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B+dlU7HP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B21BDDC
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366481; cv=none; b=NGrsPU9oddvjsNXIx8QS2I0ralM8lUJJIqxQjV5LivB2MWPX/aTTqeZHscZjwmwnIOt/ATYM4h4ejmwBho3Ljf1jtNS+bQlqny8hbqecFUlyq2KudZCe0lLM/csWdSLDjWshzRcz5GhAE9Ze/Ni0IzRadM17npWsvIoAhhhIT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366481; c=relaxed/simple;
	bh=YDg129yTSsBuHV2qIIPTnwYijNaq80hPPi5SRHwjfsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkI9VOsWRCCKBM9/pyaS6/eun7DqLvjjPKUlmdCWEZfUhS2atjFK9r4ZpLA69Acr9DoKz18DOevcAMX88WCgZBplvnmw1xdILRd17RUrJJyxC4tuPbrNE8NjbQPvRfp5AQe+CNvOEBBUS29Om9GQx6ZcgWtbAqQS+OO1bCK4ANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B+dlU7HP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B+dlU7HP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3086521AB5
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bfe3QrZKQw9sDHgRHiyeVMQGdNVriEED4mVseY5PlWk=;
	b=B+dlU7HP4kkixbZr9zyNe6iZ6X+DMOb6W0a4cw9OvGjd6u0XhS5lDcZ6IrFLJORta+ZpYD
	Hs/D6i7QH5m+jF6b46Xhb5lelcYg1NFvz4QIqu4kvDDQpqu/uuOi1brU3AswhTwe/yphSg
	w20SCfxFbCSP6u0hk06m6XKauue9UwM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bfe3QrZKQw9sDHgRHiyeVMQGdNVriEED4mVseY5PlWk=;
	b=B+dlU7HP4kkixbZr9zyNe6iZ6X+DMOb6W0a4cw9OvGjd6u0XhS5lDcZ6IrFLJORta+ZpYD
	Hs/D6i7QH5m+jF6b46Xhb5lelcYg1NFvz4QIqu4kvDDQpqu/uuOi1brU3AswhTwe/yphSg
	w20SCfxFbCSP6u0hk06m6XKauue9UwM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 484BD139C2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SM8aAExze2ZtbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/5] btrfs: make validate_extent_map() to catch ram_bytes mismatch
Date: Wed, 26 Jun 2024 11:17:31 +0930
Message-ID: <812f620f55e3e6990847fdf98cc3c30b9fc53363.1719366258.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719366258.git.wqu@suse.com>
References: <cover.1719366258.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Previously validate_extent_map() is only to catch bugs related to
extent_map member cleanups.

But with recent btrfs-check enhancement to catch ram_bytes mismatch with
disk_num_bytes, it would be much better to catch such extent maps
earlier.

So this patch adds extra ram_bytes validation for extent maps.

Please note that, older filesystems with such mismatch won't trigger this error:

- extent_map::ram_bytes is already fixed
  Previous patch has already fixed the ram_bytes for affected file
  extents.

So this enhanced sanity check should not affect end users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index b869a0ee24d2..6961cc73fe3f 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -317,6 +317,11 @@ static void validate_extent_map(struct btrfs_fs_info *fs_info, struct extent_map
 		if (em->offset + em->len > em->disk_num_bytes &&
 		    !extent_map_is_compressed(em))
 			dump_extent_map(fs_info, "disk_num_bytes too small", em);
+		if (!extent_map_is_compressed(em) &&
+		    em->ram_bytes != em->disk_num_bytes)
+			dump_extent_map(fs_info,
+		"ram_bytes mismatch with disk_num_bytes for non-compressed em",
+					em);
 	} else if (em->offset) {
 		dump_extent_map(fs_info, "non-zero offset for hole/inline", em);
 	}
-- 
2.45.2


