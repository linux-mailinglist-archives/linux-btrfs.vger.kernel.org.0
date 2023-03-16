Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC96BD310
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 16:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCPPN6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 11:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCPPNz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 11:13:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9BC2D8C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 08:13:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 939EF68AA6; Thu, 16 Mar 2023 16:13:44 +0100 (CET)
Date:   Thu, 16 Mar 2023 16:13:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: btrfs_add_compressed_bio_pages
Message-ID: <20230316151344.GA12835@lst.de>
References: <20230314165110.372858-1-hch@lst.de> <20230314165110.372858-3-hch@lst.de> <4e5ce579-7c66-ffb7-e2c3-8b3727695f86@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5ce579-7c66-ffb7-e2c3-8b3727695f86@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 16, 2023 at 04:57:39PM +0800, Anand Jain wrote:
> And, in our case, we do not require the functionality of 
> __bio_try_merge_page()?

Yes.  These are separately allocated pages, and we have enough
space for them.  In the unlikely case that they are contiguous,
they will still be coalesced when merging into the scatterlist.
