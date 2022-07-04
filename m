Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8455653F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 13:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiGDLmm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 07:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGDLmM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 07:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6F6199
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 04:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7EB60AE3
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 11:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82877C341CD
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656934929;
        bh=r8AvoU2fZ+01KvGx86OdS4eZy19Wbar4s7BVN4ugZXE=;
        h=From:To:Subject:Date:From;
        b=PPbRoVR4ysKQXpI6n2oN9DG67Ufhopkfml9W9K7Fl7q/2aKS3jVYAycyz9yC/i1WV
         Cf8V32n3LIo2no80hg2gg2wSB9LfWJMu0k7Tg6odfgEFGpX91SxRtQvJMiUro1s2ID
         nzzBRmB4JhubCCmxdwQUzdPaRE9UhiMc92+Ojq6g0vEg5PUkJIwfaoKrAzgd0gHl2N
         sAsSCwD8q8vm/ZeW8Yt2WWGZAZvcfZ2mEgaUnCrk/X2W3seBtDWB4uKWBFtQTY17Xt
         vX2nihpi2pt17scbGjnjkmjH0nXuY/j7OxreDyemJGw7yGirXiLu5xO2vk3dPocuIy
         kvaEVcbDOMFPQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: a few direct IO fixes/improvements
Date:   Mon,  4 Jul 2022 12:42:02 +0100
Message-Id: <cover.1656934419.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Several fixes and improvements regarding direct IO, with the first one being
recently reported by Dominique when using qemu with io_uring on images that
have a mix of compressed and non-compressed extents. That in particular
exposed a bug in qemu's handling of partial reads, fixed recently by
Dominique, but despite that we could avoid returning a partial read when
there's really no need to, not just for efficiency but also because many
applications don't take into consideration partial reads (MariaDB for
example didn't use to until recently) or are buggy dealing with them.
More details in the changelogs.

Filipe Manana (3):
  btrfs: return -EAGAIN for NOWAIT dio reads/writes on compressed and
    inline extents
  btrfs: don't fallback to buffered IO for NOWAIT direct IO writes
  btrfs: fault in pages for dio reads/writes in a more controlled way

 fs/btrfs/file.c  | 72 ++++++++++++++++++++++++++++++++++++------------
 fs/btrfs/inode.c | 14 +++++++++-
 2 files changed, 68 insertions(+), 18 deletions(-)

-- 
2.35.1

