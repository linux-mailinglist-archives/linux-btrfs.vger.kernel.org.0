Return-Path: <linux-btrfs+bounces-6216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D89281C2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 08:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28ABF1F23050
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 06:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56081136E17;
	Fri,  5 Jul 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dBMTgmvD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dBMTgmvD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1433C7
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160167; cv=none; b=YVqZYzjK6iNy9diejaHYEBY3atBsH3+JiRnjCIdMqPjubBc+RUj2VFOe7ox2IBoxZzeOyGt4eDAJBVJHKlmO7lfXbrSDlJmnsjfQYQFHo2rIlR4eo00YEXNNf16TJbPFHjUlN8JOLwXwmUysIHdyH6Yvl0Vt2NhqRBwNQUxUMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160167; c=relaxed/simple;
	bh=nQVogGhvG5sBfS2pqmkWdo/HBhEXLZPfxMz8TQRBDXg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ew7A6/n7EcCqNO75GIBBHeP/gVQsnQrQI94lScyg+JOh5F/Jmxl+rSZI/Wvn+XipC4oqzhJF1rQPhvirGGbWK6WKQBJhn7JjDEzmPKPsKiiig5JaHk7p/+MIbvxXlgjJJkcKah8ZvXqIWqh+HK5eWUd9e8AabIaiFU1aTEbTrVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dBMTgmvD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dBMTgmvD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FC891F7E2
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720160163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LZ0mcyDZrYJu3/vo8CrS1Gtqi5svIjcyV7xa6560xZ0=;
	b=dBMTgmvDFraspKD55ezkwSWyIhlWxCEVyBlBnIlgnzCxoaKN7Fcc/WZAlV1LDnta7WO2no
	CdIjU2GfphmYCBnDqaD9pM9X3Q3C681aWp3hSPmvwPaIMTyZXobOeCB+SB5ycjj/TBko9n
	yuHAyjnQd4J3jBQcmowSSC/ep+YTrHU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720160163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LZ0mcyDZrYJu3/vo8CrS1Gtqi5svIjcyV7xa6560xZ0=;
	b=dBMTgmvDFraspKD55ezkwSWyIhlWxCEVyBlBnIlgnzCxoaKN7Fcc/WZAlV1LDnta7WO2no
	CdIjU2GfphmYCBnDqaD9pM9X3Q3C681aWp3hSPmvwPaIMTyZXobOeCB+SB5ycjj/TBko9n
	yuHAyjnQd4J3jBQcmowSSC/ep+YTrHU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FD5C1396E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +01zBqKPh2YQFgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2024 06:16:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: remove __GFP_NOFAIL usage for debug builds
Date: Fri,  5 Jul 2024 15:45:37 +0930
Message-ID: <cover.1720159494.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.19
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.19 / 50.00];
	BAYES_HAM(-2.39)[97.19%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

This patchset removes all __GFP_NOFAIL flags usage inside btrfs for
DEBUG builds.

There are 3 call sites utilizing __GFP_NOFAIL:

- __alloc_extent_buffer()
  It's for the extent_buffer structure allocation.
  All callers are already handling the errors.

- attach_eb_folio_to_filemap()
  It's for the filemap_add_folio() call, the flag is also passed to mem
  cgroup, which I suspect is not handling larger folio and __GFP_NOFAIL
  correctly, as I'm hitting soft lockups when testing larger folios

  New error handling is added.

- btrfs_alloc_folio_array()
  This is for page allocation for extent buffers.
  All callers are already handling the errors.

Furthermore, to enable more testing while not affecting end users, the
change is only implemented for DEBUG builds.

Qu Wenruo (3):
  btrfs: do not use __GFP_NOFAIL flag for __alloc_extent_buffer()
  btrfs: do not use __GFP_NOFAIL flag for attach_eb_folio_to_filemap()
  btrfs: do not use __GFP_NOFAIL flag for btrfs_alloc_folio_array()

 fs/btrfs/extent_io.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.45.2


