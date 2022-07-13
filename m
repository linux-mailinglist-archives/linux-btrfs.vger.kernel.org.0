Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991CA572E6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiGMGuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiGMGub (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:50:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3601CBD6A2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:50:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 98C5268AA6; Wed, 13 Jul 2022 08:50:27 +0200 (CEST)
Date:   Wed, 13 Jul 2022 08:50:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/11] btrfs: split submit_stripe_bio
Message-ID: <20220713065027.GA14237@lst.de>
References: <20220713061359.1980118-1-hch@lst.de> <20220713061359.1980118-9-hch@lst.de> <PH0PR04MB741681A236D9F0C0F834BAFC9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741681A236D9F0C0F834BAFC9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 13, 2022 at 06:46:41AM +0000, Johannes Thumshirn wrote:
> On 13.07.22 08:14, Christoph Hellwig wrote:
> > +static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)>  {
> 
> Nit:	struct btrfs_fs_info *fs_info = dev->fs_info;
> 
> so we don't need dev->fs_info for the round_down() and 
> btrfs_debug_in_rcu() calls.

We can't assign it here because it is before the NULL check for dev,
and assigning it later just to save a second dereference does not
seem all that useful.
