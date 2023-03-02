Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124D36A83EF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 15:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCBODL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 09:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCBODJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 09:03:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D8A1420F
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 06:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pUNnfLxusFZn4Q8JyBqAa2cH1Fz9OVudplm9AoohRDI=; b=qXgA4/snBz7NrJAAOiUHOwF0jm
        dUlUxdORIx842bJHkkJ8mvzvpad5vl/fIDCrg+lMwuw9ktY2ZvL8ag6V+Q0Id+FGiPLzjavVQ74Jp
        hYLsN0wF1cz+6881ZQO4EoviZURoybXWfV5in7JGLUZHfjG64Gp9ElfrW0sZdwLymTTr14v2XSR95
        R/9CHesu3mvfdlQGbfxTGriDbg6mbY9Y6dlNKN9ZNbyU21yv4JnKAo/CE6Yeb8jAMSQBJPPpLMA3D
        NfsapuCjgrNL7YEtteTU4oDnOkrvp6AakBW+qjk3dK1J4605MOPDuqXg0Qh9DKvSvWb1L0YgN/qUX
        M+DeiW1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXjWT-002P66-OD; Thu, 02 Mar 2023 14:03:05 +0000
Date:   Thu, 2 Mar 2023 06:03:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <ZACsmbLdmTSdzA3e@infradead.org>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <2648e7a4-271d-b49e-5ea6-6d3826f42f59@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2648e7a4-271d-b49e-5ea6-6d3826f42f59@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 11:45:44AM +0000, Johannes Thumshirn wrote:
> +	wait_event(fs_info->ordered_stripe_wait,
> +		   !btrfs_ordered_stripes_pending(fs_info));

Ugg.  Waiting for processing from one workqueue from another one
is really a big fat warning sign you are in workqueue hell.  Let's
take a step back and solve this properly.
