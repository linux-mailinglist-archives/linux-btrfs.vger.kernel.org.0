Return-Path: <linux-btrfs+bounces-11778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB6A445A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DE63A9572
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC918C035;
	Tue, 25 Feb 2025 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PIBGw+2D";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u+iOPhAH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9121ABAB
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499961; cv=none; b=PRgDSs3ETghnFYqALkPz0v71opg+5AoKDCqwnhfLZgg5uBcRwTAOsEPB0Ub0ByRAKaF+ZE//0Z0DIwMnFtvuktlnIUvNkOw2tdTbADSVBu18VuSCJEHnIYPpVhue+Ht8feCudnjwlry1uR9odz5XbO0aOqPirKs5GPNi8ToBgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499961; c=relaxed/simple;
	bh=3/fNi19RJfcvacWgCItifvTHSZ50HeWIOZOdt8wsEdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFjo2CqwNZqBa6n4l5y4V6nLLoK8ROcIHgNs7Ef/m2lEAROzwhT3nQpljJp0WT0HL9RjJNY1y3WSurEx1r6W0MuBFHq8m+V+uJfC0dXqrNFG5uo7CyGyEarQhSadTViT0mt5U6AYDj5FD++DessYyEfi/LVAoQBbD0tHqEatgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PIBGw+2D; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u+iOPhAH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E875D2117A;
	Tue, 25 Feb 2025 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740499958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fiV4HPeQ3R2YmxZL5EtKks+aJ4Oci1p45h7vPgEn3Ok=;
	b=PIBGw+2DaKRY4F3JtLG8JayiM3S7u3goYyTUp6LO3OcdoOX6h0jDFcPJ6imgS7Q2evmFa8
	EiHRRyr8KcGU9Hh8yoeQnZbOA9oSAtYf9ZnA7F++NXntVmCF5FvjZcx17TdogoWUD5ULMv
	mvi5CWK9k1SXcRkDVE22soIz8anfAHw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=u+iOPhAH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740499957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fiV4HPeQ3R2YmxZL5EtKks+aJ4Oci1p45h7vPgEn3Ok=;
	b=u+iOPhAHvSGyJe+sy+WGq6PHo43OMJPYQnmfR5Qnca1+6MZo7r93Jz/GYr9gOVCmvlRdj8
	7SH6FFapkpNRTOOXCqZEBp3197z3cns+XOCQ6zQ29+B2S9lR7NGOVuhvoN1LJ+JvqGJk8c
	SMG1g0+rjS7JB6m6ueXf0mbTxEHdPOE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1FC313888;
	Tue, 25 Feb 2025 16:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6OUmN/XrvWf/OAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 25 Feb 2025 16:12:37 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.14-rc5
Date: Tue, 25 Feb 2025 17:12:34 +0100
Message-ID: <cover.1740498490.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E875D2117A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

please pull a few more fixes. Thanks.

- extent map shrinker fixes
  - fix potential use after free accessing an inode to reach fs_info,
    the shrinker could do iput() in the meantime
  - skip unnecessary scanning of inodes without extent maps
  - do direct iput(), no need for indirection via workqueue

- in block < page mode, fix race when extending i_size in buffered mode

- fix minor memory leak in selftests

- print descriptive error message when seeding device is not found

----------------------------------------------------------------
The following changes since commit da2dccd7451de62b175fb8f0808d644959e964c7:

  btrfs: fix hole expansion when writing at an offset beyond EOF (2025-02-11 23:09:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc4-tag

for you to fetch changes up to efa11fd269c139e29b71ec21bc9c9c0063fde40d:

  btrfs: fix data overwriting bug during buffered write when block size < page size (2025-02-21 09:32:24 +0100)

----------------------------------------------------------------
David Disseldorp (1):
      btrfs: selftests: fix btrfs_test_delayed_refs() leak of transaction

Filipe Manana (3):
      btrfs: fix use-after-free on inode when scanning root during em shrinking
      btrfs: skip inodes without loaded extent maps when shrinking extent maps
      btrfs: do regular iput instead of delayed iput during extent map shrinking

Qu Wenruo (2):
      btrfs: output an error message if btrfs failed to find the seed fsid
      btrfs: fix data overwriting bug during buffered write when block size < page size

 fs/btrfs/extent_map.c               | 83 ++++++++++++++++++++++++++-----------
 fs/btrfs/file.c                     |  9 +++-
 fs/btrfs/tests/delayed-refs-tests.c |  1 +
 fs/btrfs/volumes.c                  |  6 ++-
 4 files changed, 73 insertions(+), 26 deletions(-)

