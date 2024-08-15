Return-Path: <linux-btrfs+bounces-7207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF495288E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 06:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42371C21BDF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 04:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181F3B182;
	Thu, 15 Aug 2024 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y2S0DByK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y2S0DByK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59C3BBC1
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696731; cv=none; b=oacv9Lv7vOIyOLDGzPSlfohWkcJdB9BPZZarsEfCn6GaB2BxbtKSSnSyeLkz0+pU4RR7rru7fBuK0dEZ+Tdj4FC3acI8hKO1Jf7X3bE396P7pj7hSMVfHMSMKNS25OeyYUCj3FMZOsbMAPS85OF7rgxpm3pL2qYRLFDxcjd1EHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696731; c=relaxed/simple;
	bh=ePw17upVsF86q4LV3kob83KFIhz3+QTKkbycx51kdms=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DhetNjDkbA+7OLI71Bga1fSQLJNGoHdEit803sOAfiMutGle9c9tSyW4cYqHxZdSnokH1beoQGoAGpNSjeSxU1FG0KOUgKDA/g12pAT68Jx5Qyq3F8W8IDvF1No36gHxxMLLjDbPnqinujnhcP2qShQr0hOPhxSUyx0ZsYar5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y2S0DByK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y2S0DByK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DB541FCFC
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723696725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=00Mc31/e1tQEgvwFw+IaJog+KzGnz0kK1Zz5DcUOvq4=;
	b=Y2S0DByKA/Xo1Ekno9LBahbwpiWzoh9PZsH04bXtBs+hd2Phe47jYPfCZhJmkp+kM+Rjqt
	VpJXD1i0vWhRe+K0tNiGBd8Bm2ETHo2s5nnYGE7TMyBwP+60DREw0rJ7nBJW47hL/fCTQC
	ADoZVV8531RnmyFLL22cPIayVkUgvFk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Y2S0DByK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723696725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=00Mc31/e1tQEgvwFw+IaJog+KzGnz0kK1Zz5DcUOvq4=;
	b=Y2S0DByKA/Xo1Ekno9LBahbwpiWzoh9PZsH04bXtBs+hd2Phe47jYPfCZhJmkp+kM+Rjqt
	VpJXD1i0vWhRe+K0tNiGBd8Bm2ETHo2s5nnYGE7TMyBwP+60DREw0rJ7nBJW47hL/fCTQC
	ADoZVV8531RnmyFLL22cPIayVkUgvFk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A372913983
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0s6TF1SGvWaoPgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: mkfs/rootdir: add hard link support
Date: Thu, 15 Aug 2024 14:08:16 +0930
Message-ID: <cover.1723696468.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 7DB541FCFC
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Score: -5.01

With the recently reworked --rootdir support, although it solves several
hard link related problems, it splits the hard links into new inodes.

And on each split, it shows a warning on each file with hardlinks.

Although the split behavior doesn't cause any data corruption, it can
still be pretty noisy for rootfs creation, as there are a lot of distros
storing timezone files as hardlinks.

This patchset adds back the hard link detection and creation, with
enhanced handling to co-operate with --subvol option.

The details can be found in the first patch, with the new corner case
introduced by --subvol option.

The second patch enhances the existing --rootdir and --subvol test case
with extra corner cases like hard links, and hard links split by
subvolume boundary.

Qu Wenruo (2):
  btrfs-progs: mkfs/rootdir: add hard link support
  btrfs-progs: mkfs-tests: add hardlink related tests for --subvol

 Documentation/mkfs.btrfs.rst                |  13 ++
 mkfs/rootdir.c                              | 196 +++++++++++++++++---
 tests/mkfs-tests/036-rootdir-subvol/test.sh |  78 ++++++--
 3 files changed, 244 insertions(+), 43 deletions(-)

--
2.46.0


