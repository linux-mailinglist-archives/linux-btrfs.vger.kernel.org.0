Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D0952F080
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349811AbiETQYk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346569AbiETQYj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 12:24:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC817DDC3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 09:24:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5BA5968AFE; Fri, 20 May 2022 18:24:35 +0200 (CEST)
Date:   Fri, 20 May 2022 18:24:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/15] btrfs: introduce a pure data checksum checking
 helper
Message-ID: <20220520162435.GA25490@lst.de>
References: <20220517145039.3202184-1-hch@lst.de> <20220517145039.3202184-2-hch@lst.de> <ac460e01-b909-9957-55b8-a841cee37258@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac460e01-b909-9957-55b8-a841cee37258@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 20, 2022 at 11:45:26AM +0300, Nikolay Borisov wrote:
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>
> Though I find the naming of the function suboptimal because we now have a 
> bunch of *_check_* function and unless you go in and read the body of the 
> new helper you have no idea what 'check' entails and that it is about 
> verifying check sums.
>
>
> For data reads we have:
>
> btrfs_verify_data_csum -> check_data_csum -> btrfs_check_data_sector
>
> I.e the newly introduced function should have csum in its name i.e 
> btrfs_check_data_sector_csum.

If we rename things anyway, do we really need the data in here?
Why not simply btrfs_check_sector_csum?
