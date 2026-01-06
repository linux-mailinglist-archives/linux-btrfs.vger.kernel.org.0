Return-Path: <linux-btrfs+bounces-20163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB1CF94DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 037BB3027697
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A21A324719;
	Tue,  6 Jan 2026 16:20:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2E2DA75C
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716451; cv=none; b=a+B1pF9+2Qgc2Vkrqeuic/Zxrk1QG0MYZR/FP5Dg1+dZ+ZVHHi/wgCG/4PPCbiRXz/wfEPLXZRLLK1uqxb6huYFXED+gH94E1AMLrSa0g3U1taHwWI1cEFjIfYcCbJj3K5JZjU/gijAQFp2A1IlHEISj0bqqebRtkmhg+7MVSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716451; c=relaxed/simple;
	bh=7aYVBLOAxHwird/ocfqUQHue4mPzrca+cF2hPGVzLWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBt/5wYAdHB2R8SgtsPY3DwEu0NFa0mix/dDY//r2V9ui/QJV7DzwXPYzOtSwkF54SVF1QjmNPE091fUWa0b+ABuklPstSjAU95yARM2SrKTL+RFaPvC0pAPnKsMZJz2r0PrtUlmYXeXDjR3sESznRdcnILIflcB6HiAqmTbyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 906CB33692;
	Tue,  6 Jan 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A1683EA63;
	Tue,  6 Jan 2026 16:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uC+0IV02XWmeWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:20:45 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/12] btrfs: remove duplicate calculation of eb offset in btrfs_bin_search()
Date: Tue,  6 Jan 2026 17:20:24 +0100
Message-ID: <bac90390ab73dabc0e8a2da8b5ecdcf25491c675.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 906CB33692
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action

In the main search loop the variable 'oil' (offset in folio) is set
twice, one duplicated when the key fits completely to the contiguous
range. We can remove it and while it's just a simple calculation, the
binary search loop is executed many times so micro optimizations add up.

The code size is reduced by 64 bytes on release config, the loop is
reorganized a bit and a few instructions shorter.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7267b250266579..1eef80c2108331 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -776,7 +776,6 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
 			const unsigned long idx = get_eb_folio_index(eb, offset);
 			char *kaddr = folio_address(eb->folios[idx]);
 
-			oil = get_eb_offset_in_folio(eb, offset);
 			tmp = (struct btrfs_disk_key *)(kaddr + oil);
 		} else {
 			read_extent_buffer(eb, &unaligned, offset, key_size);
-- 
2.51.1


