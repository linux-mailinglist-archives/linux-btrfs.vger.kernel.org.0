Return-Path: <linux-btrfs+bounces-8351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7AB98B06D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 00:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3964B283B26
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 22:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D435188CA6;
	Mon, 30 Sep 2024 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GcY2A0ca";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GcY2A0ca"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13D17332B
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736454; cv=none; b=nFe0crH67PYGuWpBL8+cmUgN2bbAd9rncgp98x85ZaSSitvEDMIUu972gJfsVoyf9QSk6c1uxk6H9Jafp4u2U1GpK8s4NE62S6L7AFlsY3IDL1tAla6dRnh0VjQoqbHnehzEeIxoQqBmpAM3aUeK+MRxT2vhm1RDWcHFKYjTgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736454; c=relaxed/simple;
	bh=plJWZx+Bi/t9OoylPpoIOJD5iCJ5EXYtpxmCIsstXpA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GrHAFbSXJC32cS9CPv0P4LtYy9HsKi5KutSatRd4Uv1jaW802Ch7g0fqJ30ch7J6oJnLSZWQe9LCJyrgBIsbLqAroIfxm4M4ECgYU/SOaNzPNxxPY7BSw0L1sVkZ9VTaws5ql1RKIqIEcIKu6jyZMAPmMz+tNMImCRh3EHwVHEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GcY2A0ca; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GcY2A0ca; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98E891F81C
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727736449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JzKNb2FIz1Xa8e3C6Dv5vQi7M5joPKQsNi+gXSWVUN4=;
	b=GcY2A0caIG6xBcr0szIoOL6iGF1XzL//IKzIq0IJSm/6gAfTMgUbg/kqWjBKniYzbVfrI2
	apV+l1NvgncHk2oESEvogIJXzgKj61UBzYQ6PTDMHVNT7kJWbRe3TpFZ6jKE8xO7dKSnGd
	rUp/l+n+KIfMmU/IwZ53aMuNpZ3WmSA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727736449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JzKNb2FIz1Xa8e3C6Dv5vQi7M5joPKQsNi+gXSWVUN4=;
	b=GcY2A0caIG6xBcr0szIoOL6iGF1XzL//IKzIq0IJSm/6gAfTMgUbg/kqWjBKniYzbVfrI2
	apV+l1NvgncHk2oESEvogIJXzgKj61UBzYQ6PTDMHVNT7kJWbRe3TpFZ6jKE8xO7dKSnGd
	rUp/l+n+KIfMmU/IwZ53aMuNpZ3WmSA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D532113A8B
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y3qCJYAq+2YsGgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:47:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: small cleanups to buffered write path
Date: Tue,  1 Oct 2024 08:17:09 +0930
Message-ID: <cover.1727736323.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
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

[CHANGELOG]
v2:
- Utilize folio APIs instead of the old page APIs for the 2nd patch

These two are small cleanups to the buffered write path, inspired by the
btrfs test failure of generic/563 with 4K sector size and 64K page size.

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
2.46.2


