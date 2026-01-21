Return-Path: <linux-btrfs+bounces-20868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMjGGr0/cWnKfQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20868-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:06:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D509B5DC8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08BF7B284F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B84219F1;
	Wed, 21 Jan 2026 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzSX3+3t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE7421EEA
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028764; cv=none; b=F333hiU2G01Cd+1xWaPZM/Xae6FYqd3LzO+CDgFUA6GpbNEjPbvVQQAUJA/Y7fbTQEhVx5oDdvNFsqMJLLe+hbvF5+C3om4Un41FTh9GI8sjkGI4h3kOQwJ8km/AVCNtdThtswBEVyavrFlu5RRzU1zztHx/VVeOV2yIUyXbgKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028764; c=relaxed/simple;
	bh=xbMstzAuwM7v9HTvr2oENZHaB2mMKK+Q1Qkhh+KPdBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyUb8wJPueygOyL/vYkIG0vDb5ThM0kIiod1DqtkoQejF+ipavlm18iLcqc4BXvmPGXYjRZafpdH8k0bRLNxI5wM76i2MAb6lDIb+FBJM4dcERM7qxYEALK5lmAog/CH/HGps2m8z2+kds0j2d6PH0yABbqI3p3e87pIribmgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzSX3+3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA1AC16AAE
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 20:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769028763;
	bh=xbMstzAuwM7v9HTvr2oENZHaB2mMKK+Q1Qkhh+KPdBw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NzSX3+3tqL5d6QaAU1Otq7YspFKlWgpU6EXkjxXDkwLSpVV6/PraUbzaPZSuDyt6l
	 ChuF6DU1w+a+UJGXhXRkpzSM0dD4FuA67NUu7cXnmHr+76yQT4T1KpRdNOdLJcsGc1
	 uHK5qAAQ+F+IgG4LO8JoNnZjrFIj8tJ0em18t9DWgcTjkrdYckXiB6BE2+Vuy+Hj4W
	 Torrmbfq7f22RivrLhkbzUiVLwJPYeHg7R5nyZJ3TzvBhlAfi6K6h6JEhI3CPhVMHY
	 ZmsL88PBVDdgp2auqktMRZLLDY3tcwQDkL2+O5JrDtwRoKxnBk8TgInORM2E9VDqwO
	 kqQjpZWuf/97w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: deal with missing root in sample_block_group_extent_item()
Date: Wed, 21 Jan 2026 20:52:38 +0000
Message-ID: <30034e48a39502638fbac40662914132895cca4b.1769028677.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1769028677.git.fdmanana@suse.com>
References: <cover.1769028677.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20868-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: D509B5DC8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

In case the does not exists, which is unexpected, btrfs_extent_root()
returns NULL, but we ignore that and so if it happens we can trigger
a NULL pointer dereference later. So verify if we found the root and
log an error message in case it's missing.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6387e11f8f8e..b3345792f3a1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -607,6 +607,12 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 	lockdep_assert_held_read(&fs_info->commit_root_sem);
 
 	extent_root = btrfs_extent_root(fs_info, block_group->start);
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info,
+			  "Could not find extent root for block group at offset %llu\n",
+			  block_group->start);
+		return -EUCLEAN;
+	}
 
 	search_offset = index * div_u64(block_group->length, max_index);
 	search_key.objectid = block_group->start + search_offset;
-- 
2.47.2


