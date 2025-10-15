Return-Path: <linux-btrfs+bounces-17836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33091BDE68F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED9B1927CB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F9326D5E;
	Wed, 15 Oct 2025 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZVWSRhu/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZVWSRhu/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970029CE1
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530327; cv=none; b=pQs9YvZ+uQ5RKisnJk0SN66WKdEGpQB0pyX6RtBAdfJoKNb6o0yMNm2oueCRJbfK2VQI7ad1b1SMhKQ0Lkagl+3NBWj8jIda7borJCU0DM3GmhhOg2nbR2HYlPH+Zn6hHrSCOXzJPev7g4/kUkTQeEFQR8yyYJX1NCgEm0oLYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530327; c=relaxed/simple;
	bh=GwKTjGdtH8SyYzBBv2w+INFz3gkafze60sE6ebLVpJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYvWef8j/G7MMCOQCXWLfIoR6PQ2XFLrU0TOvE9wU+fpPGMXUJ+iNT7zDSmZRvOpDu3mrdQQe8Ltq85FIc1Lv07ihvSHarRe7+rLgA8Skd7vmpGdrQ4m58U+qcyTwztJeAPeSNQGL1TIVfHmJ2wC50sZKvqsjOSAwG4LYJdy9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZVWSRhu/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZVWSRhu/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DDB533855;
	Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760530322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OacZZNGxWtrqaDyrPXsR9AmEfSe8DiBBLFkHp1Qodgw=;
	b=ZVWSRhu/sa3jTV9DYnouUhxxj0zCpiZhVLO4rpAdubWf+ur4ppH4+dvHlqZAs7RLKYIx0R
	K3/ZBj7BSCFsKsHQuaBo8vdskI1wkWzYmqYg7o95xA+N6w6hnWtX039jNERF2w8Sr41jzH
	nNwwvaqCKr3py9cmlkDT16txmr9irbc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760530322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OacZZNGxWtrqaDyrPXsR9AmEfSe8DiBBLFkHp1Qodgw=;
	b=ZVWSRhu/sa3jTV9DYnouUhxxj0zCpiZhVLO4rpAdubWf+ur4ppH4+dvHlqZAs7RLKYIx0R
	K3/ZBj7BSCFsKsHQuaBo8vdskI1wkWzYmqYg7o95xA+N6w6hnWtX039jNERF2w8Sr41jzH
	nNwwvaqCKr3py9cmlkDT16txmr9irbc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B01813A42;
	Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z756HZKP72i2fAAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 15 Oct 2025 12:12:02 +0000
From: Daniel Vacek <neelx@suse.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 0/8] btrfs-progs: fscrypt updates
Date: Wed, 15 Oct 2025 14:11:48 +0200
Message-ID: <20251015121157.1348124-1-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.942];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.79

This series is a rebase of an older set of fscrypt related changes from
Sweet Tea Dorminy and Josef Bacik found here:
https://github.com/josefbacik/btrfs-progs/tree/fscrypt

The only difference is dropping of commit 56b7131 ("btrfs-progs: escape
unprintable characters in names") and a bit of code style changes.

The mentioned commit is no longer needed as a similar change was already
merged with commit ef7319362 ("btrfs-progs: dump-tree: escape special
characters in paths or xattrs").

I just had to add one trivial fixup so that the fstests could parse the
output correctly.

Daniel Vacek (1):
  btrfs-progs: string-utils: do not escape space while printing

Josef Bacik (1):
  btrfs-progs: check: fix max inline extent size

Sweet Tea Dorminy (6):
  btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
  btrfs-progs: start tracking extent encryption context info
  btrfs-progs: add inode encryption contexts
  btrfs-progs: interpret encrypted file extents.
  btrfs-progs: handle fscrypt context items
  btrfs-progs: check: update inline extent length checking

 check/main.c                    | 36 ++++++++++--------
 common/string-utils.c           |  1 -
 kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
 kernel-shared/ctree.h           |  3 +-
 kernel-shared/print-tree.c      | 41 +++++++++++++++++++++
 kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++------
 kernel-shared/uapi/btrfs.h      |  1 +
 kernel-shared/uapi/btrfs_tree.h | 27 +++++++++++++-
 8 files changed, 186 insertions(+), 31 deletions(-)

-- 
2.51.0


