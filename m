Return-Path: <linux-btrfs+bounces-12574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE833A706FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 17:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E154418932E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F35D25D530;
	Tue, 25 Mar 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="URC/8W1W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="URC/8W1W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1B257AF2
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920318; cv=none; b=shc59xKkoLmpEXwmRcI6Wvze3T0PfZkcteIuD/v1s6vAUCkCFy/CwiyfATi059hc4Y2m+TrtgsP6baqdWdFgt3g7UOkcRxjwwqwhRj4mHI5EFTwxSMKI9onu8E4RKaKlx6wPRfYjLGPh9KtxJDEcX+CC10Rz5t7kKk7kaI2kkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920318; c=relaxed/simple;
	bh=eWXxqsgrKXzBPrF8cRI2av7A685G//8p1hBb4smPizU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkBoEGYVcbFes+CeQr+A9AuH4gcCsIR21Y4BgQUckQQKYFH4swzwpNLOebvMrSgTjG2x6cvOy6ZTh3S2Xl55dstRMzYKOuzPFOM6eclVkyV7ZxIRuJrfxfdjP+dKtLz2E8adbafxDlprw3c7nyRgjLUnvIA0MZONFQyyKmFDfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=URC/8W1W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=URC/8W1W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FCCA21172;
	Tue, 25 Mar 2025 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AuQwi+dDekrTDrq2NHVrIsKGsWOSbGf0aot71i79cVU=;
	b=URC/8W1WkTHl5TKhRtah2NP68RUjELY64QIJRNsU8cFltTJT97MmY+huDHTZWUpItZgDPl
	SflVbYIRhTXQlLpGAOWDJz0OVCTYOspZfubRo+i8btewVumMpwUwZatiRq7lBGLGYyQCLA
	ExA8yDADY5Ys7WKUjgGN4WDb1jd0dEs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="URC/8W1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AuQwi+dDekrTDrq2NHVrIsKGsWOSbGf0aot71i79cVU=;
	b=URC/8W1WkTHl5TKhRtah2NP68RUjELY64QIJRNsU8cFltTJT97MmY+huDHTZWUpItZgDPl
	SflVbYIRhTXQlLpGAOWDJz0OVCTYOspZfubRo+i8btewVumMpwUwZatiRq7lBGLGYyQCLA
	ExA8yDADY5Ys7WKUjgGN4WDb1jd0dEs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CFA7137AC;
	Tue, 25 Mar 2025 16:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /jU3Enna4meDSQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 25 Mar 2025 16:31:53 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] btrfs: extent buffer flags cleanup
Date: Tue, 25 Mar 2025 17:31:35 +0100
Message-ID: <20250325163139.878473-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FCCA21172
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

There are a few leftover extent buffer flags not being meaningfully used
anymore for some time. Simply clean them up.

Daniel Vacek (3):
  btrfs: cleanup EXTENT_BUFFER_READ_ERR flag
  btrfs: cleanup EXTENT_BUFFER_READAHEAD flag
  btrfs: cleanup EXTENT_BUFFER_CORRUPT flag

 fs/btrfs/disk-io.c     | 11 ++---------
 fs/btrfs/extent-tree.c |  6 ------
 fs/btrfs/extent_io.c   |  7 ++-----
 fs/btrfs/extent_io.h   |  5 -----
 4 files changed, 4 insertions(+), 25 deletions(-)

-- 
2.47.2


