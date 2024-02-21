Return-Path: <linux-btrfs+bounces-2605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFD185D6D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 12:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFCF1C20FA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1F3FE4F;
	Wed, 21 Feb 2024 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qE291asU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qE291asU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4628363;
	Wed, 21 Feb 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514882; cv=none; b=QkpnZ6gYe7Y6ega28oKVrlyRdGQ3f0oHFEH82oOJcmGICgQFfKVG2wZQRcW/DHbp0fxMmiTxf/pMHxC768qmNIynmJDuT/skO9FnBNlwRC6S6pdNyz49ADSAhPQWK6RSg3OL5pKHb3KKxGcR/ZFzn+vIAB2/VG4XdzuKsjjclP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514882; c=relaxed/simple;
	bh=BywlEbsucmqy+5m46i5CilD67EK5HGN4QAUcU1Vfp8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FedCdLM9bmNKBqDfGRre09LFz21QKoZ6B43kfsLXLZdBeh4N8tF8wk24Uj2uZdzr8AYmgK9lKH6QbgF82kVDFxzNDSz862lkrcoNoBFY9PMTH3btAYBRJA73kKfpCwq9rsFqZA4xNaEn6K1Eo76BRC5eUkcPhCPsYIDJl9QEQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qE291asU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qE291asU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79DB222233;
	Wed, 21 Feb 2024 11:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708514877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W2GrXRFuiX2ZYgdL4b+iEFBGei99fMVQAa677s2gmcs=;
	b=qE291asUgT9nbMqFwKe/WeAbY+ZO8OzzyZrlxxACQwNb+T5XND4W/mK5MLBWeFtUhvlQle
	djeCIkkRgNJGnszRawPoW6g76KJNa1qDCBwoWr96QU+rD7KTBE1zTzvK7oyAuxWfSHT/6e
	/4Z1B4hnhqL01Jeu+wBGS0I7k/rGWdU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708514877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W2GrXRFuiX2ZYgdL4b+iEFBGei99fMVQAa677s2gmcs=;
	b=qE291asUgT9nbMqFwKe/WeAbY+ZO8OzzyZrlxxACQwNb+T5XND4W/mK5MLBWeFtUhvlQle
	djeCIkkRgNJGnszRawPoW6g76KJNa1qDCBwoWr96QU+rD7KTBE1zTzvK7oyAuxWfSHT/6e
	/4Z1B4hnhqL01Jeu+wBGS0I7k/rGWdU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7369713A25;
	Wed, 21 Feb 2024 11:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zk0oHD3e1WUWIwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 21 Feb 2024 11:27:57 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.8-rc6
Date: Wed, 21 Feb 2024 12:27:15 +0100
Message-ID: <cover.1708514684.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Hi,

two more fixes. Please pull, thanks.

- fix a deadlock in fiemap, there was a big lock around the whole operation
  that can interfere with a page fault and mkwrite, reducing the lock
  scope can also speed up fiemap

- fix range condition for extent defragmentation which could lead to worse
  layout in some cases

----------------------------------------------------------------
The following changes since commit 2f6397e448e689adf57e6788c90f913abd7e1af8:

  btrfs: don't refill whole delayed refs block reserve when starting transaction (2024-02-13 18:39:09 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc5-tag

for you to fetch changes up to b0ad381fa7690244802aed119b478b4bdafc31dd:

  btrfs: fix deadlock with fiemap and extent locking (2024-02-19 11:20:00 +0100)

----------------------------------------------------------------
Josef Bacik (1):
      btrfs: fix deadlock with fiemap and extent locking

Qu Wenruo (1):
      btrfs: defrag: avoid unnecessary defrag caused by incorrect extent size

 fs/btrfs/defrag.c    |  2 +-
 fs/btrfs/extent_io.c | 62 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 46 insertions(+), 18 deletions(-)

