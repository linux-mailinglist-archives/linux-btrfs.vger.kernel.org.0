Return-Path: <linux-btrfs+bounces-15474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C7B025C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 22:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AE3A6531C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 20:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387AA1F582B;
	Fri, 11 Jul 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ0kI23Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B21F4181
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265577; cv=none; b=cC0LgiAqQgVNJ5U1jIDAqIvoje3YWReWdNVg1CkgiP86kD/UGdUAw8T5Pphqf/ed9xKXSGvxYlo9KNSv0/+phYojIFKLjmotqHqb4U6H2RS4frELlNR/k3+nzHUundS/JJ1hEesjELf9CRPK6oXLesMQzVXn/+neEh+utBE91uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265577; c=relaxed/simple;
	bh=n3RE4w2HL9GwPv0+K8/MixzTAQfrFK92vq7cGI7n4sY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Lk3rmbsALhxDdj7RA8O0BYG6tv3Nt6GjYcvSPqUN+Es3aLfe5KVcFUbCv/n7w1+xMRMbY+m99IUGv+aq7ESdBWyVRwd/Os2JWODuiTk9o8agZiMMv15GVoTU7FLZjeSdsQVFM9ddvyWPtosaBpP7Htdbs3W8GxIDnbriPZzGVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ0kI23Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54314C4CEED
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752265576;
	bh=n3RE4w2HL9GwPv0+K8/MixzTAQfrFK92vq7cGI7n4sY=;
	h=From:To:Subject:Date:From;
	b=fJ0kI23Z0tQNZg3f5juElRFlg39m1tqA1CCeDBLAA2jbKeVtQ//zUQdUyOW/izw8x
	 bPFA/YovBNW79bIDiX7ADT6GgZgSaMhq/XzWh7eEhZlshaQQlnlIL4bVbrNMfX3fWv
	 Os+Z+cvS0hTo40pj74Fq2XclAlK4ErDBgIyGzF5JnPLwwChKg74HKIKqIP0J+ePXJE
	 g01geYrQf3CrkTfv9qX5pb4KaeI4zgUfELUsrSXXANEHH1vBWutJS+Ay+G1r4A5tYH
	 7iJGRDf8w89NzrcoHFxZuGo4WXo1dbZYjiTM5gr9SDJhJxzUF8oxeAO1DbbG9HjKM7
	 RwWcsLk1oLwmA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: log replay bug fixes and cleanup
Date: Fri, 11 Jul 2025 21:26:09 +0100
Message-ID: <cover.1752265165.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple bug fixes for log replay and a cleanup.

Filipe Manana (3):
  btrfs: don't ignore inode missing when replaying log tree
  btrfs: don't skip remaining extrefs if dir not found during log replay
  btrfs: use saner variable type and name to indicate extrefs at add_inode_ref()

 fs/btrfs/tree-log.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

-- 
2.47.2


