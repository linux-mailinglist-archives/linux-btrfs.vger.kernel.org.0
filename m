Return-Path: <linux-btrfs+bounces-12129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46663A58D03
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 08:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DD43AADCB
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 07:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29EA221542;
	Mon, 10 Mar 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UthPMLlv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UthPMLlv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B732206B6
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592204; cv=none; b=iZ1+EYdpDSW/jC97hWM08uawkkmkUQ0PKpHwT0QBprHNaUvkbywg8nsde1e1RN56HWsr3paAQw/PVBvbXOWFbMX+6s/7lmG2FoR0rMYQy8rs3TOWXYowMSl890SkcUwYiBKMNXqx28sDqevLj+sA5soj3cFY45mtKILgHoTA6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592204; c=relaxed/simple;
	bh=cEgdYc5dk80Vb6I1hl5B1zo8NQhpZWuwcRsV0RaacZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYfw+L7GGwtw2KaQ6AqPI4k2Gdxe6NkDSmNB1nhsN0FhgNd4dojF0SKX57BwKe3SMFnxk9Ubqt9nHMVfVxd+QL+qI5jEo/7nsWd+K6mAGrdJJsaZqgVATxOs3agm/uNPHwinzUgj5dJ/lzKH04CO1LO1jMprDSeewXCcYRZSw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UthPMLlv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UthPMLlv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EBC21F452;
	Mon, 10 Mar 2025 07:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tDw8wahVwaQa5oVGT4EFOtKQAMsGUF2KWjzuhsk2to=;
	b=UthPMLlv3LlKvdkfQGuKUsBZFqHpYwymYcAJ08is6WKuYqY+rl84RggjeJEcZYr2lLzSS4
	ayOAcBHbFk7k9l+ds9CKZP1N5iFNBkUKYsG0gDfazY/hqU21KMsKXK1sdUTsQ+KWroh5SL
	s/awqIt7c9JGOvmSVpT8SSotyb3Vdx4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tDw8wahVwaQa5oVGT4EFOtKQAMsGUF2KWjzuhsk2to=;
	b=UthPMLlv3LlKvdkfQGuKUsBZFqHpYwymYcAJ08is6WKuYqY+rl84RggjeJEcZYr2lLzSS4
	ayOAcBHbFk7k9l+ds9CKZP1N5iFNBkUKYsG0gDfazY/hqU21KMsKXK1sdUTsQ+KWroh5SL
	s/awqIt7c9JGOvmSVpT8SSotyb3Vdx4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9534913A70;
	Mon, 10 Mar 2025 07:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aIxGFXmWzmfpMAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 10 Mar 2025 07:36:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/6] btrfs: prepare btrfs_launcher_folio() for larger folios support
Date: Mon, 10 Mar 2025 18:06:00 +1030
Message-ID: <9c82cbbe6e9347042b4b90de80b3b8b21bfd7695.1741591823.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741591823.git.wqu@suse.com>
References: <cover.1741591823.git.wqu@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

That function is only calling btrfs_qgroup_free_data(), which doesn't
care about the size of the folio.

Just replace the fixed PAGE_SIZE with folio_size().

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1af72f77f820..f2ced3f7b112 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7307,7 +7307,7 @@ static void wait_subpage_spinlock(struct folio *folio)
 static int btrfs_launder_folio(struct folio *folio)
 {
 	return btrfs_qgroup_free_data(folio_to_inode(folio), NULL, folio_pos(folio),
-				      PAGE_SIZE, NULL);
+				      folio_size(folio), NULL);
 }
 
 static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
-- 
2.48.1


