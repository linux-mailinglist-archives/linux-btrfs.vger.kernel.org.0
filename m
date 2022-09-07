Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5135B0003
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 11:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIGJLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 05:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiIGJLF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 05:11:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3CA8319
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 02:11:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C896968AFE; Wed,  7 Sep 2022 11:10:57 +0200 (CEST)
Date:   Wed, 7 Sep 2022 11:10:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: code placement for bio / storage layer code
Message-ID: <20220907091056.GA32007@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

On Thu, Sep 01, 2022 at 10:41:59AM +0300, Christoph Hellwig wrote:
> Note: this adds a fair amount of code to volumes.c, which already is
> quite large.  It might make sense to add a prep patch to move
> btrfs_submit_bio into a new bio.c file, but I only want to do that
> if we have agreement on the move as the conflicts will be painful
> when rebasing.

any comments on this question?  Should I just keep adding this code
to volumes.c?  Or create a new bio.c?  If so I could send out a
small prep series to do the move of the existing code ASAP.
