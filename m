Return-Path: <linux-btrfs+bounces-19782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D8CC1C3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 10:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 341D7303938D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83387343D7F;
	Tue, 16 Dec 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="crG2gYvA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="crG2gYvA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A700343216
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765877053; cv=none; b=SeGTgoPKW683dGNmkatAmXBOB+zh6YmzrJr1mZ1Ii9GY13fBtKJhr+aP+KSKQlRwiPaXO1L5iPeZh0iGwu1IOedXrAYPNNq2hR7XaVgvnukIqqS5Z7PwJrm4AKAs5co5LkN5Zm5bFN8F0S/Y3YN4wM+jfpRwrNEM6Yq4lskE4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765877053; c=relaxed/simple;
	bh=ExMlSLOWhboVgs6japmiG0M0nzARFizm720ByrqR3lw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PZrwmnbHeyyfzBlIhKIDYhiNwim2Yiu00tdUt1gFOz9DpW5pMzhqa8Ile08x5IJUaXEApTK4U9k8cGwaCXOSTVM3ufakaLBDOQ1YExNjIzgO3Kge/dBkc3lsHPJqNGmW2n9XL9lwUE43JY1SUAl+SDTrujs966o9ItHc0vgFftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=crG2gYvA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=crG2gYvA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A65133692
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765877047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GnTH7wuWeSL+jqOlLxjZyBluvoi5Ejg18Gt2UuRNd5M=;
	b=crG2gYvALT0E8Nq8KwpGICYymgfysgY3lNkm7cFFa3ofUwccoDdjqcLO9v6TOAU3O2qBso
	EKpbelycfXisGMQTZvOWw7sMJW/9gce2M4FKkViuVkNXwFXa+q/REGXyEvQJrEdnTaNBpB
	Fzn2mX+k2ovV2bPZM+ShFD1AuxhMN2U=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=crG2gYvA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765877047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GnTH7wuWeSL+jqOlLxjZyBluvoi5Ejg18Gt2UuRNd5M=;
	b=crG2gYvALT0E8Nq8KwpGICYymgfysgY3lNkm7cFFa3ofUwccoDdjqcLO9v6TOAU3O2qBso
	EKpbelycfXisGMQTZvOWw7sMJW/9gce2M4FKkViuVkNXwFXa+q/REGXyEvQJrEdnTaNBpB
	Fzn2mX+k2ovV2bPZM+ShFD1AuxhMN2U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5670F3EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:24:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HqWiBjYlQWlKNQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:24:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs-progs: enhance detection on unknown keys in subvolumes
Date: Tue, 16 Dec 2025 19:53:46 +1030
Message-ID: <cover.1765876829.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 1A65133692
X-Spam-Flag: NO
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Add a new test case

This is inspired by a real world bitflip corruption, where an INODE_REF
is now 8 (an unknown key type), causing btrfs-check to freak out and the
existing INODE_REF/DIR_ITEM/DIR_INDEX repair is not cutting this
particular case for the original mode.

Lowmem mode is better, but for this particular image it's too large and
lowmem is too slow to be practical.

As the first step, detect and report such unknown keys in subvolume
trees as an error.

With a new test case for it.

In the long run we should allow btrfs-check --repair to delete such
unknown keys.

Qu Wenruo (2):
  btrfs-progs: enhance detection on unknown inode keys
  btrfs-progs: add a test case for unknown keys in subvolume trees

 check/main.c                                     |   7 +++++++
 check/mode-lowmem.c                              |   5 +++--
 check/mode-lowmem.h                              |   1 +
 tests/fsck-tests/069-unknown-fs-tree-key/test.sh |  14 ++++++++++++++
 .../unknown_key_empty.img.xz                     | Bin 0 -> 2084 bytes
 5 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 tests/fsck-tests/069-unknown-fs-tree-key/test.sh
 create mode 100644 tests/fsck-tests/069-unknown-fs-tree-key/unknown_key_empty.img.xz

--
2.52.0


