Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7053B8C4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 14:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiFBMH6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 08:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiFBMHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 08:07:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196DA20043F;
        Thu,  2 Jun 2022 05:07:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D0D768AFE; Thu,  2 Jun 2022 14:07:44 +0200 (CEST)
Date:   Thu, 2 Jun 2022 14:07:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/9] btrfs: test repair with sectors corrupted in
 multiple mirrors
Message-ID: <20220602120743.GA27700@lst.de>
References: <20220524071838.715013-1-hch@lst.de> <20220524071838.715013-9-hch@lst.de> <20220602113056.GA3347231@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602113056.GA3347231@falcondesktop>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 02, 2022 at 12:30:56PM +0100, Filipe Manana wrote:
> On Tue, May 24, 2022 at 09:18:37AM +0200, Christoph Hellwig wrote:
> > Test that repair handles the case where it needs to read from more than
> > a single mirror on the raid1c3 profile.
> 
> The test currently fails (at least on current misc-next branch), as the
> repair does not happen, see below. Is it a bug in the repair code for
> raid1c3 (I haven't checked)?

Yes, it only repairs the previously bad copy and doesn't propagate
the repair.

> Also why only raid1c3 coverage and not raid1c4 as well?

Because I've really wanted any coverage at all for mutiple mirror
repair operations.  raid1c4 is probably useful to test, but won't
increase the coverage of the read repair code much.
