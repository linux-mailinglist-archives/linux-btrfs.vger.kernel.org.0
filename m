Return-Path: <linux-btrfs+bounces-22044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHT1MrsQoWlDqAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22044-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 04:34:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A491B2498
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 04:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 376AB306AECC
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 03:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22A33030C;
	Fri, 27 Feb 2026 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fW2AZwi6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fW2AZwi6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037D32FA2D
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163257; cv=none; b=ULpUFG80zJfZUhP+GAF2fzH2oWruVba0VBqOYjzmX2V8AMULSeGGx7JSzOdi1lr8CWLkhS2kZ6xmsBW2wqxf3/ahwAZ/WDckKTIxzC2nQWtRM+j8OYoShJe5Y1tikWh3UJ2weaACmCDwwoDIXcYX7z7HIaEPAPeXFX+9FPDL1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163257; c=relaxed/simple;
	bh=vuar8e1g8nuGmfWBiIXhuQ4nJjtfwEg10L5eqheOLNA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rTHZIa3Xr+lDsrnEFJVohTbfIdDTeRZOR9130UYHsi9iejLLVgFUoIYNiHRkL+7dO88Qyw7GIy2+dGwBtfXChFHvVhxuneQKO2Gza2NYLpFZewQA/s41+IvSr0JC09VJvwD4e2hkD546HdEYaFUDPrkhUPUbCbA5CKnVlK1iCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fW2AZwi6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fW2AZwi6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F2704DB9C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 03:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772163253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yI0+5SBm9RJWrdvtLhtt2Ruumve7Mv3ow+83dmrVaIg=;
	b=fW2AZwi6OkH1O3oNg6rYRwLlQveQ9c5MgyCvBDvqQ3okSFWiw4b6Frr833hQa8q+f9rRZq
	iwEYY+eMavzonZDLtXn8htmvXOr8vDWSnjYXD0Xt5flbK50IuMG54UNjAjO/m4MeHE/316
	8KI11q6xwMOCSmHw5xNQkDUbei70MDo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fW2AZwi6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772163253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yI0+5SBm9RJWrdvtLhtt2Ruumve7Mv3ow+83dmrVaIg=;
	b=fW2AZwi6OkH1O3oNg6rYRwLlQveQ9c5MgyCvBDvqQ3okSFWiw4b6Frr833hQa8q+f9rRZq
	iwEYY+eMavzonZDLtXn8htmvXOr8vDWSnjYXD0Xt5flbK50IuMG54UNjAjO/m4MeHE/316
	8KI11q6xwMOCSmHw5xNQkDUbei70MDo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F2423EA69
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 03:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mSZCE7QQoWmcNAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 03:34:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: move some features out of experimental
Date: Fri, 27 Feb 2026 14:03:42 +1030
Message-ID: <cover.1772162871.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22044-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 40A491B2498
X-Rspamd-Action: no action

[CHANGELOG]
v2:
- Move bs < ps && bs != 4K out of experimental
  That feature is a pretty small niche though.
  The basis is already there from the bs < ps support for a while.

- Remove 2K block size support
  That is too niche, considering how easy to trigger subpage routine
  with the larger data folio support, there is not much need for it.

The following features can be moved out of experimental in v7.1:

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

- Block size smaller than page size but not 4K support
  The requirement for 4K block size is purely artificial to reduce our
  test load.
  But since we're moving towards supporting all block sizes, the
  artifical limit can be lifted now.

Qu Wenruo (4):
  btrfs: drop 2K block size support
  btrfs: move shutdown and remove_bdev callbacks out of experimental
    features
  btrfs: move larger data folios out of experimental features
  btrfs: move block size < page size support out of experimental
    features

 fs/btrfs/Kconfig       |  4 +---
 fs/btrfs/btrfs_inode.h |  2 --
 fs/btrfs/fs.c          | 16 ++++------------
 fs/btrfs/fs.h          | 11 +----------
 fs/btrfs/super.c       |  4 ----
 5 files changed, 6 insertions(+), 31 deletions(-)

-- 
2.53.0


