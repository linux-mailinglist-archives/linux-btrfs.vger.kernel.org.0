Return-Path: <linux-btrfs+bounces-21576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKRmHRWuimkKNAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21576-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 05:03:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14369116D3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 05:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 689DB3011BE0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53B6283C89;
	Tue, 10 Feb 2026 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tl1KnAxr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tl1KnAxr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C252F851
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770696201; cv=none; b=YhTQS63VB5na0iQsT4X+o88OyPyhb0yhwZT4lIL0uTjUqK0lpqQxXfLrEIBd8bddObi3jO5blR6V0owGgHJu9Wib8jHTo6erLchB1eX1nYnQyN1WUbzYv41S5cbRM/I+NKaiAch26sQkucalyhkZXKCvGZodL7fFjoAHzfIAf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770696201; c=relaxed/simple;
	bh=FQ/Y/zwFMQrKdWILi60cre6pRSa1hkBI0M02VHALPQE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=niG10ZRoNWUwxemgmOBOlEt+pSa9o1FyhyxLXT9SLIZwizPLJYigPXDdZF5SycquQrVj1LVbWEYekZbyjHOywP+2sNCa+CXXqCyl2VY65NdIrN/a//XbK8Of9kVKX6EK3Kc2q1FHhOL95GRtYMhD3X1Tl6YyipiFxwxq2Gh8Fc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tl1KnAxr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tl1KnAxr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28A3F3E70F
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770696198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+aW25BIgdZghjxftbbQOQMVUbTmnOw2KiNLW2sFTgLM=;
	b=tl1KnAxrZbDPt3ZNsVy/HR27S2eFc+1E7VqNbp6KwfwesPMxF8eueyklT+gQEyreV0VjT2
	CNJqmW0BmpQB3IUG/eURySwwWulHlDh5D+DSr5Y7CEb2k3p7c+MTvdMpC4oVV9IbuhD5Re
	j7r+pTa7IPN5S1RxHjlVCCUQybmpMlU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tl1KnAxr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770696198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+aW25BIgdZghjxftbbQOQMVUbTmnOw2KiNLW2sFTgLM=;
	b=tl1KnAxrZbDPt3ZNsVy/HR27S2eFc+1E7VqNbp6KwfwesPMxF8eueyklT+gQEyreV0VjT2
	CNJqmW0BmpQB3IUG/eURySwwWulHlDh5D+DSr5Y7CEb2k3p7c+MTvdMpC4oVV9IbuhD5Re
	j7r+pTa7IPN5S1RxHjlVCCUQybmpMlU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 128B53EA62
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /kqgKwSuimm/bwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH FOR v7.1 0/2] btrfs: move some features out of experimental
Date: Tue, 10 Feb 2026 14:32:56 +1030
Message-ID: <cover.1770695952.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21576-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 14369116D3B
X-Rspamd-Action: no action

The two features can be moved out of experimental in v7.1:

- Large data folios
  It's introduced in v6.17, but we still have a bug fix related for it
  in v6.19.
  If there is no new bug exposed I believe it's time to expose this
  feature to end users.

- Shutdown and remove_bdev callbacks
  It's introduced in v6.19, but there is no major known bug exposed yet.
  Furthermore the remove_bdev callback, aka auto-shutdown/degradation
  when a device is missing, can affect end users.

  Thus we want some feedbacks from early adopters.

Qu Wenruo (2):
  btrfs: move shutdown and remove_bdev callbacks out of experimental
    features
  btrfs: move larger data folios out of experimental features

 fs/btrfs/Kconfig       | 4 +---
 fs/btrfs/btrfs_inode.h | 2 --
 fs/btrfs/super.c       | 4 ----
 3 files changed, 1 insertion(+), 9 deletions(-)

-- 
2.52.0


