Return-Path: <linux-btrfs+bounces-11760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2612A43C75
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 11:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBBD3BCFF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAEE26770C;
	Tue, 25 Feb 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYd/q1+K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CE267711
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481034; cv=none; b=lJXwOJiAL9hqRBOyHIwhDS9vTI6d/58bs0wgOTQzi7VQMVU4CDn/OTy8OC5DGeqvKIylD4vshUGXW2v4Eb3P+MC4Nn8YQX6jpAIBkDWhBwlOmdDjT1DWI/mKazVi6+xidycDn04CaSkjnCQq95GDl3FCPbITPu67jLn9QMx26B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481034; c=relaxed/simple;
	bh=twmDrwZlXcHB8quRjHNkqcM2xBiFbFOQR6txF1QNUF8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Au7iTuFzuGsHULdQcvQbyyYxMT/ExmaD9EkvtqVlhb4PY3ts5lo/LdAurURyItV9JpXctiTuQS1WsNbmiP9/ns51JMOfIZRKOxz2KYfLjwwEWY5q2SStqdPZ1woJiwlAwDNf2KTjquhss1RvMTBU9JoeqejoliJoB66w9H9e1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYd/q1+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CA0C4CEDD
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740481033;
	bh=twmDrwZlXcHB8quRjHNkqcM2xBiFbFOQR6txF1QNUF8=;
	h=From:To:Subject:Date:From;
	b=HYd/q1+K2NZJyTkHpG5y/DpJnJ4UD9gIFZLzXOwC9v0JdZmy/ud63AtPdTIIQE1AH
	 s3UNv1WzIEzTEXOj3uf20qtIaP3iIipcrYO1p7OaE8X9ZNUcHUA5h4ypx2hmdUTIef
	 YJsKFmBFg+W03XXZtwpTzBLJQt338XfqmwB8IJd2FTwLH3GUgwGYBfjFhQQobl0iI0
	 FZowqhnzEgcXwGiQ4lCSfFDqLkahvpoWRZbxVSz0Lpu3k1y/Wz7fEoSie/2ffOjwvk
	 JN3gQOmd4rPzNbVDGiUTAbmS7A7BHKhkHLFGCPHkaF+q8Pgc8wbfbtvRZgmxeFZb5k
	 d8E4nGBEK6Rpg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: some fixes around automatic block group reclaim
Date: Tue, 25 Feb 2025 10:57:06 +0000
Message-Id: <cover.1740427964.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a couple races that should be mostly harmless but trigger KCSAN warnings
and fix the accounting of reclaimed bytes. More details in the change logs.

Filipe Manana (3):
  btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_bgs_work()
  btrfs: get used bytes while holding lock at btrfs_reclaim_bgs_work()
  btrfs: fix reclaimed bytes accounting after automatic block group reclaim

 fs/btrfs/block-group.c | 55 ++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 13 deletions(-)

-- 
2.45.2


