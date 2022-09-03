Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6305ABE42
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 11:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiICJtS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiICJtR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 05:49:17 -0400
Received: from out20-217.mail.aliyun.com (out20-217.mail.aliyun.com [115.124.20.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B70C2753
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 02:49:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04656945|-1;BR=01201311R201S27rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.634586-0.0278387-0.337575;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.P6rheoG_1662198552;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.P6rheoG_1662198552)
          by smtp.aliyun-inc.com;
          Sat, 03 Sep 2022 17:49:12 +0800
Date:   Sat, 03 Sep 2022 17:49:14 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH PoC 1/9] btrfs: introduce BTRFS_IOC_SCRUB_FS family of ioctls
In-Reply-To: <410234ec-1c4a-f683-6913-1df9757685ff@gmx.com>
References: <20220903172506.447E.409509F4@e16-tech.com> <410234ec-1c4a-f683-6913-1df9757685ff@gmx.com>
Message-Id: <20220903174913.BAEA.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2022/9/3 17:25, Wang Yugui wrote:
> > Hi,
> >
> >> The new ioctls are to address the disadvantages of the existing
> >> btrfs_scrub_dev():
> >>
> >> a One thread per-device
> >>    This can cause multiple block groups to be marked read-only for scrub,
> >>    reducing available space temporarily.
> >>
> >>    This also causes higher CPU/IO usage.
> >>    For scrub, we should use the minimal amount of CPU and cause less
> >>    IO when possible.
> >>
> >> b Extra IO for RAID56
> >>    For data stripes, we will cause at least 2x IO if we run "btrfs scrub
> >>    start <mnt>".
> >>    1x from scrubbing the device of data stripe.
> >>    The other 1x from scrubbing the parity stripe.
> >>
> >>    This duplicated IO should definitely be avoided
> >>
> >> c Bad progress report for RAID56
> >>    We can not report any repaired P/Q bytes at all.
> >>
> >> The a and b will be addressed by the new one thread per-fs
> >> btrfs_scrub_fs ioctl.
> >
> > CRC check of scrub is CPU sensitive, so we still need multiple threads,
> > such as one thread per-fs but with additional threads pool based on
> > chunks?
> 
> This depends.
> 
> Scrub should be a background work, which can already be affected by
> scheduling, and I don't think users would bother 5% or 10% longer
> runtime for a several TB fs.
> 
> Furthermore if checksum in a single thread is going to be a bottleneck,
> then I'd say your storage is already so fast that scrub duration is not
> your primary concern any more.

scrub is sequence I/O, HDD is very fast too.
HDD*10  with HW RAID6 is very fast for scrub, about 2GB/s or more.

> Yes, it can be possible to offload the csum verification into multiple
> threads, like one thread per mirror/device, but I don't want to
> sacrifice readability for very minor performance improvement.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/03


