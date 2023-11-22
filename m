Return-Path: <linux-btrfs+bounces-292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA30B7F4E12
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8ADB20EE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46043584E8;
	Wed, 22 Nov 2023 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IfMZRu1E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04D783
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:03 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59b5484fbe6so73631277b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673483; x=1701278283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlq9xIxzihJ9Zp/3H5NzgI5FOteXkG6rNgvxYnjxSR8=;
        b=IfMZRu1EZOjVUaTsk10Np89gZNYBSklT25xlYVllCC7lwHpMJ81C9JqPwgfdhQx06a
         DZqO07g4yKjbFeaSGRxAkEIxCOzMbENlQ9oB0bDHgHoLecwMh9OPk6JQc9aD3WRpiChP
         I9ipk+4belmB/BSsJtrdMvOUFsxpCW/n92YyA4uzIjfpeEeOGFCSsc8o6/4TyNXDBiBk
         sSF5hCYhGtdohoj/yqNSz7KfA7TA8ocd5n5eA37wFPcY3NhRplJkelSZnTWwJdLVK7tv
         0j7X/T3+ZQZUsEOjRNSnQegeUVYRw9Y0pVtnfq7kYH1TR5drEP2vA60+/oIi4Yh+/GUL
         +zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673483; x=1701278283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlq9xIxzihJ9Zp/3H5NzgI5FOteXkG6rNgvxYnjxSR8=;
        b=occ1EkS1zaYwdc9JsFBIQFdBpxchrZBjaqeQZm3SfImt2GwovrY6e7bLbmHUlVaUo6
         DZ03t2btyqa3kcqqwR4BD0eqqZbbIB33KBnYBsc1WzL8V6LoLveiuRePKyeCrHVHzxkS
         DReP+/SqZN7C0VxhQDOlhN+QYQgKZbzkNsJt6XkFlW5B0NNpbqOBrPZmDJ6Z/eVWQX7j
         MHFvkELX3y8W7fYMkrsN/nrAqtrk16UTU3XiyKu5g2cPA0HCccamOqbi9Xf4qPD/xzBh
         ZhzeHMbrgNhG+UHKG16QL5rVorkT18c3Fgbw2zad+2C9jglOdlrGMIyAy3aW+6+u8Cpv
         le6g==
X-Gm-Message-State: AOJu0YzM0s4Cig83Tcdjxn/HiP7Ubd5XCsK7ClieGJ2AS7F0uZGfixyH
	Qlt3DCYqtrifmBp+f3XH7tEK5cXGbhOc0sKS/xVLkYNy
X-Google-Smtp-Source: AGHT+IGZogcjKabAq+uGnN6DonRu5ealS0dJfCQgkpsr0pTOcKgtk1QC11v1YDbxBgN1kr8KCnkGhQ==
X-Received: by 2002:a81:a1cc:0:b0:5ca:4b0a:e603 with SMTP id y195-20020a81a1cc000000b005ca4b0ae603mr2822425ywg.3.1700673482852;
        Wed, 22 Nov 2023 09:18:02 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p127-20020a0dcd85000000b005a7bbd713ddsm3764790ywd.108.2023.11.22.09.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 00/19] btrfs: convert to the new mount API
Date: Wed, 22 Nov 2023 12:17:36 -0500
Message-ID: <cover.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2->v3:
- Fixed up the various review comments from Dave and Anand.
- Added a patch to drop the deprecated mount options we currently have.

v1->v2:
- Fixed up some nits and paste errors.
- Fixed build failure with !ZONED.
- Fixed accidentally dropping BINARY_MOUNTDATA flag.
- Added Reviewed-by's collected up to this point.

These have run through our CI a few times, they haven't introduced any
regressions.

--- Original email ---
Hello,

These patches convert us to use the new mount API.  Christian tried to do this a
few months ago, but ran afoul of our preference to have a bunch of small
changes.  I started this series before I knew he had tried to convert us, so
there's a fair bit that's different, but I did copy his approach for the remount
bit.  I've linked to the original patch where I took inspiration, Christian let
me know if you want some other annotation for credit, I wasn't really sure the
best way to do that.

There are a few preparatory patches in the beginning, and then cleanups at the
end.  I took each call back one at a time to try and make it as small as
possible.  The resulting code is less, but the diffstat shows more insertions
that deletions.  This is because there are some big comment blocks around some
of the more subtle things that we're doing to hopefully make it more clear.

This is currently running through our CI.  I thought it was fine last week but
we had a bunch of new failures when I finished up the remount behavior.  However
today I discovered this was a regression in btrfs-progs, and I'm re-running the
tests with the fixes.  If anything major breaks in the CI I'll resend with
fixes, but I'm pretty sure these patches will pass without issue.

I utilized __maybe_unused liberally to make sure everything compiled while
applied.  The only "big" patch is where I went and removed the old API.  If
requested I can break that up a bit more, but I didn't think it was necessary.
I did make sure to keep it in its own patch, so the switch to the new mount API
path only has things we need to support the new mount API, and then the next
patch removes the old code.  Thanks,

Josef

Christian Brauner (1):
  fs: indicate request originates from old mount api

Josef Bacik (18):
  btrfs: split out the mount option validation code into its own helper
  btrfs: set default compress type at btrfs_init_fs_info time
  btrfs: move space cache settings into open_ctree
  btrfs: do not allow free space tree rebuild on extent tree v2
  btrfs: split out ro->rw and rw->ro helpers into their own functions
  btrfs: add a NOSPACECACHE mount option flag
  btrfs: add fs_parameter definitions
  btrfs: add parse_param callback for the new mount api
  btrfs: add fs context handling functions
  btrfs: add reconfigure callback for fs_context
  btrfs: add get_tree callback for new mount API
  btrfs: handle the ro->rw transition for mounting different subovls
  btrfs: switch to the new mount API
  btrfs: move the device specific mount options to super.c
  btrfs: remove old mount API code
  btrfs: move one shot mount option clearing to super.c
  btrfs: set clear_cache if we use usebackuproot
  btrfs: remove code for inode_cache and recovery mount options

 fs/btrfs/disk-io.c |   85 +-
 fs/btrfs/disk-io.h |    1 -
 fs/btrfs/fs.h      |   15 +-
 fs/btrfs/super.c   | 2357 +++++++++++++++++++++++---------------------
 fs/btrfs/super.h   |    5 +-
 fs/btrfs/zoned.c   |   16 +-
 fs/btrfs/zoned.h   |    6 +-
 fs/namespace.c     |   11 +
 8 files changed, 1263 insertions(+), 1233 deletions(-)

-- 
2.41.0


