Return-Path: <linux-btrfs+bounces-19849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2691CCCA43C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 05:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8000D300F9CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E459225417;
	Thu, 18 Dec 2025 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ngXITJMn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ngXITJMn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3E1DDF3
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766033152; cv=none; b=E8KpE7yHSXefxZ3izw6e96eswY9f6K2KsSZ0kEjC7LHGCU/UgiSzD1/9rcpbCPXEQcDy0jfviyIy0MOkgixBw9HL0+D11QqgQm47biqmarjq+07udVI1AZfr8z6XIFALbf8com2T2VcuERo2lDiyPJcTn2Q6tvwZk8drFsnLvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766033152; c=relaxed/simple;
	bh=HfG127kwzIkXgda10Q5zrMuDnL9MuR6NRHIck0cfo/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LVvKielHXtvNvwLibS8jLoQnew1XNupNjzLbs4FIybTU0lgPu2gKO1eIsnUnO1DMpIF5lYbcsDwlBWxy+V/t0uFoxia6K2uxouojpIm04G5/acZmQyPEQ2+d1bv9EruasCwBD6MJBxk0iXLDXVEeOlaoWx48tJ9wYEk65aIOkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ngXITJMn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ngXITJMn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9CDA33694
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766033147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bhBQfY2fCH74daVFL0szsU0xpRi0/NcDtMzjL0v6IuQ=;
	b=ngXITJMnLD9X9dB7BpcBkQSqoy21tYTkfkwTWmwGA8U1UMHTteqwAqmU2Sq2yZWKZYeo/I
	vRHnf/zTo9MsEaMAFKUnEAwY7mvdF83f+eN6BCYCJRctuLh54aqcL4E1fJS7HzHYUGF7gz
	Dw66Y4IaaelYCnlTcvg9TkXW1hJfC9Q=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766033147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bhBQfY2fCH74daVFL0szsU0xpRi0/NcDtMzjL0v6IuQ=;
	b=ngXITJMnLD9X9dB7BpcBkQSqoy21tYTkfkwTWmwGA8U1UMHTteqwAqmU2Sq2yZWKZYeo/I
	vRHnf/zTo9MsEaMAFKUnEAwY7mvdF83f+eN6BCYCJRctuLh54aqcL4E1fJS7HzHYUGF7gz
	Dw66Y4IaaelYCnlTcvg9TkXW1hJfC9Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F9B13EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ms9MMPqGQ2kYBgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: minor bs != ps cases fixes for free space tree enforcing
Date: Thu, 18 Dec 2025 15:15:27 +1030
Message-ID: <cover.1766032843.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.35
X-Spam-Level: 
X-Spamd-Result: default: False [-0.35 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.25)[0.750];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]

I'm update btrfs/131 to remove the v1 cache usage since v1 cache is
already marked deprecated.

With that update, I can run the test on bs < ps and bs > ps cases, the
formal failed due to the following reason:

- Free space cache is always enforced for bs < ps case
  Even if 'nospace_cache' mount option is provided.
  This is fixed by the first patch

And during tests I also exposed a minor problem for bs > ps cases:

- v1 cache mount is rejected for bs > ps cases
  That's because we lack the automatic free space tree enforcing for
  bs > ps cases.
  This is fixed by the second patch.

Qu Wenruo (2):
  btrfs: only enforce free space tree if v1 cache is required for bs <
    ps cases
  btrfs: forcing free space tree for bs > ps cases

 fs/btrfs/super.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
2.52.0


