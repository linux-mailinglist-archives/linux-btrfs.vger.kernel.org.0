Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEB719433
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 09:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjFAH2j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 03:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjFAH2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 03:28:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4FE44
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 00:28:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F8E267373; Thu,  1 Jun 2023 09:27:57 +0200 (CEST)
Date:   Thu, 1 Jun 2023 09:27:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Message-ID: <20230601072757.GA28794@lst.de>
References: <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com> <20230531133038.GA30855@lst.de> <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de> <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com> <20230601044034.GA21827@lst.de> <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com> <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6> <mmttvfirtcp32ruvodutdw2vnvxqdnad2gywwb6jxl7gtkzqta@xw75lfxofsso> <37a62c6c-ca9a-a6d2-37ba-249605427d08@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a62c6c-ca9a-a6d2-37ba-249605427d08@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 03:21:22PM +0800, Qu Wenruo wrote:
> Is there any function that I can go to grab the current writer pointer?

You can get the information using blkdev_report_zones, or the
"blkzoned report" command from user space.

