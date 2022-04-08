Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E4F4F8DA6
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiDHFKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiDHFKv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:10:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3191ED918
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V+DLB8GPsE8M5d/5BWt4l4kXDa0FeCtR5sl1vkozIjw=; b=R5qRf5Bf2ZhmiZ5KQWODPPVaRc
        EWgD8tKYiz3HaBFY7teLx3FhZZ1td5xj9oa0Kvco/gisCkJ/wH5+V3FNpDZoB6dmMXqPJXLXXDNIM
        nnAhfMBNP2ygp7uI9sSDR2+f0TuKVPNIdSoLebX2I/J1pRC61Xzl2n9Nh4J8KPjaVFmxgeqcxqstF
        gRRWDl24yKB8tKViyfADTSW+iJoab2TQL2pO31MyHQmGjxtD4uwlTv2zmI1OwTES4jNskQbObNHvq
        8wF7M/kqjJkwa2/kvbabE+5juGOrqGE3f7TT4SwV5nLTFVysxZZ0I/BjHEhqgPEPyNqL2U3YRZkGT
        COjMxIgw==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgrS-00F12y-F6; Fri, 08 Apr 2022 05:08:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: cleanup btrfs bio handling, part 1 v2
Date:   Fri,  8 Apr 2022 07:08:27 +0200
Message-Id: <20220408050839.239113-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series  moves btrfs to use the new as of 5.18 bio interface and
cleans up a few close by areas.  Larger cleanups focussed around
the btrfs_bio will follow as a next step.

Changes since v1:
 - rebased to btrfs/misc-next
 - improve a commit log

Diffstat:
 check-integrity.c |  165 +++++++++++++++++++++++++-----------------------------
 check-integrity.h |    8 +-
 disk-io.c         |    6 +
 extent_io.c       |   55 ++++++++----------
 extent_io.h       |    2 
 raid56.c          |   46 ++++++---------
 scrub.c           |   92 ++++++++++++------------------
 volumes.c         |   12 ++-
 8 files changed, 179 insertions(+), 207 deletions(-)
