Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608446C5497
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 20:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCVTMS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCVTMR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 15:12:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5CF3526A
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 12:11:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AC8A55C01BC;
        Wed, 22 Mar 2023 15:11:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Mar 2023 15:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1679512315; x=1679598715; bh=dk2o/oxrWa
        5rkOxMqFFw/JkDlbqxkHtNccoyyECLmiE=; b=HU3NSe7tiiqOxH2AkWfG//g6ON
        h+emgrtf+PEawTrP+OrskFJRvLK/Jtl3AtKdBzeOHnY9jPlx+0aHNcObIwrsce0K
        sOD1WLeluvpkvqikIX+hEUo6bY2a/4xfqqrUf3KGnolx3L1Bqkz06QLUFhHg34Sn
        RBKgjN3DWzgxk8YCvtz9HBQlRrdF4kTLh8sF7fI5TX1KADPw/Z3uUi16qPKoLEpj
        TbzR7vueXRrBWwEtqTRXSGDTLGfwQkgEIfRcyuAMEzPejjL6d6uwOCavjeSgsDeN
        rk3Pk1YaVmq8jXEzCMv6sGzLK6OALUsfgmqbY5lDIG5WX7fka1zDud74gwdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1679512315; x=1679598715; bh=dk2o/oxrWa5rkOxMqFFw/JkDlbqx
        kHtNccoyyECLmiE=; b=Ltn4WYsrUDWijmlV2O2lvZ85UV81FISCa+Ny9ODJqHBo
        F54MJKWAb2YBCo4dWMw+786k3p1bv5Z1U7+ZoPN1U+7Bi12VUBQ9zr5KaZOvSqPN
        gogIp4bYGCKQPN92vZsE+Emy4eVfIyGxAgQl92VEQLTgJ1G/iafexyR9/e1Hryo3
        u6m/EZBxlm7b6dBTpmKCek7HM5OS6pDnQKkUfTbnYCaMu0+uTq2MSKRgnwJZA0K4
        6TPCyhzEQzfn6lz5fatlAI6NT98gwfsHNZ3yPYP3eNoJ150lfGlxBCkYXwVemGdq
        eVZKEZjilOIyI1RpGgb86VYtY7VkOW3edXtxSgEKrA==
X-ME-Sender: <xms:-lIbZGOwHTn61NPO3cHpRJLSZiSv5VvJWgZ6302nlr8vDpqCo9j3gA>
    <xme:-lIbZE8oV7uWkkpf548r1C7g6jaVUGIS4Dx2gpU8ZFA4uefnwjnqN6Y6uVhuf1P5V
    5kY9EBSwZwGpazOGrI>
X-ME-Received: <xmr:-lIbZNR7h7RqETPL3OWAuMzY0qg2GZ21xnj7opLVQ-9Xo8MKgYA8qaEV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:-lIbZGudQ9t2rAT19BJC06bjaMiTTu_m7l4X1cowRRnYH4pDTqiZXQ>
    <xmx:-lIbZOfsH0DoNVlpP5CINn7psjLbRmUvvY9Je8jh4zyUwFJygO-bRQ>
    <xmx:-lIbZK0ESjSeSZLvyFheNXzgcz8Y_1XnFJ6pfTlRKMH2_QdYdLo0jg>
    <xmx:-1IbZGm_UCV7VVSNHuWal3eMyhqs07CsXv_ANTtTJT3byuSfRIMzcA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 15:11:54 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 0/5] btrfs: fix corruption caused by partial dio writes
Date:   Wed, 22 Mar 2023 12:11:47 -0700
Message-Id: <cover.1679512207.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Patch 3: Use Patch 1 to track the new ordered_extent(s) that result from
         splitting an ordered_extent.
Patch 4: Fix a bug in ordered extent splitting
Patch 5: Use the new more general split logic of Patch 4 and the stashed
         ordered extent from Patch 2 to split partial dio bios to fix
         the corruption while avoiding the deadlock.

---
Changelog:
v5:
- skip splitting em on nocow writes, this removes the need to refactor
  split_em, so remove that patch, and just rename split_zoned_em to
  split_em.
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


Boris Burkov (5):
  btrfs: add function to create and return an ordered extent
  btrfs: stash ordered extent in dio_data during iomap dio
  btrfs: return ordered_extent splits from bio extraction
  btrfs: fix crash with non-zero pre in btrfs_split_ordered_extent
  btrfs: split partial dio bios before submit

 fs/btrfs/bio.c          |  2 +-
 fs/btrfs/btrfs_inode.h  |  5 ++-
 fs/btrfs/inode.c        | 94 +++++++++++++++++++++++++++++++----------
 fs/btrfs/ordered-data.c | 88 ++++++++++++++++++++++++++++----------
 fs/btrfs/ordered-data.h | 13 ++++--
 5 files changed, 152 insertions(+), 50 deletions(-)

-- 
2.38.1

