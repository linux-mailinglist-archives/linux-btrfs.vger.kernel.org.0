Return-Path: <linux-btrfs+bounces-13552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE87AA4E41
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504331C20213
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D2101E6;
	Wed, 30 Apr 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FyKem6JO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FyKem6JO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78E25EF80
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022598; cv=none; b=FTIh11oV25SIxOuoTaGX62/cTadVsJuZPWM1oWJ1RBonwvUZfv6M8xLiPPHtWTmNcOtvXyMQBRJb1tlh4SfGA608PeMzjNuxcsYe+1y0lvH+UYcnGTE6lpLmkgf+17sylkgY8j6SUa+RwkHcmeojFLcZzCjLaHqJuIVVf9R0KKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022598; c=relaxed/simple;
	bh=L4oureru/QhsHpZCf8GL8h8WuWk0kxwj123Xi75Vk5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsxL3XO3XGrln60prnjSpZ4iUOsmqMC5YAlWavYn+qMy+J1dbpeyXIJL1ngkIizvGcREzzXQ7Jf00BoulzcIBqIAucTH/uPh7/oT0h0sDHd2xPdpmYtfe24LrCwcEeudC+Hw2f14NqPNNLCMuUArQt5SuIbqXM10aEKr9R5QP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FyKem6JO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FyKem6JO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BB5A1F7BD;
	Wed, 30 Apr 2025 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746022594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R0zyn1/q5qglad2th0J0BUpdc9+TDlLDZ3IhM/d9DJ8=;
	b=FyKem6JOFYu6XylaOlx41X4CgQUdnb7DVk515+p4G1A5iybiUEd8KKBOyw/YVk/vp8w1kM
	TtldbNMlF1x7fvH6/e8X0HMebWENwTN9qP2ZDRt6rQ4yzf6IzYXranxuK6m+5rAMpWCYX/
	7V9QNgUAr7hD7Lb9JrqG2VaFb3OI5yY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746022594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R0zyn1/q5qglad2th0J0BUpdc9+TDlLDZ3IhM/d9DJ8=;
	b=FyKem6JOFYu6XylaOlx41X4CgQUdnb7DVk515+p4G1A5iybiUEd8KKBOyw/YVk/vp8w1kM
	TtldbNMlF1x7fvH6/e8X0HMebWENwTN9qP2ZDRt6rQ4yzf6IzYXranxuK6m+5rAMpWCYX/
	7V9QNgUAr7hD7Lb9JrqG2VaFb3OI5yY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63B23139E7;
	Wed, 30 Apr 2025 14:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XINUGMIwEmjyBgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 30 Apr 2025 14:16:34 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.15-rc5
Date: Wed, 30 Apr 2025 16:16:30 +0200
Message-ID: <cover.1746021929.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
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
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull a few short fixes, thanks.

- fix potential inode leak in iget() after memory allocation failure

- in subpage mode, fix extent buffer bitmap iteration when writing
  out dirty sectors

- fix range calculation when falling back to COW for a NOCOW file

----------------------------------------------------------------
The following changes since commit 866bafae59ecffcf1840d846cd79740be29f21d6:

  btrfs: zoned: skip reporting zone for new block group (2025-04-17 11:57:25 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc4-tag

for you to fetch changes up to e08e49d986f82c30f42ad0ed43ebbede1e1e3739:

  btrfs: adjust subpage bit start based on sectorsize (2025-04-23 08:42:10 +0200)

----------------------------------------------------------------
Dave Chen (1):
      btrfs: fix COW handling in run_delalloc_nocow()

Josef Bacik (1):
      btrfs: adjust subpage bit start based on sectorsize

Penglei Jiang (1):
      btrfs: fix the inode leak in btrfs_iget()

 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/inode.c     | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

