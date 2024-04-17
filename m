Return-Path: <linux-btrfs+bounces-4387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D0A8A8FB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 01:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3271C2125E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 23:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75812D759;
	Wed, 17 Apr 2024 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f2OFh7cd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f2OFh7cd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B96586634;
	Wed, 17 Apr 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397998; cv=none; b=p2kMN9UqzBgGOUJmJZB1wFkGsLZF87THIcFoG9tKClBxnQA/Fa1OwgkdQneFZFSDgLN/23bJN4iRT3FLk/gO0m/6lE3nBESfF4m3lFBkBu+2s9CwLt78w7bArQvxc/5tv9Rvxb0HfCxJz4tkrVCTECEmTdPXyM1N03p/WHIYeko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397998; c=relaxed/simple;
	bh=BZbM0yFFQWacApkv2yzxp8iBa8jtgGewk9581bFZLc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEA/yTd3n6s9izeMJ+GDFerrQ1pv6YxjinWG2feMhvsX9OA7opiK7uwAmyz1jow0w7hHiCluVJe+QE4igy1OPHtsf2z0/PEdeE/cb4sVoMuDZFI5a3cz8+sKyP1ZwwliKb/v+5SMIIAZWI3xzpKQs65b8xdeB5IWfjYyvmCT7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f2OFh7cd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f2OFh7cd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68A035BF01;
	Wed, 17 Apr 2024 23:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713397994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qoKj9Ceuv1j+XfjhqeFyhNCHpOwULMy/JgT08VwnSQA=;
	b=f2OFh7cdbO/JrjSq6d+RrFdACVGfuVSpsMDkQmk/5JsB3xKHt87jyA7FYCIxL5Rfpdn9Af
	3VJuhE2+k0hxg1+vE0rvFdXaqIgppw9RcUMtyMJCRKiQ2n+8uZVM2p0lgATqWm0f+EqKsc
	gN34EDNEW39HoMFbiz3ksIjZSqOdMQo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=f2OFh7cd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713397994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qoKj9Ceuv1j+XfjhqeFyhNCHpOwULMy/JgT08VwnSQA=;
	b=f2OFh7cdbO/JrjSq6d+RrFdACVGfuVSpsMDkQmk/5JsB3xKHt87jyA7FYCIxL5Rfpdn9Af
	3VJuhE2+k0hxg1+vE0rvFdXaqIgppw9RcUMtyMJCRKiQ2n+8uZVM2p0lgATqWm0f+EqKsc
	gN34EDNEW39HoMFbiz3ksIjZSqOdMQo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 624B813957;
	Wed, 17 Apr 2024 23:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vgr2F+pgIGarBAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 17 Apr 2024 23:53:14 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.9-rc5
Date: Thu, 18 Apr 2024 01:45:43 +0200
Message-ID: <cover.1713396900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.04 / 50.00];
	BAYES_HAM(-1.03)[87.50%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 68A035BF01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.04

Hi,

please pull the following fixes, thanks.

- fixup in zoned mode for out-of-order writes of metadata that are no
  longer necessary, this used to be tracked in a separate list but now
  the old locaion needs to be zeroed out, also add assertions

- fix bulk page allocation retry, this may stall after first failure for
  compression read/write

----------------------------------------------------------------
The following changes since commit 6e68de0bb0ed59e0554a0c15ede7308c47351e2d:

  btrfs: always clear PERTRANS metadata during commit (2024-04-02 19:19:13 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc4-tag

for you to fetch changes up to 1db7959aacd905e6487d0478ac01d89f86eb1e51:

  btrfs: do not wait for short bulk allocation (2024-04-09 23:20:32 +0200)

----------------------------------------------------------------
Naohiro Aota (2):
      btrfs: zoned: do not flag ZEROOUT on non-dirty extent buffer
      btrfs: zoned: add ASSERT and WARN for EXTENT_BUFFER_ZONED_ZEROOUT handling

Qu Wenruo (1):
      btrfs: do not wait for short bulk allocation

 fs/btrfs/extent-tree.c |  8 ++++++++
 fs/btrfs/extent_io.c   | 21 ++++++---------------
 2 files changed, 14 insertions(+), 15 deletions(-)

