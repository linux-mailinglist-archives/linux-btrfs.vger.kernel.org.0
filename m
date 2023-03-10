Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FAE6B37FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCJIDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCJIDk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:03:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0FA2B9EA
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:03:35 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB7A76732D; Fri, 10 Mar 2023 09:03:31 +0100 (CET)
Date:   Fri, 10 Mar 2023 09:03:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
Message-ID: <20230310080331.GA15272@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-6-hch@lst.de> <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com> <20230310074723.GA14897@lst.de> <17c86afa-41af-a8d4-094e-81f1d47e8788@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c86afa-41af-a8d4-094e-81f1d47e8788@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 04:02:02PM +0800, Qu Wenruo wrote:
> Like this inside a RAID0 bg:
>
> 0	32K	64K	96K	128K
> |             |//|//|           |
>
> There is an old chunk allocator behavior that we can have a chunk starts at 
> some physical bytenr which is only 4K aligned, but not yet STRIPE_LEN 
> aligned.
>
> In that case, extent allocator can give us some range which crosses stripe 
> boundary.

Ewww, ok.  So the metadata isn't required to be naturally aligned.
