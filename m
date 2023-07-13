Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB229751FCD
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 13:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjGMLVq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 07:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjGMLVo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 07:21:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D412D61
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1k5wya+F3VE/UaYBscos0/fCU8kjsMbNGaqIgYHqpn0=; b=IZshu3u7E3y8MqJHiONX45TEYb
        WqyczAblJjckA9Lq4NMEAfXxlEmsxaKmma0xBr545zD6xs3it4+KgKxXBVf9Ta9VRh0E/LNtkAumG
        MHFeKjXwRvzUjN3X+SbAofP0pHrAnKzsBUCupjPO4rbp7sN2IJ2TGlZ2TItr7twDcwhfpK8HPUrR2
        699HREcWVpd+0veDh3Cux1LF3i5LOYijRzKTMCUXpXX8V0VUHPk/89CuxLnXwZvwROar9vOwa3VK0
        UKm2CuW0yIk9G4D5ABuAX3jtDOHSigK087D1WPPhVZUMQO02xELWHLjJP0V3YRMJfPLxh+qLPjotj
        ks50/09w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJuNi-0034GJ-34;
        Thu, 13 Jul 2023 11:21:10 +0000
Date:   Thu, 13 Jul 2023 04:21:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org
Subject: Re: [PATCH] btrfs: disable slab merging in debug build
Message-ID: <ZK/eJlk0jb1F4E2V@infradead.org>
References: <20230712191712.18860-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712191712.18860-1-dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 12, 2023 at 09:17:12PM +0200, David Sterba wrote:
> The slab allocator newly allows to disable merging per-slab (since
> commit d0bf7d5759c1 ("mm/slab: introduce kmem_cache flag
> SLAB_NO_MERGE")). Set this for all caches in debug build so we can
> verify there are no leaks when module gets reloaded.

So we're having a discussion on linux-mm wether to just disbale slab
merging by default, because it really is a pain.  Maybe wait for that
to settle before adding per-subsystem hacks for what really is a slab
problem?

