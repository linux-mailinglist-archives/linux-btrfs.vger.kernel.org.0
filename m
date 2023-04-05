Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D946D73F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 07:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjDEFtt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 01:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjDEFtn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 01:49:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047974C23;
        Tue,  4 Apr 2023 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2cph45vi9UXMWYj+/V5DmnXu58ktqclhI29RNkQDrVw=; b=24ytSQXz7tvVrd0iuYnV4gKyLr
        4MfP2OXqfiVyeHzlmxi0633eHCTjFhmPP0o3j2XYmRpIAAaXqhI1n0JMsdX6jSWE7BlownX4YiA1B
        MEe9mwvq0UQrr12wDvPsAEw/hZAOMtBvsaYSYYTgU/C6pC7lCBO5F/eUP76BduwTgETZDyI0OqpXe
        X7r4nR878mvIQo+vgAHOug5PgaHjCnQEyB78GB/qgijMX+vzraF9EOW7PAtG4bS03sOX2zOwT4qXP
        tudzRI18aW4uYOyzdB8xmmrer+eHXxdtBZ/3XPzTY0hMrFJpnwVsGLdFKU9w/hUqubtH0yNIFX17S
        5iW4d7UA==;
Received: from [2001:4bb8:191:a744:c06e:b99:9fd8:3e0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjw16-003QkG-2Q;
        Wed, 05 Apr 2023 05:49:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: remove crc32c_impl
Date:   Wed,  5 Apr 2023 07:49:03 +0200
Message-Id: <20230405054905.94678-1-hch@lst.de>
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

this series stops printing the crc32c implementation at btrfs load
time as it's already printed at mount time, and then removes the
now unused crc32c_impl function.

This series is on top of the btrfs for-next tree, which has a bunch
of required crc32c-related work.

Diffstat:
 fs/btrfs/super.c       |    2 +-
 include/linux/crc32c.h |    1 -
 lib/libcrc32c.c        |    6 ------
 3 files changed, 1 insertion(+), 8 deletions(-)
