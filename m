Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF73760006
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 21:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjGXTuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGXTuQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 15:50:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2FE1BEC
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 12:49:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C03B68AA6; Mon, 24 Jul 2023 21:49:23 +0200 (CEST)
Date:   Mon, 24 Jul 2023 21:49:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Burkov <boris@bur.io>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs NOCOW fix and cleanups
Message-ID: <20230724194923.GC30159@lst.de>
References: <20230724142243.5742-1-hch@lst.de> <20230724183033.GB587411@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724183033.GB587411@zen>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 11:30:33AM -0700, Boris Burkov wrote:
> On Mon, Jul 24, 2023 at 07:22:37AM -0700, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series fixes a (found by code inspection) bug in the error handling
> > in btrfs_run_delalloc_nocow, and then cleans up a bunch of things in
> > btrfs_run_delalloc_nocow to allow me to actually undestand the logic
> > there, and in case of the last patch signigicantly simplifies it.
> > 
> > The series is on top of the for-next branch as that includes previous
> > work not in misc-next yet that the series relies on.
> 
> This doesn't apply on the latest for-next, but I reviewed it from your
> git tree. It all LGTM there, thanks.

Yeah, looks like for-next got rebased again today.  I'll rebase and
push it out to the git tree later today and can resend as needed.
