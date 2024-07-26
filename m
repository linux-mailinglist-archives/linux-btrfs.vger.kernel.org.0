Return-Path: <linux-btrfs+bounces-6712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C829393D0BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 12:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046191C21767
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600BF176AD8;
	Fri, 26 Jul 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GM7mbISz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k+d3L0Mm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9BF143C5A
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988022; cv=none; b=ExAXy7fNKLSK5YWlm7fWW0JzL3zilsm8L/KGfyynbrAR0AtjNE2UW51mz73DrmSnQ9ci0MEQIbFRKm9pTqYAQXVVaiBR5EfTJf7yW02BKJrqpT874MgLdaviNG/Lx5FXwRAFVEQ7scINLfIs9rg1/hIxIKR6NowfMYyPC+sgbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988022; c=relaxed/simple;
	bh=dcQHFf/kdrdVd2jXLuvw2ClQoWasVJrlf5F+9i4oAbU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QE5o3krmJwiyIMOXqf2tOUfNVc5dnegeOeApDcWEcoYisEOmoNqGWViTEoVzRaYlGguZG6eyj1bGIGnqavWoTWrbqykeJLutzqD3GrWBJeapIa6Hp7GLe8BIIrzM3pEDWblB8MFsu+FdEc9tkA06dtgcwpzmR9EnQI9rb4oA0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GM7mbISz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k+d3L0Mm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E653421BD1
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721988019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FYZ4vlt61REYUlJ1afc2DyxPPy4NzvnUVQiTShMXZAk=;
	b=GM7mbISzf+B6UAJeYCqxxJWLwlha6xMzsNEZZmYfhlsog9F9Sj1sk5+PJZoY11lJMBCFqh
	LkZGi2zUwhsLrF3Cdfp059BW82YYoYgwlXhxczf55vz5Zj3mKaDvRkiZy8Ar528Uv941I1
	+P/zbBvPKIA+n8y9k4z1IcxTnuaV3cw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=k+d3L0Mm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721988018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FYZ4vlt61REYUlJ1afc2DyxPPy4NzvnUVQiTShMXZAk=;
	b=k+d3L0Mm+77VxIrdggfFalB0PH9cKNDiIfHe4lQ9i12t8zXMkUnhHLm5ex/NJU3atoRxyz
	kWFSfFrqqYhANkBkudy5/K7EDcqu8sqfCey5YK3UgHoaRBdafR8i/IXNWv4PPTn8bFNiAV
	PvJDaDguJ5NsK8+xCs4I5cqkIluqhe4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1557E1396E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DEJOMLFzo2YeTwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: a more generic uuid tree rebuild ability
Date: Fri, 26 Jul 2024 19:29:52 +0930
Message-ID: <cover.1721987605.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: E653421BD1

Inspired by Mark's previous attempt to add multi-subvolume mkfs support,
one of the problem he hits is the uuid tree generation.

Currently the uuid tree is only generated for mkfs, but that's
hard-coded for FS_TREE. Furthermore btrfs-convert doesn't really
generate a UUID tree at all.

Thus this patchset introduces a more generic uuid tree rebuild, without
the need to touch the existing subvolume creation code.

This is done by:

- Create a new uuid tree if there is not one

- Empty the existing uuid tree

- Iterate through all subvolumes
  * If the subvolume has no valid UUID, regenerate one
  * Add the uuid entry for the subvolume UUID
  * If the subvolume has received UUID, also add it to UUID tree

This can handle all the situations I can think of, include the future
multi-subvolume mkfs support.

The first two patches are just cleanup and preparation, the main dish is
the last patch.

Qu Wenruo (3):
  btrfs-progs: move uuid-tree definitions to kernel-shared/uuid-tree.h
  btrfs-progs: cross-port btrfs_uuid_tree_add() from kernel
  btrfs-progs: introduce btrfs_rebuild_uuid_tree() for mkfs and
    btrfs-convert

 common/root-tree-utils.c  | 265 ++++++++++++++++++++++++++++++++++++++
 common/root-tree-utils.h  |   1 +
 common/send-utils.c       |   1 +
 convert/main.c            |   5 +
 kernel-shared/ctree.h     |  11 --
 kernel-shared/uuid-tree.c | 120 +++++++++++++++++
 kernel-shared/uuid-tree.h |  35 +++++
 mkfs/main.c               |  94 +-------------
 8 files changed, 431 insertions(+), 101 deletions(-)
 create mode 100644 kernel-shared/uuid-tree.h

--
2.45.2


