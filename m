Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236E2719202
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 06:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjFAExH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 00:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjFAExG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 00:53:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC9129
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 21:53:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A7A867373; Thu,  1 Jun 2023 06:53:02 +0200 (CEST)
Date:   Thu, 1 Jun 2023 06:53:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Message-ID: <20230601045302.GA22596@lst.de>
References: <20230531125224.GB27468@lst.de> <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com> <20230531132032.GA30016@lst.de> <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com> <20230531133038.GA30855@lst.de> <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <ea984319-decb-ce86-aed4-d4520bf3ad3d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea984319-decb-ce86-aed4-d4520bf3ad3d@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 06:25:59AM +0800, Qu Wenruo wrote:
> To me, the problem can be solved in a much simpler way, if it's
> dev-replace for zoned device, let's write the whole stripe to the target
> device, and wait for it.
>
> For the btrfs_record_physical_zoned(), we can skip the OE things if
> bbio::inode is NULL.
>
> Would the following change solves the problem?

It can't, as we need to record the actually written location.
