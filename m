Return-Path: <linux-btrfs+bounces-11639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFB0A3D7AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EB57A1B1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36D1F1539;
	Thu, 20 Feb 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0dp1OHq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A421F152F
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049491; cv=none; b=Fmcxxszzp5bUvImwDlpVKNdKFfZ2nrISiRuqfzv+1ObobLtzJboPW234n3AP8ADLIJbM/XyDHtViUvtYjWUAtDyEzLEulOSe/cc2G88/SlIQFD/6v9dRFJMvmisbzNWqKmKu/dXGecxkj1CUnI6U8YlT2Z1XEGI2cMsQznLQOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049491; c=relaxed/simple;
	bh=rdrI5QR7o7YSMAs7It4zSI9Pc91EI1TQvoSr4/qmDNk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwNZmQOLZt1/d705jvSjrUvzWM5AFEx9cGtmOBBChjnJjO+yhe1mSPnbavY+kN1byofzQORLTVdvCn8yVFVOfOGXiES5wX/l5i7wNcPIhrpLnPja9BBJdVXfUBUAKuGswlXoZmcEeywpQr+/VlYN+xGKdgoJjr5tcbgtBnYAmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0dp1OHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3ABC4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049491;
	bh=rdrI5QR7o7YSMAs7It4zSI9Pc91EI1TQvoSr4/qmDNk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=S0dp1OHqMZqr5mW/1mh0oUpZvV6M7v07/aLd0W3aYSIZhPeXmP6saIFc/E2C5XJQe
	 eObxS5pqdjwKrZa7RpIPyFG34kvAkAuQwOj9Bk4GRI8HpfiAINF5Bd8rEIEZVkfnA3
	 H4rRAOFuItTyPkgbHXUw3F+Slqkg4/DKteJA4cQmc/oEB9n+eCBHdOE4w24qylaM02
	 RkVFfhfgxw4hZu3SDvMlMdXXZJg+DAGEk1MF/LiI8MuR8CMzQZMw+vNeQiK9/0tx8d
	 druRjmy3gNSmUysr287WRW9Fh0jwZCV6v/FjVusiQns0sw0GsEF5jLK5UsGB7tf4c0
	 tHYEj8Q7RuF5g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/30] btrfs: send: simplify return logic from fs_path_prepare_for_add()
Date: Thu, 20 Feb 2025 11:04:17 +0000
Message-Id: <a6e5ef2197a0df3434dc49b92e929d321af5fa14.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9f9885dc1e10..535384028cb8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -535,7 +535,7 @@ static int fs_path_prepare_for_add(struct fs_path *p, int name_len,
 		new_len++;
 	ret = fs_path_ensure_buf(p, new_len);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (p->reversed) {
 		if (p->start != p->end)
@@ -550,8 +550,7 @@ static int fs_path_prepare_for_add(struct fs_path *p, int name_len,
 		*p->end = 0;
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static int fs_path_add(struct fs_path *p, const char *name, int name_len)
-- 
2.45.2


