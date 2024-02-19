Return-Path: <linux-btrfs+bounces-2500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCC185A2A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D384C1F22542
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BD52CCB3;
	Mon, 19 Feb 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqJeEe0l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E3C24A05
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343975; cv=none; b=BOp25XTRR2DZdDZeFgCvxwx0nHwjRTZbO8wBOjgLHaT44lEfr8GqQodwLVUoA5XRqpExqv7uKZWLMiHhzmdaLtJG7fX9LivbX6+7zd5SeaO3LfvN0FL06pEBphzHpyPEMwZKGMrL9VW4ttpWJc2A5uM/F8TElUgRgA8WaQHhAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343975; c=relaxed/simple;
	bh=ogBiHcYulcmoGslVkxksX9YU3ZQznM3V4K5Pd7l0vRU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=U0t4f/za0Z+MYdkS/gBCOeiXUWmryxfFYEUgfnDa2OsI1VolX153laivhjzMWs9Ze3J9m3Xkm0c/eg1bHLRxn8639Dm+tDvIuZiKnViZFoprECPlRcvJ/vDuEuHBrlZ6XwWsPVVqyZ/8seymRpqdKvwpC531xOGiN9JOJHODPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqJeEe0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A31C433C7
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708343974;
	bh=ogBiHcYulcmoGslVkxksX9YU3ZQznM3V4K5Pd7l0vRU=;
	h=From:To:Subject:Date:From;
	b=cqJeEe0lFPTWdyXravQJkcQnpLU5nuD9xOdLYlvoQ1GDomiiwpe7aYY9+VvLyj6WF
	 3uM+//U7mDQozBGFOwAymk7KO78w0++7WH0CnDr/1N5tSXhwfOWYs3K4wipHJVRf+e
	 o9BjFeUsy3hDO/BfFUYqEWAqttD57NDpXiyaXNEkyFDw48vJof1QBzCyJu2YfYPGHn
	 Ilw3k1Zp2MaRLs4T2LnEvdaTcoWjMM1vO0dgPchmKo2hoNLg9+lej9W0WxHgWHw9tJ
	 HzsrCBF5P8zS55DPcN2pL/T1mrNm4KDQrUPyRuuqotlimLc0Ff+VEyH58WTURtOw5y
	 IKKjdKcSAPtUQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some optimizations for send
Date: Mon, 19 Feb 2024 11:59:29 +0000
Message-Id: <cover.1708260967.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The following are two optimizations for send, one to avoid sending
unnecessary holes (writes full of zeros), which can waste a lot of space
at the receiver and increase stream size for cases where sparse files are
used, such as images of thin provisioned filesystems for example as
recently reported by a user. The second is just a small optimization to
avoid repeating a btree search. More details in the respective change logs.

Filipe Manana (2):
  btrfs: send: don't issue unnecessary zero writes for trailing hole
  btrfs: send: avoid duplicated search for last extent when sending hole

 fs/btrfs/send.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

-- 
2.40.1


