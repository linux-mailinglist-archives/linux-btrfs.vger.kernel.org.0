Return-Path: <linux-btrfs+bounces-19029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0DBC5F6D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 22:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D28E94E48C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 21:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F795281504;
	Fri, 14 Nov 2025 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="laXKC43+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="laXKC43+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11258285C99
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156791; cv=none; b=NiVORkm+FYJ5ejwcrkgdvfkIu3sz1AoDnx7mMCd5UGemT1rk/NacfPJ5prIS9puD+IruiJQQIE4PaEDU7NyGEomlvPhFvyKvBIbdg5X67MWnXTsP7W5bHspExBvJCwruv9XHTYncoDo+5Aqb4ZlNvfqhuIOPZ4Z6HcYlgH2NVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156791; c=relaxed/simple;
	bh=B43hGQPhzvpmXepZeTu4GQpSEHm4yXpshFFDzT3r0TM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jCxHQObOzbxRGbQVL0dDwiQR7VGbh4iI31a0OIy3BkzZOOB08bUE6UXxqNsjCaqyt6taioU+gkGAEn+1u5pOVO2hzkUK3Xig5Bg4F72ZNa6omZElpYZPpnlGTfQgmylkBWtfwWEgcitTioY0t8fjJGqjTLpu5Hkktur5TGq3rIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=laXKC43+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=laXKC43+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3412F216EF
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763156787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cLagxUxj+hMPNMGJrsghXaBSGlhVH9W+23DzglAmn0Q=;
	b=laXKC43+GhyR1YloORLkcP+w0l0mPXpqWrG8FQCoFwzglFrY0yNrRid3UbEXDMMFd2cm+m
	kWLY84iPK3X25WZQ6VvvlzIWFZuC5vNWYpGXILIX6cyHiYqEemtYok0Yi9UU8j75iyFP6z
	d8zYgENOTYgoWW2rj2zEM0TPHuFtQvk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763156787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cLagxUxj+hMPNMGJrsghXaBSGlhVH9W+23DzglAmn0Q=;
	b=laXKC43+GhyR1YloORLkcP+w0l0mPXpqWrG8FQCoFwzglFrY0yNrRid3UbEXDMMFd2cm+m
	kWLY84iPK3X25WZQ6VvvlzIWFZuC5vNWYpGXILIX6cyHiYqEemtYok0Yi9UU8j75iyFP6z
	d8zYgENOTYgoWW2rj2zEM0TPHuFtQvk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 701C03EA61
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tra8DDKjF2l/FQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: check: add repair ability for missing root orphan item
Date: Sat, 15 Nov 2025 08:15:58 +1030
Message-ID: <cover.1763156743.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

There is another report of missing root orphan item, although the latest
btrfs-progs can detect such corruption, we have no way to fix it.

This makes the affected end users helpless, as the corruption can happen
for affected old kernels, and that damage is persistent.

Add the repair ability to save those affected end users.


Qu Wenruo (2):
  btrfs-progs: check: add repair ability for missing orphan root item
  btrfs-progs: fsck-tests: make test case 066 to be repairable

 check/main.c                                  |  5 +++
 check/mode-common.c                           | 33 +++++++++++++++++++
 check/mode-common.h                           |  1 +
 check/mode-lowmem.c                           | 13 ++++++--
 .../.lowmem_repairable                        |  0
 .../066-missing-root-orphan-item/test.sh      | 14 --------
 6 files changed, 49 insertions(+), 17 deletions(-)
 create mode 100644 tests/fsck-tests/066-missing-root-orphan-item/.lowmem_repairable
 delete mode 100755 tests/fsck-tests/066-missing-root-orphan-item/test.sh

--
2.51.2


