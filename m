Return-Path: <linux-btrfs+bounces-10930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C42A0B37A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 10:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE68D16A63A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5F01FDA9D;
	Mon, 13 Jan 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZCZIOTiz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZCZIOTiz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FA1FDA8A
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761356; cv=none; b=M/5aVCmw0e0ntGHfiU5/bzQCfdhC2nMch1Jsm5m79xT6FZsV5zrX6FLrJEaxh47mAYBL8DxASBwmMmk6G1bP9L43WPJXKpUO4ElXmu6mfQbj+1aAiviftSNkNGbDRB+6c+MTv6Xl5gy9AOWm9wLP89pCJNMfcLP5L67Wvcm8Tw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761356; c=relaxed/simple;
	bh=QQds1yUAFAOBDiRHuqhUzgBJ3ghc6oVxuskfEjPAzGw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mmCPatEMBspwwlqkqFX0sH4NzI9FDl/8p05HzDLwLeHKSvVug41wyFMyZNbIujb9ihafqNMfhnS8aYdhnkb62H3FOF7wNE4xwkIn1UdpaydZEnttUw3MUvweiNunO2sRfCCey/W2avoSNbu80c2dCyZImyQOz7PaXcYzJ6emMPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZCZIOTiz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZCZIOTiz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E1871F37C
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736761352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e3Np7VFGtVNBdKPc6+1mMzkICZVOQrYrQVF+k+HGs10=;
	b=ZCZIOTiz+mT4lwtbLDPypqAg2B2tLLx/R7G+GIDVMOGFro72MApUaXX2PT7EAnH5qRXwbh
	b6sAZPuR+8FjpsqM/wO/CvFijPNPP5uN1sL3XchgggwmcEPRE+8uq8RpDcE3sotwniPw4M
	8SfyodhqhoA+WHmjt1bwLeo2jQWG6hc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736761352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e3Np7VFGtVNBdKPc6+1mMzkICZVOQrYrQVF+k+HGs10=;
	b=ZCZIOTiz+mT4lwtbLDPypqAg2B2tLLx/R7G+GIDVMOGFro72MApUaXX2PT7EAnH5qRXwbh
	b6sAZPuR+8FjpsqM/wO/CvFijPNPP5uN1sL3XchgggwmcEPRE+8uq8RpDcE3sotwniPw4M
	8SfyodhqhoA+WHmjt1bwLeo2jQWG6hc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA6EE13310
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oFwSGwfghGf0WgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: move ordered extents cleanup to where they got allocated
Date: Mon, 13 Jan 2025 20:12:11 +1030
Message-ID: <cover.1736759698.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
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

Currently ordered extents cleanup is delayed, e.g:

Cow_file_range() and run_delalloc_nocow() all can allocate ordered
extents by themselves.
But the ordered extents cleanup is not happending in those functions,
but at the caller, btrfs_run_delalloc_range().

This is not the common practice, and has already caused various ordered
extent double accounting (fixed by the recent error handling patchset).

So this series will address the problem by:

- Refactor run_delalloc_nocow() to extract the NOCOW ordered extents
  creation
  To make later error handling a little simpler.

- Move ordered extents cleanup to where they got created
  There are 3 call sites:
  - cow_file_range()
    This is the simplest one, as the recent fix makes it pretty straight
    forward.

  - nocow_one_range()
    The new helper introduced to created ordered extents and extent maps
    for NOCOW writes.
    This is also pretty straightforward

  - run_delalloc_nocow()
    There are 3 different error cases that needs to adjust the ordered
    extents cleanup range.

Qu Wenruo (2):
  btrfs: extract the nocow ordered extent and extent map generation into
    a helper
  btrfs: move ordered extent cleanup to where they are allocated

 fs/btrfs/inode.c | 188 +++++++++++++++++++++++++++--------------------
 1 file changed, 107 insertions(+), 81 deletions(-)

-- 
2.47.1


