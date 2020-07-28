Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECED22FF5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 04:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgG1CMj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 22:12:39 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38981 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbgG1CMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 22:12:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ECC375C010A;
        Mon, 27 Jul 2020 22:12:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Jul 2020 22:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=aUT9Y6biGb5ejRtXCEHlJ3ZV4p
        wZdisa7/Z3AnVtPsE=; b=FvVzuPKK2cPSJZ8j27PbfAQBGsVjX+cAgfHJPoCXpo
        2ftdqxljlADVCQna3hCCxA2vzGuA4N7qDrZaInAMW0D+8L70vSwcINrXWKvELh0x
        rXd1lvpySdGJyYJwSRvwdDmKbalEBw8K11HZXezRBQm2jXOjuatLa8DD6Vf9Zrzk
        QCWpyk+mYmrzPTHfloT94abmKWXaVKQycmzAoGKAb/GYJBGT32n+KWtJclL0niiQ
        o/AiP28Q5/g0+TSPXdUp6Lfb3mhgVpaCCZZk5wQafk0qwPyu76USye0gU6e3JNkt
        gv6PxbNkJKn2i1qWbiy9k0ZPh3/NCqkZZz+LHGTrfUPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=aUT9Y6biGb5ejRtXC
        EHlJ3ZV4pwZdisa7/Z3AnVtPsE=; b=uwPHS0n7cjUgu7HqHARYjWpXUUMFidrj+
        7vA8vXegdd7hHJf0bGEqs/KXWUm2c/n03xuFWwrE66MxjcTu8uEK7JP1JihT6RAZ
        SMwGuJ/G2kIbihhxvEWtuQlu/ifWg+sFlLc+AmNjwvkgnagpqs5VPC7rvo4iddlP
        9gyODG+Ib24hw0tKGyzRWK9RWS7uN1eBJf3Y5tcXG5PAX2d9DdydMuNZ+e82NAxa
        eEHYFjYHdQmY2BXvuhXUn7cN7OsITd7RD2n9iQIdyS/4dP6NJNDKH38ZSkdlHOsf
        Pe200HfUD4pu5qOirxcrkSoPuH0zZFmY+o5dG7VXWSUFo6E/flmvw==
X-ME-Sender: <xms:lIkfXwR5zv5Hj0I_pshFHp9Gpy1vhCVmWWVqxfcnjAbQqcesx1s7cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedriedugdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieffgfelvdffiedtleejvdetfe
    efiedvfeehieevveejudeiiefgteeiveeiffffnecukfhppeejfedrleefrddvgeejrddu
    feegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepug
    iguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:lIkfX9w6SU4YnlvWr7NTssq0uaK7GB8Sbnu3-8HkDvRWDk-jnkL1IQ>
    <xmx:lIkfX90PQCLxb-r9GFj4VA0km3kKKe2b7Sx3oH_Uyq-OVeetFmzR0w>
    <xmx:lIkfX0C7Jq4_4swKe1lgr2-zVGHLIM2Xja4S6H-DxoG0yMbFmOUcTA>
    <xmx:lYkfXzdtjyjb6yuLe14e9G5pHpgMIGyrqTyLrvRwQbIqNiUaPGz5_g>
Received: from localhost.localdomain (c-73-93-247-134.hsd1.ca.comcast.net [73.93.247.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D6DA328005A;
        Mon, 27 Jul 2020 22:12:36 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: --init-extent-tree if extent tree is unreadable
Date:   Mon, 27 Jul 2020 19:12:24 -0700
Message-Id: <20200728021224.148671-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This change can save the user an extra step of running `btrfs check
--init-extent-tree ...` if the user was already trying to repair the
filesystem.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 check/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check/main.c b/check/main.c
index f93bd7d4..4da17253 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10243,6 +10243,10 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		goto close_out;
 	}
 
+        /* Fallback to --init-extent-tree if extent tree is unreadable */
+        if (!extent_buffer_uptodate(info->extent_root->node) && repair)
+		init_extent_tree = true;
+
 	if (init_extent_tree || init_csum_tree) {
 		struct btrfs_trans_handle *trans;
 
-- 
2.27.0

