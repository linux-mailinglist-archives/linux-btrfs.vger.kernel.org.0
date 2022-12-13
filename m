Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6445D64B6E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 15:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiLMOJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 09:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiLMOJC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 09:09:02 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6AA20F54
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 06:08:51 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5F3F967373; Tue, 13 Dec 2022 15:08:49 +0100 (CET)
Date:   Tue, 13 Dec 2022 15:08:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs; rename the disk_bytenr in strut
 btrfs_ordered_extent
Message-ID: <20221213140849.GB24075@lst.de>
References: <20221212073724.12637-1-hch@lst.de> <20221212073724.12637-3-hch@lst.de> <Y5d5vuENR9vIltLs@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5d5vuENR9vIltLs@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 01:58:06PM -0500, Josef Bacik wrote:
>         /*                                                                                                                            
>          * These fields directly correspond to the same fields in                                                                     
>          * btrfs_file_extent_item.
>          */
> 
> which with this change is no longer true.  Please update the comment
> appropriately, other than that the change is reasonable to me, you can add

Ok.  Or should we skip this patch and stick to the on-disk naming
even if it is a bit confusing?
