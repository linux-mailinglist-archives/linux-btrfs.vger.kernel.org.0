Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4EB6B1F4E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCIJGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCIJG1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:06:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59583DC0A1
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5i+rhiKJY0PCpfgPIPbulTaZS+zdlZkVCyhspr8vOqY=; b=Ps7z7w+1qeTCWPl9grBcCNgRD4
        WGCbNgjzVGUZabHWbwnJEeJXvdbmOFU1s3IQ6oCyOE7L+vUsiJ26h4zqCHcnKpN3rzrCsqNWU9Zg8
        SCjo56qbGsfyKEJHgYk8ZfO/fDk9qUg3falp+rl5H+kbgDTw3lyVHeKyNoRQl5cfghBUXSaFF5b14
        OyAUpZUTOq0rjF3U5pnXTBXq9iXajDQX3H5K5UDLJi3GVrjCyegUlCZ/txmo8si+As0n8BoMT0e1V
        TCQoStaLwQq4eJ+UfGvupcroW4+Pna8mTqxKPfWxEKeKCu0IiUfkev1V2teEeUnFCIECrEOjwqLaT
        kKNsykqA==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCDL-008hYb-O1; Thu, 09 Mar 2023 09:05:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: simplify extent_buffer reading and writing
Date:   Thu,  9 Mar 2023 10:05:06 +0100
Message-Id: <20230309090526.332550-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Diffstat:
 compression.c |    4 
 compression.h |    2 
 disk-io.c     |  276 +++------------------------
 disk-io.h     |    5 
 extent_io.c   |  589 ++++++++++++++--------------------------------------------
 extent_io.h   |    3 
 6 files changed, 192 insertions(+), 687 deletions(-)
