Return-Path: <linux-btrfs+bounces-8318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE46989907
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 03:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941571F21AEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 01:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD4C2E9;
	Mon, 30 Sep 2024 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o3NPF4ZY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o3NPF4ZY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52606566A
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727661054; cv=none; b=tyieBrt8iwgpKgAgR70pax6LzTJTPee+ey2q4CwOTuOcCDninitbRpDEQTvmvIX4pIHpnDRlaURRyqXOLIQd0c0RMpxXGY7IndocKRF12YbZ85NucY828oi79dMev2k+Ya+Ul4NxRT0IDDLX1JvNi6+ohAJmO7GHpm+rLQY/7qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727661054; c=relaxed/simple;
	bh=97mqJl9tdIi4qyXXJRQkmU5zRkcJ8KiB+3YQchLlsGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X583HaoYJkrsUoi3StaP0QEcsBugf0EFiRcfJ48dGdDzXAkUL8wPtybGyzVEJLJ6fPfUrxbGUw0TQ9YI3HXvk1tc/ku8Tp3gXc5vCMHAnH0lmXQB3qP8kiZAqeGh06j0swSQ3V7q1Y8pGseSTPXT7tnOW1yu+9tSMgNOgaWVLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o3NPF4ZY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o3NPF4ZY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F7C81F7E5
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727661049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2XYn1uIQNJy037FKGGj7joRNTF/A531WJFGuN1De4lI=;
	b=o3NPF4ZYtX8kiMviehsmbonhU3VV+C5adcYJehMFxEWc4wQlbfDonLTwPORnSAe/MdPqZC
	4gYwPhonxnkGE/spTqoHD7vXzLCAWYk58NLwZBgD+wzgd7j4nkup4Zo5POLj2LYh3uclXi
	qIjKxT0BWvucJ3MERUqiFXNQxxCUbUE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727661049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2XYn1uIQNJy037FKGGj7joRNTF/A531WJFGuN1De4lI=;
	b=o3NPF4ZYtX8kiMviehsmbonhU3VV+C5adcYJehMFxEWc4wQlbfDonLTwPORnSAe/MdPqZC
	4gYwPhonxnkGE/spTqoHD7vXzLCAWYk58NLwZBgD+wzgd7j4nkup4Zo5POLj2LYh3uclXi
	qIjKxT0BWvucJ3MERUqiFXNQxxCUbUE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BE6013318
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M9aiD/gD+mZvLgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: small cleanups to buffered write path
Date: Mon, 30 Sep 2024 11:20:28 +0930
Message-ID: <cover.1727660754.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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

These two are small cleanups to the buffered write path, inspired by the
test btrfs failure of generic/563 with 4K sector size and 64K page size.

The root cause of that failure is, btrfs can't avoid full page read when
the dirty range covers sectors, but not yet the full page.

This is only the preparation part, we can not yet switch to the skip the
full page read, or it will still lead to incorrect data.

The full fix needs extra co-operation between the subpage read and
write, until then prepare_uptodate_page() still needs to read the full
page.

Qu Wenruo (2):
  btrfs: remove the dirty_page local variable
  btrfs: simplify the page uptodate preparation for prepare_pages()

 fs/btrfs/file.c             | 87 +++++++++++++++++++------------------
 fs/btrfs/file.h             |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 3 files changed, 46 insertions(+), 45 deletions(-)

-- 
2.46.1


