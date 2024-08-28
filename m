Return-Path: <linux-btrfs+bounces-7614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7AA96279B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 14:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A52282572
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF3181329;
	Wed, 28 Aug 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tcOz3Kdo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RraF2jiX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jL9gkaNW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zSR+xMLu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8A16EB53
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849167; cv=none; b=BuFphS7MMoMReyMegzL+oxLTy5CiqMaRYWQguYq2Va/bYIO64tSn/ASBztSdX7ueIGXBtnK239vf7wxiX2qVgcWWSyGMPI8hxrdhemMv99HkDWSSQ6SqN+A/knOFoDEB2mgBZtcBP5pMimyXxFCNo9EzCPk14EetyJG9XXRYBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849167; c=relaxed/simple;
	bh=dVtbCxYIypvRaxZQlH1eGuHWR1jPuPZzPc6VPoOpKsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWluhdF/uSIEmERhNGMcZXTeHky7moPp6n5VBeU8og/Wn688Dhs+A3DR3NjTe2a/raEx4/snInBIGM3r2GjYwmYo2rcJuB5n33i4tgyqMUnFlGgFLiudZgY1A5g4pQ8JRaufGXAlH+s1VYSSrjEWDLPTpFhkZ3qkZd1KUt64A/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tcOz3Kdo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RraF2jiX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jL9gkaNW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zSR+xMLu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6F1C21B63;
	Wed, 28 Aug 2024 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724849164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcAPkg7IRbRQyqzEuiVsGm/IGCKI/rMnk1o6TdE+eys=;
	b=tcOz3KdomTr8XUkM2aHaUlPgIug5yFNXxUpbk+Bqdr/rvKolKEqO3FjJUXCBCW6D+r1Q9S
	hfRfYfQknrL7VCl92x5xkiJfBnkppY666nWmEUfHXvZVEfRlnFpTiB+/eiJ2YwHTa754Bg
	8zhFEVgQ9l4U1uKvdnUcCetbFonXRwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724849164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcAPkg7IRbRQyqzEuiVsGm/IGCKI/rMnk1o6TdE+eys=;
	b=RraF2jiXGQgxoSwXEXgP8/+J7n2cIsMS4eoa7fwTpaKG1HL3HAJVQZGfzxZa3k8ovqrxDe
	tSRb+6cE1EWpJ5Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jL9gkaNW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zSR+xMLu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724849162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcAPkg7IRbRQyqzEuiVsGm/IGCKI/rMnk1o6TdE+eys=;
	b=jL9gkaNWf6D6BNfeo2md3spuwCJH+pEuUkE1fGEnHtg+irxqrEUrKPPn+E+BhCVqaXU6p6
	Sc5KfSAzA35oXBm4j5Y0lAyKNLfU1uVSxUQElvAC+LWcV6jNFg6HEIlr4HJ6Gvhx2BRrY3
	ITvvh3dZucUUcAtcHhBHUyjjB8GMH3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724849162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcAPkg7IRbRQyqzEuiVsGm/IGCKI/rMnk1o6TdE+eys=;
	b=zSR+xMLu+akRzLVmuJWdhe4BUI74snWFo1uPbJiMJrrlRgJdtZMC8hkAiOZGKC72E845EQ
	9FxZ0pYGNrCQ17AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5C5B138D2;
	Wed, 28 Aug 2024 12:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2uanIgocz2YGGQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 28 Aug 2024 12:46:02 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/2] btrfs: btrfs_has_ordered_extent() to check for ordered extent in range
Date: Wed, 28 Aug 2024 08:45:49 -0400
Message-ID: <c252c360e04767f25698f0c6b85031c380a8a31d.1724847323.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724847323.git.rgoldwyn@suse.com>
References: <cover.1724847323.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E6F1C21B63
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

A simple function which checks if there are ordered extent in range
supplied.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ordered-data.c | 11 +++++++++++
 fs/btrfs/ordered-data.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index eb9b32ffbc0c..ea8b5fa42454 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1006,6 +1006,17 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 	return entry;
 }
 
+bool btrfs_has_ordered_extent(struct btrfs_inode *inode, u64 file_offset, u64 len)
+{
+	struct btrfs_ordered_extent *oe = NULL;
+
+	oe = btrfs_lookup_ordered_range(inode, file_offset, len);
+	if (!oe)
+		return false;
+	btrfs_put_ordered_extent(oe);
+	return true;
+}
+
 /*
  * Adds all ordered extents to the given list. The list ends up sorted by the
  * file_offset of the ordered extents.
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4e152736d06c..0c715c2a01ac 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -201,6 +201,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		struct btrfs_inode *inode,
 		u64 file_offset,
 		u64 len);
+bool btrfs_has_ordered_extent(struct btrfs_inode *inode, u64 file_offset, u64 len);
 void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 					   struct list_head *list);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
-- 
2.46.0


