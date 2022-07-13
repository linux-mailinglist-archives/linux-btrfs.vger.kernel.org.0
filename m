Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1E573531
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 13:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiGMLSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 07:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiGMLSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 07:18:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A02EDB51
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 04:18:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD9F967373; Wed, 13 Jul 2022 13:18:01 +0200 (CEST)
Date:   Wed, 13 Jul 2022 13:18:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/11] btrfs: make the btrfs_io_context allocation in
 __btrfs_map_block optional
Message-ID: <20220713111801.GA32416@lst.de>
References: <20220713061359.1980118-1-hch@lst.de> <20220713061359.1980118-11-hch@lst.de> <PH0PR04MB741647058825EF24A1E89CAA9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741647058825EF24A1E89CAA9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 13, 2022 at 09:58:15AM +0000, Johannes Thumshirn wrote:
> Could be my changes on top, but in order to get RAID0 with a raid-stripe-tree
> working I needed the following change:

For the existing raid0 code we can one call to __btfs_map_block, so this
is not needed.  I think it should go into your series and be restricted
to declustered raid0 only.
