Return-Path: <linux-btrfs+bounces-1178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355318216D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 05:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1111F21903
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 04:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438423CB;
	Tue,  2 Jan 2024 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gTh1lc/l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gTh1lc/l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94E20FA;
	Tue,  2 Jan 2024 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01A4521E95;
	Tue,  2 Jan 2024 04:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704168761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqyUBOmhs9offHldf0W33EpKIqaYkR5v3L8UtRVyOpw=;
	b=gTh1lc/lXZFGjEKesd9Gevs1I53VdB+N+SyqMrimTYU/xJaKFVlB9ynmaLDS/xelaQ737O
	2yai750KC5G1uh470GM6wvJuwNvCRWnPXs/HoYe1tHb6HBKPRvadOD4lE6+YC0CyaXLFc4
	UKN6bvyvPT9HSPAWzu+z3eKOZnv8/DE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704168761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pqyUBOmhs9offHldf0W33EpKIqaYkR5v3L8UtRVyOpw=;
	b=gTh1lc/lXZFGjEKesd9Gevs1I53VdB+N+SyqMrimTYU/xJaKFVlB9ynmaLDS/xelaQ737O
	2yai750KC5G1uh470GM6wvJuwNvCRWnPXs/HoYe1tHb6HBKPRvadOD4lE6+YC0CyaXLFc4
	UKN6bvyvPT9HSPAWzu+z3eKOZnv8/DE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4BD4136D1;
	Tue,  2 Jan 2024 04:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I2Q0HzWNk2UHQQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 02 Jan 2024 04:12:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de
Subject: [PATCH v2 0/4] kstrtox: introduce memparse_safe()
Date: Tue,  2 Jan 2024 14:42:10 +1030
Message-ID: <cover.1704168510.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="gTh1lc/l"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.19)[-0.973];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.00
X-Rspamd-Queue-Id: 01A4521E95
X-Spam-Flag: NO

[CHANGELOG]
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

Function memparse() lacks error handling:

- If no valid number string at all
  In that case @retptr would just be updated and return value would be
  zero.

- No overflown detection
  This applies to both the number string part, and the suffixes part.
  And since we have no way to indicate errors, we can get weird results
  like:

  	"25E" -> 10376293541461622784 (9E)

  This is due to the fact that for "E" suffix, there is only 4 bits
  left, and 25 with 60 bits left shift would lead to overflow.
  (And decision to support for that "E" suffix is already cursed)

So here we introduce a safer version of it: memparse_safe(), and mark
the original one deprecated.
Unfortunately I didn't find a good way to mark it deprecated, as with
recent -Werror changes, '__deprecated' marco does not seem to warn
anymore.

The new helper has the following advantages:

- Better overflow and invalid string detection
  The overflow detection is for both the numberic part, and with the
  suffix. Thus above "25E" would be rejected correctly.
  The invalid string part means if there is no valid number starts at
  the buffer, we return -EINVAL.

- Allow caller to select the suffixes, and saner default ones
  The new default one would be "KMGTP", without the cursed and overflow
  prone "E".
  Some older code like setup_elfcorehdr() would benefit from it, if the
  code really wants to only allow "KMG" suffixes.

- Keep the old @retptr behavior
  So the existing callers can easily migrate to the new one, without the
  need to do extra strsep() work.

- Finally test cases
  The test case would cover more things other than the existing kstrtox
  tests:
  * The @retptr behavior
    Either for bad cases, which @retptr should not be touched,
    or for good cases, the @retptr is properly advanced,

  * Return value verification
    Make sure we distinguish -EINVAL and -ERANGE correctly.

With the new helper, migrate btrfs to the interface, and since the
@retptr behavior is the same, we won't cause any behavior change.


Qu Wenruo (4):
  kstrtox: always skip the leading "0x" even if no more valid chars
  kstrtox: introduce a safer version of memparse()
  kstrtox: add unit tests for memparse_safe()
  btrfs: migrate to the newer memparse_safe() helper

 fs/btrfs/ioctl.c        |   6 +-
 fs/btrfs/super.c        |   9 +-
 fs/btrfs/sysfs.c        |  14 ++-
 include/linux/kernel.h  |   8 +-
 include/linux/kstrtox.h |  15 +++
 lib/cmdline.c           |   5 +-
 lib/kstrtox.c           |  98 ++++++++++++++++-
 lib/test-kstrtox.c      | 235 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 382 insertions(+), 8 deletions(-)

-- 
2.43.0


