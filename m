Return-Path: <linux-btrfs+bounces-15104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF1AEDE76
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1FC7AA8F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6428D82E;
	Mon, 30 Jun 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzP9ofj7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AF283FCE
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288875; cv=none; b=QcPtyDwhB2CXRjVlQn9TA//WxN0QQ+LssS6Ds9bKM//YkBk2yI1tvbl1BtQivWvQnsh9gcnJ1DzC3oyftgkjOskdAYXYdaMfy+sZUXKRXJMZR0enF4v77a5AeNnlPnZ2KmXqZIgG935FWuJDI1DD/oeJ86IfNH1qK57WIsk/Vb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288875; c=relaxed/simple;
	bh=xaqDtYHf0AOkJRf9snetc0iGLapJd/GxnSaFBg5oTLk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuuyvPcl2IH0WOnHt0PXiAuEqagHOWh1PtSGJk3+T7x+AofHyKjPLqZnabRuL+unGNYOh5NWaiIe8soqHK0lo8zerYyZ3o3niABeSr8Ve2gL9YNr/fw6cqDjYl5QGVDvlspHu9si/4O1fFg4VtJIRRlcjsplGJQjnHoxAWbNhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzP9ofj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29100C4CEE3
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751288874;
	bh=xaqDtYHf0AOkJRf9snetc0iGLapJd/GxnSaFBg5oTLk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PzP9ofj7yHdZT/IvUD24kEqqTlOlrhZV8vxwtAFSDGjzllbS586GLxIsi6mRRoJsc
	 aTk50a4qowipGtV96G0vlFXhTYqgzLiqDtnlxHPw5tYCtjvASGOSdCbN5WqWRCXW1G
	 zcbgZfAa0bAlvPlKtkTr01WiiRw/GG717nfQcOoEpH3bA4z1Hcj86CZ0geo2lZH7QM
	 WR4NNJX65Rsd1kxU2t6UTssuhaFsgP2UneslHtdiCFiPf5tA988Xh150GAXI6KyOrB
	 oCopsG+NyYcVffOaBhfd3QOyvdch+Ks99WQvaAWvUWPCKDlV+pr3aQmGBvJuSQNA1r
	 YRp7G4u6qoVJg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: qgroup race fix and cleanup
Date: Mon, 30 Jun 2025 14:07:46 +0100
Message-ID: <cover.1751288689.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1751286816.git.fdmanana@suse.com>
References: <cover.1751286816.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a race that leads to a use-after-free plus cleanup no longer used
qgroup_ulist.

V2: Update patch 1/2 to return -ENOTCONN if quotas are disabled when
    we try to start the rescan worker.
V3: Make patch 1/2 actually return -ENOTCONN.

Filipe Manana (2):
  btrfs: qgroup: fix race between quota disable and quota rescan ioctl
  btrfs: qgroup: remove no longer used fs_info->qgroup_ulist

 fs/btrfs/disk-io.c |  1 -
 fs/btrfs/fs.h      |  6 -----
 fs/btrfs/qgroup.c  | 57 ++++++++++++++++------------------------------
 3 files changed, 20 insertions(+), 44 deletions(-)

-- 
2.47.2


