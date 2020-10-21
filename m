Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E5295501
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 01:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507013AbgJUXGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 19:06:55 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:39345 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507008AbgJUXGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 19:06:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 7519412A1;
        Wed, 21 Oct 2020 19:06:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Oct 2020 19:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=HpF5ODtuuUMA9yniIzM7gAdfAV
        6XFJucoEdMBZpsEo8=; b=SSkiPl7CHKcAXZuq9+gYpMyC7+kxINGeGBSJlhpY0q
        HeS/muHO/D1zyDg9Sljxw8FOqSiPx08P5n/JJsis8fBOznBDcxgXfE3ZxzEfDa6N
        yle7V0VUPMJJb0uF8Z7mNtEV3hie6PfvrhL6n1xrvPs6TZR0tObJ9quyoXObpfZl
        NtXplYDHXDb1EjOSeq9S8Ye3NBE+D5DHVrj3Fw6AKE5miOUwgM8cGuUfUKPgB8hK
        zl3khTYY9EG/1jlJxzvWJ2uqeShFaXFuwNfI3TZ5evmsPrRAlvM7QLZAERQC9i2c
        L2aDVhTdBSMpK0ZbksJtaO7gZ6ccqCFIaWoL0gZbbQIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HpF5ODtuuUMA9yniI
        zM7gAdfAV6XFJucoEdMBZpsEo8=; b=J2U0jRB/GOgucWB2vOIu4//g0CfZSC/1y
        ArtcDV2v9wP3wDoYo0jAn+P5Ac0k2mjMYHUWeVh37m+7IOZJ1ZttFx9Q3WBhhzuz
        2tOCGq+dAm70bm1SQe+bIJqEtntdHDnpzNWI3G85sRn6bbVO7posB2ItlgbYFUvZ
        fTcm5t4lHcXVkqw5fE2OzvAOp+rrUk7DKpty7KLmHf2P6IWK4smX5zVa4MmjUVxz
        rf5n3uFV4Y09AqTPLlw1jk5u/IwbUGjrHQ7NX4scIaeFjdiY/+qKO4J1RyB6pRpe
        Zla8mhBTP/bLyPG8irrHbSXpN08qd4gcrLtCOt9BRjFRcnAtDP5Ww==
X-ME-Sender: <xms:DL-QX7XSqzD4IYnpo__CXE_1oYB9i_of_HweRtmNIkixKOmNNTBGtQ>
    <xme:DL-QXzlxSZWKS-BLHfnOL03ueeNYSEGD5dLhLzmoJKebSSFRNdO8ULwK6qvzW7VAe
    lYyw5YJj2HpSc4v7rY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrih
    ho
X-ME-Proxy: <xmx:DL-QX3bD6lHyvwTYySYoVzwC3rm40uOhwzcxk4J5OgTce_PuwCGUkA>
    <xmx:DL-QX2WpPJacKD0jdHOSgXFi8ZYTGIJxDl41NSysQc67W1zgdLNHFw>
    <xmx:DL-QX1miZHNYR9QfmtGroRmxqBV3untRGuGPku-qu1UyoY8h-DcEAg>
    <xmx:Db-QX0uZBBFtFBEZitkGUPEkbabaw27DG5j3l7liZ2rYuah3q0v9YQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5C5FF3064680;
        Wed, 21 Oct 2020 19:06:52 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v4 0/8] btrfs: free space tree mounting fixes
Date:   Wed, 21 Oct 2020 16:06:28 -0700
Message-Id: <cover.1603318242.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch set cleans up issues surrounding enabling and disabling various
free space cache features and their reporting in /proc/mounts.  Because the
improvements became somewhat complex, the series starts by lifting rw mount
logic into a single place.

The first patch is a setup patch that unifies very similar logic between a
normal rw mount and a ro->rw remount. This is a useful setup step for adding
more functionality to ro->rw remounts.

The second patch fixes the omission of orphan inode cleanup on a few trees
during ro->rw remount.

The third patch adds enabling the free space tree to ro->rw remount.

The fourth patch sets up for more accurate /proc/mounts by ensuring that
cache_generation > 0 iff space_cache is enabled.

The fifth patch is the more accurate /proc/mounts logic.

The sixth patch is a convenience kernel message that complains when we skip
enabling the free space tree on remount.

The seventh patch removes the space cache v1 free space item and free space
inodes when space cache v1 is disabled (nospace_cache or space_cache=v2).

The eighth patch stops re-creating the free space objects when we are not
using space_cache=v1

changes for v4:
Patch 1/8: New
Patch 2/8: New
Patch 3/8: (was Patch 1) Made much simpler by lifting of Patch 1. Simply add
           free space tree creation to lifted rw mount logic.
Patch 4/8: Split out from old Patch 2. Add an fs_info flag to avoid surprises
           when a different transaction updates the cache_generation.
Patch 5/8: Split out from old Patch 2, but no change logically.
Patch 6/8: Split out from old Patch 1. Formatting fixes.
Patch 7/8: (was Patch 3) Rely on delayed_iput running after orphan cleanup
           (setup in patch 2) to pull iputs out of mount path, per review.
Patch 8/8: No change.

changes for v3:
Patch 1/4: Change failure to warning logging.
Patch 2/4: New; fixes mount option printing.
Patch 3/4: Fix orphan inode vs. delayed iput bug, change remove function
           to take inode as a sink.
Patch 4/4: No changes.

changes for v2:
Patch 1/3: made remount _only_ work in ro->rw case, added comment.
Patch 2/3: added btrfs_ prefix to non-static function, removed bad
           whitespace.


Boris Burkov (8):
  btrfs: lift rw mount setup from mount and remount
  btrfs: cleanup all orphan inodes on ro->rw remount
  btrfs: create free space tree on ro->rw remount
  btrfs: keep sb cache_generation consistent with space_cache
  btrfs: use sb state to print space_cache mount option
  btrfs: warn when remount will not create the free space tree
  btrfs: remove free space items when disabling space cache v1
  btrfs: skip space_cache v1 setup when not using it

 fs/btrfs/block-group.c      |  42 ++---------
 fs/btrfs/ctree.h            |   3 +
 fs/btrfs/disk-io.c          | 141 ++++++++++++++++++++----------------
 fs/btrfs/disk-io.h          |   1 +
 fs/btrfs/free-space-cache.c | 121 +++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |   6 ++
 fs/btrfs/super.c            |  59 ++++++---------
 fs/btrfs/transaction.c      |   2 +
 8 files changed, 241 insertions(+), 134 deletions(-)

-- 
2.24.1

