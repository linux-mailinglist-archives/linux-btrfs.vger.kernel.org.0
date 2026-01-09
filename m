Return-Path: <linux-btrfs+bounces-20329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82035D09BC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 13:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42DF03027E40
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531AB323406;
	Fri,  9 Jan 2026 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/SdIypV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359531ED69
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961796; cv=none; b=jXnTdcgZD5S8FC4shwdkOQfKCkm7OTZyYNBZwqazKysJLNZ3YU/QZhTV0UzmCtnsrwLRlWsYYNwDhpWQz4MfD3F2zTCYTsMMb84pXqb+tYEMlxy05f7gYH+b0puhlwCJA4y1uxUDOJiDD6Oa8wrZQXiAXYcw7nazBg6Pnt86XNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961796; c=relaxed/simple;
	bh=ZxiW9zOAMMRifwsI4f2c2swta/xyu7KQEj0O81ydomQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NYW2S4SVb0MTOF0TbSjMuypw+sRnPlOEs0w/ydEgiocmwHWhuXqBbGqTw3aBftZWN2lMRjNGLAw9pHxgMSifZPS8lNj7rWZjM0lpJqum12PqAD972GBrJgYz5U6fdhCr5MiCcRIcMixeNomf9JdVsr3tMD/aXAvlz4nrMQR8hjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/SdIypV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE959C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767961796;
	bh=ZxiW9zOAMMRifwsI4f2c2swta/xyu7KQEj0O81ydomQ=;
	h=From:To:Subject:Date:From;
	b=T/SdIypVNpfq8iBsT3E9/EcQTaUZ91NLrPkV2b1Gqt9XVx48JbQuhkC67yj0Id+GL
	 65Tf9McjYQqVi0Ww/6HL/I2m30X2IewvFjWkobbgYuVuRrh+W2+P4rbyEV6ZEQPwvT
	 6oWCWSFB14tdF1ihSroekPYowurcmrL04HelLgV61ky0Y7IhgkmxzvE77w4UjFjkyj
	 8hFGUyR9xwRhMoQiJKN7jehpfvfQAaaLeAtiWut8meXiSB6DIVBz5rOFYQZxU+qvSP
	 zIF6oHEkcoP99Rf6dLz+chtDln7niyQJis/T0Yjh9nk8dBmWjkm48+q2cy2W+R3RnA
	 zngcP/kNCI8WA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: reflink updates
Date: Fri,  9 Jan 2026 12:29:49 +0000
Message-ID: <cover.1767960735.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a bug where concurrent buffered reads with reflinks may return
unexpected zeroes when using large folios, and update a comment about
why we need to flush delalloc and wait for ordered extents before
attempting to invalidate the page cache.

V2: Updated patch 1/2 change logs and a stale comment.
    Added patch 2/2.

Filipe Manana (2):
  btrfs: invalidate pages instead of truncate after reflinking
  btrfs: update comment for delalloc flush and oe wait in btrfs_clone_files()

 fs/btrfs/reflink.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

-- 
2.47.2


