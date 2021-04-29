Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576B236F22F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 23:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhD2Vkr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 17:40:47 -0400
Received: from out20-14.mail.aliyun.com ([115.124.20.14]:53603 "EHLO
        out20-14.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbhD2Vkr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 17:40:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08964293|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.122438-0.0107588-0.866803;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.K6IIYBA_1619732398;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.K6IIYBA_1619732398)
          by smtp.aliyun-inc.com(10.147.42.241);
          Fri, 30 Apr 2021 05:39:58 +0800
Date:   Fri, 30 Apr 2021 05:40:02 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 0/7] Preemptive flushing improvements
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <a4d45780-84f1-2ff9-638e-64a0e97af5b0@toxicpanda.com>
References: <20210429094852.DAC3.409509F4@e16-tech.com> <a4d45780-84f1-2ff9-638e-64a0e97af5b0@toxicpanda.com>
Message-Id: <20210430054002.6E36.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 4/28/21 9:48 PM, Wang Yugui wrote:
> > Hi,
> >
> > xfstests generic/562 failed with this patch.
> >
> > This is the file 562.out.bad.
> > 
> It's not failing for me, what is your config like?  Both the local.config and the type/size of your devices.  Thanks,
> 

# cat xfstests/local.config

dev_base_disk=/dev/disk/by-id/nvme-Dell_Express_Flash_NVMe_SM1715_800GB_SFF__S29HNYAH500207

export TEST_DIR=/mnt/test

export TEST_DEV=${dev_base_disk}-part6
export TEST_DEV=$(realpath $TEST_DEV)


export SCRATCH_MNT=/mnt/scratch

export SCRATCH_DEV_POOL="${dev_base_disk}-part1 ${dev_base_disk}-part2
${dev_base_disk}-part3 ${dev_base_disk}-part4 ${dev_base_disk}-part5"
export SCRATCH_DEV_POOL=$(realpath $SCRATCH_DEV_POOL | xargs /bin/echo )

#LOGWRITES_DEV=


# parted /dev/disk/by-id/nvme-Dell_Express_Flash_NVMe_SM1715_800GB_SFF__S29HNYAH500207 unit s print
Model: NVMe Device (nvme)
Disk /dev/nvme0n1: 1562824368s
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start       End         Size       File system  Name     Flags
 1      2097152s    54525951s   52428800s  btrfs        primary
 2      54525952s   106954751s  52428800s               primary
 3      106954752s  159383551s  52428800s               primary
 4      159383552s  211812351s  52428800s               primary
 5      211812352s  264241151s  52428800s               primary
 6      264241152s  316669951s  52428800s  btrfs        primary

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/30


