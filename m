Return-Path: <linux-btrfs+bounces-565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB21803916
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FE5281167
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30C12CCD6;
	Mon,  4 Dec 2023 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XauK/msL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B292C18A;
	Mon,  4 Dec 2023 15:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328E7C433C7;
	Mon,  4 Dec 2023 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701704727;
	bh=Fu2tELMPgLjwRxxZhBtHwiZV2E7hWAhrM7G7gqNRdRI=;
	h=From:To:Cc:Subject:Date:From;
	b=XauK/msL+5lX3xUfWQ2Yavxgimdcpu1A9saILmYlPXS4dSv2PNyo21TD6foDQzV1w
	 WHWV9u9LVvVwTGQhRZSD3VO26oxx8biYJo4PE5rR+EXZKBVJJ0ChNhUEJA80qBeefV
	 4DcVL7DNTdgDVoIBqIVjlDK5Yuy93ntUPNGcn4BhwJ3bgx/g9k4vf2g2HgvAa9//kC
	 W/3UcXOURf6LEbzRne35KQRcunNxb+mt6XmAEv4Gl1NnJYMspBlhfq08xgFj/sRNi2
	 rElSNPvlk4lPu28Ft3bLO+4VVTan0MPKNcj0+aHFuZTD1vBxba1wrzRV4KaRgaNGsA
	 Q2hI9YuYehSDw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/2] fstests: add some missing groups to some btrfs tests
Date: Mon,  4 Dec 2023 15:45:09 +0000
Message-Id: <cover.1701704557.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some btrfs tests exercise some features but are not listed in the
corresponding groups, so add them to those groups.

Filipe Manana (2):
  btrfs: add some tests to the 'compress' group
  btrfs/048: add missing groups 'subvol', 'snapshot' and 'send'

 tests/btrfs/004 | 2 +-
 tests/btrfs/005 | 2 +-
 tests/btrfs/048 | 2 +-
 tests/btrfs/052 | 2 +-
 tests/btrfs/056 | 2 +-
 tests/btrfs/059 | 2 +-
 tests/btrfs/094 | 2 +-
 tests/btrfs/112 | 2 +-
 tests/btrfs/150 | 2 +-
 tests/btrfs/167 | 2 +-
 tests/btrfs/173 | 2 +-
 tests/btrfs/174 | 2 +-
 tests/btrfs/259 | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.40.1


