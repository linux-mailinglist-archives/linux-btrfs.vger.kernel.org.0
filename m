Return-Path: <linux-btrfs+bounces-2669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601CF861562
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 16:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38F11F256BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402C81ADE;
	Fri, 23 Feb 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqiBpJAz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2C35EF1
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701596; cv=none; b=r4DJZE+g51XfLPaus6QkWbTroVsUOhonKluriJ/V5dRJwAFxiHLjLcFhcVlBnHwfj2NmauuiJUdEChuNuFP9f+/Ij6kh14aC3KSZhfbsOt0oAcljTP4i83aZf/IKG5L4ciTWT2C9yYvcym/LrWBebpV9opM56tSnUDl326H4vJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701596; c=relaxed/simple;
	bh=RXLNS1Csd3IZzNpotaaYjXtPSAA47bwNpJ2/jvef3qU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUdU/tNwBTkbwGlQ47F7dK1FKR9WXqrFukGQLBPBorVMy7eayE5ucja1ez51feg66Oovg3TvlGlr16lBQFDK2AdNaB2F7EHQ0jeWF+rQbldMwtjlPf1NyGucIIYbnVUmiTNw0LLMwmVnCI9TLQDZ3YoauoOzAhPPpbeT/NV9lFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqiBpJAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2912AC43390
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701595;
	bh=RXLNS1Csd3IZzNpotaaYjXtPSAA47bwNpJ2/jvef3qU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rqiBpJAzAH+BNoKOzpZU7b5f5D8/cIhtS9IN9vzU3KH3R30EDog9RqltjDMiT5BJn
	 4DVn76jSkvYSyas2R3SSbXKMrihG/V6H6m84a4MlzOZ2FfpNAaPKpwWXn7n9TmKhpi
	 RK5mEA6ANeWSvias85oAud+ScLfkZkrO8ufvH/yUbriZB0KVSfgTMb/mc+uyUB+UJe
	 ENBb5rEjz4wPOQ6AV+jDN+MwPPW5LLXO72FSHfo2E6sEDivV/B8ZC/GIuQjX7lwRUA
	 SXICdT2RbCcMgC2nZRxSoRAh4REkVtapzsiLyYSILv+9Z5qm5ox1caXsZtLCQ5fT63
	 6bVzmtVcf+WRg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: some fiemap fixes
Date: Fri, 23 Feb 2024 15:19:47 +0000
Message-Id: <cover.1708701186.git.fdmanana@suse.com>
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

V2: Updated patch 1/2 to deal with the case of a hole/prealloc extent
    with multiple delalloc ranges inside it.

Filipe Manana (2):
  btrfs: fix race between ordered extent completion and fiemap
  btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given

 fs/btrfs/extent_io.c | 60 +++++++++++++++++++++++++++++++-------------
 fs/btrfs/inode.c     | 22 +++++++++++++++-
 2 files changed, 64 insertions(+), 18 deletions(-)

-- 
2.40.1


