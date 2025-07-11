Return-Path: <linux-btrfs+bounces-15478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7BFB025D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 22:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC5E7B5629
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660FF1FBE83;
	Fri, 11 Jul 2025 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uphGAKiF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF7A1C84A1
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266203; cv=none; b=ZKOXpVeMCXxAK6YHW8uwosZXd5BAs7q/LIlRYeXzxcW1Rm7cop9U6HaTvhgjSNy/QhJ17ysX0wklPb9rART03HWsyEZxyhB7uvcUw6tyEuNCXEiaNgjNrHYZFOCt0NuiMSWrnlS8RabHFvX0Driu4pRXIsrTCOhLZJ7QSxxbEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266203; c=relaxed/simple;
	bh=/Yo/a17vxprXbVIAraTFUXJyVfHh26hf/ZBm3Y/2oLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhqfXuOMDzE7knd4TbspQcbW/+j5LN6Su9sPWNYKqGgsUdPROeryCTA7679yY9MtCv/XEG8xkGcv1/QTzEwPxZa90AMTYE0B4FGdURkQvAEkXB3FUSy2g/fpj5DRbwnqBsIn/SwJzl1q1GIgLGkuUCaDC+miZizuz93929qtxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uphGAKiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A006BC4CEED
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752266203;
	bh=/Yo/a17vxprXbVIAraTFUXJyVfHh26hf/ZBm3Y/2oLE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uphGAKiFfXOSffLU9L88C7Zw/wDLRWOi3PgYuz66s7wsT+rkKIDLG/loF2RzaT6LF
	 VJO29Y29Hn4CkDkqE9ncaXVrDe2LIvHXR5Cg6fD+jKaG/CHMCUoORdFZxevVsjZzRP
	 BeGgBnqXZdN156qEtpH7P3YW8imveW/0S/L7CdsABEm/wwxsQGZwwUnzgbXjEgsMnM
	 QGM7As4NBGX2zMMxF3gNqQyM9dJNtRSJxd++S3cumseehFaIj371oZ2OD0qjQiWTfC
	 x4MMdY6nmRUeEWSljcIg0LhLUouAEremD6TrpqiTIkLZTo/+7I/WDjUi9QIKgm9J2+
	 UTR+4CeQLdIzg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: log replay bug fixes and cleanup
Date: Fri, 11 Jul 2025 21:36:37 +0100
Message-ID: <cover.1752266047.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752265165.git.fdmanana@suse.com>
References: <cover.1752265165.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple bug fixes for log replay and a cleanup.

V2: Updated patch 2/3 to avoid a NULL pointer deref on directory.

Filipe Manana (3):
  btrfs: don't ignore inode missing when replaying log tree
  btrfs: don't skip remaining extrefs if dir not found during log replay
  btrfs: use saner variable type and name to indicate extrefs at add_inode_ref()

 fs/btrfs/tree-log.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

-- 
2.47.2


