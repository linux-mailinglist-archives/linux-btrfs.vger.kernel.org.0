Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ED151C385
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 17:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350336AbiEEPNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiEEPNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 11:13:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FEF38BDA
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 08:09:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C649568AA6; Thu,  5 May 2022 17:09:52 +0200 (CEST)
Date:   Thu, 5 May 2022 17:09:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/10] btrfs: remove btrfs_end_io_wq
Message-ID: <20220505150952.GD19810@lst.de>
References: <20220504122524.558088-1-hch@lst.de> <20220504122524.558088-9-hch@lst.de> <02e4d2a3-7e72-1b83-1005-fab13bf50931@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e4d2a3-7e72-1b83-1005-fab13bf50931@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 05, 2022 at 10:34:34AM +0800, Qu Wenruo wrote:
> I did a quick search on other fses, it looks like it's a common pratice
> to queue the work into the workqueue when the last one finished, other
> than making everything happen in workqueue.

Yes.  It is a lot more efficient as queing up lots of items tends to
cause quite some overhead, also due to the dynamic threadpool of the
workqueue.  XFS goes even futher and adds many bios to list at
completion time to be able to batch them up for the workqueue based
completions.
