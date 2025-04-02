Return-Path: <linux-btrfs+bounces-12753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE214A79180
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A0616F42A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CCE23C393;
	Wed,  2 Apr 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+G8soaX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D64C92
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605656; cv=none; b=CA2tdss53EBHn5riI0+NUdB/3vEHeEf5Db0Hwp0AmOnKOZthB66ldlGdlH7XpISYF0V31+sEjHkJM3Sa78WBvEL1nyDiU3L6lpAxPQHxOPP6lbQf6wcd3eN958hqLU6hJe1lBJ+qkMUbH1lYXgSlmabB5+8hGuV78SSijl5xSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605656; c=relaxed/simple;
	bh=172l6UeIj9b4ZFDJM9Z/IRHNhMQkdsqTEZ0+GTltp6Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YT7qfLOgzCTscj/yx9FkY7Bs2zOxCur8yB0RZqUFTXhBtQGn1S76weLlzWF8GD0SQBw9oMarGtg9hbgCqzcMiLUGMyFOCL7J4ZDR9JN8zsCfr+Q8WQ1SZxm+KET2Mc5y8Hk/t5eO/+VawV+FuIeKYAOZb8xPkUUkKLwMvJUF65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+G8soaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A13C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743605656;
	bh=172l6UeIj9b4ZFDJM9Z/IRHNhMQkdsqTEZ0+GTltp6Y=;
	h=From:To:Subject:Date:From;
	b=M+G8soaXBepTMOZhkxKnCGn95kbqNcvFymkpLm0BDnXnr7AnW67KJtm0D3x0Mg1qe
	 65D1Em8QcLnezVtCwljOyncJQSFcVZ7zGLEUpIKERZGTO2QvXcngQ8MNglspWuwOi/
	 l9dV/RKui4UHfE2QLsuNgBRMWgZaDTEKMIrTbfuWgsPihfRHL/JoxEqgXJMcTI8vzA
	 XBP5hKxjGC1NvCM2lytt7rKckYyq9xXnTDJe3CCS7y7IyAi9V9TraGFtz1xIOd7Co5
	 wjN57zOa/qAjJq/iyplhOIJ89X/1QjDmqy1GY9OXLn7bQCt3Et+9q/R+6zCQQuvBvp
	 IF1rv0ixcNmTQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: some more cleanups for the io tree code
Date: Wed,  2 Apr 2025 15:54:08 +0100
Message-Id: <cover.1743604119.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some simple and short cleanups for the io tree code in preparation
for other work. Details in the change logs.

Filipe Manana (4):
  btrfs: fix documentation for tree_search_for_insert()
  btrfs: remove redundant check at find_first_extent_bit_state()
  btrfs: simplify last record detection at test_range_bit()
  btrfs: remove redudant record start offset check at test_range_bit()

 fs/btrfs/extent-io-tree.c | 41 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

-- 
2.45.2


