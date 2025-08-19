Return-Path: <linux-btrfs+bounces-16154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF71B2C286
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 14:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF12D16333D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199F32A3C2;
	Tue, 19 Aug 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka+SAGpe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F117202C5C;
	Tue, 19 Aug 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604865; cv=none; b=FRQvO1/onj5P6e1FNNtX8wip1lAPr75oHbeOmwHLxE68uzNHcilSDn8tsX4CxGX13RYO3JIhOpptjUSuK6F6lAdDcvY49jOXxRxmKKyI7OjUHBr66WhMtkW/Nx2KVStiDalPRUbChR9yTTb+9hlrhRqOo5pDOywyDZyvwEpMEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604865; c=relaxed/simple;
	bh=jcliUsfZpPZgCmB6n043pDFiQdp2C8kPCRpzmtP4aTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qx5piQ8uchWyiNYIipGnJeC8MaGLHNes4/ZLMxb4vwiFwdyM+TRxO8vdzxe0wYZWSML2RSSAvZV2aSKkDl31xlQv2BrGI5X8U6kk5/9r+tAdckZo6EEY/U96ay6lojGUMObpc4jSw/C+qwAekPWFhoiY/lAAk9/pTixqz9e/b9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka+SAGpe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4300147b3a.1;
        Tue, 19 Aug 2025 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755604862; x=1756209662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yw0y00gRV+ogA2X71w4d6peUD5C0gqTUv5oZj0ogsKs=;
        b=Ka+SAGpe/CCtBu6vpSVsnjcPMMw6xKoRXX/soVH30q+Ay3rWh8KIKwtWcC4UFMgKu4
         UvE68Ck0Ve71mkHAUHYrpwhknzif9XKnSwIR2XvXCANbBPKj6an+lFpbIoxQPyDU3vYA
         t5wBMqm6Ll6zVxYl8Xajgf2Br2Gd7Ym7501EKr06PqifM9hrfOS+rCCh4vdv7PZ3BWcI
         oEy83shRzBPHBSlLC/LuaUueJ7x+5n1TvbbBGQJbLmGGJgt+9SYyaEfSCRfDu36vOskR
         6QNKP4XLIWQ2vxy8wLLGJ4Sj2skXk4UsYXpyZaQ3QsmdpMx8VgdF1aq+P3XholgqerdS
         iIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755604862; x=1756209662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw0y00gRV+ogA2X71w4d6peUD5C0gqTUv5oZj0ogsKs=;
        b=q+prhWU8eBzTlX3DlRziwf/W2NYfEYkKVESeDpJYOqVBPD7E58b+D4dEV23lKbHIoG
         2DfIzbZuMevqwOYwqeZtyqQ0B8K4+ElXZMWageGSpiLt0UUGtj6EP+aiyqpMLxR49mtO
         aWZ78TcDLSmUWU7lMbQUu7a360Pv7HCaRAZRVSgNEb62umYMEmFfsMSE7de7w2pH4ctG
         HXMmwe/Jh6Obnr7oW+LlVqyAp84ezMXi+FG38pWTASfeyMWzgyuBTM42wf/1OazQsxWY
         5W7ueOioOjwKiz4uJ5Qa7umDZw4jeaKCQ7UCA9RXA53yZHKLauI3Vokcww9dIpxuGD8q
         6qQQ==
X-Gm-Message-State: AOJu0YybYIsckfRBtZm1LCME5pJpQYbzK5ycr9HzgwNg5KQwnuZho018
	ntEAzcEIZ5JguS8xxpdWKndNkHt//rsIVc2hq66QbeTM2GNXHIeegQ3pMg5NfzBj
X-Gm-Gg: ASbGncvE/01g68gcXKcZhCGoqZ8Kx9meZWVk7icgpvkVrikYJpddW76u6C2KAvbKFI3
	piqilEwXrVNcaDPwPquTjgNmC4ui4avxQW6LHHpYibROa3DX8sMi1MbKn/XfaAQGX6Me8F4tbri
	1Ds9Z+s84VFf/VYoLdIIKOtCyKilgfuU6LgGPWQkJXdRApiCrOXdKRLvVemyZhS4ZetqK3SViDI
	4irb4znTI6Wxj1hZWO5USHLktpi2isji29J/cINseFpPUTYnvpPHrrihBAYaSqcDIf6LO8dXHgT
	vCl2u1+2v/UFhLaPRvfWgV/rOJ4bcHWnJ8pV4g1SGqVcZpgzDrRsH0lv0OqUZ0rgDLc9rVpv6TK
	wIjE5NHQ2HCRUHOyZmEsi3seNXA==
X-Google-Smtp-Source: AGHT+IG4rOKCeNeqADRxkJ2vmOZaqAtE+v6RQIakSbnOswte3OQg/iIRrZoN7yFtwbH3lrJjAg3dUA==
X-Received: by 2002:a05:6a20:7f84:b0:23d:48fc:652b with SMTP id adf61e73a8af0-2430da83ec2mr2754411637.12.1755604861898;
        Tue, 19 Aug 2025 05:01:01 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d122ad7sm2331999b3a.36.2025.08.19.05.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:01:01 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com,
	quwenruo.btrfs@gmx.com
Subject: [PATCH v2 0/4] btrfs: Misc test fixes for large block/node sizes
Date: Tue, 19 Aug 2025 12:00:32 +0000
Message-Id: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the btrfs and generic tests are written with 4k block/node size in mind.
This patch fixes some of those tests to be compatible with other block/node sizes too.
We caught these bugs while running the auto group tests on btrfs with large
block/node sizes.

[v1] -> v2:
1. Removed the patch for btrfs/200 of [v1] - need more analysis on this.
2. Removed the first 2 patches of [v1] which introduced 2 new helper functions
3. btrfs/{137,301} and generic/274 - Instead of scaling the test dynamically
   based on the underlying disk block size, I have hardcoded the pwrite blocksizes
   and offsets to 64k which is aligned to all underlying fs block sizes <= 64.
4. For generic/563 - Doubled the iosize instead of btrfs specific hack to cover
   for btrfs write ranges.
5. Updated the commit messages

[v1] - https://lore.kernel.org/all/cover.1753769382.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (4):
  btrfs/301: Make the test compatible with all the supported block sizes
  generic/274: Make the pwrite block sizes and offsets to 64k
  btrfs/137: Make this test compatible with all supported block sizes
  generic/563: Increase the iosize to to cover for btrfs

 tests/btrfs/137     | 11 ++++----
 tests/btrfs/137.out | 66 ++++++++++++++++++++++-----------------------
 tests/btrfs/301     |  2 +-
 tests/generic/274   | 16 +++++------
 tests/generic/563   |  2 +-
 5 files changed, 49 insertions(+), 48 deletions(-)

--
2.34.1


