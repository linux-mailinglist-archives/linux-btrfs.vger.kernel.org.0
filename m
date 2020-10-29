Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4882F29F956
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgJ2X6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49729 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:34 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A1305C00DD;
        Thu, 29 Oct 2020 19:58:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=jpS/w6iqmvKNHpceFjPc/umWEP
        efzVobPQYltFIFD/A=; b=Q122rEUhYWzlxK+7kEVVqnh4XiMKFM5wxok6J0lyT4
        xoxCcffS6Tnr6vxmHaqYnDgrCJKJlBzRbZNk6psmwFw3hDl7ZzRTGeNkHTkIGAVL
        VTGGjgyeg8Fjk8o+5aHu42QfPB8luBO+goxkq736C+oe27d7bo9kmBEcSyhq4bxz
        FPs53MdkAqk131QULGpc9ixlaJKSqrvaeF3Lr/clGI4SjbWGkfhWzR8Daq9ATMw8
        G0KEBDDAKnU9nxwVonNDkcEDXbwvZB6P1HZKSyU3yeP1J5/1c2fwEimLQOkNKpwI
        MvVlYEuxlWK3pSWAMdQ9azPde0Gde62AeTL4wlyn3uHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jpS/w6iqmvKNHpceFjPc/umWEPefzVobPQYltFIFD/A=; b=mBs7HhKw
        TL0aZrMSN0SXITkzYXuBKh7Z11E8b6f1KHR3IXcaGj7yk91CGKrRFTFyJUMya032
        +/dFvlmSbaxApOM3nJzUX5nFyoYWqb4CmRqcWjGHJSlUCjb2vbZHXj4EOza/9yOr
        oI9dPAQfuNr2E2fe55QMPR+xB7Llgu9fPlyX8k+dCzjK7T8LWLFPiYeRelAEMqEq
        1PafbenYJz6iewZWn3SnD4UCDZroLJcwQjwxcK9z3NMZdn6xex4PyjmQGZELXM7b
        qzkBbzZ5ynVDRBitlltDyyaq+5dcFZ1heXUBMNWZzYDs93tW0PcvwFsr8lyiLELO
        nV+V1ogH4uAN5g==
X-ME-Sender: <xms:KVebX9rXpNXTtOvlXFdTIR0VZm8ouIIJo5snp3zH9dTIfNk68p19iQ>
    <xme:KVebX_rfC2In6CHNUwFS8jKPiy1yG3gmeTSqYq5O-8KRU_MBpFfhPkM65HjItu0VT
    zumXFU1WfrWZxS7W4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepkeenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:KVebX6NRIai8cWTrWmGUZowSx43DBIMrStYHrcfHsgcW1ZjkmPB25g>
    <xmx:KVebX46gr2YetyK5f5xApYcW3W-YgOoJBfyMp-SeQrrkOD1g150C5Q>
    <xmx:KVebX860MuaLMmTRh4D0iGb693YqrMJz4ktparNu1McsmA_BcKf8lQ>
    <xmx:KVebXxVYihgkICua5dYqmJMguqaP0fLX0AMsdmahdGZ1Q581QdC6Lg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id C83CC3280066;
        Thu, 29 Oct 2020 19:58:32 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 10/10] btrfs: skip space_cache v1 setup when not using it
Date:   Thu, 29 Oct 2020 16:57:57 -0700
Message-Id: <97ff859cf0df9b5db6313df215fa62754213fb4b.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 2dde5c6f1da8..13a16158f4c7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2374,6 +2374,9 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
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

