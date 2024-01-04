Return-Path: <linux-btrfs+bounces-1247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216EE82493B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 20:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B1128700E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 19:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251A2C1BC;
	Thu,  4 Jan 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="dqeG6XG3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA42C19E
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28bf1410e37so687633a91.2
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jan 2024 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1704397733; x=1705002533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1h+0myj9YujgReqAntLogeW/5yY4hauVmf5VRToRCc=;
        b=dqeG6XG3sP5o20me6BFiz7CcVrXj4T+PH+7RQV2nDf//5XxLZuNpdCcW9zv+Q7iUCM
         25/+Uu+zJ9AsBXrpKmXMI6BjYfM4Oa/BiKDo9VLzIXt4ythGRvzUmttJ4McH6EAixzKH
         yUXTRYdOxV8uFEgVNtqH5KVFC+032rvheFr2h3Qa7npghCDOw0HII6i8727GjgsLaHwo
         fyJ6JlAVJrbXM0VUhhqsfReR4A2/M2S5rMDe7O+mIsrBHzPGuThSG968owxQ+IBjOa4H
         4EmfMpdKXKVP+6ncw9owZYFtR8idzvoY+N5Gjicr4zYbB9JLGwpjXdoVbsJdMl63XMMC
         mS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397733; x=1705002533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1h+0myj9YujgReqAntLogeW/5yY4hauVmf5VRToRCc=;
        b=B6zdRfUnOHe9yLv39WM9nayX+gq74dzme1SVPiRMlXbPRcigwCMLfVs8lrWYNoqAr5
         bnpLGeRMd7ehCaHTBtqKB++R8e8cZc6gD5vGGkE+4QeneVZjuG5qiJdCdjLH81xVdiBY
         T+KkNg39HmBjYPnCxM9jGYIWGWGYhQ49WQ68ofDHwddUMR0h8dsBof3O97wjoeNdfI0P
         7syRzXbf4WW314J99/D86VQTT7hBRxqu2fjVNWGplXyprr+kR/WGW2c+J6HkOpkPwIXj
         HkmH3mOb0hY3SzNO+aJlTATFMFhbpMXTyJaYFdlJz2mqJY1+LjMWn7MZG51f3lEodUgG
         kvfQ==
X-Gm-Message-State: AOJu0YxeiC4F9VHJEc+O1+YyDHb+uyS8GfeD4YhHiCacUWG6bXlbYR2q
	mkf6X669IHm3M29cMQuGswOcZaLrpDSPBIVenXwvQtqbJT8=
X-Google-Smtp-Source: AGHT+IGAtoKqCqDf4MPeC3peSIlrLuxyWwhHDNHfjKhflFBlOKUmMkjiBloDY6Qj50waMCNrsvteeg==
X-Received: by 2002:a17:90a:1f81:b0:28c:26a2:4b70 with SMTP id x1-20020a17090a1f8100b0028c26a24b70mr1042117pja.66.1704397732615;
        Thu, 04 Jan 2024 11:48:52 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2620:10d:c090:400::4:ff66])
        by smtp.gmail.com with ESMTPSA id gf23-20020a17090ac7d700b0028c89298d36sm98431pjb.27.2024.01.04.11.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:48:52 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 0/2] btrfs: subvolume deletion vs. snapshot fixes
Date: Thu,  4 Jan 2024 11:48:45 -0800
Message-ID: <cover.1704397423.git.osandov@fb.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Hi,

This small series fixes a couple of bugs that can happen when trying to
snapshot a deleted subvolume. Patch 1 fixes a filesystem abort that we
hit in production. Patch 2 fixes another issue that Sweet Tea spotted
when reviewing patch 1.

An fstest was sent previously [1].

Thanks!

Changes from v1 [2]:

- Rebased on latest misc-next.
- Added patch 2.

1: https://lore.kernel.org/linux-btrfs/62415ffc97ff2db4fa65cdd6f9db6ddead8105cd.1703010806.git.osandov@osandov.com/
2: https://lore.kernel.org/linux-btrfs/068014bd3e90668525c295660862db2932e25087.1703010314.git.osandov@fb.com/

Omar Sandoval (2):
  btrfs: don't abort filesystem when attempting to snapshot deleted
    subvolume
  btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of
    subvolume being deleted

 fs/btrfs/inode.c | 22 +++++++++++++---------
 fs/btrfs/ioctl.c |  3 +++
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.43.0


