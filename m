Return-Path: <linux-btrfs+bounces-14583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198ABAD35EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BFA3B8A46
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31EA28F509;
	Tue, 10 Jun 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jA/L6RKx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QWnEF1Bj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1928F938
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557873; cv=none; b=f9+whCHuj4NZzPpSdAlzhd+03CDeYitya3Cj/Vi2UuVkItaQ05pHjjvOY+abIVFC9opVF4OgBYVFuiIOhY9hg1q1hX0ieORwfy8yVUTfKj8qvv8ncgm9wt+/X/GdhIvQ2KNb0grwl/JbVWUzZY58DBqh1nju/J6KJ8UGlwVySuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557873; c=relaxed/simple;
	bh=M9F3iorEpCFUhynX5kkY08InBJ5kHRBxCKopBbqK3hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyAJzUPMtOZy4hJqAalEsPhICLZKOLP9joN7uRbxCl9337oci90OtkuzfMrwoU8ErfhaQhPC1yMNgFWcg4nbmKJe8oHpN9EZ8OkCW77aV1IQTb4hQFRIexcYnM7gWxmnMbDe15Mb13Mdyzz1uIBHMaaR2jJDk3LWDpHb9APluHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jA/L6RKx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QWnEF1Bj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A62111F7C2;
	Tue, 10 Jun 2025 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749557869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KCoRXMc3CYLpU6Z6zC5+ADtTYkVf35M2U+NTPVWuG8Y=;
	b=jA/L6RKxtFR8Bcl3/fvbPDBonfX8sAOw+6LthdJfay45RiaG3taOOkqtqBue+TF2oSwxq5
	AM84aMK+eq4cNowtihQrfTNmQzjQcQUksy77xGlaF3LevDrBLoZLvCMIPqIXYCd4X1IkYD
	Ijg0SQgLLfBeDECVTrRuszK5+xH/saQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749557866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KCoRXMc3CYLpU6Z6zC5+ADtTYkVf35M2U+NTPVWuG8Y=;
	b=QWnEF1BjrtxXe/3DU76ejpikStq40hFJDAU0XFdftTTsRyMUnx07Gj38E3gcmDS6cqjZP5
	GHrUOVTtogeY/6b/PgrP0DUhrpKwsqbn7Gd9vdxusvj8vflOFf+GHFP+ndHGG74L6B8u+X
	HZTOkrq2NXW4Jq1Sjn0zG3e9dD6a9gs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ECC8139E2;
	Tue, 10 Jun 2025 12:17:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eHK/JmoiSGircgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 10 Jun 2025 12:17:46 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/4] Folio pos + size cleanups
Date: Tue, 10 Jun 2025 14:17:44 +0200
Message-ID: <cover.1749557686.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Helper to simplify numerous folio_pos() + folio_size() calculations.

v2:
- preparatory patches: rename variables matching the semantics of
  locking with the "-1" end of range, and simplify some range calculations
- updated changelogs with stats of potential usage outside of btrfs

David Sterba (4):
  btrfs: simplify range end calculations in
    truncate_block_zero_beyond_eof()
  btrfs: rename variables for locked range in defrag_prepare_one_folio()
  btrfs: add helper folio_end()
  btrfs: use folio_end() where appropriate

 fs/btrfs/compression.h  |  7 +++----
 fs/btrfs/defrag.c       | 19 +++++++++----------
 fs/btrfs/extent_io.c    | 17 ++++++++---------
 fs/btrfs/file.c         |  9 ++++-----
 fs/btrfs/inode.c        | 12 +++++-------
 fs/btrfs/misc.h         |  7 +++++++
 fs/btrfs/ordered-data.c |  2 +-
 fs/btrfs/subpage.c      |  5 ++---
 8 files changed, 39 insertions(+), 39 deletions(-)

-- 
2.47.1


