Return-Path: <linux-btrfs+bounces-1129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28DB81D371
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Dec 2023 10:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE4E1F2289D
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Dec 2023 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525BBA44;
	Sat, 23 Dec 2023 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CcM9o1T9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Er9z0CDZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0968F79;
	Sat, 23 Dec 2023 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3E7521EFF;
	Sat, 23 Dec 2023 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703325514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uZZNVmiXAnORfKDw7Spx/yDLniWTiCC/ccjJyHvjL+A=;
	b=CcM9o1T9Yhfx+Zw+7ZbYw1jBC0MQctpi0FJx/2+Rd9qOktYIFLrrz+csJ9HhrzBAjFl2nk
	0xyj/WOyFkcBcNLR8XV7YZMdWtLeSk2TnXorOs6/nBE/0GLg+VULJNBZmGBchv5sdJqVMH
	colW3vl10h70ShklEz2pc6Di/1jclkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703325513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uZZNVmiXAnORfKDw7Spx/yDLniWTiCC/ccjJyHvjL+A=;
	b=Er9z0CDZkQhfiiNuwVSx1vYzP7xlUJEBwFA50QJmHAJ5P/+K9U9Z9MI9ocg5nRXCTUMe5o
	O/OIJhb8UQ734d1vf7EyfXfltzAY2gz6dJFxkQl30BhleFlbR46W+iOddvJu/OUgnmBelF
	X6Jh/tuWedlrqlwhm6whCfD+8Vs+Qo4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 685051392C;
	Sat, 23 Dec 2023 09:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yLm6BEavhmXmcgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 23 Dec 2023 09:58:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de
Subject: [PATCH 0/3] kstrtox: introduce memparse_safe()
Date: Sat, 23 Dec 2023 20:28:04 +1030
Message-ID: <cover.1703324146.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ******
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Er9z0CDZ
X-Spam-Score: -1.81
X-Rspamd-Queue-Id: D3E7521EFF

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

Qu Wenruo (3):
  kstrtox: introduce a safer version of memparse()
  kstrtox: add unit tests for memparse_safe()
  btrfs: migrate to the newer memparse_safe() helper

 fs/btrfs/ioctl.c        |   8 +-
 fs/btrfs/super.c        |   8 ++
 fs/btrfs/sysfs.c        |  14 ++-
 include/linux/kernel.h  |   8 +-
 include/linux/kstrtox.h |  15 +++
 lib/cmdline.c           |   5 +-
 lib/kstrtox.c           |  96 ++++++++++++++++++
 lib/test-kstrtox.c      | 217 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 364 insertions(+), 7 deletions(-)

-- 
2.43.0


