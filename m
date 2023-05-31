Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7237184EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 16:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjEaO1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjEaO1N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 10:27:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5E197
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 07:27:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C63DA68B05; Wed, 31 May 2023 16:17:39 +0200 (CEST)
Date:   Wed, 31 May 2023 16:17:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Message-ID: <20230531141739.GA2160@lst.de>
References: <20230531125224.GB27468@lst.de> <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com> <20230531132032.GA30016@lst.de> <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com> <20230531133038.GA30855@lst.de> <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 02:04:05PM +0000, Johannes Thumshirn wrote:
> 
> Heh and this has never actually worked IMHO.
> 
> I did a crude hack to bandaid scrub:

I think the better approach is to:

 a) branch out at a very high level to the zoned code in
    flush_scrub_stripes, or in fact even higher given that we
    don't really care about tracking stripes.  The write
    side of scrub has to work at a zone, not stripe level for
    zoned devices
 b) don't create a new relocation thread per zone, but run it from
    the scrub context.

