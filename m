Return-Path: <linux-btrfs+bounces-8211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC647984F5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 02:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF63B22DB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 00:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA82CA6;
	Wed, 25 Sep 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PahCwl9x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PahCwl9x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10C1862
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223241; cv=none; b=guVq36dLtdV0DxeppofVdOhdPTtkKb0c966PMHuTgJdJUlDh8Y3og/lOxsk9UWolItmeeMB7am6eVU6N2U++bi7CE4RZhokfC3Au2WpAbvTN4XraELwUt5h7aplaxi6Eq3QjBJ0wJooe1r+YThr5MYawYQA5E9/LCJpXj8j2GgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223241; c=relaxed/simple;
	bh=DEswMJrPFV4Gp/az4xU4vkwAAnIy+4kp1hh4sJZrRWA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gZjqYBNyzcAAZ3cxVYNlqzYR7eddddEF6pbdlvSpMmO9G1mRy+qTP6aqhty7YzZrUo2p1OtdYjkv3+79C3FIU9vLvvFOak9TwM9b8yldXLjYqsz2soXxPHYPge83/kPmZEzwWMWl+CHFwsvxFAYqjPLHArmTWFLCQfF7LTmXfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PahCwl9x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PahCwl9x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9DA21F7E0
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 00:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727222778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dqfOQ/gCSB39/jZIFJPRWoQpce1jWhgTyEvfjbQRd2c=;
	b=PahCwl9xSBkFtTIuWuWWT9IqxHH4PCUG6d5rz4OHoDjDFxwu6Hqgc92yHafwQ91sapb0zJ
	b9+L0pDXYrT4fOpoag9ohJjUJx7Bo0/tvY8Yj/MZ4LuY5JyoTuTVaksIjw5ZS6I8I+c4jp
	w3tTczVydK8Im21Mvx+PgfOSnrGdxD8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727222778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dqfOQ/gCSB39/jZIFJPRWoQpce1jWhgTyEvfjbQRd2c=;
	b=PahCwl9xSBkFtTIuWuWWT9IqxHH4PCUG6d5rz4OHoDjDFxwu6Hqgc92yHafwQ91sapb0zJ
	b9+L0pDXYrT4fOpoag9ohJjUJx7Bo0/tvY8Yj/MZ4LuY5JyoTuTVaksIjw5ZS6I8I+c4jp
	w3tTczVydK8Im21Mvx+PgfOSnrGdxD8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B62A13A66
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 00:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BOlQL/lT82a1AgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 00:06:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: enhance btrfs device path rename
Date: Wed, 25 Sep 2024 09:35:58 +0930
Message-ID: <cover.1727222308.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Update the example of the first patch
  Instead of using the special C program, just touch the soft link
  to trigger the rescan.

- Add Link and reported-by tags for the first patch

- Fix a "weird" -> "wild" typo
  This is really weird...

- Remove the debugging pr_info()

- Use safer strscpy() to replace strncpy()

- Use the shortcut version of conditional operator when possible

Fabian Vogt reported a very interesting case where we can use
"/proc/self/fd/3" to mount a btrfs, then that /proc name will remain as
the device path for the btrfs.

Sometimes udev scan can trigger a rename, and get a proper name back,
but if that doesn't win the race, we got the "/proc/self/fd/3" in the
mtab which makes no sense, since "/proc/self" is bounded to the current
process, no one is going to know where the real device is.

So to enhance the handling:

- Do proper path comparison to determine if we want to update device
  path
  Currently the path comparison is done by strcmp(), which will never
  handle different hard nor soft links.

  Instead go with path_equal() on the resolved paths, which is way more
  reliable.
  This should reduce the unnecessary path name updates in the first
  place.

- Canonicalize the device path if it's not inside "/dev/"
  If we pass a soft link which is not inside "/dev/", we just follow the
  soft link and use the final destination instead.

  It can be something like "/dev/dm-2", other than more readable LVM
  names like "/dev/test/scratch1", but it's still way better than
  "/proc/self/fd/3".

  If the soft link itself is already inside "/dev/", then we can
  directly use the path.

  This is to allow fstest run properly without forced to use
  "/dev/dm-*" instead of the "/dev/mapper/test-scratch1" as test
  devices.
  Otherwise fs tests will reject runs because it believe the btrfs
  is mounted somewhere else.

Qu Wenruo (2):
  btrfs: avoid unnecessary device path update for the same device
  btrfs: canonicalize the device path before adding it

 fs/btrfs/volumes.c | 107 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

-- 
2.46.1


