Return-Path: <linux-btrfs+bounces-9986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E39DF51C
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C309162634
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDC883CD3;
	Sun,  1 Dec 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMIwFkPM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2674BED
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Dec 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733045770; cv=none; b=eVa+j9Vtr+hACa62OlyqICsKq76ZVpXTYCK1VeFq/P0o7/JM0d0cM6EVo0nLalmUtge2SdlQxDtQvEc40l5nh5T4DmkVY6zDQZ69rNEPr9elkNdZ8CrJxv9pmJoWCpwKGbrWZhRq8OWSJU207qssltLGNvgWOLYhM3AIHYJ23Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733045770; c=relaxed/simple;
	bh=lB+n7whgH/n5VB95xkecNn+qN4Edltxk65mTNO9GcuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXhRq3EXy28yIfFxM9e5U50pZ38n6hO58uBkHwOausbJDerehpNW2vTOKKKjY8KeZoH8Sv0nVxIBTXq3f+LrUl0y3YljtbczlWllgu01ps8h5VrG0BEUunIj/j7cO+Ebn4ltTjfFmudsTvOV9/9k6PIluH4s8s1EaY4okQsWfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMIwFkPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12837C4CECF;
	Sun,  1 Dec 2024 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733045770;
	bh=lB+n7whgH/n5VB95xkecNn+qN4Edltxk65mTNO9GcuQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KMIwFkPMQ8zslzNAOc+6wPRDEKsOAEwMeuMFKRB2ycGuUyEoypVY8My6wd1fjcKxB
	 k+U6n3keJvW7n3YGyE5FJKiZ+LiYa6sFhmkU/BeiLL4reMqw7P5zU0KUU8FbVJCCHV
	 pY/aNqz3d8LZHGqq/14SsRuMnd/c90Wou41tYmgVy7FyBp/Yl3RXLs70giwZ2ivDmo
	 0MMdkeveCv2SMbMww5ZqhpkS+S6jqJ3HZPNTfR913KLwxzxJ+kW8rmTBt3mcpzEwHA
	 gyROky50Efez7rkrXf9mtv/X1+83Bua9MkRNq0Ns760ixvQnY+/WB2s29PdU6D9omn
	 NAOZJFOEu4N5Q==
From: Zorro Lang <zlang@kernel.org>
To: ltp@lists.linux.it
Cc: linux-btrfs@vger.kernel.org,
	zlang@redhat.com
Subject: [PATCH 0/3] LTP random fixes for xfs and btrfs
Date: Sun,  1 Dec 2024 17:36:03 +0800
Message-ID: <20241201093606.68993-1-zlang@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero

  It doesn't skip filesystems as its plan, fix it.

[PATCH 2/3] stat04+lstat03: fix bad blocksize mkfs option for xfs

  mkfs.xfs doesn't support "-b 1024", needs "-b size=1024"

[PATCH 3/3] stat04+lstat03: skip test on btrfs

  The "-b" option of mkfs.btrfs isn't a blocksize option, there's not blocksize
  option in mkfs.btrfs. So I'd like to skip this test for btrfs. But I'm not
  sure if there's better way, so CC *btrfs list* to get more review points for
  that.
  (BTW, better to have a common helper to deal with different filesystems'
   blocksize options in the future)

