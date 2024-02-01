Return-Path: <linux-btrfs+bounces-2034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E2845F5F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78811C22C1F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE9C127B5C;
	Thu,  1 Feb 2024 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsdAI/92"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B1C63064;
	Thu,  1 Feb 2024 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810641; cv=none; b=Ob9NwS+rzRyQ5CeBChxENGBViYD4WLzU6YIU6J9GsEL1CKNoDPZPo1aK/wyuxDVSAA5sfrisZ3fvVuwFVWw+vBJodFvQdhGSInmLGgurnX6AaZQrKFpPlHIvNfLJxzUJUCkZ34QzMQ7HQa8TOlI2D941zUSoOHzUWi85Dy4ee1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810641; c=relaxed/simple;
	bh=96ppUxJBx7LSRaXOuDSPWGA3cidzQAI0DSO/YVLLPQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AM/Lx8X6dISxyffxHAWf4lTEzQfKzdXWIt4Gma1KaczLfKovehf2jHk023DzZbHiMeT1bHQX6YxiRfhpUd1LgR3wL4dPL57Dp9otdNY6mShSR3Otfzk+/YV8aLFh2S2ee+9yZTvCMKxnhCyw4undPQ2avTIWk2Dmgtoe3P6JuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsdAI/92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C144C433F1;
	Thu,  1 Feb 2024 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810641;
	bh=96ppUxJBx7LSRaXOuDSPWGA3cidzQAI0DSO/YVLLPQA=;
	h=From:To:Cc:Subject:Date:From;
	b=TsdAI/92acWj9Ch+UEjETTbOlBF3WA1g9FVzx+LituDlcb/X0CulyxwdOzvmkpelK
	 c+AVb6/4CRbhpM7jlz/9343lWCsdVI0nadYYZEZRcqZ1bBXfjXiCRnp/TwUQU0dHJp
	 R9RJcbQbB5BS+ROo1329iRKm8e19YKm+2D3pnHZMRkz8HpyI29siuAnxaN5k/4e6uj
	 e/1a8ZdfHcuhMeHNqi/Hjjkl2trcQ/FeDqXEkFEo6NEQ7pVuEHvVzVpgCtaXAn5A8z
	 QFHDlivdQSyGP2c/uIZyxCN8pcRwSHCvhxdpKf2MvGB6n5VG0v4z1vjJSoV83Tqcin
	 fotPqDKMKIsCQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/4] btrfs: make test pass or skip them when using nodatacow
Date: Thu,  1 Feb 2024 18:03:46 +0000
Message-Id: <cover.1706810184.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several test btrfs test cases fail when using "-o nodatacow" in MOUNT_OPTIONS.
So fix that by either adapting the tests to pass or skip them if there's no
way for them to succeed in nodatacow mode.

Filipe Manana (4):
  btrfs: require no nodatacow for tests that exercise compression
  btrfs/173: make the test work when mounting with nodatacow
  btrfs/299: skip test if we were mounted with nodatacow
  btrfs: require no nodatacow for tests that exercise read repair

 tests/btrfs/024 | 1 +
 tests/btrfs/048 | 1 +
 tests/btrfs/059 | 1 +
 tests/btrfs/138 | 1 +
 tests/btrfs/140 | 3 ++-
 tests/btrfs/141 | 2 ++
 tests/btrfs/157 | 2 ++
 tests/btrfs/158 | 2 ++
 tests/btrfs/173 | 5 +++++
 tests/btrfs/215 | 2 ++
 tests/btrfs/234 | 1 +
 tests/btrfs/265 | 2 ++
 tests/btrfs/266 | 2 ++
 tests/btrfs/267 | 2 ++
 tests/btrfs/268 | 2 ++
 tests/btrfs/269 | 2 ++
 tests/btrfs/281 | 1 +
 tests/btrfs/289 | 2 ++
 tests/btrfs/299 | 3 +++
 19 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.40.1


