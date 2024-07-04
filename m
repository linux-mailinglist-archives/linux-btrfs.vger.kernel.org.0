Return-Path: <linux-btrfs+bounces-6203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B86927BA1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 19:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4B42888D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F31B3F16;
	Thu,  4 Jul 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BjoT3JNc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BjoT3JNc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FD1B6A42;
	Thu,  4 Jul 2024 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112915; cv=none; b=qHnME3Mbc/d15bbRsgL7WXUcU9ZlEO3ZOPMaB/KniIzLI779He6AEXDABIatbVOnTE0T8vPnw3o8Wcz6WowgQM2xwYgjfumv03zwgH8HJlhw5gUlcUA3s0Rhp78xFLzbNrKgYxR51YUTVQ2dZul+dpzDCryW3Jw/9TmTeBWFZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112915; c=relaxed/simple;
	bh=yYVAQVfefVPAizfXvsFybpBijNlmD1qU13nE5cjAJVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/F1X5ODtiPJB22NywovxuPHDJFFYb206j9exsayJGY8h/1awB0KaG6kleA0IGWwxLt8rBsO4NRmIz4SpRRyRFOtgjW8s1vJfyCqXGfY2kLtGn+s4pX39JTqE2iKOqUvQ8EsOCz290GD6PUVlwCcLvVEmfB4K+mk8n45HIpukQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BjoT3JNc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BjoT3JNc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3348721BAC;
	Thu,  4 Jul 2024 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720112910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WTQvVo1gqLBLZnjrXLwhOKXabapyuxzQ7DU2T+72XC4=;
	b=BjoT3JNcNhZ0r6M0kLZxWYI8JMujbSOIt3yj1xHJlhDEefuIbFu5dFMsUjzIFIlgCO5BAW
	raki6CjjUU40afP9E8kNP2D/I7KZDtZIFIQ2C314dAjWsv3teRZFrkBAp4IYfDWPJJrbXg
	7haNeHGGnD7qQEHXMJ7cwENspNUnLVI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720112910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WTQvVo1gqLBLZnjrXLwhOKXabapyuxzQ7DU2T+72XC4=;
	b=BjoT3JNcNhZ0r6M0kLZxWYI8JMujbSOIt3yj1xHJlhDEefuIbFu5dFMsUjzIFIlgCO5BAW
	raki6CjjUU40afP9E8kNP2D/I7KZDtZIFIQ2C314dAjWsv3teRZFrkBAp4IYfDWPJJrbXg
	7haNeHGGnD7qQEHXMJ7cwENspNUnLVI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CCB513889;
	Thu,  4 Jul 2024 17:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hTDsCg7XhmbiXAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 04 Jul 2024 17:08:30 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.10.rc7, part 2
Date: Thu,  4 Jul 2024 19:08:16 +0200
Message-ID: <cover.1720111779.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi,

please pull a few more fixes for bugs reported recently. Thanks.

- fix folio refcounting when releasing them (encoded write, dummy extent
  buffer)

- fix out of bounds read when checking qgroup inherit data

- fix how configurable chunk size is handled in zoned mode

- in the ref-verify tool, fix uninitialized return value when checking
  extent owner ref and simple quota are not enabled

----------------------------------------------------------------
The following changes since commit 48f091fd50b2eb33ae5eaea9ed3c4f81603acf38:

  btrfs: fix adding block group to a reclaim list and the unused list during reclaim (2024-07-01 17:33:15 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc6-tag

for you to fetch changes up to a56c85fa2d59ab0780514741550edf87989a66e9:

  btrfs: fix folio refcount in __alloc_dummy_extent_buffer() (2024-07-04 02:19:10 +0200)

----------------------------------------------------------------
Boris Burkov (2):
      btrfs: fix folio refcount in btrfs_do_encoded_write()
      btrfs: fix folio refcount in __alloc_dummy_extent_buffer()

Filipe Manana (1):
      btrfs: fix uninitialized return value in the ref-verify tool

Naohiro Aota (1):
      btrfs: zoned: fix calc_available_free_space() for zoned mode

Qu Wenruo (1):
      btrfs: always do the basic checks for btrfs_qgroup_inherit structure

 fs/btrfs/extent_io.c  |  2 +-
 fs/btrfs/inode.c      |  2 +-
 fs/btrfs/qgroup.c     | 10 ++++++++--
 fs/btrfs/ref-verify.c |  9 +++++++--
 fs/btrfs/space-info.c | 24 +++++++++++++++++++++---
 5 files changed, 38 insertions(+), 9 deletions(-)

