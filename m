Return-Path: <linux-btrfs+bounces-15596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C49B0C961
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8606A3AA714
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F482D1914;
	Mon, 21 Jul 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjFr3ydq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2702E1C56
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118204; cv=none; b=TC9uzPMpAJHyl9i3ZzuTtseD+sM0AyfTY0ckGDYy58YRlxxPqfiQef+1aFEqJr/oxbpq0d0Iel3dPPFLoaFIjR10hnForlGpr/Z7pfmtuk5GFkPTXKx+vIqg+ldbMDz72WPGMNKW8VifGU+YJ933bciCynX34lpiYLlx71xnrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118204; c=relaxed/simple;
	bh=bzD6yQzVTApXn5vqzg2l3nkRjTJa49PoNMaZ4+djs6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BXyyTRYqz2szefCD2cx2W+FY/2XxA0qt88n+XntBwPjSaxwLsRfBciJfmJ8IQ0QckkDN85SVoKT3hZrczQXGMM3nt2gmuHE7PDan8X4Bifik78ewtTWu+gqWomIFfkJ9F3sqdpxdv8eDkeu7P9ImXgG6Js6CtQxQy06FbP25AzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjFr3ydq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63569C4CEF7
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118203;
	bh=bzD6yQzVTApXn5vqzg2l3nkRjTJa49PoNMaZ4+djs6g=;
	h=From:To:Subject:Date:From;
	b=qjFr3ydqTO+rHQ6Y3yTjJ50FeTrvGhyqRN/RGdD+dXP2+lx+F3AgLhQD+skKF2FQ0
	 e2xjRmIGlJm0GTfop0bmfPmE8VfjICvi0hGmnUXHNhdtgORJQjU6zvGVWn+bMGSVUH
	 FpHcVTckjS5f/UsnZF5CW6jdYDdI9SER1AJRzmHuSsP3DBTQFm9UoIXuap+CEZaXK4
	 mXV9pqDmDzjB4+rAqRxXoW0IwD/Uv4n6e2ci3zRGgST+iHHst9il7K1gu4lAgu7Wsx
	 MwjOHP3vV8UP+FpwEgBi9Fpitr1J14+zVxTqwYcwXO4Ls47I8V6kyRM6lTq/ggHzIF
	 5CAZZMBl2URvw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/10] btrfs: improve error reporting for log tree replay
Date: Mon, 21 Jul 2025 18:16:27 +0100
Message-ID: <cover.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Most errors that happen during log replay or destroying a log tree are hard
to figure out where they come from, since typically deep in the call chain
of log tree walking we return errors and propagate them up to the caller of
the main log tree walk function, which then aborts the transaction or turns
the filesystem into error state (btrfs_handle_fs_error()). This means any
stack trace and message provided by a transaction abort or turning fs into
error state, doesn't provide information where exactly in the deep call
chain the error comes from.

These changes mostly make transacton aborts and btrfs_handle_fs_error()
calls where errors happen, so that we get much more useful information
which sometimes is enough to understand issues. The rest are just some
cleanups.

Filipe Manana (10):
  btrfs: error on missing block group when unaccounting log tree extent buffers
  btrfs: abort transaction on specific error places when walking log tree
  btrfs: abort transaction in the process_one_buffer() log tree walk callback
  btrfs: use local variable for the transaction handle in replay_one_buffer()
  btrfs: return real error from read_alloc_one_name() in drop_one_dir_item()
  btrfs: abort transaction where errors happen during log tree replay
  btrfs: exit early when replaying hole file extent item from a log tree
  btrfs: process inline extent earlier in replay_one_extent()
  btrfs: use local key variable to pass arguments in replay_one_extent()
  btrfs: collapse unaccount_log_buffer() into clean_log_buffer()

 fs/btrfs/tree-log.c | 659 +++++++++++++++++++++++++++-----------------
 1 file changed, 401 insertions(+), 258 deletions(-)

-- 
2.47.2


