Return-Path: <linux-btrfs+bounces-4426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D058AABB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 11:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9BB282652
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2707BB0C;
	Fri, 19 Apr 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o76o1oJb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o76o1oJb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5673518
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520035; cv=none; b=sC0LJlxgqA41P4+g8IM/mRPDsXbcz9fLqf/SjBO+HgcVAitHJCYpaOc7VE6DSgd1+bxTxC5Z0rxqofF7yDxvuUIx0xzu3UU5SBQQYwBFnVPToylwb5yJPLgsycBXoat9hoUw31W02KOz/cX5JWOAD3NJpGIcxctOKg/twdkhu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520035; c=relaxed/simple;
	bh=LGpi74AXO3tn53wTqnMjXTpKdR8NiWAPTP9CWsSi9J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=us7on3OF23S6nV8XqR9H1fzDOsVx5ONm3YQrlYTi78QSg8+V1zntjtYCC3mzx4Mt9TBTdEcIM+RF9Xtp68Sdw5sBaYlSDZNe0kV7gucfaZYWZRyDYwcwTxuqW9yVxga9ZJ/HYh5ECg/FcG/3Ik4ekSKNbU75yhfe+l2dN03GBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o76o1oJb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o76o1oJb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40C565D526;
	Fri, 19 Apr 2024 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713520032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GavpPhX8AWfR8lr0svP2cMWX46c8Yor8drFXkHl4Y5o=;
	b=o76o1oJbEBpQOjaORKGY4wwBtqpr8+xCmgyY/+Ft5p5NFM0QD5utmasyl0C61dY936aVEY
	OkLbnfFUcv3vyE0eg9S7Ms8nYNNqiqCQOBP3rYD5vCpu4+2cUj8A4w1qphoU4egbFMEPnE
	xn/WAuJEXh0wNSBogPs4rdpfSxNRhkw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713520032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GavpPhX8AWfR8lr0svP2cMWX46c8Yor8drFXkHl4Y5o=;
	b=o76o1oJbEBpQOjaORKGY4wwBtqpr8+xCmgyY/+Ft5p5NFM0QD5utmasyl0C61dY936aVEY
	OkLbnfFUcv3vyE0eg9S7Ms8nYNNqiqCQOBP3rYD5vCpu4+2cUj8A4w1qphoU4egbFMEPnE
	xn/WAuJEXh0wNSBogPs4rdpfSxNRhkw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BB8F136CF;
	Fri, 19 Apr 2024 09:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o303AJ89ImafBwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Apr 2024 09:47:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: boris@bur.io
Subject: [PATCH v2 0/2] btrfs: qgroup: stale qgroups related impromvents
Date: Fri, 19 Apr 2024 19:16:51 +0930
Message-ID: <cover.1713519718.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.32 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.52)[80.30%];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.32
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Do more sanity checks before deleting a qgroup

- Make squota to handle auto deleted qgroup more gracefully
  Unfortunately the behavior change would affect btrfs/301, as the
  fully deleted subvolume would make the test case to cause bash grammar
  error (since the qgroup is gone with the subvolume).

  Cc Boris for extra comments on squota compatibility and future
  btrfs/311 updates ideas.

We have two problems in recent qgroup code:

- One can not delete a fully removed qgroup if the drop hits
  drop_subtree_threshold
  As hitting drop_subtree_threshold would mark qgroup inconsistent and
  skip all accounting, this would leave qgroup number untouched (thus
  non-zero), and btrfs refuses to delete qgroup with non-zero rfer/excl
  numbers.

  This would be addressed by the first patch, allowing qgroup
  deletion as long as it doesn't have any child nor a corresponding
  subvolume.

- Deleted subvolumes leaves a stale qgroup until next rescan
  This is a long existing problem.

  Although previous pushes all failed, just let me try it again.

  The idea is commit current transaction if needed (full accounting mode
  and qgroup numbers are consistent), then try to remove the subvolume
  qgroup after it is fully dropped.


Qu Wenruo (2):
  btrfs: slightly loose the requirement for qgroup removal
  btrfs: automatically remove the subvolume qgroup

 fs/btrfs/extent-tree.c |   8 +++
 fs/btrfs/qgroup.c      | 108 ++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/qgroup.h      |   2 +
 3 files changed, 110 insertions(+), 8 deletions(-)

-- 
2.44.0


