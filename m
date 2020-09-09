Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA882638A8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 23:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIIVrE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 17:47:04 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59237 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIIVrC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 17:47:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3974E5C00EB;
        Wed,  9 Sep 2020 17:47:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 09 Sep 2020 17:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=bYm5PRfdB6LUT
        UDJ9XSXOiHVFdiOrqPvHtv2a5oVMeA=; b=nxBQHySg5oeupISc2GFlK4Aw86UkX
        q4IMQQc5O+RzORx3ffr2g53RRzWvzLZnZ2pQ2HYtHLO8GCJsXd6mcN94bCL/26+w
        0bxC56pt3QPwwtAVgv2M2Iss8UrAKwgllPMV3OIBWSb0wqOM8tatjD6NuhOZtMzL
        4yx8Zsd9Pxk5QNjbxT1HKRto3Shko4fTnkW4Mxe+nFf87eoF5QzZ5cZ+rsfcZnAr
        QvHKuEqxTYYmC9SFZ0Pywg4JZvDwc2ZiNas2cNFl98F+2sQhbjxHFF0a1W2xn15R
        quAmEpwbqWt6skH0Zu+RL2SPrUJY73+iUi/mDJLxhghS7NVkweE6zDi0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=bYm5PRfdB6LUTUDJ9XSXOiHVFdiOrqPvHtv2a5oVMeA=; b=CqPitWuw
        wUk36xExY5Y2ZFB1UV3yTJAgz1xu4SmEhKz7oqntGFjuqiUmCzF7GVLNv8V7O7aB
        A28m+xFDymKc0ZomusGsCYmjfe8TrE0Y3StC0IvnwdvpUB75H6cRsCEyFKDwvyi3
        3YEeRiZCmdiomeLCf+gNXFzP0u2+Snzxp0R5n+EPbvB/4HXx0GU9HqB0/4QRMvCh
        rC5mz9CycJi+dQE5iL6Ci2H+9LLZy+A4SWK+5/NSKomZyW6drO88qJsfbZTAEdkY
        JKAfCHvhAtJnRubxJ4bCAY2VTszjfNEXWe9vbf7dRwUImsKPF+4H94OgjsD4nDrx
        DBsdlUCqJVVjGw==
X-ME-Sender: <xms:VU1ZXxZvAtKYakW1OWelDUJQdhMww4yvcml7YXgdM-icwvPCrHHEcg>
    <xme:VU1ZX4YsFV8eYaOuGD05RFIRMjWEE7AR7CD2vopL4Kw6whU0-t2DmOsQoYe0b39Le
    xK5GEahfMgKawRWFx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:VU1ZXz-x7LhxJqiJY4SYs4aXgdsgyJ8YgNu5ovm_ijaFmi_5c90kHg>
    <xmx:VU1ZX_p9_bC-yeSTqgg1TKIozzDjTSbUvzDO7RP5EoA7MCJ9VYw5Dg>
    <xmx:VU1ZX8oD2UVr36eqaZGIxSM9wdG0jIFEzqQ-Vyk9V9yhnIZUS00sHQ>
    <xmx:VU1ZX3Xx7mpAw0o0hVH5foQ1OVSoOfcIjI95LAIp3vwOtLuygkfebw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id A72AE3068C64;
        Wed,  9 Sep 2020 17:47:00 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Dave Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: skip space_cache v1 setup when not using it
Date:   Wed,  9 Sep 2020 14:45:18 -0700
Message-Id: <2e20e4da6a0df68bc29e85e173f70fcd393df2fa.1599686801.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1599686801.git.boris@bur.io>
References: <cover.1599686801.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we are not using space cache v1, we should not create the free space
object or free space inodes. This comes up when we delete the existing
free space objects/inodes when migrating to v2, only to see them get
recreated for every dirtied block group.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e5e5baad88d8..b3502a887978 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2308,6 +2308,9 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	int retries = 0;
 	int ret = 0;
 
+	if (!btrfs_test_opt(fs_info, SPACE_CACHE))
+		return 0;
+
 	/*
 	 * If this block group is smaller than 100 megs don't bother caching the
 	 * block group.
-- 
2.24.1

