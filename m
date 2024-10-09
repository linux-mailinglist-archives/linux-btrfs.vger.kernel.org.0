Return-Path: <linux-btrfs+bounces-8715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17838996DF9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF24E1F21C04
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3E1A263F;
	Wed,  9 Oct 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LgRe6r0o";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LgRe6r0o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5A19FA93
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484328; cv=none; b=dTsBMW8HAyhPKQJrBJjx0gfql5mwkPl5KVNrEkoD/Z5RuakYnUcT4aSjqsLyD5J0od+3psUBHXwo1sjgP3DuRzfyjcUob1RVY2r5RQ6N0fdOJGyU7dqTljjQJ5R5c8jYfJFOV7iazZ/rh00yWjG141dJQjUfF1A03bPtxou9CVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484328; c=relaxed/simple;
	bh=nfn1DAQOJdYjghiBDG5lvOYz+gXLqAj0kcTso8Ejb04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzAk0Ag7W17Ve+B3PwawWF42jbUiE3bcfW20EGaYVzzHMYEHHs6bwso45LcO9yJjYLxxoEAZvtzI+JzImHKfGG+TuE13s+PlniZrnQrMRwfwidOPF9qpBPW2yrHm2tnQnMtep8DgmiESOucMoVtPsJ5wRaB3hOeGDZ8DAm66/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LgRe6r0o; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LgRe6r0o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 575371F80B;
	Wed,  9 Oct 2024 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQLF6/7+cEk07Qqa2JHaQQDxoOsMW/Pc8p36Yjt4lus=;
	b=LgRe6r0og2N2kFbAvXMVtIAf3WcXDXBXdvc0XWFBrABkVDw1sKS1qHSN+MGCnCk2/qKYLr
	UVGxM2kPFlookLqYxyXpZlWrw3cOvMow0Y+K12hgXCk9rM8379Qh5sQv8f8KGejqAx75pw
	YyRdNpqtMpFMweFFq37Bh2loIcjBuhE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQLF6/7+cEk07Qqa2JHaQQDxoOsMW/Pc8p36Yjt4lus=;
	b=LgRe6r0og2N2kFbAvXMVtIAf3WcXDXBXdvc0XWFBrABkVDw1sKS1qHSN+MGCnCk2/qKYLr
	UVGxM2kPFlookLqYxyXpZlWrw3cOvMow0Y+K12hgXCk9rM8379Qh5sQv8f8KGejqAx75pw
	YyRdNpqtMpFMweFFq37Bh2loIcjBuhE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 506D7136BA;
	Wed,  9 Oct 2024 14:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cVehE+WTBmdvRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:32:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 20/25] btrfs: drop unused parameter fs_info from folio_range_has_eb()
Date: Wed,  9 Oct 2024 16:32:05 +0200
Message-ID: <6cd727c0954d96bb8d3b51c11c0af5a0bfa7a569.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The parameter was added in 8ff8466d29efc2 ("btrfs: support subpage for
extent buffer page release") for page but hasn't been used since, so we
can drop it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 59c47cb8e538..7b68c9da691b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2506,7 +2506,7 @@ static int extent_buffer_under_io(const struct extent_buffer *eb)
 		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 }
 
-static bool folio_range_has_eb(struct btrfs_fs_info *fs_info, struct folio *folio)
+static bool folio_range_has_eb(struct folio *folio)
 {
 	struct btrfs_subpage *subpage;
 
@@ -2580,7 +2580,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 	 * We can only detach the folio private if there are no other ebs in the
 	 * page range and no unfinished IO.
 	 */
-	if (!folio_range_has_eb(fs_info, folio))
+	if (!folio_range_has_eb(folio))
 		btrfs_detach_subpage(fs_info, folio);
 
 	spin_unlock(&folio->mapping->i_private_lock);
-- 
2.45.0


