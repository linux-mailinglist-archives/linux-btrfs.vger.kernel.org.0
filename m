Return-Path: <linux-btrfs+bounces-3032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 203EB872A3D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 23:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4D5B21B9E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB7426AD0;
	Tue,  5 Mar 2024 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WMEX59EM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WMEX59EM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3191E1429A
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678157; cv=none; b=G9h6YXAGBfIO94idAV9THvKVsTKUqYf5un5FNPl3/iAevkFEYxkx6IULfxCZ5YF+rBHeIARmxAlUvYrrSkGd9DWFeQ3t4uGbWejkgitZjlBEsDTLgGOBTmZ6qdD36+YOkyVGH9FIzdKhHsxEDRc5tmG3cdaeI2RTnVZKNpGZcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678157; c=relaxed/simple;
	bh=XyUEgLJQStFJsQsnbHgvv7ij9aJxesZ6RQq50g1cZUw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lirXElxhiCxsoH5VFY0Jkfc1f/sLZb4SHv0vdL+OzOXKoIQR40gFCmxqYa1adxo0IoI2uFQPJMxlLYarE+OUP1Wv+6dRm1MeYQeiPx8sRlrVPm4k0AdaWYESjax6+wZYnLlH6c6f5MxgUaOrstt42/P05P3bTUYfP9q3ZQz6m3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WMEX59EM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WMEX59EM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72F2134E72
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709678153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Oh+/oXym9Jl4cgPHYOLQ5eoltiu+dwFoFF6Xfh2DbHY=;
	b=WMEX59EMJBcf7o5eSNgfOa6NzAn1QZlim5DFvAv4Pdtx6/vN/OqxKIqNJo20+QbWV26HEG
	71CKewulRRlmm2HqM1qrTbC5bfqjeCPz+nqUlxTN1yOxEw3Q9gxWKzT1QEO28SSCceyvwe
	owtqz+U0byJUprUwGyawe56g4mI3le4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709678153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Oh+/oXym9Jl4cgPHYOLQ5eoltiu+dwFoFF6Xfh2DbHY=;
	b=WMEX59EMJBcf7o5eSNgfOa6NzAn1QZlim5DFvAv4Pdtx6/vN/OqxKIqNJo20+QbWV26HEG
	71CKewulRRlmm2HqM1qrTbC5bfqjeCPz+nqUlxTN1yOxEw3Q9gxWKzT1QEO28SSCceyvwe
	owtqz+U0byJUprUwGyawe56g4mI3le4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8515B13A5D
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mejaDkie52VwKgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 22:35:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: fix data corruption/hang/rsv leak in subpage zoned cases
Date: Wed,  6 Mar 2024 09:05:32 +1030
Message-ID: <cover.1709677986.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.69
X-Spamd-Result: default: False [3.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[45.58%]
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Update the commit message for the first patch
  As there is something wrong with the ASCII art of the memory layout.

[REPO]
https://github.com/adam900710/linux/tree/subpage_delalloc

The repo includes the subpage delalloc rework, or subpage zoned won't
work at all.


Although my previous subpage delalloc rework fixes quite a lot of
crashes of subpage + zoned support, it's still pretty easy to cause rsv
leak using single thread fsstress.

It turns out that, it's not a simple problem of some rsv leak, but
certain dirty data ranges never got written back and just skipped with
its dirty flags cleared, no wonder that would lead to rsv leak.

The root cause is again in the extent_write_locked_range() function
doing weird subpage incompatible behaviors, especially when it clears
the page dirty flag for the whole page, causing __extent_writepage_io()
unable to locate any dirty ranges to be submitted.

The first patch would solve the problem, meanwhile for the 2nd patch
it's a cleanup, as we will never hit the error for current subpage +
zoned cases.

Qu Wenruo (2):
  btrfs: do not clear page dirty inside extent_write_locked_range()
  btrfs: make extent_write_locked_range() to handle subpage writeback
    correctly

 fs/btrfs/extent_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.44.0


