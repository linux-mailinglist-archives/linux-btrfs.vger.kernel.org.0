Return-Path: <linux-btrfs+bounces-2753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E152A862CA7
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 20:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB841F214B1
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2619BBA;
	Sun, 25 Feb 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4PG09XX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF3171BB
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708890690; cv=none; b=nLDLugFmPosOjpb5SN8DZMMt7rVAZ9USAKec24RTqJu8usVNZ5XLph0la/Nx3aOSyIs6UDum5/UxQDfmzB4RQoWnaKzla4DFJzH57wUAC/hiZepgWQ3ePS8jrx0O3K/NvZNU0m/BdhSBYpYp2Nz2PPq1uxNOdGR2nRLP1tB/Wi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708890690; c=relaxed/simple;
	bh=ixncfMde1q3kytYilWtNmGq1oB4CEHC9UV5BrFoGLX4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=haqaVQ3+6ScvUMUXkwPVFVb+jzgauQ3MkKdkfs+2OKGvt9xaLiKq+mMbFoEwhyG/FeIpy34mJxSidKDFsEOsNec01xCq2XU4Jb/sX0dSOcRwMvLUZYLVDDMVeUh8OfV2VUAaNofxOTs2my9WW/9dEnLox4hwHZMXMhEL87V8Pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4PG09XX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF53C433F1
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708890689;
	bh=ixncfMde1q3kytYilWtNmGq1oB4CEHC9UV5BrFoGLX4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J4PG09XXXQ2iMIb+3CnyYVqyw6Lf3YHTLr/n658Ua15hUwqOIVtqLvmJn/J+d/dCt
	 vDaDKPmHJ2sX1rPqx1xty61bPqkqcRPQWTO7F/Ra6EVcrRzP6VMYhXC8rDC4WBt5ZR
	 BEsa6l2POeVtoGkvXi/rrNxOUcwsUUwio0sSdPOCqnxehScuzEBCX7FzIQclmhrNB8
	 5EEqW+Q2U1tLW1uaiA1QSDLOjDzv+i/CSSioYlUqwXyoeQAC1UeMWymdlzvSM3I4cw
	 VCy43LQG4Dh1yWbY8u2fhel5G/ObIzK6jfPabzIeGeAm3nXIBgpYj9d9LSTQP1B94B
	 1QrHll1VEmy0g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/2] btrfs: some fiemap fixes
Date: Sun, 25 Feb 2024 19:51:23 +0000
Message-Id: <cover.1708797432.git.fdmanana@suse.com>
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

V4: Updated patch 1/2, added a lot more comments about that's going on,
    how each case is dealt with and why, added a missing handling for
    a delalloc case that could result in emmiting overlapping ranges.

V3: Deal with the case where offset == cache->offset which is also
    possible if we had delalloc in the range of a hole or prealloc extent.

V2: Updated patch 1/2 to deal with the case of a hole/prealloc extent
    with multiple delalloc ranges inside it.

Filipe Manana (2):
  btrfs: fix race between ordered extent completion and fiemap
  btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given

 fs/btrfs/extent_io.c | 124 ++++++++++++++++++++++++++++++++++++-------
 fs/btrfs/inode.c     |  22 +++++++-
 2 files changed, 125 insertions(+), 21 deletions(-)

-- 
2.40.1


