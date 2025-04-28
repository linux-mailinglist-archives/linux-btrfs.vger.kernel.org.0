Return-Path: <linux-btrfs+bounces-13474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BACA9FCB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 00:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6309C3B5096
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 22:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB68207A0C;
	Mon, 28 Apr 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ien+hFQT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DF1DE2CF;
	Mon, 28 Apr 2025 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745877712; cv=none; b=U4FvUrzwcvyadTQKgQqTFSCVzrAjEel0BFwMEtcTY4eU3jYvej935epA6XMGtDmFIev3XpYm2iJup/5YWLGSpn4nPNx4oHE9sgT+FZbcs+ChrwF2iXSRDWJxjU1dZfHvzeTu66tWBden8LiOAyA132oMd9fiMV1DuKG6+dawtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745877712; c=relaxed/simple;
	bh=TzUT2DGtBUJzrG7xMMDQeBP+PRRIqcfkkj/d4QN4onk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U+rTyOUOaLum57HvGn/CylyMry6xPq89GIjxyX5S3fHCjbe/5kJAAnQZKl34bYtRHWC36V0GpT+SUCA8R9puRCzN4Ds4luf3rbj5pa85TrdBkXQ3mljckuXsYdwwLKyD7DCj1nIXU1ns8D66oOeiu521Ono+gGJsQGHjbks3jAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ien+hFQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A5EC4CEE4;
	Mon, 28 Apr 2025 22:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745877711;
	bh=TzUT2DGtBUJzrG7xMMDQeBP+PRRIqcfkkj/d4QN4onk=;
	h=From:Date:Subject:To:Cc:From;
	b=Ien+hFQTYrk0Ss3ZUo2IeTQasSQ4uLYP372OpxPZUU0RBViZc9OhR0439eGCLgrWc
	 vD8ivxWX2ruDYXKzkbpvf8SGx1pjiUOgcjxmSTYB9DCnUs2+JIwMQ4UFVY2xfNpbzL
	 Wesi7yjDUapaz86RzCOgDmaXN8eAXM8wQg1VmUs8bFt1m94wB1ehBYM7vfFKgtZbqP
	 h1ETofk9O6PS30saEIOvQPjhbPKlhQZgxuhh6t/T7q56zp0FQpVAgh4fveLtvaS2qe
	 t3q3uZFKHxG6gyWhELPI8UpK7uUqWKppa5sX/DeuyuN8igGJtrvapEY9g5Cv0cItTX
	 N3CB25WzirZdg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 28 Apr 2025 15:01:35 -0700
Subject: [PATCH] btrfs: Fix use of GCC_VERSION in messages.h
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-btrfs-fix-messages-h-clang-v1-1-5ede51586a9c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL76D2gC/x3MSwqAMAwA0atI1gZstSBeRVxom9qAPxoRQby7w
 eXAYx4QykwCXfFApouF903DlAX4NG4zIQdtsJV1VWNbnM4cBSPfuJLIOJNgQr8oRWu8a0Mda0M
 BdHBkUvfP++F9P6y2lOFsAAAA
X-Change-ID: 20250428-btrfs-fix-messages-h-clang-21c58d3f31ed
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=nathan@kernel.org;
 h=from:subject:message-id; bh=TzUT2DGtBUJzrG7xMMDQeBP+PRRIqcfkkj/d4QN4onk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBn8v84e1WDYsW3XXPaoWrZt037GmUTOnfrj9LeyV4yf5
 914ur9lZkcpC4MYF4OsmCJL9WPV44aGc84y3jg1CWYOKxPIEAYuTgGYyJVKRoYLRr5XeWp2njcX
 MSuqeL/2qW16aeyt69PkfDwXqIRUR9ow/OF+ILxQTXr2bdmsBRxJDZPUL12aorLINSfXKf5aZ/L
 BZawA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y):

  fs/btrfs/messages.h:188:5: error: 'GCC_VERSION' is not defined, evaluates to 0 [-Werror,-Wundef]
    188 | #if GCC_VERSION >= 80000
        |     ^

GCC_VERSION is defined in compiler-gcc.h, which is not included when
building with clang. Use the always defined Kconfig symbol,
CONFIG_GCC_VERSION, to do the comparison.

Additionally, as a comment above this #ifdef notes, clang supports
__VA_OPT__, which is really what is needed for this block to function.
Include a check for CONFIG_CC_IS_CLANG as well, since clang 13 is the
minimum supported version for building the kernel.

Fixes: 14d740332aa0 ("btrfs: enhance ASSERT() to take optional format string")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/btrfs/messages.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index dcba4f43ee00..5539fb3c2e24 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -185,7 +185,7 @@ static inline void verify_assert_printk_format(const char *fmt, ...) {
  */
 #define __REST_ARGS(_, ... ) __VA_OPT__(,) __VA_ARGS__
 
-#if GCC_VERSION >= 80000
+#if defined(CONFIG_CC_IS_CLANG) || CONFIG_GCC_VERSION >= 80000
 /*
  * Assertion with optional printk() format.
  *

---
base-commit: b25667588fc3bf7b500c592959c3e6012e35a0de
change-id: 20250428-btrfs-fix-messages-h-clang-21c58d3f31ed

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


