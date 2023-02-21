Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82D69E242
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 15:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjBUO0Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 09:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjBUO0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 09:26:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D3110269
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rk6CGKB0/vrgJKrPnGy27jkIyPkoUB0ICwzDgQ4KpuI=; b=X8jsFqJkJJT5JS7yWpB+1mbeUM
        +pn8nZJOgj7EDEXcnN0KQdLR7C1YQQTJ4SVhLEl+EM/ynryNLcT0z9SAQtBV78wy7vURYoMn9sTDU
        /4fFmL3eHIlQVAnUJlEfCf7q0OzrCV8IXC6TgcfGSr7/TOAS8xPCcwZWEYi4H89xyPkqwGzYdnXL4
        uFsyHFKbsyp8v0z0mEVJDQxPhnW71vkSWfHmmHbTaXw3mbXykTQGApi9aP/DR4Hyz+bXoYJb6kyOw
        EfdPfQ1jiS1unQGVpgY3XXZVAgN3U60zTw96HCr1R63DhBo/bn5EOB4KNwGBxp1/qfEV1RpfjSTLK
        kHxMpP+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUTb5-008UPu-1d; Tue, 21 Feb 2023 14:26:23 +0000
Date:   Tue, 21 Feb 2023 06:26:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reflow calc_bio_boundaries
Message-ID: <Y/TUjwJCkzcoAEac@infradead.org>
References: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 05:25:36AM -0800, Johannes Thumshirn wrote:
> calc_bio_boundaries() is only used for guaranteeing the one bio equals to one
> ordered extent rule for uncompressed Zone Append bios.
> 
> Re-flow the function to exit early in case we're not operating on an
> uncompressed Zone Append and then calculate the boundary.
> 
> This imposes no functional changes but improves readability.

This looks correct but doesn't really read much better to me.

My mid-term plan here is to instead keep a refrence to the ordered
extent in the bio_ctrl and get rid of the len_to_oe_boundary value,
in which case this is just a bit more churn.  But I'm not sure I'm
going to get to that yet for the 6.4 merge window.
