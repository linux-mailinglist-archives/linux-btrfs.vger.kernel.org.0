Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D7A2638A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 23:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIIVp3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 17:45:29 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39339 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIIVp0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 17:45:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8476A5C0130;
        Wed,  9 Sep 2020 17:45:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 09 Sep 2020 17:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=B+Rp/pjVWS/4X58wyOPvLN6u3B
        CdeTUOJeiuoCKjLpk=; b=m7QKwu3O6k7FQZVNZ0bJSrVjVaNmRIqKEWQ/dot2Gd
        KkUnDhO0IcfasRyiONspEF2hxaxXLQBWwtiEFjqcyUvYMC6tr7zqxmuJ+PKj8enb
        CAsyD1BKovkS453ZqkxWTCfHixqsy/CEX43QzueLterbnAEHfDOCL1ec6KZZguch
        ChBYY5vmyFcSN1UBdfvnqDyEVEobMoC8/MpWCXNHiIVOzqC8L3rr8dOZHlpYNjYH
        pjKsLmr9IN05eVbvsiEQSPKaeUfyBbmEK9koFc6q5Fqbe5uWbXKULmFjCs+41PCV
        k82G/YEuPG+PRP9VvHLsEgqAMCdGuWaY1tXXQNxHMwAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=B+Rp/pjVWS/4X58wy
        OPvLN6u3BCdeTUOJeiuoCKjLpk=; b=tsi17ZSBcGNrdEV93oAk+UBx9L+zJoXk7
        0VT8ewmXXreF3e6563N8ZQquri/Q8R2DfOnXd45ImGoWg0mwNl13P3KKrVkTCv4I
        InFMCcjCvAIXM1vT1U4YhbwbSLBipG+Jz/heZQDyKa6AtXiuuSga6qDfXAlKFMxt
        M+2xH6lFxSbLfPazwuh+VVjpMTJGBVr8tk6+HPW+5ZS7pH9EEMYPPbssf9Q3z3ht
        4ccRD0rz8ZRVKRHKot6o6rlrrXou3KDnk4Q5S5egt3mpREcLil44N33xZOey6asS
        2P5k/UhdfvXLZ8tuTb/89CrgxBcL5G/U5KoL8a81jwX0L02kJCQWg==
X-ME-Sender: <xms:9UxZX9cYbQGICtpL1LzPPzI1FQnA2iqP_ZqbGGJlG6JgmxxdVKRrRg>
    <xme:9UxZX7PZ7j_Fd_2v3hWNyF6uCEOlzp5uuf6F7xjbbuNgDGjuLCY5_DBFSQHrljrqf
    ibI0M_Y2unr7dyu9Tk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehiecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhk
    ohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuie
    ejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphepudeifedr
    uddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:9UxZX2jbrbLc1kQDI_3v5FYt68cE4CeONOqYAF92ga0co6A8sCuLKQ>
    <xmx:9UxZX29H6f9DsazGprwtqr3Qar2GLrKkJacn-OAk9u1klZqOmcpprw>
    <xmx:9UxZX5voGOXx2hpRzEhlQk3e5DXYM02xMq29nMlAB1NnlI2OJLiAGw>
    <xmx:9UxZXxKnJQshkGR9D32qZSwyO2ae7_GN096mntPqngne3E8SQ3Jeyw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 047FA3068BF3;
        Wed,  9 Sep 2020 17:45:25 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Dave Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 0/3] btrfs: free space tree mounting fixes
Date:   Wed,  9 Sep 2020 14:45:15 -0700
Message-Id: <cover.1599686801.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few fixes for issues with mounting the btrfs free space tree
(aka space_cache v2). These are not dependent, and are only related
loosely, in that they all apply to mounting the file system with
the free space tree.

The first patch fixes -o remount,space_cache=v2.

The second patch fixes the slight oversight of not cleaning up the
space cache free space object or free space inodes when migrating to
the free space tree.

The third patch stops re-creating the free space objects when we
are not using space_cache=v1.

changes for v2:
Patch 1/3: made remount _only_ work in ro->rw case, added comment.
Patch 2/3: added btrfs_ prefix to non-static function, removed bad
           whitespace.
Patch 3/3: new in v2, was part of Patch 2/2 in v1.

Boris Burkov (3):
  btrfs: support remount of ro fs with free space tree
  btrfs: remove free space items when creating free space tree
  btrfs: skip space_cache v1 setup when not using it

 fs/btrfs/block-group.c      | 42 ++++----------------------------
 fs/btrfs/free-space-cache.c | 48 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/free-space-tree.c  |  3 +++
 fs/btrfs/super.c            | 29 ++++++++++++++++++++++
 5 files changed, 87 insertions(+), 37 deletions(-)

-- 
2.24.1

