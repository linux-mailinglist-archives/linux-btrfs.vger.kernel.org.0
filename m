Return-Path: <linux-btrfs+bounces-20879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDWdD5NccWnLGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20879-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:09:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8DC5F4EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1A7676AF20
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51B644BCBB;
	Wed, 21 Jan 2026 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k295Q5Ez";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k295Q5Ez"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FF38B9AF
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036904; cv=none; b=YdlY2lVCTvCzQPLgFbcwOcQMjmgoikG6tlsPN+nSXmlrwf6x3wH55ZFIco6whMpOiEmmXaOCCfw/1L1CnSHTfJk9l6m6w0ahd19ylYKlWdz3YR5F4U+tcw5rePFKdVihQEA2XJIkIsHnVbo1N+vypyyT1mb0LG8HX8sk1gEl/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036904; c=relaxed/simple;
	bh=2t+nDkQPP8mP0Fxy2IpjbOzuH3q3m4NeFm6fu0Ddj88=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s8VIdq92/hyVnpmZ7wgB1Vf9QlVoBVDsQjVxbkC69S6oncBDs2cx7KKDRKhzJknM5+a+QtboWqFGtAcdZZlcTGaEumtl/T8uSEDn+TaqsLDRAzEFi7suIZtSoOU7SyEjBH5H7BE/6vCKErRQujbjyUM6ZSwk+7Gmw5T2o1Qjj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k295Q5Ez; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k295Q5Ez; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77D585BCEF
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769036900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o2tHPUu2h7gUMcWjiE7zGZCS+Zi0zDZMwzmPMGzCWo8=;
	b=k295Q5EzPk6EOejRCrnfU4CSBJMb112F/Y3xGB+AFmXbt4xT3Cb4Fk/8XV9Ynvt9ntYnVH
	hCdn9YB+fPWVc6W/0JAbxcmOrd5rMt3zzTAPjshiElE12vVblDXh/HOGrvqdDGpulkk7xX
	i1TsOvoPOJ0Zx+9lTnMOSfZzbL8YUq0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769036900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o2tHPUu2h7gUMcWjiE7zGZCS+Zi0zDZMwzmPMGzCWo8=;
	b=k295Q5EzPk6EOejRCrnfU4CSBJMb112F/Y3xGB+AFmXbt4xT3Cb4Fk/8XV9Ynvt9ntYnVH
	hCdn9YB+fPWVc6W/0JAbxcmOrd5rMt3zzTAPjshiElE12vVblDXh/HOGrvqdDGpulkk7xX
	i1TsOvoPOJ0Zx+9lTnMOSfZzbL8YUq0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 740F43EA63
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3LRvCGNccWkiXgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:08:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: apply strict alignment checks to extent maps
Date: Thu, 22 Jan 2026 09:37:57 +1030
Message-ID: <cover.1769036831.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20879-lists,linux-btrfs=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_ONE(0.00)[1];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: EB8DC5F4EE
X-Rspamd-Action: no action

[CHANGELOG]
v2:
- Grammar fixes

  Not only spelling fixes, but also extra new line after an item of a
  list.

- Remove unnecessary ASSERT()s inside inode tests

  There is already enough comments on each test file extent item.

- Remove some unnecessary commit messages from patch 3

  Which not only introduces grammar errors, but also duplicated.


Although we already have strict checks on file extent items from
tree-checker, we never do proper alignment checks for extent maps.

The reason is mostly due to the failure of self tests and how hard it is
to touch them, especially for the inode self tests.

I have to say the inode self test is really something, the extent maps
of the self test makes no sense, and would be rejected by the
tree-checker if they show up in the real world.
Thankfully only the first few file extents items are invalid, the
remaining ones are totally fine.

The comments are not any better, after the first line, there are no more
aligned number at all, and the numbers are not offset by 1, but 3 or
even more.
Considering we're using decimals for most of our dump-tree and comments,
no one is really going to note the wrong numbers until one throw them
into python or whatever calculator one prefers.

The series will mostly rework the inode self tests file extent item
layout so that they represent the real world better, and update the
comments and make the poor person who needs to update that selftest
suffer less in the future.

Then address the minor problem in the extent-map selftest where
fs_info->sectorsize is never properly populated for the 4K based self
test.

With all those done, we can finally put a proper alignment check into 
validate_extent_map() which is called for every new, merged or replaced
extent map.

Qu Wenruo (3):
  btrfs: tests: remove invalid file extent map tests
  btrfs: tests: prepare extent map tests for strict alignment checks
  btrfs: add strict extent map alignment checks

 fs/btrfs/extent_map.c             | 12 ++++
 fs/btrfs/tests/extent-map-tests.c | 16 ++++--
 fs/btrfs/tests/inode-tests.c      | 96 ++++++++++++++++---------------
 3 files changed, 72 insertions(+), 52 deletions(-)

-- 
2.52.0


