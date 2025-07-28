Return-Path: <linux-btrfs+bounces-15708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DD9B137A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 11:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC42188B942
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EA225229D;
	Mon, 28 Jul 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWbVsK0q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8431F0E34
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695592; cv=none; b=fgGqKAnCXC8ioM/xXNLaPpba/9TjkDYeJGytM6+olEnoECrsbsw3z8/i5ag8gAfffBIp2BD1kgYtuWXr5LptHfEcmAow2aprAfhf/1yc6quuwItLpGgJXTF3d4u1H3GLN29GoTbnr795LZwicDhvdULUHFifFAb94ej33klXZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695592; c=relaxed/simple;
	bh=oZO8jU85mcfMOZyKXN1yBUbDv24PB3rCzyLDo7UgueE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pI17OumAzD6HPpZxvLjlAx4IIJzvmDxN1pYCBkVENgM/h1TI+JUKVG5/PKkDVez5fTBQs+jiDUsiFiZfLX0iPmUX10CU6b4ujRuA0n1BTPn+tE+CwoUnjWH4T8ix/7GLPXWhZ4an39/MaEmbVNrrj89Rttlo8wL6LgnZHWwyJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWbVsK0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEE8C4CEF4
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753695591;
	bh=oZO8jU85mcfMOZyKXN1yBUbDv24PB3rCzyLDo7UgueE=;
	h=From:To:Subject:Date:From;
	b=DWbVsK0qLwPuT5br8dVmkEBAwiimAz4WgK/wiIMIXlY2MpFgP7Y7pDWS+vKRxPGUg
	 LiKtOZrP0hEXyrdoKK1mPPLlWmr/4Nk3VS5LSu26qT11jHmC6KJrUIeL0K6tlE51px
	 C96US/6bPb4PCd0QZB/0jcWBWokKaOsM4vhE2qvZpj+HdNOIJd2VHjiu9mWEqigm0k
	 lwd2zHpL13+cDXmQIGKKJBk2+TcBroCM0QhoXnR8+iwHsWk0ukGNidKRVgwgUaokEg
	 V6/9ofAovvpFjCfcpwIbAI0Rz4yOVyZZAFHtkhXtLssRdh1cq6/D+FG9gD98yaoXAo
	 PDU56EzmNOhOw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: error path fixes for btrfs_link() and a cleanup
Date: Mon, 28 Jul 2025 10:39:45 +0100
Message-ID: <cover.1753469762.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a couple bugs in the error paths for btrfs_link() and a cleanup to make
it more simple.

Filipe Manana (3):
  btrfs: abort transaction on failure to add link to inode
  btrfs: fix inode leak on failure to add link to inode
  btrfs: simplify error handling logic for btrfs_link()

 fs/btrfs/inode.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

-- 
2.47.2


