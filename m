Return-Path: <linux-btrfs+bounces-5458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0458FC015
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 01:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56CB281D87
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C914E2EA;
	Tue,  4 Jun 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NVdi/42f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NVdi/42f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C514D703
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544658; cv=none; b=miEsjVoZxd2m1EFMeH0PZP4RI50VXP38kESychVZSDTZ6doeTviiKBmWA9WgdNY7CuvtKuRskfj2nxOef+rJgi2lFhzkNFSo+jd4BbApRoelvgh07SfO3YUL1bK0Yp+BX+SGd3byASUSffmUcu0nLUprhiQwY+F6X52ynfeIttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544658; c=relaxed/simple;
	bh=PZ2HDVSZ4VyYwCx3VZhoCHK401SnUK5LxvjLJMs73M4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUsGjrPf7Ik2jUhJSKbw+Rp3NlVekTs8i2pkWcWR7JTjanP/T3xZXuSxOh5aHUZopIGppTsx0enbcaVzWrvAUcKGxZqtv7I61SduCct+opsncbZsQfYgheOd8RmqAD4u+HGGasCDEq+o+b9sl3onSNIVQi1rd3lcHiy9n/PZBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NVdi/42f; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NVdi/42f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0493D219B4
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kvOLK3RdeCOYkMxQh3BqwinpGm3EViPpx7E5ZPvm9U=;
	b=NVdi/42f4SgnJ37kQWSkXw3t8u8c/Oi+lklJs14fZwXPKQW1BuB3hHXoNIp7Xmis97jvRW
	Os3LkrcaECh0H2lxmswoG8V1+Wp7hDvO6OWPCdm6JrPPes2nyxLf+8FIUph/cayTLR24QQ
	1rC24GuSuBMKdWIlGfEunvL3YrctKZo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="NVdi/42f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kvOLK3RdeCOYkMxQh3BqwinpGm3EViPpx7E5ZPvm9U=;
	b=NVdi/42f4SgnJ37kQWSkXw3t8u8c/Oi+lklJs14fZwXPKQW1BuB3hHXoNIp7Xmis97jvRW
	Os3LkrcaECh0H2lxmswoG8V1+Wp7hDvO6OWPCdm6JrPPes2nyxLf+8FIUph/cayTLR24QQ
	1rC24GuSuBMKdWIlGfEunvL3YrctKZo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 119BC13A93
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iIepLcmmX2bcJwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 23:44:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs-progs: print-tree: do sanity checks for dir items
Date: Wed,  5 Jun 2024 09:13:42 +0930
Message-ID: <817cdc0c65b00491a78d7f47efddffa1f76ab087.1717544015.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1717544015.git.wqu@suse.com>
References: <cover.1717544015.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0493D219B4
X-Spam-Level: 
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]

There is a bug report that with UBSAN enabled, fuzz/006 test case would
crash.

It turns out that the image bko-154021-invalid-drop-level.raw has
invalid dir items, that the name/data len is beyond the item.

And if we try to read beyond the eb boundary, UBSAN got triggered.

Normally in kernel tree-checker would reject such metadata in the first
place, but in btrfs-progs we can not go that strict or we can not do a
lot of repair.

So here just enhance print_dir_item() to do extra sanity checks for
data/name len before reading the contents.

Issue: #805
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 1b9386d87a0a..9a72ba39b426 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -78,6 +78,11 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
 		printf("\n");
 		name_len = btrfs_dir_name_len(eb, di);
 		data_len = btrfs_dir_data_len(eb, di);
+		if (data_len + name_len + cur > size) {
+			error("invalid length, cur=%u name_len=%u data_len=%u size=%u\n",
+				cur, name_len, data_len, size);
+			break;
+		}
 		len = (name_len <= sizeof(namebuf))? name_len: sizeof(namebuf);
 		printf("\t\ttransid %llu data_len %u name_len %u\n",
 				btrfs_dir_transid(eb, di),
-- 
2.45.2


