Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882532B140B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 02:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgKMBzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 20:55:51 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41939 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgKMBzv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 20:55:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7AD435C0066;
        Thu, 12 Nov 2020 20:55:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 12 Nov 2020 20:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=MiqDpT57mHdcEU1h7zTO+nOins
        OSyQk23xizre+RRmU=; b=RxmdFojK7PmGFIj8M2Qf+8ikclh2u6MNMllvzCBv3X
        qHtmCluDXrdkvas8KG6Th9hE8Rogy/c7eV0NDud4S5K34EeerqYZ1rHhs28+AzK+
        5XnAa7Bq66TiU8Mrfk9cnA2dAFeZAs5+EDa582ghUJ/YryTWpCXdowQtO/lB/xRg
        iIrjzzRVb7/i6dnIN0bLYdsrF4BgYf/H6Bfz2Gz8LXRH46GcKYlaYYAdVWv8kTkM
        rKN+38/FbLBVXiLTgtthOetInX3yWZfKLlUvuLsNiZrseRJfDFR5ErvEvSaHPMml
        qxEOo9C5llsp4AF3yqs8tGxSxrNmtXfyU37EXnlBZMaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MiqDpT57mHdcEU1h7
        zTO+nOinsOSyQk23xizre+RRmU=; b=ZN6ssop/HCiLJriKaw+aIenHv/fsNk7V8
        eGJHvFjx4eTzGMSshUBUQpqWYSZ2HBSNbJrJTrurQWxyePdw4Y+kwZbwQhwI53be
        YeBT9KF5Evxm654RY9M/L3bNtt6SLCncEmWYeblRG40jcIuspP2yPNd8m+CuItpM
        CPBlukNgPVSe8U1Ngv+zFZ8/EULdbbCrHGLQLgRDdDOQeoDzfVgcNjcOwsFsm8lC
        n4pfclo0tvQhFzUFYFQ0Uoz0yYWw5kU9Jax9TNcKZ4fAAq7q/koquYQNOaVb6Yqb
        xEiwX8Rr0yCGcDW0whI7YVckrOXF5AwcwJ1/aySD6m3Q5CoAJaGgA==
X-ME-Sender: <xms:puetX16OGBesd8ve7AYykKpj89L50aDWB2cU3F9obO_etYrDkb3BhA>
    <xme:puetXy4u--9p75xNjSgY2NFZnTw86h152i3dlvSJXqHeXxegXHh4ReT4pQzZkItnV
    UroLOJ9AV-SAvBeVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeetfeehtedvueegtdeitdefud
    ehudefjeetfeejffejuefghedtheevleevudefjeenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:puetX8dVOEfZ7LOWfd9U77T-yzTuNBvdK4aVZeiz0LHkkcO9t5CO6w>
    <xmx:puetX-K7ZNonwYrjMAPTOPcotWoodlieprtidHt0IwBlA46i4fuHpg>
    <xmx:puetX5LPTOr_iufWvMnfaFHd8r3jFdG_4fEkXW8prp7dNbYZkyrLqg>
    <xmx:puetX7zEmVJnBXsNS1fYCeQZITlwodBSB2v62L5V4pmhy_9ghLhT1Q>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9484B3069002;
        Thu, 12 Nov 2020 20:55:49 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH] btrfs: tree-checker: Error out if invalid btrfs_root_item size found
Date:   Thu, 12 Nov 2020 17:55:06 -0800
Message-Id: <0e869ff2f4ace0acb4bcfcd9a6fcf95d95b1d85a.1605232441.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There was a proper error check but it failed to error out. This can
cause stack scribbling against a crafted iamge.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=210181
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/btrfs/tree-checker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 8784b74f5232..6cefabd27209 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1068,6 +1068,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			    "invalid root item size, have %u expect %zu or %u",
 			    btrfs_item_size_nr(leaf, slot), sizeof(ri),
 			    btrfs_legacy_root_item_size());
+		return -EUCLEAN;
 	}
 
 	/*
-- 
2.29.2

