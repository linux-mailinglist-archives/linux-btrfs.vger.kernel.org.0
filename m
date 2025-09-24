Return-Path: <linux-btrfs+bounces-17136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE5B9AECF
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 18:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE8D7B4638
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DEA3148CE;
	Wed, 24 Sep 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5i9v3wx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE2313289
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732900; cv=none; b=O88YiN+fixSzczgZGd+brvMHcZ8icdCknbx6x/vfBPtMxNUPTLkgRof8eOg7yTm8eTNgtsQj0/2jepIufplSMJmZ2EXkjwv3wmq6v3PqPDlksmgkKtcr1OsFW8qRgogJcUC7vUNpE02Ol3l/8d8cXa5ktYr0MrwAoKNL0NdoIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732900; c=relaxed/simple;
	bh=oJHu4d/z+hqVaGoLVnFjAOmrekN9KH35mP4Kr87oAos=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hk7sXvb960Ujl0qcXq7CLf9L4NC6wOOgTJBc15isTm+mvKKqMazF70ma2yrYMU2n8rBAncy4kKL/3uWfkKe34zL6Xeba8XK7LliTKhljurHN+IRikvii4kaFBc8FAurvFlTSRzAeb0JUhxXj+/kxxcCKk2sOezRRO3suWwDYmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5i9v3wx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97DBC4CEF0
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 16:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758732900;
	bh=oJHu4d/z+hqVaGoLVnFjAOmrekN9KH35mP4Kr87oAos=;
	h=From:To:Subject:Date:From;
	b=F5i9v3wx1xBPiYKX+Zmrll3q8ZGw+yKME0GYgU9+3W32iRxcy/Yikp4VwtVUCCD8H
	 CIcbJ4+zVz8sk+Gslrxq+mjm74FmDGNKD1Y0RcoWcC4jtbO8nfwy6RG4tnb6tBaRzx
	 ricgfnPzf1UXG1XE0yskOl4Be2S7lwu6hPGFEuCM4AN1tfABVUie54uANQSH3XRBp8
	 RUKximZ/4ceGzNa4awDwPOB1VyKECdWc8C7xgLnMxsbqNjWBeYp0dwxCsiViXStLPZ
	 S3z/3LVsne7J5qKyChivp15C5Ua1wXHeiIZQgVyqlKGD7Px06/TL3ZAUKTLhCVdyRg
	 qnP88hmmqzLqQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: relocation bug fix and a cleanup
Date: Wed, 24 Sep 2025 17:54:54 +0100
Message-ID: <cover.1758732655.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Details in the change logs.

Filipe Manana (2):
  btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running
  btrfs: use single return value variable in btrfs_relocate_block_group()

 fs/btrfs/relocation.c | 51 +++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

-- 
2.47.2


