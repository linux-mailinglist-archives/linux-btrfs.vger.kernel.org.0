Return-Path: <linux-btrfs+bounces-4213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B0F8A3FA3
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B78282038
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015455823C;
	Sat, 13 Apr 2024 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="svx5ZfJk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0418E06
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052417; cv=none; b=L8tL3Pl3BAvoiGTwLy5hcXDGcZI8BAPgyVZ7/tjdanYUEiyuAhklBXcAE+AH3wQMtNXGe2mpEAh09HUX98vGzOwuhvmTKzn0xE8drAeis/JL5/m9SwqqGyRV5ABegyHf9J30SqMPZ0g9kCkFDtzzBNcuvNZgkkToxolAMNrhFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052417; c=relaxed/simple;
	bh=NgU29ycOL8aSsx67gB/M/Ds5RbzKztWhij+P5u0va6k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oSMe7KGeeJB2ALhuTL71IGFUZ+O9S+2UIg3jz4hMkTGLxQ8+7JhjD6aNv1gmz/z3uRJ5DVrhUDG5wLBwtXKoV84Kg3MS6l/MFUNjesGzqGvJHo7gI5t6dRm9VO/yGZW+O1BY4ESZ8xDXPWaeEFUuNqSBnB0j2a+5sCANEgoo9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=svx5ZfJk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69b10c9cdf4so11754236d6.1
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052413; x=1713657213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XpxEjePlvgq6DB3gENdH6LdV1sEXQzpKwtA7Lqwyvc=;
        b=svx5ZfJklyIxj5NiCsdnf0EVN3i2WwTavOKZ0kHNmstomd1wpEnTOPyUYKo/rX9PuQ
         mitZKWFV5/Cca0LZH10p7tEs7OdtLX9rpPLm7mRT/ZWMl9N00qdu2/43YWeaKUXbs8Lu
         4343Ae5bnvqubsGGcIVF+D6QeAIjYvG5nGOi1csjUeL7DUIFMZRw+F1J5RmLw0GgdT8X
         ob/MvzdrECMaflKyAElARv8qYMjoKpkaFh2zF7dt8sl9wKgx/BtYYUr6t+TjtSpPM/VY
         NMyHyxFoiGcDwm/lS9YgXc+nRvNcbRltxgaKKtigOOaZWdQiGTfc+Dl8Ok8wTm+TYrCh
         BziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052413; x=1713657213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XpxEjePlvgq6DB3gENdH6LdV1sEXQzpKwtA7Lqwyvc=;
        b=gUGtrhmY1X3hfZ+QQE4vppY6IFVOFywN0Uju6fjAU4FTbuLcbtusH0RNtfUJ2omGO3
         /k33Wgzf1pSsx/+vlgEXonNQSc/UBAup0Xp/UwxeOnDCInFH2ZR2qv1AsH9/ple463CD
         PLD1jlgKRVsQ3ensrm7iH98uxPpCTiE6h/tbukj0eLiXUOA6bA/wJNvVkKuMOB5eXAh7
         63FJbvNIpZfPyy21Z4NAn4Wh35+4hoZFGglsJHSTY6Xu3ji6J5wmfZcAw0bzP47C4Pm/
         8qCvbMXY2RUzM+EhKTDSLotLzbzgUYj7xKgae07yoIkyJCdbjxFokxw6STfDpfmpnhZk
         +epg==
X-Gm-Message-State: AOJu0YwPOUZ18RxU8jG27/idklDThCuhcepiub47p+BofmaeCQ9IeAi0
	rtfAMzmxFQ/KulYNbXMv3GZaq8Y6V0Uh758sQ2tbG5e4E02j21Rlw0iGR2UYQ7UjRh+tE9FBrGw
	U
X-Google-Smtp-Source: AGHT+IH0Ab90SwJfNaEAwix+furlTpp76PQO2uemjUgXXMB5vZfQ58VD2M6/RxKlnEEH2BgiWfFwxQ==
X-Received: by 2002:ad4:4050:0:b0:69b:59c1:f259 with SMTP id r16-20020ad44050000000b0069b59c1f259mr5631246qvp.17.1713052413640;
        Sat, 13 Apr 2024 16:53:33 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id gs15-20020a056214226f00b0069942a53f46sm1408796qvb.53.2024.04.13.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:33 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 00/19] btrfs: delayed refs cleanups
Date: Sat, 13 Apr 2024 19:53:10 -0400
Message-ID: <cover.1713052088.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While I was fixing the snapshot deletion corruption I noticed a lot of silly
duplication when it comes to delayed refs.  We have two things to refer to
references, and use different names for the same thing, anybody who doesn't know
what this code does would understandably be confused.

I reworked all of this to consolidate everything into btrfs_delayed_ref_node,
and got rid of the type specific wrapper structs.  I made the initialization of
the btrfs_ref for the actions clearer instead of a 6 argument initialization
function.  I used this simplification to reduce the duplicated code around
adding new delayed refs.  The result is a net removal of 130 lines of code, and
makes several of the call chains clearer as we just pass the
btrfs_delayed_ref_node around where we can.

I want to cleanup how we lookup delayed ref heads and how we handle those cases,
but I'm much more cautious around that code because there's some guarantees
about parallel modifications that are maintained by the current status quo, and
I'm afraid cleaning that code up will result in subtle bugs.

These cleanups should be relatively safe as they have no behavior changes.  I've
run it through fstests to validate nothing broke.  Thanks,

Josef

Josef Bacik (19):
  btrfs: add a helper to get the delayed ref node from the data/tree ref
  btrfs: embed data_ref and tree_ref in btrfs_delayed_ref_node
  btrfs: do not use a function to initialize btrfs_ref
  btrfs: move ref_root into btrfs_ref
  btrfs: pass btrfs_ref to init_delayed_ref_common
  btrfs: initialize btrfs_delayed_ref_head with btrfs_ref
  btrfs: move ref specific initialization into init_delayed_ref_common
  btrfs: simplify delayed ref tracepoints
  btrfs: unify the btrfs_add_delayed_*_ref helpers into one helper
  btrfs: rename ->len to ->num_bytes in btrfs_ref
  btrfs: move ->parent and ->ref_root into btrfs_delayed_ref_node
  btrfs: rename btrfs_data_ref->ino to ->objectid
  btrfs: make __btrfs_inc_extent_ref take a btrfs_delayed_ref_node
  btrfs: drop unnecessary arguments from __btrfs_free_extent
  btrfs: make the insert backref helpers take a btrfs_delayed_ref_node
  btrfs: stop referencing btrfs_delayed_data_ref directly
  btrfs: stop referencing btrfs_delayed_tree_ref directly
  btrfs: remove the btrfs_delayed_ref_node container helpers
  btrfs: replace btrfs_delayed_*_ref with btrfs_*_ref

 fs/btrfs/backref.c           |  40 ++--
 fs/btrfs/delayed-ref.c       | 369 +++++++++++------------------------
 fs/btrfs/delayed-ref.h       | 148 +++++++-------
 fs/btrfs/extent-tree.c       | 273 ++++++++++++--------------
 fs/btrfs/file.c              |  79 ++++----
 fs/btrfs/inode-item.c        |  16 +-
 fs/btrfs/ref-verify.c        |   8 +-
 fs/btrfs/relocation.c        |  84 +++++---
 fs/btrfs/tree-log.c          |  17 +-
 include/trace/events/btrfs.h |  56 ++----
 10 files changed, 479 insertions(+), 611 deletions(-)

-- 
2.43.0


