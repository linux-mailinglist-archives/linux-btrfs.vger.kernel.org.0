Return-Path: <linux-btrfs+bounces-14257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884CAC5AAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 21:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228DA4A264E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D09288C02;
	Tue, 27 May 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqYuBQ9T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE9288500
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374132; cv=none; b=h5+CBWb6M12+HIblSUfPklG8Nvwszi8zX26w+dZEYlWDshTIE5essWFFOOJXJzkpWTXN5K3+L01AgZhvgmMfbqC8iAEpbwCafiutI9ymMpsMGOAiqXKmlQwbpDSHJxTIuoOwJzZt8oq8Itke6BJ+xQGbe1rxe0FK0EUYaCpoVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374132; c=relaxed/simple;
	bh=oGN6ry7ZySzg1Mb47PThhq8r1wIxxKGx0glbYn7/HII=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI2KmzYLenZAbqzUf3asOQzEbKdWyHWhRiS1Nps4oKh3HYuGJxY6i8w4HWmHHM5xNy93Y1jDr27cLxfUZitC9anG5uY7KgSNkxwxOyIrB/740kpuHTjypSs9vvSDBZE/CHHAPy1XpyCuelrE8Dq8+VCRody4nBG/ZZAahj4eTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqYuBQ9T; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-2d4e91512b4so1833431fac.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748374129; x=1748978929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GokeOo9QehtmqC5uHuSJQcNLgMZZEmiaAWT3wu3ZsaM=;
        b=iqYuBQ9T3+vOhRRcV/9TvaZoAoEqSQcjWGPXuqHeYpka9/wenEdK9SSfUMq/yMATkb
         wUBV+ughcQCC0p3sq7U1Z4fM0Ekl4N6er74kdi8Jy8iADF7iXpdmQAU9su3iBoNjrmjT
         9przs8S/vtqJMlSFG+olRnZlpufrsnxMUZxkfNVBIBp2esQoVzalA6lARuRMNrpV+JHM
         11fedcW6fFjo1R0Hp5KSr2UJo0sT/MIIdT5dfcX2m393MgBEGEXR0hngyLQHrHXdpvVb
         RK6YnBguo6NPf/Y7yaZYSUowBA1d1513ZjMlwccda5iiA7HUi1a5527ehjBTuHhxwyPM
         b2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748374129; x=1748978929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GokeOo9QehtmqC5uHuSJQcNLgMZZEmiaAWT3wu3ZsaM=;
        b=HlgE6FObWNrxoM8ZQzWgZI+NWlRiTUDFwAbEuoCEax83u5nLJa082u9r5HLYjhlRDl
         8h5LguwXMuiSgxH3EDM94B13H4VgWm58tNxYJvFT/kJtdui94fzH1AvSe/ocF/TZ5fxS
         smxFGkMAMtd3PDruQwrxV/KqCxL+E3QbWWCCy6f0Kl/4o43MKly0Hb602sFir3QM9Q7R
         z7N5qwat6bOgojTFXxKHMW3kc27AZUTj82sJECjhP+2ceMz5V9bQBBDB/weOml1YbehJ
         Eyd+FiljTd/jtVMzCRtzRtePc5xLhxjFwBM+GVfIOCSapx39Rj6R69e0X20nmGV3Gnso
         KRWQ==
X-Gm-Message-State: AOJu0YwcoVGHaS9TVC2aeytf4e4kO5DL5XlNDZDRm4au1ygAFKlD6s+/
	SjfetnTFD7FwKmsNKPCOOCsh2ySgToCDXbEIX3+diC08LRP6C3IAJB1X7l7QkN9A
X-Gm-Gg: ASbGnctIkWpkxDkdWJtk7L3Gt5Ws8Mm2i3P7N0L1ELohlQ7Nv3v7GVGCW3Ax87ZdMNj
	ofJURhAqrFK6FdIkmUqCHa3uaXdDI7/mPBm9W1+9NDz4H/rfYc2lBO/48pl5Ek0HzFnVi2Mmu40
	8rOa+ZRgJ1OfIjrvXSRTWN/rssbaDKD++ChvHnrE/MIqIHaU8ZrK6+axwagy5oVZEwv2dhMMsGF
	VzJW0ix68yETl81B9hIxR+bmILyjbhrDviBVtIbvYHgxIZF97Sg9//GhSgPImiS3F9cgaZoKJo1
	Fy0jMUPO7jKgiTC760H0G/eRqxdZlhVCmTqATPWPk8li4/w=
X-Google-Smtp-Source: AGHT+IElCFnqktFzO+9jdRMFXPP66UrD3LsLURLJD/3ecT3MKYK1DMDjxolCTA2mNhFPHtdFI7b9HQ==
X-Received: by 2002:a05:6870:1991:b0:2b8:78c0:2592 with SMTP id 586e51a60fabf-2e861eca298mr7248958fac.23.1748374129318;
        Tue, 27 May 2025 12:28:49 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:4f::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c0aa15f5sm5493563fac.39.2025.05.27.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 12:28:48 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: fix refcount leak in debug assertion
Date: Tue, 27 May 2025 12:28:35 -0700
Message-ID: <1696139274b2bd4327c008ed6df6f58cb5a8569e.1748373059.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748373059.git.loemra.dev@gmail.com>
References: <cover.1748373059.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the delayed_root is not empty we are increasing the number of
references to a delayed_node without decreasing it, causing a leak.
Fix by decrementing the delayed_node reference count.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/delayed-inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index c7cc24a5dd5e..f4e47bfc603b 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1377,7 +1377,12 @@ static int btrfs_wq_run_delayed_node(struct btrfs_delayed_root *delayed_root,
 
 void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
 {
-	WARN_ON(btrfs_first_delayed_node(fs_info->delayed_root));
+	struct btrfs_delayed_node *node = btrfs_first_delayed_node(fs_info->delayed_root);
+
+	WARN_ON(node);
+
+	if (node)
+		refcount_dec(&node->refs);
 }
 
 static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int seq)
-- 
2.47.1


