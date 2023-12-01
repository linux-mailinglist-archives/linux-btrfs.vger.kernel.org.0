Return-Path: <linux-btrfs+bounces-467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95353800383
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 07:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ADB1C20C00
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 06:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115BAC120;
	Fri,  1 Dec 2023 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JIsod02X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6E93
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 22:07:21 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 642B721ABF
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 06:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701410839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XPDW5nYUDRKujsyJKDstrQ5upC5FJaJXPU+ARBus7zo=;
	b=JIsod02Xk/Js0tg6izqiUfKGCDXy1jfQuWS7UKRTUKT2JqgLoUiFGN8zXCaQQ3RCJ3801H
	MiAUJuqnTbJ5rhK8MY4pp0mkqFL8Jzz1Ld+pw+ufu5ztt17NOF7yus84WsGI8aJBnsYNU6
	iuS9wObRZd1YDxOd0RUSdoHsOItbyws=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 55FA91344E
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 06:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id naFZABZ4aWUTOAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 06:07:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: migrate extent_buffer::pages[] to folio and more cleanups
Date: Fri,  1 Dec 2023 16:36:53 +1030
Message-ID: <cover.1701410200.git.wqu@suse.com>
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
X-Spam-Score: 3.90
X-Spamd-Result: default: False [3.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

[CHANGELOG]
v2:
- Adda new patch to do more cleanups for metadata page pointers usage

This patchset would migrate extent_buffer::pages[] to folios[], then
cleanup the existing metadata page pointer usage to proper folios ones.

This cleanup would help future higher order folios usage for metadata in
the following aspects:

- No more need to iterate through the remaining pages for page flags
  We just call folio_set/mark/start_*() helpers, for the single folio.
  The helper would only set the flag (mostly for the leading page).

- Single bio_add_folio() call for the whole eb

- Better filio helpers naming
  PageUptodate() compared to folio_test_uptodate().

The first patch would do a very simple conversion, then the 2nd patch do
the prepartion for the higher order folio situation.

There are two locations which won't be converted to folios yet:

- Subpage code
  There is no meaning to support higher order folio for subpage.
  The two conditions are just conflicting with each other.

- Data page pointers
  That would be more useful in the future, before we going to support
  multi-page sectorsize.

However the 2nd one would also add a new corner case:

- Order mismatch in filemap and eb folios
  Unforatunately I don't have a better plan other than re-allocate the
  folios to the same order.
  Maybe in the future we would have better ways to handle it? Like
  migrating the pages to the higher order one?



Qu Wenruo (2):
  btrfs: migrate extent_buffer::pages[] to folio
  btrfs: cleanup metadata page pointer usage

 fs/btrfs/accessors.c             |  20 +-
 fs/btrfs/accessors.h             |   4 +-
 fs/btrfs/ctree.c                 |   2 +-
 fs/btrfs/disk-io.c               |  25 +-
 fs/btrfs/extent_io.c             | 402 ++++++++++++++++++-------------
 fs/btrfs/extent_io.h             |  21 +-
 fs/btrfs/inode.c                 |   2 +-
 fs/btrfs/subpage.c               |  60 ++---
 fs/btrfs/subpage.h               |  11 +-
 fs/btrfs/tests/extent-io-tests.c |   4 +-
 10 files changed, 322 insertions(+), 229 deletions(-)

-- 
2.43.0


