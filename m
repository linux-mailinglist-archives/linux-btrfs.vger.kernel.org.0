Return-Path: <linux-btrfs+bounces-16504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C6B3AD08
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973877B7C7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931FE2BE7C3;
	Thu, 28 Aug 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ox0mXqDw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ox0mXqDw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DE28153A
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418045; cv=none; b=ZZRZEu12XrubO5dDFuGKwtKOLSPTDeaoRANeVOTmRFA8cIFv/2GmJnUlJfcwm0rSXn45Zwv2iMvVGSrrxGOWt+lm0cPsVmreendCJdOImYWJhPfsChoVRrTGdMX2IGyt5fvh6roQYbQrtrLrV8dPdpM34mF3ssjt8blvMWcWyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418045; c=relaxed/simple;
	bh=mm1dFZ3V/l1XsfUi1onGD2xTThkzKt3etYEODAKH/9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hBamVWTnQs6ZWGeNDGs9GMYLEi76WhgMPO0aFNoKr1JjkGcJAxHdLToC84dqM9Decfnz9+KurnxM801GLyz7i0OURuv4GHy93nDRDpWNERQ/1jek+ukuvPOxfmo3mt3dd214v5lwgpGPP1I/0ZnzIoUQCVM0JyGkn+6gIoelqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ox0mXqDw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ox0mXqDw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AAEC020EFA;
	Thu, 28 Aug 2025 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756418041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WAGHuP6gb0ma+67s0WBfPpyBNotzHbPLEBjb34KBlwY=;
	b=ox0mXqDwq3L6cpmBoWCbMkyCIJncZbbdkgDoVW5ZSmt/Jdfim6ao89j3F/pZh5vzrRXiIB
	LhpObojkBEVbP29Ozw+QJ+rqPTixaO7U4e2H+SYwmPJT3yN3Me8S/CP8ubXyH2chkpV7yW
	11ugrn4Ps84PNBtJHLb7YFCvIGodeio=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756418041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WAGHuP6gb0ma+67s0WBfPpyBNotzHbPLEBjb34KBlwY=;
	b=ox0mXqDwq3L6cpmBoWCbMkyCIJncZbbdkgDoVW5ZSmt/Jdfim6ao89j3F/pZh5vzrRXiIB
	LhpObojkBEVbP29Ozw+QJ+rqPTixaO7U4e2H+SYwmPJT3yN3Me8S/CP8ubXyH2chkpV7yW
	11ugrn4Ps84PNBtJHLb7YFCvIGodeio=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A066C1368B;
	Thu, 28 Aug 2025 21:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ANrlJvnPsGg7LwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 28 Aug 2025 21:54:01 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Allocate eb in 16k an 64k slabs, cache folio address
Date: Thu, 28 Aug 2025 23:53:53 +0200
Message-ID: <cover.1756417687.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Optimiztion of eb folio access.

NOTE: does not work with both patches applied, btrfs/002 hangs and I
      don't see why. I'm sending this out in case somebody can spot it.

The extent buffer folio array is not used effectively on 16K node size,
so there are two slabs allocated for the default size and 64k for
everything else. With some pointer magic we can also cache the folio
addresses and this allows object code reduction. Numbers are in the
patches.

David Sterba (2):
  btrfs: add 16K and 64K slabs for extent buffers
  btrfs: use cached extent buffer folio address everywhere

 fs/btrfs/accessors.c | 12 +++---
 fs/btrfs/accessors.h |  5 +--
 fs/btrfs/ctree.c     |  2 +-
 fs/btrfs/disk-io.c   |  6 +--
 fs/btrfs/extent_io.c | 96 ++++++++++++++++++++++++++++++--------------
 fs/btrfs/extent_io.h | 20 ++++++---
 6 files changed, 92 insertions(+), 49 deletions(-)

-- 
2.51.0


