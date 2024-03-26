Return-Path: <linux-btrfs+bounces-3629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AA988D02C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43541C2F350
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7769B13D899;
	Tue, 26 Mar 2024 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="gPyzMTa1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XU8gqtS2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A713D88C
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489073; cv=none; b=Q6BTlOaSGlAyhYNhrxU3xu00Pk09dyh2+5rPlvMhx8D1XXOJIRwrrduO85ShlnK9cAfbbeu6EtqMEycnNk3miHR7JrBytvxoHtOd804b8yinv8Qb5CcfB89xrEKuO4B6TX0zFvPqyESzqUGpm4iDd4gbWE2rMTKqUAGDY4UDbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489073; c=relaxed/simple;
	bh=wr4W1gNsBGD+YO2JDfoZjQ7dBpQSCvxciKvThvJRzM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPu63WQIROTgmlL7tZ7Xux8FgJWBxMWyKie7voR1/xa1w+pB3IxghXZLAhtx2//W8kGDzy/nKmGJfXU+30Q4z5QWXgwGFfVTIv/RL+81qNr5sDMdI5Etv6CF1qrBr9u0o6dCXc0GPjMrcWw8tUwWFyYA/s50lqSm+QhUfnvIqso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=gPyzMTa1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XU8gqtS2; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id D672F5C0058;
	Tue, 26 Mar 2024 17:37:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 17:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711489070; x=
	1711575470; bh=lol4IibumezYR84ohG1GEyMi9uemJzUgaOrsviVHMCc=; b=g
	PyzMTa1/u8IPV5chYRAq9Jb6LJbyeM8WY3Dknd7+TbX7cSSga0yPfxsRUzHpkDyJ
	imQnNlC6ZV4xDj2UsTcQ0jQyBc4uud6gYQyzsFupABwA2ecC6jButJFsOKx1b3Fx
	bqg9YKRnGIL2IYcB0p8vGNXI2X1Z6upk/2GavQKDxr5lDFWRZOGGpvJvahbUFeBd
	cAcKL7gsgLck1Z/GXic2T0DnasI4CrBXCS5jfoosBwxqpr3mvNRgtyOLC8Dnck7F
	ejxEOYDMUI5/eoCvkJdYlp5jCmE6sfDVkZD3KI3I4K/cg8z1fvRmsUKEAL07+Edy
	EjL4mncvRnoBcEcuerbYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711489070; x=1711575470; bh=lol4IibumezYR
	84ohG1GEyMi9uemJzUgaOrsviVHMCc=; b=XU8gqtS2G8cJlDVALS1CznNARPzmX
	IkWzizYMxR4mQW58t74qcAOUzY74Cee5zJjvJhLw4Wm6U9WhcU7ETH1BRWWFDN9U
	iYr0OQgr2UawD0ETWRzVzN1jbD8a595+HfHJuiFDUVlzNpKMfRJuAiXbr3anIOc4
	0lUFWxSNO+GFK3Dz7YLM5V4eM+VT6qPIYHTokk5oWKVCapmTs04vhWYr/NarB+Kl
	DAdDLiAf8UJHuJE85sN6f0xj8Nsl4gEvq7bZWBD22k/XkLvPq3Rrf4605ggwI1vx
	IeGnmrgrgEGdRM5fqy6xOoa5O9T3sqNl38soP9v7rC46eN7uD1/rk/AIg==
X-ME-Sender: <xms:LUADZvkJ-lNNsDw2WzeHAtwakYruYYxP9X2yHUtm9TKbPQWG6g60OA>
    <xme:LUADZi0R7s3w8_nFj9ONRODVo_ENQbzDn2-bqh0wzbki_eT93K_vldYUM1e_QQe1_
    LtBDbjGgd2iJp2nn3M>
X-ME-Received: <xmr:LUADZloWqGRdMjpLseqTGocybnbfy0HvscSIr11YQ3iVIg8zUG4CTJUeuZy1aBBoRVt-YMx3hfXWxCJW7bSJPz8GXWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:LUADZnnMgcu33HKq3fQ8Vqg3ZVayOtDGObrXrdRnmyRBrLgTzG8kPw>
    <xmx:LUADZt2JyO16A25iSpOOUbZXjLg5YKlbnizntmE5AfjkRFfk0LaYAA>
    <xmx:LUADZmvd4ahplbz0l--vRJfxMv70CZMsHqcEwpuoBKp7YOqaOy9ErQ>
    <xmx:LUADZhX6WjAXgJkL-3MDi3hbu56U82rmOQallApVljPxI7WVQDWI9A>
    <xmx:LkADZu-Njqm_VsGtwFljK9aIL7ZavuJ1oaC_R3-cX9D-q_snM9A8FA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 17:37:49 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/7] btrfs: record delayed inode root in transaction
Date: Tue, 26 Mar 2024 14:39:37 -0700
Message-ID: <cadc31b0278e4e362f71f7c57ebccb0c94af693b.1711488980.git.boris@bur.io>
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

When running delayed inode updates, we do not record the inode's root in
the transaction, but we do allocate PREALLOC and thus converted PERTRANS
space for it. To be sure we free that PERTRANS meta rsv, we must ensure
that we record the root in the transaction.

Fixes: 4f5427ccce5d ("btrfs: delayed-inode: Use new qgroup meta rsv for delayed inode and item")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delayed-inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index dd6f566a383f..121ab890bd05 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1133,6 +1133,9 @@ __btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
+	ret = btrfs_record_root_in_trans(trans, node->root);
+	if (ret)
+		return ret;
 	ret = btrfs_update_delayed_inode(trans, node->root, path, node);
 	return ret;
 }
-- 
2.44.0


