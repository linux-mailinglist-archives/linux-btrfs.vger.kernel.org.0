Return-Path: <linux-btrfs+bounces-15531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95CB07F63
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 23:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1781C42808
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 21:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBE4501A;
	Wed, 16 Jul 2025 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tOAZORly";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tOAZORly"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5119CCF5
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700531; cv=none; b=Tjz8j9tqNpSPFsPOG/UH+DrhrGMJXwgD75FUhhIj52HWg5LAmvfeHJRFUt5WtC1biBaltKwaXep0LrvvVDgU9xmCd+2t2I3JUJ0kf1DvjNJV78U6tOV1C/bZVFRUWy9vd354FPmL4hCitMVr9RrVPsJuKH1h25BU7i2xRulY/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700531; c=relaxed/simple;
	bh=m3c4lBOuMF01+h5xU1fPUuxK/rQLtkTitOVLIvTSiI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igTF1cm5MzMQbXLY9HTKn6KMYPRNfSA5rERSuqpHB/+5JjnFUsZGAIYQbeCDuZ2LeDQRWgdyOfDFVBySzEf9s9PGpWl0o0WvBOhgJ5cqA6OYcqUcbo+WoxSkpyIyi+QEJ2pItcx8EkHAWB08xEHWfeGGlmCn1R2nZUOAdaFdRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tOAZORly; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tOAZORly; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDA40211FE
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752700521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDKFLhW2o3u1z60W1qkmdwLnO/iTblno5b2+PJPgsxc=;
	b=tOAZORlygBhU0vzngllWnW9uuF4PqSEHf5LzEzfJgA+gcBmdWhjzFSYygavkaN7Ls6mtJr
	FiXa3T6ePGMHMq72xMX+xLCYs5fU6OZ+0MyAqiNA6cOKayt3fBmhoNklTbk8RWbJa+UfyC
	yi93bBOSP9NMpN178kZlg9QmUK2DQfI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752700521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDKFLhW2o3u1z60W1qkmdwLnO/iTblno5b2+PJPgsxc=;
	b=tOAZORlygBhU0vzngllWnW9uuF4PqSEHf5LzEzfJgA+gcBmdWhjzFSYygavkaN7Ls6mtJr
	FiXa3T6ePGMHMq72xMX+xLCYs5fU6OZ+0MyAqiNA6cOKayt3fBmhoNklTbk8RWbJa+UfyC
	yi93bBOSP9NMpN178kZlg9QmUK2DQfI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9DCE13306
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CKTrHGgWeGipBwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: output more info when btrfs_subpage_assert() failed
Date: Thu, 17 Jul 2025 06:44:58 +0930
Message-ID: <60a37707504b8a56d37d1577d69a4f1d9d4b3615.1752700452.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752700452.git.wqu@suse.com>
References: <cover.1752700452.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

The function btrfs_subpage_assert() is a very common utilized assert to
make sure the range passed in is correct inside the folio.

And when some code is not properly subpage/large folio compatible
btrfs_subpage_assert() will be the first to be triggered.
E.g. when I incorrectly enabled large folios for data reloc inodes, it
immediately triggered btrfs_subpage_assert().

In that case, outputting all the involved members will be very helpful,
this includes:

- start
- len
- folio position inside the mapping
- folio size

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 2c5c9262b1a8..c9b3821957f7 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -186,8 +186,9 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	 * unmapped page like dummy extent buffer pages.
 	 */
 	if (folio->mapping)
-		ASSERT(folio_pos(folio) <= start &&
-		       start + len <= folio_end(folio));
+		ASSERT(folio_pos(folio) <= start && start + len <= folio_end(folio),
+		       "start=%llu len=%u folio_pos=%llu folio_size=%zu",
+		       start, len, folio_pos(folio), folio_size(folio));
 }
 
 #define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
-- 
2.50.0


