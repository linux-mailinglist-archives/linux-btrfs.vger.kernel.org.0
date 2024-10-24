Return-Path: <linux-btrfs+bounces-9144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFA89AEBE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1A61C22B95
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68491F9ECC;
	Thu, 24 Oct 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZEaH6TI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD831F9EB9
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787085; cv=none; b=EGPIkEJKEFclmALicWiE50diuW9E7QyUPFoZrjBkWYrDT3bTDcVcs0xXTbEblGtpNnuhzmQIDbBAZFCwT5c0CpKbVxah+6fLdJqvSStgCq2I3tvyZk++xrPntBy+xNSdNY3Y+xmDJfzMN4Odxmq6NyI9mwT6tjR35kVHL+lj0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787085; c=relaxed/simple;
	bh=XMWUvmGYo+H1wRihXcStxnVmZvCqgjo2I0mDgTtUBDU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqmTMv4CA2GfwniSkirOWaCTamuK4DIUcr2a+yNNay6HOEbVMR0Wk0jYXsP2ql6dDf6EitP5RLyx5bX4vYYos+UVCbs3UGmkiknssRb3yqarhA/kr4e1OBUAuzpnnXNsdfr1cWzACSu/B+tpaX/CE2pfyQnr1QTD7qbhBpLnBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZEaH6TI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5856C4CEC7
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787085;
	bh=XMWUvmGYo+H1wRihXcStxnVmZvCqgjo2I0mDgTtUBDU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RZEaH6TIg2zLSN40fgFdeTd7wvX3peYxm14NuTdsGfmOL6465RLumq+qSRkjnEk1V
	 FgCKgamRpfVkdCw21KxFXSVVedRf1C+5csykDj/2AtLK98kgPt1gbWd5Ysjzem+YLU
	 78jRqMjEypqGDghmPChwg4g2G9VBNXdii0kG6Pn7Pt/dZQtPEHxtM7fDHSwsAoaXMg
	 /Y8fHKWXoCiD3rSHB8uJQhOqaRGt09FZkQgdZnSlruwS4TP9Iq5p1E9f/XPy1a95At
	 61QwXwG45Mjcgbsi4WS24JegVMNHnBv+b2sh/GBJ/FyIEGoD3P0glGehVoJl27WG1+
	 2UN4/MtDyRrbQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/18] btrfs: assert delayed refs lock is held at add_delayed_ref_head()
Date: Thu, 24 Oct 2024 17:24:23 +0100
Message-Id: <d355c98ae393b053218a0c7f5f0b7cf9d130af45.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The delayed refs lock must be held when calling add_delayed_ref_head(),
so assert that it's being held.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index a8cf76f44b2b..2b6a636ba4b5 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -886,6 +886,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	bool qrecord_inserted = false;
 
 	delayed_refs = &trans->transaction->delayed_refs;
+	lockdep_assert_held(&delayed_refs->lock);
 
 	/* Record qgroup extent info if provided */
 	if (qrecord) {
-- 
2.43.0


