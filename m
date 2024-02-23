Return-Path: <linux-btrfs+bounces-2695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5018620C3
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 00:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FFF1F23D62
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 23:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD414DFE3;
	Fri, 23 Feb 2024 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNI6jdoa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A52208E
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732050; cv=none; b=BXiFa8fz9UmacAFq3Hw/lzSioyixyFakyzaL1K+KxZCN03htU5T1lnSTRf7tHN4gTRG62DGiWyj0VszjaMU08AVgXQCIwFcw2d8zn+kCP3paeNnGOzh9ybtpGr1CYT40wMryQ51oa7Kojw+fnhQWXR3achyZjwkvZAlGqO7NC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732050; c=relaxed/simple;
	bh=JzufSfTeGk3DqnUbWQOgBxwl5zPoivrcX2/1SkuMmwc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epB08aY7/XrmvknQumS1pz2PAmFQRgiQkuGZrfL3Z1efr6CoUPybx0c2vKa9iJwf+wofoxCTaJ/53wOOtwJUu/1VYRNxxdgdP40UIOkIKJZ+jrk4+dUPSil6KjAGc6dpljMRUIa6duclmAwNenyrf/44QB3hRiZjNA8F6wllWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNI6jdoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD08C433F1
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708732050;
	bh=JzufSfTeGk3DqnUbWQOgBxwl5zPoivrcX2/1SkuMmwc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kNI6jdoaboSXtM+ToG7cvROOUmU1sL6CxXh2BV3vIDVkOxVn2Nk8Xwm8jvaUK2OwX
	 6xvSpKg8hPjhoKFMq/FTar4FlQkUJm+k//4Jb/pARbu6PjPZ9DQmKGZuAMcrTzlRrx
	 A25Wtq3v9GX7vmoUNB5TozKcx4/joPZUQTLSb1fhQTmh8vuiS/gDi9LMIZFHyfl/zY
	 hmAFwbq8wGbFshge0/kieRWQwdZ/6xEhBghOWfBwSw7uPygi0qLZBXbq2tW5PfUgW4
	 8tjO2Q+cz8+0Ng9PgOKsMaFv4RSkfWSNvpEkYQ56B/9acTt/MEKW+/nVHDXwiMW4nO
	 JlGHgM+8TXGow==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: some fiemap fixes
Date: Fri, 23 Feb 2024 23:47:24 +0000
Message-Id: <cover.1708730657.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708635463.git.fdmanana@suse.com>
References: <cover.1708635463.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's a recent regression with fiemap due to a fix for a deadlock between
fiemap and memory mapped writes when the fiemap buffer is memory mapped to
the same file range, which leads to a race triggering a warning and making
fiemap fail. Plus one more long standing race when using FIEMAP_FLAG_SYNC.
Details in the change logs.

V3: Deal with the case where offset == cache->offset which is also
    possible if we had delalloc in the range of a hole or prealloc extent.

V2: Updated patch 1/2 to deal with the case of a hole/prealloc extent
    with multiple delalloc ranges inside it.

Filipe Manana (2):
  btrfs: fix race between ordered extent completion and fiemap
  btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given

 fs/btrfs/extent_io.c | 59 ++++++++++++++++++++++++++++++--------------
 fs/btrfs/inode.c     | 22 ++++++++++++++++-
 2 files changed, 61 insertions(+), 20 deletions(-)

-- 
2.40.1


