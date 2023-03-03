Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA36A9946
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 15:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCCORx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 09:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCCORu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 09:17:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245A5D447
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 06:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bnOlzx3on2L0l7VXSRvHxuGLzFz4AD99K/HPQKfTuaA=; b=qGIkNBogQCSfhc1vxZ8cK9Upar
        orpKEsm1poO4/l74YNXTT7AkHkj1cIka/1xGaUghwziaobnZe1mu9qL/jVkT1s8Qjc4fSrdGaolQS
        NFT9+yaL2QHuWGIsSl9WWtX2LKSNR0oeQtSrYW19XRTwLg2EL/ZBazayIDdGCFsamHLgtTuaCscOU
        RRxRJj+8VbKsxZ0R4sXAtwKD+Drl9nebPkTou9P0yk565lR+nU5eB+9Ar1U20lFcvRXyH96dsi59V
        G2k69V729mR3WCDOjSqfKez3CYJBGiDu/wxoE2S9boBvR6/hk3KbbdTvtbMkZMFlEmoUGpy+q940L
        lcuQXvWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pY6E9-006aRn-Dj; Fri, 03 Mar 2023 14:17:41 +0000
Date:   Fri, 3 Mar 2023 06:17:41 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "hch@infradead.org" <hch@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <ZAIBhVhIQ+0xcM28@infradead.org>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
 <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
 <b538f61d-fda6-2ed0-9a17-216506ab2692@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b538f61d-fda6-2ed0-9a17-216506ab2692@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 03, 2023 at 11:15:00AM +0000, Johannes Thumshirn wrote:
> There's two possibilities how to handle it:
> 1) Have a common workfn that handles all the calls in the correct order
> 2) Do the RST update in btrfs_finish_ordered_io()
> 
> To me both are valuable options, so I don't care. Both need a bit of
> preparation work before, but that's the nature of the beast.
> 
> For 2) we need a pointer to the bioc in ordered_extent, so we need to
> make sure the lifetimes are in sync. Or the other way around, have
> ordered_stripe hold enough information for the RST updates and the
> end_io handler insert it in the ordered_stripe (that needs to be
> passed into the bioc or bbio).
> 
> *Iff* I interpret Christoph's proposal in [1] correctly, options 1) is
> easier to implement.

1 is probably easier, and should be done for other reasons.  But 2
really feels like the right thing to do in addition to 1.
