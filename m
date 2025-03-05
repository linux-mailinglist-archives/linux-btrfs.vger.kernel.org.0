Return-Path: <linux-btrfs+bounces-12028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1DDA506AC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5CD1719C0
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 17:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862C1AAE2E;
	Wed,  5 Mar 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpyS88DD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C38B13633F
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196756; cv=none; b=RJaH3NisZSWNAcLtjeHq65LAouOceCYuNGzsEFS/YEcSVmhSN82RxemUfW8S4D1or6EiNWaq7ZCNmxTP/YKnO8AMxuB54R6ulCLayi5puBf1f7iyq0BZ51cpoOOnmaLNijySYOET/MPZHnwP8+xudomnCu3UAKO8Zb+od6p3yTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196756; c=relaxed/simple;
	bh=tKpekctY1PkhzPF9q4hCHLjwiuZw9H7vHzJw95LCHqI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LCX6bHRZPGX74ZiQyd6L7NDDa/R1of32QibgDHtnQoTauv/RPzoNuGVrcdeeYyHqawsmStWKhxRf0KvZ1xJ/fuFUDR8Mhp/uEraryq65wEFD9jkJG+ssv2+I9a003udKVFhPCMCqLvoUDUOEGxc+QHI2yez8/MMf82nZ5+ElQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpyS88DD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199ABC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196755;
	bh=tKpekctY1PkhzPF9q4hCHLjwiuZw9H7vHzJw95LCHqI=;
	h=From:To:Subject:Date:From;
	b=YpyS88DDMwZv+MoarwigjnmYqOPgOzLiWykfXU9Ydhz3kX1C3jzLHQTUTrtlFUHWM
	 JGHvC3XnOb6u9YXj7BeTosViPNgFIDCs/gX0InDzgsSUnFNz0og62eh9mNycpCef0q
	 rA6ZhywCMLAnkn1belUnownjM0HgaygsC13GGI8gqtmJ6JEoZRv3aPUHKdJUoIWhLc
	 pgbqsaedkdl8/2HmSGdsLGLtmOQzMEdOQLs3bJw5xnHrfsbqMWrTTJq+0I7hv8fi62
	 8FJPWvlp4buegR7j+ecnUPSFX1nhIuLbcgBuw1YOjusPe8j+XRYJsKa+S0ENph6JEj
	 vxhtBQg6Zq0sQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: fix unexpected delayed iputs at umount time and cleanups
Date: Wed,  5 Mar 2025 17:45:46 +0000
Message-Id: <cover.1741196484.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a couple races that can result in adding delayed iputs during umount after
we no longer expect to find any, triggering an assertion failure. Plus a couple
cleanups. Details in the change logs.

Filipe Manana (4):
  btrfs: fix non-empty delayed iputs list on unmount due to endio workers
  btrfs: fix non-empty delayed iputs list on unmount due to compressed write workers
  btrfs: move __btrfs_bio_end_io() code into its single caller
  btrfs: move btrfs_cleanup_bio() code into its single caller

 fs/btrfs/bio.c     | 36 ++++++++++++++----------------------
 fs/btrfs/disk-io.c | 23 +++++++++++++++++++++++
 2 files changed, 37 insertions(+), 22 deletions(-)

-- 
2.45.2


