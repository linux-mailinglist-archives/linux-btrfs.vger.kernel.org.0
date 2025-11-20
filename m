Return-Path: <linux-btrfs+bounces-19201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C489EC72AA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 08:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 438394E83AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBAD305E27;
	Thu, 20 Nov 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bL+fCCWJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bL+fCCWJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19312E03F1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625129; cv=none; b=CefoEpmxPa2cltqIJAlUcQlQTG5DlsYMZlC+X5SXYi9sBNb7b/gZ8XRiD90vcS8gx3Pmhln+fxtSufNMoDPU4zJGjN4REs9ZLDiK0vnSZDqPVTsF9dyJwWJjRBu1Am1tLEgQSRZNFS7LUHdA41IYNeP9wCJDOXP2s3X7Zes3JG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625129; c=relaxed/simple;
	bh=k3pZhxla2EIo8sz3lLf+Ri7+vOMiaxxlGzapu8ccgtE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HAjJQaPwkiCagym7kSNCzhD4bFgSWuv8o0YD6J+4I84Tt7UqJ8b9Ls13pQy2j2UmNmwTZPR+jGx7bIyOuOFK+S9T7xhoLvIefiCqYN60D0G3S1wsdiV19SixgdFEM96hmZhM2ToB9QcjdpVpDeG/6ndDKWQ1CbihPOjko2DvEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bL+fCCWJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bL+fCCWJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BE2D208F3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763625122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=odqSj+Qo/bYDD06d5ml5r+02qk8Wxt2/GSDfqErQies=;
	b=bL+fCCWJqIfXojBetURwhbd3wFY2qb1JfRnzOJTd3h+e0b4ZactTPui/2EnLZKhpWpCF+0
	q/BY+g7XpHXVFK7ykabALEPdfwbubrXEbDRBiJ7miJVe65b3xBmtxZhQyPCjRtfamQ3ojQ
	nkOwsfAby8jEBFl2opNiZekOvW5k8Kw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763625122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=odqSj+Qo/bYDD06d5ml5r+02qk8Wxt2/GSDfqErQies=;
	b=bL+fCCWJqIfXojBetURwhbd3wFY2qb1JfRnzOJTd3h+e0b4ZactTPui/2EnLZKhpWpCF+0
	q/BY+g7XpHXVFK7ykabALEPdfwbubrXEbDRBiJ7miJVe65b3xBmtxZhQyPCjRtfamQ3ojQ
	nkOwsfAby8jEBFl2opNiZekOvW5k8Kw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 760953EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dFwKDqHIHmmAQwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: reduce btrfs_get_extent() calls for buffered write path
Date: Thu, 20 Nov 2025 18:21:39 +1030
Message-ID: <cover.1763620860.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
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

[CHANGELOG]
v2:
- Fix a potential bug where OEs beyond EOF are not truncated properly
  This replace the original patch to extract the code into a helper.

- Replace more for_each_set_bit() with for_each_set_bitrange()

- Fix several copy-n-pasted incorrect range inside submit_range()


Although btrfs has bs < ps support for a long time, and the larger data
folios support is also going to be graduate from experimental features
soon, the write path is still iterating each fs block and call
btrfs_get_extent() on each fs block.

What makes the situation worse is that, for the write path we do not
have any cached extent map, meaning even with large folios and we got a
continuous range that can be submitted in one go, we still call
btrfs_get_extent() many times and get the same range extent map again
and again.

This series will reduce the duplicated btrfs_get_extent() calls by only
call it once for each range, other than for each fs block.

The first one is a potential bug inspired by Boris' review.
Patch 2~3 are minor cleanups.
Patch 4 is the core of the optimization.

Although I don't expect there will be much difference in the real world though.

Qu Wenruo (4):
  btrfs: make sure all ordered extents beyond EOF is properly truncated
  btrfs: integrate the error handling of submit_one_sector()
  btrfs: replace for_each_set_bit() with for_each_set_bitmap()
  btrfs: reduce extent map lookup during writes

 fs/btrfs/extent_io.c    | 236 +++++++++++++++++++++-------------------
 fs/btrfs/ordered-data.c |  38 +++++++
 fs/btrfs/ordered-data.h |   2 +
 3 files changed, 162 insertions(+), 114 deletions(-)

-- 
2.52.0


