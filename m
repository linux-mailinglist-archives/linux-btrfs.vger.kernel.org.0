Return-Path: <linux-btrfs+bounces-476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 961228014DD
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 21:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA4F1F20FFD
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03385914D;
	Fri,  1 Dec 2023 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="blymQRDD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bT6oGRcQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FD110C2
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 12:59:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 51BFF5C01C1;
	Fri,  1 Dec 2023 15:59:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 15:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1701464340; x=
	1701550740; bh=0kJXEGAVBdGtZ+Gdv9T8tAWTrKEgtcGgN5Vv6HI3ORU=; b=b
	lymQRDD27vEecbVyrahcAaETtTOwSK/dWY5fsKQ0T1jSSeSu8JZmeQ4AiPh3rr1s
	pvrJo9u9WRQsSCKsUukO96tRzkGr+qdB+4x79n2mb7eGd2QpFq13F0je73pjLDQK
	b0rhTro/RjDw/y+l97O8rMyRu7e/JLN94KiqczSTvSl/oK/3j8gMkF0s0vm0OPlm
	OJPiyFKbHteBhXXDcnDyDofM/pFx9GQFsitrQvXOiQsbt0I1dvEznrGau27YR5k8
	009krE+IiJEQ/CbCBKhVqVz4j+7hsctuQSYGeX+GY5W3UEkeoIRe2J2EhNYDq03e
	uVPWj0P5tSze6zVM5edVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1701464340; x=1701550740; bh=0
	kJXEGAVBdGtZ+Gdv9T8tAWTrKEgtcGgN5Vv6HI3ORU=; b=bT6oGRcQIfO14LDAv
	k9EIu5DlhFoJvfIPKCF+6tQPbwlvzfMFjWaAOUuW7zkhoPjak21e1XNGwXzuTHMs
	+uS2c/9qQeX7K66G0LFGjYt+zzG+9pseb6X8HWd/IYxbhBZpSaRokAwdPqJumkWm
	YrBixYY0hM2RPIYDHXNk25SfU/pQOxJCKs0un5/ueMi3rQibnDfGZvfE7i5HAlyI
	1XuibR5LMI30s5BZrBUpK+jDD3zecaArJSl49MItGDJ2geDTV1S+2q7HMsBz36Lv
	XjR2nDhbJcx8Terr9IP5om2o7BAtdT4+IDbwLE8xrjHuwg6kSWMy84h7Tj27qxG+
	SMF/Q==
X-ME-Sender: <xms:FElqZVxyexOzWtExQEY6b9H9Hfnh5t8cVw2F6v73Afgz2H8ExNoZiA>
    <xme:FElqZVR1FLFXGoqEO51Fh3_ep4ynngYH8JcS02UoPBWp8vx0PD2-D7rslO51Ddahc
    sefS_Ii9b34RpSYiwg>
X-ME-Received: <xmr:FElqZfXE778rs3MbTtHl9russZNmfjm4Bky8XKep27DgieLS36uXBl_yl13wBIbQSTGpCE9ahuZhSCnQ7xf9Ox9J77w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:FElqZXhmynDtqStSFrSBExwJe9EVYvUAC9IBGAEC0dLsmFH9s1UM0g>
    <xmx:FElqZXA1IaFjQE2d3omCljT41N1pkkeZPEfpIoHqOzNLXb7GFMSkOQ>
    <xmx:FElqZQL9TFVka_lG_pb9PElqltRmAx7CiN7MFk4JJ29_TUz0IvR6zA>
    <xmx:FElqZaqr8nNskLn1ukF1AG0h_f9ySiHzTud4W5FJK0cRPXPdqXuHUw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:58:59 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: free qgroup rsv on ioerr ordered_extent
Date: Fri,  1 Dec 2023 13:00:09 -0800
Message-ID: <301bc827ef330a961a95791e6c4d3dbe3e2a6108.1701464169.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701464169.git.boris@bur.io>
References: <cover.1701464169.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ordered extent completing is a critical moment in qgroup rsv
handling, as the ownership of the reservation is handed off from the
ordered extent to the delayed ref. In the happy path we release (unlock)
but do not free (decrement counter) the reservation, and the delayed ref
drives the free. However, on an error, we don't create a delayed ref,
since there is no ref to add. Therefore, free on the error path.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ordered-data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 574e8a55e24a..8d4ab5ecfa5d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -599,7 +599,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 			release = entry->disk_num_bytes;
 		else
 			release = entry->num_bytes;
-		btrfs_delalloc_release_metadata(btrfs_inode, release, false);
+		btrfs_delalloc_release_metadata(btrfs_inode, release,
+						test_bit(BTRFS_ORDERED_IOERR, &entry->flags));
 	}
 
 	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,
-- 
2.42.0


