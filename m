Return-Path: <linux-btrfs+bounces-14952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E2FAE84EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA641887BDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A62A25E458;
	Wed, 25 Jun 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fqaxbz39";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dSjC1kkm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7F25B315
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858642; cv=none; b=VnUTfW8Wn4KXt3MVMkoaPWRMWL6KR4MwUNGVtXF2YrAvDzznzHP0RCmDx6dNhNEOYzBbY1F7aLd5RoByQedoXkOjJpe4se3qnqwj3M6lQnLpLuABvZbJR9Rr61qRVS6gzqDseK7TzfuZur4eQckrrCf1ccEaJORxr0bQ3fuR5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858642; c=relaxed/simple;
	bh=kjwQrXWtag4Rvc4IptY513GhlqYYVXNCu8jHymfVk6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hPM3OcqcXh+3IFr2K4ZB0L1BlkdwZV2SqBs339e8lYroB2vo8bs9Di3kubhLIaXvbD6Ts+pOKnWJ/yPxUWQTFrqGL9FgQUV0sm1YcpMZi+m71DqvM/z13u99pQX+33u9jac6+fdEQnAM5qCoBpgytq9bE2mmYs1ArfiS1MtHHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fqaxbz39; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dSjC1kkm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6E791F46E;
	Wed, 25 Jun 2025 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750858638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YNYHF1GklVhdK6sGI79iUsI6xyydzaG6jrw8+DOgXQM=;
	b=Fqaxbz39Wm/oWZEWKejJ5AMaRDq/YzN2OWwp4+dO63WuHM5W1LRvOAvH8ZLyv1TqPlr80c
	OGN615iP2+0raU/SiJP4ka+CC1JpkIaaE8o3tk62L7nHNVm6byKp/4pYWcTsjsxW+ZYDsy
	/4kisZxBUNXgrMBRoST7m4E/J3P8w04=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750858637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YNYHF1GklVhdK6sGI79iUsI6xyydzaG6jrw8+DOgXQM=;
	b=dSjC1kkmHieuGLy+63j5V6LacUNdHdDNmAQIF5eh2NHWYepAlMrdWN6k8x9plRf5+5sAeq
	/3y4YDWIwlw2mOcj1P5eLIsyCvsOOiQVfPk/g8UIvdNfBF1cgHYy7jOvISmAkUbd3+basC
	6oKpSjN2DSQcrIOJuzapuCIJYBI44IU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADB3A13485;
	Wed, 25 Jun 2025 13:37:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yUEfKo37W2hWBQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 25 Jun 2025 13:37:17 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/2] Device name and RCU string
Date: Wed, 25 Jun 2025 15:37:15 +0200
Message-ID: <cover.1750858539.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

v2:
- drop patch adding RCU protection around update_dev_time(), there's a
  sleeping allocation inside; after revisiting the RCU requirements, I
  don't think it's needed and we can access the raw string (the same way
  it was done with rcu_string), the time update is called from scratch
  superblocks and after the ->dev_list hook is removed, so there's no
  chance it can be reached from device_list_add

After recent simplifications of the RCU usage in messages, this patchset
implements the RCU protection directly without the RCU string so this
API can be removed completely as we don't have nor plan anything else to
use it for.

David Sterba (2):
  btrfs: open code RCU for device name
  btrfs: remove struct rcu_string

 fs/btrfs/rcu-string.h | 40 ----------------------------------------
 fs/btrfs/volumes.c    | 29 +++++++++++++++++------------
 fs/btrfs/volumes.h    |  6 +++---
 fs/btrfs/zoned.c      | 23 +++++++++++------------
 4 files changed, 31 insertions(+), 67 deletions(-)
 delete mode 100644 fs/btrfs/rcu-string.h

-- 
2.49.0


