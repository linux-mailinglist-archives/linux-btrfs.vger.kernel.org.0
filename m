Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB96D1200
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 00:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjC3WN4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 18:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjC3WNz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 18:13:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E329754
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A0Ot3iTEFGm9MgaiRDsgW46IbSWpO7fgaxMEyX3zq2o=; b=nTFsUAZsuCN4vVg08slf7n3lcW
        9qLA8UEAN5LOz5y+jiPkrX6ZmOSeKJkdebZfLQihse82eLbEl6FXuN8OSJgyhPVHBSMcEp7XxLOsg
        yu2ObLre5yaMo6sOL1SJKoZCExt/TqSnQ+5FoSpCYfv4wBm3TkFz4c8isX5PntpvBXZz+hF+jBPRV
        EnZbTJI4EeS1iLtyZparujqUs2FgY+zl0AVwCkQz03GdZpWx3xRkg2cK+Q6r/XhdWvAzdxmF2mqze
        Ojgdgy4NkT0/npEE4PY7/DaBgrmTrX3FBD4xZBMC2sLEeMAL8Ubk+Yv1O7y/GOLbpdbsas61i5zNK
        5UbeHTcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pi0Wl-005C9e-0I;
        Thu, 30 Mar 2023 22:13:51 +0000
Date:   Thu, 30 Mar 2023 15:13:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v7 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
Message-ID: <ZCYJn6ygcvtX+ZEh@infradead.org>
References: <cover.1680047473.git.wqu@suse.com>
 <72f4fa26c35f2e649bc562a80a40955d745f1118.1680047473.git.wqu@suse.com>
 <ZCTK34vrpfGiCu1B@infradead.org>
 <b38a9aa2-9869-2f95-59a0-d2fe20f4e1d6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38a9aa2-9869-2f95-59a0-d2fe20f4e1d6@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 30, 2023 at 02:47:08PM +0800, Qu Wenruo wrote:
> Due to the interface differences (read-repair goes plain bio and
> submit_bio_wait(), while scrub goes btrfs_bio), I can't find a perfect
> single interface for both usage.

> Thus I go a common helper, map_repair_smap(), to grab the device with its
> physical, and use it to implement the old btrfs_repair_io_failure() and the
> new btrfs_submit_repair_write() interface.

I think this map helper approach looks very nice.

A bunch of comments, though:

 - map_repair_smap doesn't deal with bios at all, so I think it should
   go into volumes.c instead and be renamed to something like
   btrfs_map_repair_block
 - it really needs a better comment describing what is can be used
   for for and what the assumptions are
 - The smap.dev ASSERT in both callers of map_repair_smap is odd,
   I'd expect a valid dev to just be part of the contract fo that
   helper.
 - shouldn't the ASSERT check that map_length is >= length, as a shorter
   map is the real problem here?  A larger one doesn't seem problematic.
   Instead of just an assert I'd probably do an actual error check with
   a WARN_ON_ONCE.
 - I'd factor the raid56 branch into a separate helper
 - the non-raid56 case should probably call set_io_stripe, to make
   Johannes' life with the raid stripe tree easier

 - all new code in bio.c should stay below btrfs_submit_bio to keep
   the main I/O path together
 - typo: "No csum geneartion" should be: "No csum generation"
 - why can btrfs_submit_repair_write skip the
   BTRFS_DEV_STATE_WRITEABLE check from btrfs_repair_io_failure?
   Shouldn't that and the ->bdev check be lifted into map_repair_smap?

> 
> The whole series has been tested without problem for non-zoned device.
> 
> Thanks,
> Qu
---end quoted text---
