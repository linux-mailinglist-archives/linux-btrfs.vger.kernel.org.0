Return-Path: <linux-btrfs+bounces-7409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95D95BAAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 17:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EDAB24AA4
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A001CC17B;
	Thu, 22 Aug 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ryCyMiiU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694A1CC164
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341264; cv=none; b=c+5tiP7fozndedlYOqOOH7eii9m/wVY3Il2pwIOifOmg0zebbYYI5gRsMSwW4mTtJj6TNzpEIe8UYbBsHLB1yy6rB1M7YzMWoyqi287HtaekFTUaBmkd7LiS2prEoB8G2HJRC/VjQ9W4o6SRd5JrmHMNg0cUO9mLkuYpI6x+aR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341264; c=relaxed/simple;
	bh=8fSSHtdr74Se+Q/0rPKF6KVOBPFqqnuTwrHaWg4EJW8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=J+ow3UGRSPz2+wNAeECesPgnRj1fzi+J+oEx1alKVnhbr9FHtH8MRetLCk7qQmDWuLYa5+I0FWEMum3u5GIArKLXA5CvFYk3DWBDu/4MyWDznSTQe5gmayaQYYQoSN54nkPeo3S8QkJLn2Sa60320iMMIc6N5mfkGleBy3j5Cuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ryCyMiiU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6b2e6e7ad28so16902587b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724341260; x=1724946060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=497p4ousRDZxApeR8GB3kl8EB7bBl4hpHMmvGF/OkZA=;
        b=ryCyMiiUzbfKnBf+t6lBUw/Ue5w5oaIhKYhN0AJKhDHFCXQA4knmujrzOEwRQbnLvO
         AVp38ZlB4O9imrvG1AXCRdOmEeBu2WDwFYAFLvW5F5QqfB+YwFJUX2QLRaB4coNdjd4O
         Z7i+uTZ0PMYd5Vu/7nrd0lVib2oouiGAjWHqJrFmeLIRfOpmmhQblb54RMpXKuMxDmWr
         uUSnjVVOE53FHt8aiIF2kiyfpXKR6JLWscAQRqZ4Phl51Xi+s6SeNz677CdkEA9YoUQ+
         Ux2TStKfloeOOvFhgm21bgygaEXaW8WeJOi8GUx/lKoQYqLII5axQ9pVLVGqpPw732eS
         zHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724341260; x=1724946060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=497p4ousRDZxApeR8GB3kl8EB7bBl4hpHMmvGF/OkZA=;
        b=c7pgq5g3q1hNFgyOmI932vc3fkqKZwfnIAr5zSrlprhuhG04FofMdFeddXrgjkExXI
         t+J6WlKyVRswxj0biAft+G//II7uqilKfIJeu5/knfgNdg8ZW0M+pBAOSldD2sGRiTC+
         j5bJ9cQ9tMNvGeHa71IlisYUgzZgWuoh3/nZAxhVJTyDCdWqm5NaRC4OeFu1bLmCRFtR
         i8MfoDzett+9Xp+azjd59K/1RnZ6PXPWEDLasdbPtvsnvmHnmrbmgwpeCo2TNGA47DIe
         gbFYh/J34KpHjRxrrEVKTC5NZcCDYZ8PqkfSq7tXomhFZptTSfNujIA+iHxxOqx4lA5u
         OrEQ==
X-Gm-Message-State: AOJu0Ywk+1gl6kHSdyj3fHVKX923krhKM3T/C3Z4tXb9BGYp/EtL8DbW
	tupic3iBZwOG/FewVVHzutnJX5O8jPTQB3Rg7srgeeid4epNjRGchLf998mM0tx0lhIB98+FJeW
	e
X-Google-Smtp-Source: AGHT+IGahrTCF8+XEANKqfJey1eOsKMWFCGbqk5fDo/itfB9dPFzsGkILlOhvw63dQmJGNFHud6ksw==
X-Received: by 2002:a05:690c:385:b0:65f:7c41:30b2 with SMTP id 00721157ae682-6c303549026mr35985647b3.3.1724341260422;
        Thu, 22 Aug 2024 08:41:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39dd475d6sm2473657b3.123.2024.08.22.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:41:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: run delayed iputs when flushing delalloc
Date: Thu, 22 Aug 2024 11:40:55 -0400
Message-ID: <c718e1eef33488e3cd232a650b7c2d97701bbf24.1724341245.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have transient failures with btrfs/301, specifically in the part
where we do

for i in $(seq 0 10); do
	write 50m to file
	rm -f file
done

Sometimes this will result in a transient quota error, and it's because
sometimes we start writeback on the file which results in a delayed
iput, and thus the rm doesn't actually clean the file up.  When we're
flushing the quota space we need to run the delayed iputs to make sure
all the unlinks that we think have completed have actually completed.
This removes the small window where we could fail to find enough space
in our quota.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index be9a56a5d298..a77d2cd9d89d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4185,6 +4185,8 @@ static int try_flush_qgroup(struct btrfs_root *root)
 		return 0;
 	}
 
+	btrfs_run_delayed_iputs(root->fs_info);
+	btrfs_wait_on_delayed_iputs(root->fs_info);
 	ret = btrfs_start_delalloc_snapshot(root, true);
 	if (ret < 0)
 		goto out;
-- 
2.43.0


