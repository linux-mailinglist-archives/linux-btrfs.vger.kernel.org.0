Return-Path: <linux-btrfs+bounces-14115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E7ABBB54
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 12:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96A41897153
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE427464D;
	Mon, 19 May 2025 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGu+Nd9g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D972741A3
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651329; cv=none; b=qQYK4KJs3zGK802ARuLRxxb2rpVQGh4iuAtMNiz1kizddY3xWW2xcHha2puvoVqtOsxta91popCMNC2vvDEhSGkINTEHnR2cXgj6RF1Bt3MyT9D9LPCM5KCzGyaDeGHi2d31H4VD1RrwljZRz1nZqjV6ZRzyOEridZ8R2o0wypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651329; c=relaxed/simple;
	bh=c3bV2vDoRB+QZEF+9V8MlLgcVv3Smx8O3m6RQs4N6k8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OKuVdvx+CJObGF8tySaOU7f7ZY55q8+N5gaCakoGQnsd4zVHHeL7N7B8u67lkIFHcPZ00j2naeWFTde0XGrN4nm9ViZBLOtdGaQ6/oLyDFJybjsPFcTIIzCjRo9zFM64mqS9QAiGNKcPWZ1d35kWrqib17YgXb+3N3Kd+47BWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGu+Nd9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E3BC4CEEF
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 10:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747651328;
	bh=c3bV2vDoRB+QZEF+9V8MlLgcVv3Smx8O3m6RQs4N6k8=;
	h=From:To:Subject:Date:From;
	b=AGu+Nd9gfF9D1/BjP5aQsTDu5n6DVp7xyDiHcDVQKwHg0hXOtcpVPkruX0m9phd8j
	 0NOnUqwGUOfnpG4Lzs/FIZUdeUOreW3jJPfqCl9BkHXznitPMdspwfroLpPVMjBx2a
	 X09OXmWl62EiYej+1NGrdxMrWnN2VeNDn9+9+FYPzs2wC5o3xnrtJqqnTIvjzsKiYx
	 m9jJzCvR3mop9Pwi8YLz+84J+j4fUVFaIKq07ist7IYn0owNaqMDrZGjQqciRjsOFo
	 Jo01Hgc24oL2M069vDh9NbWHdpl1wuq4NG7w6jWthl0IE2wbFjMsB8kwnDYqpMx+YN
	 n3NP0VC46mhvw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some cleanups for btrfs_copy_root()
Date: Mon, 19 May 2025 11:42:03 +0100
Message-Id: <cover.1747649462.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple simple cleanups, details in the change logs.

Filipe Manana (2):
  btrfs: unfold transaction abort at btrfs_copy_root()
  btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()

 fs/btrfs/ctree.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

-- 
2.47.2


