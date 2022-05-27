Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990C2535BC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349582AbiE0Inb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbiE0In2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:43:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F11C2AC53
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4ubUD/KztmzUYIfCwe1Ej5+W/j7gidL9uqmfeEVAktQ=; b=2WrhFiRWTU2Swt/9EIbaDnhs2y
        yfCpLi7/e7zeRegZcM+k4Q51fX57WuRGAX6xvIuLO58Dh/CIUV5Q53EX02Ps8FcBGAIJNz6oIt7Ck
        jIRCubyfX24bpWLcSi3fbYUP+cG1+5iT/aOQgVBj2pYVKjGSpwsNerS4erx9WNhxLuvHgVSJgqfhZ
        doBtDzk9WHo3UU/nwBN8gxhyw1KDJ1wUEHEx1b586fGL2rD9gErfnVZLjbjwth1/vNymS9RbR5rbA
        VQdp3TVDxS/jx9djZwS/Swiq3Efq2kmZdBz50PWzOLzrU/9UhMlm5QgpavW5jx6ACluYkukFt1qUP
        SHlQT7/A==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVZ4-00H3Ts-8g; Fri, 27 May 2022 08:43:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: simple synchronous read repair v2
Date:   Fri, 27 May 2022 10:43:11 +0200
Message-Id: <20220527084320.2130831-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this is my take on the read repair code.  It borrow a lot of concepts
and patches from Qu's attempt.  The big difference is that it does away
with multiple in-flight repair bios, but instead just does one at a
time, but tries to make it as big as possible.

My aim here is mostly to fix up the messy I/O completions for the
direct I/O path, that make further bio optimizations rather annoying,
but it also gives better I/O patterns for repair (although I'm not sure
anyone cares) and removes a fair chunk of code.

[this is on top of a not commit yet series.  I kinda hate doing that, but
 with all the hot repair discussion going on right now we might as well
 have an uptodate version of this series out on the list]

Git tree:

   git://git.infradead.org/users/hch/misc.git btrfs-read_repair

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-read_repair

Changes since v1:
 - rebased on top of the "misc btrfs cleanups" series that contains
   various patches previously in this series and the
   "cleanup btrfs bio handling, part 2 v4" series
 - handle partial reads due to checksum failures
 - handle large I/O for parity RAID repair as well
 - add a lot more comments
 - rename btrfs_read_repair_end to btrfs_read_repair_finish

Diffstat:
 fs/btrfs/Makefile            |    2 
 fs/btrfs/btrfs_inode.h       |    5 
 fs/btrfs/extent-io-tree.h    |   15 -
 fs/btrfs/extent_io.c         |  570 ++++---------------------------------------
 fs/btrfs/extent_io.h         |   25 -
 fs/btrfs/inode.c             |   55 +---
 fs/btrfs/read-repair.c       |  248 ++++++++++++++++++
 fs/btrfs/read-repair.h       |   33 ++
 fs/btrfs/super.c             |    9 
 fs/btrfs/volumes.c           |   97 +++++++
 fs/btrfs/volumes.h           |    2 
 include/trace/events/btrfs.h |    1 
 12 files changed, 467 insertions(+), 595 deletions(-)
