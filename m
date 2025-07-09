Return-Path: <linux-btrfs+bounces-15372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA14AFE338
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504C37BA3DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080627F182;
	Wed,  9 Jul 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF2C45JE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249EA1EB3D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051204; cv=none; b=O6ZMLyeFdvfO85LBSW9F6BN1J+TNYtsBTbxxQO2QDqEFqyBO1zg1FxW87J72y3UvtRkNfs1l10Xm4lknI+Pu4i+CSf/Nj2MqnjgQeOJ7CH38FjwG1JmsVaNJejj1JXbg09mgjSTLmIph97WOMOAzmEe2zhMEDD+HaBmzltzAE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051204; c=relaxed/simple;
	bh=eyG9aA6Uki6g4zBLwFDSqrqiPS8IC2Qpw7/NFrBVbW8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kQrO69GJcIBYpX+068c933/GT+C6kKPSTnWiaIrTCq44A0mAjB3S0YzLQPB/tg7SzOS8A/9r8w7VoW078jiTW8UKkU7CsIj2/1L/dx2LCMyckJmjwuPGrtAOXJjzWq9jmMXQh441/VpcdCmkoPkIDIeBcVqzyiGq5dYx7tOs/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF2C45JE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10F0C4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051203;
	bh=eyG9aA6Uki6g4zBLwFDSqrqiPS8IC2Qpw7/NFrBVbW8=;
	h=From:To:Subject:Date:From;
	b=uF2C45JE8PDynK7K9ZI/4MFLkp3FfMcH+iBi3/xXhbCpJF9l+Y4AjTvlbzNIDzIp5
	 W3+a1mcTmZN8ZVBGqBgahAyCkSFANVMQNoTCX/GXP3Vq5CUqf5A+s73/KhTTLkfIdw
	 3xzKdO1KHXudpKmFWoEjwV7pMB1VkOHXzDjrJAEJQoRk4ICmAsDJc55WDHWC9YUdrD
	 cOpSln1JdJVJIzVh6RwNNAvMYQqBJSfYn3YEjB9tySndxjtkAoDe4HFwsYHTRE1Uz0
	 OAY9+95Mawp3IlWwvxLswz4opvbN1O+uLthJGRB7MM6hQ6Q75tpQbkF2A0eCmZQ92Q
	 Oj+hkzpl3chQQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fix mmap writes for NOCOW files/extents
Date: Wed,  9 Jul 2025 09:53:17 +0100
Message-ID: <cover.1752050704.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A bug fix and a couple cleanups. Details in the individual change logs.

Filipe Manana (3):
  btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
  btrfs: use variable for io_tree when clearing range in btrfs_page_mkwrite()
  btrfs: use btrfs_inode local variable at btrfs_page_mkwrite()

 fs/btrfs/file.c | 85 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 27 deletions(-)

-- 
2.47.2


