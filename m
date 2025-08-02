Return-Path: <linux-btrfs+bounces-15794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C976B189E2
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 02:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB553A4266
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 00:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F661863E;
	Sat,  2 Aug 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vu/jg6ay";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XTkgOdCF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEFE12E7F
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754094403; cv=none; b=XSmsfrE6se7YxMB1ITkG75Oq6RtJVfz3zpzpxQSPeBuwGcVXaZw/euG9ZrP2XH8/nDb4Db6AmulwATi3qZ6WQ8bnlTcKWLH5t5PxtEARQ9iYDs+G466KUkYCx4r35ZooKRPOJBrTQcE5dn1Z7yS/87QEa+EyvMQGlhv1ruQX6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754094403; c=relaxed/simple;
	bh=A/3QdqoJhqjfEbWbaZJVarIfPfXyZAcdF37XpTEzbug=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=or6SSa+ZVe2PLnVu2Jqi7Wx4peosvLpB4A6jPCOHOQ8ECQZYEpchOcBFQCFtcohQytU+D7P8HBJa17zIGXmaBANvO5E0BoWRB2sFeuRd0v7i+sWY7h9a49pDq2pRSopAcH6Z0+eAgVILyZ0UN1DA1mdywYUrWHNvATdoaRiMqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vu/jg6ay; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XTkgOdCF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E504F1F7F4
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 00:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754094399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NnUZonyTas2nFk5RTV6vp32WUaL54Dk2DA1E0tpzu20=;
	b=Vu/jg6ayr3iSpSToEOz5Wu8GIPMqklXtR88IdCCHNzceD/8LMHhmcnvHe00nORmHA1OQ/n
	hS/LTzjE1MAY0sjct1ZFcPoA4gSgSWHlRlf7+MbrIFgOY9AOFYkws67A/9+7H9yNa9WqpM
	NYH6ydYAbauT8NfN7+LLuWWUlVhH2Vs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754094398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NnUZonyTas2nFk5RTV6vp32WUaL54Dk2DA1E0tpzu20=;
	b=XTkgOdCFzm0wfX/O1sfoaakeyxZLhuA7PoZMQiQiJ2jAFuZ/wGr1LbuRH0lwxR/e6oGMDo
	wA2e/IAEyVZpZs1owfGfax8DScNsgU/iqpuOoI9wRIfqp5LaqnN6qRin2qDEZwLm5RxV+n
	aO1O6Srx6YCYFREABf8lWX0T3gINf1o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28575133D1
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 00:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XYR5Nj1bjWjnPAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 00:26:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: check for device item between super
Date: Sat,  2 Aug 2025 09:56:18 +0930
Message-ID: <cover.1754090561.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
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
X-Spam-Score: -2.80

Mark has submitted a check enhancement for progs to detect the device
item mismatch between super blocks and the items inside chunk tree.

However there is a long existing problem that it will break CI.

The root cause is that the CI kernel lacks the needed backports, that on
a lot cases the kernel can lead to such mismatch and being caught by the
newer progs.

So to merge this long existing fsck enhancement, this series refresh and
workaround the problem by:

- Only reports warnings when such mismatch is detected
  Such mismatch is not a huge deal, as we always trust the device item in
  chunk tree more than the super block one.
  So it won't cause data loss or whatever.

  So even if the CI kernel doesn't have the fix, self test cases won't
  report them as a failure.

- Workaround fsck/057 to avoid failure
  Test case fsck/057 is a special case, where we manually check the
  output for warning messages.

  This is originally to detect problems related seed device, but now it
  will also detect device item mismatch cause by the older CI kernel.

  Workaround it by making the keyword more specific to the original
  problem, not just checking for warnings.

With those done, we can finally make CI to accept the new checks even
the kernel is not uptodate.

Mark Harmstone (1):
  btrfs-progs: check that device byte values in superblock match those
    in chunk root

Qu Wenruo (1):
  btrfs-progs: fsck-tests: make the warning check more specific for 057

 check/main.c                                  | 35 +++++++++++++++++++
 .../fsck-tests/057-seed-false-alerts/test.sh  |  6 ++--
 2 files changed, 38 insertions(+), 3 deletions(-)

--
2.50.1


