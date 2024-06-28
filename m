Return-Path: <linux-btrfs+bounces-6029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934D91B5AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 06:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0592B283D3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 04:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA547225D4;
	Fri, 28 Jun 2024 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rLulfZ/N";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rLulfZ/N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7BF3BBC5
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719548517; cv=none; b=iIfquG2xVRx1OdjH7AKzPd6jt1x8xSWiR5RTLkmrd45ievWhc4WKvJPgjQvrZpO7EKXEbFeTmhtcWXZF3YxzKYKzV9ncdhR/lbmAkTM989jTdOB7LbTrBFUPuYV2U6YXu1fuuvu7fF8oUZLiIOEUjBR9PXdkXJ2YnePMCNLO4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719548517; c=relaxed/simple;
	bh=v4q4WfTW/O9ZeduXAsylsKz9t7zD8Z4MwwTRybQbFIc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UzWsiyuVbNLBUrT/E4yj5HE9S6dYcoN5r1VVVi+lC8FL8BI9a6ToYO5bzELJz2fd4MIt0TRtH+TSJgVc2pWpSwrMCwGXownrXxAXdB4LXOIIgzOx9uyG5aXv7hc2OyNv1JfwM6f70lefhrYzA1Z3vg1c9OXDOThve+IEM6HfBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rLulfZ/N; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rLulfZ/N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0198421A56
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719548513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GjiuhiJrFd7K8+CNcCzr1/0OCCAz0V8AJYt++TnAKvc=;
	b=rLulfZ/NJjSRBpBQwDelDtsuzObhgdHgRFRw/2R/wsFXNcYjgj7gPBn7tgD0GlWkLUdOtP
	mEnDTCCz1dvSI0yFxMBpKzdFe81BvDUVuMqsfPX1Y7hQApt4jHmC2bukC845+3b7kvHBlf
	7U7KQB3AeSm+Krvhlmj9MqAoDeLqhKc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719548513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GjiuhiJrFd7K8+CNcCzr1/0OCCAz0V8AJYt++TnAKvc=;
	b=rLulfZ/NJjSRBpBQwDelDtsuzObhgdHgRFRw/2R/wsFXNcYjgj7gPBn7tgD0GlWkLUdOtP
	mEnDTCCz1dvSI0yFxMBpKzdFe81BvDUVuMqsfPX1Y7hQApt4jHmC2bukC845+3b7kvHBlf
	7U7KQB3AeSm+Krvhlmj9MqAoDeLqhKc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 265B21373E
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z5J8NF86fmZXWwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:21:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: cleanup on the extra_gfp parameters
Date: Fri, 28 Jun 2024 13:51:28 +0930
Message-ID: <cover.1719548446.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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

[CHANGELOG]
v2:
- Instead of a one line wrapper, just rename @extra_gfp to @nofail

The @extra_gfp parameters for page/folio array allocation is only for
extent buffer allocation to pass __GFP_NOFAIL.
Furthermore there is no usage of btrfs_alloc_folio_array() for the extra
gfp flags.

This patchset removes the parameter for btrfs_alloc_folio_array() first,
then rename @extra_gfp to @nofail for btrfs_alloc_page_array().

Qu Wenruo (2):
  btrfs: remove the extra_gfp parameter from btrfs_alloc_folio_array()
  btrfs: rename the extra_gfp parameter of btrfs_alloc_page_array()

 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   | 28 +++++++++++++---------------
 fs/btrfs/extent_io.h   |  5 ++---
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/raid56.c      |  6 +++---
 fs/btrfs/scrub.c       |  2 +-
 6 files changed, 21 insertions(+), 24 deletions(-)

-- 
2.45.2


