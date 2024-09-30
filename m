Return-Path: <linux-btrfs+bounces-8348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB098AFCA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 00:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC2BB210E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B118891C;
	Mon, 30 Sep 2024 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcbT6eNT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB6185B74
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735094; cv=none; b=ISXqw5IPpjwQmsLxD63Cnm0Rbdmj/INOXFOwXoxqu3jat1phrbC4BuWGFTqTMkk91eKwH66Ad/uJReiLVM0HNnAHb77UCDO0FCUGveC03Uu4FqFdNue6i7KT0D+1+cMR4OCoh5sne1ZqRv5OfWuczaXjPbW8eEuN4LqFb3Utk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735094; c=relaxed/simple;
	bh=qjLXJDYNj6E8m47H7GOOXgRVaw45V0N0MvmeO3V5nn4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hLU3KLcieDPVbJH9Y56zMPrEZWbUfr2XiOW+oDr7gN9lFbHukqJb4dvhCBksL9RpTcoCGZjFEjQggb5sYxD+uUxrWoTdFsBXZN3tIXk3nUekn6Budg7OS2FnIhPrXt2m5wSZS2NGrKV1f089NWKJ1VGVOj8exd5OZQKacuLkt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcbT6eNT; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3e399ca48f3so1537102b6e.3
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727735092; x=1728339892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrAbCCpD6UBbIhcqNrRDftjQO6HpsFbMNMpArGRGcvg=;
        b=IcbT6eNTL8kYbmqDcK1Alm9KXZBp4K4Is8LlH4Jw+lRuRxz5MpxNQxRyd/n9ssJ+VQ
         UV0PRDL9ataHbkl/03DBUIEnPOTpQnSX6/lh2e9kVozywyp8btv7rNbhfWZwtZqEtEMA
         xsadQMCONwn5pPA0tmC9crAiEg8AWaFOJ/nuqpBRnl1tbKSl6QZtTTjKSYVByeeRLpjd
         U7mFDMragyipxwE2CMusFmrwk3FsnVc3X0gijTtsvcA/HHseARfskBlbxJhYnOMdqQeI
         kgbSArvPfZza6sMZ3CfRu8aEh3lnOL2xl4/rX8g4WIalp4Ktep8IuqI4uLrQAE6AF24o
         TaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727735092; x=1728339892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrAbCCpD6UBbIhcqNrRDftjQO6HpsFbMNMpArGRGcvg=;
        b=VrncgmJivqrJzZkWOjuvGIcMOr95Z1tkpnZKIFlQ6N3sZa2hhZ/SfsflD3nATHvrCZ
         NZk5kRFm/XsCUSlYn6S4Uichby1CVpSyLJ2AQo+D5MB7Esw/Wz0ZJcYHS7JGs2NjIbh7
         AQeSuRifgW+DDS2prk1AUdFJuVS3qjP+Hr8v2eY/CH+SrIJ8g/taNP9STw7fu950RmRq
         4DXtuJkViliitgErDGxeEH3nAapxD73LrgnQJ8mCV/MNvTe4yT0GoRNQxZpoVi6OrHC+
         tVx5O/YUadXIM2TqKvEvxlWULbj+93dYfFipS+hNUMecpK0nKniboIFVutilQOGbrpsv
         oxCA==
X-Gm-Message-State: AOJu0YxC2KeSd6gz1TxqTiD8De3HEiRXSpoP61y1SuAMw8bQeeg7fDrU
	cK9pheqVige8Ts3qCC/pGDDmcG7wThZCu85+cFV09DSv6qu8/BRFpHKQcq8w
X-Google-Smtp-Source: AGHT+IF/mrT5lcvH2mO+tBia5Xs79LHHfwPEdUHNYLsXMp8nmNSOc4hOWLMz+cP7MQku9Kv+u4pQUg==
X-Received: by 2002:a05:6808:1284:b0:3e0:42a3:21b2 with SMTP id 5614622812f47-3e39399b4bemr8993892b6e.28.1727735091899;
        Mon, 30 Sep 2024 15:24:51 -0700 (PDT)
Received: from localhost (fwdproxy-eag-003.fbsv.net. [2a03:2880:3ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e393587330sm2717480b6e.19.2024.09.30.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:24:51 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/2] btrfs-progs: mkfs free-space-info bug
Date: Mon, 30 Sep 2024 15:23:10 -0700
Message-ID: <cover.1727732460.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mkfs creates a few block-groups to bootstrap the filesystem.
Along with these block-groups some free-space-infos are created. When
the block-group cleanup happens the block-groups are deleted and the
free-space-infos are not. This patch set introduces a fix that deletes
the free-space-infos when the block-groups are deleted.

When implementing a test for my changes I found that there was already
some code in free-space-tree.c that attempts to verify that all
free-space-infos correspond to a block-group. This code only checks if
there exists a block-group that has an objectid >= free-space-info's
objectid. I added an additional check to make sure that the block-group
actually matches the free-space-info's objectid and offset.

Making this change to fsck will cause all filesystems that were created
using mkfs.btrfs to warn that there is some free-space-info that doesn't
correspond to a block-group. This seems like a bad idea, I considered
adding to the message to signify that this is not a big issue and maybe
point them to this patchset to get the fix. Open to ideas on how to
handle this.

Leo Martins (2):
  btrfs-progs: delete free space when deleting block group
  btrfs-progs: check free space maps to block group

 common/clear-cache.c            |  3 ++-
 kernel-shared/extent-tree.c     | 10 ++++++++++
 kernel-shared/free-space-tree.c |  3 +++
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.43.5


