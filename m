Return-Path: <linux-btrfs+bounces-1780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 474FF83BEBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 11:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB2B286FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 10:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CB81CAA1;
	Thu, 25 Jan 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRqndaOJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877071CA95
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178392; cv=none; b=DQDhq12S6RcTyF4SEVMnMvXhpOJESziZkJmYkM+43KXmP2+QA5tUVb727WRRejkOOFt+/iiKgQ6M322PugJS6FCwHufa6smVZpCTSwfC0RAjCUvZUT/sXRKoWykVbWc1DcK7pPaqBhxAJI1+NnXjyp7AV1W26Ahj8LOFMrnT65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178392; c=relaxed/simple;
	bh=7FrmPtriUSfYwwbZALzwmNLp7jyb4VUDGzOBW/ewuhM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=WH3KZMVqXYH0OYkq2jN0bni6B/3eg1MJ1GnnmOu+K09d9EPElkxmPP4LtOf1m8Aiw9k+EZkAFZpC2182wPtNEkN4EJr3UZlSX2NKwA+MdAl+2hPLGCNvoVQO8SmLn9kniynsj0c0hlkDcC0HA4Ya4prELF8fwllueUQtFxB8DfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRqndaOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C5AC433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178392;
	bh=7FrmPtriUSfYwwbZALzwmNLp7jyb4VUDGzOBW/ewuhM=;
	h=From:To:Subject:Date:From;
	b=qRqndaOJryU8WW0k6dG9rbBYsTijhMRnwOTPFulAOxlctr39ZPhPX4wgNg6IB8bSw
	 s677gwXKBBPG98P0a78RM2vPd1+6iCn0M77uroXZapkzS1YdpUtM8sAbkg+bUgSfwZ
	 22l2nuFFlDz2lhnZO8JWivEI4vwXGa6e/TSkO/EmHWQ5XgGhLSP+a10XPwauGlG/VC
	 hqLzVrqrj+JXMKaUbunuBbkzGSrN732uB4GY3gU8CGyNqQq6ln2zLuE8IXQ2s0Se48
	 NhgKOUssW0796vftCqib13KxCM1q+b0aOT6SWiaqTez83MgEGYeFnKjaL9W87lOIG8
	 XojV/0QiFOiNw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: some fixes around unused block deletion
Date: Thu, 25 Jan 2024 10:26:23 +0000
Message-Id: <cover.1706177914.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These fix a couple issues regarding block group deletion, either deleting
an unused block group when it shouldn't be deleted due to outstanding
reservations relying on the block group, or unused block groups never
getting deleted since they were created due to pessimistic space
reservation and ended up never being used. More details on the change
logs of each patch.

Filipe Manana (5):
  btrfs: add and use helper to check if block group is used
  btrfs: do not delete unused block group if it may be used soon
  btrfs: add new unused block groups to the list of unused block groups
  btrfs: document what the spinlock unused_bgs_lock protects
  btrfs: add comment about list_is_singular() use at btrfs_delete_unused_bgs()

 fs/btrfs/block-group.c | 87 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/block-group.h |  7 ++++
 fs/btrfs/fs.h          |  3 ++
 3 files changed, 95 insertions(+), 2 deletions(-)

-- 
2.40.1


