Return-Path: <linux-btrfs+bounces-20743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B579D3BC3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 01:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 822543029BB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B13F23373D;
	Tue, 20 Jan 2026 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T/thge7j";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T/thge7j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98162199FB0
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867232; cv=none; b=sU45xlj5FPhu/4ybESpe4tEHKjNbiwWPA0VxoW9r0+MTIldsAaGbEGdZyRRDkwV0P09b8oks20cJA5zXS5xb3sA+CvACSzw6JDCqHjHi7w1EczdAYh/4E1gMARgN1MQn+quRje24GTZDH/nATQ3tYLOV3h7dOrioeYC9Mam6O4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867232; c=relaxed/simple;
	bh=BQ+sWnm5OiSyvJMEmUJEA14NlPy+QC4U7bxLqLdxlXA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=i8Q1ryOITB84nH6T1q760XcrK6WLK20NV6Je9GzYbcKxn1YC/kfRZnE6tVVLb7Rut6ISiOPKn6nZ9U3qIf3YMkidxJ5O63CO2h0CcI/135om1x1wGE6A2YhwDmMtYUt0JfcQLbC1l73sKzWW5Li2QgICBzDsDj0+8ZxqEdB8A2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T/thge7j; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T/thge7j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAD755BCC5
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768867229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ilU+ZjPAKsfGlS41kU7RjRfRdqrjIJtk4Hc6zyJW3Gs=;
	b=T/thge7jcAWt0pfEpvpWJdHKqLrbbyMXTQ59IQnR1FY0EkbQCQn6LHWJ7rCoutsP9xd5jK
	mmIVMJk5lOhiYo+J9UasVqOjhlHhcYay7lCXot+G5+do6hf6ceQ35h88fPFduUF+KqhcZR
	UxrcciWFc3/SapFQZEI+f00QDbDgz0Y=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768867229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ilU+ZjPAKsfGlS41kU7RjRfRdqrjIJtk4Hc6zyJW3Gs=;
	b=T/thge7jcAWt0pfEpvpWJdHKqLrbbyMXTQ59IQnR1FY0EkbQCQn6LHWJ7rCoutsP9xd5jK
	mmIVMJk5lOhiYo+J9UasVqOjhlHhcYay7lCXot+G5+do6hf6ceQ35h88fPFduUF+KqhcZR
	UxrcciWFc3/SapFQZEI+f00QDbDgz0Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C81BB3EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k0H4HJzFbmlsGwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: get rid of compressed_bio::compressed_folios[] part 1
Date: Tue, 20 Jan 2026 10:30:07 +1030
Message-ID: <cover.1768866942.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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
X-Spam-Level: 

Currently we have compressed_bio::compressed_folios[] allowing us to do
random access to any compressed folio, then we queue all folios in that
array into a real btrfs_bio, and submit that btrfs_bio for read/write.

However there is not really any need to do random access of that array.

All compression/decompression is doing sequential folio access.

The part 1 is some easy and safe conversion on decompression path.

The part 2 will handle the compression part, but unfortunately that will
require some changes all compression path, thus will need some extra
work.

And only after compression paths also got converted, we still need
that compressed_folios[] array for now.

Qu Wenruo (3):
  btrfs: use folio_iter to handle lzo_decompress_bio()
  btrfs: use folio_iter to handle zlib_decompress_bio()
  btrfs: use folio_iter to handle zstd_decompress_bio()

 fs/btrfs/lzo.c  | 48 +++++++++++++++++++++++++++++++++++++++---------
 fs/btrfs/zlib.c | 19 ++++++++++++-------
 fs/btrfs/zstd.c | 13 +++++++++----
 3 files changed, 60 insertions(+), 20 deletions(-)

-- 
2.52.0


