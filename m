Return-Path: <linux-btrfs+bounces-9673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE209C9439
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 22:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DD21F23037
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 21:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC851AF0AC;
	Thu, 14 Nov 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eorneKZ0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eorneKZ0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDBD2905;
	Thu, 14 Nov 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619344; cv=none; b=uU/i75i+lzsIDQUlYBb2EiNNUrKgTGF4iLsnTLao0nEt7Bx99EGt1uiZGZMyzjH1sL73KicS+ZO1t866LZzkjJjiSfXZEcCI4Jy0IiwNhrx5Sq4y3oT4YEic4tI/BR47+NN4J8MjDYaySi+XEJL3jqu9MSGbpC4lKc/b8f+n+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619344; c=relaxed/simple;
	bh=XCENbKrDfm/widL02i/vkrSPfF4JfIhdiWoAwb8DTuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEPHjg1hczL1He/mxTuZRTZaMkKZpzv0YDAEPK61BCAUCbu6BSakwiCW/um1XFu3LHTIPZ2oHwWmGHvcvIWJNQjI2gNxiyRyim2OAsQ+Kil6wUf4Ee0WW/vcye/iVgMgIBWpbXjZuLvyWSVQSLzb36gsVcCI4SP8META33QdPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eorneKZ0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eorneKZ0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4365A1F7C7;
	Thu, 14 Nov 2024 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731619339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rU0YHa2Jhh/LrcKUOrvPemYgVnp4+HPNG1kzn4LEzBI=;
	b=eorneKZ0VXlikKjijgLOA5CTiE213Gx8fn7+pC9OmUIPMHb2Ov1f+lF9l5BYvzsywwdaIK
	1mF3n4qiiShEK0Wp1h4dWgQdnSfBhUmdFbzS9M5cKHBdt5sinxa+r5IGB70ShMI7kMiAHS
	1nGWg85ec8YXC3LT8qiAJodonZk2oRU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eorneKZ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731619339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rU0YHa2Jhh/LrcKUOrvPemYgVnp4+HPNG1kzn4LEzBI=;
	b=eorneKZ0VXlikKjijgLOA5CTiE213Gx8fn7+pC9OmUIPMHb2Ov1f+lF9l5BYvzsywwdaIK
	1mF3n4qiiShEK0Wp1h4dWgQdnSfBhUmdFbzS9M5cKHBdt5sinxa+r5IGB70ShMI7kMiAHS
	1nGWg85ec8YXC3LT8qiAJodonZk2oRU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BAD213794;
	Thu, 14 Nov 2024 21:22:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a4SHDgtqNmdddgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 14 Nov 2024 21:22:19 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.12-rc8
Date: Thu, 14 Nov 2024 22:22:10 +0100
Message-ID: <cover.1731619157.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4365A1F7C7
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

one more fix that seems urgent and good to have in 6.12 final. It could
potentially lead to unexpected transaction aborts, due to wrong
comparison and order of processing of delayed refs.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 2b084d8205949dd804e279df8e68531da78be1e8:

  btrfs: fix the length of reserved qgroup to free (2024-11-07 02:08:29 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc7-tag

for you to fetch changes up to 7d493a5ecc26f861421af6e64427d5f697ddd395:

  btrfs: fix incorrect comparison for delayed refs (2024-11-14 16:11:02 +0100)

----------------------------------------------------------------
Josef Bacik (1):
      btrfs: fix incorrect comparison for delayed refs

 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

