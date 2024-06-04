Return-Path: <linux-btrfs+bounces-5455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45078FC012
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 01:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F741F249B8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 23:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03014D6EE;
	Tue,  4 Jun 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nO+ObmCH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nO+ObmCH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D014BF9B
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544651; cv=none; b=jRy1BpGH/dhAeU+p3Jb8h7qPk/C71j/9Da/NFLv2x1fwAI4G+ARobCpXpjuiDiZZWOCAPFLtvarX0MnuW3sV9y2xvCPvUSqwi6pGruoUGXnDuLawMPrF1uOEKFZdzSxXCh2NDUMXxBNubDk5JM7De5N4olVvOJfQrOqPexXDGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544651; c=relaxed/simple;
	bh=E0OysOT4RxSXEXjqAn5FQYB+CyweahNT7OTK5M0ykWY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ByyA3L+tHug7BTqPE2rryAAUwoFkAPOUvrEsPNStwnkitKH7kbaXXJ/3OO2JNmR2blz6CpIAM/Y8670ifmqCnW1vNSgHutpgzE9eDd6bH1alsh0/3iNpmtXkvnnIakLAcKgpYdvMmrspQRaROvdttZ9AC7cR+udSuOvcHfs7FWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nO+ObmCH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nO+ObmCH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BD611F45A
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pasYgLqiY20KJEArAlDUSKvVTqze3ET/2XQw584yl6E=;
	b=nO+ObmCHRi7bP5jFkJqY6UzVM7LYpCIcDeFZlNDfpVBPruN9aFeZAHJMueS91vJrkQeHst
	1vyFydsmW3eFjTqc8HVGxJDGMeTtxnOpr4Q3MFuXRSI9E0fslJ4gABEtz4c3N5fIO+4AFr
	rZM37YI2EY2Asq5lWG0imwQMtdnvMNw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717544647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pasYgLqiY20KJEArAlDUSKvVTqze3ET/2XQw584yl6E=;
	b=nO+ObmCHRi7bP5jFkJqY6UzVM7LYpCIcDeFZlNDfpVBPruN9aFeZAHJMueS91vJrkQeHst
	1vyFydsmW3eFjTqc8HVGxJDGMeTtxnOpr4Q3MFuXRSI9E0fslJ4gABEtz4c3N5fIO+4AFr
	rZM37YI2EY2Asq5lWG0imwQMtdnvMNw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAF6413A93
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 23:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gRXoF8amX2bcJwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 23:44:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs-progs: small bug fixes
Date: Wed,  5 Jun 2024 09:13:40 +0930
Message-ID: <cover.1717544015.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

3 fixes for 3 github issues.

Meanwhile the last one fix a test failure which always fails on my VM
(cause by one bug inside the test case), but it never fails on the
github CI (as the kernel commits two transactions, causing slot change).

[Pull request]
https://github.com/kdave/btrfs-progs/pull/807

[Changelog]
v2:
- Concentrate all small fixes into a patchset
- Update the last patch to handle multiple transactions

Qu Wenruo (4):
  btrfs-progs: corrupt-block: fix memory leak in debug_corrupt_sector()
  btrfs-progs: print-tree: do sanity checks for dir items
  btrfs-progs: error out immediately if an unknown backref type is hit
  btrfs-progs: fix misc/038 test cases

 btrfs-corrupt-block.c                            |  7 ++++---
 kernel-shared/backref.c                          |  3 ++-
 kernel-shared/print-tree.c                       |  5 +++++
 .../038-backup-root-corruption/test.sh           | 16 ++++++++++++----
 4 files changed, 23 insertions(+), 8 deletions(-)

--
2.45.2


