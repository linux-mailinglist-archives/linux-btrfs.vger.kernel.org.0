Return-Path: <linux-btrfs+bounces-3632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC91588D02F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA3E1C32B4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9919913D8A7;
	Tue, 26 Mar 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="oQq8ktMb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q6MwiQcy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84413D8AB
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489080; cv=none; b=aOOU9Y2O7fWiGY0jXMcDcYtyKNG7D0t+I1FEr+/EWqArThCjLAvK+jtX+XGTG4ZChCDettKH0wzSH1GOiaZr0GGzXHz00b0NziupNvCGw6Sa3f0nzPX+xgt9d3CqpZ7puhtO0tQ9Cxhw2VNNYEbxusrZel2J1gbMnBzxjD5JLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489080; c=relaxed/simple;
	bh=TNn9pcahLnIZ7G1YwN7M9xSbBOL+orWtpccs5en3dhk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLRbf7RJdzmq0vzhtfYYcIDckx6Kg316NV+1JahpaEKjYAgSPfnNLeV7ncDhL120CDyOwUXlFst1g9Q+aBz3rpGdzMA2PF6tdRaq+ajqTVe1Q1hecRWYaBDUPb2acNRxDBa2M/YQMe5IUvUknmnPTz4bAR6C9Rk4sXYEh5XR/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=oQq8ktMb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q6MwiQcy; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 3D55C3200A1D;
	Tue, 26 Mar 2024 17:37:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 26 Mar 2024 17:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711489077; x=
	1711575477; bh=Tz7Gz4UO5Jmbw4K+G5yh/ZqiXiXxxgYTkvSRVL6iE1Y=; b=o
	Qq8ktMbd0GjJdjHWPBxTCMaTmllGUkozxas2rX6E8ocK/7nC8wbbRdR2lXEUxmEF
	KyEl48QYIXKs4frVVg5vDhiaDwtR8kZtXIR8T1tm5RxzKUsk3xsi5wNMVL2gih5M
	sJRv5fbB2+CtBMajUh8bF1o7gkxg/oWwyyV9EpGG/4VlRf4A/Qyb79v0ws6wVBYo
	adAKpDbPH/MqAUccaH4pfkMImpZa9qx9TyQUkBS5BG1GpaB5eRsQ1F9+XvqZ+e7i
	bJvk9YSpR+zrNnCvD90onxVAgB59Cryo2pF/9WLHGZm+YSD7fcjA+BlfnfjeWvUx
	p5Wbxk1NQ+FgAxw/up0yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711489077; x=1711575477; bh=Tz7Gz4UO5Jmbw
	4K+G5yh/ZqiXiXxxgYTkvSRVL6iE1Y=; b=q6MwiQcyOjZMtpnd7wNHODRGlF/hW
	2zy+2B4hiXBARwg9PjdHVtj70XdHNVVhUkIYhz5hzF9ndhDDRExw/dAiPkitpbtw
	OXSDQfF62zLzvdBT6TQjqHh1xDuC0pBBngiAkHabS3eVs38X2+HcSmmOKNm1PiWw
	gwIXweRHNV36gTQdhOy8CeJIGNRT/WYzR4x1U+50zOS+UAezZDYN22HClMQen/f6
	dbqRKC3jQb6g7kpxaIpvTYwxV5YXcdMjjxjeyygZgFDt8xqsazaIgByW8Bpb/FgP
	fBRykP/mUlaiWzZPf2PiOGfx8BnG0rpAi4Xf95XN5Uf5hoidic83oUysQ==
X-ME-Sender: <xms:NUADZgd0CU0XwqaXwyf25IRI4EgYV-_95SICpqEXORZWNNvfVswdmA>
    <xme:NUADZiPNrpucB0-SrIwlhSsmCaAvjVssTfbLF_4E9lkDRjs2b_RgG4SHTLLz8O2OM
    pvQJe6Pd5kHJzEmswI>
X-ME-Received: <xmr:NUADZhgiX8PYgPsNzMvfHbSzJqE9RaHFc01GZaT6VfFkA_FeBThJFRr9tLSgLdmORMAD5T8g7Pv01aEOQ5NF87aYlD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:NUADZl-AJiuipATTO_vyKtHNVmbAZq4DtRRzHOrsriKZp5TYC1twnw>
    <xmx:NUADZsvGkeyoFz51lboiOzn_tbBdXaqwzm9fylQNarmyH8LCBVS4Eg>
    <xmx:NUADZsGitoAT7Ooui9W1OegsWcZx34uONZN0rpxxozUmh7w_P70tpA>
    <xmx:NUADZrNDhr49pWAUxb1BH4mTEgYp6lLdPORivNMq7yo6ba4OUzJw9A>
    <xmx:NUADZpWYwyPIP6OrrnIzNACudu372bT-GefFk_ubilfAmIa9SaUdqQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 17:37:57 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 6/7] btrfs: btrfs_clear_delalloc_extent frees rsv
Date: Tue, 26 Mar 2024 14:39:40 -0700
Message-ID: <ce7db2df5f2f7617ac37f7c715a69e476acc7f1d.1711488980.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711488980.git.boris@bur.io>
References: <cover.1711488980.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, this callsite only converts the reservation. We are marking
it not delalloc, so I don't think it makes sense to keep the rsv around.
This is a path where we are not sure to join a transaction, so it leads
to incorrect free-ing during umount.

Helps with the pass rate of generic/269 and generic/475

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2587a2e25e44..273adbb6b812 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2533,7 +2533,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 		 */
 		if (bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
-- 
2.44.0


