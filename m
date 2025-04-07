Return-Path: <linux-btrfs+bounces-12831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B9A7D3D2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 08:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2818C3AD542
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 06:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08902224AE8;
	Mon,  7 Apr 2025 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="izfLro05";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="izfLro05"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBEA55
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006185; cv=none; b=S5LyZ/4nuAi9NJ/tFDDzDQS5rSpdQrHihExbJevG0Ix5EruxiaHpL67UyiNceOAkD4l1G8O3unqw1ncWcy4bw6CL18+IobHbYDtY+LgddFriFD5iwOzU6sdp8jwUmDatdAyScFzgU2PlqBL2jO3Uv/LM+x4E3KelKXWnYpqsEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006185; c=relaxed/simple;
	bh=NKGR/RkrKgcVifPCzdBvDF2mMWU7TNpG7ze6QNDOnNw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UxBcSUYKQjOMSZNwK8UkPnjOM6l0MDVOy1tQhl38fJPAx0YnfIZIYnM9+oxFll7mq7PtV2PDtmY6ZJdPdphqhL/9kOv7akLRsid3iKlVyR0fW5NymZJ994YYsbKSofiSs6GBphXxyrPRewA0WWJ3bzzcPDj7DclRJv/Zjul6JbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=izfLro05; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=izfLro05; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BB352118D
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744006180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qUNm1nmhrZOZQ6rfCc4kowjdIyZR+SfQ5A5ltBzGZvI=;
	b=izfLro05j+/Pr0p7PXqlp7+qOFzroJpQUo5CcZ5d8pfiTurDccFAJDQMZFhUczGfViGgnk
	yaptVQvHsQYVau8xT2zAsaF9q842gST3xQRkPJXrsP2l1QqtUzr4WEmgTpTmDvuAmokJOH
	y2V1npDvs2yvGKY3RGrFtB5/1Jcubf8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=izfLro05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744006180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qUNm1nmhrZOZQ6rfCc4kowjdIyZR+SfQ5A5ltBzGZvI=;
	b=izfLro05j+/Pr0p7PXqlp7+qOFzroJpQUo5CcZ5d8pfiTurDccFAJDQMZFhUczGfViGgnk
	yaptVQvHsQYVau8xT2zAsaF9q842gST3xQRkPJXrsP2l1QqtUzr4WEmgTpTmDvuAmokJOH
	y2V1npDvs2yvGKY3RGrFtB5/1Jcubf8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 816E613691
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rodTECNs82eIfwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 07 Apr 2025 06:09:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: add large folio support to read-repair and defrag
Date: Mon,  7 Apr 2025 15:39:19 +0930
Message-ID: <cover.1744005845.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4BB352118D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

These two patches are originally in a series of ASSERT()s cleanup, but
later since I'm able to enable large data folios for testing, one bug is
exposed in the first patch, thus these two are not yet merged into
for-next branch.

Now with full fstests able to run on my local large data folios branch,
I can eventually verify the behavior of those two patches.

The first patch is to add extra calculation to convert the bio_vec (no
matter single page or multi page) to a proper folio and offset inside the
folio.

The second patch is to add large folios support to defrag, which only
needs minor changes.

Qu Wenruo (2):
  btrfs: prepare btrfs_end_repair_bio() for larger data folios
  btrfs: enable larger data folios support for defrag

 fs/btrfs/bio.c    | 61 ++++++++++++++++++++++++++++++++++-----
 fs/btrfs/defrag.c | 72 +++++++++++++++++++++++++++--------------------
 2 files changed, 96 insertions(+), 37 deletions(-)

-- 
2.49.0


