Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA36F4E45
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 03:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjECA7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 20:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECA7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 20:59:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609F810E5
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 17:59:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D15DD5C02C4;
        Tue,  2 May 2023 20:59:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 May 2023 20:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1683075585; x=1683161985; bh=Gj9cTM2DZr
        UAzGtBNEEquI/3rnil+gr66CqefVHNszE=; b=VowC6KVRLBY8Z+HCiMgg39XEJz
        8Z7nwl9nTi7/5Hbu4uXZDi/G5PBGGrj+pRRuu0XZOfYQTEKtJwfswRLAszobH8yQ
        pRCfOU/WyzNzAjwoFLPURriYJyqwPD93+SlhJyvZ8Qc37f7SwHvmqpJP3qK5AW5k
        xIyjdrzaYLdYc2QBR/npjBPtNDAUO40Twpgh0I5CgFW1n/h5eUihmX1kxOvFhfL/
        DJVn2PHdQdsDktCXJuYHXYA1JAiiD0BELqR3drRQJ6+v3cmLLKAGIaUKKrEzwRgI
        I1YdxzSVNIfTQawzHnAXtigZUiLb8Wpx0AUMoZVwX3vE85VTZ+BkReRsLZ9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1683075585; x=1683161985; bh=Gj9cTM2DZrUAzGtBNEEquI/3rnil
        +gr66CqefVHNszE=; b=fOFTpuICGPM4FjIdd562hk++ltYiNyGebxpodH1/DMeH
        gFzchzq+BUMMpUPXK4pOvClqZNZ2LsL9/hd0wwgMKt39YUkLvvz7mjA3Ew2mVJ7w
        hGpoKNbiJ/TEi19uOjjY6UYVN9USN/FbM2TBWKJLliOGHQNlfQeEd5byKF3V6Pd7
        WYGLKvyH6ivNEQwLfOC2kPLgNGMVbgfAo9GP5M+P84d5u58FUx3iRKJGuxYmq+wF
        1I29jknTiIIAGtH/z3x6JCgy4WOm+y1zrDZs8hngP6pLymIVyx2ExwnayKY/ZtHu
        n85WgGnwzBkNLxUhPZlUiSiZIDvLOmWH8dgV+6+ccg==
X-ME-Sender: <xms:AbJRZLaO3s3ud3yJ3QDnR-_O1o9isc6QdAVNflcweFTOS920DoqIQg>
    <xme:AbJRZKZjuEdvU5IZSIO6pzbGbUkf_wI0GUCKrTR7eQlGR5UeeWlM6T5gGfsu-qLfV
    -dqTYRzk4WIXOjqpks>
X-ME-Received: <xmr:AbJRZN_pcfu_DW74dl-6fsJtBX_wzej1AhtH8Z3uR7n-9A1smnPrlwPS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehteeljeeikeehfffghfehteegjeevjeeggeevtdefhe
    etjeehfeeutdefhedvkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:AbJRZBpaFqjc3xOAyYUy42uJJvTYzE6ZmrMmQv0R4cYuJfGElnYL_A>
    <xmx:AbJRZGp9s34eQIclrXAD3QrcfnAFlLSLyMYGFgOvM6iOfTk44JksPA>
    <xmx:AbJRZHQ-uD_0UMTe9hogSU77QyEKFfGTv9m13e8eps3darFlON6nkQ>
    <xmx:AbJRZNTDeKD_kaodH7tEkrYujTklb7EgTkU48rIhXueqVGCR0Yv9xQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 20:59:45 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH RFC 0/9] btrfs: simple quotas
Date:   Tue,  2 May 2023 17:59:21 -0700
Message-Id: <cover.1683075170.git.boris@bur.io>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs quota groups (qgroups) are a compelling feature of btrfs that
allow flexible control for limiting subvolume data and metadata usage.
However, due to btrfs's high level decision to tradeoff snapshot
performance against ref-counting performance, qgroups suffer from
non-trivial performance issues that make them unattractive in certain
workloads. Particularly, frequent backref walking during writes and
during commits can make operations increasingly expensive as the number
of snapshots scales up. For that reason, we have never been able to
commit to using qgroups in production at Meta, despite significant
interest from people running container workloads, where we would benefit
from protecting the rest of the host from a buggy application in a
container running away with disk usage.

