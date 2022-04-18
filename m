Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2AE504BBD
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 06:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiDREp7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 00:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiDREp6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 00:45:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C37813E97
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vCwx+gyboTF3f9eUi3tJCL2UQHjCs/Uwvh74Sgj3tfg=; b=qPiwAMUXf+T9xcAFAZ6k+QEUuh
        7uUMqUVcNAl7byIDy7ItBJ2ZZVLbg5AmbFPxH8dUK0ezxDVS+QGEOLV3W5p/lZq+dY/YhRtpMcnaA
        CO+TNYHfH5TMBVqR5b2c4GbQyH49aIm24zOe9189/tyxlQb8j1rw0B9Zh23hf6gDvchWaJR1Q7Gqf
        fY5Qwbkm9/N4hs2G0zHR/r/xytdvujkKyN9VRqG/ds7Raxhx35JwrwedTsqCQNX4aNyDEYvJmxN2o
        bMxiWCq/iXizEai2BayIDIb4BGwNMW/dEQ+5p8pRV5jZ5OwPbnLxUeX9ij1CO96lreaIpRPqvBpqB
        zCX2NCaA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJEJ-00FYR4-Dr; Mon, 18 Apr 2022 04:43:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: btrfs_workqueue cleanups
Date:   Mon, 18 Apr 2022 06:43:08 +0200
Message-Id: <20220418044311.359720-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series cleans up the btrfs_workqueue implementation, and switches
a few workqueues to use the cheaper normal kernel workqueues.

Diffstat:
 fs/btrfs/async-thread.c      |  123 ++++++++-----------------------------------
 fs/btrfs/async-thread.h      |    7 --
 fs/btrfs/ctree.h             |    9 +--
 fs/btrfs/disk-io.c           |   19 +++---
 fs/btrfs/raid56.c            |   29 ++++------
 fs/btrfs/scrub.c             |   76 ++++++++++++--------------
 fs/btrfs/super.c             |    3 -
 include/trace/events/btrfs.h |   32 ++++-------
 8 files changed, 105 insertions(+), 193 deletions(-)
