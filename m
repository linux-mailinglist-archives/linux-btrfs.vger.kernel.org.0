Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F307259194F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 09:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiHMHqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMHqP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 03:46:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0BFBCB4
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 00:46:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7CD9168AA6; Sat, 13 Aug 2022 09:46:11 +0200 (CEST)
Date:   Sat, 13 Aug 2022 09:46:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: [PATCH] btrfs: don't merge pages into bio if their page offset
 is not continuous
Message-ID: <20220813074611.GA11755@lst.de>
References: <8641e5e791942d86de0a1b3ee120570441616fdc.1660375698.git.wqu@suse.com> <20220813073909.GA11586@lst.de> <1f71de8a-2292-054e-913b-15e41b409de6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f71de8a-2292-054e-913b-15e41b409de6@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 13, 2022 at 03:43:49PM +0800, Qu Wenruo wrote:
> BTW, I'll also update the commit message to mention some future
> cleanups, as now a btrfs_bio is completely a continous range, thus
> things like endio_readpage_release_extent() related infrastructure can
> also be removed.

Yes, there is a lot of things that can be cleaned up with this. For
that reason along I was planning to look into a change like this
eventually, but I should have done it earlier..
