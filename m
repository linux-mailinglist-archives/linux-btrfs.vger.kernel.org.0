Return-Path: <linux-btrfs+bounces-10114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE119E8332
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 03:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECAB1884717
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 02:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEFE22097;
	Sun,  8 Dec 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AC4n2r33";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AC4n2r33"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE017C69
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626288; cv=none; b=VQ2QvzngF98XHf9lVHVqvz8dDJDUOS6EQ+TdtEDfKZ8U6ZBMdauWvJVWqNs6sdtpDIGSGwdUQ6+/WfqtHcjWMrHCQTdb/uVP9ZPKuZGHNwU2D9I2bZdkw+3JnZuJ1uLY3FX22HcmKLalE+jLG4IWpD/nZwMHHCg8L3Q7uU7/e+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626288; c=relaxed/simple;
	bh=XTBLwuAP4uqw471tziAkpHAkF0fn06TITwFplxMvWXg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TsJoIkuexglJF4trfZgTedet2Orqi/6MuDFLhbaafN9hF+F+X7ctageXgNBa1hm4cHSqzvNH3wgvBkpQ2Zcg+WcEBxI7NDkQj+/WUa7fSimku9MMZmCuKDwAdRq2+puUcZsVOqWdpTcl1T6tg7BlJ7Zw6qzHjUt/Pp8hLoUD+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AC4n2r33; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AC4n2r33; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2FADB1F37E
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b0WVONDOpso0nPYZImN+/49k3xTqeH5omJMgjRtO4EQ=;
	b=AC4n2r33iezt+KqRcoYDtMXec8RN7HKAJcpAdoNZvLAF1LsoPtyFj/fRebauCIsizc8fkW
	Ek6edHAt995vAJgvSuuLMJkY38HTFVFs0y4Nad/K26cge/kpjZtzYYNro7HfohqD5cM3nX
	5QkkeliIVePSVgif6KSckPK8h7am2v8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AC4n2r33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b0WVONDOpso0nPYZImN+/49k3xTqeH5omJMgjRtO4EQ=;
	b=AC4n2r33iezt+KqRcoYDtMXec8RN7HKAJcpAdoNZvLAF1LsoPtyFj/fRebauCIsizc8fkW
	Ek6edHAt995vAJgvSuuLMJkY38HTFVFs0y4Nad/K26cge/kpjZtzYYNro7HfohqD5cM3nX
	5QkkeliIVePSVgif6KSckPK8h7am2v8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67CA1133D1
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OPpRCqsJVWcXcQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 02:51:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: error handling fixes
Date: Sun,  8 Dec 2024 13:20:57 +1030
Message-ID: <cover.1733624454.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2FADB1F37E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

I believe there is a regression in the last 2 or 3 releases where
metadata/data space reservation code is no longer working properly,
result us to hit -ENOSPC during btrfs_run_delalloc_range().

One of the most common situation to hit such problem is during
generic/750, along with other long running generic tests.

Although I should start bisecting the space reservation bug, but I can
not help fixing the exposed bugs first.

This exposed quite some long existing bugs, all in the error handling
paths, that can lead to the following crashes

- Double ordered extent accounting
  Triggers WARN_ON_OCE() inside can_finish_ordered_extent() then crash.

  This bug is fixed by the first 3 patches.

- Subpage ASSERT() triggered, where subpage folio bitmap differs from
  folio status
  This happens most likey in submit_uncompressed_range(), where it
  unlock the folio without updating the subpage bitmaps.

  This bug is fixed by the 3rd patch.

- WARN_ON() if out-of-tree patch "btrfs: reject out-of-band dirty folios
  during writeback" applied
  This is a more complex case, where error handling leaves some folios
  dirty, but with EXTENT_DELALLOC flag cleared from extent io tree.

  Such dirty folios are still possible to be written back later, but
  since there is no EXTENT_DELALLOC flag, it will be treat as
  out-of-band dirty flags and trigger COW fixup.

  This bug is fixed by the 4th and 5th patch

With so many existing bugs exposed, there is more than enough motivation
to make btrfs_run_delalloc_range() (and its delalloc range functions)
output extra error messages so that at least we know something is wrong.

And those error messages have already helped a lot during my
development.

Patches 6~8 are here to enhance the error messages.

With all these patches applied, at least fstests can finish reliably,
otherwise it frequently crashes in generic tests that I was unable to
finish even one full run since the space reservation regression.

Qu Wenruo (8):
  btrfs: fix double accounting race when btrfs_run_delalloc_range()
    failed
  btrfs: fix double accounting race when extent_writepage_io() failed
  btrfs: fix the error handling of submit_uncompressed_range()
  btrfs: do proper folio cleanup when cow_file_range() failed
  btrfs: do proper folio cleanup when run_delalloc_nocow() failed
  btrfs: subpage: fix the bitmap dump for the locked flags
  btrfs: subpage: dump the involved bitmap when ASSERT() failed
  btrfs: add extra error messages for delalloc range related errors

 fs/btrfs/extent_io.c |  79 ++++++++++++++----
 fs/btrfs/inode.c     | 188 +++++++++++++++++++++++++++++++------------
 fs/btrfs/subpage.c   |  48 ++++++++---
 3 files changed, 234 insertions(+), 81 deletions(-)

-- 
2.47.1


