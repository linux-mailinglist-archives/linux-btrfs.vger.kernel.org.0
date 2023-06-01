Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8737192B9
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 07:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjFAFvA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 01:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjFAFuh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 01:50:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582ECE70
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 22:48:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DD4967373; Thu,  1 Jun 2023 07:47:33 +0200 (CEST)
Date:   Thu, 1 Jun 2023 07:47:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Message-ID: <20230601054732.GA23496@lst.de>
References: <20230531132032.GA30016@lst.de> <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com> <20230531133038.GA30855@lst.de> <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de> <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com> <20230601044034.GA21827@lst.de> <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com> <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6> <7939e360-27fb-119f-8339-36a86c2b3f94@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7939e360-27fb-119f-8339-36a86c2b3f94@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 01:45:49PM +0800, Qu Wenruo wrote:
> Oh, that looks like the cause.
>
> In btrfs_submit_repair_write() we set the bi_opf to ZONE_APPEND instead,
> which later would trigger btrfs_record_physical_zoned().
>
> So this means, we should not change the WRITE into ZONE_APPEND for
> btrfs_submit_repair_write() for dev-replace case at all.
>
> I stupidly thought zoned device can not accept WRITE command at all but
> only ZONE_APPEND.
>
> Let me try it locally first.

I'm already testing with the patch.  It stop us from seeing the
call into btrfs_record_physical_zoned, but device replace on zoned
devices still doesn't work.

