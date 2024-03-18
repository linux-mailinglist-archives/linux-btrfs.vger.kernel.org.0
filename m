Return-Path: <linux-btrfs+bounces-3348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC887E92C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 13:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A24F1C21182
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907BC381B8;
	Mon, 18 Mar 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c70DVn8r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4337711
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764099; cv=none; b=hRfrdUGDgfoKCWydCfuI7wHJMH35WRFQMb2W8ZIhXdWJjTdqePSOcDudCuUzPdtW+4ptzM0jqLpaZPp0/Xca3teIZrn8sNMgqfGMmj/w7lA2CeONLpWgx3A5XhiuV6IeN0NAwFjvtBjt9L+f1Rukkc5+Syvwrv/BO6AU+QMxkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764099; c=relaxed/simple;
	bh=iC5aYyNQiZLW7/up13LPwNBJ8W048IpBz7NyA2WiHKc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=pq+Aaq79XDGyGlli5PbYdAGi9QJTD3KpKYiAQGpuUeRqRQ+2QJNC8q4hl20H6j7haWZsYWQabpSWWxv+VdmwxOM5dKM3CkK80IjFcxCHhmISxi9wKjjdKg50R7qacu52SWpI9P7QXwjKMPOUrCD5HACA3PZaS9fpVBAIrrxyhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c70DVn8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7548C433C7
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 12:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710764099;
	bh=iC5aYyNQiZLW7/up13LPwNBJ8W048IpBz7NyA2WiHKc=;
	h=From:To:Subject:Date:From;
	b=c70DVn8rL1zwkNTXebX/UfJFbziU4egkb07RzxL0+HZs+IEoO8ALwcfyIFu7vNcKf
	 cITCRboIn8fVX628jXu812omgLRmSO8ig25i7o22Kv+lHnQFXlgxWneW5v+XS+5Dfh
	 vS0f5IY5iGmhn5ma7JPzSH9nEy5sngc7GiTiI3BT7hEYP5rVbj0w/M9Z1mVKfXDwqF
	 x8yFoqhqibpwIIlHiHoPb+Au3JfmOKPbRBhS9xdk4c6O5Td9HTtto4eDefF0VtU7i8
	 6Zsz4mhIN1gM/Qqsw723k2QsWxPRFzdxEKbhnX85KSK/XoVez9xx0QFbEUdlGN1c6p
	 se+X5Z+3mB1cA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: remove a couple pointless callback wrappers
Date: Mon, 18 Mar 2024 12:14:54 +0000
Message-Id: <cover.1710763611.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Trivial stuff, details in the change logs.

Filipe Manana (2):
  btrfs: remove pointless readahead callback wrapper
  btrfs: remove pointless writepages callback wrapper

 fs/btrfs/extent_io.c |  5 ++---
 fs/btrfs/extent_io.h |  5 ++---
 fs/btrfs/inode.c     | 11 -----------
 3 files changed, 4 insertions(+), 17 deletions(-)

-- 
2.43.0


