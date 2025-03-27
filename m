Return-Path: <linux-btrfs+bounces-12608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86651A73677
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C393F1891D5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E100E1A08B5;
	Thu, 27 Mar 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crtYQlf4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311341991B8
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092036; cv=none; b=mr/mi4oDEfV/JZci9KH8Yjqu2/RSO9Gxhm3GP88jwfGjNGzgrlP1aQOcDVvVXhdR90uVYhKXnXykIV5rOW8vNR4XctQKsQptYMznWzmgAoBoxSnHbcPTR5oUuJ87bCsOJ2rK9cqupcJcjoKF48GZ+TzcUPaZNYIEAgVTGvFqE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092036; c=relaxed/simple;
	bh=hIRue67y5yqS/U9jlLLYKyMOFygDJ5TS5+BQYbBb3g8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qcuPxjKWqcRFZRTf3axgiz0zZFSATHqWP6wLmPqe6lttVU5kbGv+QrgQmByZZ9scDaUnzJ28yweK7+6uWQjsAaw7oUD6X1aNfITEhf7uCc7mU3ev/orMF1QYZFUV/XN7ip/tNwR5VLTUC8+fv6XNhKTH+J03blRv+w2/ztRsbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crtYQlf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27168C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743092035;
	bh=hIRue67y5yqS/U9jlLLYKyMOFygDJ5TS5+BQYbBb3g8=;
	h=From:To:Subject:Date:From;
	b=crtYQlf4XYSsnAZjbGw8TjM/sTJ4VHGaZeubqmO6xJO8ea2DtyEHz9tLxbDWQI9F4
	 /KZt16gEkGcsnTP0LqOzG5EGIuSIpyFxjGeYaXJTr7vaYUKzcAD/5EGmR9XGHesCr2
	 +R++ivXmUiqcIj2FI/6/CRVYs5vLC+yy21Je3rXn7RLjTN/B5VsnEoxGFPikJBjEWN
	 vUvqHjqA3rNUNpDWre2GEhx6Km/EeR+58qdzrB6tpsoqcie0EgzPKTb+IKPdSkmoOy
	 w/uwsO1/rEwx8cUJTrlYUwuR0Zkud1tPW5Sxq0wmkPF58zqSqMyANr/h/96jMdMaO5
	 YGTfxvEgo7rsA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: improvements to the release_folio callback
Date: Thu, 27 Mar 2025 16:13:49 +0000
Message-Id: <cover.1743004734.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple improvements to the release_folio callback and an update to a
related function comment that's still referring to pages when the callback
is now folio aware. Details in the change logs.

Filipe Manana (3):
  btrfs: update comment for try_release_extent_state()
  btrfs: allow folios to be released while ordered extent is finishing
  btrfs: pass a pointer to get_range_bits() to cache first search result

 fs/btrfs/extent-io-tree.c | 34 ++++++++++++++++++++++
 fs/btrfs/extent-io-tree.h |  7 +++++
 fs/btrfs/extent_io.c      | 60 ++++++++++++++++++++++-----------------
 fs/btrfs/inode.c          |  6 ++--
 4 files changed, 79 insertions(+), 28 deletions(-)

-- 
2.45.2


