Return-Path: <linux-btrfs+bounces-1256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4879E824CF6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 03:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9809286C64
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 02:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675F3C36;
	Fri,  5 Jan 2024 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ce4/JgXB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ce4/JgXB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2420EB;
	Fri,  5 Jan 2024 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D91421DFE;
	Fri,  5 Jan 2024 02:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704422130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H0CJ8fANNvO2ixq7Pn+kIG0ltYTB4ZJd1BUKZhfIgRI=;
	b=ce4/JgXBWP38apNl3rzbGK1QuSVkmQ6Pko+GF2QAlzzGnLJ06qLrhMihwuXxqnWLPD0osl
	ADI0IpQluppyOH11AFxNcf0hcCqRVqsbUah/9QM0jzIfroo2/Pv5LIkbHFNoyrmj1JbqYD
	K/2e3GOsbZSiwYN6yWbVPiXtywsgxlM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704422130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H0CJ8fANNvO2ixq7Pn+kIG0ltYTB4ZJd1BUKZhfIgRI=;
	b=ce4/JgXBWP38apNl3rzbGK1QuSVkmQ6Pko+GF2QAlzzGnLJ06qLrhMihwuXxqnWLPD0osl
	ADI0IpQluppyOH11AFxNcf0hcCqRVqsbUah/9QM0jzIfroo2/Pv5LIkbHFNoyrmj1JbqYD
	K/2e3GOsbZSiwYN6yWbVPiXtywsgxlM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36972137E8;
	Fri,  5 Jan 2024 02:35:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yJZQK+tql2XhbAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 05 Jan 2024 02:35:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de,
	geert@linux-m68k.org,
	rdunlap@infradead.org
Subject: [PATCH v4 0/4] kstrtox: introduce memparse_safe()
Date: Fri,  5 Jan 2024 13:04:58 +1030
Message-ID: <cover.1704422015.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="ce4/JgXB"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de,linux-m68k.org,infradead.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[24.27%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 7D91421DFE
X-Spam-Flag: NO

[CHANGELOG]
v4:
- Extra test cases for supported but not enabled suffixes

- Comments update for memparse_safe() function

v3:
- Fix the 32bit pointer pattern in the test case
  The old pointer pattern for 32 bit systems is in fact 40 bits,
  which would still lead to sparse warning.
  The newer pattern is using UINTPTR_MAX to trim the pattern, then
  converted to a pointer, which should not cause any trimmed bits and
  make sparse happy.

v2:
- Make _parse_integer_fixup_radix() to always treat "0x" as hex
  This is to make sure invalid strings like "0x" or "0xG" to fail
  as expected for memparse_safe().
  Or they would only parse the first 0, then leaving "x" for caller
  to handle.

- Update the test case to include above failure cases
  This including:
  * "0x", just hex prefix without any suffix/follow up chars
  * "0xK", just hex prefix and a stray suffix
  * "0xY", hex prefix with an invalid char

- Fix a bug in btrfs' conversion to memparse_safe()
  Where I forgot to delete the old memparse() line.

- Fix a compiler warning on m68K
  On that platform, a pointer (32 bits) is smaller than unsigned long long
  (64 bits), which can cause static checker to warn.


Qu Wenruo (4):
  kstrtox: always skip the leading "0x" even if no more valid chars
  kstrtox: introduce a safer version of memparse()
  kstrtox: add unit tests for memparse_safe()
  btrfs: migrate to the newer memparse_safe() helper

 arch/x86/boot/string.c  |   2 +-
 fs/btrfs/ioctl.c        |   6 +-
 fs/btrfs/super.c        |   9 +-
 fs/btrfs/sysfs.c        |  14 ++-
 include/linux/kernel.h  |   8 +-
 include/linux/kstrtox.h |  15 +++
 lib/cmdline.c           |   4 +-
 lib/kstrtox.c           | 101 ++++++++++++++++-
 lib/test-kstrtox.c      | 244 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 394 insertions(+), 9 deletions(-)

-- 
2.43.0


