Return-Path: <linux-btrfs+bounces-15387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63BAFE809
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0790848671A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB532D94BE;
	Wed,  9 Jul 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwpWt2IY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024482D8DDD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061545; cv=none; b=U6zkdWf10HBr/NpFCPkav8Yk0RuYYyHSubzUS5LkIGAgcgKmetXm7jy9/MJgscuIKdN2XHDNam+MFQMF0X+NhV9b+TPPQKO6wqopqW7VodaYChI0vnZMEZd61QdmQ4+G9ew/Cc9ODgLKnfmM5AEG4sHAYBqdEZ2sjd5E2yttWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061545; c=relaxed/simple;
	bh=/TBNgxPjIAQLWtuDTnwKDdD0EdccoWETDUlPuTqdWwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6o5yBF+E1vpyoxJj5sPSJw35CDbMczlsg7IqamDJrXByIbRGDFE2dnjkdzfW8wjQr7uDWnIsWsKBF0wbbJ5Eizs2a8mY2HWUG31Dis0xHpn4GvemCsHiY7Wu1+RNPQ4pr/mtBsWVg6nyLnVlELy+5y6mtzyNSnNOFs3v307Ik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwpWt2IY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBABBC4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752061544;
	bh=/TBNgxPjIAQLWtuDTnwKDdD0EdccoWETDUlPuTqdWwo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lwpWt2IYgFkG8tzw20WJ75yfNLXJUOhghOIERfWaWCJPChwGSIZJCY2AncpZXhINl
	 s+gYa2clqaZv8zAOD0263BWCbObhPkCBoF5ZJcD20jpK9Sp2jtMMR4mpeObgtjSkUx
	 SxMiMbwgducMklhXoIr1O5M5dzep2qj74w5qzL25QGyBCkutx8x4w5TPQlhbDqR4B9
	 35fdFt042xxkqzwvtaVPW8LyMsiPRu7Nc0d5HhYxp1kKecJACXTI1342L2/AcJ1XiC
	 bKQIKNhqFoJVHsrDldRnUD70vkz+iFWN7MMG1rWXdIm8yaBYpoAwYOq5UzVCtZCno/
	 DdybIqEGEZdEg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/3] btrfs: fix mmap writes for NOCOW files/extents
Date: Wed,  9 Jul 2025 12:45:38 +0100
Message-ID: <cover.1752061083.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752050704.git.fdmanana@suse.com>
References: <cover.1752050704.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A bug fix and a couple cleanups. Details in the individual change logs.

V2: Fix a bug in patch 1/3 where if write_bytes < reserved_space we would
    exit without unlocking the cow lock, so set only_release_metadata to
    true before bailing out in that case.
    Added Qu's review tags.

V3: Add missing release of metadata reserved space in case we fall
    back to NOCOW mode and we are in a folio that contains i_size
    somewhere in its middle

Filipe Manana (3):
  btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
  btrfs: use variable for io_tree when clearing range in btrfs_page_mkwrite()
  btrfs: use btrfs_inode local variable at btrfs_page_mkwrite()

 fs/btrfs/file.c | 93 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 27 deletions(-)

-- 
2.47.2


