Return-Path: <linux-btrfs+bounces-7869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300D196E90B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 07:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98672B20C98
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 05:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4578120C;
	Fri,  6 Sep 2024 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="okitou+4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="okitou+4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38D182C3
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599820; cv=none; b=YIb4Ja9yfS9+rdnB8RJqAbKutiMQ+QrZjR5QNS1qzt4z1P9NtGHFBvT44IPb7BvuAtJqm0nN/etJrUX9C0JgtfWLY5OM8srsRDlEteJCgPhAqJBcvjUqSG6ck7azSnx2695/qDgD97p1mC55PsQGXduCR4IWctpqMQHdEmBKwL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599820; c=relaxed/simple;
	bh=f8nW35SEoWV1K831A9ZFfZ4zO3f7784dRARwx6RyqPs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DlnZBp2VhtlvXow8yA+aP/h2vw40lHr6i9GghQ7mcBcQUjtuqd6zzNbw4w2BdJA35eqhpRV/VDE4y3sm8C+ZvMt0nhKqL/TMWdAsX2jE5R3Qj9x2gu4BlpKnHsbJOpVxRYQMVkVEXcUqNMl0tZLz/JGbXPnAcKhsnCQiMhmhoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=okitou+4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=okitou+4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 379D22198A
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725599816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7mzryrt9IM6gOwV3GeOcOx5Z9CQHc9XWJ+Rn9QHT69w=;
	b=okitou+4sH5eiqQKSfbExZ0rMD16q97Ojmb/py+zqiZU+xj9iTiQsXEjq9djU90ehX6Uer
	CNsgdJS6BAVzVSxJ1ZJwAP9uGACgrV1PUpowQpjGw6auEIicepm1t/2I7rRXx5B9ONZ9LV
	+392GNFytzZgP3o0tyeYhCzCs1Yw3DI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725599816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7mzryrt9IM6gOwV3GeOcOx5Z9CQHc9XWJ+Rn9QHT69w=;
	b=okitou+4sH5eiqQKSfbExZ0rMD16q97Ojmb/py+zqiZU+xj9iTiQsXEjq9djU90ehX6Uer
	CNsgdJS6BAVzVSxJ1ZJwAP9uGACgrV1PUpowQpjGw6auEIicepm1t/2I7rRXx5B9ONZ9LV
	+392GNFytzZgP3o0tyeYhCzCs1Yw3DI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70AAF1395F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 29bODEeQ2ma6DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2024 05:16:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fixes for incoming sector perfect compression support
Date: Fri,  6 Sep 2024 14:46:19 +0930
Message-ID: <cover.1725599171.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Level: 

Currently if a btrfs is mount with sector size < page size (aka,
subpage), then compression is only limited to range that is fully page
aligned.

This is mostly caused by the asynchonously submission for compression.

With recent changes in the page writeback path, we're closer and closer
to the sector perfect compression support for subpage.

Locally I have already enabled such support to shake out the remaining
bugs.

So far 2 obvious bugs are exposed by my local fstests runs.
They all share the same cause, incorrect assumption that one page is one
sector, thus some pointer is always increased by PAGE_SIZE, which is not
correct.

Fix both of them with a single line fix, then add an ASSERT() to ensure
the total read-in bytes never exceed the input range.

There is a remaining hang reproduced by btrfs/062, which I'm still
debugging, but I think sector perfect compression support is not that far
away anymore.

Qu Wenruo (3):
  btrfs: zlib: make the compression path to handle sector size < page
    size
  btrfs: zstd: make the compression path to handle sector size < page
    size
  btrfs: compression: add an ASSERT() to ensure the read-in length is
    sane

 fs/btrfs/compression.c | 3 +++
 fs/btrfs/zlib.c        | 2 +-
 fs/btrfs/zstd.c        | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.46.0


