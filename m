Return-Path: <linux-btrfs+bounces-3243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B2A87A82D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 14:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBE8285763
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E474085E;
	Wed, 13 Mar 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOAi5ugb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0C63B798
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336051; cv=none; b=R8bVUBDOL7lmxG8F8qJ3PS/yA53MUw1mJq6Ph6fjM/y5OXYweZ0gHV8PgXhy2Ey3A7E5Oa93Cv+l2FhW4dXUT/G82zrQFKgEUE44qLRvUUD1Xxr6lT8+hnReIv5pK8eUIRyQbNOIVBOkpQzEMn79ETwOGRyBiEwN2XSfTLVhO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336051; c=relaxed/simple;
	bh=Mow2vbuNPBWQz8wNLzygnzzg/3H6xNTsDQ/AwvYMLCw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=PDY1E5nR1CoD5kD8+9xCyoJ9P4boDFyt/BHapCSTIfhZL07Fjp6S2gdxftxq4ttNQ2lek663QLSXJNb34/MMPdLlD1bBNzfBdcmGMsYFQl9x1rzGH92f5uW+RLD3TF+FNR+waUFhzCf8hm94uGLXadaD9eoU6ykvQ9g2UO0Twfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOAi5ugb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81028C433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710336051;
	bh=Mow2vbuNPBWQz8wNLzygnzzg/3H6xNTsDQ/AwvYMLCw=;
	h=From:To:Subject:Date:From;
	b=jOAi5ugb4CatADQLaIJ5JtDcqT7pbFTetSHoPvHq1qXPlXf3IBLpNlB9Dvo/bPZNf
	 5WaDV0jZtt5BhzF1Ssw/MUo03sTt4qLeg+tUc91xwcAgkX+VzD7GP9aBjmxrDz5Qh0
	 073rNM7uILSdydb+TXjf6ONrBSwss/iL1HsKgOIiWjtcInWRjsCKm3nYVWrYLatJaZ
	 QBrgI5nSUCIfbFBSw4Mfb9oONOxqTxIMcXxqbnuJ77LBhP+KAgM4sla0iN36mOQVZl
	 fU6HZJilMb85cDnfy/3VCRDtbzfs9lIGt7RBkI7loqkgOnAuu01ogVhSn2cKW7NoQc
	 3q+GAM5PTLq/w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: some minor fixes around extent maps
Date: Wed, 13 Mar 2024 13:20:43 +0000
Message-Id: <cover.1710335452.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some minor fixes around extent maps for unexpected error cases.
More details in the change logs.

Filipe Manana (3):
  btrfs: fix extent map leak in unexpected scenario at unpin_extent_cache()
  btrfs: fix warning messages not printing interval at unpin_extent_range()
  btrfs: fix message not properly printing interval when adding extent map

 fs/btrfs/extent_map.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.0