This patch series introduces a simplified version of qgroups called
simple quotas (squotas) which never computes global reference counts
for extents, and thus has similar performance characteristics to normal,
quotas disabled, btrfs. The "trick" is that in simple quotas mode, we
account all extents permanently to the subvolume in which they were
originally created. That allows us to make all accounting 1:1 with
extent item lifetime, removing the need to walk backrefs. However, this
sacrifices the ability to compute shared vs. exclusive usage. It also
results in counter-intuitive, though still predictable and simple,
accounting in the cases where an original extent is removed while a
shared copy still exists. Qgroups is able to detect that case and count
the remaining copy as an exclusive owner, while squotas is not. As a
result, squotas works best when the original extent is immutable and
outlives any clones.

In order to track the original creating subvolume of a data extent in
the face of reflinks, it is necessary to add additional accounting to
the extent item. To save space, this is done with a new inline ref item.
However, the downside of this approach is that it makes enabling squota
an incompat change, denoted by the new incompat bit SIMPLE_QUOTA. When
this bit is set and quotas are enabled, new extent items get the extra
accounting, and freed extent items check for the accounting to find
their creating subvolume.

Squotas reuses the api of qgroups. The only difference is that when you
enable quotas via `btrfs quota enable`, you pass the `--simple` flag.
Squotas will always report exclusive == shared for each qgroup.

This is still a preliminary RFC patch series, so not all the ducks are
fully in a row. In particular, some userspace parts are missing, like
meaningful integration with fsck, which will drive further testing.

My current branches for btrfs-progs and fstests do contain some (sloppy)
minimal support needed to run and test the feature:
btrfs-progs: https://github.com/boryas/btrfs-progs/tree/squota-progs
fstests: https://github.com/boryas/fstests/tree/squota-test

Current testing methodology:
- New fstest (btrfs/400 in the squota-test branch)
- Run all fstests with squota enabled at mkfs time. Not all tests are
  passing in this regime, though this is actually true of qgroups as
  well. Most of the issues have to do with leaking reserved space in
  less commonly tested cases like I/O failures. My intent is to get this
  test suite fully passing.
- Run all fstests without squota enabled at mkfs time

Basic performance test:
In this test, I ran a workload which generated K files in a subvolume,
then took L snapshots of that subvolume, then unshared each file in
each subvolume. The measurement is just total walltime. K is the row
index and L the column index, so in these tables, we vary between 1
and 100 files and 1 and 10000 snapshots. The "n" table is no quotas,
the "q" table is qgroups and the "s" table is squotas. As you can see,
"n" and "s" are quite similar, while "q" falls of a cliff as the
number of snapshots increases. More sophisticated and realistic
performance testing that doesn't abuse such an insane number of
snapshots is still to come.

n
        1       10      100     1000    10000
1       0.18    0.24    1.58    16.49   211.34
10      0.28    0.43    2.80    29.74   324.70
100     0.55    0.99    6.57    65.13   717.51

q
        1       10      100     1000    10000
1       2.19    0.35    2.32    25.78   756.62
10      0.34    0.48    3.24    68.72   3731.73
100     0.64    0.80    7.63    215.54  14170.73

s
        1       10      100     1000    10000
1       2.19    0.32    1.83    19.19   231.75
10      0.31    0.43    2.86    28.86   351.42
100     0.70    0.90    6.75    67.89   742.93


Boris Burkov (9):
  btrfs: simple quotas mode
  btrfs: new function for recording simple quota usage
  btrfs: track original extent subvol in a new inline ref
  btrfs: track metadata owning root in delayed refs
  btrfs: record simple quota deltas
  btrfs: auto hierarchy for simple qgroups of nested subvols
  btrfs: check generation when recording simple quota delta
  btrfs: expose the qgroup mode via sysfs
  btrfs: free qgroup rsv on io failure

 fs/btrfs/accessors.h            |   6 +
 fs/btrfs/backref.c              |   3 +
 fs/btrfs/delayed-ref.c          |  13 +-
 fs/btrfs/delayed-ref.h          |  28 ++++-
 fs/btrfs/extent-tree.c          | 143 +++++++++++++++++----
 fs/btrfs/fs.h                   |   7 +-
 fs/btrfs/ioctl.c                |   4 +-
 fs/btrfs/ordered-data.c         |   6 +-
 fs/btrfs/print-tree.c           |  12 ++
 fs/btrfs/qgroup.c               | 216 +++++++++++++++++++++++++++++---
 fs/btrfs/qgroup.h               |  29 ++++-
 fs/btrfs/ref-verify.c           |   3 +
 fs/btrfs/relocation.c           |  11 +-
 fs/btrfs/sysfs.c                |  26 ++++
 fs/btrfs/transaction.c          |  11 +-
 fs/btrfs/tree-checker.c         |   3 +
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  13 ++
 18 files changed, 471 insertions(+), 64 deletions(-)

-- 
2.40.0

