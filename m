Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35068542E8F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 12:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiFHK6e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbiFHK6c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 06:58:32 -0400
Received: from out20-86.mail.aliyun.com (out20-86.mail.aliyun.com [115.124.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958711F5C5E
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 03:58:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04500999|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.100209-0.0105529-0.889238;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.O014u3P_1654685881;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O014u3P_1654685881)
          by smtp.aliyun-inc.com;
          Wed, 08 Jun 2022 18:58:01 +0800
Date:   Wed, 08 Jun 2022 18:58:06 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: What mechanisms protect against split brain?
Cc:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <a97ff3a3-7b14-e6a4-32e9-b9da8cec422e@gmx.com>
References: <20220608181502.4AB1.409509F4@e16-tech.com> <a97ff3a3-7b14-e6a4-32e9-b9da8cec422e@gmx.com>
Message-Id: <20220608185805.41ED.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2022/6/8 18:15, Wang Yugui wrote:
> > Hi, Forza, Qu Wenruo
> >
> > I write a script to test RAID1 split brain base on Qu's work of raid5(*1)
> > *1: https://lore.kernel.org/linux-btrfs/53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com/T/#u
> 
> No no no, that is not to address split brain, but mostly to drop cache
> for recovery path to maximize the chance of recovery.
> 
> It's not designed to solve split brain problem at all, it's just one
> case of such problem.
> 
> In fact, fully split brain (both have the same generation, but
> experienced their own degraded mount) case can not be solved by btrfs
> itself at all.
> 
> Btrfs can only solve partial split brain case (one device has higher
> generation, thus btrfs can still determine which copy is the correct one).
> 
> >
> > #!/bin/bash
> > set -uxe -o pipefail
> >
> > mnt=/mnt/test
> > dev1=/dev/vdb1
> > dev2=/dev/vdb2
> >
> >    dmesg -C
> >    mkdir -p $mnt
> >
> >    mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
> >    mount $dev1 $mnt
> >    xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
> >    sync
> >    umount $mnt
> >
> >    btrfs dev scan -u $dev2
> >    mount -o degraded $dev1 $mnt
> >    #xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
> >    mkdir -p $mnt/branch1; /bin/cp -R /usr/bin $mnt/branch1 #complex than xfs_io
> >    umount $mnt
> >
> >    btrfs dev scan
> >    btrfs dev scan -u $dev1
> >    mount -o degraded $dev2 $mnt
> 
> Your case is the full split brain case.
> 
> Not possible to solve.
> 
> In fact, if you don't do the degraded mount on dev2, btrfs is completely
> fine to resilve the fs without any problem.

step1: we mark btrfs/RAID1 with degraded write as not-clean-RAID1.
step2: in that state, we default try to read copy 0 of RAID1
	current pid based i/o patch select policy
           preferred_mirror = first + (current->pid % num_stripes);

this idea seem to work?

degraded RAID1 write is almost the same as full split brain?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/08


