Return-Path: <linux-btrfs+bounces-20451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D06AD1A68C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 710FB30183B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8134DCD2;
	Tue, 13 Jan 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLnEst6P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD934DCE3
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323062; cv=none; b=DU9uszUjPxjzyCoKi7NdQPah0/NFcZQxuG9BRmFJQZokPf9u1nq87pnJUVNI7hfVPxx+iyJ5TiVYWD7+g/QdRQc7946/UMhp6fZCyd9VQ0/LuoHLdESKchFU0AhYteeeU0QPYmqnR1KnVnAWizwSpgp3ADverIRG6fpj0Z606F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323062; c=relaxed/simple;
	bh=SYSvhlD6D2do2g7mkStcyTRW4n2Q9nYr9AiuFo1KFv4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NoSSCxM9y/db6CZ1AGIIgPapbTs90vUtlhJNQGlk04jIFkLmYe0g34am3Dz+Bl9EzUsuzsB9zCgwgStI/onE0vRXOcjKyIXkeqQ2uofyTpv05/JWghmBkQpHbN08M0MgZdXlP4qRiwcuCIA9JIC0c9vwq0wqpwMFuH/NbcI7Lyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLnEst6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A332AC116C6
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768323062;
	bh=SYSvhlD6D2do2g7mkStcyTRW4n2Q9nYr9AiuFo1KFv4=;
	h=From:To:Subject:Date:From;
	b=bLnEst6PdfaKTLIPqUp5bVuI1U2DY14qAHNQ1jYe64OxwlNenlRXSObg0g9zlVBAj
	 kEiavwh2K3IwFe3B5xcibhxyl1ZACBE60dofV2ligDqFzOa5uf6ouPIJfNi89kqBu9
	 +rNCiR6matkqkYz+mGASbTErBWmAWbt/Hv3A6s1PXYivPqs4gMDm48Py9EJe86APRK
	 jjNRdkV43px3Dlpj7uTjKHtRpDZ6eCsqsbbfyrct7BfImNy6FVxm/PBF8P/Lop+B7d
	 D2zKygYmpo8AkjsMX5NQM6hORbjnoPA1Q3umzdxg0nOT0agCMQxrAw18if+MUaGqlw
	 kC1Q2/Tuqb4qg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: get rid of a BUG() in run_one_delayed_ref() and cleanups
Date: Tue, 13 Jan 2026 16:50:56 +0000
Message-ID: <cover.1768322747.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Remove a BUG() call in run_one_delayed_ref() and a couple trivial cleanups
in that function.

Filipe Manana (3):
  btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
  btrfs: remove unnecessary else branch in run_one_delayed_ref()
  btrfs: tag as unlikely error handling in run_one_delayed_ref()

 fs/btrfs/extent-tree.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

-- 
2.47.2


