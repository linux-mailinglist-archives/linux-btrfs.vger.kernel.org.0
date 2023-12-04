Return-Path: <linux-btrfs+bounces-567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51449803918
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020371F21053
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966102C18A;
	Mon,  4 Dec 2023 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECs/ebmK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C322071;
	Mon,  4 Dec 2023 15:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09071C433C8;
	Mon,  4 Dec 2023 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701704735;
	bh=yLz327e1xTQk+nxRMTwZIMbD5St1aq+35xCKeU8bTOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECs/ebmKWEZwL8xVqb6uvLixhHVA3yzp/mlPqFRJ/DUfK8zVfpZugQskvNXm3APAy
	 aClzKY4Q9gFH5Leo+n8sjeqJBCbyTvkoxsJlHjbJJ/S8RXrcpCg+8/dtqMiJtkxAxR
	 NrJbUAQv+PtZLRlXLacswOkbbA6l2rR2tveMqjFRUgQlhozEDmv/0s8tonNe0HZhfm
	 NxiZrQEmsdNxMQeubMMiV2upDyMViJ706txp/DPyN7s1OqnWLVFjwrtMpAXxpTAYgp
	 8/SJIlw0x7BKhvkrh8eGlkxFJ+XIqAfHRu208m1YzvvmIA2uLqkcUxL4izS3Y2odA6
	 64dfPsvhQ4ARQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs/048: add missing groups 'subvol', 'snapshot' and 'send'
Date: Mon,  4 Dec 2023 15:45:11 +0000
Message-Id: <bb893d210f2cb43467f219a817003cbd6b596b6c.1701704559.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1701704557.git.fdmanana@suse.com>
References: <cover.1701704557.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This test case exercises subvolumes, snapshot and send/receive, so add
the corresponding groups to the test.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/048 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 7816a997..8a88b8cc 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -11,7 +11,7 @@
 #  btrfs: fix zstd compression parameter
 #
 . ./common/preamble
-_begin_fstest auto quick compress
+_begin_fstest auto quick compress subvol snapshot send
 
 # Override the default cleanup function.
 _cleanup()
-- 
2.40.1


