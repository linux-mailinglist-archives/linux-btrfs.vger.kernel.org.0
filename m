Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894DB56756C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiGERTE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiGERTD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 13:19:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA52658
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 10:19:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B4BA67373; Tue,  5 Jul 2022 19:18:59 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:18:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 3/4] btrfs: remove the start argument to check_data_csum
Message-ID: <20220705171858.GC15148@lst.de>
References: <20220630160130.2550001-1-hch@lst.de> <20220630160130.2550001-4-hch@lst.de> <1376ac49-d51a-8004-d05a-eddfb6dd0d93@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376ac49-d51a-8004-d05a-eddfb6dd0d93@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 05, 2022 at 06:35:59PM +0300, Nikolay Borisov wrote:
>> +int check_data_csum(struct inode *inode, struct btrfs_bio *bbio, u32 bio_offset,
>> +		    struct page *page, u32 pgoff)
>
> nit: The removal of the static could be tucked into the next patch as 
> that's where it's being used for the first time.

I can do that if is generally preferred, but this version causes less
churn, especially with the annoying btrfs style of the variable prototype
continuation indentation.
