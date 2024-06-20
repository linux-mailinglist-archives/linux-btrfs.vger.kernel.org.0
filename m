Return-Path: <linux-btrfs+bounces-5849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26ED910E58
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4ED91C22357
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC11B3F0A;
	Thu, 20 Jun 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k/BP/0RO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l/uzB8Oc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8A1A4F1D;
	Thu, 20 Jun 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904068; cv=none; b=FWpjiCRxSoKmABSCO7HJHaizgttK4/SoFujLBXyuRbn57PKsuefJqVAqddRjs8WA4xg8enoRp+u4oAUkN7y2LO7VuuLbr9EEvZ4aKah6Hrn+BxVzNyv/nWI8U5QyjALl8BPrMbH8IKZlVf+gyJlReggLD6jD11G6IypRpjrhjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904068; c=relaxed/simple;
	bh=ZzBYLy6w7C7HSZeVVEd0tacSuYrjT+qz0QAXkUbMTPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GI50gvb9S60BEhkInLaxpY6P7tdXLx/KHDcrdWEx2/hRA/pAj0iOlB1Zcb7PtNY3QeXmyCAT2uTBWtGvJ5kxZFMwXaplKZKQYvhLT9ssxoC7NFYsAD1uteid5s8iuWpevHomqqs/w/3yy2eP84FcL1nUNEzsaft8xUtZDVdKcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k/BP/0RO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l/uzB8Oc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86F9B21B18;
	Thu, 20 Jun 2024 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718904056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B8HnWldaOSVqirjJcR6sBf8qjkKnVUl92K/9KUx7/j4=;
	b=k/BP/0RORbosCoNjvdi1O6lnhoGjC/Vws94wopLQGDeckRd/fSiLKTRPLx/D2zypR6krXE
	EDMAH4Qsp4iQxS1ZeCBxXml/0G/jckLuLnX2DtuBBMv2PjzAxpAe8uFStpQ+D2jMKiNHEo
	OuNYzYFpbEHYANIEUJtGSMbFJyzDmgw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="l/uzB8Oc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718904055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B8HnWldaOSVqirjJcR6sBf8qjkKnVUl92K/9KUx7/j4=;
	b=l/uzB8OcqiEXxIGhEBV8wJTK37YBQ/2dLXn21NZeiu+wZ6eiWoKOMPlkbBBuhm3s53GF16
	jxsABFdWvU/Zfu3PF/98cNVOoZjbTo74rbC4hQM0RLd2JojatFo2R0ZuQaYuoPVWcIwcYA
	/CRdLjXDTLFM7jxEmVI2/gk5uX2C+rw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C8551369F;
	Thu, 20 Jun 2024 17:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JUYVHvdkdGabGwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Jun 2024 17:20:55 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.10-rc5
Date: Thu, 20 Jun 2024 19:20:51 +0200
Message-ID: <cover.1718903445.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86F9B21B18
X-Spam-Score: -3.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi,

a few more fixes for stable trees. Please pull, thanks.

- fix potential infinite loop when doing block grou reclaim

- fix crash on emulated zoned device and NOCOW files

----------------------------------------------------------------
The following changes since commit f3a5367c679d31473d3fbb391675055b4792c309:

  btrfs: protect folio::private when attaching extent buffer folios (2024-06-06 21:42:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc4-tag

for you to fetch changes up to cebae292e0c32a228e8f2219c270a7237be24a6a:

  btrfs: zoned: allocate dummy checksums for zoned NODATASUM writes (2024-06-13 20:43:55 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: retry block group reclaim without infinite loop

Johannes Thumshirn (1):
      btrfs: zoned: allocate dummy checksums for zoned NODATASUM writes

 fs/btrfs/bio.c         |  4 +++-
 fs/btrfs/block-group.c | 11 +++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

