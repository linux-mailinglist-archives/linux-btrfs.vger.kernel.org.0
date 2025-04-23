Return-Path: <linux-btrfs+bounces-13322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DD5A9949F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B07B9250E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6427CCD3;
	Wed, 23 Apr 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y4Mi+kPP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y4Mi+kPP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619B1F2C45
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423855; cv=none; b=kDsiNqiOW+sfJjySt0onFK0XOY9+TnLpnnujLmSLOdvUZr+yB6psj6TwwXH8+aZSaUgHXTBomyrR8rH1Ny7OZdJS5t9SLlDi6I/thoIY8i35KDv9CIx1dvrc2GzGJ+m6gGX2kOHOMyrqg7rXemPMY5cRDdTAAxxNcTfdb8uE9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423855; c=relaxed/simple;
	bh=EP7mcJUKq3nrb3RTbfY8AEMtdjU0K1jzcDrFurhOPfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKbqLIV51tcAHMoBLSjHtUoSC8Gq9R78vw22qYt67j6FWnRZNFKUYYX4YeUI3TA1MjFPMmmP4R8Qmbwpev9L89E47zmnhtxpcx4IzXw/oelRWcx8m/ojKDF7mvq78lo3WIkBvtJNtLmtDCxN0g1O+GoihFsIGa+T5RfXMUPTtfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y4Mi+kPP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y4Mi+kPP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 473171F38D;
	Wed, 23 Apr 2025 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=04BmrMqV8SfLOTrdvoUQP3p/P3SdupfaFiBVMYeMDvQ=;
	b=Y4Mi+kPP71Km+Pj0gk9cF3xucrwegQ50uCWCHvfDtVjNMMdn+MVLhlBpA79idyv6iR8Gm1
	maz5RmvEj9dhdjWg+jIQdeysA8qFJ3EQKG6lbnS92DRSyHluR08S6gQIRjqf4vEWi5uY4l
	kstjY4GIO3/akV7KlrRa9zC8muEGmq8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=04BmrMqV8SfLOTrdvoUQP3p/P3SdupfaFiBVMYeMDvQ=;
	b=Y4Mi+kPP71Km+Pj0gk9cF3xucrwegQ50uCWCHvfDtVjNMMdn+MVLhlBpA79idyv6iR8Gm1
	maz5RmvEj9dhdjWg+jIQdeysA8qFJ3EQKG6lbnS92DRSyHluR08S6gQIRjqf4vEWi5uY4l
	kstjY4GIO3/akV7KlrRa9zC8muEGmq8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34A4313691;
	Wed, 23 Apr 2025 15:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HSvQDOsNCWhzCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:57:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/12] Cleanups of blk_status_t use
Date: Wed, 23 Apr 2025 17:57:12 +0200
Message-ID: <cover.1745422901.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Use the blk_status_t only for interaction with block layer API and
remove it from our functions. Do some naming unifications and minor
cleanups.

David Sterba (12):
  btrfs: drop redundant local variable in raid_wait_write_end_io()
  btrfs: change return type of btrfs_lookup_bio_sums() to int
  btrfs: change return type of btrfs_csum_one_bio() to int
  btrfs: change return type of btree_csum_one_bio() to int
  btrfs: change return type of btrfs_bio_csum() to int
  btrfs: rename ret to status in btrfs_submit_chunk()
  btrfs: rename error to ret in btrfs_submit_chunk()
  btrfs: simplify reading bio status in end_compressed_writeback()
  btrfs: rename ret to status in btrfs_submit_compressed_read()
  btrfs: rename ret2 to ret in btrfs_submit_compressed_read()
  btrfs: change return type of btrfs_alloc_dummy_sum() to int
  btrfs: raid56: rename parameter err to status in endio helpers

 fs/btrfs/bio.c         | 33 ++++++++++++++++++---------------
 fs/btrfs/compression.c | 22 +++++++++++-----------
 fs/btrfs/disk-io.c     | 16 ++++++++--------
 fs/btrfs/disk-io.h     |  2 +-
 fs/btrfs/file-item.c   | 20 ++++++++++----------
 fs/btrfs/file-item.h   |  6 +++---
 fs/btrfs/raid56.c      | 13 ++++++-------
 7 files changed, 57 insertions(+), 55 deletions(-)

-- 
2.49.0


