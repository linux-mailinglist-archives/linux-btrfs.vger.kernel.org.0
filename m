Return-Path: <linux-btrfs+bounces-21670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yID9Lf9zj2kQRAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21670-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 19:57:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A0139114
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D13304224B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE0A28B7DB;
	Fri, 13 Feb 2026 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nx77Y2cN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nx77Y2cN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18B27EFE3
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009015; cv=none; b=AAo5nTW6OUxByDiyhwSdeemYR5NLe87UvtyLr6tBtMTV9S1Yrdrw04n5odyKHCxhZEYeSjQUituwVMxzgXwPU2l4Bltj+xszQHU1bp8JGbc+BnVOnj09WL3OdjbrHmm3r/mCS3acRLZ9Qq1R5BI/cH5GMoKXREaK7ma/6lRRuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009015; c=relaxed/simple;
	bh=1ceCPA+3Uwk0RtxejDx0wMp4s6v5xuD5+5UxgJp4thg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EYz3QCz7SNO4uRr6yUntC5SepGaa0NeCrV3zUe/ekwruxWarm9nMe0KIGxdfFqBSJBvIzvXidlwPWx0/vTwjOxqxSzzhgfUyzuFCKNSPe+WLXSYuJkv6WStfCyCovzQj47E2Z2Kov6p0zfZWpd2e2wCJxVq05eyjUb0AkCChJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nx77Y2cN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nx77Y2cN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23BC35BCDE
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771009012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MU4yHQ7iRCRO+6uZM449HSJfM6rkjocSYZpaqoONl0Q=;
	b=Nx77Y2cNmisOkFBJo9jsqumLfy/1idZYQ13qXsq56N6tMYBBenp6pVWuYNrU70XzbM36ot
	319gdKD5MJDsovAwAIQjDV7a8koRxKTNRxMgeZIZMtx9E8grZvnWAGrZNNTdY1jmNiYaon
	acdUqIwhtLxLIdO2J8delY2yTOWv0vI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771009012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MU4yHQ7iRCRO+6uZM449HSJfM6rkjocSYZpaqoONl0Q=;
	b=Nx77Y2cNmisOkFBJo9jsqumLfy/1idZYQ13qXsq56N6tMYBBenp6pVWuYNrU70XzbM36ot
	319gdKD5MJDsovAwAIQjDV7a8koRxKTNRxMgeZIZMtx9E8grZvnWAGrZNNTdY1jmNiYaon
	acdUqIwhtLxLIdO2J8delY2yTOWv0vI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 123063EA62
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 18:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /SpvBPRzj2m2SQAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 18:56:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.19
Date: Fri, 13 Feb 2026 19:56:46 +0100
Message-ID: <20260213185647.21966-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21670-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pypi.org:url,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 580A0139114
X-Rspamd-Action: no action

Hi,

btrfs-progs version 6.19 have been released (ther version 6.18 has been skipped).

There's change in mkfs.btrfs defaults, the block group tree is now enabled. A
note is printed (which was a last minute change and the release was redone, the
top commit is 9ac9a97ee3ebcc71).

Changelog:

* mkfs:
  * make block-group-tree default (support since linux 6.1), use -O ^bgt to
    unset it for backward compatibility
  * speed up initial device discard by procesing the ranges in order
  * disable block-grooup-tree feature if a dependent feature is explicitly
    unselected (like disabling no-holes), instead of erroring out
* check:
  * add ability to detect and fix missing orphan items in deleted subvolumes
  * add ability to fix inode refs from directory items
  * enhance detection on unknown inode keys
* libbtrfsutil:
  * minor version update to 1.4.0
  * add missing aliases for API updates done in 0.1.3, C and python
* libbtrfs:
  * patchlevel version update 0.1.5
  * error handling updates
* fixes:
  * with DUP profile and mixed sequential and conventional zoned make sure
    to track the right write pointers
  * scrub: fix ETA wraparound calculations, when many files get deleted
    during the operation bytes_scrubbed and bytes_total get too much out of
    sync, the ETA will be 0
* corrupt-block: add ability to specify key value when corrupting item keys
* experimental features:
  * initial remap tree support (new logical-to-logical mapping layer),
    coming in linux 7.0
* other:
  * documentation updates
  * CI updates, new and updated tests
  * code cleanups and refactoring

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.19
Python: https://pypi.org/project/btrfsutil/

