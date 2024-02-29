Return-Path: <linux-btrfs+bounces-2919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591F86C8A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770271C21407
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C227CF13;
	Thu, 29 Feb 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyq/2Dzq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839679B70
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207786; cv=none; b=DyomoRoS1F450wo6wiz5SJKgCaQwSbHKcbL3b5GWRkX1cthI6Pq6I/oQIrBgMbjh5NnejAPMs/R1rf3Q+A6xFLe3zpuDzZxqcZQJaZdAQKGBIOqBYudRTcfi4SBrvG2RK5ZHQ8MuQVwX+A9FhwQQt1nin0A92Fx/WgYGPFADe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207786; c=relaxed/simple;
	bh=pZfJHq4AtYcByz3+MDxWMHx4jjvKBLD69hxTrJbwV/I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=lowBnW9HLO2j+mT1WLOAB8K2ydqn/QuoxUX8yMWJEShOlN3GzePBf6SigVCJMBRuh5AKlcE8ce3GfFQDrcNVLXztpAKbJPbFyIO1Zt3hsrlT4BDyXFUJDc6Gts3hBKk45mdPTwHhncrkUXid0y67pNmkJdCj1PyB7I8R8p1SXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oyq/2Dzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798F6C433C7
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709207786;
	bh=pZfJHq4AtYcByz3+MDxWMHx4jjvKBLD69hxTrJbwV/I=;
	h=From:To:Subject:Date:From;
	b=Oyq/2DzqVDqwsx/C39KZY2dwsdUm06qAsW4C/QSy3wEehsZ4YcZQuaYDH6d/Ynjso
	 Y/CTXW/yr2yBsHsdGCM1b9RKCDcXCQTb0azWehvh98Jkfn3kcKX+0sbIecxowqJT85
	 bVRii1Fugka1dY3SrX6NP89Vg3ddA1TrtQclz+k4FfomJJbdN0JaaGd+oZCe153rH2
	 tFiXlBW0xe+kEF34IHIZjZ7lMnhS603R2ZOyayyjCajklL96s/VkE9Ul/mXNyv7zsg
	 LJYtX3cpfitnwMHKCRij/6dFPqUzFtg+YQx5oWpPcXGGnopMiXcHRO1Pab5MgyKoex
	 AOf2qI43tZ/zA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fiemap fix and optimization
Date: Thu, 29 Feb 2024 11:56:20 +0000
Message-Id: <cover.1709202499.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

One more fix for a regression introduced recently introduced to fiemap,
which can actually have serious consequences, as explained in the change
log of the first patch. The other is just a small optimization.
More details in the change logs.

Filipe Manana (2):
  btrfs: fix race when detecting delalloc ranges during fiemap
  btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations

 fs/btrfs/extent_io.c | 253 +++++++++++++++++++++++++++++++------------
 1 file changed, 184 insertions(+), 69 deletions(-)

-- 
2.40.1


