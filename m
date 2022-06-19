Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021165508F6
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 08:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiFSGfv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 02:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFSGfu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 02:35:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E128389A
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 23:35:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A48A168AA6; Sun, 19 Jun 2022 08:35:45 +0200 (CEST)
Date:   Sun, 19 Jun 2022 08:35:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/10] btrfs: remove the raid56_parity_recover return
 value
Message-ID: <20220619063545.GA27154@lst.de>
References: <20220617100414.1159680-1-hch@lst.de> <20220617100414.1159680-6-hch@lst.de> <PH0PR04MB74162BBB070D56528215E6569BAE9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74162BBB070D56528215E6569BAE9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 18, 2022 at 11:06:06AM +0000, Johannes Thumshirn wrote:
> On 17.06.22 12:04, Christoph Hellwig wrote:
> > -	ret = lock_stripe_add(rbio);
> > +	if (lock_stripe_add(rbio))
> > +		return;
> >  
> 
> I kinda have the feeling lock_stripe_add() should return bool,
> but that's out of scope for this patch.

Yes, it should.  But it does not fit this patch, and even the series
seems big enough already as-is..
