Return-Path: <linux-btrfs+bounces-20140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C2CF7A91
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 11:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841C0302D922
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1235C30AAC2;
	Tue,  6 Jan 2026 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iY8SbnUD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iY8SbnUD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DDC2417C3
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693407; cv=none; b=Oq6z/IS6cyS2sj9komDZCdBjbL6AScXuVWLRxi6WMpVxItzIRRn0GRVOIS0b9h8x7OLds/dnS7+Nqfq2lRPjctFaFcbLhAqG95455rWSdDRA5PU/Vp/AJyl8hGDZ7Yd2c5uee/SbxUtKt0hUlmEhp8VffE1iiyO6UgmQQP9jMs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693407; c=relaxed/simple;
	bh=+WyDQyiR1UznsR5D64Zo8Gg2LjOfsN0LkcQXrVwnWJQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mDAva05abxwcQ/+yglJNCg2fd9yVy0L2worrBZzcE+b+8lkW7XicjuOL+UcPZj2THFckQJV+rifrVkwLBom6Jj/mx4K7H1bJVZILW1GtLF4GYnIuOGRqDNyhfz4sH0lJF1RAmmOtzzh0Wz+8kKrO6S+kjlh7z6mMo1GDJ8iAMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iY8SbnUD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iY8SbnUD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 992C95BCC4
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767693403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VLcPLavPbNNQlSoBLaxVaR5gKoAf0JTjlyaOM8Kdwco=;
	b=iY8SbnUDZGou4bWHmoCnIJUJJEP6gt1wNVkRgWSmXWDiC4Ia3AWUOAQqg6qmiuIyJtvsXr
	BPuHoCZRlBI6K35IUVISaM0RaTEyOD7IqtLzYyh1k1b8jbv9hRuGVS7uzN+sRnXk4dIBfR
	KRtd47LJdqPqzB4cOeYM62+fq/YRGfk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767693403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VLcPLavPbNNQlSoBLaxVaR5gKoAf0JTjlyaOM8Kdwco=;
	b=iY8SbnUDZGou4bWHmoCnIJUJJEP6gt1wNVkRgWSmXWDiC4Ia3AWUOAQqg6qmiuIyJtvsXr
	BPuHoCZRlBI6K35IUVISaM0RaTEyOD7IqtLzYyh1k1b8jbv9hRuGVS7uzN+sRnXk4dIBfR
	KRtd47LJdqPqzB4cOeYM62+fq/YRGfk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDE983EA63
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 09:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tVNOKFrcXGnAAgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 09:56:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: send: check for inline extents in range_is_hole_in_parent()
Date: Tue,  6 Jan 2026 20:26:40 +1030
Message-ID: <d03b605a911523e504cb1d6f00010c40d6558980.1767693386.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.68
X-Spam-Level: 
X-Spamd-Result: default: False [-2.68 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.413];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Before accessing the disk_bytenr field of a file extent item we need
to check if we are dealing with an inline extent.
This is because for inline extents their data starts at the offset of
the disk_bytenr field. So accessing the disk_bytenr
means we are accessing inline data or in case the inline data is less
than 8 bytes we can actually cause an invalid
memory access if this inline extent item is the first item in the leaf
or access metadata from other items.

Fixes: 82bfb2e7b645 ("Btrfs: incremental send, fix unnecessary hole writes for sparse files")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog
v2:
- Update the subject and commit message
  To give a more clear explanation on why we shouldn't touch disk_bytenr
  and other members before making sure the file extent is not an inlined
  one.
---
 fs/btrfs/send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2522faa97478..d8127a7120c2 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6383,6 +6383,8 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 		extent_end = btrfs_file_extent_end(path);
 		if (extent_end <= start)
 			goto next;
+		if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
+			return 0;
 		if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
 			search_start = extent_end;
 			goto next;
-- 
2.52.0


