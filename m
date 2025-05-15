Return-Path: <linux-btrfs+bounces-14036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D47AB8542
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 13:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1148C6704
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DE3298C10;
	Thu, 15 May 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhnzxs/h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011E20FA81;
	Thu, 15 May 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309824; cv=none; b=gsBjB6ofgA7dwVy01TokbpfdlSGbJtdQK0bNkHbLaXcHDQODbUmzALr8MMRAovV4zENDCvlkE/Hu/YCWNt2cPzEjG3CTNsssZJQtS4RqsbYiA0ub9FUEgclyIH3BM42mEQQEpV/W0ZyJJdqLMTUsHV3fxr2CsPCOrDRYkdafjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309824; c=relaxed/simple;
	bh=NVapLLXqpQBk8NkSLOp1ic6UK2klF83NyjKMpf/4t7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMbXXz0WehxgSoEiGkwiIVMiSOWkTJSYps5kYW3wzVtkudYZZw6lSe5MzG/JrNff4H/nV4mft4X3tSq0QVq01+O5Xcshzor0If4tV6JjLdDzY5E4C6cZ61BDq66umHqwb3TPLorvdiyn5RplN9hmNOOP2An/oOuZBksKKxlE7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhnzxs/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C4DC4CEE9;
	Thu, 15 May 2025 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747309823;
	bh=NVapLLXqpQBk8NkSLOp1ic6UK2klF83NyjKMpf/4t7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bhnzxs/h7r+vsVfLVE7FiZ2YPrMbP5/ugKwz7CAOZnjmDJEyPSAmBjEMGC5GlmnUa
	 0rRe/j4j9vdx9Xmq29zp/mdUChFm7F9vYX1fbMAzA9R2T9BYeAvMQioZarVwkrlPnD
	 Fm8irPIiwPG/MrLltSudZ02XxvZ0ZZ+kL9erRz2g3DFxDTlf94SrMedUWObOGvDAAj
	 tsbcm2YqbQbi+ot6gN8Sry5CprtEFUCLiWN1B8bUWVL51z7qiTAm5pqIKzOqcLt6VT
	 L2do0Leklo1UCwhJg2HKYeVJfLW0dRrI2VnO6Pi7MLIDRDyzheobB9hTOMayMOwkkn
	 UnXuE02BnNt7Q==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs/023: add to the quick group
Date: Thu, 15 May 2025 12:50:08 +0100
Message-ID: <29bf7308d67eca82e564956f381dfe983696fbf9.1747309685.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1747309685.git.fdmanana@suse.com>
References: <cover.1747309685.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This is a very quick test, so add it to the quick group.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/023 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/023 b/tests/btrfs/023
index 52fe0dfb..f09d11ed 100755
--- a/tests/btrfs/023
+++ b/tests/btrfs/023
@@ -9,7 +9,7 @@
 # The test aims to create the raid and verify that its created
 #
 . ./common/preamble
-_begin_fstest auto raid
+_begin_fstest auto quick raid
 
 . ./common/filter
 
-- 
2.47.2


