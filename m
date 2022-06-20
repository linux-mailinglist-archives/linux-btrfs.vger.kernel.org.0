Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89844550E84
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 04:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiFTCMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 22:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiFTCMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 22:12:18 -0400
Received: from out20-50.mail.aliyun.com (out20-50.mail.aliyun.com [115.124.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1BFBC0D
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 19:12:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06250902|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.215413-0.00174655-0.78284;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.O8V6mgb_1655691127;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O8V6mgb_1655691127)
          by smtp.aliyun-inc.com;
          Mon, 20 Jun 2022 10:12:07 +0800
Date:   Mon, 20 Jun 2022 10:12:09 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Problems with BTRFS formatted disk
Cc:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <1f033574-9c56-8454-a4a2-7db57ffd0e01@gmx.com>
References: <20220620090137.1661.409509F4@e16-tech.com> <1f033574-9c56-8454-a4a2-7db57ffd0e01@gmx.com>
Message-Id: <20220620101209.B0E9.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2022/6/20 09:01, Wang Yugui wrote:
> > Hi,
> >
> >> On 2022/6/20 04:06, David C. Partridge wrote:
> >>> Yes write caching was enabled - I suspect that the way it worked was that on power fail the super-caps held the data until power was restored.
> >>>
> >>> Sadly it wasn't restored for a few weeks by which time the super-caps had lost their charge.
> >>
> >> A little off-topic here, since I'm not familiar with how those hardware
> >> RAID controllers work.
> >>
> >> Yep, those cards should have (super) caps to handle power loss, but for
> >>    SCSI SYNC CACHE commands, they should "the device server ensure that
> >> the specified logical blocks have their most recent data values recorded
> >> in non-volatile cache and/or on the medium."
> >>
> >> Considering in a power loss event, the juice in those caps is definitely
> >> not enough to power those HDDs, it should at least have some
> >> non-volatile cache, like NAND, as backups.
> >>
> >> But from sites I can found, it only states the card has 1024MiB cache
> >> memory.
> >>
> >> Even with caps to keep the memory alive, it's still far from
> >> "non-volatile cache" required by SCSI spec.
> >>
> >> Or is this a common practice in hardware RAID controller world to use
> >> volatile cache and break the SCSI spec requirement?
> >
> >
> > "non-volatile cache"  require a battery(inside or separated) and
> > Backup Flash(inside or separated).
> 
> Then it comes the question, why there is need for battery if our
> non-volatile cache is NAND flash?
> Since NAND doesn't need power to keep its data.
> 
> My guess is, NAND flash is not fast enough so they have battery for RAM
> as the primary cache, and only when power loss happen, then use the
> battery to power the RAM so that we have enough time to dump the content
> of RAM into the backup flash?

Yes.

RAM/memory is fast than NAND. 
and NAND have the limit of total write bytes.

