Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2553550E37
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 03:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiFTBCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 21:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiFTBCI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 21:02:08 -0400
Received: from out20-87.mail.aliyun.com (out20-87.mail.aliyun.com [115.124.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98DEB7CB
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 18:01:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05615693|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0687693-0.00537248-0.925858;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.O8S2.qD_1655686895;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O8S2.qD_1655686895)
          by smtp.aliyun-inc.com;
          Mon, 20 Jun 2022 09:01:36 +0800
Date:   Mon, 20 Jun 2022 09:01:38 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Problems with BTRFS formatted disk
Cc:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <5d892115-c132-b2ea-7651-9cb94f76ee6b@gmx.com>
References: <003801d88418$15096b50$3f1c41f0$@perdrix.co.uk> <5d892115-c132-b2ea-7651-9cb94f76ee6b@gmx.com>
Message-Id: <20220620090137.1661.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2022/6/20 04:06, David C. Partridge wrote:
> > Yes write caching was enabled - I suspect that the way it worked was that on power fail the super-caps held the data until power was restored.
> >
> > Sadly it wasn't restored for a few weeks by which time the super-caps had lost their charge.
> 
> A little off-topic here, since I'm not familiar with how those hardware
> RAID controllers work.
> 
> Yep, those cards should have (super) caps to handle power loss, but for
>   SCSI SYNC CACHE commands, they should "the device server ensure that
> the specified logical blocks have their most recent data values recorded
> in non-volatile cache and/or on the medium."
> 
> Considering in a power loss event, the juice in those caps is definitely
> not enough to power those HDDs, it should at least have some
> non-volatile cache, like NAND, as backups.
> 
> But from sites I can found, it only states the card has 1024MiB cache
> memory.
> 
> Even with caps to keep the memory alive, it's still far from
> "non-volatile cache" required by SCSI spec.
> 
> Or is this a common practice in hardware RAID controller world to use
> volatile cache and break the SCSI spec requirement?


"non-volatile cache"  require a battery(inside or separated) and
Backup Flash(inside or separated).

For Microsemi Adaptec,
the battery and Backup Flash are in separated 'Flash Backup Module
AFM-700'.

For broadcom MegaRAID 9480/9580,
Backup Flash is inside the card,
but the battery is in separated CacheVault CVPM05.

For Dell, H730/H740 have battery/backup flash inside,
but H330 have no battery inside and we can not add battery to H330.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/20


