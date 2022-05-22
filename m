Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EBA53032E
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 14:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbiEVMxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 08:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345405AbiEVMxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 08:53:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F40A245B2
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 05:53:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4297668AFE; Sun, 22 May 2022 14:53:38 +0200 (CEST)
Date:   Sun, 22 May 2022 14:53:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Message-ID: <20220522125337.GB24032@lst.de>
References: <20220522114754.173685-1-hch@lst.de> <20220522114754.173685-9-hch@lst.de> <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com> <20220522123108.GA23355@lst.de> <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 22, 2022 at 08:38:50PM +0800, Qu Wenruo wrote:
>> 'cause now a lot of the bio works will depend on the read repair, and
>> I don't want to block it on yet another series..
>
> Although I believe we will have to take more time on the read repair
> code/functionality.
>
> Especially all our submitted version have their own problems.
>
> From the basic handling of checker pattern corruption, to the trade-off
> between memory allocation and performance for read on corrupted data.

I've already pushed out a new version here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-read_repair

so feel free to take a look.  I just don't want to spam the list with it
quite yet with this series outstanding.
