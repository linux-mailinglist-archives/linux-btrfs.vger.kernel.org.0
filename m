Return-Path: <linux-btrfs+bounces-16879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B0B7DFDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0881C012BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231823054C5;
	Wed, 17 Sep 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryhkfn45"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFB30504F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095566; cv=none; b=EReZmWAaVGYzp409Fv7CZb3Pa0bNmGoE3oY3V+3UQNIECTiceX4K2mew9gOtjLOQjUzwJubldzJ2jnjeZxBCwSTWq5M2ZfPKIKJ6OR6ADDDE11I2UKOq7QiZndHpM1uWmsPzTuoktaDzuNc9I9IqLgoTxFQQuHb/rPVOSJHsuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095566; c=relaxed/simple;
	bh=9buOae3QQP8lCeHO3Ibjxk4bJwaJXwuoH1tuS5gAXhg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aBPhYqmeU5+d3S8mQT7voculirHtqPJOlsQ4cWyUpJvi1vKTTUspAaDEaZgKCqUF4kgIuGEazD+YgtRKbgSL7eq0imjlGtJn+5cJL13eZe3iY5rsRVp1UzKBE0pDAlNLfFqrzXrIZbtMlrKHCfrVapEIi/gPFWE8VRIBajuOtLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryhkfn45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E06C4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095565;
	bh=9buOae3QQP8lCeHO3Ibjxk4bJwaJXwuoH1tuS5gAXhg=;
	h=From:To:Subject:Date:From;
	b=ryhkfn45PR9xl3rJMjnDngGR514oXsm0pnOybl52hk+k83YvtUy9wYOwc2V3mGlhk
	 +QX7UpXTQEgCGjS/bJOBSKf4nnYKn1hvaefxpBOhZrcLBYsw/iB8r8+560HLLH34Yo
	 i7LIlSfCfiXCGtvXHpKyVWoFMOAsIDu3KdM2JALoPLIXsvWz1qGACs5tCoTyXW3Dpc
	 20civDBHeSLnpGzXy7UxhAD5YOsd7RAVPeQsti6BQYW+yPzsQcUu/kmNf1dMTk3xWe
	 zQ9JQRnSwjw9BpX0lnNwF35j5U78xhf2I1GGHaW3SfLrnWhIoJm9IY7PnFQ5LL/SsD
	 h/3wpJ+n0tdLQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: tag as unlikely several unexpected critical errors
Date: Wed, 17 Sep 2025 08:52:37 +0100
Message-ID: <cover.1758095164.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several critical error checks are never expected to be hit, so tag them
as unlikely. Details in the changelogs.

Filipe Manana (5):
  btrfs: store and use node size in local variable in check_eb_alignment()
  btrfs: mark extent buffer alignment checks as unlikely
  btrfs: mark as unlikely not uptodate check in read_extent_buffer_pages()
  btrfs: mark as unlikely not uptodate extent buffer checks when navigating btrees
  btrfs: mark leaf space and overflow checks as unlikely on insert and extension

 fs/btrfs/ctree.c     | 22 +++++++++++-----------
 fs/btrfs/extent_io.c | 21 +++++++++++----------
 2 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.47.2


