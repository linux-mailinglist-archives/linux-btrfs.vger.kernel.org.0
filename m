Return-Path: <linux-btrfs+bounces-548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B7802BC1
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 07:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E811F21022
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A348F74;
	Mon,  4 Dec 2023 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gD8tp0SB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75079D3
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 22:56:50 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19FF021F75
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 06:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701673009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f70bwqLR9vK5xAETdlA+OfSL9G+QkgfBQWG5oQ/k3LU=;
	b=gD8tp0SB6vGwHFjpcVUFWKgNdo10mCHaJWc6SRX9g5bI5+7kpZCSd3pHzRI9KtKljMlxdI
	d9ngioY4ebT49kwr7OSwDRcD4pd5/1rYQOK+y5IODfYkgrVSAGD4k9DjUyv/eGixKb41Er
	Od0nodcLK2gLflpxh3tiIh+VfuPC9so=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 15B1C13588
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 06:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6uTjLC94bWXABwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 06:56:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: tune: run "btrfs check" before and after full fs conversion
Date: Mon,  4 Dec 2023 17:26:26 +1030
Message-ID: <cover.1701672971.git.wqu@suse.com>
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
X-Spam-Score: 6.87
X-Spamd-Result: default: False [6.87 / 50.00];
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
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_SPAM_SHORT(2.99)[0.998];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[56.11%]

There are already two reports about some filesystem corruption after
converting to block group tree.

So far we don't have any concrete evidence that block group tree
conversion is the cause yet, but there are some possible cases like a
unhealthy fs in the first place which can screw up such full fs
conversion.

To rule out the possibility, let's run "btrfs check" both before and
after a full fs conversion run (*), so that we make sure the fs is fine
and stays fine during the conversion.

*: For now this includes the following operations:
   - convert to block group tree
   - convert to extent tree
   - convert checksum type

   For UUID change (not the metadata uuid one), although we're rewriting
   the whole fs, we are doing it in-place, thus not much can go wrong,
   unlike the above 3, which relies one full transactional protection.
   Other operations are just changing a super block flag.

The first patch is removing inode cache clearing from btrfs check, as
we're exporting btrfs-check now, those deprecated functionality is no
longer worthy maintaining in "btrfs check". (And it's still maintained,
although only through "btrfs rescue").

The second patch would export the full "btrfs check" functionality
through btrfs_check() function, with btrfs_check_options structure to
toggle all the options.

Finally the last patch is doing all the extra checks for btrfstune.

Qu Wenruo (3):
  btrfs-progs: check: remove inode cache clearing functionality
  btrfs-progs: check: export a dedicated btrfs_check() function
  btrfs-progs: tune: add fsck runs before and after a full conversion

 Makefile                                      |   3 +-
 check/main.c                                  | 999 +++++++++---------
 common/utils.c                                |  18 +
 common/utils.h                                |  41 +
 .../ino-cache-enabled.raw.xz                  | Bin
 .../060-ino-cache-clean}/test.sh              |   2 +-
 tune/main.c                                   |  55 +
 7 files changed, 614 insertions(+), 504 deletions(-)
 rename tests/{fsck-tests/046-ino-cache-clean => misc-tests/060-ino-cache-clean}/ino-cache-enabled.raw.xz (100%)
 rename tests/{fsck-tests/046-ino-cache-clean => misc-tests/060-ino-cache-clean}/test.sh (97%)

--
2.43.0


