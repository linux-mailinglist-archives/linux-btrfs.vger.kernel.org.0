Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF1728465
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjFHP7J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbjFHP6i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 11:58:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97928E59
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 08:58:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D635D6732D; Thu,  8 Jun 2023 17:58:33 +0200 (CEST)
Date:   Thu, 8 Jun 2023 17:58:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: set FMODE_CAN_ODIRECT instead of a dummy
 direct_IO method
Message-ID: <20230608155833.GA1060@lst.de>
References: <20230608091133.104734-1-hch@lst.de> <20230608155141.GL28933@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608155141.GL28933@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 08, 2023 at 05:51:41PM +0200, David Sterba wrote:
> On Thu, Jun 08, 2023 at 11:11:33AM +0200, Christoph Hellwig wrote:
> > Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
> > systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
> > wiring up a dummy direct_IO method to indicate support for direct I/O.
> > Do that for btrfs so that noop_direct_IO can eventually be removed.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Added to misc-next, thanks. Seems that a few more filesystem can use the
> same conversion.

Yes.  I have a few more patches, but not all are as trivial.
