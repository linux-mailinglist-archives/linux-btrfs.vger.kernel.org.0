Return-Path: <linux-btrfs+bounces-5731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FB9082E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 06:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF19E283394
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 04:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0530D144D12;
	Fri, 14 Jun 2024 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F5Ry+L+9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F5Ry+L+9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A026AD7
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 04:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338964; cv=none; b=r6VYDaODkQRujUQKuHo4DdBUE7g6ov83ay6o6fDEaY+wxdF7Boj7ZkazoaxCtdAtgX878AvYOTlNX66NUlahJA6RPFBFCYnIuB771qgVMqiUndQRqga37FCVfeAZnlMsHQXYlMkJUP74mLFwkm9R30jSZQI/RVTzfDTn2Fd7SOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338964; c=relaxed/simple;
	bh=ygCzxKA5aYvhpMbQxOvcGgvxNq15V8L86f07vt7Kl2Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pw9oMwkF/9F8/EyJSPi4qBolTxf9hLovKuHJ8hqKKBDvl+lRdSLjCIGqlxDdEOJu2OXPPBsu6dmCC6bjPqHemq/t7JEllkTo/o51mS5n1Rr+WgyQt9Yj1xu4Eg6t+gGkywYdWunWEzWGVrOXzmB8NmPlcrn7jzEZi4tg2Nc2qrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F5Ry+L+9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F5Ry+L+9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 011021FFD9
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 04:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2X18KzmufxnEyi1vpHavE75eDjFkP/Ywdv4s0Tpramw=;
	b=F5Ry+L+9ON/ksvcyny367XF63fxMEdUdeyYPXas/Grow262g638y5ezTuIdjJzqofJMEIf
	D9x1VBXtroFYQLugYjGUT5lyiUr5XQ6wci42xgqtL8eXpRLK0bdLhpGLlHk8O/vwsp1aTy
	EZDkOLVlld9M6scQFEqRwtlrFVdXQR8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=F5Ry+L+9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2X18KzmufxnEyi1vpHavE75eDjFkP/Ywdv4s0Tpramw=;
	b=F5Ry+L+9ON/ksvcyny367XF63fxMEdUdeyYPXas/Grow262g638y5ezTuIdjJzqofJMEIf
	D9x1VBXtroFYQLugYjGUT5lyiUr5XQ6wci42xgqtL8eXpRLK0bdLhpGLlHk8O/vwsp1aTy
	EZDkOLVlld9M6scQFEqRwtlrFVdXQR8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15DF913AAD
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 04:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BAb1Lo7Fa2YBJQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 04:22:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: rescue= mount options enhancement to support interrupted csum conversion
Date: Fri, 14 Jun 2024 13:52:27 +0930
Message-ID: <cover.1718338860.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 011021FFD9
X-Spam-Score: -5.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

[CHANGELOG]
v2:
- Add the new rescue options to supported rescue options sysfs interface
- Add the state char 'S' for skipping metadata csum
- Add an info line of unsupported super flags if rescue=ignoresuperflags
  is specified
- Add const prefix for one-time btrfs_test_opt() result

[REPO]
https://github.com/adam900710/linux/tree/rescue_changes

[BACKGROUND]
There is an adventurous user using btrfstune to convert a 32T btrfs
from crc32c to xxhash.

However for such huge fs, it takes too long time and the reporter
canceled the conversion.

This makes the reporter unable to mount the fs at all.

[CAUSE]
First of all, for a half converted fs, we will never allow RW mount, so
everything must be done in rescue mode.

There are several different stages of csum conversion, and at different
stage it requires different handling from kernel:

- Generationg new data csums
  At this stage only the super flags (CHANGING_DATA_CSUM flag) is
  preventing the kernel from mounting.

  Intrdoce "rescue=ignoresuperflags" to address this.

- Deleting old data cums
  The same super flags problem, with possible missing data csums.

  Despite the new "rescue=ignoresuperflags", end users will also need
  the existing "rescue=ignoredatacsums" mount option.

- Renaming the objectid of new data cums
  The new csums' objectid will be changed to the regular one.

  During this we can hit data csum mismatch.
  So the same "rescue=ignoresuperflags:ignoredatacsums" can handle it
  already.

- Rewriting metadata csums
  This part is done in-place (no COW), with a new super flags
  (CHANGING_META_CSUM).

  So here introduce a new "rescue=ignoremetacsums" to ignore the
  metadata checksum verification (and rely on the remaining sanity
  checks like tree-checkers).

The first 2 patches are just small cleanups, meanwhile the last two are
the new "rescue=" mount options to handle interrupted csum change.

Qu Wenruo (4):
  btrfs: remove unused Opt enums
  btrfs: output the unrecognized super flags as hex
  btrfs: introduce new "rescue=ignoremetacsums" mount option
  btrfs: introduce new "rescue=ignoresuperflags" mount option

 fs/btrfs/bio.c       |  2 +-
 fs/btrfs/disk-io.c   | 35 +++++++++++++++++++++++++----------
 fs/btrfs/file-item.c |  2 +-
 fs/btrfs/fs.h        |  5 ++++-
 fs/btrfs/messages.c  |  3 ++-
 fs/btrfs/super.c     | 27 +++++++++++++++++++++++----
 fs/btrfs/sysfs.c     |  2 ++
 fs/btrfs/zoned.c     |  2 +-
 8 files changed, 59 insertions(+), 19 deletions(-)

-- 
2.45.2


