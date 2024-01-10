Return-Path: <linux-btrfs+bounces-1376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACB282A208
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 21:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8997728DB47
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0884EB23;
	Wed, 10 Jan 2024 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="j9jIYgXn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97A4E1DE
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783045e88a6so398586485a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1704917799; x=1705522599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBFilUKDFnlkH9FlIUiNg3JOUShB6wO3itobT5MhAkc=;
        b=j9jIYgXn0ldoNYl1kv3XhOFcAwn//7lrD4p/BeIsT2m67+6K5LtZT1SaPGZyrWnSo3
         TpOwk6XuT9QWH2kcd7YxUsYEFrDVuMT6RKeJCtvczdTW+TiNjXM2mNkRIIlnrEHiG72m
         PFOhbythvzJhvFLco782Khq2qYCxyei1M0oOiEKvh72gKdlPY0Xk6kEbHaLCDAAzumc4
         gV5f0X43Kk/p+msuQ2lZpcJ4e65NUTEuaVgF1PsFVIhXIvzkPtwH2TdodAVAmb7CQY7P
         dApvqt9ksjYl9nHQA3lncREriU2v5J7qYS0OoUj5HjHZrsBR4O6+16k/6GNv4YC1qvct
         G9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704917799; x=1705522599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBFilUKDFnlkH9FlIUiNg3JOUShB6wO3itobT5MhAkc=;
        b=Fpz1j2658gbVXEpQ0zfg+2xC/z7YZjedmafHVlqx7u+D/Pkooj3JPmianw7QCF5gC/
         ep4NMExjqUL/MkwLA9SpJS+JsK9zxR0Os2R6fRwtTDkuamSKE/UR7vp64B7AWK98evy4
         g8g7p4sedCibz4Zwq4vi+X/2ZZt/tqOBp7cu9e87HWam/zk7n1WisNQFjvJLcDGcTyZZ
         7rIcIR8Gw/oFj1cyiWtrcHaj8cs6ipWJROaTu912jZtPDvlzkU1xU4GD9YS5ST0gzXoO
         uLAsk1OKJOoA1C55EEcnddRAk/F8t6J2MSnv259LmPW4dxieHseTccmrzJNAiyrjeJGD
         /3aQ==
X-Gm-Message-State: AOJu0YxHwT0XjJQLQ7T8WwzE9AlXTsOax1ppbWqfW7dLJN3HseEPAE4O
	79J0cV1AOKXnpW/iuTAoRzv3pQBH4QA8XMd1kksMBoB+60E=
X-Google-Smtp-Source: AGHT+IG+We4p6MsPHvLxt929DpEQhLU6qSlJSolGqT03nCMO9Xr70uLf8aZL9rgzsEFyne2pYKc/0A==
X-Received: by 2002:a05:620a:1245:b0:783:1a24:1715 with SMTP id a5-20020a05620a124500b007831a241715mr271150qkl.0.1704917799062;
        Wed, 10 Jan 2024 12:16:39 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f21-20020a05620a20d500b00781df19c062sm1830746qka.59.2024.01.10.12.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:16:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: do not restrict writes to devices
Date: Wed, 10 Jan 2024 15:16:35 -0500
Message-ID: <2fe68e18d89abb7313392c8da61aaa9881bbe945.1704917721.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a version of ead622674df5 ("btrfs: Do not restrict writes to
btrfs devices"), which pushes this restriction closer to where we use
bdev_open_by_path.  This was in the mount path, and changed when we
switched to the new mount api, and with that loss we suddenly weren't
able to mount.  Move this closer to where we use bdev_open_by_path so
changes on the upper layers don't mess anything up, and then we can
remove this when we merge the bdev holder patches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- This needs to go in before the new mount API patches when we rebase onto
  linus/master for the merge request, otherwise we won't be able to mount file
  systems.  I've put this at the beginning of the for-next branch in the github
  linux tree, which is rebased onto recent linus.

 fs/btrfs/volumes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d67785be2c77..9c8de7fad86e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -474,6 +474,9 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	struct block_device *bdev;
 	int ret;
 
+	/* No support for restricting writes to btrfs devices yet... */
+	flags &= ~BLK_OPEN_RESTRICT_WRITES;
+
 	*bdev_handle = bdev_open_by_path(device_path, flags, holder, NULL);
 
 	if (IS_ERR(*bdev_handle)) {
@@ -1322,6 +1325,9 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 	lockdep_assert_held(&uuid_mutex);
 
+	/* No support for restricting writes to btrfs devices yet... */
+	flags &= ~BLK_OPEN_RESTRICT_WRITES;
+
 	/*
 	 * we would like to check all the supers, but that would make
 	 * a btrfs mount succeed after a mkfs from a different FS.
-- 
2.43.0


