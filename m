Return-Path: <linux-btrfs+bounces-2228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5F584DC32
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E04A1F23E42
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9E96A8DE;
	Thu,  8 Feb 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TZq9uvj1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TZq9uvj1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48C6A8DD
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382819; cv=none; b=DVywUfVvQ+RuU0UHQHtABimQ3Q1HTyFO1vurMIwbRn3u4CfnWqkquzc7iV/TV3CMYm68iGZiqvduiR/69neHWuTICv+Jn16J/a8tIwk0EH2d2jcQcpezEVbK3w4JuMp9HQkH24sD4794kRYZdEl/Gq4GAn92EGLiEc6WCeYq7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382819; c=relaxed/simple;
	bh=T6tUH1yA1Pc7hY5NRIX/F/cOeIksAwqyypLFPixkRw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVBQ2wHNFjSBvTCb0XweBOWuJclkZJaa7DlP6uyvNvFU/xK7q3KEMRNn8W65HcZ07f6GHZYuTtrkk0Xbo47r1wNzG4RbxJ1Tzh+8q2wuvTa/dHdy0hSY3II3kK+IFvL2/un7biyOdZNXqnkPb/G7amLFBKp9whCAswNkEL2caWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TZq9uvj1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TZq9uvj1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 673D421E6F;
	Thu,  8 Feb 2024 09:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF/fSJ1XzhKLj4+dOEYNW5wBSo4glcs4lnGFzHki48I=;
	b=TZq9uvj1EZc9SXsT0YbqpArzLBGoZ9YhTyKCDEmohO3Uvg5FH41njEGXk5/NbzlChtcbd+
	b1s6VCcrL6DCZlOP59qIlIkgqEXP/u0BYbMJjeFEMDuDHAwE7gdUN/oayC7zSyBmxIBSIc
	RtiztndIcQxvYb1risJXJhH3xw0DPz8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF/fSJ1XzhKLj4+dOEYNW5wBSo4glcs4lnGFzHki48I=;
	b=TZq9uvj1EZc9SXsT0YbqpArzLBGoZ9YhTyKCDEmohO3Uvg5FH41njEGXk5/NbzlChtcbd+
	b1s6VCcrL6DCZlOP59qIlIkgqEXP/u0BYbMJjeFEMDuDHAwE7gdUN/oayC7zSyBmxIBSIc
	RtiztndIcQxvYb1risJXJhH3xw0DPz8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5535413984;
	Thu,  8 Feb 2024 09:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DPXLFB6YxGV4DgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:14 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/14] btrfs: handle invalid extent item reference found in find_first_extent_item()
Date: Thu,  8 Feb 2024 09:59:41 +0100
Message-ID: <499c884260520b27afcf39f7142ac690ce1b7bc9.1707382595.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
References: <cover.1707382595.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.21
X-Spamd-Result: default: False [-0.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.11)[-0.574];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

The find_first_extent_item() helper looks up an extent item by a key,
allowing to do an inexact search when key->offset is -1.  It's never
expected to find such item, as it would break the allowed range of a
extent item offset.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0123d2728923..c4bd0e60db59 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1390,8 +1390,15 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
+	if (ret == 0) {
+		/*
+		 * Key with offset -1 found, there would have to exist an extent
+		 * item with such offset, but this is out of the valid range.
+		 */
+		btrfs_release_path(path);
+		return -EUCLEAN;
+	}
 
-	ASSERT(ret > 0);
 	/*
 	 * Here we intentionally pass 0 as @min_objectid, as there could be
 	 * an extent item starting before @search_start.
-- 
2.42.1


