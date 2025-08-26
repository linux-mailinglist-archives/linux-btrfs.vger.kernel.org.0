Return-Path: <linux-btrfs+bounces-16405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF514B36EAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4A2981E03
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA9734DCFF;
	Tue, 26 Aug 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uxi7ohXq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08CB36934B
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222907; cv=none; b=IizuYw1s+omyWnq0pm4F0qEQXUzzxfPB5MciG8rXvSG/j+HjySLGjVFYmNViKrwDHCozxVyFnMNFSHmy8pZRTurmZb8Rzv6yxdR16YZ2aRmEKXutEsuGMR79hV9aSM+WUXY6Eb1xeEqr+tr0Dowlzp3R63Qbpb/zKL0P7bhtcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222907; c=relaxed/simple;
	bh=1ynNzpiuwPqZZfc4RXGfh4iGaVDz+/1Rc+r/9GR0kTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh2h4FziGNprcY3vGUsnDh6CzyUxpY43BdD6j3rOn7LWpr429Gdr5kario7YXlA1a5MCmhCbNCPSnr6TvK5GmM7a9rYHJHariLQ7lpBtWO9xQpF1+yWFa9Xyqqc7LEk4Wy1MzQoUsf3epp8no2sPmB6bLQUBgMC0TpMPRJp7Lwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uxi7ohXq; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96c77b8ff5so1849250276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222905; x=1756827705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=uxi7ohXqKUcBZO7Ua+hc/ajCXggSTI51qc1be8CHoDfUpzc91NJRWTj/ghdlaZYRf9
         UZg0KXNhymiGudejku1NoA3cYkQKamjzBVlLEFd6DdClC3w5WTOYjiwjrdo2npfRk5se
         rccY1P8OI+uIIFRIpkNDPGmZORCr2dsZ5FwzsD7zEg2OYIpROZqzcWcry128AHtFhHlp
         40XeOJZzb9CJ3Pw9dhXIg7BYAJHGtCSTnyJwArIl0VKn+2nxcrh0YTOXBwxok1KBlNTo
         i6+JRCs2Ohy6I6h+rp+4maxUIdO91tkyGK/4frTy/5B5MYdwS9dXV8z+ZV8yR/zK0Gls
         O3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222905; x=1756827705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=clVLvH8KUUKJyyotZUsyFohMMdpS8xz9sX3OS/Hnlg2OygL8ZZYPoajPDlXo0invHc
         f4X7j5P8tC6KAUEqa6Xgwz/YIbjbOavLoAtFgApG+71VHSA5CvzjcJJIvkjvQuedbZMx
         7qBfAEx+1P7mqrS8Pes2uk1VHKUD7Rm8REoCbljV3ewowdgrTRQTVE0mz6P69gz/tn2i
         Kj7zEsEm0YyEuPV6OV/c+gbCkn0SWih7ag0Vk53ZLkFG7qt+BSBGF463+WU/TK97ddFW
         mwQldCMwD64IJgRQnPGa5KQsPmCMc3V4XJ+eHFPMvnsmAj474Z33klwz8mLbxrqWHtjQ
         h1hA==
X-Forwarded-Encrypted: i=1; AJvYcCVkBFHrhLh4K2YBBGt6LGjl439XJA6kOpnzdMNvTUKcmQ8tOFZWTuVkmwMSTtZExupgxsUE0WwLY2dSkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYbe6GY1LcaZ5vlYD9UMwxy/GTq12OGcUKKzajSuvw/jd9DYt
	H34omEJxfA7s7g88ZL40aZl6UQm+C72qKEvKinJLyEQZAywd37nuXAwSiLzc7pjyMHA=
X-Gm-Gg: ASbGnctUoATxW1td24Ptmj86qn83JspqnvkaoCNw8ZUBT2EaPnYV4Rg2tOX0SIsX2gd
	vMO1d0Ba/uH0SmsPaVyRh/QMqZDO6ms9YDns9gDlOiIYNQG0Xtj96qL3qHJhLtkZ7tz3AgfHsMq
	jBeBGUZMyIh4YS7YfQlYqtG3ZFjViMqliybKyo2GQ/Kd2OsaGJGHAcma3CDzzEysWk550EB4mS2
	GHF9/tn42Qr+G9+v/YgIk2r4rOVzT8fZ5j1XadeSxq97gox0Imf8OeqmTHfXYhYkfhK3AdOBid9
	5iZk9bL7LUfsTdYXw2URPE02AgTzLM4Q7kwwM7aFSTkrKjtin4HjTt13Dkx+iwi/V1bMgzrj6kX
	JmsqdMxFA4KzRethKIWR3muqBlamaodxPPEkQbnYkXNtg6VhKzq2V6/aPDQYyodnkiDZLQEmEt8
	SM9D3z
X-Google-Smtp-Source: AGHT+IGukatO5Mwgl+iFpY8aNAJGoZlPwkGqVoc2HLHPS4uUtL3IivdATW29hDRBnU0HqwHw9U1Bqg==
X-Received: by 2002:a05:690c:6e93:b0:71c:1de5:5da8 with SMTP id 00721157ae682-71fdc40d339mr188030487b3.36.1756222904483;
        Tue, 26 Aug 2025 08:41:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5fbb1a885absm418881d50.4.2025.08.26.08.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 38/54] gfs2: remove I_WILL_FREE|I_FREEING usage
Date: Tue, 26 Aug 2025 11:39:38 -0400
Message-ID: <45b3bd8bf31cdb07d0b7db55655f66ab49ecc94f.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the reference count to check if the inode is live, use
that instead of checking I_WILL_FREE|I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/gfs2/ops_fstype.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c770006f8889..2b481fdc903d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1745,17 +1745,26 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
+again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
-		    !need_resched()) {
+		if ((inode->i_state & I_NEW) && !need_resched()) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode)) {
+			if (need_resched()) {
+				spin_unlock(&sb->s_inode_list_lock);
+				iput(toput_inode);
+				toput_inode = NULL;
+				cond_resched();
+				goto again;
+			}
+			continue;
+		}
 		spin_unlock(&sb->s_inode_list_lock);
 
 		iput(toput_inode);
-- 
2.49.0


