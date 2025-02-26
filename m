Return-Path: <linux-btrfs+bounces-11837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87BAA45801
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EDE18903A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 08:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCDB1E1DF5;
	Wed, 26 Feb 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aIse23EO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aIse23EO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E846426
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558147; cv=none; b=mIVUxQiF23LDBIhzyIj1E0A6VW2fEPUYwRIpHSMyCemDdZFd4CcCGwFBXI55Wn7aux52LZXGG2Pcu/jRB33W8Bejr9LTA6P7rUvTOMM/ZS3xLSxi75dBZYBfDuGyfb/BXuXzl8tA9wTN0mP2XjprjZ/bvCA3GItzjGxcUYFI9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558147; c=relaxed/simple;
	bh=Oga3O/nMA3gOs7SBiCOIL3F8u1dkNtzSR26ot1dUlhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryfkjW0WyFF1NOV4k7mdJKNI5A8LNnzVv+OnA7hCi88xETmzrIQR3NfM9l7vCHlWdEmK2g41ppQHZ4qHnlgP+gwek4W6V2M4DZOysG0ib6xQik66s82MCSxt6066mKbotSKA7c7Vp1W7dDqRf79T4weWsWl0gAAzEirfmf86A+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aIse23EO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aIse23EO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF2BE1F38D;
	Wed, 26 Feb 2025 08:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740558143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gmn35pcDILjhhmzg2k/jvOKKExhaFVp700JXAQlTHEM=;
	b=aIse23EOGT3E+O4s8KgUkd8M+fodMqnJdAkzWiYzTohdUbATp7wPGPPbYVEgVLjePhkLFo
	jgZOjaj9w5NwlC2xLyk0oxuHvwhSEzHoxEl9fvyXQBkgNCMkHILlv+ZhiXpMDWrLeoZxA/
	Bsh1VNK60lAJoWKqk5dvycOoUjI2eKc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740558143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gmn35pcDILjhhmzg2k/jvOKKExhaFVp700JXAQlTHEM=;
	b=aIse23EOGT3E+O4s8KgUkd8M+fodMqnJdAkzWiYzTohdUbATp7wPGPPbYVEgVLjePhkLFo
	jgZOjaj9w5NwlC2xLyk0oxuHvwhSEzHoxEl9fvyXQBkgNCMkHILlv+ZhiXpMDWrLeoZxA/
	Bsh1VNK60lAJoWKqk5dvycOoUjI2eKc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8EAA1377F;
	Wed, 26 Feb 2025 08:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H2E0KT/PvmdmRAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 08:22:23 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Extent buffer allocation helpers cleanup
Date: Wed, 26 Feb 2025 09:22:21 +0100
Message-ID: <cover.1740558001.git.dsterba@suse.com>
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
X-Spam-Flag: NO
X-Spam-Level: 

There used to be a reason to have an eb allocation with arbitrary
nodesize due to selftests but this does not seem to be necessary
anymore.

David Sterba (2):
  btrfs: don't pass nodesize to __alloc_extent_buffer()
  btrfs: merge alloc_dummy_extent_buffer() helpers

 fs/btrfs/extent_io.c             | 26 +++++++++-----------------
 fs/btrfs/extent_io.h             |  2 --
 fs/btrfs/tests/extent-io-tests.c |  6 +++---
 3 files changed, 12 insertions(+), 22 deletions(-)

-- 
2.47.1


