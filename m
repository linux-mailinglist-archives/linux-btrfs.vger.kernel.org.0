Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCE6C75E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCXCc2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCXCc0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F469000
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 19:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=akex8ew+t/W4+P/6E32d/wCrbu6NEbpjrLkjFrXpxPU=; b=oov6PLWiCC8+hvugFYCZCHQvBR
        wUCDNVhGyNUgCX+02Aw5ZAcAes6A1HEpAKE1JUQ/fgJu2i5J+8xHLuBilXfXdtSRqd1+IikFeliEE
        BJsPeLCPVhzzdsQcknvqrd82abw8OBn9gB6YddkThU8/6I+OEFDsWlmbJ1f2g19DWc706Pkh8Gx0W
        Kv0sZeIwCDAzun2TENGMpqxE7ieEpj4uLhZ20YI4oR2/Uyrk84WqYyFlD26kDmPVO6+UeVrIe/AQH
        hkpQ6aFmS4QSpXgNm2qaRufBebjyX32eUtKpaOKw6jv2ddxKCwIicEbEUsAAcfEnBlmoxshSMoklU
        przS8oXA==;
Received: from [122.147.159.118] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfXDx-003PFq-2l;
        Fri, 24 Mar 2023 02:32:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: btrfs: fix corruption caused by partial dio writes v6
Date:   Fri, 24 Mar 2023 10:31:56 +0800
Message-Id: <20230324023207.544800-1-hch@lst.de>
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

Changes since v5:
 - avoid three-way splits in btrfs_extract_ordered_extent
