Return-Path: <linux-btrfs+bounces-5435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48EF8FB0BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 13:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625EBB215E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D51145347;
	Tue,  4 Jun 2024 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO4tqFsO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E5144D3B
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499336; cv=none; b=rbluVKyWvKaNSoehQOZ4pVFw83APeDDl9ET0t8sKtoorjLVaXPoSjLvpbhSf7GpLxGy2V55t3okoDn75SQwHjjVoUDeaIgI7+nN7+A9Z0ZRUviRjd2WpYGKzITId+5C1ggnM0tx2IEA4oYoQ24bpkvTNUSRQe/9W8FgVIzNQ0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499336; c=relaxed/simple;
	bh=dw1a8dHrW798J/jCUCFKDR1Crw+TkWiuPAzRIjVfxyM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=bwONFxuBldMtKFD7pcyqGeS5XPWAr+790CU3MNaSpQPLUg04TzH7Ai7idgMhnz0a6ieuIeUWO/hQgPru5V45HNojBqFQAu43Jc9ocTBm50775BZL6Fytr/iUSM9YgjqBzZC2eMF/ZulpAv8tXpbnOUx01wF3wCJhoAh7nJcZcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO4tqFsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6B7C2BBFC
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717499335;
	bh=dw1a8dHrW798J/jCUCFKDR1Crw+TkWiuPAzRIjVfxyM=;
	h=From:To:Subject:Date:From;
	b=TO4tqFsOjl6gwm2bOAePSt2+ElGEvtHm6kR8TCFprRqqFL92BWn09ycwBbwxsawq8
	 CAIFFsTZtP+DaQJahf8tRsgc5VpNNZXAFqt+MqegNfCRLDCB00aQe/EHAIg9NQ9PoR
	 +fqgSgWKEQyOwrLCVkoPC7i77QidgaDyT853+abuKgSD0iyC2n9OGZEQlSsKmJF0SP
	 CKU73FyRRuw7xEh/zN10cZ49Xa80qtFyFiba+EXAk0cuRP4Y31JpVaOB9cID4DgjCZ
	 xvSM5WKSHvV+ySNRINzKyDrCnDzMZhk7fRKhSNA8mLWuDIcxL+uKUIBaTKqp7gaNpr
	 A5892SxH3APHA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: some tweaks and cleanups around ordered extents
Date: Tue,  4 Jun 2024 12:08:46 +0100
Message-Id: <cover.1717495660.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Details in the individual change logs.

Filipe Manana (6):
  btrfs: reduce critical section at btrfs_wait_ordered_roots()
  btrfs: reduce critical section at btrfs_wait_ordered_extents()
  btrfs: add comment about locking to btrfs_split_ordered_extent()
  btrfs: avoid removal and re-insertion of split ordered extent
  btrfs: mark ordered extent insertion failure checks as unlikely
  btrfs: update panic message when splitting ordered extent

 fs/btrfs/ordered-data.c | 51 ++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 21 deletions(-)

-- 
2.43.0


