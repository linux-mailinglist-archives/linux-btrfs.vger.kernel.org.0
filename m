Return-Path: <linux-btrfs+bounces-20839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPxgDhoKcWmPcQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20839-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:17:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA45A67F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC75FB2DB76
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B295313535;
	Wed, 21 Jan 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM2eTkOi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED2410D0A
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013049; cv=none; b=ZganlYohFV7AI9nKQCVHC0gdnASwsMKnQUC+616qf2MMLvp3O3s6WBslZq5VhKlNY0raMzaymHjSKYQn1I2chsIXHQXGiMlvl+jCp70dV/8WYicKXt4powwIXMOMZnyaOus314++NPf+2BabjV649pK0/lzhVTchpYHEdGb3VDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013049; c=relaxed/simple;
	bh=r9xAAN5np1FGSpQDA8K6s931LpKMlnN2r7qzlmyEafg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/llJYV458QXq/E9Gt9YZfA5s5N76cTEQ3moXqUR3dc0zevvMG9/wPbwKXGu1C33tRqJ1j8iApAdSeC1NMxgY6Zra8EoV1MuYlgKTUJjA1fI4qOdrwBhwkleTgVJuUVT0LQyVZ6aKWekS8ODTtFoa0bCz0zO9yuzMKuwWP4uLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM2eTkOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5888C4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013049;
	bh=r9xAAN5np1FGSpQDA8K6s931LpKMlnN2r7qzlmyEafg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RM2eTkOi0+wuaION6lw7+vtK48HZVSZ1VAbSwz4LQ9a8Cizk+wKLkxsiPFlDnRXyH
	 rE5Oy+Ip6LwR1TPylUJRRTgA19kyuduvHRbhB4iMSXzT1Lu+9USzUvbfArsxA6Al4l
	 f9kTQ4EXmKp51ExQwfldnfOpFf327g/xTFNiadBPqFp09OKUc/Cs8ahCoaNGgXCMnU
	 vJ6XI+fjOAJ0IfVt5h0q3BDp5oS2HAGGkbXx/q1aAaEy3qUbfPp1lju+879v+8401t
	 AuUUx0njC39xQAUvTw9KPYRcW1gxQJEL6n7nRsl2VPM9KIs2aAuPENEaFszhXdSLmp
	 Udr9KwC+v7z6w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/19] btrfs: fix a return value and remove pointless labels and gotos
Date: Wed, 21 Jan 2026 16:30:26 +0000
Message-ID: <cover.1769012876.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20839-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: D7EA45A67F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Remove pointless labels and gotos that can be replaced with a single
"return ret" or "return -SOMEERROR", making the code shorter and more
straighforward to follow and to not leave such examples for people to
copy and keep repeating it. The first patch fixes a bug in an error
path where we can end up returning success (0) instead of an error.

V2: Fix a couple wrong return values in send.c and lzo.c.

Filipe Manana (19):
  btrfs: qgroup: return correct error when deleting qgroup relation item
  btrfs: remove pointless out labels from ioctl.c
  btrfs: remove pointless out labels from send.c
  btrfs: remove pointless out labels from qgroup.c
  btrfs: remove pointless out labels from disk-io.c
  btrfs: remove pointless out labels from extent-tree.c
  btrfs: remove pointless out labels from free-space-cache.c
  btrfs: remove pointless out labels from inode.c
  btrfs: remove pointless out labels from uuid-tree.c
  btrfs: remove out label in load_extent_tree_free()
  btrfs: remove out_failed label in find_lock_delalloc_range()
  btrfs: remove out label in btrfs_csum_file_blocks()
  btrfs: remove out label in btrfs_mark_extent_written()
  btrfs: remove out label in lzo_decompress()
  btrfs: remove out label in scrub_find_fill_first_stripe()
  btrfs: remove out label in finish_verity()
  btrfs: remove out label in btrfs_check_rw_degradable()
  btrfs: remove out label in btrfs_init_space_info()
  btrfs: remove out label in btrfs_wait_for_commit()

 fs/btrfs/block-group.c      | 10 ++---
 fs/btrfs/disk-io.c          | 54 +++++++++++---------------
 fs/btrfs/extent-tree.c      | 24 +++++-------
 fs/btrfs/extent_io.c        |  5 +--
 fs/btrfs/file-item.c        | 16 ++++----
 fs/btrfs/file.c             | 30 +++++++--------
 fs/btrfs/free-space-cache.c | 28 ++++++--------
 fs/btrfs/inode.c            | 21 +++++-----
 fs/btrfs/ioctl.c            | 44 +++++++++------------
 fs/btrfs/lzo.c              | 17 ++++-----
 fs/btrfs/qgroup.c           | 22 +++++------
 fs/btrfs/scrub.c            |  8 ++--
 fs/btrfs/send.c             | 76 ++++++++++++++++---------------------
 fs/btrfs/space-info.c       | 13 +++----
 fs/btrfs/transaction.c      |  9 +++--
 fs/btrfs/uuid-tree.c        | 16 +++-----
 fs/btrfs/verity.c           | 13 +++----
 fs/btrfs/volumes.c          | 12 +++---
 18 files changed, 179 insertions(+), 239 deletions(-)

-- 
2.47.2


