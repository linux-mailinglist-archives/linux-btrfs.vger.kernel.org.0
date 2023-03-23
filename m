Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127AD6C622E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 09:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCWIrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 04:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCWIra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 04:47:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F9198
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YVIIwD9Z65DbQaIvgORk/W2df2DWv4Ifq0XukOWDI1M=; b=RVPLK2HmER6ipFbPOUnFqfGynL
        SL0TxXYb8mxsES58aRD1ov160VNufQ1xkpphRzrksN6IA3APw/p8SDMkGTCwDkV/WP/QPxGC4qqom
        3EdrRPngvrHwg8IxqZ9m2qeSWd3m4LnDfiDrA0eruQoHFEHMml5TSp/JSZKQIckw+ws8X/nDIiiXH
        kAHrYLJcCGBXwUkxjjeh3p+uJO4cJ3WNPle1+rk/8OaWntAvti9UVTKYyukzuJSepN1SNmvVk0mFP
        uV1h/zk5HTVJAmTD3UEKOd+0flcAi3OVnxo9VTDyetGfSLkc6/Zc+FPjrRrNM4AbJIWs1HcFn0YhF
        MyOuk66A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfGbY-001Juw-0O;
        Thu, 23 Mar 2023 08:47:28 +0000
Date:   Thu, 23 Mar 2023 01:47:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 3/5] btrfs: return ordered_extent splits from bio
 extraction
Message-ID: <ZBwSIGXZipuob/61@infradead.org>
References: <cover.1679512207.git.boris@bur.io>
 <cf69fdbd608338aaa7916736ac50e2cfdc3d4338.1679512207.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf69fdbd608338aaa7916736ac50e2cfdc3d4338.1679512207.git.boris@bur.io>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a bit of a mess.  And the root cause of that is that
btrfs_extract_ordered_extent the way it is used right now does
the wrong thing in terms of splitting the ordered_extent.  What
we want is to allocate a new one for the beginning of the range,
and leave the rest alone.

I did run into this a while ago during my (nt yet submitted) work
to keep an ordered_extent pointer in the btrfs_bio, and I have some
patches to sort it out.

I've rebased your fix on top of those, can you check if this tree
makes sense to you;

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-dio-fix-hch

it passes basic testing so far.
