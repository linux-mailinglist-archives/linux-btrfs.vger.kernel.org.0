Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D940371921B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 07:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjFAFW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 01:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjFAFW1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 01:22:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23712C
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 22:22:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 69B3F67373; Thu,  1 Jun 2023 07:22:23 +0200 (CEST)
Date:   Thu, 1 Jun 2023 07:22:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Message-ID: <20230601052223.GA23080@lst.de>
References: <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com> <20230531132032.GA30016@lst.de> <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com> <20230531133038.GA30855@lst.de> <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de> <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com> <20230601044034.GA21827@lst.de> <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com> <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 05:17:23AM +0000, Naohiro Aota wrote:
> > Thus we don't need to do any adjustment (unless you're talking about
> > RST, but I believe that's a different beast).
> 
> True. For the dev_replace, we need to place the moved data at the same
> address on the destination device as the source device. Thus, we need to
> use WRITE command to ensure that.
> 
> So, calling into the record_physical function looks strange to me. It
> misses some condition to use ZONE_APPEND?

ch@brick:~/work/linux$ git-grep -C1 btrfs_record_physical_zoned fs/btrfs/bio.c
fs/btrfs/bio.c-         if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
fs/btrfs/bio.c:                 btrfs_record_physical_zoned(bbio);
fs/btrfs/bio.c-

nope.  We are doing a zone append write here.

That being said in latest misc-next btrfs_record_physical_zoned stops
lookin at bbio->inode, so the crash part is gone.
