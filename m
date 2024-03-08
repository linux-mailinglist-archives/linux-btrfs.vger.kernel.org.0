Return-Path: <linux-btrfs+bounces-3090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC8A875D4A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 05:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA601C20CC3
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 04:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781192E620;
	Fri,  8 Mar 2024 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TURqM+pu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TURqM+pu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1D1CFB2
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709873796; cv=none; b=BxVqBP707v5nbvDa2DlaTXGULfp8R6//gK+TJm2m3PyNdaMtS4FDXtT74qq/AvE3Lh01bRm+gZDj0+zRa9KrBrFTp3ZsaTi2ssCi9x8MBWTO7vcuEAR7yVt4/s97xV5YNzh2hTIPnc1BmrKfcTYB0XDgaBoSdnNQPVATX/+y4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709873796; c=relaxed/simple;
	bh=DMTGu5ddLN95FRHpVz4RXUUrquCNKhba3XDXI1VX3rE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=i9CcrlI5qGX1IYBAqoK4IlmIFbRUHMK/KnLb+Mmoo67Qoo4+q0BGhl4g10syqSrmZG+yksI9hsIgahrXOY+wcR0mI2pGJ6l5WnzrfI9aKtc6k7lSet3sGDL1dKNelMBQp0ihXeb6dEElbRqkMtcL1l4f7ddwDOiAOoPkoUMBONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TURqM+pu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TURqM+pu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 338E867983;
	Fri,  8 Mar 2024 03:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709868380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ztwZOjH+YiCYU/c2Rofq77pB2pREfQC7jIVXiawevEY=;
	b=TURqM+puRKZRdcLT3KSoSSTIInfsKs8WADBW0LpnE+sLjTjdT1GQXY9SWd61hd7EJYxEES
	aQ9/YeDOmsuQhH1et+YwTiUfYpN7EDmVy4nHIseUV8Al6FLFdAHe90LuZzqyav8eNiBOij
	ZdOZb1+hv5uvdODx6zFpB1JrGoqjc8g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709868380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ztwZOjH+YiCYU/c2Rofq77pB2pREfQC7jIVXiawevEY=;
	b=TURqM+puRKZRdcLT3KSoSSTIInfsKs8WADBW0LpnE+sLjTjdT1GQXY9SWd61hd7EJYxEES
	aQ9/YeDOmsuQhH1et+YwTiUfYpN7EDmVy4nHIseUV8Al6FLFdAHe90LuZzqyav8eNiBOij
	ZdOZb1+hv5uvdODx6zFpB1JrGoqjc8g=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EADE51391D;
	Fri,  8 Mar 2024 03:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id A0o0KFqF6mW6dQAAn2gu4w
	(envelope-from <wqu@suse.com>); Fri, 08 Mar 2024 03:26:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	michel.palleau@gmail.com
Subject: [PATCH 0/2] btrfs: scrub: update last_physical more frequently
Date: Fri,  8 Mar 2024 13:55:58 +1030
Message-ID: <cover.1709867186.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.22)[72.19%]
X-Spam-Score: 4.68
X-Spam-Flag: NO

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


