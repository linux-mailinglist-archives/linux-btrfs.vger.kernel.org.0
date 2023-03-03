Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B396A995B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 15:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCCOYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 09:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCCOYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 09:24:35 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6245A6FF
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 06:24:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88E4468BEB; Fri,  3 Mar 2023 15:24:30 +0100 (CET)
Date:   Fri, 3 Mar 2023 15:24:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/10] btrfs: cleanup
 btrfs_encoded_read_regular_fill_pages
Message-ID: <20230303142430.GA32738@lst.de>
References: <20230301134244.1378533-1-hch@lst.de> <20230301134244.1378533-3-hch@lst.de> <afde017a-6767-1a75-ca5a-5e0ebc083d30@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afde017a-6767-1a75-ca5a-5e0ebc083d30@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 03, 2023 at 07:24:29AM +0800, Qu Wenruo wrote:
> Can't we even merge the bio allocation into the main loop?
>
> Maybe something like this instead?

That should work.  I personally prefer the version that I sent out,
though.
