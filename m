Return-Path: <linux-btrfs+bounces-19071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457DC6406F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 13:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D5C03604E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F968329C40;
	Mon, 17 Nov 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cecCm3dX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517482417F0
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763382372; cv=none; b=Zoz/umALwY5BuDsOO5lvGfijJ6bygxUMuMAVt4DfzHP9YnVdmK48TLLYcN2yh6A1EEGh9KIM0KY+uk0M3z0XvOR0ZbwhYmXa2M9/9DzWgZHianUjso1sTVCxSSc5U+jT7R0MAPyy3YD4GMlC1AbIX4sbNi1JDt+S2xzCNaJLxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763382372; c=relaxed/simple;
	bh=3BgrmRRZoEYitXDwLspXOBtz1MeJ1pv0xY/YxXu/WYc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ENQIDxPliiL6EZYS+7CymJKLP0VTCZRH55Lbk4F09vf5gvGgXEMjzP/yRIAe8smkjiwt9GaTTQVI4w9JHM34l057aHr8nqVwLlkWzeQKHiSJkptD2ryLYRM0WBMw5DoqYu1f5+iTdep6sth0Jp05Z1jNEHG0xs2JrR4TVeK3W9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cecCm3dX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B30C19425
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 12:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763382371;
	bh=3BgrmRRZoEYitXDwLspXOBtz1MeJ1pv0xY/YxXu/WYc=;
	h=From:To:Subject:Date:From;
	b=cecCm3dXEHZ8Yp7Z/B7AdYrmIRkGs9OZLhCMxOCkIS06wjJ+9IyFdumPlSXCGoATD
	 guf3L/8h4vxLQp9vBkdnxhX6UvY6NJQrgpetlCtnCcXVlZvjI2S12kiTozcMcrA6c6
	 NIaA0Uk6HdExXs0W8bEY3tPiTxNZkDjI5ObIhR/3K+7pSWCsihtQDvTUfb5jh1zXq8
	 unZCnYWdV9Wk8MpwCkXRl50AvcilfEEIQ3Oc/sJoo/hFTuw4xf3yftuVoMbHXQZ2Io
	 8BxcGA5Socxq0VkoGEJfC2LR8SBgxIlwmROwxbL0b1tvyJ2p22FO7lPlkKFMNf/tKY
	 A0eUjn5dZrgGw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: reduce size of struct find_free_extent_ctl
Date: Mon, 17 Nov 2025 12:26:06 +0000
Message-ID: <cover.1763381954.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Reduce the size of struct find_free_extent_ctl and use bool type for
some arguments that are defined as int but used as booleans. Details
in the change logs.

Filipe Manana (2):
  btrfs: use booleans for delalloc arguments and struct find_free_extent_ctl
  btrfs: place all boolean fields together in struct find_free_extent_ctl

 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/block-group.h |  2 +-
 fs/btrfs/direct-io.c   |  2 +-
 fs/btrfs/extent-tree.c | 16 +++++++---------
 fs/btrfs/extent-tree.h | 24 ++++++++++++------------
 fs/btrfs/inode.c       |  8 ++++----
 6 files changed, 26 insertions(+), 28 deletions(-)

-- 
2.47.2


