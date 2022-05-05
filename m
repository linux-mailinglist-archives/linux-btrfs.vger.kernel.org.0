Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364D851C38A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349075AbiEEPPM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 11:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiEEPPL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 11:15:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FCBC0F
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 08:11:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0CEF268AA6; Thu,  5 May 2022 17:11:29 +0200 (CEST)
Date:   Thu, 5 May 2022 17:11:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: cleanup btrfs bio handling, part 2 v3
Message-ID: <20220505151128.GE19810@lst.de>
References: <20220504122524.558088-1-hch@lst.de> <a6952ff4-1e4e-5650-7d57-8fd442e9d5aa@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6952ff4-1e4e-5650-7d57-8fd442e9d5aa@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 05, 2022 at 02:56:49PM +0800, Qu Wenruo wrote:
> So do you mind to do some basic benchmark for read and write and see how
> the throughput and latency changed?

I'm not actually seeing any meaningful differences at all.  I think this
will help btrfs to better behave under memory pressure, though.
