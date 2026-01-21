Return-Path: <linux-btrfs+bounces-20867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDvEJA1AcWnKfQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20867-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:07:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E085DCEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 915E0B26510
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DB34C802;
	Wed, 21 Jan 2026 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN29S2ea"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE04219FD
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028763; cv=none; b=TCFade/45tlJbEoAiNF2na0uoePk6aNWyhW8gcZ3/rdNeYfUuGf2BxMFD9SsswgS2ouwtzW75d6aOjrGeUYOJzUsSwQP72CYJ25NAspkEsdsPuIT3T4fNRUr/VvoIyn1f6GowyPMDXt0WNhEhWBUkbc3ls5CxyCnoa3HfQLLXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028763; c=relaxed/simple;
	bh=A0vwnBM8npLB4U/gakla3SChnL8LZb4SM8JnyT5xwow=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qp56Ukr9eyOFETHIpjLI8qxHDCj1udtzHc6INDK5w06F2qr8CpsGVocFceeiy0vC2HTRWNPH1quAJNAq+2xTEbMZXoAcRUNipv+ghXHjZXTK5Suqn2HDF2FXjjijGMtF9NeIfHcBVGuICN/iBJBppe9oBZKqdFjLLjCR7BFqT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN29S2ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B8FC4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 20:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769028763;
	bh=A0vwnBM8npLB4U/gakla3SChnL8LZb4SM8JnyT5xwow=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gN29S2eaotblAHkxnLEhXSyMZqWn1/swK/BXRTemxX8BPpFiFOPzioUgVVJP5n7IE
	 mKcVFtboyGzuyDe9/1xyNKxDISZkptayUQiMS2g5Ep8VFsUmuaMKsnFNo244KOx//w
	 OZr/iaVAlF5dFFAIiqr1K8sdX4E301avrCdaaVVjTx9BQm6aBxb/w2bvIvLEYejuNB
	 cMRlYbuu/AI61lepld7TDmCBEy/QPG9h/XosArJ+4wpi5vo7pIFx6TCqPKKHEPrMsj
	 zmMOdNeIUMANi4AHdkefSsLloLTzNojnNT7CEor9c3m/n4V/4FyJtnSccn1IXVTcVp
	 UaBQz/rKj2oGg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: remove bogus root search condition in sample_block_group_extent_item()
Date: Wed, 21 Jan 2026 20:52:37 +0000
Message-ID: <2f8b28463af1986b769f8eea29463eead1846745.1769028677.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20867-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 44E085DCEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There's no need to pass the maximum between the block group's start offset
and BTRFS_SUPER_INFO_OFFSET (64K) since we can't have any block groups
allocated in the first megabyte, as that's reserved space. Furthermore,
even if we could, the correct thing to do was to pass the block group's
start offset anyway - and that's precisely what we do for block groups
that happen to contain superblock mirror (the range for the super block
is never marked as free and it's marked as dirty in the
fs_info->excluded_extents io tree).

So simplify this and get rid of that maximum expression.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index feec6f513ea0..6387e11f8f8e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -606,8 +606,7 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 	lockdep_assert_held(&caching_ctl->mutex);
 	lockdep_assert_held_read(&fs_info->commit_root_sem);
 
-	extent_root = btrfs_extent_root(fs_info, max_t(u64, block_group->start,
-						       BTRFS_SUPER_INFO_OFFSET));
+	extent_root = btrfs_extent_root(fs_info, block_group->start);
 
 	search_offset = index * div_u64(block_group->length, max_index);
 	search_key.objectid = block_group->start + search_offset;
-- 
2.47.2


