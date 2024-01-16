Return-Path: <linux-btrfs+bounces-1460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3BE82E83F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 04:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190B4284D98
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 03:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0A7482;
	Tue, 16 Jan 2024 03:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cX3dsWko";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cX3dsWko"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D326FBF
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EDC121A8A
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705375906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tnkgOPSqJCCqgrNezn355R2zqFV4NQSGRyh9+ND9gog=;
	b=cX3dsWko4+uxJWJwyInJD/zS/5SgoOkgjMpgQWbnb2DEd8oO41OnFQgwCcVTjRIwvrB54u
	pMNiJoNySqOCtVK/hGu8YUIj7nqbIxekzfPRkFDtjI2awTrPl1IuEhpY0ukJ4tmFVsD91f
	i/l+shniduaf8ShnZ5MTm4LE41m/XjI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705375906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tnkgOPSqJCCqgrNezn355R2zqFV4NQSGRyh9+ND9gog=;
	b=cX3dsWko4+uxJWJwyInJD/zS/5SgoOkgjMpgQWbnb2DEd8oO41OnFQgwCcVTjRIwvrB54u
	pMNiJoNySqOCtVK/hGu8YUIj7nqbIxekzfPRkFDtjI2awTrPl1IuEhpY0ukJ4tmFVsD91f
	i/l+shniduaf8ShnZ5MTm4LE41m/XjI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C310132FA
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wV4zAqH4pWUKOgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: make convert to generate chunks aligned to stripe boundary
Date: Tue, 16 Jan 2024 14:01:23 +1030
Message-ID: <cover.1705375819.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cX3dsWko
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[32.73%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: 3EDC121A8A
X-Spam-Flag: NO

There is a recent report about scrub use-after-free, which is caused by
unaligned chunk length (only aligned to sectorsize, but not to
BTRFS_STRIPE_LEN).

Although the bug would soon be fixed in kernel, there is no hard to make
convert to generate data chunks with both start and length aligned to
BTRFS_STRIPE_LEN.

Thankfully the start bytenr is already aligned to 64K, we only need to
make the length aligned.

Furthermore, allow "btrfs check" to detect such unaligned chunks and
gives a warning (but not consider it as an error).
For selftests, we would utilize the debug environment variable,
BTRFS_PROGS_DEBUG_STRICT_CHUNK_ALIGNMENT, to convert the warning to an
error.

Qu Wenruo (3):
  btrfs-progs: convert: make sure the length of data chunks are also
    stripe aligned
  btrfs-progs: add extra chunk alignment checks
  btrfs-progs: tests: enable strict chunk alignment check

 check/common.h       |  1 +
 check/main.c         | 20 ++++++++++++++++++++
 check/mode-lowmem.c  | 11 +++++++++++
 common/utils.c       | 19 +++++++++++++++++++
 common/utils.h       |  1 +
 convert/main.c       |  3 ++-
 tests/common         |  2 ++
 tests/common.convert |  2 ++
 8 files changed, 58 insertions(+), 1 deletion(-)

--
2.43.0


