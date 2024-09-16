Return-Path: <linux-btrfs+bounces-8043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBE8979DD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 11:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6B31F2408F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4713BC1E;
	Mon, 16 Sep 2024 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pj6bJzzN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jx34kRQa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA9130499
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477556; cv=none; b=N14hhzlrmn6NEuBh+0esGeloC0UICQOZJvZOw8ezA2IM8JAkRNkzYMWjn3d/ZWIldoKPLQAfFdl7+XLJqFFmaueYXtRaYhl3cPW/F1FPCzgbk2mF+4SSGQr4sh2+NFpIc266iUw/8hnYxMkLHLdHLhV28/qt4rIEyoSRv2bwu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477556; c=relaxed/simple;
	bh=sefn6udt6+Fi+Ey/arOdHhIP5EV8+YGJpnIe+Jt7q2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X3HCdWwQ6kCERtHS9Edtyf6JQA/DDrm7VtN/e4N56IweKPh9LcapGlQhIkd0ELWmwgWXWSrTchEZHPVT9aVQVm62Rl45oP2smCVKB8Mrg3z2XXXshRmc8hfwITOggiAUBvLCMQge4TDK7xnBYCwME1ERdTkBngbIUYKqAcAhQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pj6bJzzN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jx34kRQa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 956511FD56
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726477552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tnDnaa23emcIVn6iXID012NyktMiszyyujZya9fSDQ8=;
	b=Pj6bJzzNDxPYXmozxDVatQOufZ2RewLAcKCSWQD3mHaXizz/eCJ/RB3rvkQsrVSv5pISie
	PrH8F8ZuQnmrvpzbfW21dPFFFD0OfY9YV0TWucfsFpQXvrpfjn+GghGM7IfD4VjyICl3e4
	xLW4T6fEemSIaXxtKYytCynsKvK0a6I=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726477551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tnDnaa23emcIVn6iXID012NyktMiszyyujZya9fSDQ8=;
	b=jx34kRQaLZrrAIk3XU8J5cf1xvpLwQ93wi2qrTxqxMMFKRIlqxsgUlmsVsKYD9Q91ZHhiJ
	aX2yc/7qHKnuAKsRGY5RDatOOCtbtP9qr5u9c/OZJL0oXAUibay4AbOEWZkB7z7QKoKyKQ
	laGUHQJYZXRrncbeKJljJJG0fmJTwJw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6A11139CE
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NIgyJu7052bTSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CONFIG_BTRFS_DEBUG
Date: Mon, 16 Sep 2024 18:35:27 +0930
Message-ID: <cover.1726477365.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Level: 

The first patch is to make it more consistent for assert_rbio() to
follow the CONFIG_BTRFS_ASSERT.

Then the second patch split out the following features into the new
CONFIG_BTRFS_EXPERIMENTAL:

- Extent map shrinker
- Extent tree v2
- Raid stripe tree
- Csum offload mode
- Send string v3

This is mostly to make those features to get more attention, and
eventually to move into stable features.

So far I think csum offload mode and extent map shrinker are strong
candidates, and later sector perfect compression will also join the
experimental features.

Qu Wenruo (2):
  btrfs: make assert_rbio() to only check CONFIG_BTRFS_DEBUG
  btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CONFIG_BTRFS_DEBUG

 fs/btrfs/Kconfig   | 9 +++++++++
 fs/btrfs/bio.c     | 2 +-
 fs/btrfs/fs.h      | 4 ++--
 fs/btrfs/raid56.c  | 3 +--
 fs/btrfs/send.h    | 2 +-
 fs/btrfs/super.c   | 6 +++---
 fs/btrfs/sysfs.c   | 4 ++--
 fs/btrfs/volumes.h | 4 ++--
 8 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.46.0


