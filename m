Return-Path: <linux-btrfs+bounces-3089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4D875D49
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 05:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1825E1F215B7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 04:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4B2E62B;
	Fri,  8 Mar 2024 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Apsc0QAx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Apsc0QAx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FFFE555
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709873653; cv=none; b=GAf3tSmFnc5RG8HQNE52DYbMsK58Vvuk/Zkb8Vb6OJrCKWsx+C2vemu1SFdYhQVn+N5svCQO2IspvfH7c/yuZV/JSJfGNkXKdjI4ST5N0TGSamkLQGQZF9lZU7tzcC0+f4oZriHiYoU/fj/CIEHLVdAbgUkt9YHM1fI0niQJ8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709873653; c=relaxed/simple;
	bh=DMTGu5ddLN95FRHpVz4RXUUrquCNKhba3XDXI1VX3rE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iiULMrXkcETMtD2WdQ1/bG6cN2e6//QFxyMPivp2gp5+BX/RqoHpxJESreqGRJlRrZIhV4GcYLDOKNzyg88/Qt9Zt6sx/dXo+vyS5ASI8+GKjaszUJqaP4WD+ixc9bB+6/eSUm6kfUrFaoPn7cFynFmrQqB+YNfGVHCgTpPiPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Apsc0QAx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Apsc0QAx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FE7720832;
	Fri,  8 Mar 2024 03:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709867451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ztwZOjH+YiCYU/c2Rofq77pB2pREfQC7jIVXiawevEY=;
	b=Apsc0QAxrY9VfthMpswC08PSCQQ0sr3FPS1g3MkXTlXrW6HoD2A20Tw924BR71NK1NeBZx
	kUIfBWTWlzwygiLoCKRiYsA0JON4icgr5ABuQe1jVszMeDAIxukofTGexqgtRCxbXcENZk
	V0Nn3C4prZPXORiAanRXpQ3OcRChIqM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709867451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ztwZOjH+YiCYU/c2Rofq77pB2pREfQC7jIVXiawevEY=;
	b=Apsc0QAxrY9VfthMpswC08PSCQQ0sr3FPS1g3MkXTlXrW6HoD2A20Tw924BR71NK1NeBZx
	kUIfBWTWlzwygiLoCKRiYsA0JON4icgr5ABuQe1jVszMeDAIxukofTGexqgtRCxbXcENZk
	V0Nn3C4prZPXORiAanRXpQ3OcRChIqM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 129251391D;
	Fri,  8 Mar 2024 03:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GOpPL7mB6mUkcwAAn2gu4w
	(envelope-from <wqu@suse.com>); Fri, 08 Mar 2024 03:10:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	michel.palleau@gmail.com
Subject: [PATCH 0/2] btrfs: scrub: update last_physical more frequently
Date: Fri,  8 Mar 2024 13:40:29 +1030
Message-ID: <cover.1709867186.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Apsc0QAx
X-Spamd-Result: default: False [3.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 BAYES_HAM(-1.04)[87.62%]
X-Spam-Score: 3.65
X-Spam-Level: ***
X-Rspamd-Queue-Id: 4FE7720832
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

There is a report in the mailling list that scrub only updates its
@last_physical at the end of a chunk.
In fact, it can be worse if there is a used stripe (aka, some extents
exist in the stripe) at the chunk boundary.
As it would skip the @last_physical for that chunk at all.

With @last_physical not update for a long time, if we cancel the scrub
halfway and resume, the resumed one scrub would only start at
@last_physical, meaning a lot of scrubbed extents would be re-scrubbed,
wasting quite some IO and CPU.

This patchset would fix it by updateing @last_physical for each finished
stripe (including both P/Q stripe of RAID56, and all data stripes for
all profiles), so that even if the scrub is cancelled, we at most
re-scrub one stripe.

Qu Wenruo (2):
  btrfs: extract the stripe length calculation into a helper
  btrfs: scrub: update last_physical after scrubing one stripe

 fs/btrfs/scrub.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
2.44.0


