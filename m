Return-Path: <linux-btrfs+bounces-1203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6872B823922
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 00:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A18B2436A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 23:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3E11F609;
	Wed,  3 Jan 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iueBo2ey";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iueBo2ey"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0061200A6;
	Wed,  3 Jan 2024 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7038E1F7D1;
	Wed,  3 Jan 2024 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704324494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=by0bN+4olGdc/qeKOMpZHxmJCP87J7Px6EVlTEehZHo=;
	b=iueBo2eyPEkbOoxVM1IjjqMU9vj8f9a9sILHhYM+dKC7krZW38hsUZ52bjf+UzjkIWA+ow
	YjZhEmXmne7lH1v7kTXEYHSyhGmO9GfWQxjaw2j9/ibig0Mb9kYfz7CRWIZfBaIa47pNGD
	FeZZaXeE8lCRAE2v+iUbz/AM+JWsguU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704324494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=by0bN+4olGdc/qeKOMpZHxmJCP87J7Px6EVlTEehZHo=;
	b=iueBo2eyPEkbOoxVM1IjjqMU9vj8f9a9sILHhYM+dKC7krZW38hsUZ52bjf+UzjkIWA+ow
	YjZhEmXmne7lH1v7kTXEYHSyhGmO9GfWQxjaw2j9/ibig0Mb9kYfz7CRWIZfBaIa47pNGD
	FeZZaXeE8lCRAE2v+iUbz/AM+JWsguU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B8D51398A;
	Wed,  3 Jan 2024 23:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BGRjOYntlWWXTgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 03 Jan 2024 23:28:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de,
	geert@linux-m68k.org
Subject: [PATCH v3 0/4] kstrtox: introduce memparse_safe()
Date: Thu,  4 Jan 2024 09:57:47 +1030
Message-ID: <cover.1704324320.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****
X-Spamd-Bar: ++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=iueBo2ey
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.99 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-0.975];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de,linux-m68k.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 4.99
X-Rspamd-Queue-Id: 7038E1F7D1
X-Spam-Flag: NO

[CHANGELOG]
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
  The test case would cover more things than the existing kstrtox
  tests:

  * The @retptr behavior
    Either for bad cases, which @retptr should not be touched,
    or for good cases, the @retptr is properly advanced,

  * Return value verification
    Make sure we distinguish -EINVAL and -ERANGE correctly.

  * Valid string with suffix, but disable the corresponding suffix
    To make sure we still got the numeric string parsed, and can
    still pass the disabled suffix to the caller.

With the new helper, migrate btrfs to the interface, and since the
@retptr behavior is the same, we won't cause any behavior change.


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
 lib/cmdline.c           |   5 +-
 lib/kstrtox.c           |  98 +++++++++++++++-
 lib/test-kstrtox.c      | 244 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 392 insertions(+), 9 deletions(-)

-- 
2.43.0


