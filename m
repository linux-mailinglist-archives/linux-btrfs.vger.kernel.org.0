Return-Path: <linux-btrfs+bounces-4802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027968BEB41
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964DB1F21EA8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187BE16D319;
	Tue,  7 May 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Y7bu+Jv9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62E15ECC6
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105545; cv=none; b=emU9yEtbJIs5IE2D5VMhCN0FgQQDIbxSfKbgayKjuRTK5zgpyuUZ3eDIHhfZw7uYTmr1vd3Jw/4WKssLtRMtkBjfnhJrQBvRW4pBQ8auASDXz9AwayAF2rfnHbplx+U21fRrosLKpcMnw5Z68YY+kRBk5WscN+muwKRLTruOHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105545; c=relaxed/simple;
	bh=vMf2ZH6ex7vicYQcar4cguoIMmvtE/OLSicpO9Gexi4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t9qR+XcfZHyexJbdXR9zjXPmO2+tUJVJrbIKh6hCUhYE+Fxls401OCVo3OnFpzYVKpX/VdFFbnlwhU33ofuAGAduqBHinVkf+Linp8xycUGRh1/Oup0LlxkSd5JKQxHQN/VETGLXGuZV8g5IoJR0H0/GQPKXluE0QGzrUD9aIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Y7bu+Jv9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6202ad4cae3so31411127b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105542; x=1715710342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSavkRdQA9PRR1NRbKzbPL9+oFeOtoHrGxahx0QsQPQ=;
        b=Y7bu+Jv9OqkAtMkSWF/npYm+9y/deAFDPdD0ZKR4KjLjpsI39qVfOpX/TPASMxQvVo
         HYyPn9rmqPe4mY7hIVsKQEieb9riOrfytTbegsSXCTCw1HOyjH/jOpvflQlRtUpxw6HD
         WXvCTIMrSdikX+BJYJb1tqtnmrry+Mfo6b4Yq6GFd+Ibwi6cExh8f6nkRHqZX4x6Au8R
         nF+cSb4S4qZA6NVyHgGDF7M5qxxVrkx8naJ11XqCgXdUvGMgepYZXUjXraNNgF5PxGHt
         8hMCufQ2h8oQnW8grs72HbblQZseSChIvQlBKJR2hoa+/cBIvht1IA4gKaFY/1NqESD4
         +TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105542; x=1715710342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSavkRdQA9PRR1NRbKzbPL9+oFeOtoHrGxahx0QsQPQ=;
        b=TVzyUsiE4bNMr3DNTwwj+GZAinDYjEzX3K7VJ/jkuR0BbD6qH7jMuiGVjWCApEHMmS
         4cowea94NmtQo7XwB9kE95ULs1qmFd4xDMQeISM7MTqxUmUSV58P+1igZHc7iPCe0Gyt
         tuskasg6gYPCnpe4pbWu+SX9vv4D0zsciKIu6raLd8s2I6MtURykhkYbCaT6Wz4cVVEj
         nXWFo1u0qgs6/6t1WvdDfgX5ht8ixoBIfl2H70BnmyTIfsLJy/8m0J4hRcgv4TPGtBCL
         XiqRxS2bSsLlRYQBFW2+7YuG41nzk9eYXSus/1lvPnB7tTYCjTkDAI6BbdFGRHJ++Rwn
         uOqA==
X-Gm-Message-State: AOJu0YxtdnbFxcANL21H3rvOTAsdDIZZonYQ3qWvvKKRRgVOVoOFqH8I
	ZIoldUMe0nmgDnHkmBjsf541eZ6lauq/BVHtfezxexLxzawk/4MWoHXo4d1tEgCse5ZSENOmq/x
	h
X-Google-Smtp-Source: AGHT+IHx7XJo5SPnAta8hdgLnpqHRwVr+8ffOcuuEQHuSRi5l5lFOUyW3GVTRhEmmrcnz3eOYFseTA==
X-Received: by 2002:a81:a1d5:0:b0:60c:c31c:4f71 with SMTP id 00721157ae682-62085ade889mr6835787b3.42.1715105541911;
        Tue, 07 May 2024 11:12:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s20-20020a819f14000000b0061893c5bcf0sm2814675ywn.15.2024.05.07.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 00/15] btrfs: snapshot delete cleanups
Date: Tue,  7 May 2024 14:12:01 -0400
Message-ID: <cover.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2->v3:
- Fixed the bug pointed out by Dan https://lore.kernel.org/all/96789032-42fb-41c0-b16c-561ac00ca7c3@moroto.mountain/

v1->v2:
- Simply removed the btrfs_check_eb_owner() calls as per Qu's suggestion.
- Made the 0 reference count error be more verbose as per Dave's suggestion.

--- Original email ---

Hello,

In light of the recent fix for snapshot delete I looked around at the code to
see if it could be cleaned up.  I still feel like this could be reworked to make
the two stages clearer, but this series brings a lot of cleanups and
re-factoring as well as comments and documentation that hopefully make this code
easier for others to work in.  I've broken up the do_walk_down() function into
discreet peices that are better documented and describe their use.  I've also
taken the opportunity to remove a bunch of BUG_ON()'s in this code.  I've run
this through the CI a few times as I made a couple of errors, but it's passing
cleanly now.  Thanks,

Josef

Josef Bacik (15):
  btrfs: don't do find_extent_buffer in do_walk_down
  btrfs: remove all extra btrfs_check_eb_owner() calls
  btrfs: use btrfs_read_extent_buffer in do_walk_down
  btrfs: push lookup_info into walk_control
  btrfs: move the eb uptodate code into it's own helper
  btrfs: remove need_account in do_walk_down
  btrfs: unify logic to decide if we need to walk down into a node
  btrfs: extract the reference dropping code into it's own helper
  btrfs: don't BUG_ON ENOMEM in walk_down_proc
  btrfs: handle errors from ref mods during UPDATE_BACKREF
  btrfs: replace BUG_ON with ASSERT in walk_down_proc
  btrfs: clean up our handling of refs == 0 in snapshot delete
  btrfs: convert correctness BUG_ON()'s to ASSERT()'s in walk_up_proc
  btrfs: handle errors from btrfs_dec_ref properly
  btrfs: add documentation around snapshot delete

 fs/btrfs/ctree.c       |   7 +-
 fs/btrfs/disk-io.c     |   4 -
 fs/btrfs/extent-tree.c | 515 +++++++++++++++++++++++++++--------------
 3 files changed, 343 insertions(+), 183 deletions(-)

-- 
2.43.0


