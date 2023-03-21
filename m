Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5926C374E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 17:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCUQqI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjCUQp6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 12:45:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDC252911
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 09:45:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 81CAD5C0120;
        Tue, 21 Mar 2023 12:45:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 21 Mar 2023 12:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1679417135; x=1679503535; bh=7ao2iaKo8c
        w9pTDxFyCBM9mdHcew1txqKh58nvtRw18=; b=MRM+uPm+RaTUB3WjHvDbVijH5S
        IB7w7tBquC0QZKPokwCXWAVCq8fToggnI/hgk/XkDJ8ar+arEMIBxVXYHfULQxiN
        fRHUf9IWhRd+/c8f01YI19OrBreh5nfAcUL0FDBG4osBihX6q2dqqqcpK0r28ZRi
        0rc2IVlrUheQ85A2pqpzn26hHv6ZpMaErzFPsy13iarnY8ThjCBOqtzTO4xkJPr7
        gLHzhP1glWglkJxFwFytYfM9x9fUtGaWU51kqoCbV9AZBvNUe8fihOrfJhA/aSuS
        ILSdCG5pFIasxyeKU9rEhz/pW9EO7xEcYW2x0cT6Vx/3WrFAIx0kEnf78zNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1679417135; x=1679503535; bh=7ao2iaKo8cw9pTDxFyCBM9mdHcew
        1txqKh58nvtRw18=; b=GPPyKAsjNrwAGVRtD/oMTeXnsI78e1W13BotQgXg7gZU
        vEhXTFx/RfrXiz9xKIttW+yZ8+aO443e6RUB1M8o6AxNF1MywyQdFEJJIaWZvxEL
        E4+eSDwK8YkfAJWmGVeX8JQ+HK9EuFUhW0YcHLoFAoiiYma5VNuox6EevyUXlTA5
        rI6UaCKoo6d2OInRuhRpcbgryXGB8DMJJNmwVqCOCWq+cyimSiqldBC63DqeDrGW
        M3o+tFRnIUdO8bAg55QiRrN0lNneF+wrogZBnwaIhyvhXox3WYh0146hFKs7u5gQ
        9TqMNp2/h3SesISENCp4/UVVWwm2ac1mFTHJbOyhbw==
X-ME-Sender: <xms:L98ZZDB994oGuf-nyxWEhSm8b0IOPMSL0XzagIgwRUC-6lj33OOYcw>
    <xme:L98ZZJiJD9ZQaw0_1yJ4H1_YzXshPy-MMngBsKyHLf2L4DJgRQZ4vB3v_rESWu142
    GXv_tEiNEA87T1CPbk>
X-ME-Received: <xmr:L98ZZOl9vLmnzLWKUmusHF1ANBpfvwvQZnulqoFSreWbczQz6i2xoTpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:L98ZZFxeENQLaKwfJ5L_qWbv3yaO0m4tP-WEsRhgFraY5SdsvcigRw>
    <xmx:L98ZZISZ0gA1VJdDh2Du7AHaswBLYktysQz2IP-EzveO4uC8YQJ6Yg>
    <xmx:L98ZZIaRLg4QXqlkuxci4K7OEiapIEjVt0aOdhXlKPjxk1c0TzNU7Q>
    <xmx:L98ZZB4PehUk7uSOF-TJUbjoVkxEPRklwHGCxDsYY1rPguNIVc6DBg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 12:45:34 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/6] btrfs: fix corruption caused by partial dio writes
Date:   Tue, 21 Mar 2023 09:45:27 -0700
Message-Id: <cover.1679416511.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The final patch in this series ensures that bios submitted by btrfs dio
match the corresponding ordered_extent and extent_map exactly. As a
result, there is no hole or deadlock as a result of partial writes, even
if the write buffer is a partly overlapping mapping of the range being
written to.

This required a bit of refactoring and setup. Specifically, the zoned
device code for "extracting" an ordered extent matching a bio could be
reused with some refactoring to return the new ordered extents after the
split.

Patch 1: Generic patch for returning an ordered extent while creating it
Patch 2: Cache the dio ordered extent so that we can efficiently detect
         partial writes during bio submission, without an extra lookup.
Patch 3: Light refactoring of split_zoned_em -> split_em
Patch 4: Use Patch 1 to track the new ordered_extent(s) that result from
         splitting an ordered_extent.
Patch 5: Fix a bug in ordered extent splitting
Patch 6: Use the new more general split logic of Patch 4 and the stashed
         ordered extent from Patch 2 to split partial dio bios to fix
         the corruption while avoiding the deadlock.

---
Changelog:
v4:
- significant changes; redesign the fix to use bio splitting instead of
  extending the ordered_extent lifetime across calls into iomap.
- all the oe/em splitting refactoring and fixes
v3:
- handle BTRFS_IOERR set on the ordered_extent in btrfs_dio_iomap_end.
  If the bio fails before we loop in the submission loop and exit from
  the loop early, we never submit a second bio covering the rest of the
  extent range, resulting in leaking the ordered_extent, which hangs umount.
  We can distinguish this from a short write in btrfs_dio_iomap_end by
  checking the ordered_extent.
v2:
- rename new ordered extent function
- pull the new function into a prep patch
- reorganize how the ordered_extent is stored/passed around to avoid so
many annoying memsets and exposing it to fs/btrfs/file.c
- lots of small code style improvements
- remove unintentional whitespace changes
- commit message improvements
- various ASSERTs for clarity/debugging


Boris Burkov (6):
  btrfs: add function to create and return an ordered extent
  btrfs: stash ordered extent in dio_data during iomap dio
  btrfs: repurpose split_zoned_em for partial dio splitting
  btrfs: return ordered_extent splits from bio extraction
  btrfs: fix crash with non-zero pre in btrfs_split_ordered_extent
  btrfs: split partial dio bios before submit

 fs/btrfs/bio.c          |   2 +-
 fs/btrfs/btrfs_inode.h  |   5 +-
 fs/btrfs/inode.c        | 185 +++++++++++++++++++++++++++++-----------
 fs/btrfs/ordered-data.c |  88 ++++++++++++++-----
 fs/btrfs/ordered-data.h |  13 ++-
 5 files changed, 214 insertions(+), 79 deletions(-)

-- 
2.38.1

