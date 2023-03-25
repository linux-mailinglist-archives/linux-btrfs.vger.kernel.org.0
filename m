Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF766C8C86
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjCYITG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCYIS6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:18:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77043A9D;
        Sat, 25 Mar 2023 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6JF1eHv4v1gYKZog61jT3o48bhVrAnIRgnrVggIjliA=; b=llReNySCTFySkcisYDnfcsfBg+
        3mHhQljZwy/G1V0iRwngtHC9B3SXevVBGPKT8v9WLFElmBg6Mx09A6H1rZ062YI64HyWOmHga2CN7
        NuSRG57eIAgSHL45prh2m1C30rAIg8nbeeAWP34iFht7C4HM7JSdVKpjBNlY9BW4picwu//62K06M
        oYwCZG1smF7AD5iSbU8VNWnqWzl+fJZGZ3DR8BQ6h/+aPgAr5RACNWKXcSkcABWMO156lY/pNX+W7
        IYT1W9tMzkIYC7RjtJqQUlz7qvHe+mVbebFlvUSKtffVu5glsnFd5Ww59f6YxpQSrop1P29Kf+0ts
        MU4yEkyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfz6y-006RGU-1s;
        Sat, 25 Mar 2023 08:18:52 +0000
Date:   Sat, 25 Mar 2023 01:18:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fstests: btrfs/012 don't follow symlinks for populating
 $SCRATCH_MNT
Message-ID: <ZB6ubFfBIvFLqs73@infradead.org>
References: <8d1ac146d94eec8c77f08a6d04cd8d5248dc8dc8.1679688780.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1ac146d94eec8c77f08a6d04cd8d5248dc8dc8.1679688780.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 04:13:19PM -0400, Josef Bacik wrote:
> /lib/modules/$(uname -r)/ can have symlinks to the source tree where the
> kernel was built from, which can have all sorts of stuff, which will
> make the runtime for this test exceedingly long.  We're just trying to
> copy some data into our tree to test with, we don't need the entire
> devel tree of whatever we're doing, so use -P to not follow symlinks
> when copying.

Btw, if you're touching this test can you make it _notrun if the
directory doesn't exist?  This test always fails for VMs without
any modules.
