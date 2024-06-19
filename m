Return-Path: <linux-btrfs+bounces-5805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B68CD90E2B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 07:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6051F234F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 05:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D51558BC;
	Wed, 19 Jun 2024 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fv8701DP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fv8701DP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BCD4C635
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775242; cv=none; b=uk7wV1OU3aKPCdGc9FXcPRPDGGwhBtTKIUzN3Q6DRRDaCy5m44zk2OJ9R87O1FnusYyLHB0nW1nhjo4+/OVLV9DW7zyO3LOlDL68GSXBM4c+02e8cJcyjA8DG7eMbU2Cy6+U9rfnhy63xiUkNA4rm5AU3r+uZmV3xfRyYj9Zvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775242; c=relaxed/simple;
	bh=UEoSCsh6NlruBXsULqBQRz3oQIUlC+r8xemfGBOlyOU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j41sv596K4bIyILzLPHvppYvQdhVl2078A1ahFEr2txAjSL+Tc7201GIeNEQtBKjJR+rKzWpyzOW03BttBkLFtk6A5sQRxoXh1ChGWTfCZxh/8JN2mXjRCLFT0QgzmeYnnSNs7uah44vSs9VZsub/pok+NK7AA57/3TPasx2Exk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fv8701DP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fv8701DP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E23871F7DD
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W/sQh/hji+1jjrWD/ISaWsQmNccQTTiY9pfVZTYj1fY=;
	b=fv8701DPT8hMx6YqGq0+2OCwLS+0NlZtEaHV6U6DN59zPJIn1rBs8jCmSvRoWPPcqONImc
	nICpM0HetELwM4H+r+NXIeo8iCXpirMvjQU0I1DvGvkO/HJX9z3qC6bxD1FGCg+1x8WZrr
	kTzn21v0ZBDNrE4xhQebhFsiRN+DDoY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W/sQh/hji+1jjrWD/ISaWsQmNccQTTiY9pfVZTYj1fY=;
	b=fv8701DPT8hMx6YqGq0+2OCwLS+0NlZtEaHV6U6DN59zPJIn1rBs8jCmSvRoWPPcqONImc
	nICpM0HetELwM4H+r+NXIeo8iCXpirMvjQU0I1DvGvkO/HJX9z3qC6bxD1FGCg+1x8WZrr
	kTzn21v0ZBDNrE4xhQebhFsiRN+DDoY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0479B13AAF
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:33:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wcciK8VtcmYUaQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:33:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: csum-change enhancement
Date: Wed, 19 Jun 2024 15:03:36 +0930
Message-ID: <cover.1718775066.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

The first two patches are small enhancement and bugfix:

- Fix a missing error handling
- Do multi-transaction csum deletion and rename
  Or we can generate GiB or even TiB level of dirty metadata.

Finally introduce a basic error injection based test case, which will:

- Check if we have error injection first
- Inject error at the end of data csum generation
- Make sure resume from above situation is correct

I'm not adding extra injections because I believe there would definitely
be corner cases that need to be fixed.

Qu Wenruo (3):
  btrfs-progs: csum-change: add error handling for search old csums
  btrfs-progs: csum-change: add leaf based threshold
  btrfs-progs: misc-tests: add a basic resume test using error injection

 .../065-csum-conversion-inject/test.sh        | 48 ++++++++++++
 tune/change-csum.c                            | 75 +++++++++++++++----
 2 files changed, 107 insertions(+), 16 deletions(-)
 create mode 100755 tests/misc-tests/065-csum-conversion-inject/test.sh

--
2.45.2


