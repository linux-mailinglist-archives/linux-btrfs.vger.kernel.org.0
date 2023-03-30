Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF06CFB88
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjC3GbI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjC3GbH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160AA4C3B
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HPcYFhK9Hc5iJcrxXdk+8qQE4wag6QTyROFmR4sP6vo=; b=UuYMqJy7GuU7Rg1DxyBVr+1YUI
        pSKgxmNkJgcLC6HpcnHpBfLw4YX9RM/ypmuloIS8XrA0AYujmjHHDbiJXNQKbFeojhbQrdYNyLeS5
        jaybupbHK0QfXg/7+1wGTNQUG8S87yRFinEik8IwyK3t6nlHfKGsEcUVy/C1k+dhrKFUBgk/4In//
        JGg27qzq6OE5hW0DsOhQ8nubj3hLHZ19nin8tgbE3g6+8Sr/sIrFvamTNWWNWEqKIOUtUj66WS0KN
        wDhI3b1J+aoKOUwzjDMBD7WO7vUao/YYNyy7HFKqo8GXneTFlz9yRVLNyMsSu8J8dPYB9KtIfYB95
        276XfO8g==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phloM-002laA-1F;
        Thu, 30 Mar 2023 06:31:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: simplify extent_buffer reading and writing v3
Date:   Thu, 30 Mar 2023 15:30:38 +0900
Message-Id: <20230330063059.1574380-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

currently reading and writing of extent_buffers is very complicated as it
tries to work in a page oriented way.  Switch as much as possible to work
based on the extent_buffer object to simplify the code.

I suspect in the long run switching to dedicated object based writeback
and reclaim similar to the XFS buffer cache would be a good idea, but as
that involves pretty big behavior changes that's better left for a
separate series.

Changes since v2:
 - fix a commit message typo
 - don't use simplify in commit message titles

Changes since v1:
 - fix a pre-existing bug clearing the uptodate bit for subpage eb
   write errors
 - clean up extent_buffer_write_end_io a bit more

Diffstat:
 compression.c |    4 
 compression.h |    2 
 disk-io.c     |  276 +++-----------------------
 disk-io.h     |    5 
 extent_io.c   |  605 ++++++++++++++--------------------------------------------
 extent_io.h   |    3 
 6 files changed, 197 insertions(+), 698 deletions(-)
