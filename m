Return-Path: <linux-btrfs+bounces-9678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA139CD6CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 07:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D1B222A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B55D16F8F5;
	Fri, 15 Nov 2024 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SKhH6US+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SKhH6US+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14C36C
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650647; cv=none; b=rV/ve0W24KtBVlmo4ZsdZsOOsnEkVIooKKimTy6fs2K3mN+b77oIrdzKvTF+3eFm+OQ65a4wbhJ1wrYkIzgk636yy1zmDnW4QrjReRMQ7K+c42Y2U2fOSDBydtuPvbRxQ4fNDDY+S4n+M0wZ6liIW1lDOCbY2ic9JeJeWMQzF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650647; c=relaxed/simple;
	bh=12ybO6Ht9py0CTCiL/lsj5tYXtlJbqABf5V4SrPvyOI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RR63sEYgkx2IhZ2t0WdPeN4XCmvubyFlVswY2Y6a0BtBM98ezSvYxblXa6xIeNqYRSpe7YJFWq5muYH/BiLiS17eqD+x361F/51MRRO7HqDlxsp1ufqPXqogEy/DnY6ywAsEeSUkN58823S041y/fWOLBR+F4euZNpOTQW+xdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SKhH6US+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SKhH6US+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45EB11F7C7
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731650643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cC2zfKpfcu3E5M1mJCXriOQ2SBywvBN3an9599CaKC0=;
	b=SKhH6US+7wO6TdqFmaS+2b2+cb49cAGlGr3wNHFcN1uovL7/1hdHJ2sgZiOsj8RXbc+Rhm
	nQVIYWa4UQ0ns05MMbVxK25+cSm1bwFVtYMa2ErDEg0Xb45Tjk7Iihiju+bnQCVUVITrzm
	euvP5y5aZFuFIMDnvJlZuv5edyMQkOk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731650643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cC2zfKpfcu3E5M1mJCXriOQ2SBywvBN3an9599CaKC0=;
	b=SKhH6US+7wO6TdqFmaS+2b2+cb49cAGlGr3wNHFcN1uovL7/1hdHJ2sgZiOsj8RXbc+Rhm
	nQVIYWa4UQ0ns05MMbVxK25+cSm1bwFVtYMa2ErDEg0Xb45Tjk7Iihiju+bnQCVUVITrzm
	euvP5y5aZFuFIMDnvJlZuv5edyMQkOk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 650C6134B8
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g8aDCFLkNmdQBgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:04:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: allow creating inline data extents for sector size < page size case
Date: Fri, 15 Nov 2024 16:33:42 +1030
Message-ID: <cover.1731650263.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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

There are two features disabled when sector size < page size (subpage) is
allowed for btrfs:

- Inline data extent creation
- Sector perfect compressed write

Both share one critical technical problem, that inline or async
submission all unlock the whole page.

Thankfully the major technical blockage is already solved with the
recent sector perfect compressed write support for subpage cases.

So there is no need to disable inline data extent creation either.
Yes, there are cases we can mixing inline and regular data extents, but
that's also the case when page size == sector size, so it's not a show
stopper.

The first patch is to fix a harmless bug that is only affecting subpage
cases.
The second one enables the inline data extent creation for subpage
cases.

Qu Wenruo (2):
  btrfs: fix the qgroup data free range for inline data extents
  btrfs: allow inline data extents creation if sector size < page size

 fs/btrfs/inode.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

-- 
2.47.0


