Return-Path: <linux-btrfs+bounces-1787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F8183C183
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 13:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D041F2681C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DAF3D99E;
	Thu, 25 Jan 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoWRNPvu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB93589C;
	Thu, 25 Jan 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184006; cv=none; b=nTPCnbFYdOdUhnKQDejk4uLtOX4xitVp5ujGdIRlUPpu58duw5Zr9gtcN48hIHRApbGFeWCjK4W9Kmd+U/hRgZbsBTwDycJ4aAJGCiDxt9jCT94vXwiNT+R0LXs5WNFHM+EZ9Rw8FxGIz6KmRcUtY8TLB6b7B3vI5CCO29+R+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184006; c=relaxed/simple;
	bh=hYpQ7CEzvle5EuuG/F5A+L14k1ZhxbBgAqet4EDoWeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S1FgOeldLi91K4GB0/dP5U7/sWN7XNMmnKCtvIuOJMD9cg9ho29KG1QWfcLwXu9G3J9PXzyImK/88FfCo2H1mnM9660FEsOl03HQVHT6SLQAMYJP/nNgWdQ2g/ptZM0PR741ul5SPQZOSQi/+aCJRtVNMfAyrqDkv7f8EJaCbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoWRNPvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A72C433F1;
	Thu, 25 Jan 2024 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706184006;
	bh=hYpQ7CEzvle5EuuG/F5A+L14k1ZhxbBgAqet4EDoWeA=;
	h=From:To:Cc:Subject:Date:From;
	b=NoWRNPvuH6fRc4RR7QmgJ1Ci1fFdrrXBWTPGQ+p8bwamD3pWYoP5D6QSUW1uengFV
	 qR7HtH9KaBKzrEBRwKWgXqDf8/TWmwoWg4OnzU9eKKQODEKsnTgQPHFN5H/jEoH3sG
	 xmKMNRUl92pp0ULMQza9wy+P2bIk/M5uYkWPbEs8UWzwzRs9i5DchGwFnd66p+Tzow
	 Y1MFGJ/tnEvhLtO1xMdN1zplSYvo+Ngac3W1MAmwmlfTpNE4W4/U3Wl5LBDtmy1184
	 PrM5nibtW6K4BTjCk3jIC1VrTJ7K7fmaggRV//btvHvEgES/LwHbArciIw5Ia2qobL
	 MAdLhlPNFpSZQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: erosca@de.adit-jv.com,
	Maksim.Paimushkin@se.bosch.com,
	Matthias.Thomae@de.bosch.com,
	Sebastian.Unger@bosch.com,
	Dirk.Behme@de.bosch.com,
	Eugeniu.Rosca@bosch.com,
	wqu@suse.com,
	dsterba@suse.com,
	stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/4 for 5.15 stable] btrfs: some directory fixes for stable 5.15
Date: Thu, 25 Jan 2024 11:59:34 +0000
Message-Id: <cover.1706183427.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Here follows the backport of some directory related fixes for the stable
5.15 tree. I tested these on top of 5.15.147.

These were recently requested at:

   https://lore.kernel.org/linux-btrfs/20240124225522.GA2614102@lxhi-087/

Filipe Manana (4):
  btrfs: fix infinite directory reads
  btrfs: set last dir index to the current last index when opening dir
  btrfs: refresh dir last index during a rewinddir(3) call
  btrfs: fix race between reading a directory and adding entries to it

 fs/btrfs/ctree.h         |   1 +
 fs/btrfs/delayed-inode.c |   5 +-
 fs/btrfs/delayed-inode.h |   1 +
 fs/btrfs/inode.c         | 150 +++++++++++++++++++++++++--------------
 4 files changed, 102 insertions(+), 55 deletions(-)

-- 
2.40.1


