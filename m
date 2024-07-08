Return-Path: <linux-btrfs+bounces-6272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB910929B73
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 07:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AC81F215ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 05:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25499B665;
	Mon,  8 Jul 2024 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Esz0MQw/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Esz0MQw/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D214A85
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720415685; cv=none; b=Meux1VXh+eJNfWcw4puu5yJEA3M4nVwCrjT5Fr+565TIUbdFGAHo/ePOKc8Up/WU72RRk9PMEWhY6s5llVA1ZcGsMAk2H7p9V+JSRhbxavaNiAI0d6rQuxh98+J4JkQvLvpWfDTlQD8FLFzOkW0ldOKMyZjDTBfJQCl3Jv3zJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720415685; c=relaxed/simple;
	bh=3RYDKCiDq83zLPWNkiJkE8znWU6pjNwM1R9J/GFKyF8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+3Zph+NPX0psS3FgeqUd5M97Xr/UjdT3ZI85qHDH3RqKufuBdJ9lWzttZTbNSsnuB3y2xNkIzZUHNHwm4W3P4sB5c6mpzcYsIdbAcY+L+P/Koy8X63krBXNDIgUA+ock4X/CuP9sD87WktB863i+qe30CLcoIBo7dYfHJEoTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Esz0MQw/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Esz0MQw/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32E381FBDD
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=63eI4mU5IGWZB2j9OoQpXy2sxya8pQnq2bKZ8BFHre4=;
	b=Esz0MQw/qJUE2b627Ela/e9TQbNa7Z7Mg2vDQ13MthLbKnryU5HXQsCWcnYx77jCrQyA54
	1bKkWeyPbR5EYSJkTiFoTjYxyf7Vxeoq9bCDAb6fhNbToPRPs6cX1Oj4vOzQw6sCNgT98q
	mclLSPM0+7NUICMmh/Kf2xm9cNU/7FY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Esz0MQw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=63eI4mU5IGWZB2j9OoQpXy2sxya8pQnq2bKZ8BFHre4=;
	b=Esz0MQw/qJUE2b627Ela/e9TQbNa7Z7Mg2vDQ13MthLbKnryU5HXQsCWcnYx77jCrQyA54
	1bKkWeyPbR5EYSJkTiFoTjYxyf7Vxeoq9bCDAb6fhNbToPRPs6cX1Oj4vOzQw6sCNgT98q
	mclLSPM0+7NUICMmh/Kf2xm9cNU/7FY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 520351396E
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XEvqAsB1i2YbZwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jul 2024 05:14:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: fix the filename sanitization of btrfs-image
Date: Mon,  8 Jul 2024 14:44:14 +0930
Message-ID: <cover.1720415116.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 32E381FBDD
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

There are several bugs in btrfs-image filename sanitization:

- Ensured kernel path resolution bug
  Since during path resolution btrfs uses hash to find the child inode,
  with garbage filled DIR_ITEMs, it's definitely unable to properly
  resolve the path.

  A warning is added to the man page by the first patch.

- Only the last item got properly sanitized
  All the remaining INODE_REF/DIR_INDEX/DIR_ITEM are not sanitized at
  all.

  This is fixed by the second patch.

- Sanitized filename contains non-ASCII chars
  This is fixed by the third patch.


Finally a new test case is introduced to verify the filename
sanitization behavior of btrfs-image.

Qu Wenruo (4):
  btrfs-progs: add warning for -s option of btrfs-image
  btrfs-progs: image: fix the bug that filename sanitization not working
  btrfs-progs: fix rand_range()
  btrfs-progs: misc-tests: add a test case for filename sanitization

 Documentation/btrfs-image.rst               | 17 ++++++-----
 common/utils.c                              | 10 +++----
 image/sanitize.c                            |  8 ++++-
 tests/misc-tests/065-image-filename/test.sh | 33 +++++++++++++++++++++
 4 files changed, 55 insertions(+), 13 deletions(-)
 create mode 100755 tests/misc-tests/065-image-filename/test.sh

--
2.45.2


