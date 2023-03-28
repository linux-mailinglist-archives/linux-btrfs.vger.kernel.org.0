Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106416CB5DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 07:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjC1FUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 01:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjC1FUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 01:20:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722AC19A7
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 22:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4FqWmQELS2//v6i3WPZsoxnb6ZPdywKU1FkB8WF4LSI=; b=D4u0Cgjn//xVmBek4dh17QMCMT
        1SJxkTWGSchcoMLTFM8zauE4mMvxTtjPKZdOI/ocV66WV/do7DOww2uV3qcO2TQXgcQn6v0Lx5HW9
        9BS9fzzVVN+W6ght2MHagu5x27GR7OjJCbTUkcG0v4aPWZOgIroAWcRCw2R5IexIL9N8OCaR9jDCb
        gNBDqTIXSWa6vmLYAjkP5d5NL/gHURDWA3qkdSqrrcE5s1nWd/C4RdNSBNGQKSFtLxg6Gdi580kiJ
        lAh9cKqSnbxVsi+te5zEcgkPV4ujKMFTL+W1E/rY6/Fjkbw40corgaZT8Fj7boU41UMExdFSlFAfc
        n7QlBF8w==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1kW-00DATE-39;
        Tue, 28 Mar 2023 05:20:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: btrfs: fix corruption caused by partial dio writes v7
Date:   Tue, 28 Mar 2023 14:19:46 +0900
Message-Id: <20230328051957.1161316-1-hch@lst.de>
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

[this is a resend of the series from Boris, with my changes to avoid
 the three-way split in btrfs_extract_ordered_extent inserted in the
 middle]

The final patch in this series ensures that bios submitted by btrfs dio
match the corresponding ordered_extent and extent_map exactly. As a
result, there is no hole or deadlock as a result of partial writes, even
if the write buffer is a partly overlapping mapping of the range being
written to.

This required a bit of refactoring and setup. Specifically, the zoned
device code for "extracting" an ordered extent matching a bio could be
reused with some refactoring to return the new ordered extents after the
split.


Changes since v6:
 - use ERR_CAST
 - clarify a commit log

Changes since v5:
 - avoid three-way splits in btrfs_extract_ordered_extent
