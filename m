Return-Path: <linux-btrfs+bounces-15101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D021AEDE7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 15:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2343BF110
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B203628C00E;
	Mon, 30 Jun 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3VC1D/1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FB2D5407
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288515; cv=none; b=Tfe/I8rLf6A6dUuhahSBhsEduQjSr9sLjlJ4lk6JaMHZwDTj3rUJJ0icRwoELqJZcj8DNEd9BtNP69ir6ABzsM/5MZL2RCCGM0RHkM68Quum0/fvR4cZIPu7x15po2JNiq5GQ9x1I5kAcsFX1vNBOviLQ7N9+55e0xG/7CueFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288515; c=relaxed/simple;
	bh=+y2qWHsMaZAqW5VCICZb/kU7UCwuhA7WGk+UDNxMBoo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT1YGkdarWqWPzAE64JJKhK4REC3/5PVbz+DhkOfv9jEetq1QzEk3aFGBzHMQ8FXLvstKd9P82zVxZKGl8PQiU2ad/GNTS2ITaG6yhlN60R7B9o+jwaKatzRgiwAFjPFul7wFJfMwBHnSNUEDKuwom6JiCKJSK8MEeCUuTwehCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3VC1D/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE443C4CEE3
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751288514;
	bh=+y2qWHsMaZAqW5VCICZb/kU7UCwuhA7WGk+UDNxMBoo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A3VC1D/1CRtfxif9i6apInWn7xz4fZRwU1A91SzEUQxIFNIdmMMRa4WarQYv2iOS+
	 hqbCUhar38/190pUMudzd4sPYTjgYFro/JkZgmRbLO7eS5mKE5v24yIhI48ajDwkLz
	 OT5xaLoSNLL9Q3unerRuJmpDG1z6FSylHcS2eEK77G5zgJgZOtAXe3uhZjqiOTX4c6
	 ral+rtjvoYWWzvQKEac8UV153TrnGyttrI6cao2DCONxjX84TNLx10t3sxa8abiTRW
	 sSTOdEyOpJCOnr9ZC4F76lIJGOt42LFbaqWdqCXgam9p2T3ZBYoxrSgpGg80m3typv
	 rlp5VcBt1b8Aw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: qgroup race fix and cleanup
Date: Mon, 30 Jun 2025 14:01:49 +0100
Message-ID: <cover.1751288310.git.fdmanana@suse.com>
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

Filipe Manana (2):
  btrfs: qgroup: fix race between quota disable and quota rescan ioctl
  btrfs: qgroup: remove no longer used fs_info->qgroup_ulist

 fs/btrfs/disk-io.c |  1 -
 fs/btrfs/fs.h      |  6 -----
 fs/btrfs/qgroup.c  | 55 ++++++++++++++++------------------------------
 3 files changed, 19 insertions(+), 43 deletions(-)

-- 
2.47.2


