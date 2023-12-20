Return-Path: <linux-btrfs+bounces-1068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6868194F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 01:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F301F25849
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A28C00;
	Wed, 20 Dec 2023 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XdkYY0aL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XdkYY0aL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4178BEB
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E39AC21F64
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 00:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703031025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i/+Ir5lwMGR7lxdtN2fUP1w54Ae/AHwaMd/325YFSU4=;
	b=XdkYY0aLASbF4zqYdSSOfHvxsfUmFaqsOrAOub1mjWxlEm5vpJTGL2UllZr5Yrnv7emZ95
	/4WAEuUktUUSRyUhCFwmCOV82B+ZByddnN43tQ71pNYYfpmUlGH//yVwISGGHq1u08xwUk
	DHHIZAgvbuka+QAmE1eXze5eLV1Rhzc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703031025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i/+Ir5lwMGR7lxdtN2fUP1w54Ae/AHwaMd/325YFSU4=;
	b=XdkYY0aLASbF4zqYdSSOfHvxsfUmFaqsOrAOub1mjWxlEm5vpJTGL2UllZr5Yrnv7emZ95
	/4WAEuUktUUSRyUhCFwmCOV82B+ZByddnN43tQ71pNYYfpmUlGH//yVwISGGHq1u08xwUk
	DHHIZAgvbuka+QAmE1eXze5eLV1Rhzc=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE9B6139F9
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 00:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id or1EFvAwgmU5dQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 00:10:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] lib/kstrtox: introduce kstrtoull_suffix() helper
Date: Wed, 20 Dec 2023 10:39:59 +1030
Message-ID: <cover.1703030510.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[13.42%]
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Use enum bitmap to define suffixes
  This get rid of the upper/lower case problem, and using enum for each
  suffix still provides a somewhat readable result.

- Do proper suffix overflow check
  The previous check for suffix overflow is incorrect at all, would
  still lead to incorrect values.

- Slight refactor for kstrtoull_suffix() code
  

Recently David Sterba <dsterba@suse.cz> exposed some weird behavior of
btrfs sysfs interface, which is utilizing memparse().

One example is using "echo 25e >
/sys/fs/btrfs/<uuid>/devinfo/scrub_speed_max".

The result value is not 0x25e, because there is no "0x" prefix provided.
Nor (25 << 60), as that would overflow.

All these are the caveats of memparse(), which lacks:

- Overflow check
- Reasonable suffix selection
  I know there may be some niche cases for memory layout, but for most
  callers, they just want a kstrtoull() with reasonable suffix
  selection.
  And I don't think exabytes is a reasonable suffix.

So here we introduce a new helper, "kstrtoull_suffix", which has some
the following two abilities added:

- Allow caller to select the suffix they want to enable
  The default list is "KkMmGgTtPp", no unreasonable "Ee" ones.

- Allow suffix parsing with overflow detection.
  The int part detection is already done by _kstrtoull(), and with the
  extra left shift, do the check again before returning the value.

Unfortunately this new helper is still not a drop-in replacement for
memparse():

- No @retptr support
  It's possible to add, but I'm not sure how many call sites need that
  for extra separators, and even if there are, they may want to go
  strsep() and strtok().

- Need to check the failure properly
  Which memparse() callers never seems to check anyway.

Thus the existing memparse() callers need to opt-in.
For now, btrfs usage of memparse() can be easily converted to
kstrtoull_suffix(), in the 2nd patch.

Qu Wenruo (2):
  lib/strtox: introduce kstrtoull_suffix() helper
  btrfs: sysfs: use kstrtoull_suffix() to replace memparse()

 fs/btrfs/sysfs.c        |  20 +++-----
 include/linux/kstrtox.h |  20 ++++++++
 lib/kstrtox.c           | 108 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 131 insertions(+), 17 deletions(-)

-- 
2.43.0


