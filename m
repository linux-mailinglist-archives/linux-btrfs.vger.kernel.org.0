Return-Path: <linux-btrfs+bounces-17845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 036ABBDE734
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A330E34E2FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A662FFDF1;
	Wed, 15 Oct 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI1lEi7i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733131BCA9
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530885; cv=none; b=mG/VaLEpgbh8yQu9GoGCQkJOcPjR5ZfP1zq1Cmsg4p8ZQfdp710gVGhYHw2BWOJGz2gl3TDa6J0qK2w9tx4FoRXNCHD1fFIH30cm7n9emN57Q9i2qXju9h0/4f9qu7MuJ60eir7QCqTadlGg67565kI/3cVZerlmOBAOlNtMnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530885; c=relaxed/simple;
	bh=BUGLTCGVRo93zvWcQR8RAn3zvY+vzOF0nBlz/DGOykI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QlZDW2uavkd7dAgxZiNWPdOYnnA5HRwXwfEKk6UuRsuZFOcXKTcq3y/BLdrCPBQ9jGQKPYDd6RrZcKRIWvDu+hPP7LThdIVSvXB1klIXIh+bitMwgm9uCA4UM7IWrVJlra5DCbXYR4aL26TgAQQ1EAe+j4kH5zU9deabLM0FmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI1lEi7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01407C4CEF8
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530884;
	bh=BUGLTCGVRo93zvWcQR8RAn3zvY+vzOF0nBlz/DGOykI=;
	h=From:To:Subject:Date:From;
	b=fI1lEi7i2Ak2OGeFHSsQCIrQ0RSNrz6bE9/aSzY3Th/PQaeichLzTr4jRXRGjQ6k+
	 ugk7qmNYYZ3j0gOMKvPYgtatWCKmYR6AEyOKDF4VZ9/QEfHmyL2ddZXAE7uph0wTWb
	 TXqY/RSHFJjZZ2kTsixl4nDZ3CJWlqjohnOiFMde+EoB8afx3Jr+Ghfc1pSmqqHGfF
	 C1MMa14jm2FpGUTKyiufEwtGGn0chuE6I1MfXuCnBxfZgMi72jRZpWAG2KxLARY9Ja
	 gVR52+WtGgzDelvriqDscrRWpu2Xz3UkilCv8H+9aGEhSGKSoAwIlbwYi2okMvhhHl
	 qgBNpqUCxMsUQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: add and use helper macros to print keys
Date: Wed, 15 Oct 2025 13:21:19 +0100
Message-ID: <cover.1760530704.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Details in the change logs.

Filipe Manana (2):
  btrfs: add macros to facilitate printing of keys
  btrfs: use the key format macros when printing keys

 fs/btrfs/backref.c      | 11 +++++------
 fs/btrfs/ctree.c        | 17 +++++++----------
 fs/btrfs/extent-tree.c  | 14 +++++++-------
 fs/btrfs/fs.h           |  3 +++
 fs/btrfs/inode.c        |  4 ++--
 fs/btrfs/print-tree.c   | 14 ++++++--------
 fs/btrfs/qgroup.c       |  6 ++----
 fs/btrfs/relocation.c   |  4 ++--
 fs/btrfs/root-tree.c    |  4 ++--
 fs/btrfs/send.c         | 10 ++++------
 fs/btrfs/tree-checker.c | 21 +++++++++------------
 fs/btrfs/tree-log.c     | 38 ++++++++++++++++++--------------------
 12 files changed, 67 insertions(+), 79 deletions(-)

-- 
2.47.2


