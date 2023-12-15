Return-Path: <linux-btrfs+bounces-970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C98143CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 09:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175A8B22235
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E52A13FE1;
	Fri, 15 Dec 2023 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H8cb2zho";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CH7oPX8r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA994D28D
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D99BD21D8D
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702629585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xuipCeHoRGKtSoA+WXb3DqugtiCKIPjw2vUJT9kZ04Y=;
	b=H8cb2zho6YE9ik3os0fSJGR8nfKWaPZAvscbGAJHPug0+kk9ZImTm5ZHe/2+E9PfeZUExV
	gVJ7+6M3KODGoK3jx2ZyyMLjCsBWqQipBMSp8yMMaAU82GMy/GDA7Cr5WojxFwmmA8Mw6J
	SMolJkG3ANuZAMsQjWryvp/sFfoez+4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702629584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xuipCeHoRGKtSoA+WXb3DqugtiCKIPjw2vUJT9kZ04Y=;
	b=CH7oPX8rfcdrZUCjs5l70UMSIQYOiIbMWxI4v3iNHKwtBn7JxYEtQV+qbAK0cOn67w+VTh
	BilFbmwdhUc6yZMSlnvAC6CafIoGSSAWbNaA6CsNwlk+QJAYMZmXpEdc3i7GwsY+QLDGOb
	ZQivivXxTR3sN8VW6cuNjAZPm+zH8i0=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B4EC613A08
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 08:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yR6/F88QfGVJBgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 08:39:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] lib/kstrtox: introduce kstrtoull_suffix() helper
Date: Fri, 15 Dec 2023 19:09:22 +1030
Message-ID: <cover.1702628925.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CH7oPX8r
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
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
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.80%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: D99BD21D8D
X-Spam-Flag: NO

Recently David Sterba <dsterba@suse.cz> exposed some weird behavior of
btrfs sysfs interface, which is utilize memparse().

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
  for extra separators.

- Need to check the failure properly
  Which memparse() callers never seems to check anyway.

Thus the existing memparse() callers need to opt-in.
For now, btrfs usage of memparse() can be easily converted to
kstrtoull_suffix(), in the 2nd patch.

Qu Wenruo (2):
  lib/strtox: introduce kstrtoull_suffix() helper
  btrfs: sysfs: use kstrtoull_suffix() to replace memparse()

 fs/btrfs/sysfs.c        |  20 +++----
 include/linux/kstrtox.h |   7 +++
 lib/kstrtox.c           | 113 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 123 insertions(+), 17 deletions(-)

-- 
2.43.0


